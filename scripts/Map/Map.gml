/// @function				Map()
///
/// @description			Constructs a Map Data Structure, which stores data by creating key 
///							and value pairs. The data inside of it is not sorted and values
///							are accessed either by providing a specific existing key or by
///							iterating through the entire Data Structure.
///
///							Construction methods:
///							- New constructor
///							- Wrapper: {int:map} map
///							- Constructor copy: {Map} other
function Map() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				ID = undefined;
				
				if (argument_count > 0)
				{
					if (instanceof(argument[0]) == "Map")
					{
						//|Construction method: Constructor copy.
						self.copy(argument[0]);
					}
					else if ((is_real(argument[0])) and (ds_exists(argument[0], ds_type_map)))
					{
						//|Construction method: Wrapper.
						ID = argument[0];
					}
				}
				else
				{
					//|Construction method: New constructor.
					ID = ds_map_create();
				}
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (ds_exists(ID, ds_type_map)));
			}
			
			// @argument			{bool} deepScan?
			// @returns				{undefined}
			// @description			Remove the internal information from the memory.
			//						A deep scan can be performed before the removal, which will 
			//						iterate through this and all other Data Structures contained
			//						in it to destroy them as well.
			static destroy = function(_deepScan)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					if (_deepScan)
					{
						var _size = ds_map_size(ID);
						
						if (_size > 0)
						{
							var _key = ds_map_find_first(ID);
							
							repeat (_size)
							{
								var _value = ds_map_find_value(ID, _key);
								_key = ds_map_find_next(ID, _key);
							
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
							}
						}
					}
					
					ds_map_destroy(ID);
					
					ID = undefined;
				}
				
				return undefined;
			}
			
			// @description			Remove data from this Data Structure.
			static clear = function()
			{
				if ((!is_real(ID)) or (!ds_exists(ID, ds_type_map)))
				{
					ID = ds_map_create();
				}
				
				ds_map_clear(ID);
			}
			
			// @argument			{Map} other
			// @description			Replace data of this Map with data from another one.
			static copy = function(_other)
			{
				if ((instanceof(_other) == "Map") and (is_real(_other.ID)) 
				and (ds_exists(_other.ID, ds_type_map)))
				{
					if ((!is_real(ID)) or (!ds_exists(ID, ds_type_map)))
					{
						ID = ds_map_create();
					}
					
					ds_map_copy(ID, _other.ID);
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
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					return ds_map_size(ID);
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
			// @description			Return the first key in this Map for use in iterating through it.
			//						Returns {undefined} if this Map does not exists or is empty.
			static getFirst = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					return ds_map_find_first(ID);
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
			// @description			Return the last key in this Map for use in iterating through it.
			//						Returns {undefined} if this Map does not exists or is empty.
			static getLast = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					return ds_map_find_last(ID);
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
			
			// @argument			{any} key
			// @returns				{any|undefined}
			// @description			Return the key that is previous to the specified one.
			//						Returns {undefined} if this Map does not exists, is empty or
			//						the value was first.
			static getPrevious = function(_key)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					return ds_map_find_previous(ID, _key);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getPrevious";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argumnet			{any} key
			// @returns				{any|undefined}
			// @description			Return the key that is next to the specified one.
			//						Returns {undefined} if this Map does not exists, is empty or
			//						the value was last.
			static getNext = function(_key)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					return ds_map_find_next(ID, _key);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getNext";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{any} key
			// @returns				{any|undefined}
			// @description			Return the value of the specified key.
			//						Returns {undefined} if this Map does not exists, is empty or
			//						the key does not exist.
			static getValue = function(_key)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					return ds_map_find_value(ID, _key);
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
			
			// @returns				{any[]}
			// @description			Return all keys in this Map in an array.
			static getAllKeys = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					var _size = ds_map_size(ID);
					var _result = array_create(_size, undefined);
					
					if (_size > 0)
					{
						_result[0] = ds_map_find_first(ID);
						
						var _i = 1;
						repeat (_size - 1)
						{
							_result[_i] = ds_map_find_next(ID, _result[_i - 1]);
							
							++_i;
						}
					}
					
					return _result;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getAllKeys";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return [];
				}
			}
			
			// @returns				{any[]}
			// @description			Return all values in this Map in an array.
			static getAllValues = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					var _size = ds_map_size(ID);
					var _result = array_create(_size, undefined);
					
					if (_size > 0)
					{
						var _key = ds_map_find_first(ID);
						
						var _i = 0;
						repeat (_size)
						{
							_result[_i] = ds_map_find_value(ID, _key);
							_key = ds_map_find_next(ID, _key);
							
							++_i;
						}
					}
					
					return _result;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getAllValues";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return [];
				}
			}
			
			// @argument			{any} key
			// @returns				{bool} | On error: {undefined}
			// @description			Check if the specified key exists in this Map.
			static keyExists = function(_key)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					return ds_map_exists(ID, _key);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "keyExists";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{any} key
			// @returns				{bool|undefined}
			// @description			Check if the specified key is storing a bound List.
			//						Returns {undefined} if this Data Structure does not exists or 
			//						if the specified key does not hold a Data Structure.
			static valueIsBoundList = function(_key)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					return ds_map_is_list(ID, _key);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "valueIsBoundList";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{any} key
			// @returns				{bool|undefined}
			// @description			Check if the specified key is storing a bound Map.
			//						Returns {undefined} if this Data Structure does not exists or 
			//						if the specified key does not hold a Data Structure.
			static valueIsBoundMap = function(_key)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					return ds_map_is_map(ID, _key);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "valueIsBoundMap";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{bool} | On error: {undefined}
			// @description			Check if this Data Structure does not contain any values in it.
			static isEmpty = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					return ds_map_empty(ID);
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
			// @description			Execute the specified function once for each element in this Data
			//						Structure.
			//						The arguments below will be provided to the function and can be
			//						accessed by using their name or the argument array:
			//						- argument[0]: {int} _i
			//						- argument[1]: {any} _key
			//						- argument[2]: {any} _value
			//						- argument[3]: {any} _argument
			static forEach = function(__function, _argument)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					var _size = ds_map_size(ID)
					
					if (_size > 0)
					{
						var _key = ds_map_find_first(ID);
						var _i = 0;
						repeat (_size)
						{
							var _value = ds_map_find_value(ID, _key);
							
							__function(_i, _key, _value, _argument);
							
							_key = ds_map_find_next(ID, _key);
							
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
			
			// @argument			{any} key
			// @argument			{any} value
			// @argument			...
			// @returns				{bool|bool[]}
			// @description			Add one or more key and value pairs to this Map.
			//						Fails if a key already existed for that specific addition.
			//						Returns true if the addition was successful, false if it
			//						was not or an array of such in case of multiple additions.
			static add = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					var _pairCount = (argument_count div 2);
					
					var _results = array_create(_pairCount, false);
					
					var _i = 0;
					repeat (_pairCount)
					{
						_results[_i div 2] = ds_map_add(ID, argument[_i], argument[_i + 1]);
						
						_i += 2;
					}
					
					switch (_pairCount)
					{
						case 0: return false; break;
						case 1: return _results[0]; break;
						default: return _results; break;
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
			
			// @argument			{any} key
			// @argument			{map|Map} value
			// @argument			...
			// @description			Adds one or more key and value pairs to this Map, where the
			//						value is other Map. The added value will become bound to this
			//						Map and will be destroyed upon the destruction of this Map.
			//						While encoding this Map to JSON, binding Data Structures will
			//						allow their values be encoded as well, as opposed to just the
			//						reference ID.
			static addBoundMap = function(_key, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					var _i = 0;
					repeat (argument_count div 2)
					{
						_key = argument[_i];
						_value = argument[_i + 1];
						
						if (instanceof(_value) == "Map")
						{
							ds_map_add_map(ID, _key, _value.ID);
						} 
						else if (ds_exists(_value, ds_type_map))
						{
							ds_map_add_map(ID, _key, _value);
						}
						
						_i += 2;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "addBoundMap";
					var _errorText = ("Attempted to write to an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{any} key
			// @argument			{list|List} value
			// @argument			...
			// @description			Adds one or more key and value pairs to this Map, where the
			//						value is a List. The added value will become bound to this
			//						Map and will be destroyed upon the destruction of this Map.
			//						While encoding this Map to JSON, binding Data Structures will
			//						allow their values be encoded as well, as opposed to just the
			//						reference ID.
			static addBoundList = function(_key, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					var _i = 0;
					repeat (argument_count div 2)
					{
						_key = argument[_i];
						_value = argument[_i + 1];
						
						if (instanceof(_value) == "List")
						{
							ds_map_add_list(ID, _key, _value.ID);
						}
						else if (ds_exists(_value, ds_type_list))
						{
							ds_map_add_list(ID, _key, _value);
						}
						
						_i += 2;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "addBoundList";
					var _errorText = ("Attempted to write to an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{any} key
			// @argument			{any} value
			// @argument			...
			// @description			Add one or more key and value pairs to this Map or replace
			//						the value of the specified key if it already exists.
			static set = function(_key, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					var _i = 0;
					repeat (argument_count div 2)
					{
						ds_map_set(ID, argument[_i], argument[_i + 1]);
						
						_i += 2;
					}
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
			
			// @argument			{any} key
			// @argument			{any} value
			// @description			Set the value of a specified key, but only if it is defined.
			//						If replacing a bound Map or List, the new value will also be
			//						bound and the replaced value will be unbound.
			static replace = function(_key, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					if (ds_map_find_value(ID, _key) != undefined)
					{
						if (ds_map_is_map(ID, _key))
						{
							ds_map_replace_map(ID, _key, _value);
						}
						else if (ds_map_is_list(ID, _key))
						{
							ds_map_replace_list(ID, _key, _value);
						}
						else
						{
							ds_map_replace(ID, _key, _value);
						}
					}
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
			
			// @argument			{any} key
			// @argument			...
			// @description			Removes one or more keys and their values from the Map.
			static remove = function(_key)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					var _i = 0;
					repeat (argument_count)
					{
						ds_map_delete(ID, argument[_i]);
						
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
			// @returns				{string}
			// @description			Create a string representing the constructor.
			//						Overrides the string() conversion.
			//						Content will be represented by the data of this Data Structure.
			static toString = function(_multiline, _elementNumber, _elementLength, _mark_separator,
									   _mark_cut, _mark_elementStart, _mark_elementEnd, 
									   _mark_section)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					//|General initialization.
					var _size = ds_map_size(ID);
					
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
					if (_mark_section == undefined) {_mark_section = ": ";}
					
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
					var _keys = self.getAllKeys();
					
					//|Content loop.
					var _i = 0;
					
					repeat (min(_size, _elementNumber))
					{
						//|Get Data Structure Element.
						var _key = string(_keys[_i]);
						var _value = string(ds_map_find_value(ID, _keys[_i]));
						
						var _newElement = (_key + _mark_section + _value);
						
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
									//|If the current element is last, cut it if it would be too
									// long, but expand the length check by the length of the cut
									// mark.
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
			// @description			Create an array with all keys and values of this Map.
			//						The array will contain two other arrays. First will contain
			//						all keys and second will contain all values.
			static toArray = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					var _size = ds_map_size(ID);
					
					var _keys = array_create(_size, undefined);
					var _values = array_create(_size, undefined);
					
					if (_size > 0)
					{	
						_keys[0] = ds_map_find_first(ID);
						_values[0] = ds_map_find_value(ID, _keys[0]);
						
						var _i = 1;
						repeat (_size - 1)
						{
							_keys[_i] = ds_map_find_next(ID, _keys[_i - 1]);
							_values[_i] = ds_map_find_value(ID, _keys[_i]);
							
							++_i;
						}
					}
					
					return [_keys, _values];
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
			// @description			Add key and value pairs from the specified array to this Map.
			//						The first dimension of the array must contain keys and the 
			//						second their value pairs.
			//						Values not provided for a key will be set to {undefined}.
			static fromArray = function(_array)
			{
				if ((!is_real(ID)) or (!ds_exists(ID, ds_type_map)))
				{
					ID = ds_map_create();
				}
				
				if ((is_array(_array)) and (array_length(_array) >= 2)
				and (is_array(_array[0])) and (is_array(_array[1])))
				{
					var _keys = _array[0];
					var _values = _array[1];
						
					var _keys_length = array_length(_keys);
					var _values_length = array_length(_values);
						
					var _i = 0;
						
					repeat (_keys_length)
					{
						var _value = ((_i < _values_length) ? _values[_i] : undefined);
							
						ds_map_add(ID, _keys[_i], _value);
							
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
			}
			
			// @returns				{string}
			// @description			Return an encoded string of this Data Structure,
			//						which can later be decoded to recreate it.
			static toEncodedString = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					return ds_map_write(ID);
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
				
				if ((!is_real(ID)) or (!ds_exists(ID, ds_type_map)))
				{
					ID = ds_map_create();
				}
				
				ds_map_read(ID, _string, _legacy);
			}
			
			// @argument			{string:path} path
			// @description			Obfuscate and save the Map in the local storage of this device,
			//						fingerprinted for use on this device only.
			//						Arrays will be converted to DS Lists.
			static secureSave = function(_path)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					ds_map_secure_save(ID, _path);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "secureSave";
					var _errorText = ("Attempted to convert an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{string:path} path
			// @returns				{int} | On error: -1
			// @description			Deobfuscate a Map that was obfuscated and fingeprinted for this
			//						device only from its local storage.
			//						Arrays will be converted to DS Lists.
			//						ID of this Map will be returned or -1 if the operation failed.
			static secureLoad = function(_path)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					ds_map_destroy(ID);
				}
				
				ID = ds_map_secure_load(_path);
				
				return ID;
			}
			
			// @argument			{Buffer} buffer
			// @description			Save this Map into a Buffer. This Buffer is intended to be saved
			//						as a file and then loaded later.
			static secureSave_buffer = function(_buffer)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					if ((instanceof(_buffer) == "Buffer") and (is_real(_buffer.ID))
					and (buffer_exists(_buffer.ID)))
					{
						ds_map_secure_save_buffer(ID, _buffer.ID);
					}
					else
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "secureSave_buffer";
						var _errorText = ("Attempted to convert a Data Structure to an invalid " +
										  "Buffer: " +
										  "{" + string(_buffer) + "}");
						_errorReport.reportConstructorMethod(self, _callstack, _methodName,
															 _errorText);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "secureSave_buffer";
					var _errorText = ("Attempted to convert an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Buffer} buffer
			// @description			Load a Map that is in a Buffer that was loaded from a file and
			//						replace this Map with it.
			static secureLoad_buffer = function(_buffer)
			{
				if ((instanceof(_buffer) == "Buffer") and (is_real(_buffer.ID))
				and (buffer_exists(_buffer.ID)))
				{
					if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
					{
						ds_map_destroy(ID);
					}
				
					ID = ds_map_secure_load_buffer(_buffer.ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "secureLoad_buffer";
					var _errorText = ("Attempted to convert an invalid Buffer to a Data " +
									  "Structure: " +
									  "{" + string(_buffer) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName,
															_errorText);
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
