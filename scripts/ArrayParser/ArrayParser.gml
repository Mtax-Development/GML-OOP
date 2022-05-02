/// @function				ArrayParser()
/// @argument				{any[]} array?
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
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (instanceof(argument[0]) == "ArrayParser")
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						ID = [];
						
						array_copy(ID, 0, _other.ID, 0, array_length(_other.ID));
					}
					else
					{
						//|Construction type: New constructor.
						ID = argument[0];
					}
				}
				else
				{
					//|Construction type: Empty array.
					ID = [];
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
			// @description			Copy specfied number of elements from other array to this one from
			//						specified position in other one to specified position in this one.
			//						If the specified positions are already occupied, their values will
			//						be overwritten.
			static copy = function(_other, _position = 0, _other_position = 0, _count)
			{
				if (instanceof(_other) == "ArrayParser") {_other = _other.ID;}
				
				if (is_array(_other))
				{
					if (!is_array(ID))
					{
						ID = array_create((_position - 1), undefined);
					}
					
					array_copy(ID, _position, _other, _other_position,
							   (_count ?? (array_length(_other) - _other_position)));
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
			
			// @returns				{any|undefined}
			// @description			Return the first value in this array.
			//						Returns {undefined} if this array does not exists or is empty.
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
			// @description			Return the last value in this array.
			//						Returns {undefined} if this array does not exists or is empty.
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
			
			// @returns				{bool} | On error: {undefined}
			// @description			Check if this array has no values in it.
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
			
			// @argument			{int} size
			// @returns				{any[]} | On error: {undefined}
			// @description			Set the number of elements in this array to the specified one.
			//						If the specified size is lower than current, values from the end
			//						will be removed.
			//						If the specified size is higher than current, empty positions will
			//						be set to 0.
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
					
					var _functionReturn = [];
					
					var _i = 0;
					repeat (_size)
					{
						var _value = array_get(ID, _i);
						
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
					
					return undefined;
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
			static set = function(_value, _position)
			{
				if (is_array(ID))
				{
					array_set(ID, _position, _value);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "set";
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
			
			// @argument			{any|ArrayParser}
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

