/// @function				List()
///
/// @description			Constructs a List Data Structure, which stores data in a linear
///							model, offering flexibility while doing so. It easily resized,
///							sorted and manipulated in other ways.
///
///							Construction methods:
///							- New constructor
///							- Wrapper: {int:list} list
///							- Constructor copy: {List} other
function List() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				ID = undefined;
				
				if (argument_count > 0)
				{
					if (instanceof(argument[0]) == "List")
					{
						//|Construction method: Constructor copy.
						self.copy(argument[0]);
					}
					else if ((is_real(argument[0])) and (ds_exists(argument[0], ds_type_list)))
					{
						//|Construction method: Wrapper.
						ID = argument[0];
					}
				}
				else
				{
					//|Construction method: New constructor.
					ID = ds_list_create();
					ds_list_clear(ID);
				}
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
			static destroy = function(_deepScan)
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
			}
			
		#endregion
		#region <Getters>
			
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
			
			// @returns				{any|undefined}
			// @description			Return the first value in this List.
			//						Returns {undefined} if this List does not exists or is empty.
			static getFirst = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					return ((ds_list_size(ID) > 0) ? ds_list_find_value(ID, 0) : undefined);
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
					var _size = ds_list_size(ID);
				
					return ((_size > 0) ? ds_list_find_value(ID, (_size - 1)) : undefined);
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
			// @returns				{int} | On error: -1
			// @description			Return the first found position of the specified value or -1 if
			//						not present.
			static getFirstIndex = function(_value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					return ds_list_find_index(ID, _value);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getFirstIndex";
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
			static getAllIndexes = function(_value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					var _indexes = [];
					
					var _i = 0;
					repeat (ds_list_size(ID))
					{
						if (ds_list_find_value(ID, _i) == _value)
						{
							_indexes[array_length(_indexes)] = _i;
						}
						
						++_i;
					}
					
					return _indexes;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getAllIndexes";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return [];
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
			
			// @returns				{bool} | On error: {undefined}
			// @description			Check if this Data Structure has any values in it.
			static isEmpty = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					return ds_list_empty(ID)
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
			// @description			Execute a function once for each element in this Data Structure.
			//						The following arguments will be provided to the function and can
			//						be accessed in it by using their name or an argument array:
			//						- argument[0]: {int} _i
			//						- argument[1]: {any} _value
			//						- argument[2]: {any} _argument
			static forEach = function(__function, _argument)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					var _size = ds_list_size(ID);
					
					if (_size > 0)
					{
						var _i = 0;
						repeat (_size)
						{
							var _value = ds_list_find_value(ID, _i);
							
							__function(_i, _value, _argument);
							
							++_i;
						}
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
				}
			}
			
			// @argument			{any} value
			// @argument			...
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
			}
			
			// @argument			{any} value
			// @argument			{int} position
			// @description			Set a specified position of this List to provided value and any
			//						empty places before it to 0.
			static set = function(_value, _position)
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
			}
			
			// @argument			{any} value
			// @argument			{int} position
			// @description			Set a specified position of the List to provided value,
			//						but only if it already exists.
			static replace = function(_value, _position)
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
			}
			
			// @argument			{int} position
			// @description			Remove a value at a specified position from the List and 
			//						push the position of all values after it back by one.
			static remove_position = function(_position)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					ds_list_delete(ID, _position);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "remove_position";
					var _errorText = ("Attempted to remove data from an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{any} value
			// @desccription		Remove the specified value from all positions in the List
			//						and push the position of all values after them back by one.
			static remove_value = function(_value)
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
					var _methodName = "remove_value";
					var _errorText = ("Attempted to remove data from an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{any} value
			// @argument			{int} position
			// @description			Add a value at a specified position to the List and push
			//						the position of all values after it forward by one.
			static insert = function(_value, _position)
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
			}
			
			// @argument			{bool} order_ascending
			// @description			Sort all values in the List in ascending or descending order.
			//						Numbers will be placed before the strings.
			static sort = function(order_ascending)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					ds_list_sort(ID, order_ascending);
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
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented by the data of this Data Structure.
			static toString = function(_multiline, _elementNumber, _elementLength, _mark_separator,
									   _mark_cut, _mark_elementStart, _mark_elementEnd)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_list)))
				{
					//|General initialization.
					var _size = ds_list_size(ID);
					
					switch (_elementNumber)
					{
						case undefined: _elementNumber = 10; break;
						case all: _elementNumber = _size; break;
					}
					
					if (_elementLength == undefined) {_elementLength = 30;}
					if (_mark_separator == undefined) {_mark_separator = ", ";}
					if (_mark_cut == undefined) {_mark_cut = "...";}
					if (_mark_elementStart == undefined) {_mark_elementStart = "";}
					if (_mark_elementEnd == undefined) {_mark_elementEnd = "";}
					
					var _mark_separator_length = string_length(_mark_separator);
					var _mark_cut_length = string_length(_mark_cut);
					var _mark_elementStart_length = string_length(_mark_elementStart);
					var _mark_elementEnd_length = string_length(_mark_elementEnd);
					var _mark_linebreak = (_multiline ? "\n" : "");
					
					var _string = ((_multiline) ? "" : (instanceof(self) + "("));
					
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
						_string += (_mark_elementStart + _newElement + _mark_elementEnd +
									_mark_linebreak);
						
						//|Cut strings and add cut or separation marks if appriopate.
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
									if (_string_length >= _string_lengthLimit_cut)
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
			}
			
			// @returns				{string}
			// @description			Return an encoded string of this Data Structure,
			//						which can later be decoded to recreate it.
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
			// @description			Decode the previously encoded string of the same Data 
			//						Structure and recreate it into this one.
			//						Use the "legacy" argument if that string was created
			//						in old versions of GameMaker with different encoding.
			static fromEncodedString = function(_string, _legacy)
			{
				if (_legacy == undefined) {_legacy = false;}
				
				if ((!is_real(ID)) or (!ds_exists(ID, ds_type_list)))
				{
					ID = ds_list_create();
				}
				
				ds_list_read(ID, _string, _legacy);
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
