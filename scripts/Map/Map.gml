//  @function				Map()
///							
/// @description			Constructs a Map Data Structure, which stores data by creating key and
///							value pairs. The contained data is not sorted and values are accessed
///							either by providing a specific existing key or by iterating through the
///							the entire Map.
//							
//							Construction types:
//							- New constructor
//							- Wrapper: map {int:map}
//							- Empty: {undefined}
//							- Constructor copy: other {Map}
function Map() constructor
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
						if (instanceof(argument[0]) == "Map")
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
					ID = ds_map_create();
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (ds_exists(ID, ds_type_map)));
			}
			
			/// @argument			deepScan? {bool}
			/// @returns			{undefined}
			/// @description		Remove the internal information from the memory.
			///						A deep scan can be performed before the removal, which will 
			///						iterate through this and all other Data Structures contained
			///						in it to destroy them as well.
			static destroy = function(_deepScan = false)
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
					}
					
					ds_map_destroy(ID);
					
					ID = undefined;
				}
				
				return undefined;
			}
			
			/// @description		Remove data from this Data Structure.
			static clear = function()
			{
				if ((!is_real(ID)) or (!ds_exists(ID, ds_type_map)))
				{
					ID = ds_map_create();
				}
				
				ds_map_clear(ID);
				
				return self;
			}
			
			/// @argument			other {Map}
			/// @description		Replace data of this Map with data from another one.
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
					var _size = ds_map_size(ID);
					var _key = ds_map_find_first(ID);
					var _i = [0, 0];
					repeat (_size)
					{
						var _value = ds_map_find_value(ID, _key);
						
						_i[1] = 0;
						repeat (argument_count)
						{
							if (_value == argument[_i[1]])
							{
								return true;
							}
							
							++_i[1];
						}
						
						_key = ds_map_find_next(ID, _key);
						
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
			/// @returns			{int
			/// @description		Return the number of times the specified values occur in this
			///						Data Structure.
			static count = function()
			{
				try
				{
					var _result = 0;
					var _size = ds_map_size(ID);
					var _key = ds_map_find_first(ID);
					var _i = [0, 0];
					repeat (_size)
					{
						var _value = ds_map_find_value(ID, _key);
						_i[1] = 0;
						repeat (argument_count)
						{
							if (_value == argument[_i[1]])
							{
								++_result;
							}
							
							++_i[1];
						}
						
						_key = ds_map_find_next(ID, _key);
						
						++_i[0];
					}
					
					return _result;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "count()"], _exception);
				}
				
				return 0;
			}
			
			/// @argument			key... {any}
			/// @returns			{any|undefined}
			/// @description		Return the value of a single specified key or final nested key.
			///						Returns {undefined} if this Map does not exists, is empty or the
			///						key does not exist.
			static getValue = function()
			{
				try
				{
					var _value = self;
					var _i = 0;
					repeat (argument_count)
					{
						_value = ds_map_find_value(_value.ID, argument[_i]);
						
						++_i;
					}
					
					return _value;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getValue()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{any[]}
			/// @description		Return all values in this Map in an array.
			static getAllValues = function()
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getAllValues()"], _exception);
				}
				
				return [];
			}
			
			/// @returns			{any[]}
			/// @description		Return all keys in this Map in an array.
			static getAllKeys = function()
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getAllKeys()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{any|undefined}
			/// @description		Return the first key in this Map for use in iterating through it.
			///						Returns {undefined} if this Map does not exists or is empty.
			static getFirst = function()
			{
				try
				{
					return ds_map_find_first(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getFirst()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{any|undefined}
			/// @description		Return the last key in this Map for use in iterating through it.
			///						Returns {undefined} if this Map does not exists or is empty.
			static getLast = function()
			{
				try
				{
					return ds_map_find_last(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getLast()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			key {any}
			/// @returns			{any|undefined}
			/// @description		Return the key that is previous to the specified one.
			///						Returns {undefined} if this Map does not exists, is empty or the
			///						value was first.
			static getPrevious = function(_key)
			{
				try
				{
					return ds_map_find_previous(ID, _key);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getPrevious()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argumnet			key {any}
			/// @returns			{any|undefined}
			/// @description		Return the key that is next to the specified one.
			///						Returns {undefined} if this Map does not exists, is empty or the
			///						value was last.
			static getNext = function(_key)
			{
				try
				{
					return ds_map_find_next(ID, _key);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getNext()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			key {any}
			/// @returns			{bool} | On error: {undefined}
			/// @description		Check if the specified key exists in this Map.
			static keyExists = function(_key)
			{
				try
				{
					return ds_map_exists(ID, _key);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "keyExists()"], _exception);
				}
			}
			
			/// @argument			key {any}
			/// @returns			{bool|undefined}
			/// @description		Check if the specified key is storing a bound List.
			///						Returns {undefined} if this Data Structure does not exists or
			///						if the specified key does not hold a Data Structure.
			static valueIsBoundList = function(_key)
			{
				try
				{
					return ds_map_is_list(ID, _key);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "valueIsBoundList()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			key {any}
			/// @returns			{bool|undefined}
			/// @description		Check if the specified key is storing a bound Map.
			///						Returns {undefined} if this Data Structure does not exists or
			///						if the specified key does not hold a Data Structure.
			static valueIsBoundMap = function(_key)
			{
				try
				{
					return ds_map_is_map(ID, _key);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "valueIsBoundMap()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{int}
			/// @description		Return the number of values in this Data Structure.
			static getSize = function()
			{
				try
				{
					return ds_map_size(ID);
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
					return ds_map_empty(ID);
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
			/// @returns			{any[]}
			/// @description		Execute a function once for each element in this Data Structure.
			///						The following arguments will be provided to the function and can
			///						be accessed in it by using their name or the argument array:
			///						- argument[0]: _i {int}
			///						- argument[1]: _key {any}
			///						- argument[2]: _value {any}
			///						- argument[3]: _argument {any}
			static forEach = function(__function, _argument)
			{
				var _dataCopy = ds_map_create();
				
				try
				{
					ds_map_copy(_dataCopy, ID);
					var _size = ds_map_size(ID)
					var _functionReturn = [];
					var _key = ds_map_find_first(_dataCopy);
					var _i = 0;
					repeat (_size)
					{
						var _value = ds_map_find_value(_dataCopy, _key);
						
						try
						{
							array_push(_functionReturn, __function(_i, _key, _value, _argument));
						}
						catch (_exception)
						{
							new ErrorReport().report([other, self, "forEach()", "function()"],
													 _exception);
						}
						
						_key = ds_map_find_next(_dataCopy, _key);
						
						++_i;
					}
					
					return _functionReturn;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "forEach()"], _exception);
				}
				finally
				{
					ds_map_destroy(_dataCopy);
				}
				
				return [];
			}
			
			/// @argument			key... {any}
			/// @argument			value... {any}
			/// @returns			{bool|bool[]}
			/// @description		Add one or more key and value pairs to this Map.
			///						Fails if a key already existed for that specific addition.
			///						Returns true if the addition was successful, false if it
			///						was not or an array of such in case of multiple additions.
			static add = function()
			{
				try
				{
					var _pairCount = (argument_count div 2);
					var _result = array_create(_pairCount, false);
					var _i = 0;
					repeat (_pairCount)
					{
						_result[_i div 2] = ds_map_add(ID, argument[_i], argument[(_i + 1)]);
						
						_i += 2;
					}
					
					switch (_pairCount)
					{
						case 0: return false; break;
						case 1: return _result[0]; break;
						default: return _result; break;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "add()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			key... {any}
			/// @argument			value... {List|int:list}
			/// @description		Adds one or more key and value pairs to this Map, where the
			///						value is a List. The added value will become bound to this
			///						Map and will be destroyed upon the destruction of this Map.
			///						While encoding this Map to JSON, binding Data Structures will
			///						allow their values be encoded as well, as opposed to just the
			///						reference ID.
			static addBoundList = function(_key, _value)
			{
				try
				{
					var _i = 0;
					repeat (argument_count div 2)
					{
						try
						{
							_key = argument[_i];
							_value = argument[(_i + 1)];
							
							if (instanceof(_value) == "List")
							{
								ds_map_add_list(ID, _key, _value.ID);
							}
							else if ((is_real(_value)) and (ds_exists(_value, ds_type_list)))
							{
								ds_map_add_list(ID, _key, _value);
							}
						}
						catch (_exception)
						{
							new ErrorReport().report([other, self, "addBoundList()"], _exception);
						}
						
						_i += 2;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "addBoundList()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			key... {any}
			/// @argument			value... {Map|int:map}
			/// @description		Adds one or more key and value pairs to this Map, where the
			///						value is other Map. The added value will become bound to this
			///						Map and will be destroyed upon the destruction of this Map.
			///						While encoding this Map to JSON, binding Data Structures will
			///						allow their values be encoded as well, as opposed to just the
			///						reference ID.
			static addBoundMap = function(_key, _value)
			{
				try
				{
					var _i = 0;
					repeat (argument_count div 2)
					{
						try
						{
							_key = argument[_i];
							_value = argument[(_i + 1)];
						
							if (instanceof(_value) == "Map")
							{
								ds_map_add_map(ID, _key, _value.ID);
							} 
							else if ((is_real(_value)) and (ds_exists(_value, ds_type_map)))
							{
								ds_map_add_map(ID, _key, _value);
							}
						}
						catch (_exception)
						{
							new ErrorReport().report([other, self, "addBoundMap()"], _exception);
						}
						
						_i += 2;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "addBoundMap()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			key... {any}
			/// @argument			value... {any}
			/// @description		Add one or more key and value pairs to this Map or replace the
			///						value of the specified key if it already exists.
			static set = function(_key, _value)
			{
				try
				{
					var _i = 0;
					repeat (argument_count div 2)
					{
						ds_map_set(ID, argument[_i], argument[(_i + 1)]);
						
						_i += 2;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "set()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			key... {any}
			/// @argument			value... {any}
			/// @description		Set one or more values of the specified keys, but only if each
			///						already exists in this Map.
			///						If replacing a bound Map or List, the new value will become bound
			///						and the value that was replaced by it will become unbound.
			static replace = function(_key, _value)
			{
				try
				{
					var _i = 0;
					repeat (argument_count div 2)
					{
						try
						{
							_key = argument[_i];
							_value = argument[(_i + 1)];
							
							if (ds_map_find_value(ID, _key) != undefined)
							{
								if (ds_map_is_map(ID, _key))
								{
									if (instanceof(_value) == "Map")
									{
										ds_map_replace_map(ID, _key, _value.ID);
									}
									else
									{
										ds_map_replace_map(ID, _key, _value);
									}
								}
								else if (ds_map_is_list(ID, _key))
								{
									if (instanceof(_value) == "List")
									{
										ds_map_replace_list(ID, _key, _value.ID);
									}
									else
									{
										ds_map_replace_list(ID, _key, _value);
									}
								}
								else
								{
									ds_map_replace(ID, _key, _value);
								}
							}
						}
						catch (_exception)
						{
							new ErrorReport().report([other, self, "replace()"], _exception);
						}
					
						_i += 2;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "replace()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			key... {any}
			/// @description		Removes one or more keys and their values from the Map.
			static remove = function(_key)
			{
				try
				{
					var _i = 0;
					repeat (argument_count)
					{
						ds_map_delete(ID, argument[_i]);
						
						++_i;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "remove()"], _exception);
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
			/// @argument			mark_section? {string}
			/// @argument			mark_sizeSeparator? {string}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented by the data of this Data Structure.
			static toString = function(_multiline = false, _elementNumber = 10, _elementLength = 30,
									   _mark_separator = ", ", _mark_cut = "...",
									   _mark_elementStart = "", _mark_elementEnd = "",
									   _mark_section = ": ", _mark_sizeSeparator = " - ")
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
				{
					//|General initialization.
					var _size = ds_map_size(ID);
					
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
									//|If the current element is last, cut it if it would be too
									// long, but expand the length check by the length of the cut
									// mark.
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
			
			/// @returns			{any[]}
			/// @description		Create an array with all keys and values of this Map.
			///						The array will contain two arrays. The first one will contain all
			///						keys and second one will contain all values.
			static toArray = function()
			{
				try
				{
					var _size = ds_map_size(ID);
					var _keys = array_create(_size, undefined);
					var _values = array_create(_size, undefined);
					
					if (_size > 0)
					{	
						_keys[0] = ds_map_find_first(ID);
						_values[0] = ds_map_find_value(ID, _keys[0]);
						
						var _i = 1;
						repeat (_size - _i)
						{
							_keys[_i] = ds_map_find_next(ID, _keys[_i - 1]);
							_values[_i] = ds_map_find_value(ID, _keys[_i]);
							
							++_i;
						}
					}
					
					return [_keys, _values];
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "toArray()"], _exception);
				}
				
				return [[], []];
			}
			
			/// @argument			array {any[]}
			/// @description		Add key and value pairs from the specified array to this Map.
			///						The first dimension of the array must contain keys and the 
			///						second their value pairs.
			///						Values not provided for a key will be set to {undefined}.
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
					new ErrorReport().report([other, self, "fromArray()"],
											 ("Attempted to convert an invalid or incorrectly " +
											  "formatted array to a Data Structure: " +
											  "{" + string(_array) + "}"));
				}
				
				return self;
			}
			
			/// @returns			{struct}
			/// @description		Create a struct with all keys and values of this Map, as well as
			///						its nested Maps represented as structs.
			///						Keys with names that do not follow variable naming rules will not
			///						be accessible with the struct variable dot notation, but can still
			///						be accessed through a function or an accessor.
			static toStruct = function()
			{
				try
				{
					var _size = ds_map_size(ID);
					var _struct = {};
					
					if (_size > 0)
					{	
						var _key = ds_map_find_first(ID);
						var _value = ds_map_find_value(ID, _key);
						
						if (instanceof(_value) == "Map")
						{
							_value = _value.toStruct();
						}
						
						variable_struct_set(_struct, _key, _value);
						
						var _i = 1;
						repeat (_size - _i)
						{
							_key = ds_map_find_next(ID, _key);
							_value = ds_map_find_value(ID, _key);
							
							if (instanceof(_value) == "Map")
							{
								_value = _value.toStruct();
							}
							
							variable_struct_set(_struct, _key, _value);
							
							++_i;
						}
					}
					
					return _struct;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "toStruct()"], _exception);
				}
				
				return {};
			}
			
			/// @argument			struct {struct}
			/// @description		Add key and value pairs from the specified struct to this Map
			///						and its nested structs to newly created Maps nested in this Map.
			///						Already existing keys will not be overwritten.
			static fromStruct = function(_struct)
			{
				if (is_struct(_struct))
				{
					if ((!is_real(ID)) or (!ds_exists(ID, ds_type_map)))
					{
						ID = ds_map_create();
					}
				
					var _key = variable_struct_get_names(_struct);
					var _i = 0;
					repeat (array_length(_key))
					{
						if (!ds_map_exists(ID, _key[_i]))
						{
							var _value = variable_struct_get(_struct, _key[_i]);
						
							if (is_struct(_value))
							{
								ds_map_add(ID, _key[_i], new Map().fromStruct(_value));
							}
							else
							{
								ds_map_add(ID, _key[_i], _value);
							}
						}
					
						++_i;
					}
				}
				else
				{
					new ErrorReport().report([other, self, "fromStruct()"],
											 ("Attempted to convert an invalid struct: " + 
											  "{" + string(_struct) + "}"));
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
					return ds_map_write(ID);
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
			///						Use the "legacy" argument if that string was created in old
			///						versions of GameMaker with different encoding.
			static fromEncodedString = function(_string, _legacy = false)
			{
				try
				{
					if ((!is_real(ID)) or (!ds_exists(ID, ds_type_map)))
					{
						ID = ds_map_create();
					}
				
					ds_map_read(ID, _string, _legacy);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "fromEncodedString()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			path {string:path}
			/// @description		Obfuscate and save this Map in the local storage of this device,
			///						fingerprinted for use on this device only.
			///						Arrays will be saved as DS Lists.
			static secureToFile = function(_path)
			{
				try
				{
					ds_map_secure_save(ID, _path);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "secureToFile()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			path {string:path}
			/// @returns			{int}
			/// @description		Deobfuscate a Map that was obfuscated and fingeprinted for this
			///						device only from its local storage.
			///						Arrays will be loaded as DS Lists.
			///						ID of this Map will be returned or -1 if the operation failed.
			static secureFromFile = function(_path)
			{
				if (file_exists(_path))
				{
					if ((is_real(ID)) and (ds_exists(ID, ds_type_map)))
					{
						ds_map_destroy(ID);
					}
				
					ID = ds_map_secure_load(_path);
				
					return ID;
				}
				else
				{
					new ErrorReport().report([other, self, "fromStruct()"],
											 ("Attempted to load a nonexistent file: " +
											  "{" + string(_path) + "}"));
				}
				
				return undefined;
			}
			
			/// @argument			buffer {Buffer}
			/// @description		Load a Map that is in a Buffer that was loaded from a file and
			///						replace this Map with it.
			static secureFromBuffer = function(_buffer)
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
					new ErrorReport().report([other, self, "secureFromBuffer()"],
											 ("Attempted to convert an invalid Buffer to a Data " +
											  "Structure: " +
											  "{" + string(_buffer) + "}"));
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
