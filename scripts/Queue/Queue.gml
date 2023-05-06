//  @function				Queue()
///							
/// @description			Constructs a Queue Data Structure, which stores data in a linear,
///							first-in-first-out model that disallows order manipulation.
//							
//							Construction types:
//							- New constructor
//							- Wrapper: queue {int:queue}
//							- Empty: {undefined}
//							- Constructor copy: other {Queue}
function Queue() constructor
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				ID = undefined;
				
				if (argument_count > 0)
				{
					if (argument[0] != undefined)
					{
						if (instanceof(argument[0]) == "Queue")
						{
							//|Construction type: Constructor copy.
							self.copy(argument[0]);
						}
						else if ((is_real(argument[0])))
						{
							//|Construction type: Wrapper.
							ID = argument[0];
						}
					}
				}
				else
				{
					//|Construction type: New constructor.
					ID = ds_queue_create();
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (ds_exists(ID, ds_type_queue)));
			}
			
			/// @argument			deepScan? {bool}
			/// @returns			{undefined}
			/// @description		Remove the internal information from the memory.
			///						A deep scan can be performed before the removal, which will 
			///						iterate through this and all other Data Structures contained
			///						in it to destroy them as well.
			static destroy = function(_deepScan = false)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_queue)))
				{
					if (_deepScan)
					{
						repeat (ds_queue_size(ID))
						{
							var _value = ds_queue_dequeue(ID);
							
							if (is_struct(_value))
							{
								switch (instanceof(_value))
								{
									case "Buffer":
									case "Grid":
									case "List":
									case "Map":
									case "PriorityQueue":
									case "Queue":
									case "Stack":
										_value.destroy(true);
									break;
								}
							}
						}
					}
					
					ds_queue_destroy(ID);
					
					ID = undefined;
				}
				
				return undefined;
			}
			
			/// @description		Remove data from this Data Structure.
			static clear = function()
			{
				if ((!is_real(ID)) or (!ds_exists(ID, ds_type_queue)))
				{
					ID = ds_queue_create();
				}
				
				ds_queue_clear(ID);
				
				return self;
			}
			
			/// @argument			other {Queue}
			/// @description		Replace data of this Queue with data from another one.
			static copy = function(_other)
			{
				if ((instanceof(_other) == "Queue") and (is_real(_other.ID))
				and (ds_exists(_other.ID, ds_type_queue)))
				{
					if ((!is_real(ID)) or (!ds_exists(ID, ds_type_queue)))
					{
						ID = ds_queue_create();
					}
					
					ds_queue_copy(ID, _other.ID);
				}
				else
				{
					new ErrorReport().report([other, self, "copy()"],
											 ("Attempted to copy from an invalid Data Structure: " + 
											  "{" + string(_other) + "}"));
				}
				
				return self;
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			value... {any}
			/// @returns			{bool} | On error: {undefined}
			/// @description		Check if this Data Structure contains at least one of the
			///						specified values.
			static contains = function()
			{
				try
				{
					var _size = ds_queue_size(ID);
					
					if (_size > 0)
					{
						var _dataCopy = ds_queue_create();
						ds_queue_copy(_dataCopy, ID);
						
						repeat (_size)
						{
							var _value = ds_queue_dequeue(_dataCopy);
							
							var _i = 0;
							repeat (argument_count)
							{
								if (_value == argument[_i])
								{
									ds_queue_destroy(_dataCopy);
									return true;
								}
								
								++_i;
							}
						}
						
						ds_queue_destroy(_dataCopy);
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
			/// @returns			{int} | On error: {undefined}
			/// @description		Return the number of times the specified values occur in this
			///						Data Structure.
			static count = function()
			{
				try
				{
					var _result = 0;
					var _size = ds_queue_size(ID);
					
					if (_size > 0)
					{
						var _dataCopy = ds_queue_create();
						ds_queue_copy(_dataCopy, ID);
						
						repeat (_size)
						{
							var _value = ds_queue_dequeue(_dataCopy);
							var _i = 0;
							repeat (argument_count)
							{
								if (_value == argument[_i])
								{
									++_result;
								}
								
								++_i;
							}
						}
						
						ds_queue_destroy(_dataCopy);
					}
					
					return _result;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "count()"], _exception);
				}
				
				return 0;
			}
			
			/// @returns			{any|undefined}
			/// @description		Return the head value of this Queue, which is the one that
			///						would be removed first.
			///						Returns {undefined} if this Queue does not exists or is empty.
			static getFirst = function()
			{
				try
				{
					return ds_queue_head(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getFirst()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{any|undefined}
			/// @description		Return the tail value of this Queue, which is the one that
			///						would be removed last.
			///						Returns {undefined} if this Queue does not exists or is empty.
			static getLast = function()
			{
				try
				{
					return ds_queue_tail(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getLast()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{int}
			/// @description		Return the number of values in this Data Structure.
			static getSize = function()
			{
				try
				{
					return ds_queue_size(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getSize()"], _exception);
				}
				
				return 0;
			}
			
			/// @returns			{bool} | On error: {undefined}
			/// @description		Check if this Data Structure has no values in it.
			static isEmpty = function()
			{
				try
				{
					return ds_queue_empty(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "isEmpty()"], _exception);
				}
				
				return undefined;
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			function {function}
			/// @argument			argument? {any}
			/// @argument			readOnly? {bool}
			/// @returns			{any[]}
			/// @description		Execute a function once for each element in this Data Structure.
			///						It can be treated as read-only for this operation, in which case
			///						it will be performed solely on its copy and the original will not
			///						be modified in order to read the values.
			///						The following arguments will be provided to the function and can
			///						be accessed in it by using their name or the argument array:
			///						- argument[0]: _i {int}
			///						- argument[1]: _value {any}
			///						- argument[2]: _argument {any}
			static forEach = function(__function, _argument, _readOnly = false)
			{
				try
				{
					var _dataCopy = ds_queue_create();
					ds_queue_copy(_dataCopy, ID);
					var _size = ds_queue_size(ID);
					var _functionReturn = [];
					var _removableData = ((_readOnly) ? [_dataCopy] : [_dataCopy, ID]);
					var _removableData_count = array_length(_removableData);
					var _i = [0, 0];
					repeat (_size)
					{
						var _removedData = [];
						_i[1] = 0;
						repeat (_removableData_count)
						{
							_removedData[_i[1]] = ds_queue_dequeue(_removableData[_i[1]]);
							
							++_i[1];
						}
						
						var _value = _removedData[0];
						
						try
						{
							array_push(_functionReturn, __function(_i[0], _value, _argument));
						}
						catch (_exception)
						{
							new ErrorReport().report([other, self, "forEach()", "function()"],
													 _exception);
						}
						
						++_i[0];
					}
					
					ds_queue_destroy(_dataCopy);
					
					return _functionReturn;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "forEach()"], _exception);
				}
				
				return [];
			}
			
			/// @argument			value... {any}
			/// @description		Add one or more values at the tail of this Queue.
			static add = function()
			{
				try
				{
					var _i = 0;
					repeat (argument_count)
					{
						var _value = argument[_i];
						
						ds_queue_enqueue(ID, _value);
						
						++_i;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "add()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			count? {int}
			/// @returns			{any|any[]|undefined}
			/// @description		Remove any number of values from this Queue and return them. If
			///						more than one value were removed, they will be returned in an
			///						array.
			///						Returns {undefined} if this Queue does not exists or is empty.
			static remove = function(_count = 1)
			{
				try
				{
					var _size = ds_queue_size(ID);
					
					if ((!(_count >= 1)) or (_size < 1))
					{
						return undefined;
					}
					else
					{
						if (_count == 1)
						{
							return ds_queue_dequeue(ID);
						}
						else
						{
							_count = min(_count, _size);
							
							var _result = array_create(_count, undefined);
							var _i = 0;
							repeat (_count)
							{
								_result[_i] = ds_queue_dequeue(ID);
								
								++_i;
							}
							
							return _result;
						}
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "remove()"], _exception);
				}
				
				return undefined;
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
			///						Content will be represented by the data of this Data Structure.
			static toString = function(_multiline = false, _elementNumber = 10, _elementLength = 30,
									   _mark_separator = ", ", _mark_cut = "...",
									   _mark_elementStart = "", _mark_elementEnd = "",
									   _mark_sizeSeparator = " - ")
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_queue)))
				{
					//|General initialization.
					var _size = ds_queue_size(ID);
					
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
					
					//|Data Structure preparation.
					var _dataCopy = ds_queue_create();
					ds_queue_copy(_dataCopy, ID);
					
					//|Content loop.
					var _i = 0;
					repeat (min(_size, _elementNumber))
					{
						//|Get Data Structure Element.
						var _newElement = string(ds_queue_dequeue(_dataCopy));
						
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
								// ones that are not last. Add a cut mark after the last one if not
								// all elements are shown.
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
					
					//|Data structure clean-up.
					ds_queue_destroy(_dataCopy);
					
					return _string;
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			/// @returns			{any[]}
			/// @description		Create an array with all values of this Data Structure.
			static toArray = function()
			{
				try
				{
					var _size = ds_queue_size(ID);
					var _array = array_create(_size, undefined);
					
					if (_size > 0)
					{
						var _dataCopy = ds_queue_create();
						ds_queue_copy(_dataCopy, ID);
						var _i = 0;
						repeat (_size)
						{
							_array[_i] = ds_queue_dequeue(_dataCopy);
							
							++_i;
						}
						
						ds_queue_destroy(_dataCopy);
					}
					
					return _array;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "toArray()"], _exception);
				}
				
				return [];
			}
			
			/// @argument			array {any[]}
			/// @argument			startFromEnd? {bool}
			/// @description		Add values from the specified array to this Queue, starting from
			///						either its beginning or end.
			static fromArray = function(_array, _startFromEnd = false)
			{
				if ((!is_real(ID)) or (!ds_exists(ID, ds_type_queue)))
				{
					ID = ds_queue_create();
				}
				
				if (is_array(_array))
				{
					var _size = array_length(_array);
						
					var _i = ((_startFromEnd) ? (_size - 1) : 0);
					
					if (_startFromEnd)
					{
						var _i = (_size - 1);
						repeat (_size)
						{
							ds_queue_enqueue(ID, _array[_i]);
							--_i;
						}
					}
					else
					{
						var _i = 0;
						repeat (_size)
						{
							ds_queue_enqueue(ID, _array[_i]);
							++_i;
						}
					}
				}
				else
				{
					new ErrorReport().report([other, self, "fromArray()"],
											 ("Attempted to convert an invalid array to a Data" +
											  "Structure: " +
											  "{" + string(_array) + "}"));
				}
				
				return self;
			}
			
			/// @returns			{string}
			/// @description		Encode this Data Structure into a string, from which it can be
			///						recreated.
			static toEncodedString = function()
			{
				try
				{
					return ds_queue_write(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "toEncodedString()"], _exception);
				}
				
				return string(undefined);
			}
			
			/// @argument			string {string}
			/// @argument			legacy? {bool}
			/// @description		Decode a string to which a Data Structure of the same type was
			///						previously encoded into this one.
			///						Mark it as "legacy" if that string was created in the old version
			///						of GameMaker with different encoding.
			static fromEncodedString = function(_string, _legacy = false)
			{
				try
				{
					if ((!is_real(ID)) or (!ds_exists(ID, ds_type_queue)))
					{
						ID = ds_queue_create();
					}
					
					ds_queue_read(ID, _string, _legacy);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "fromEncodedString()"], _exception);
				}
				
				return self;
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
			var _value = variable_struct_get(prototype, _property[_i]);
			
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

