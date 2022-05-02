/// @function				PriorityQueue()
///							
/// @description			Constructs a Priority Queue Data Structure, which stores data in
///							a linear model that orders values based on their assigned priority.
///							
///							Construction types:
///							- New constructor
///							- Wrapper: {int:priorityQueue} priorityQueue
///							- Empty: {undefined}
///							- Constructor copy: {PriorityQueue} other
function PriorityQueue() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				ID = undefined;
				
				if (argument_count > 0)
				{
					if (argument[0] != undefined)
					{
						if (instanceof(argument[0]) == "PriorityQueue")
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
					ID = ds_priority_create();
				}
				
				return self;
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (ds_exists(ID, ds_type_priority)));
			}
			
			// @argument			{bool} deepScan?
			// @returns				{undefined}
			// @description			Remove the internal information from the memory.
			//						A deep scan can be performed before the removal, which will 
			//						iterate through this and all other Data Structures contained
			//						in it to destroy them as well.
			static destroy = function(_deepScan)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					if (_deepScan)
					{
						repeat (ds_priority_size(ID))
						{
							var _value = ds_priority_delete_max(ID);
							
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
					
					ds_priority_destroy(ID);
					
					ID = undefined;
				}
				
				return undefined;
			}
			
			// @description			Remove data from this Data Structure.
			static clear = function()
			{
				if ((!is_real(ID)) or (!ds_exists(ID, ds_type_priority)))
				{
					ID = ds_priority_create();
				}
				
				ds_priority_clear(ID);
				
				return self;
			}
			
			// @argument			{PriorityQueue} other
			// @description			Replace data of this Priority Queue with data from another one.
			static copy = function(_other)
			{
				if ((instanceof(_other) == "PriorityQueue") and (is_real(_other.ID)) 
				and (ds_exists(_other.ID, ds_type_priority)))
				{
					if ((!is_real(ID)) or (!ds_exists(ID, ds_type_priority)))
					{
						ID = ds_priority_create();
					}
					
					ds_priority_copy(ID, _other.ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "copy";
					var _errorText = ("Attempted to copy from an invalid Data Structure: " +
									  "{" + string(_other) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{any} value...
			// @returns				{bool} | On error: {undefined}
			// @description			Check if this Data Structure contains at least one of the
			//						specified values.
			static contains = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					var _size = ds_priority_size(ID);
					
					if (_size > 0)
					{
						var _dataCopy = ds_priority_create();
						ds_priority_copy(_dataCopy, ID);
						
						repeat (_size)
						{
							var _value = ds_priority_delete_max(_dataCopy);
							
							var _i = 0;
							repeat (argument_count)
							{
								if (_value == argument[_i])
								{
									ds_priority_destroy(_dataCopy);
									return true;
								}
								
								++_i;
							}
						}
						
						ds_priority_destroy(_dataCopy);
					}
					
					return false;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "contains";
					var _errorText = ("Attempted to read an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{any} value...
			// @returns				{int} | On error: {undefined}
			// @description			Return the number of times the specified values occur in this
			//						Data Structure.
			static count = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					var _result = 0;
					
					var _size = ds_priority_size(ID);
					
					if (_size > 0)
					{
						var _dataCopy = ds_priority_create();
						ds_priority_copy(_dataCopy, ID);
						
						repeat (_size)
						{
							var _value = ds_priority_delete_max(_dataCopy);
							
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
						
						ds_priority_destroy(_dataCopy);
					}
					
					return _result;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "count";
					var _errorText = ("Attempted to read an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{any|undefined}
			// @description			Return any value with the highest priority in this Priority Queue.
			//						Returns {undefined} if this Priority Queue does not exists or is
			//						empty.
			static getFirst = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					return ds_priority_find_max(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getFirst";
					var _errorText = ("Attempted to read an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{any|undefined}
			// @description			Return any value with the lowest priority in this Priority Queue.
			//						Returns {undefined} if this Priority Queue does not exists or is
			//						empty.
			static getLast = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					return ds_priority_find_min(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getLast";
					var _errorText = ("Attempted to read an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{any} value
			// @returns				{any|undefined}
			// @description			Return the priority of a specified value.
			//						Returns {undefined} if this Priority Queue or the value does not
			//						exist.
			static getPriority = function(_value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					return ds_priority_find_priority(ID, _value);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getPriority";
					var _errorText = ("Attempted to read an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{int}
			// @description			Return the number of values in this Data Structure.
			static getSize = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					return ds_priority_size(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getSize";
					var _errorText = ("Attempted to read an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return 0;
				}
			}
			
			// @returns				{bool} | On error: {undefined}
			// @description			Check if this Data Structure has no values in it.
			//						Returns {undefined} if this Data Structure does not exists.
			static isEmpty = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					return ds_priority_empty(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "isEmpty";
					var _errorText = ("Attempted to read an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{function} function
			// @argument			{any} argument?
			// @argument			{bool} readOnly?
			// @argument			{bool} orderAscending?
			// @returns				{any[]}
			// @description			Execute a function once for each element in this Data Structure.
			//						It can be treated as read-only for this operation, in which case
			//						it will be performed on its copy and the original will not be
			//						modified in order to read the values.
			//						The values will be iterated through starting from the ones with
			//						the highest priority, unless ascending order is specified.
			//						The following arguments will be provided to the function and can
			//						be accessed in it by using their name or the argument array:
			//						- argument[0]: {int} _i
			//						- argument[1]: {any} _value
			//						- argument[2]: {any} _argument
			static forEach = function(__function, _argument, _readOnly = false,
									  _orderAscending = false)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					var _size = ds_priority_size(ID);
					
					var _functionReturn = [];
					
					if (_size > 0)
					{
						var _priorityQueue = ID;
						
						if (_readOnly)
						{
							var _dataCopy = ds_priority_create();
							ds_priority_copy(_dataCopy, ID);
							
							_priorityQueue = _dataCopy;
						}
						
						var __read = ((_orderAscending) ? ds_priority_delete_min
														: ds_priority_delete_max);
						
						var _i = 0;
						repeat (_size)
						{
							var _value = __read(_priorityQueue);
							
							array_push(_functionReturn, __function(_i, _value, _argument));
							
							++_i;
						}
						
						if (_readOnly)
						{
							ds_priority_destroy(_dataCopy);
						}
						
						return _functionReturn;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "forEach";
					var _errorText = ("Attempted to iterate through an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{any} priority...
			// @argument			{any} value...
			// @description			Add one or more value and priority pairs to this Priority Queue.
			static add = function(_priority, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					var _i = 0;
					repeat (argument_count div 2)
					{
						_priority = argument[_i];
						_value = argument[(_i + 1)];
						
						ds_priority_add(ID, _value, _priority);
						
						_i += 2;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "add";
					var _errorText = ("Attempted to write to an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{any} priority...
			// @argument			{any} value...
			// @description			Set the priority of one or more existing values.
			static setPriority = function(_priority, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					var _i = 0;
					repeat (argument_count div 2)
					{
						_priority = argument[_i];
						_value = argument[(_i + 1)];
						
						ds_priority_change_priority(ID, _value, _priority);
						
						_i += 2;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "changePriority";
					var _errorText = ("Attempted to write to an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{any} value...
			// @description			Remove one or more specified values from this Priority Queue.
			static remove = function(_value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					var _i = 0;
					repeat (min(argument_count, ds_priority_size(ID)))
					{
						_value = argument[_i];
						
						ds_priority_delete_value(ID, _value);
						
						++_i;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "remove";
					var _errorText = ("Attempted to remove data from an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{int} count?
			// @returns				{any|any[]|undefined}
			// @description			Remove one or more values with the highest priority in this
			//						Priority Queue and return it.
			//						If multiple values were removed, they will be returned in an
			//						array. If no values were removed, {undefined} will be returned.
			static removeFirst = function(_count = 1)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					var _size = ds_priority_size(ID);
					
					_count = min(_count, _size);
					
					if ((!(_count >= 1)) or (_size < 1))
					{
						return undefined;
					}
					else
					{
						if (_count == 1)
						{
							return ds_priority_delete_max(ID);
						}
						else
						{
							var _result = array_create(_count, undefined);
							
							var _i = 0;
							repeat (_count)
							{
								_result[_i] = ds_priority_delete_max(ID);
								
								++_i;
							}
							
							return _result;
						}
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "removeFirst";
					var _errorText = ("Attempted to remove data from an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{int} count?
			// @returns				{any|any[]|undefined}
			// @description			Remove one or more values with the lowest priority in this
			//						Priority Queue and return it.
			//						If multiple values were removed, they will be returned in an
			//						array. If no values were removed, {undefined} will be returned.
			static removeLast = function(_count = 1)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					var _size = ds_priority_size(ID);
					
					_count = min(_count, _size);
					
					if ((!(_count >= 1)) or (_size < 1))
					{
						return undefined;
					}
					else
					{
						if (_count == 1)
						{
							return ds_priority_delete_min(ID);
						}
						else
						{
							var _result = array_create(_count, undefined);
							
							var _i = 0;
							repeat (_count)
							{
								_result[_i] = ds_priority_delete_min(ID);
								
								++_i;
							}
							
							return _result;
						}
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "removeLast";
					var _errorText = ("Attempted to remove data from an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
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
			// @argument			{string} mark_section?
			// @argument			{string} mark_sizeSeparator?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented by the data of this Data Structure.
			static toString = function(_multiline = false, _elementNumber = 10, _elementLength = 30,
									   _mark_separator = ", ", _mark_cut = "...",
									   _mark_elementStart = "", _mark_elementEnd = "",
									   _mark_section = ": ", _mark_sizeSeparator = " - ")
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					//|General initialization.
					var _size = ds_priority_size(ID);
					
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
					var _string_lengthLimit_cut_multiline = (_elementLength + _mark_cut_length);
					
					//|Data Structure preparation.
					var _dataCopy = ds_priority_create();
					ds_priority_copy(_dataCopy, ID);
					
					//|Content loop.
					var _i = 0;
					repeat (min(_size, _elementNumber))
					{
						//|Get Data Structure Element.
						var _priority = string(ds_priority_find_priority(_dataCopy, 
											   ds_priority_find_max(_dataCopy)));
						
						var _value = string(ds_priority_delete_max(_dataCopy));
						
						var _newElement = (_priority + _mark_section + _value);
						
						//|Remove line-breaks.
						_newElement = string_replace_all(_newElement, "\n", " ");
						_newElement = string_replace_all(_newElement, "\r", " ");
						
						//|Limit element length for multiline listing.
						if ((_multiline) and (_elementLength != all))
						{
							if ((string_length(_newElement)) > (_string_lengthLimit_cut_multiline))
							{
								_newElement = string_copy(_newElement, 1,
														  _string_lengthLimit_cut_multiline);
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
					ds_priority_destroy(_dataCopy);
					
					return _string;
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			// @returns				{any[]}
			// @description			Create an array with all priorities and values of this Priority
			//						Queue.
			//						The array will contain two arrays. The first one will contain all
			//						priorities and second one will contain all values.
			static toArray = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					var _size = ds_priority_size(ID);
					
					var _priority = array_create(_size, undefined);
					var _value = array_create(_size, undefined);
					
					if (_size > 0)
					{
						var _dataCopy = ds_priority_create();
						ds_priority_copy(_dataCopy, ID);
						
						var _i = 0;
						repeat (_size)
						{
							_priority[_i] = ds_priority_find_priority(_dataCopy,
												 ds_priority_find_max(_dataCopy));
							
							_value[_i] = ds_priority_delete_max(_dataCopy);
							
							++_i;
						}
						
						ds_priority_destroy(_dataCopy);
					}
					
					return [_priority, _value];
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "toArray";
					var _errorText = ("Attempted to convert an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return [[], []];
				}
			}
			
			// @argument			{any[]} array
			// @description			Add priority and value pairs from the specified array to this
			//						Priority Queue.
			//						The first dimension of the array must contain priorities and the
			//						second their values. Values that are not provided for a priority
			///						will be set to {undefined}.
			static fromArray = function(_array)
			{
				if ((!is_real(ID)) or (!ds_exists(ID, ds_type_priority)))
				{
					ID = ds_priority_create();
				}
				
				if ((is_array(_array)) and (array_length(_array) >= 2)
				and (is_array(_array[0])) and (is_array(_array[1])))
				{
					var _priorities = _array[0];
					var _values = _array[1];
						
					var _priorities_length = array_length(_priorities);
					var _values_length = array_length(_values);
						
					var _i = 0;
					repeat (_priorities_length)
					{
						var _value = ((_i < _values_length) ? _values[_i] : undefined);
							
						ds_priority_add(ID, _value, _priorities[_i]);
							
						++_i;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "fromArray";
					var _errorText = ("Attempted to convert an invalid or incorrectly formatted " +
									  "array to a Data Structure: " +
									  "{" + string(_array) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @returns				{string}
			// @description			Encode this Data Structure into a string, from which it can be
			//						recreated.
			static toEncodedString = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					return ds_priority_write(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "toEncodedString";
					var _errorText = ("Attempted to convert an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return string(undefined);
				}
			}
			
			// @argument			{string} string
			// @argument			{bool} legacy?
			// @description			Decode a string to which a Data Structure of the same type was
			//						previously encoded into this one.
			//						Use the "legacy" argument if that string was created
			//						in old versions of GameMaker with different encoding.
			static fromEncodedString = function(_string, _legacy = false)
			{
				if ((!is_real(ID)) or (!ds_exists(ID, ds_type_priority)))
				{
					ID = ds_priority_create();
				}
				
				ds_priority_read(ID, _string, _legacy);
				
				return self;
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

