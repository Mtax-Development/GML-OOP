//  @function				List()
/// @description			Constructs a List Data Structure, which stores data in a linear model,
///							offering flexibility while doing so. It is easily resized, sorted and
///							manipulated in other ways.
//							
//							Construction types:
//							- New constructor
//							- Wrapper: {int:list} list
//							- Empty: {undefined}
//							- Constructor copy: {List} other
function List() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				ID = undefined;
				
				if (argument_count > 0)
				{
					if (argument[0] != undefined)
					{
						if (is_instanceof(argument[0], List))
						{
							//|Construction type: Constructor copy.
							self.copy(argument[0]);
						}
						else if (is_handle(argument[0]))
						{
							//|Construction type: Wrapper.
							ID = argument[0];
						}
					}
				}
				else
				{
					//|Construction type: New constructor.
					ID = ds_list_create();
					ds_list_clear(ID);
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_handle(ID)) and (ds_exists(ID, ds_type_list)));
			}
			
			/// @argument			deepScan? {bool}
			/// @returns			{undefined}
			/// @description		Remove the internal information from the memory.
			///						A deep scan can be performed before the removal, which will 
			///						iterate through this and all other Data Structures contained
			///						in it to destroy them as well.
			static destroy = function(_deepScan = false)
			{
				if (self.isFunctional())
				{
					if (_deepScan)
					{
						var _i = 0;
						repeat (ds_list_size(ID))
						{
							var _value = ds_list_find_value(ID, _i);
							
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
							
							++_i;
						}
					}
					
					ds_list_destroy(ID);
					
					ID = undefined;
				}
				
				return undefined;
			}
			
			/// @description		Remove data from this Data Structure.
			static clear = function()
			{
				if (!self.isFunctional())
				{
					ID = ds_list_create();
				}
				
				ds_list_clear(ID);
				
				return self;
			}
			
			/// @argument			other {List}
			/// @description		Replace data of this List with data from another one.
			static copy = function(_other)
			{
				if ((is_instanceof(_other, List)) and (_other.isFunctional()))
				{
					if (!self.isFunctional())
					{
						ID = ds_list_create();
						ds_list_clear(ID);
					}
					
					ds_list_copy(ID, _other.ID);
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
			
			/// @argument			value {any}
			/// @returns			{bool}
			/// @description		Check if this Data Structure contains at least one of the
			///						specified values.
			static contains = function()
			{
				try
				{
					var _size = ds_list_size(ID);
					var _i = [0, 0];
					repeat (_size)
					{
						_i[1] = 0;
						repeat (argument_count)
						{
							if (ds_list_find_value(ID, _i[0]) == argument[_i[1]])
							{
								return true;
							}
							
							++_i[1];
						}
						
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
			/// @returns			{int}
			/// @description		Return the number of times the specified values occur in this Data
			///						Structure.
			static count = function()
			{
				try
				{
					var _result = 0;
					var _size = ds_list_size(ID);
					var _i = [0, 0];
					repeat (_size)
					{
						var _value = ds_list_find_value(ID, _i[0]);
						
						_i[1] = 0;
						repeat (argument_count)
						{
							if (_value == argument[_i[1]])
							{
								++_result;
							}
							
							++_i[1];
						}
						
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
			
			/// @argument			position {int}
			/// @returns			{any|undefined}
			/// @description		Return the value at the specified position.
			///						Returns {undefined} if this List or the value does not exists.
			static getValue = function(_position)
			{
				try
				{
					return ds_list_find_value(ID, _position);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getValue()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{any|undefined}
			/// @description		Return the first value in this List.
			///						Returns {undefined} if this List does not exists or is empty.
			static getFirst = function()
			{
				try
				{
					return ds_list_find_value(ID, 0);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getFirst()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{any|undefined}
			/// @description		Return the last value in this List.
			///						Returns {undefined} if this List does not exists or is empty.
			static getLast = function()
			{
				try
				{
					return ds_list_find_value(ID, (ds_list_size(ID) - 1));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getLast()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			value {any}
			/// @returns			{int}
			/// @description		Return the first found position of the specified value or -1 if
			///						the value does not exist.
			static getFirstPosition = function(_value)
			{
				try
				{
					return ds_list_find_index(ID, _value);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getFirstPosition()"], _exception);
				}
				
				return -1;
			}
			
			/// @argument			value {any}
			/// @returns			{int[]}
			/// @description		Return an array with all positions of the specified value.
			static getPositions = function(_value)
			{
				try
				{
					var _position = [];
					var _i = 0;
					repeat (ds_list_size(ID))
					{
						if (ds_list_find_value(ID, _i) == _value)
						{
							array_push(_position, _i);
						}
						
						++_i;
					}
					
					return _position;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getPosition()"], _exception);
				}
				
				return [];
			}
			
			/// @returns			{int}
			/// @description		Return the number of values in this Data Structure.
			static getSize = function()
			{
				try
				{
					return ds_list_size(ID);
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
					return ds_list_empty(ID);
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
			///						- argument[1]: _value {any}
			///						- argument[2]: _argument {any}
			static forEach = function(__function, _argument)
			{
				var _dataCopy = ds_list_create();
				
				try
				{
					ds_list_clear(_dataCopy);
					ds_list_copy(_dataCopy, ID);
					var _size = ds_list_size(ID);
					var _functionReturn = [];
					var _i = 0;
					repeat (_size)
					{
						var _value = ds_list_find_value(_dataCopy, _i);
						
						try
						{
							array_push(_functionReturn, __function(_i, _value, _argument));
						}
						catch (_exception)
						{
							new ErrorReport().report([other, self, "forEach()", "function()"],
													 _exception);
						}
						
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
					ds_list_destroy(_dataCopy);
				}
				
				return [];
			}
			
			/// @argument			value... {any}
			/// @description		Add one or more values to this List.
			static add = function()
			{
				try
				{
					var _i = 0;
					repeat (argument_count)
					{
						var _value = argument[_i];
						
						ds_list_add(ID, _value);
						
						++_i;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "add()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			position {int}
			/// @argument			value {any}
			/// @description		Set a specified position of this List to the specified value and
			///						any empty places before it to 0.
			static set = function(_position, _value)
			{
				try
				{
					ds_list_set(ID, _position, _value);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "set()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			position {int}
			/// @argument			value {any}
			/// @description		Set a specified position of the List to the specified value, but
			///						only if it already exists.
			static replace = function(_position, _value)
			{
				try
				{
					ds_list_replace(ID, _position, _value);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "replace()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			position {int}
			/// @description		Remove a value at a specified position from the List and push the
			///						positions of all values after it back by one.
			static removePosition = function(_position)
			{
				try
				{
					ds_list_delete(ID, _position);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "removePosition()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {any}
			/// @description		Remove the specified value from all positions in the List and push
			///						the position of all values after them back by one.
			static removeValue = function(_value)
			{
				try
				{
					var _i = 0;
					repeat (ds_list_size(ID))
					{
						if (ds_list_find_value(ID, _i) == _value)
						{
							ds_list_delete(ID, _i);
						}
						else
						{
							++_i;
						}
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "removeValue()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			position {int}
			/// @argument			value {any}
			/// @description		Add a value at a specified position to the List and push
			///						the position of all values after it forward by one.
			static insert = function(_position, _value)
			{
				try
				{
					ds_list_insert(ID, _position, _value);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "insert()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			orderAscending {bool}
			/// @description		Sort all values in the List in ascending or descending order.
			///						Numbers will be placed before the strings.
			static sort = function(_orderAscending)
			{
				try
				{
					ds_list_sort(ID, _orderAscending);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "sort()"], _exception);
				}
				
				return self;
			}
			
			/// @description		Randomize the position of all values in the List.
			static shuffle = function()
			{
				try
				{
					ds_list_shuffle(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "shuffle()"], _exception);
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
			/// @argument			mark_sizeSeparator? {string}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented by the data of this Data Structure.
			static toString = function(_multiline = false, _elementNumber = 10, _elementLength = 30,
									   _mark_separator = ", ", _mark_cut = "...",
									   _mark_elementStart = "", _mark_elementEnd = "",
									   _mark_sizeSeparator = " - ")
			{
				if (self.isFunctional())
				{
					//|General initialization.
					var _size = ds_list_size(ID);
					
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
						//|Get Data Structure Element.
						var _newElement = string(ds_list_find_value(ID, _i));
						
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
			/// @description		Create an array with all values of this List.
			static toArray = function()
			{
				try
				{
					var _size = ds_list_size(ID);
					var _array = array_create(_size, undefined);
					var _i = 0;
					repeat (_size)
					{
						_array[_i] = ds_list_find_value(ID, _i);
						
						++_i;
					}
					
					return _array;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "toArray()"], _exception);
				}
				
				return [];
			}
			
			/// @argument			array {any[]}
			/// @description		Add all values from the specified array dimension to this List.
			static fromArray = function(_array)
			{
				if (is_array(_array))
				{
					if (!self.isFunctional())
					{
						ID = ds_list_create();
						ds_list_clear(ID);
					}
					
					var _i = 0;
					repeat (array_length(_array))
					{
						ds_list_add(ID, _array[_i]);
						
						++_i;
					}
				}
				else
				{
					new ErrorReport().report([other, self, "fromArray()"],
											 ("Attempted to read an invalid array: " +
											  "{" + string(_array) + "}"));
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
					return ds_list_write(ID);
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
					if (!self.isFunctional())
					{
						ID = ds_list_create();
						ds_list_clear(ID);
					}
					
					ds_list_read(ID, _string, _legacy);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "fromEncodedString()"], _exception);
				}
				
				return self;
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static constructor = List;
		
		static prototype = {};
		var _property = variable_struct_get_names(prototype);
		var _i = 0;
		repeat (array_length(_property))
		{
			var _name = _property[_i];
			var _value = variable_struct_get(prototype, _name);
			
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
