/// @function				Queue()
///
/// @description			Constructs a Queue Data Structure, which stores data in a linnear,
///							first-in-first-out (FIFO) model that disallows order manipulation.
function Queue() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				ID = ds_queue_create();
			}
			
			// @returns				{undefined}
			// @description			Remove the internal information from the memory.
			static destroy = function()
			{
				//+TODO: Deep data structure scan.
				
				if (ds_exists(ID, ds_type_queue))
				{
					ds_queue_destroy(ID);
				}
				
				return undefined;
			}
			
			// @description			Remove all data from this Queue.
			static clear = function()
			{
				if (ds_exists(ID, ds_type_queue))
				{
					ds_queue_clear(ID);
				}
			}
			
			// @description			Replace all data of this Queue with data from another one.
			static copy = function(_other)
			{
				if (ds_exists(_other.ID, ds_type_queue))
				{
					if (!ds_exists(ID, ds_type_queue))
					{
						self.construct();
					}
		
					ds_queue_copy(ID, _other.ID);
				}
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{int}
			// @description			Return the number of values in this Queue.
			static getSize = function()
			{
				return ((ds_exists(ID, ds_type_queue)) ? ds_queue_size(ID) : 0);
			}
			
			// @returns				{any|undefined}
			// @description			Return the head value of this Queue, which is the one that
			//						would be removed first.
			//						Returns {undefined} if this Queue does not exists or is empty.
			static getFirst = function()
			{
				return ((ds_exists(ID, ds_type_queue)) ? ds_queue_head(ID) : 0);
			}
			
			// @returns				{any|undefined}
			// @description			Return the tail value of this Queue, which is the one that
			//						would be removed last.
			//						Returns {undefined} if this Queue does not exists or is empty.
			static getLast = function()
			{
				return ((ds_exists(ID, ds_type_queue)) ? ds_queue_tail(ID) : 0);
			}
			
			// @returns				{bool|undefined}
			// @description			Check if this Queue has any values in it.
			static isEmpty = function()
			{
				return ((ds_exists(ID, ds_type_queue)) ? ds_queue_empty(ID) : undefined);
			}
			
		#endregion
		#region <Execution>
			
			// @description			Add a one or more values at the tail of this Queue.
			static add = function()
			{
				if (ds_exists(ID, ds_type_queue))
				{
					var _i = 0;
		
					repeat(argument_count)
					{
						ds_queue_enqueue(ID, argument[_i++]);
					}
				}
			}
			
			// @argument			{int} number?
			// @returns				{any|any[]|undefined}
			// @description			Remove any number of values from the Queue and
			//						return them. If more than one value are to be 
			//						removed, they will be returned as an array.
			static remove = function(_number)
			{
				if (ds_exists(ID, ds_type_queue))
				{
					var _size = ds_queue_size(ID);
					
					if (_size <= 0)
					{
						return undefined;
					}
					else
					{
						if (_number == undefined) {_number = 1;}
						
						if (_number == 1)
						{
							return ds_queue_dequeue(ID);
						}
						else
						{
							var _values = array_create(clamp(_number, 0, _size), 
														undefined);
						
							var _i = 0;
						
							repeat (array_length(_values))
							{
								_values[_i++] = ds_queue_dequeue(ID);
							}
						
							return _values;
						}
					}
				}
				else
				{
					return undefined;
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Overrides the string conversion with the content preview.
			static toString = function()
			{
				var _string = (instanceof(self) + "(");
				
				var _separator = ", ";
				var _separator_length = string_length(_separator);
				
				var _contentLenght = 30;
				var _maximumLenght = (_contentLenght + string_length(_string));
				
				var _queueCopy = ds_queue_create();
				ds_queue_copy(_queueCopy, ID);
				
				var _size = ds_queue_size(_queueCopy);
				var _i = 0;
				
				repeat (_size - 1)
				{
					_string += string(ds_queue_dequeue(_queueCopy));
					
					if ((string_length(_string) + _separator_length) < _maximumLenght)
					{
						if (_i < _size)
						{
							_string += _separator;
						}
					}
					else
					{
						ds_queue_destroy(_queueCopy);
						
						return (string_copy(_string, 1, _maximumLenght) + "...)");
					}
				}
				
				if (_size > 0)
				{
					_string += string(ds_queue_dequeue(_queueCopy));
				}
				
				ds_queue_destroy(_queueCopy);
				
				return (_string + ")");
			}
			
			// @returns				{string}
			// @description			Create a string with constructor name and all of its content.
			static toString_full = function()
			{
				var _string = (instanceof(self) + "(");
				
				var _separator = ", ";
				
				var _queueCopy = ds_queue_create();
				ds_queue_copy(_queueCopy, ID);
				
				var _size = ds_queue_size(_queueCopy);
				
				repeat (_size - 1)
				{
					_string += (string(ds_queue_dequeue(_queueCopy)) + _separator);
				}
				
				if (_size > 0)
				{
					_string += string(ds_queue_dequeue(_queueCopy));
				}
				
				ds_queue_destroy(_queueCopy);
				
				return (_string + ")");
			}
			
			// @argument			{bool} full?
			// @returns				{string}
			// @description			Create a line-broken string with all values of the Queue.
			static toString_multiline = function(_full)
			{
				var _string = ((_full) ? self.toString_full() : self.toString());
				_string = string_replace_all(_string, (instanceof(self) + "("), "");
				_string = string_replace_all(_string, ", ", "\n");
				_string = string_copy(_string, 1, (string_length(_string) - 1));
				
				return _string;
			}
			
			// @argument			{string} string
			// @argument			{bool} legacy?
			// @description			Add Queue values from an encoded string into this Queue.
			//						Set the "legacy" argument to true if that string was
			//						created in old versions of Game Maker.
			static fromEncodedString = function(_string, _legacy)
			{
				if (_legacy == undefined) {_legacy = false;}
				
				if (!ds_exists(ID, ds_type_queue))
				{
					self.construct();
				}
				
				ds_queue_read(ID, _string, _legacy);
			}
			
			// @returns				{string}
			// @description			Encode all values of this Queue into a string, so it
			//						can be later decoded back into that Queue.
			static toEncodedString = function()
			{
				return ((ds_exists(ID, ds_type_queue)) ? ds_queue_write(ID) : string(undefined));
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		self.construct();
		
	#endregion
}
