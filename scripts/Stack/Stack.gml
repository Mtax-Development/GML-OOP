/// @function				Stack()
///
/// @description			Constructs a Stack Data Structure, which stores data in a linear,
///							last-in-first-out (LIFO) model that disallows order manipulation.
///
///							Construction methods:
///							- New constructor
///							- Constructor copy: {Stack} other
function Stack() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				ID = undefined;
				
				if (argument_count > 0)
				{
					if (instanceof(argument[0]) == "Stack")
					{
						//|Construction method: Constructor copy.
						self.copy(argument[0]);
					}
					else if ((is_real(argument[0])) and (ds_exists(argument[0], ds_type_stack)))
					{
						//|Construction method: Wrapper.
						ID = argument[0];
					}
				}
				else
				{
					//|Construction method: New constructor.
					ID = ds_stack_create();
				}
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (ds_exists(ID, ds_type_stack)));
			}
			
			// @argument			{bool} deepScan?
			// @returns				{undefined}
			// @description			Remove the internal information from the memory.
			//						A deep scan can be performed before the removal, which will 
			//						iterate through this and all other Data Structures contained
			//						in it to destroy them as well.
			static destroy = function(_deepScan)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_stack)))
				{
					if (_deepScan)
					{
						repeat (ds_stack_size(ID))
						{
							var _value = ds_stack_pop(ID);
							
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
					
					ds_stack_destroy(ID);
					
					ID = undefined;
				}
		
				return undefined;
			}
			
			// @description			Remove data from this Data Structure.
			static clear = function()
			{
				if ((!is_real(ID)) or (!ds_exists(ID, ds_type_stack)))
				{
					ID = ds_stack_create();
				}
				
				ds_stack_clear(ID);
			}
			
			// @argument			{Stack} other
			// @description			Replace data of this Stack with data from another one.
			static copy = function(_other)
			{
				if ((instanceof(_other) == "Stack") and (is_real(_other.ID)) 
				and (ds_exists(_other.ID, ds_type_stack)))
				{
					if ((!is_real(ID)) or (!ds_exists(ID, ds_type_stack)))
					{
						ID = ds_stack_create();
					}
		
					ds_stack_copy(ID, _other.ID);
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
			
			// @argument			{any} value...
			// @returns				{bool}
			// @description			Check if this Data Structure contains at least one of the
			//						specified values.
			static contains = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_stack)))
				{
					var _size = ds_stack_size(ID);
					
					if (_size > 0)
					{
						var _dataCopy = ds_stack_create();
						ds_stack_copy(_dataCopy, ID);
						
						repeat (_size)
						{
							var _value = ds_stack_pop(ID);
							
							var _i = 0;
							repeat (argument_count)
							{
								if (_value == argument[_i])
								{
									ds_stack_destroy(_dataCopy);
									return true;
								}
								
								++_i;
							}
						}
						
						ds_stack_destroy(_dataCopy);
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
			
			// @returns				{int}
			// @description			Return the number of values in this Data Structure.
			static getSize = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_stack)))
				{
					return ds_stack_size(ID);
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
			// @description			Return the top value of this Stack, which is the one that would
			//						be removed first.
			//						Returns {undefined} if this Stack does not exists or is empty.
			static getFirst = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_stack)))
				{
					return ds_stack_top(ID);
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
			// @description			Return the bottom value of this Stack, which is the one that would
			//						be removed last.
			//						Returns {undefined} if this Stack does not exists or is empty.
			static getLast = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_stack)))
				{
					var _size = ds_stack_size(ID);
					
					if (_size <= 0)
					{
						return undefined;
					}
					else
					{
						var _dataCopy = ds_stack_create();
						ds_stack_copy(_dataCopy, ID);
						
						repeat (_size - 1)
						{
							ds_stack_pop(_dataCopy);
						}
						
						var _value = ds_stack_pop(_dataCopy);
						
						ds_stack_destroy(_dataCopy);
						
						return _value;
					}
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
			
			// @returns				{bool} | On error: {undefined}
			// @description			Check if this Data Structure has any values in it.
			static isEmpty = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_stack)))
				{
					return ds_stack_empty(ID);
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
			// @description			Execute a function once for each element in this Data Structure.
			//						It can be treated as read-only for this operation, in which case
			//						it will be performed on its copy and the original will not be
			//						modified in order to read the values.
			//						The following arguments will be provided to the function and can
			//						be accessed in it by using their name or an argument array:
			//						- argument[0]: {int} _i
			//						- argument[1]: {any} _value
			//						- argument[2]: {any} _argument
			static forEach = function(__function, _argument, _readOnly)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_stack)))
				{
					var _size = ds_stack_size(ID);
					
					if (_size > 0)
					{
						var _stack = ID;
						
						if (_readOnly)
						{
							var _dataCopy = ds_stack_create();
							ds_stack_copy(_dataCopy, ID);
							
							_stack = _dataCopy;
						}
						
						var _i = 0;
						repeat (_size)
						{
							var _value = ds_stack_pop(_stack);
							
							__function(_i, _value, _argument);
							
							++_i;
						}
						
						if (_readOnly)
						{
							ds_stack_destroy(_dataCopy);
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
			// @description			Add one or more values at the top of this Stack.
			static add = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_stack)))
				{
					var _i = 0;
					repeat (argument_count)
					{
						var _value = argument[_i];
						
						ds_stack_push(ID, _value);
						
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
					
					return false;
				}
			}
			
			// @argument			{int} count?
			// @returns				{any|any[]|undefined}
			// @description			Remove any number of values from this Stack and return them. If
			//						more than one value were removed, they will be returned in an
			//						array.
			//						Returns {undefined} if this Stack does not exists or is empty.
			static remove = function(_count)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_stack)))
				{
					if (_count == undefined) {_count = 1;}
					
					var _size = ds_stack_size(ID);
					
					if ((!(_count >= 1)) or (_size < 1))
					{
						return undefined;
					}
					else
					{
						if (_count == 1)
						{
							return ds_stack_pop(ID);
						}
						else
						{
							_count = min(_count, _size);
							
							var _result = array_create(_count, undefined);
						
							var _i = 0;
							repeat (_count)
							{
								_result[_i] = ds_stack_pop(ID);
								
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
					var _methodName = "remove";
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
			// @returns				{string}
			// @description			Create a string representing the constructor.
			//						Overrides the string() conversion.
			//						Content will be represented by the data of this Data Structure.
			static toString = function(_multiline, _elementNumber, _elementLength, _mark_separator,
									   _mark_cut, _mark_elementStart, _mark_elementEnd)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_stack)))
				{
					//|General initialization.
					var _size = ds_stack_size(ID);
					
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
					
					//|Data Structure preparation.
					var _dataCopy = ds_stack_create();
					ds_stack_copy(_dataCopy, ID);
					
					//|Content loop.
					var _i = 0;
					repeat (min(_size, _elementNumber))
					{
						//|Get Data Structure Element.
						var _newElement = string(ds_stack_pop(_dataCopy));
						
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
					
					//|Data structure clean-up.
					ds_stack_destroy(_dataCopy);
					
					return _string;
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			// @returns				{any[]}
			// @description			Create an array with all values of this Data Structure.
			static toArray = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_stack)))
				{
					var _size = ds_stack_size(ID);
					var _array = array_create(_size, undefined);
					
					if (_size > 0)
					{
						var _dataCopy = ds_stack_create();
						ds_stack_copy(_dataCopy, ID);
						
						var _i = 0;
						repeat (_size)
						{
							_array[_i] = ds_stack_pop(_dataCopy);
							
							++_i;
						}
						
						ds_stack_destroy(_dataCopy);
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
			// @argument			{bool} startFromEnd?
			// @description			Add values from the specified array to this Stack, starting
			//						from either the start of the array or its end.
			static fromArray = function(_array, _startFromEnd)
			{
				if ((!is_real(ID)) and (!ds_exists(ID, ds_type_stack)))
				{
					ID = ds_stack_create();
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
							ds_stack_push(ID, _array[_i]);
							--_i;
						}
					}
					else
					{
						var _i = 0;
						repeat (_size)
						{
							ds_stack_push(ID, _array[_i]);
							++_i;
						}
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "fromArray";
					var _errorText = ("Attempted to convert an invalid array to a Data Structure: " +
									  "{" + string(_array) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @returns				{string}
			// @description			Return an encoded string of this Data Structure,
			//						which can later be decoded to recreate it.
			static toEncodedString = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_stack)))
				{
					return ds_stack_write(ID);
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
				
				if ((!is_real(ID)) or (!ds_exists(ID, ds_type_stack)))
				{
					ID = ds_stack_create();
				}
				
				ds_stack_read(ID, _string, _legacy);
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
