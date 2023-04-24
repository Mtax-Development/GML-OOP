/// @function				ArrayParser()
/// @argument				{any:array} value?
///							
/// @description			Constructs a Handler for parsing arrays.
///							
///							Construction types:
///							- New constructor
///							- Empty array: {void|undefined}
///							- Constructor copy: {ArrayParser} other
function ArrayParser() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
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
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return (is_array(ID));
			}
			
			// @argument			{int} size?
			// @argument			{any} value?
			// @description			Replace the array with a newly created array of the specified size
			//						filled with the specified value.
			static create = function(_size = 0, _value)
			{
				ID = array_create(_size, _value);
				
				return self;
			}
			
			// @description			Remove all data from the array.
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
			
			// @argument			{any[]|ArrayParser} other
			// @argument			{int} position?
			// @argument			{int} other_position?
			// @argument			{int} count?
			// @argument			{function} condition_copy?
			// @argument			{function} condition_execute?
			// @description			Copy to the array the specfied number of elements or all of them
			//						from the specified position in other array to a specified position
			//						in the array or the beginning of either array. Values at already
			//						occupied positions will be overwritten. Condition functions can be
			//						specified. These function will be providen each candidate value as
			//						the only argument. That candidate value will be copied only if the
			//						specified functions return true. The execution stops if the second
			//						condition function is specified and returns false.
			static copy = function(_other, _position = 0, _other_position = 0, _count,
								   __condition_copy, __condition_execute)
			{
				if (instanceof(_other) == "ArrayParser") {_other = _other.ID;}
				
				if (is_array(_other))
				{
					if (!is_array(ID))
					{
						ID = array_create((_position - 1), undefined);
					}
					
					var _other_size = array_length(_other);
					var _remaining_position_count = (_other_size - _other_position);
					
					if ((__condition_copy != undefined) or (__condition_execute != undefined))
					{
						if (__condition_copy == undefined)
						{
							__condition_copy = function() {return true;}
						}
						
						if (__condition_execute == undefined)
						{
							__condition_execute = function() {return true;}
						}
						
						var _i = _other_position;
						repeat (min((_count ?? _remaining_position_count), _remaining_position_count))
						{
							var _value = array_get(_other, _i);
							
							if (!__condition_execute(_value))
							{
								break;
							}
							else if (__condition_copy(_value))
							{
								array_set(ID, _position, _value);
								
								++_position;
							}
							
							++_i;
						}
					}
					else
					{
						array_copy(ID, _position, _other, _other_position,
								   (_count ?? (_remaining_position_count)));
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "copy";
					var _errorText = ("Attempted to copy from an invalid array: " +
									  "{" + string(_other) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{any|any[]|constructor:Parser|constructor:DataStructure} data...
			// @description			Append to the array the specified values or all values of the
			//						specified structures.
			static merge = function()
			{
				if (is_array(ID))
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
									var _structure_data = _data.forEach(function()
									{
										return argument[(argument_count - 2)];
									},
									undefined, true);
									
									array_copy(ID, array_length(ID), _structure_data, 0,
											   array_length(_structure_data));
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
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "merge";
					var _errorText = ("Attempted to write to an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{any} value...
			// @returns				{bool}
			// @description			Check if the array contains at least one of the specified values.
			static contains = function()
			{
				if (is_array(ID))
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
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "contains";
					var _errorText = ("Attempted to read an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{any} value...
			// @returns				{bool}
			// @description			Check if the array contains all of the specified values.
			static containsAll = function()
			{
				if (is_array(ID))
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
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "containsAll";
					var _errorText = ("Attempted to read an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{function} condition
			// @argument			{any} argument?
			// @argument			{bool} matchAll?
			// @returns				{bool}
			// @description			Check if the array contains a value fulfilling the specified
			//						condition function by causing it to return true at least once or
			//						for all cases as it is executed once for each value of the array.
			//						The following arguments will be provided to the function and can
			//						be accessed in it by using their name or the argument array:
			//						- argument[0]: {int} _i
			//						- argument[1]: {any} _value
			//						- argument[2]: {any} _argument
			static containsCondition = function(__condition, _argument, _matchAll = false)
			{
				if (is_array(ID))
				{
					if (_matchAll)
					{
						var _i = 0;
						repeat (array_length(ID))
						{
							if (!__condition(_i, array_get(ID, _i), _argument))
							{
								return false;
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
							if (__condition(_i, array_get(ID, _i), _argument))
							{
								return true;
							}
							
							++_i;
						}
						
						return false;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "containsCondition";
					var _errorText = ("Attempted to read an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{any[]|ArrayParser} other
			// @returns				{bool} | On error: {undefined}
			// @description			Check if this and other array have the same content.
			static equals = function(_other)
			{
				if (instanceof(_other) == "ArrayParser") {_other = _other.ID};
				
				if ((is_array(ID)) and (is_array(_other)))
				{
					return array_equals(ID, _other);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "equals";
					var _errorText = ("Attempted to compare invalid arrays:\n" +
									  "Self: " + "{" + string(ID) + "}" + "\n" +
									  "Other: " + "{" + string(_other) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{int} position
			// @returns				{any} | On error: {undefined}
			// @description			Return the value at the specified position.
			static getValue = function(_position)
			{
				if (is_array(ID))
				{
					if (_position < array_length(ID))
					{
						return array_get(ID, _position);
					}
					else
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "getValue";
						var _errorText = ("Attempted to read an array value outside its bounds:\n" +
										  "Self: " + "{" + string(ID) + "}" + "\n" +
										  "Position: " + "{" + string(_position) + "}");
						_errorReport.reportConstructorMethod(self, _callstack, _methodName,
															 _errorText);
					
						return undefined;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getValue";
					var _errorText = ("Attempted to read an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{any|any[]|ArrayParser} value?...
			// @returns				{any[]}
			// @description			Return all values among the array and specified values and arrays
			//						in a new array that does not contain duplicate values.
			static getUniqueValues = function()
			{
				if (is_array(ID))
				{
					var _result = [];
					var _position = 0;
					var _size = array_length(ID);
					var _value_map = ds_map_create();
					
					var _i = 0;
					repeat (_size)
					{
						if (ds_map_add(_value_map, array_get(ID, _i), _position))
						{
							++_position;
						}
						
						++_i;
					}
					
					_position = clamp((_position - 1), 0, _size);
					
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
					
					var _key = ds_map_find_first(_value_map);
					repeat (ds_map_size(_value_map))
					{
						array_set(_result, ds_map_find_value(_value_map, _key), _key);
						
						_key = ds_map_find_next(_value_map, _key);
					}
					
					ds_map_destroy(_value_map);
					
					return _result;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getUniqueValues";
					var _errorText = ("Attempted to read an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return [];
				}
			}
			
			// @returns				{any|undefined}
			// @description			Return the first value in the array.
			//						Returns {undefined} if the array does not exists or is empty.
			static getFirst = function()
			{
				if (is_array(ID))
				{
					if (array_length(ID) > 0)
					{
						return array_get(ID, 0);
					}
					else
					{
						return undefined;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getFirst";
					var _errorText = ("Attempted to read an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{any|undefined}
			// @description			Return the last value in the array.
			//						Returns {undefined} if the array does not exists or is empty.
			static getLast = function()
			{
				if (is_array(ID))
				{
					var _size = array_length(ID);
					
					if (_size > 0)
					{
						return array_get(ID, (_size - 1));
					}
					else
					{
						return undefined;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getLast";
					var _errorText = ("Attempted to read an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{any} value
			// @returns				{int}
			// @description			Return the first found position of the specified value or -1 if
			//						the value does not exist.
			static getFirstPosition = function(_value)
			{
				if (is_array(ID))
				{
					var _size = array_length(ID);
					var _i = 0;
					repeat (_size)
					{
						if (array_get(ID, _i) == _value)
						{
							return _i;
						}
						
						++_i;
					}
					
					return -1;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getFirstPosition";
					var _errorText = ("Attempted to read an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return -1;
				}
			}
			
			// @argument			{any} value
			// @returns				{int}
			// @description			Return the last found position of the specified value or -1 if
			//						the value does not exist.
			static getLastPosition = function(_value)
			{
				if (is_array(ID))
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
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getLastPosition";
					var _errorText = ("Attempted to read an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return -1;
				}
			}
			
			// @argument			{any} value
			// @returns				{int[]}
			// @description			Return an array with all positions of the specified value.
			static getPositions = function(_value)
			{
				if (is_array(ID))
				{
					var _position = [];
					var _size = array_length(ID);
					var _i = 0;
					repeat (_size)
					{
						if (array_get(ID, _i) == _value)
						{
							array_push(_position, _value);
						}
						
						++_i;
					}
					
					return _position;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getPositions";
					var _errorText = ("Attempted to read an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return [];
				}
			}
			
			// @argument			{function} condition
			// @argument			{any} argument?
			// @returns				{int[]}
			// @description			Return an array with all positions of values fulfilling the
			//						specified condition function by causing it to return true.
			//						The following arguments will be provided to the function and can
			//						be accessed in it by using their name or the argument array:
			//						- argument[0]: {int} _i
			//						- argument[1]: {any} _value
			//						- argument[2]: {any} _argument
			static getPositionsCondition = function(__condition, _argument)
			{
				if (is_array(ID))
				{
					var _position = [];
					var _size = array_length(ID);
					var _i = 0;
					repeat (_size)
					{
						if (__condition(_i, array_get(ID, _i), _argument))
						{
							array_push(_position, _i);
						}
						
						++_i;
					}
					
					return _position;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getPositionsCondition";
					var _errorText = ("Attempted to read an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return [];
				}
			}
			
			// @returns				{int} | On error: {undefined}
			// @description			Return the number of elements in the array.
			static getSize = function()
			{
				if (is_array(ID))
				{
					return array_length(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getSize";
					var _errorText = ("Attempted to read a property of an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{int} position
			// @returns				{any[]}
			// @description			Return the values at the specified position in the nested arrays.
			static getColumn = function(_position)
			{
				if (is_array(ID))
				{
					var _column = [];
					var _i = 0;
					repeat (array_length(ID))
					{
						var _value = ID[_i];
						
						if ((is_array(_value))
						and (_position == clamp(_position, 0, (array_length(_value) - 1))))
						{
							array_push(_column, _value[_position]);
						}
						
						++_i;
					}
					
					return _column;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getColumn";
					var _errorText = ("Attempted to read a property of an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return [];
				}
			}
			
			// @returns				{bool} | On error: {undefined}
			// @description			Check if the array has no values in it.
			static isEmpty = function()
			{
				if (is_array(ID))
				{
					return (array_length(ID) <= 0);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "isEmpty";
					var _errorText = ("Attempted to read a property of an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{any:array|ArrayParser} value
			// @description			Set the value of this parser to the specified value by ensuring it
			//						is an array. If an {ArrayParser} is specified, its value will be
			//						set as a reference, without copying or changing it. Changes in
			//						either parser will be then reflected in the other one.
			static set = function(_value)
			{
				ID = ((is_array(_value)) ? _value
										 : ((instanceof(_value) == "ArrayParser")
											? _value.ID
											: [_value]));
				
				return self;
			}
			
			// @argument			{int} size
			// @returns				{any[]} | On error: {undefined}
			// @description			Set the number of elements in the array to the specified one.
			//						If the specified size is lower than current, values from the end
			//						will be removed. If the specified size is higher than current,
			//						empty positions will be set to 0.
			static setSize = function(_size)
			{
				if (is_array(ID))
				{
					array_resize(ID, _size);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setSize";
					var _errorText = ("Attempted to set a property an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			// @returns				{function} function
			// @argument			{any} argument?
			// @returns				{any[]}
			// @description			Execute a function once for each value in the array.
			//						The following arguments will be provided to the function and can
			//						be accessed in it by using their name or the argument array:
			//						- argument[0]: {int} _i
			//						- argument[1]: {any} _value
			//						- argument[2]: {any} _argument
			static forEach = function(__function, _argument)
			{
				if (is_array(ID))
				{
					var _size = array_length(ID);
					var _dataCopy = [];
					array_copy(_dataCopy, 0, ID, 0, _size);
					
					var _functionReturn = [];
					var _i = 0;
					repeat (_size)
					{
						var _value = array_get(_dataCopy, _i);
						
						array_push(_functionReturn, __function(_i, _value, _argument));
						
						++_i;
					}
					
					return _functionReturn;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "forEach";
					var _errorText = ("Attempted to iterate through an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return [];
				}
			}
			
			// @argument			{any} value...
			// @description			Add one or more values to the array.
			static add = function()
			{
				if (is_array(ID))
				{
					var _i = 0;
					repeat (argument_count)
					{
						array_push(ID, argument[_i]);
						
						++_i;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "add";
					var _errorText = ("Attempted to write to an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{any} value
			// @argument			{int} position
			// @description			Set a specified position of the array to specified value and any
			//						empty places before it to 0.
			static setValue = function(_value, _position)
			{
				if (is_array(ID))
				{
					array_set(ID, _position, _value);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setValue";
					var _errorText = ("Attempted to write to an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{int} position
			// @argument			{any} value...
			// @description			Add one or more values to the specified positions of the array and
			//						push values on that position and after it forward by the number of
			//						added values. Empty positions before the specified position will
			//						be set to 0.
			static insert = function(_position)
			{
				if (is_array(ID))
				{
					var _i = 0;
					repeat (argument_count - 1)
					{
						array_insert(ID, (_position + _i), argument[1 + _i]);
						
						++_i;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "insert";
					var _errorText = ("Attempted to write to an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{int} position?
			// @argument			{int} count?
			// @returns				{any|any[]|undefined}
			// @description			Return one or more values starting from the specified position and
			//						return them.
			//						If multiple values were removed, they will be returned in an
			//						array. If no values were removed, {undefined} will be returned.
			static removePosition = function(_position = 0, _count = 1)
			{
				if (is_array(ID))
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
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "removePosition";
					var _errorText = ("Attempted to remove data from an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{any|ArrayParser} value
			// @returns				{int}
			// @description			Remove all occurences of the specified value. If an ArrayParser is
			//						specified as the value, all occurences of its the values of its
			//						array will be removed. The number of removed values will be
			//						returned.
			static removeValue = function(_value)
			{
				if (is_array(ID))
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
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "removeValue";
					var _errorText = ("Attempted to remove data from an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return 0;
				}
			}
			
			// @argument			{bool|function} order
			// @description			Sort the values in the array in the specified order.
			//						The order can be specified as {bool} for ascending order or as a
			//						sorting {function}.
			//						If ordering is specified as {bool}, the sorting will work properly
			//						only when all array values are either numbers or strings.
			//						If ordering is specified as a {function}, it has to accept two
			//						arguments, which are to be used to comapre every element of the
			//						array with each other in pairs, then return a number, which is
			//						0 for equality and negative or positive value for such respective
			//						comparison result.
			static sort = function(_order)
			{
				if (is_array(ID))
				{
					array_sort(ID, _order);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "sort";
					var _errorText = ("Attempted to sort an invalid array: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @argument			{int|all} elementNumber?
			// @argument			{int|all} elementLength?
			// @argument			{string} mark_separator?
			// @argument			{string} mark_cut?
			// @argument			{string} mark_elementStart?
			// @argument			{string} mark_elementEnd?
			// @argument			{string} mark_sizeSeparator?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented by the data of the array.
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

