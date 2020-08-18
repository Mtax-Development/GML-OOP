/// @function				Map()
///
/// @description			Constructs a Map Data Structure, which stores data by creating key 
///							and value pairs. The data inside of it is not sorted and values
///							are accessed either by providing a specific existing key or by
///							iterating through the entire Data Structure.
function Map() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				ID = ds_map_create();
			}
			
			// @returns				{undefined}
			// @description			Remove the internal information from the memory.
			static destroy = function()
			{
				//+TODO: Deep data structure scan.
				
				if (ds_exists(ID, ds_type_map))
				{
					ds_map_destroy(ID);
				}
				
				return undefined;
			}
			
			// @description			Remove data from this Data Structure.
			static clear = function()
			{
				if (ds_exists(ID, ds_type_map))
				{
					ds_map_clear(ID);
				}
			}
			
			// @argument			{Map} other
			// @description			Replace data of this Map with data from another one.
			static copy = function(_other)
			{
				if (ds_exists(_other.ID, ds_type_map))
				{
					if (!ds_exists(ID, ds_type_map))
					{
						self.construct();
					}
					
					ds_map_copy(ID, _other.ID);
				}
			}
			
		#endregion
		#region <Getters>
			
			//+TODO: Superset the unreleased functions when they will be available.
			
			// @returns				{int}
			// @description			Return the number of values in this Data Structure.
			static getSize = function()
			{
				return ((ds_exists(ID, ds_type_map)) ? ds_map_size(ID) : 0);
			}
			
			// @returns				{any|undefined}
			// @description			Return the first key in this Map for use in iterating through it.
			//						Returns {undefined} if this Map does not exists or is empty.
			static getFirst = function()
			{
				return ((ds_exists(ID, ds_type_map)) ? ds_map_find_first(ID) : undefined);
			}
			
			// @returns				{any|undefined}
			// @description			Return the last key in this Map for use in iterating through it.
			//						Returns {undefined} if this Map does not exists or is empty.
			static getLast = function()
			{
				return ((ds_exists(ID, ds_type_map)) ? ds_map_find_last(ID) : undefined);
			}
			
			// @argument			{any} key
			// @returns				{any|undefined}
			// @description			Return the key that is previous to the specified one.
			//						Returns {undefined} if this Map does not exists, is empty or
			//						the value was first.
			static getPrevious = function(_key)
			{
				return ((ds_exists(ID, ds_type_map)) ? ds_map_find_previous(ID, _key) : undefined);
			}
			
			// @argumnet			{any} key
			// @returns				{any|undefined}
			// @description			Return the key that is next to the specified one.
			//						Returns {undefined} if this Map does not exists, is empty or
			//						the value was last.
			static getNext = function(_key)
			{
				return ((ds_exists(ID, ds_type_map)) ? ds_map_find_next(ID, _key) : undefined);
			}
			
			// @argument			{any} key
			// @returns				{any|undefined}
			// @description			Return the value of the specified key.
			//						Returns {undefined} if this Map does not exists, is empty or
			//						the key does not exist.
			static getValue = function(_key)
			{
				return ((ds_exists(ID, ds_type_map)) ? ds_map_find_value(ID, _key) : undefined);
			}
			
			// @return				{any[]}
			// @description			Return all keys in this Map (without values) as an array.
			static getAllKeys = function()
			{
				if (ds_exists(ID, ds_type_map))
				{
					var _size = ds_map_size(ID);
					
					if (_size > 0)
					{
						var _results = array_create(_size, undefined);
						
						_results[0] = ds_map_find_first(ID);
						
						var _i = 1;
						
						repeat (_size - 1)
						{
							_results[_i] = ds_map_find_next(ID, _results[_i - 1]);
							
							_i++;
						}
						
						return _results;
					}
				}
				
				return [];
			}
			
			// @argument			{any} key
			// @returns				{bool|undefined}
			// @description			Check if the specified key exists in this Map.
			//						Returns {undefined} if this Data Structure does not exists
			static keyExists = function(_key)
			{
				return ((ds_exists(ID, ds_type_map)) ? ds_map_exists(ID, _key) : undefined);
			}
			
			// @argument			{any} key
			// @returns				{bool|undefined}
			// @description			Check if the specified key is storing a bound List.
			//						Returns {undefined} if this Data Structure does not exists,
			//						also if the checked key does not hold a Data Structure.
			static valueIsBoundList = function(_key)
			{
				return ((ds_exists(ID, ds_type_map)) ? ds_map_is_list(ID, _key) : undefined);
			}
			
			// @argument			{any} key
			// @returns				{bool|undefined}
			// @description			Check if the specified key is storing a bound Map.
			//						Returns {undefined} if this Data Structure does not exists,
			//						also if the checked key does not hold a Data Structure.
			static valueIsBoundMap = function(_key)
			{
				return ((ds_exists(ID, ds_type_map)) ? ds_map_is_map(ID, _key) : undefined);
			}
			
			// @returns				{bool|undefined}
			// @description			Check if this Data Structure does not contain any values in it.
			//						Returns {undefined} if this Data Structure does not exists.
			static isEmpty = function()
			{
				return ((ds_exists(ID, ds_type_map)) ? ds_map_empty(ID) : undefined);
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{any} key
			// @argument			{any} value
			// @argument			...
			// @returns				{bool|bool[]}
			// @description			Add one or more key and value pairs to this Map.
			//						Fails if a key already existed for that specific addition.
			//						Returns true if the addition was successful, false if it
			//						was not or an array of such in case of multiple additions.
			static add = function(_key, _value)
			{
				if (ds_exists(ID, ds_type_map))
				{
					if (argument_count <= 2)
					{
						return ds_map_add(ID, _key, _value);
					}
					else
					{
						var _pairNumber = (argument_count / 2);
						var _results = array_create(_pairNumber, false);
						
						var _pairID = 0;
						var _i = 0;
						
						repeat (_pairNumber)
						{
							_results[_pairID++] = ds_map_add(ID, argument[_i], argument[_i + 1]);
						
							_i += 2;
						}
						
						return _results;
					}
				}
				else
				{
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
				if (ds_exists(ID, ds_type_map))
				{
					var _i = 0;
					
					repeat (argument_count / 2)
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
				if (ds_exists(ID, ds_type_map))
				{
					var _i = 0;
					
					repeat (argument_count / 2)
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
			}
			
			// @argument			{any} key
			// @argument			{any} value
			// @argument			...
			// @description			Add one or more key and value pairs to this Map or replace
			//						the value of the specified key if it already exists.
			static set = function(_key, _value)
			{
				if (ds_exists(ID, ds_type_map))
				{
					var _i = 0;
					
					repeat (argument_count / 2)
					{
						ds_map_set(ID, argument[_i], argument[_i + 1]);
						
						_i += 2;
					}
				}
			}
			
			// @argument			{any} key
			// @argument			{any} value
			// @description			Set the value of a specified key, but only if it is defined.
			//						If replacing a bound Map or List, the new value will also be
			//						bound and the replaced value will be unbound.
			static replace = function(_key, _value)
			{
				if (ds_exists(ID, ds_type_map))
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
			}
			
			// @argument			{any} key
			// @argument			...
			// @description			Removes one or more keys and their values from the Map.
			static remove = function(_key)
			{
				if (ds_exists(ID, ds_type_map))
				{
					var _i = 0;
					
					repeat (argument_count)
					{
						ds_map_delete(ID, argument[_i++]);
					}
				}
			}
			
			// @argument			{string} filename
			// @returns				{bool}
			// @description			Obfuscate and save the Map in the local storage of the device.
			//						Arrays will be converted to a DS list.
			static secureSave = function(_filename)
			{
				return ((ds_exists(ID, ds_type_map)) ? ds_map_secure_save(ID, _filename) : false);
			}
			
			// @argument			{string} filename
			// @description			Deobfuscate a saved Map from the local storage of the device.
			//						Arrays will be converted to a DS list.
			static secureLoad = function(_filename)
			{
				if (ds_exists(ID, ds_type_map))
				{
					ds_map_destroy(ID);
				}
				
				ID = ds_map_secure_load(_filename);
			}
			
			// @argument			{buffer} buffer
			// @description			Save this Map into a Buffer. That buffer is intended to be saved
			//						as a file and then loaded later.
			static secureSave_buffer = function(_buffer)
			{
				if (ds_exists(ID, ds_type_map))
				{
					if (buffer_exists(_buffer))
					{
						ds_map_secure_save_buffer(ID, _buffer);
					}
				}
			}
			
			// @argument			{buffer} buffer
			// @description			Load a Map that is in a Buffer that was loaded from a file and
			//						replace this Map with it.
			static secureLoad_buffer = function(_buffer)
			{
				if (buffer_exists(_buffer))
				{
					if (ds_exists(ID, ds_type_map))
					{
						ds_map_destroy(ID);
					}
				
					ID = ds_map_secure_load_buffer(_buffer);
				}
			}
			
			#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Overrides the string conversion with the constructor 
			//						name and preview of the content.
			static toString = function()
			{
				if (ds_exists(ID, ds_type_map))
				{
					var _string = (instanceof(self) + "(");
					
					var _separator = ", ";
					var _cutMark = "...";
					var _keyMark = ": ";
					
					var _separator_length = string_length(_separator);
					var _cutMark_length = string_length(_cutMark);
					
					var _contentLength = 30;
					var _maximumLength = (_contentLength + string_length(_string));
					
					var _keys = self.getAllKeys(); //+TODO: Replace with ds_map_find_all when possible
					
					var _size = ds_map_size(ID);
					var _i = 0;
					
					repeat (_size)
					{
						var _key = string(_keys[_i]);
						var _value = string(ds_map_find_value(ID, _keys[_i]));
						
						_string += (_key + _keyMark + _value);
						
						if ((string_length(_string) + _separator_length) < _maximumLength)
						{
							if (_i < (_size - 1))
							{
								_string += _separator;
							}
						}
						else
						{
							return (((_i == _size) and
									string_length(_string) <= _maximumLength + _cutMark_length)) ?
								   (_string + ")"):
								   (string_copy(_string, 1, _maximumLength) + _cutMark + ")");
						}
						
						_i++;
					}
					
					return (_string + ")");
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			// @returns				{string}
			// @description			Return a string with constructor name and all of its content.
			static toString_full = function()
			{
				if (ds_exists(ID, ds_type_map))
				{
					var _string = (instanceof(self) + "(");
					
					var _separator = ", ";
					var _keyMark = ": ";
					
					var _keys = self.getAllKeys(); //+TODO: Replace with ds_map_find_all when possible
					
					var _size = ds_map_size(ID);
					var _i = 0;
					
					repeat (_size)
					{
						var _key = string(_keys[_i]);
						var _value = string(ds_map_find_value(ID, _keys[_i]));
						
						_string += (_key + _keyMark + _value);
						
						if (_i < (_size - 1))
						{
							_string += _separator;
						}

						_i++;
					}
					
					return (_string + ")");
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			// @argument			{bool} cut?
			// @returns				{string}
			// @description			Return a line-broken string with the content of 
			//						this Data Structure.
			static toString_multiline = function(_cut)
			{
				if (ds_exists(ID, ds_type_map))
				{
					var _string = ((_cut) ? self.toString() : self.toString_full());
					_string = string_replace_all(_string, (instanceof(self) + "("), "");
					_string = string_replace_all(_string, ", ", "\n");
					_string = string_copy(_string, 1, (string_length(_string) - 1));
					
					return _string;
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			// @returns				{string}
			// @description			Return an encoded string of this Data Structure,
			//						which can later be decoded to recreate it.
			static toEncodedString = function()
			{
				return ((ds_exists(ID, ds_type_map)) ? ds_map_write(ID) : string(undefined));
			}
			
			// @argument			{string} string
			// @argument			{bool} legacy?
			// @description			Decode the previously encoded string of the same Data 
			//						Structure and recreate it into this one.
			//						Use the "legacy" argument if that string was created
			//						in old versions of Game Maker with different encoding.
			static fromEncodedString = function(_string, _legacy)
			{
				if (_legacy == undefined) {_legacy = false;}
				
				if (!ds_exists(ID, ds_type_map))
				{
					self.construct();
				}
				
				ds_map_read(ID, _string, _legacy);
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		self.construct();
		
	#endregion
}
