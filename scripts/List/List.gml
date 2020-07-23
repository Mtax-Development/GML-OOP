/// @function				List()
///
/// @description			Constructs a List Data Structure, which offers a flexible way of
///							storing data inside of a linnear model. It can be easily resized,
///							sorted and manipulated in other ways.
function List() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				ID = ds_list_create();
				ds_list_clear(ID);
			}
			
			// @returns				{undefined}
			// @description			Remove the internal information from the memory.
			static destroy = function()
			{
				//+TODO: Deep data structure scan
			
				if (ds_exists(ID, ds_type_list))
				{
					ds_list_destroy(ID);
				}
			
				return undefined;
			}
			
			// @description			Remove all data from the List.
			static clear = function()
			{
				if (ds_exists(ID, ds_type_list))
				{
					ds_list_clear(ID);
				}
			}
			
			// @argument			{List} other
			// @description			Copy all values from other List to this one.
			static copy = function(_other)
			{
				if ((ds_exists(ID, ds_type_list)) and (ds_exists(_other.ID, ds_type_list)))
				{
					ds_list_copy(ID, _other.ID);
				}
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{any} value
			// @returns				{int}
			// @description			Return the position of a specified value or -1 if not present.
			static getFirstIndex = function(_value)
			{
				return ((ds_exists(ID, ds_type_list)) ? ds_list_find_index(ID, _value) : -1);
			}
			
			// @argument			{any} value
			// @returns				{int[]}
			// @description			Return an array populated with all positions of a specified value.
			static getAllIndexes = function(_value)
			{
				if (ds_exists(ID, ds_type_list))
				{
					var _indexes = [];
					
					var _i = 0;
					
					repeat (ds_list_size(ID))
					{
						if (ID[| _i] == _value)
						{
							_indexes[array_length(_indexes)] = _i;
						}
						
						_i++;
					}
					
					return _indexes;
				}
				else
				{
					return [];
				}
			}
			
			// @argument			{int} position
			// @returns				{any|undefined}
			// @description			Return the value at specified position.
			static getValue = function(_position)
			{
				return ((ds_exists(ID, ds_type_list)) ? 
					   ds_list_find_value(ID, _position) : undefined);
			}
			
			// @returns				{int}
			// @description			Return the number of values this List holds.
			static getSize = function()
			{
				return ((ds_exists(ID, ds_type_list)) ? ds_list_size(ID) : 0);
			}
			
			// @returns				{any|undefined}
			// @description			Return the first value in this List.
			//						Returns {undefined} if this List does not exists or is empty.
			static getFirst = function()
			{
				if (ds_exists(ID, ds_type_list))
				{
					return ((ds_list_size(ID) > 0) ? ID[| 0] : undefined);
				}
				else
				{
					return undefined;
				}
			}
			
			// @returns				{any|undefined}
			// @description			Return the last value in this List.
			//						Returns {undefined} if this List does not exist or is empty.
			static getLast = function()
			{
				if (ds_exists(ID, ds_type_list))
				{
					var _size = ds_list_size(ID);
				
					return ((_size > 0) ? ID[| (_size - 1)] : undefined);
				}
				else
				{
					return undefined;
				}
			}
			
		#endregion
		#region <Execution>
			
			// @description			Add a one or more values to this List.
			static add = function()
			{
				if (ds_exists(ID, ds_type_list))
				{
					var _i = 0;
				
					repeat(argument_count)
					{
						ds_list_add(ID, argument[_i++]);
					}
				}
			}
			
			// @argument			{int} position
			// @argument			{any} value
			// @description			Set a specified position of the List to provided value
			//						and set any empty places before it to 0.
			static set = function(_position, _value)
			{
				if (ds_exists(ID, ds_type_list))
				{
					ds_list_set(ID, _position, _value);
				}
			}
			
			// @argument			{int} position
			// @argument			{any} value
			// @description			Set a specified position of the List to provided value,
			//						but only if it already exists.
			static replace = function(_position, _value)
			{
				if (ds_exists(ID, ds_type_list))
				{
					ds_list_replace(ID, _position, _value);
				}
			}
			
			// @argument			{int} position
			// @description			Remove a value at a specified position from the List and 
			//						push the position of all values after it back by one.
			static remove = function(_position)
			{
				if (ds_exists(ID, ds_type_list))
				{
					ds_list_delete(ID, _position);
				}
			}
			
			// @argument			{int} position
			// @argument			{any} value
			// @description			Add a value at a specified position to the List and push
			//						the position of all values after it forward by one.
			static insert = function(_position, _value)
			{
				if (ds_exists(ID, ds_type_list))
				{
					ds_list_insert(ID, _position, _value);
				}
			}
			
			// @description			Randomize the position of all values in the List.
			static shuffle = function()
			{
				if (ds_exists(ID, ds_type_list))
				{
					ds_list_shuffle(ID);
				}
			}
			
			// @argument			{bool} order_ascending
			// @description			Sort all values in the List in ascending or descending order.
			//						In ascending order, numbers will be placed before strings.
			//						In descnding order, numbers will be placed after strings.
			static sort = function(order_ascending)
			{
				if (ds_exists(ID, ds_type_list))
				{
					ds_list_sort(ID, order_ascending);
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @description			Overrides the string conversion with the content output.
			static toString = function()
			{
				var _string = "List(";
			
				var _size = ds_list_size(ID);
				var _i = 0;
			
				repeat (_size - 1)
				{
					_string += (string(ID[| _i++]) + ", ");
				}
			
				if (_size > 0)
				{
					_string += string(ID[| _size - 1]);
				}
			
				_string += ")";
			
				return _string;
			}
			
			// @returns				{string}
			// @description			Encode all values of this List into a string, so it
			//						can be later decoded back into that List.
			static toEncodedString = function()
			{
				return ((ds_exists(ID, ds_type_list)) ? ds_list_write(ID) : string(undefined));
			}
			
			// @argument			{string} string
			// @argument			{bool} legacy?
			// @description			Add list values from an encoded string into this List.
			//						Set the "legacy" argument to true if that string was
			//						created in old versions of Game Maker.
			static fromEncodedString = function(_string, _legacy)
			{
				if (_legacy == undefined) {_legacy = false;}
				
				if (!ds_exists(ID, ds_type_list))
				{
					self.construct();
				}
				
				ds_list_read(ID, _string, _legacy);
			}
		
		#endregion
	#endregion
	#region [Constructor]
		
		self.construct();
		
	#endregion
}
