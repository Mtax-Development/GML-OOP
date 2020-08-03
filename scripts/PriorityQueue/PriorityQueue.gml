/// @function				PriorityQueue()
///
/// @description			Constructs a Priority Queue Data Structure, which stores data in
///							a linnear model that orders the values based on their priority.
function PriorityQueue() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				ID = ds_priority_create();
			}
			
			// @returns				{undefined}
			// @description			Remove the internal information from the memory.
			static destroy = function()
			{
				if (ds_exists(ID, ds_type_priority))
				{
					ds_priority_destroy(ID);
				}
				
				return undefined;
			}
			
			// @description			Remove all data from this Data Structure.
			static clear = function()
			{
				if (ds_exists(ID, ds_type_priority))
				{
					ds_priority_clear(ID);
				}
			}
			
			// @description			Replace all data of this Priority Queue
			//						with data from another one.
			static copy = function(_other)
			{
				if (ds_exists(_other.ID, ds_type_priority))
				{
					if (!ds_exists(ID, ds_type_priority))
					{
						self.construct();
					}
					
					ds_priority_copy(ID, _other.ID);
				}
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{int}
			// @description			Return the number of values in this Priority Queue.
			static getSize = function()
			{
				return ((ds_exists(ID, ds_type_priority)) ? ds_priority_size(ID) : 0);
			}
			
			// @returns				{any|undefined}
			// @description			Return any value with the lowest priority in this Priority Queue.
			//						Returns {undefined} if this Priority Queue does not exists or is
			//						empty.
			static getMin = function()
			{
				return ((ds_exists(ID, ds_type_priority)) ? ds_priority_find_min(ID) : undefined);
			}
			
			// @returns				{any|undefined}
			// @description			Return any value with the highest priority in this Priority Queue.
			//						Returns {undefined} if this Priority Queue does not exists or is
			//						empty.
			static getMax = function()
			{
				return ((ds_exists(ID, ds_type_priority)) ? ds_priority_find_max(ID) : undefined);
			}
			
			// @argument			{any} value
			// @returns				{any|undefined}
			// @description			Return the priority of a specified value.
			static getPriority = function(_value)
			{
				return ((ds_exists(ID, ds_type_priority)) ? ds_priority_find_priority(ID, _value) : 
															undefined);
			}
			
			// @returns				{bool|undefined}
			// @description			Check if this Data Structure has any values in it.
			static isEmpty = function()
			{
				return ((ds_exists(ID, ds_type_priority)) ? ds_priority_empty(ID) : undefined);
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{any} value
			// @argument			{any} priority
			// @argument			{any} ...
			// @description			Add one or more value and priority pair to this Priority Queue.
			static add = function(_value, _priority)
			{
				if (ds_exists(ID, ds_type_priority))
				{
					var _i = 0;
					
					repeat (argument_count / 2)
					{
						ds_priority_add(ID, argument[_i], argument[_i + 1]);
						
						_i += 2;
					}
				}
			}
			
			// @argument			{any} value
			// @description			Remove the specified value from this Priority Queue.
			static remove = function(_value)
			{
				if (ds_exists(ID, ds_type_priority))
				{
					ds_priority_delete_value(ID, _value);
				}
			}
			
			// @argument			{any} value
			// @argument			{any} priority
			// @description			Set the priority of already existing value.
			static setPriority = function(_value, _priority)
			{
				if (ds_exists(ID, ds_type_priority))
				{
					ds_priority_change_priority(ID, _value, _priority);
				}
			}
			
			// @returns				{any|undefined}
			// @description			Remove and return any value with the lowest priority in this 
			//						Priority Queue.
			//						Returns {undefined} if this Priority Queue does not exists or is
			//						empty.
			static removeMin = function()
			{
				if (ds_exists(ID, ds_type_priority) and (ds_priority_size(ID) > 0))
				{
					return ds_priority_delete_min(ID);
				}
				else
				{
					return undefined;
				}
			}
			
			// @returns				{any|undefined}
			// @description			Remove and return any value with the highest priority in this 
			//						Priority Queue.
			//						Returns {undefined} if this Priority Queue does not exists or is
			//						empty.
			static removeMax = function()
			{
				if (ds_exists(ID, ds_type_priority) and (ds_priority_size(ID) > 0))
				{
					return ds_priority_delete_max(ID);
				}
				else
				{
					return undefined;
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Overrides the string conversion with the constructor 
			//						name and content preview.
			static toString = function()
			{
				if (ds_exists(ID, ds_type_priority))
				{
					var _string = (instanceof(self) + "(");
					
					var _separator = ", ";
					var _cutMark = "...";
					var _priorityMark = ": ";
					
					var _separator_length = string_length(_separator);
					var _cutMark_length = string_length(_cutMark);
					
					var _contentLenght = 30;
					var _maximumLenght = (_contentLenght + string_length(_string));
					
					var _dataCopy = ds_priority_create();
					ds_priority_copy(_dataCopy, ID);
					
					var _size = ds_priority_size(_dataCopy);
					var _i = 1;
					
					repeat (_size)
					{
						var _priority = string(ds_priority_find_priority(_dataCopy, 
											   ds_priority_find_max(_dataCopy)));
						
						var _value = string(ds_priority_delete_max(_dataCopy));
						
						_string += (_priority + _priorityMark + _value);
						
						if ((string_length(_string) + _separator_length) < _maximumLenght)
						{
							if (_i < _size)
							{
								_string += _separator;
							}
						}
						else
						{
							ds_priority_destroy(_dataCopy);
							
							return (((_i == _size) and
									string_length(_string) <= _maximumLenght + _cutMark_length)) ?
								   (_string + ")"):
								   (string_copy(_string, 1, _maximumLenght) + _cutMark + ")");
						}
						
						_i++;
					}
					
					ds_priority_destroy(_dataCopy);
					
					return (_string + ")");
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			// @returns				{string}
			// @description			Create a string with constructor name and all of its content.
			static toString_full = function()
			{
				if (ds_exists(ID, ds_type_priority))
				{
					var _string = (instanceof(self) + "(");
					
					var _separator = ", ";
					var _priorityMark = ": ";
					
					var _dataCopy = ds_priority_create();
					ds_priority_copy(_dataCopy, ID);
					
					var _size = ds_priority_size(_dataCopy);
					var _i = 1;
					
					repeat (_size)
					{
						var _priority = string(ds_priority_find_priority(_dataCopy, 
											   ds_priority_find_max(_dataCopy)));
						
						var _value = string(ds_priority_delete_max(_dataCopy));
						
						_string += (_priority + _priorityMark + _value);
						
						if (_i++ < _size)
						{
							_string += _separator;
						}
					}
					
					ds_priority_destroy(_dataCopy);
					
					return (_string + ")");
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			// @argument			{bool} full?
			// @returns				{string}
			// @description			Create a line-broken string with all values of the Data Structure.
			static toString_multiline = function(_full)
			{
				if (ds_exists(ID, ds_type_priority))
				{
					var _string = ((_full) ? self.toString_full() : self.toString());
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
			// @description			Encode all values of this Data Structure into a string,
			//						so it can be later decoded back into that Queue.
			static toEncodedString = function()
			{
				return ((ds_exists(ID, ds_type_priority)) ? ds_priority_write(ID) : 
															string(undefined));
			}
			
			// @argument			{string} string
			// @argument			{bool} legacy?
			// @description			Add Priority Queue values from an encoded string into
			//						this Priority Queue.
			//						Set the "legacy" argument to true if that string was
			//						created in old versions of Game Maker.
			static fromEncodedString = function(_string, _legacy)
			{
				if (_legacy == undefined) {_legacy = false;}
				
				if (!ds_exists(ID, ds_type_priority))
				{
					self.construct();
				}
				
				ds_priority_clear(ID); //|Filler call to prevent the silent application crash.
				
				ds_priority_read(ID, _string);
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		self.construct();
		
	#endregion
}
