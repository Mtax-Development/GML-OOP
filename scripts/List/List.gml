/// @function				List()
///							
/// @description			Constructs a List Data Structure, which stores data in a linear
///							model, offering flexibility while doing so. It easily resized,
///							sorted and manipulated in other ways.
///							
///							Construction types:
///							- New constructor
///							- Wrapper: {int:list} list
///							- Empty: {undefined}
///							- Constructor copy: {List} other
function List() constructor
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
						if (instanceof(argument[0]) == "List")
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
					ID = ds_list_create();
					ds_list_clear(ID);
				}
				
				return self;
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (ds_exists(ID, ds_type_list)));
			}
			
			// @argument			{bool} deepScan?
			// @returns				{undefined}
			// @description			Remove the internal information from the memory.
			//						A deep scan can be performed before the removal, which will 
			//						iterate through this and all other Data Structures contained
			//						in it to destroy them as well.
			static destroy = function(_deepScan = false)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					if (_deepScan)
					{
						var _i = 0;
						
						repeat (ds_list_size(ID))
						{
							var _value = ds_list_find_value(ID, _i);
							
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
							
							++_i;
						}
					}
					
					ds_list_destroy(ID);
					
					ID = undefined;
				}
				
				return undefined;
			}
			
			// @description			Remove data from this Data Structure.
			static clear = function()
			{
				if ((!is_real(ID)) or (!ds_exists(ID, ds_type_list)))
				{
					ID = ds_list_create();
				}
				
				ds_list_clear(ID);
				
				return self;
			}
			
			// @argument			{List} other
			// @description			Replace data of this List with data from another one.
			static copy = function(_other)
			{
				if ((instanceof(_other) == "List") and (is_real(_other.ID)) 
				and (ds_exists(_other.ID, ds_type_list)))
				{
					if ((!is_real(ID)) or (!ds_exists(ID, ds_type_list)))
					{
						ID = ds_list_create();
						ds_list_clear(ID);
					}
					
					ds_list_copy(ID, _other.ID);
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
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					var _size = ds_list_size(ID);
					
					var _i = [0, 0];
					repeat (_size)
					{
						_i[1] = 0;
						repeat (argument_count)
						{
							if (ds_list_find_value(ID, _i[0]) == argument[_i[1]])
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
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					var _result = 0;
					
					var _size = ds_list_size(ID);
					
					var _i = [0, 0];
					repeat (_size)
					{
						var _value = ds_list_find_value(ID, _i[0]);
						
						_i[1] = 0;
						repeat (argument_count)
						{
							if (_value == argument[_i[1]])
							{
								++_result;
							}
							
							++_i[1];
						}
						
						++_i[0];
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
			
			// @argument			{int} position
			// @returns				{any|undefined}
			// @description			Return the value at the specified position.
			//						Returns {undefined} if this List or the value does not exists.
			static getValue = function(_position)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					return ds_list_find_value(ID, _position);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getValue";
					var _errorText = ("Attempted to read an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{any|undefined}
			// @description			Return the first value in this List.
			//						Returns {undefined} if this List does not exists or is empty.
			static getFirst = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					return ds_list_find_value(ID, 0);
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
			// @description			Return the last value in this List.
			//						Returns {undefined} if this List does not exists or is empty.
			static getLast = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					return ds_list_find_value(ID, (ds_list_size(ID) - 1));
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
			// @returns				{int}
			// @description			Return the first found position of the specified value or -1 if
			//						the value does not exist.
			static getFirstPosition = function(_value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					return ds_list_find_index(ID, _value);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getFirstPosition";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return -1;
				}
			}
			
			// @argument			{any} value
			// @returns				{int[]}
			// @description			Return an array populated with all positions of the specified
			//						value.
			static getPositions = function(_value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					var _position = [];
					
					var _i = 0;
					repeat (ds_list_size(ID))
					{
						if (ds_list_find_value(ID, _i) == _value)
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
					var _methodName = "getPositions";
					var _errorText = ("Attempted to read an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return [];
				}
			}
			
			// @returns				{int}
			// @description			Return the number of values in this Data Structure.
			static getSize = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					return ds_list_size(ID);
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
			static isEmpty = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					return ds_list_empty(ID);
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
			// @returns				{any[]}
			// @description			Execute a function once for each element in this Data Structure.
			//						The following arguments will be provided to the function and can
			//						be accessed in it by using their name or the argument array:
			//						- argument[0]: {int} _i
			//						- argument[1]: {any} _value
			//						- argument[2]: {any} _argument
			static forEach = function(__function, _argument)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					var _size = ds_list_size(ID);
					
					var _functionReturn = [];
					
					var _i = 0;
					repeat (_size)
					{
						var _value = ds_list_find_value(ID, _i);
							
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
					var _errorText = ("Attempted to iterate through an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{any} value...
			// @description			Add one or more values to this List.
			static add = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					var _i = 0;
					repeat (argument_count)
					{
						var _value = argument[_i];
						
						ds_list_add(ID, _value);
						
						++_i;
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
			
			// @argument			{int} position
			// @argument			{any} value
			// @description			Set a specified position of this List to the specified value and
			//						any empty places before it to 0.
			static set = function(_position, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					ds_list_set(ID, _position, _value);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "set";
					var _errorText = ("Attempted to write to an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{int} position
			// @argument			{any} value
			// @description			Set a specified position of the List to the specified value, but
			//						only if it already exists.
			static replace = function(_position, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					ds_list_replace(ID, _position, _value);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "replace";
					var _errorText = ("Attempted to write to an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{int} position
			// @description			Remove a value at a specified position from the List and push the
			//						positions of all values after it back by one.
			static removePosition = function(_position)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					ds_list_delete(ID, _position);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "removePosition";
					var _errorText = ("Attempted to remove data from an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{any} value
			// @desccription		Remove the specified value from all positions in the List and push
			//						the position of all values after them back by one.
			static removeValue = function(_value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					var _i = 0;
					repeat (ds_list_size(ID))
					{
						if (ds_list_find_value(ID, _i) == _value)
						{
							ds_list_delete(ID, _i);
						}
						else
						{
							++_i;
						}
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "removeValue";
					var _errorText = ("Attempted to remove data from an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{int} position
			// @argument			{any} value
			// @description			Add a value at a specified position to the List and push
			//						the position of all values after it forward by one.
			static insert = function(_position, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					ds_list_insert(ID, _position, _value);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "insert";
					var _errorText = ("Attempted to write to an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{bool} orderAscending
			// @description			Sort all values in the List in ascending or descending order.
			//						Numbers will be placed before the strings.
			static sort = function(_orderAscending)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					ds_list_sort(ID, _orderAscending);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "sort";
					var _errorText = ("Attempted to sort an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @description			Randomize the position of all values in the List.
			static shuffle = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					ds_list_shuffle(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "shuffle";
					var _errorText = ("Attempted to shuffle an invalid Data Structure: " +
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
			//						Content will be represented by the data of this Data Structure.
			static toString = function(_multiline = false, _elementNumber = 10, _elementLength = 30,
									   _mark_separator = ", ", _mark_cut = "...",
									   _mark_elementStart = "", _mark_elementEnd = "",
									   _mark_sizeSeparator = " - ")
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					//|General initialization.
					var _size = ds_list_size(ID);
					
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
						//|Get Data Structure Element.
						var _newElement = string(ds_list_find_value(ID, _i));
						
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
					
					return _string;
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			// @returns				{any[]}
			// @description			Create an array with all values of this List.
			static toArray = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					var _size = ds_list_size(ID);
					
					var _array = array_create(_size, undefined);
					
					var _i = 0;
					repeat (_size)
					{
						_array[_i] = ds_list_find_value(ID, _i);
						
						++_i;
					}
					
					return _array;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "toArray";
					var _errorText = ("Attempted to convert an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return [];
				}
			}
			
			// @argument			{any[]} array
			// @description			Add all values from the specified array dimension to this List.
			static fromArray = function(_array)
			{
				if (is_array(_array))
				{
					if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
					{
						var _i = 0;
						repeat (array_length(_array))
						{
							ds_list_add(ID, _array[_i]);
							
							++_i;
						}
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "fromArray";
					var _errorText = ("Attempted to convert an invalid array: " +
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
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					return ds_list_write(ID);
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
			//						Use the "legacy" argument if that string was created in old
			//						versions of GameMaker with different encoding.
			static fromEncodedString = function(_string, _legacy = false)
			{
				if ((!is_real(ID)) or (!ds_exists(ID, ds_type_list)))
				{
					ID = ds_list_create();
				}
				
				ds_list_read(ID, _string, _legacy);
				
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

