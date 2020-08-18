/// @function				Stack()
///
/// @description			Constructs a Stack Data Structure, which stores data in a linear,
///							last-in-first-out (LIFO) model that disallows order manipulation.
function Stack() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				ID = ds_stack_create();
			}
			
			// @returns				{undefined}
			// @description			Remove the internal information from the memory.
			static destroy = function()
			{
				//+TODO: Deep data structure scan.
		
				if (ds_exists(ID, ds_type_stack))
				{
					ds_stack_destroy(ID);
				}
		
				return undefined;
			}
			
			// @description			Remove data from this Data Structure.
			static clear = function()
			{
				if (ds_exists(ID, ds_type_stack))
				{
					ds_stack_clear(ID);
				}
			}
			
			// @argument			{Stack} other
			// @description			Replace data of this Stack with data from another one.
			static copy = function(_other)
			{
				if (ds_exists(_other.ID, ds_type_stack))
				{
					if (!ds_exists(ID, ds_type_stack))
					{
						self.construct();
					}
		
					ds_stack_copy(ID, _other.ID);
				}
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{int}
			// @description			Return the number of values in this Data Structure.
			static getSize = function()
			{
				return ((ds_exists(ID, ds_type_stack)) ? ds_stack_size(ID) : 0);
			}
			
			// @returns				{any|undefined}
			// @description			Return the top value of this Stack, which is the one that
			//						would be removed first.
			//						Returns {undefined} if this Stack does not exists or is empty.
			static getFirst = function()
			{
				return ((ds_exists(ID, ds_type_stack)) ? ds_stack_top(ID) : undefined);
			}
			
			// @returns				{bool|undefined}
			// @description			Check if this Data Structure has any values in it.
			//						Returns {undefined} if this Data Structure does not exists.
			static isEmpty = function()
			{
				return ((ds_exists(ID, ds_type_stack)) ? ds_stack_empty(ID) : undefined);
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{any} ...
			// @description			Add one or more values at the top of this Stack.
			static add = function()
			{
				if (ds_exists(ID, ds_type_stack))
				{
					var _i = 0;
		
					repeat (argument_count)
					{
						ds_stack_push(ID, argument[_i++]);
					}
				}
			}
			
			// @argument			{int} number?
			// @returns				{any|any[]|undefined}
			// @description			Remove any number of values from the Stack and
			//						return them. If more than one value are to be 
			//						removed, they will be returned as an array.
			static remove = function(_number)
			{
				if (ds_exists(ID, ds_type_stack))
				{
					var _size = ds_stack_size(ID);
					
					if (_size <= 0)
					{
						return undefined;
					}
					else
					{
						if (_number == undefined) {_number = 1;}
						
						if (_number == 1)
						{
							return ds_stack_pop(ID);
						}
						else
						{
							var _values = array_create(clamp(_number, 0, _size), 
													   undefined);
						
							var _i = 0;
						
							repeat (array_length(_values))
							{
								_values[_i++] = ds_stack_pop(ID);
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
			// @description			Overrides the string conversion with the constructor 
			//						name and preview of the content.
			static toString = function()
			{
				if (ds_exists(ID, ds_type_stack))
				{
					var _string = (instanceof(self) + "(");
				
					var _separator = ", ";
					var _cutMark = "...";
					
					var _separator_length = string_length(_separator);
					var _cutMark_length = string_length(_cutMark);
				
					var _contentLength = 30;
					var _maximumLength = (_contentLength + string_length(_string));
				
					var _dataCopy = ds_stack_create();
					ds_stack_copy(_dataCopy, ID);
				
					var _size = ds_stack_size(_dataCopy);
					var _i = 1;
				
					repeat (_size)
					{
						_string += string(ds_stack_pop(_dataCopy));
					
						if ((string_length(_string) + _separator_length) < _maximumLength)
						{
							if (_i < _size)
							{
								_string += _separator;
							}
						}
						else
						{
							ds_stack_destroy(_dataCopy);
						
							return (((_i == _size) and
									string_length(_string) <= _maximumLength + _cutMark_length)) ?
								   (_string + ")"):
								   (string_copy(_string, 1, _maximumLength) + _cutMark + ")");
						}
						
						_i++;
					}
				
					ds_stack_destroy(_dataCopy);
				
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
				if (ds_exists(ID, ds_type_stack))
				{
					var _string = (instanceof(self) + "(");
				
					var _separator = ", ";
				
					var _dataCopy = ds_stack_create();
					ds_stack_copy(_dataCopy, ID);
				
					var _size = ds_stack_size(_dataCopy);
					
					var _i = 1;
					
					repeat (_size)
					{
						_string += string(ds_stack_pop(_dataCopy));
						
						if (_i++ < _size)
						{
							_string += _separator;
						}
					}
					
					ds_stack_destroy(_dataCopy);
				
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
				if (ds_exists(ID, ds_type_stack))
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
				return ((ds_exists(ID, ds_type_stack)) ? ds_stack_write(ID) : string(undefined));
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
				
				if (!ds_exists(ID, ds_type_stack))
				{
					self.construct();
				}
				
				ds_stack_read(ID, _string, _legacy);
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		self.construct();
		
	#endregion
}
