//  @function				ArrayParser()
/// @argument				value? {any:array}
///							
/// @description			Constructs a Handler for parsing arrays.
//							
//							Construction types:
//							- New constructor
//							- Empty array: {void|undefined}
//							- Constructor copy: other {ArrayParser}
function ArrayParser() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty array.
				ID = [];
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (instanceof(argument[0]) == "ArrayParser")
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						array_copy(ID, 0, _other.ID, 0, array_length(_other.ID));
					}
					else
					{
						//|Construction type: New constructor.
						var _value = argument[0];
						
						ID = ((is_array(_value)) ? _value : [_value]);
					}
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return (is_array(ID));
			}
			
			/// @argument			value {any:array|ArrayParser}
			/// @description		Set the value operated by this parser to the specified value or
			///						the value of the specified parser by ensuring it is an array. An
			///						already existing array will be set as a reference, not as a copy,
			///						meaning changes in the array will be reflected in any variable or
			///						parser which has that array assigned.
			static setParser = function(_value)
			{
				try
				{
					var _reference = ((instanceof(_value) == "ArrayParser") ? _value.ID : _value);
					
					ID = ((is_array(_reference)) ? _reference : [_reference]);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setParser()"], _exception);
				}
				
				return self;
			}
			
			
			/// @argument			size? {int}
			/// @argument			value? {any}
			/// @description		Replace the array with a newly created array of the specified size
			///						filled with the specified value.
			static create = function(_size = 0, _value)
			{
				ID = array_create(_size, _value);
				
				return self;
			}
			
			/// @description		Remove all data from the array.
			static clear = function()
			{
				if (is_array(ID))
				{
					array_resize(ID, 0);
				}
				else
				{
					ID = [];
				}
				
				return self;
			}
			
			/// @argument			source {any[]|ArrayParser}
			/// @argument			target_position? {int}
			/// @argument			source_position? {int}
			/// @argument			count? {int}
			/// @argument			condition_copy? {function}
			/// @argument			condition_execute? {function}
			/// @description		Copy to the array the specfied number of elements or all of them
			///						from the specified position in the source array to the specified
			///						target position or the beginning of either array if unspecified.
			///						If the specified target position is negative, the values will be
			///						copied to that absolute position of the target backwards. If the
			///						specified number of values to copy from the source is negative,
			///						these values will be copied backwards from the end of source.
			///						Values at already occupied positions will be overwritten.
			///						Positions exceeding the target array size will have their value
			///						set to {undefined} if values were not copied into them.
			///						Condition functions can be specified and provided each candidate
			///						value as the only argument. That candidate value will be copied
			///						only if the specified functions return true. The execution stops
			///						if the second condition function is specified and returns false.
			static copy = function(_source, _target_position = 0, _source_position = 0, _count,
								   __condition_copy, __condition_execute)
			{
				try
				{
					if (instanceof(_source) == "ArrayParser")
					{
						_source = _source.ID;
					}
					
					var _source_size = array_length(_source);
					var _target_position_abs = abs(_target_position);
					
					if (!is_array(ID))
					{
						ID = array_create((abs(_target_position) + 1), undefined);
					}
					else
					{
						var _target_size = array_length(ID);
						
						if (_target_position_abs >= _target_size)
						{
							var _target_position_size_difference = ((_target_position_abs + 1) -
																	_target_size);
							
							array_copy(ID, _target_size,
									   array_create(_target_position_size_difference, undefined), 0,
									   _target_position_size_difference);
						}
					}
					
					if ((_target_position < 0) or (_source_position < 0)
					or (__condition_copy != undefined) or (__condition_execute != undefined))
					{
						var _target_position_boolsign = ((_target_position >= 0) ? 1 : -1);
						var _force_count_backward = ((_count == undefined)
													 and (_target_position_boolsign == -1));
						var _count_abs = ((is_real(_count)) ? abs(_count) : _count);
						var __passthrough = function() {return true;};
						
						var _remaining_position_count, _count_boolsign;
						
						if ((_count < 0) or (_force_count_backward))
						{
							_remaining_position_count = (_source_position + 1);
							_count_boolsign = -1;
						}
						else
						{
							_remaining_position_count = (_source_size - _source_position);
							_count_boolsign = 1;
						}
						
						__condition_copy ??= __passthrough;
						__condition_execute ??= __passthrough;
						
						var _target_position_current = _target_position_abs;
						var _source_position_current = _source_position;
						repeat (min((_count_abs ?? _remaining_position_count),
									_remaining_position_count))
						{
							try
							{
								var _value = array_get(_source, _source_position_current);
								
								if (!__condition_execute(_value))
								{
									break;
								}
								else if (__condition_copy(_value))
								{
									array_set(ID, _target_position_current, _value);
								
									_target_position_current += _target_position_boolsign;
								}
							}
							catch (_exception)
							{
								new ErrorReport().report([other, self, "copy()"], _exception);
							}
							
							_source_position_current += _count_boolsign;
						}
					}
					else
					{
						array_copy(ID, _target_position, _source, _source_position,
								   (_count ?? (_source_size - _source_position)));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "copy()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			data... {any|any[]|constructor:Parser|constructor:DataStructure}
			/// @description		Append to the array the specified values or all values of the
			///						specified structures.
			static merge = function()
			{
				try
				{
					var _i = 0;
					repeat (argument_count)
					{
						var _data = argument[_i];
						
						if (is_array(_data))
						{
							array_copy(ID, array_length(ID), _data, 0, array_length(_data));
						}
						else if (is_struct(_data))
						{
							switch (instanceof(_data))
							{
								case "ArrayParser":
									if (is_array(_data.ID))
									{
										array_copy(ID, array_length(ID), _data.ID, 0,
												   array_length(_data.ID));
									}
									else
									{
										array_push(ID, _data.ID);
									}
								break;
								
								case "StringParser":
									array_push(ID, _data.ID);
								break;
								
								case "Grid":
								case "Map":
								case "List":
								case "PriorityQueue":
								case "Queue":
								case "Stack":
									try
									{
										var _structure_data = _data.forEach(function()
										{
											return argument[(argument_count - 2)];
										},
										undefined, true);
										
										array_copy(ID, array_length(ID), _structure_data, 0,
												   array_length(_structure_data));
									}
									catch (_exception)
									{
										new ErrorReport().report([other, self, "merge()"],
																 _exception);
									}
								break;
								
								default:
									array_push(ID, _data);
								break;
							}
						}
						else
						{
							array_push(ID, _data);
						}
						
						++_i;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "merge()"], _exception);
				}
				
				return self;
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			value... {any}
			/// @returns			{bool}
			/// @description		Check if the array contains at least one of the specified values.
			static contains = function()
			{
				try
				{
					var _i = [0, 0];
					repeat (array_length(ID))
					{
						var _value = array_get(ID, _i[0]);
						_i[1] = 0;
						repeat (argument_count)
						{
							if (_value == argument[_i[1]])
							{
								return true;
							}
							
							++_i[1];
						}
						
						++_i[0];
					}
					
					return false;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "contains()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			value... {any}
			/// @returns			{bool}
			/// @description		Check if the array contains all of the specified values.
			static containsAll = function()
			{
				try
				{
					var _size = array_length(ID);
					var _i = [0, 0];
					repeat (argument_count)
					{
						var _argument_current = argument[_i[0]];
						var _value_exists = false;
						_i[1] = 0;
						repeat (_size)
						{
							if (array_get(ID, _i[1]) == _argument_current)
							{
								_value_exists = true;
								
								break;
							}
							
							++_i[1];
						}
						
						if (!_value_exists)
						{
							return false;
						}
						
						++_i[0];
					}
					
					return true;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "containsAll()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			condition {function}
			/// @argument			argument? {any}
			/// @argument			matchAll? {bool}
			/// @returns			{bool}
			/// @description		Check if the array contains a value fulfilling the specified
			///						condition function by causing it to return true at least once or
			///						for all cases as it is executed once for each value of the array.
			///						The following arguments will be provided to the function and can
			///						be accessed in it by using their name or the argument array:
			///						- argument[0]: _i {int}
			///						- argument[1]: _value {any}
			///						- argument[2]: _argument {any}
			static containsCondition = function(__condition, _argument, _matchAll = false)
			{
				try
				{
					if (_matchAll)
					{
						var _i = 0;
						repeat (array_length(ID))
						{
							try
							{
								if (!__condition(_i, array_get(ID, _i), _argument))
								{
									return false;
								}
							}
							catch (_exception)
							{
								new ErrorReport().report([other, self, "containsCondition()",
														  "function()"], _exception);
							}
							
							
							++_i;
						}
						
						return true;
					}
					else
					{
						var _i = 0;
						repeat (array_length(ID))
						{
							try
							{
								if (__condition(_i, array_get(ID, _i), _argument))
								{
									return true;
								}
							}
							catch (_exception)
							{
								new ErrorReport().report([other, self, "containsCondition()",
														  "function()"], _exception);
							}
							
							++_i;
						}
						
						return false;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "containsCondition()"], _exception);
				}
			}
			
			/// @argument			other {any[]|ArrayParser}
			/// @returns			{bool} | On error: {undefined}
			/// @description		Check if this and other array have the same content.
			static equals = function(_other)
			{
				try
				{
					if (instanceof(_other) == "ArrayParser") {_other = _other.ID};
					
					return array_equals(ID, _other);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "equals()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			position {int}
			/// @returns			{any} | On error: {undefined}
			/// @description		Return the value at the specified position.
			static getValue = function(_position)
			{
				try
				{
					if (_position < array_length(ID))
					{
						return array_get(ID, _position);
					}
					else
					{
						new ErrorReport().report([other, self, "getValue()"],
												 ("Attempted to read an array value outside its" +
												  "bounds:" + "\n" +
												  "Self: " + "{" + string(ID) + "}" + "\n" +
												  "Position: " + "{" + string(_position) + "}"));
						
						return undefined;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getValue()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			value?... {any|any[]|ArrayParser}
			/// @returns			{any[]}
			/// @description		Return all values among the array and specified values and arrays
			///						in a new array that does not contain duplicate values.
			static getUniqueValues = function()
			{
				var _value_map = ds_map_create();
				
				try
				{
					var _position = 0;
					var _size = array_length(ID);
					
					var _i = 0;
					repeat (_size)
					{
						if (ds_map_add(_value_map, array_get(ID, _i), _position))
						{
							++_position;
						}
						
						++_i;
					}
					
					var _i = [0, 0];
					repeat (argument_count)
					{
						var _argument = argument[_i[0]];
						var _value = ((instanceof(_argument) == "ArrayParser") ? _argument.ID
																			   : _argument);
						
						if (is_array(_value))
						{
							_i[1] = 0;
							repeat (array_length(_value))
							{
								if (ds_map_add(_value_map, _value[_i[1]], _position))
								{
									++_position;
								}
								
								++_i[1];
							}
						}
						else
						{
							if (ds_map_add(_value_map, _value, _position))
							{
								++_position;
							}
						}
						
						++_i[0];
					}
					
					var _result_count = ds_map_size(_value_map);
					var _result = array_create(_result_count, undefined);
					var _key = ds_map_find_first(_value_map);
					repeat (_result_count)
					{
						array_set(_result, ds_map_find_value(_value_map, _key), _key);
						
						_key = ds_map_find_next(_value_map, _key);
					}
					
					return _result;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getUniqueValues()"], _exception);
				}
				finally
				{
					ds_map_destroy(_value_map);
				}
				
				return [];
			}
			
			/// @argument			value?... {any|any[]|ArrayParser}
			/// @returns			{any[]}
			/// @description		Return all values among the array and specified values and arrays
			///						in a new array that does not contain duplicate values and only
			///						values present in all arguments.
			static getSharedValues = function()
			{
				var _value_map = ds_map_create();
				var _order_queue = ds_priority_create();
				
				try
				{
					var _position = 0;
					
					var _i = 0;
					repeat (array_length(ID))
					{
						if (ds_map_add(_value_map, array_get(ID, _i), [_position, 0]))
						{
							++_position;
						}
						
						++_i;
					}
					
					var _i = [0, 0];
					repeat (argument_count)
					{
						var _argument = argument[_i[0]];
						var _value = ((instanceof(_argument) == "ArrayParser") ? _argument.ID
																			   : _argument);
						
						if (is_array(_value))
						{
							_i[1] = 0;
							repeat (array_length(_value))
							{
								if (ds_map_exists(_value_map, _value[_i[1]]))
								{
									var _key_value = ds_map_find_value(_value_map, _value[_i[1]]);
									++_key_value[1];
								}
								
								++_i[1];
							}
						}
						else if (ds_map_exists(_value_map, _value))
						{
							var _key_value = ds_map_find_value(_value_map, _value);
							++_key_value[1];
						}
						
						++_i[0];
					}
					
					var _key = ds_map_find_first(_value_map);
					repeat (ds_map_size(_value_map))
					{
						var _key_value = ds_map_find_value(_value_map, _key);
						
						if (_key_value[1] == argument_count)
						{
							ds_priority_add(_order_queue, _key, _key_value[0]);
						}
						
						_key = ds_map_find_next(_value_map, _key);
					}
					
					var _result_count = ds_priority_size(_order_queue);
					var _result = array_create(_result_count, undefined);
					var _i = 0;
					repeat (_result_count)
					{
						array_set(_result, _i, ds_priority_delete_min(_order_queue));
						
						++_i;
					}
					
					return _result;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getSharedValues()"], _exception);
				}
				finally
				{
					ds_map_destroy(_value_map);
					ds_priority_destroy(_order_queue);
				}
				
				return [];
			}
			
			/// @returns			{any|undefined}
			/// @description		Return the first value in the array.
			///						Returns {undefined} if the array does not exists or is empty.
			static getFirst = function()
			{
				try
				{
					return ((array_length(ID) > 0) ? array_get(ID, 0) : undefined);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getFirst()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{any|undefined}
			/// @description		Return the last value in the array.
			///						Returns {undefined} if the array does not exists or is empty.
			static getLast = function()
			{
				try
				{
					var _size = array_length(ID);
					
					return ((_size > 0) ? array_get(ID, (_size - 1)) : undefined);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getLast()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			value {any}
			/// @returns			{int}
			/// @description		Return the first found position of the specified value or -1 if
			///						the value does not exist.
			static getFirstPosition = function(_value)
			{
				try
				{
					var _i = 0;
					repeat (array_length(ID))
					{
						if (array_get(ID, _i) == _value)
						{
							return _i;
						}
						
						++_i;
					}
					
					return -1;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getFirstPosition()"], _exception);
				}
				
				return -1;
			}
			
			/// @argument			value {any}
			/// @returns			{int}
			/// @description		Return the last found position of the specified value or -1 if the
			///						value does not exist.
			static getLastPosition = function(_value)
			{
				try
				{
					var _size = array_length(ID);
					var _i = (_size - 1);
					repeat (_size)
					{
						if (array_get(ID, _i) == _value)
						{
							return _i;
						}
							
						--_i;
					}
					
					return -1;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getLastPosition()"], _exception);
				}
				
				return -1;
			}
			
			/// @argument			value {any}
			/// @returns			{int[]}
			/// @description		Return an array with all positions of the specified value.
			static getPositions = function(_value)
			{
				try
				{
					var _position = [];
					var _i = 0;
					repeat (array_length(ID))
					{
						if (array_get(ID, _i) == _value)
						{
							array_push(_position, _value);
						}
						
						++_i;
					}
					
					return _position;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getPositions()"], _exception);
				}
				
				return [];
			}
			
			/// @argument			condition {function}
			/// @argument			argument? {any}
			/// @returns			{int[]}
			/// @description		Return an array with all positions of values fulfilling the
			///						specified condition function by causing it to return true.
			///						The following arguments will be provided to the function and can
			///						be accessed in it by using their name or the argument array:
			///						- argument[0]: _i {int}
			///						- argument[1]: _value {any}
			///						- argument[2]: _argument {any}
			static getPositionsCondition = function(__condition, _argument)
			{
				try
				{
					var _position = [];
					var _i = 0;
					repeat (array_length(ID))
					{
						try
						{
							if (__condition(_i, array_get(ID, _i), _argument))
							{
								array_push(_position, _i);
							}
						}
						catch (_exception)
						{
							new ErrorReport().report([other, self, "getPositionsCondition()"],
													 _exception);
						}
						
						++_i;
					}
					
					return _position;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getPositionsCondition()"], _exception);
				}
				
				return [];
			}
			
			/// @argument			reducer {function}
			/// @argument			initial_value? {any}
			/// @argument			argument? {any}
			/// @returns			{any} | On error: {undefined}
			/// @description		Execute a function to compare each value in the array with the
			///						previous return value and return the final of these values. The
			///						comparison starts from either the specified initial value or the
			///						first value of the array.
			///						The following arguments will be provided to the function and can
			///						be accessed in it by using their name or the argument array:
			///						- argument[0]: _value_previous {any}
			///						- argument[1]: _value_current {any}
			///						- argument[2]: _i {int}
			///						- argument[3]: _argument {any}
			static getReduction = function(__reducer, _initial_value, _argument)
			{
				try
				{
					var _size = array_length(ID);
					
					switch (_size)
					{
						case 0: return undefined; break;
						case 1: return array_get(ID, 0); break;
					}
					
					var _position_start, _value_previous, _iteration_count;
					
					if (_initial_value != undefined)
					{
						_position_start = 0;
						_value_previous = _initial_value;
						_iteration_count = _size;
					}
					else
					{
						_position_start = 1;
						_value_previous = array_get(ID, 0);
						_iteration_count = (_size - _position_start);
					}
					
					var _i = _position_start;
					repeat (_iteration_count)
					{
						_value_previous = __reducer(_value_previous, array_get(ID, _i), _i,
													_argument);
						
						++_i;
					}
					
					return _value_previous;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getReduction()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{int} | On error: {undefined}
			/// @description		Return the number of elements in the array.
			static getSize = function()
			{
				try
				{
					return array_length(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getSize()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			position {int}
			/// @returns			{any[]}
			/// @description		Return the values at the specified position in the nested arrays.
			static getColumn = function(_position)
			{
				try
				{
					var _column = [];
					var _i = 0;
					repeat (array_length(ID))
					{
						var _value = array_get(ID, _i);
						
						if ((is_array(_value))
						and (_position == clamp(_position, 0, (array_length(_value) - 1))))
						{
							array_push(_column, _value[_position]);
						}
						
						++_i;
					}
					
					return _column;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getColumn()"], _exception);
				}
				
				return [];
			}
			
			/// @returns			{bool} | On error: {undefined}
			/// @description		Check if the array has no values in it.
			static isEmpty = function()
			{
				try
				{
					return (array_length(ID) <= 0);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "isEmpty()"], _exception);
				}
				
				return undefined;
			}
			
		#endregion
		#region <Setters>
			
			/// @argument			size {int}
			/// @argument			value_default? {any}
			/// @description		Set the number of elements in the array to the specified one.
			///						If the specified size is lower than current, values from the end
			///						will be removed. If the specified size is higher than current,
			///						values in new positions will be set to the specified default value
			///						or {undefined} if unspecified.
			static setSize = function(_size, _value_default)
			{
				try
				{
					var _size_current = array_length(ID);
					
					if (_size > _size_current)
					{
						var _count = (_size - _size_current);
						
						array_copy(ID, _size_current,
								   array_create(_count, _value_default), 0, _count);
					}
					else
					{
						array_resize(ID, _size);
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setSize()"], _exception);
				}
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			/// @returns			function {function}
			/// @argument			argument? {any}
			/// @returns			{any[]}
			/// @description		Execute a function once for each value in the array.
			///						The following arguments will be provided to the function and can
			///						be accessed in it by using their name or the argument array:
			///						- argument[0]: _i {int}
			///						- argument[1]: _value {any}
			///						- argument[2]: _argument {any}
			static forEach = function(__function, _argument)
			{
				try
				{
					var _size = array_length(ID);
					var _dataCopy = [];
					array_copy(_dataCopy, 0, ID, 0, _size);
					var _functionReturn = [];
					var _i = 0;
					repeat (_size)
					{
						var _value = array_get(_dataCopy, _i);
						
						try
						{
							array_push(_functionReturn, __function(_i, _value, _argument));
						}
						catch (_exception)
						{
							new ErrorReport().report([other, self, "forEach()", "function()"],
													 _exception);
						}
						
						++_i;
					}
					
					return _functionReturn;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "forEach()"], _exception);
				}
				
				return [];
			}
			
			/// @argument			value... {any}
			/// @description		Add one or more values to the array.
			static add = function()
			{
				try
				{
					var _i = 0;
					repeat (argument_count)
					{
						array_push(ID, argument[_i]);
						
						++_i;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "add()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {any}
			/// @argument			position {int}
			/// @description		Set a specified position of the array to specified value and any
			///						empty places before it to 0.
			static set = function(_value, _position)
			{
				try
				{
					array_set(ID, _position, _value);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "set()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			position {int}
			/// @argument			value... {any}
			/// @description		Add one or more values to the specified positions of the array and
			///						push values on that position and after it forward by the number of
			///						added values. Empty positions before the specified position will
			///						be set to 0.
			static insert = function(_position)
			{
				try
				{
					var _i = 0;
					repeat (argument_count - 1)
					{
						array_insert(ID, (_position + _i), argument[1 + _i]);
						
						++_i;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "insert()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			position? {int}
			/// @argument			count? {int}
			/// @returns			{any|any[]|undefined}
			/// @description		Remove any number of values from the arraystarting from the
			///						specified position and return them. If multiple values were
			///						successfully removed, they will be returned in an array. If no
			///						values were removed, {undefined} will be returned.
			static removePosition = function(_position = 0, _count = 1)
			{
				try
				{
					var _size = array_length(ID);
					
					_count = min(_count, (_size - _position));
					
					if ((!(_count >= 1)) or (_size < 1))
					{
						return undefined;
					}
					else if (_count == 1)
					{
						var _result = array_get(ID, _position);
						
						array_delete(ID, _position, 1);
						
						return _result;
					}
					else
					{
						var _result = array_create(_count, undefined);
						var _i = 0;
						repeat (_count)
						{
							_result[_i] = array_get(ID, _position);
							
							array_delete(ID, _position, 1);
							
							++_i;
						}
						
						return _result;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "removePosition()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			value {any|ArrayParser}
			/// @returns			{int}
			/// @description		Remove all occurences of the specified value and return the number
			///						of removed values. If an ArrayParser is specified as the value,
			///						all occurences of its shared values will be removed.
			static removeValue = function(_value)
			{
				try
				{
					var _result = 0;
					
					if (instanceof(_value) == "ArrayParser")
					{
						var _i = [0, 0];
						repeat (array_length(ID))
						{
							var _iteratorModifier = 1;
							
							_i[1] = 0;
							repeat (array_length(_value.ID))
							{
								if (ID[_i[0]] == _value.ID[_i[1]])
								{
									array_delete(ID, _i[0], 1);
									
									++_result;
									_iteratorModifier = 0;
									
									break;
								}
								
								++_i[1];
							}
							
							_i[0] += _iteratorModifier;
						}
						
						return _result;
					}
					else
					{
						var _i = 0;
						repeat (array_length(ID))
						{
							if (ID[_i] == _value)
							{
								array_delete(ID, _i, 1);
								
								++_result;
							}
							else
							{
								++_i;
							}
						}
						
						return _result;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "removeValue()"], _exception);
				}
				
				return _result;
			}
			
			/// @argument			order {bool|function}
			/// @description		Sort the values in the array in the specified order.
			///						The order can be specified as {bool} for ascending order or as a
			///						sorting {function}.
			///						If ordering is specified as {bool}, the sorting will work properly
			///						only when all array values are either numbers or strings.
			///						If ordering is specified as a {function}, it has to accept two
			///						arguments, which are to be used to comapre every element of the
			///						array with each other in pairs, then return a number, which is 0
			///						for equality and negative or positive value for such respective
			///						comparison result.
			static sort = function(_order)
			{
				try
				{
					array_sort(ID, _order);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "sort()"], _exception);
				}
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @argument			elementNumber? {int|all}
			/// @argument			elementLength? {int|all}
			/// @argument			mark_separator? {string}
			/// @argument			mark_cut? {string}
			/// @argument			mark_elementStart? {string}
			/// @argument			mark_elementEnd? {string}
			/// @argument			mark_sizeSeparator? {string}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented by the data of the array.
			static toString = function(_multiline = false, _elementNumber = 10, _elementLength = 30,
									   _mark_separator = ", ", _mark_cut = "...",
									   _mark_elementStart = "", _mark_elementEnd = "",
									   _mark_sizeSeparator = " - ")
			{
				if (is_array(ID))
				{
					//|General initialization.
					var _size = array_length(ID);
					
					if (_elementNumber == all)
					{
						_elementNumber = _size;
					}
					
					var _mark_separator_length = string_length(_mark_separator);
					var _mark_cut_length = string_length(_mark_cut);
					var _mark_elementStart_length = string_length(_mark_elementStart);
					var _mark_elementEnd_length = string_length(_mark_elementEnd);
					var _string = "";
					var _string_size = (string(_size));
					
					if (!_multiline)
					{
						_string += (instanceof(self) + "(" + _string_size);
						
						if (_size > 0)
						{
							_string += _mark_sizeSeparator;
						}
					}
					
					var _string_lengthLimit = (string_length(_string) + _elementLength +
											   _mark_elementStart_length + _mark_elementEnd_length);
					var _string_lengthLimit_cut = (_string_lengthLimit + _mark_cut_length);
					
					//|Content loop.
					var _i = 0;
					repeat (min(_size, _elementNumber))
					{
						//|Get array element.
						var _newElement = string(array_get(ID, _i));
						
						//|Remove line-breaks.
						_newElement = string_replace_all(_newElement, "\n", " ");
						_newElement = string_replace_all(_newElement, "\r", " ");
						
						//|Limit element length for multiline listing.
						if ((_multiline) and (_elementLength != all))
						{
							if ((string_length(_newElement)) > _elementLength)
							{
								_newElement = string_copy(_newElement, 1, _elementLength);
								_newElement += _mark_cut;
							}
						}
						
						//|Add the element string with all its parts.
						_string += (_mark_elementStart + _newElement + _mark_elementEnd);
						
						//|Cut strings and add cut or separation marks if appropriate.
						if (!_multiline)
						{
							if (_elementLength != all)
							{
								var _string_length = string_length(_string);
								
								//|If the current element is not the last, add a separator or cut it
								// if it would be too long.
								if (_i < (_size - 1))
								{
									if ((_string_length + _mark_separator_length) >=
										 _string_lengthLimit)
									{
										_string = string_copy(_string, 1, _string_lengthLimit);
										_string += _mark_cut;
										break;
									}
									else
									{
										if (_i < (_elementNumber - 1))
										{
											_string += _mark_separator;
										}
										else
										{
											_string += _mark_cut;
											break;
										}
									}
								}
								else
								{
									//|If the current element is last, cut it if it would be too long,
									// but expand the length check by the length of the cut mark.
									if (_string_length > _string_lengthLimit_cut)
									{
										_string = string_copy(_string, 1, _string_lengthLimit);
										_string += _mark_cut;
										break;
									}
								}
							}
							else
							{
								//|If the elements are to be shown fully, add separators after the
								// ones that are not last. Add a cut mark after the last one if
								// not all elements are shown.
								if (_i < (_elementNumber - 1))
								{
									_string += _mark_separator;
								}
								else if (_elementNumber != _size)
								{
									_string += _mark_cut;
								}
							}
						}
						else
						{
							_string += "\n";
						}
						
						++_i;
					}
					
					//|String finish.
					if (_multiline)
					{
						//|Add a cut mark at the end of multiline listing if not all are shown.
						if (_i < _size)
						{
							_string += _mark_cut;
						}
					}
					else
					{
						_string += ")";
					}
					
					return _string;
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static prototype = {};
		var _property = variable_struct_get_names(prototype);
		var _i = 0;
		repeat (array_length(_property))
		{
			var _name = _property[_i];
			var _value = variable_struct_get(prototype, _name);
			
			variable_struct_set(self, _name, ((is_method(_value)) ? method(self, _value) : _value));
			
			++_i;
		}
		
		argument_original = array_create(argument_count, undefined);
		var _i = 0;
		repeat (argument_count)
		{
			argument_original[_i] = argument[_i];
			
			++_i;
		}
		
		script_execute_ext(method_get_index(self.construct), argument_original);
		
	#endregion
}
