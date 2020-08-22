/// @function				Queue()
///
/// @description			Constructs a Queue Data Structure, which stores data in a linear,
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
			
			// @description			Remove data from this Data Structure.
			static clear = function()
			{
				if (ds_exists(ID, ds_type_queue))
				{
					ds_queue_clear(ID);
				}
			}
			
			// @argument			{Queue} other
			// @description			Replace data of this Queue with data from another one.
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
			// @description			Return the number of values in this Data Structure.
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
				return ((ds_exists(ID, ds_type_queue)) ? ds_queue_head(ID) : undefined);
			}
			
			// @returns				{any|undefined}
			// @description			Return the tail value of this Queue, which is the one that
			//						would be removed last.
			//						Returns {undefined} if this Queue does not exists or is empty.
			static getLast = function()
			{
				return ((ds_exists(ID, ds_type_queue)) ? ds_queue_tail(ID) : undefined);
			}
			
			// @returns				{bool|undefined}
			// @description			Check if this Data Structure has any values in it.
			//						Returns {undefined} if this Data Structure does not exists.
			static isEmpty = function()
			{
				return ((ds_exists(ID, ds_type_queue)) ? ds_queue_empty(ID) : undefined);
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{any} ...
			// @description			Add one or more values at the tail of this Queue.
			static add = function()
			{
				if (ds_exists(ID, ds_type_queue))
				{
					var _i = 0;
		
					repeat (argument_count)
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
			// @description			Overrides the string conversion with the constructor name and
			//						main content preview.
			static toString = function()
			{
				if (ds_exists(ID, ds_type_queue))
				{
					var _string = (instanceof(self) + "(");
				
					var _separator = ", ";
					var _cutMark = "...";
					
					var _separator_length = string_length(_separator);
					var _cutMark_length = string_length(_cutMark);
				
					var _contentLength = 30;
					var _maximumLength = (_contentLength + string_length(_string));
				
					var _dataCopy = ds_queue_create();
					ds_queue_copy(_dataCopy, ID);
				
					var _size = ds_queue_size(_dataCopy);
					var _i = 1;
				
					repeat (_size)
					{
						_string += string(ds_queue_dequeue(_dataCopy));
					
						if ((string_length(_string) + _separator_length) < _maximumLength)
						{
							if (_i < _size)
							{
								_string += _separator;
							}
						}
						else
						{
							ds_queue_destroy(_dataCopy);
							
							_string = string_replace_all(_string, "\n", " ");
							_string = string_replace_all(_string, "\r", " ");
						
							return (((_i == _size) and
									string_length(_string) <= (_maximumLength + _cutMark_length))) ?
								   (_string + ")") :
								   (string_copy(_string, 1, _maximumLength) + _cutMark + ")");
						}
						
						_i++;
					}
				
					ds_queue_destroy(_dataCopy);
					
					_string = string_replace_all(_string, "\n", " ");
					_string = string_replace_all(_string, "\r", " ");
				
					return (_string + ")");
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			// @returns				{string}
			// @description			Return a string with constructor name and its main content.
			static toString_full = function()
			{
				if (ds_exists(ID, ds_type_queue))
				{
					var _string = (instanceof(self) + "(");
				
					var _separator = ", ";
				
					var _dataCopy = ds_queue_create();
					ds_queue_copy(_dataCopy, ID);
				
					var _size = ds_queue_size(_dataCopy);
					
					var _i = 1;
				
					repeat (_size)
					{
						_string += (string(ds_queue_dequeue(_dataCopy)));
						
						if (_i++ < _size)
						{
							_string += _separator;
						}
					}
				
					ds_queue_destroy(_dataCopy);
					
					_string = string_replace_all(_string, "\n", " ");
					_string = string_replace_all(_string, "\r", " ");
				
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
				if (ds_exists(ID, ds_type_queue))
				{
					var _string = ((_full) ? self.toString() : self.toString_full());
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
				return ((ds_exists(ID, ds_type_queue)) ? ds_queue_write(ID) : string(undefined));
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
				
				if (!ds_exists(ID, ds_type_queue))
				{
					self.construct();
				}
				
				ds_queue_read(ID, _string, _legacy);
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		self.construct();
		
	#endregion
}
