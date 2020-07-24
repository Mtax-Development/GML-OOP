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
			
			// @description			Remove all data from this Stack.
			static clear = function()
			{
				if (ds_exists(ID, ds_type_stack))
				{
					ds_stack_clear(ID);
				}
			}
			
			// @description			Replace all data of this Stack with data from another one.
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
			// @description			Return the number of values in this Stack.
			static getSize = function()
			{
				return ((ds_exists(ID, ds_type_stack)) ? ds_stack_size(ID) : 0);
			}
			
			// @returns				{any|undefined}
			// @description			Return the top value of this Stack, which is the one that
			//						would be removed first.
			//						Returns {undefined} if this Stack does not exists or is empty.
			static getTop = function()
			{
				return ((ds_exists(ID, ds_type_stack)) ? ds_stack_top(ID) : 0);
			}
			
			// @returns				{bool|undefined}
			// @description			Check if this Stack has any values in it.
			static isEmpty = function()
			{
				return ((ds_exists(ID, ds_type_stack)) ? ds_stack_empty(ID) : undefined);
			}
			
		#endregion
		#region <Execution>
			
			// @description			Add a one or more values at the top of this Stack.
			static add = function()
			{
				if (ds_exists(ID, ds_type_stack))
				{
					var _i = 0;
		
					repeat(argument_count)
					{
						ds_stack_push(ID, argument[_i++]);
					}
				}
			}
			
			// @argument			{int} number
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
			// @description			Overrides the string conversion with the content preview.
			static toString = function()
			{
				var _string = (instanceof(self) + "(");
				
				var _separator = ", ";
				var _separator_length = string_length(_separator);
				
				var _contentLenght = 30;
				var _maximumLenght = (_contentLenght + string_length(_string));
				
				var _stackCopy = ds_stack_create();
				ds_stack_copy(_stackCopy, ID);
				
				var _size = ds_stack_size(_stackCopy);
				var _i = 0;
				
				repeat (_size - 1)
				{
					_string += string(ds_stack_pop(_stackCopy));
					
					if ((string_length(_string) + _separator_length) < _maximumLenght)
					{
						if (_i < _size)
						{
							_string += _separator;
						}
					}
					else
					{
						ds_stack_destroy(_stackCopy);
						
						return (string_copy(_string, 1, _maximumLenght) + "...)");
					}
				}
				
				if (_size > 0)
				{
					_string += string(ds_stack_pop(_stackCopy));
				}
				
				ds_stack_destroy(_stackCopy);
				
				return (_string + ")");
			}
			
			// @returns				{string}
			// @description			Create a string with constructor name and all of its content.
			static toString_full = function()
			{
				var _string = (instanceof(self) + "(");
				
				var _separator = ", ";
				
				var _stackCopy = ds_stack_create();
				ds_stack_copy(_stackCopy, ID);
				
				var _size = ds_stack_size(_stackCopy);
				var _i = 0;
				
				repeat (_size - 1)
				{
					_string += (string(ds_stack_pop(_stackCopy)) + _separator);
				}
				
				if (_size > 0)
				{
					_string += string(ds_stack_pop(_stackCopy));
				}
				
				ds_stack_destroy(_stackCopy);
				
				return (_string + ")");
			}
			
			// @argument			{bool} full?
			// @returns				{string}
			// @description			Create a line-broken string with all values of the Stack.
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
			// @description			Add Stack values from an encoded string into this Stack.
			//						Set the "legacy" argument to true if that string was
			//						created in old versions of Game Maker.
			static fromEncodedString = function(_string, _legacy)
			{
				if (_legacy == undefined) {_legacy = false;}
				
				if (!ds_exists(ID, ds_type_stack))
				{
					self.construct();
				}
				
				ds_stack_read(ID, _string, _legacy);
			}
			
			// @returns				{string}
			// @description			Encode all values of this Stack into a string, so it
			//						can be later decoded back into that Stack.
			static toEncodedString = function()
			{
				return ((ds_exists(ID, ds_type_stack)) ? ds_stack_write(ID) : string(undefined));
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		self.construct();
		
	#endregion
}
