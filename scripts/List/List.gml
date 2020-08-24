/// @function				List()
///
/// @description			Constructs a List Data Structure, which stores data in a linear
///							model, offering flexibility while doing so. It easily resized,
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
				//+TODO: Deep data structure scan.
				
				if (ds_exists(ID, ds_type_list))
				{
					ds_list_destroy(ID);
				}
				
				return undefined;
			}
			
			// @description			Remove data from this Data Structure.
			static clear = function()
			{
				if (ds_exists(ID, ds_type_list))
				{
					ds_list_clear(ID);
				}
			}
			
			// @argument			{List} other
			// @description			Replace data of this List with data from another one.
			static copy = function(_other)
			{
				if ((ds_exists(ID, ds_type_list)) and (ds_exists(_other.ID, ds_type_list)))
				{
					ds_list_copy(ID, _other.ID);
				}
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{int}
			// @description			Return the number of values in this Data Structure.
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
			//						Returns {undefined} if this List does not exists or is empty.
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
			
			// @argument			{any} value
			// @returns				{int}
			// @description			Return the position of a specified value or -1 if not present.
			static getFirstIndex = function(_value)
			{
				return ((ds_exists(ID, ds_type_list)) ? ds_list_find_index(ID, _value) : -1);
			}
			
			// @argument			{any} value
			// @returns				{int[]}
			// @description			Return an array populated with all positions of 
			//						the specified value.
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
			// @description			Return the value at the specified position.
			static getValue = function(_position)
			{
				return ((ds_exists(ID, ds_type_list)) ? 
					   ds_list_find_value(ID, _position) : undefined);
			}
			
			// @returns				{bool|undefined}
			// @description			Check if this Data Structure has any values in it.
			//						Returns {undefined} if this Data Structure does not exists.
			static isEmpty = function()
			{
				return ((ds_exists(ID, ds_type_list)) ? ds_list_empty(ID) : undefined);
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{any} ...
			// @description			Add one or more values to this List.
			static add = function()
			{
				if (ds_exists(ID, ds_type_list))
				{
					var _i = 0;
				
					repeat (argument_count)
					{
						ds_list_add(ID, argument[_i++]);
					}
				}
			}
			
			// @argument			{int} position
			// @argument			{any} value
			// @description			Set a specified position of the List to provided value
			//						and any empty places before it to 0.
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
			
			// @argument			{bool} multiline
			// @argument			{int|all} elementNumber
			// @argument			{int|all} elementLength
			// @argument			{string|undefined} mark_separator
			// @argument			{string|undefined} mark_cut
			// @argument			{string|undefined} mark_elementStart
			// @argument			{string|undefined} mark_elementEnd
			// @returns				{string}
			// @description			Create a string representing the constructor.
			//						Overrides the string() conversion.
			static toString = function(_multiline, _elementNumber, _elementLength, _mark_separator,
									   _mark_cut, _mark_elementStart, _mark_elementEnd)
			{
				if (ds_exists(ID, ds_type_list))
				{
					//|General initialization.
					var _size = ds_list_size(ID);
					
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
					
					var _mark_separator_length = string_length(_mark_separator);
					var _mark_cut_length = string_length(_mark_cut);
					var _mark_linebreak = (_multiline ? "\n" : "");
					
					var _string = ((_multiline) ? "" : (instanceof(self) + "("));
					
					var _string_lengthLimit = (string_length(_string) + _elementLength);
					var _string_lengthLimit_cut = (_string_lengthLimit + _mark_cut_length);
					
					//|Content loop.
					var _i = 0;
					
					repeat (min(_size, _elementNumber))
					{
						//|Get Data Structure Element.
						var _newElement = string(ID[|_i]);
						
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
									//|If the current element is last, cut it if it would be too long,
									// but expand the length check by the length of the cut mark.
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
						
						_i++;
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
			
			// @returns				{string}
			// @description			Return an encoded string of this Data Structure,
			//						which can later be decoded to recreate it.
			static toEncodedString = function()
			{
				return ((ds_exists(ID, ds_type_list)) ? ds_list_write(ID) : string(undefined));
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
