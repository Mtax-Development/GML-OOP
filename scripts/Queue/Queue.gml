/// @function				Queue()
///
/// @description			Constructs a Queue Data Structure, which stores data in a linear,
///							first-in-first-out (FIFO) model that disallows order manipulation.
///
///							Construction methods:
///							- New constructor
///							- Constructor copy: {Queue} other
function Queue() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction method: New constructor.
				ID = ds_queue_create();
				
				if ((argument_count > 0) and (instanceof(argument[0]) == "Queue"))
				{
					//|Construction method: Constructor copy.
					var _other = argument[0];
					
					ds_queue_copy(ID, _other.ID);
				}
			}
			
			// @argument			{bool} deepScan?
			// @returns				{undefined}
			// @description			Remove the internal information from the memory.
			//						A deep scan can be performed before the removal, which will 
			//						iterate through this and all other Data Structures contained
			//						in it to destroy them as well.
			static destroy = function(_deepScan)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_queue)))
				{
					if (_deepScan)
					{
						repeat (ds_queue_size(ID))
						{
							var _value = ds_queue_dequeue(ID);
							
							if (is_struct(_value))
							{
								switch (instanceof(_value))
								{
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
					
					ds_queue_destroy(ID);
				}
				
				return undefined;
			}
			
			// @description			Remove data from this Data Structure.
			static clear = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_queue)))
				{
					ds_queue_clear(ID);
				}
			}
			
			// @argument			{Queue} other
			// @description			Replace data of this Queue with data from another one.
			static copy = function(_other)
			{
				if ((instanceof(_other) == "Queue") and (is_real(_other.ID)) and 
				(ds_exists(_other.ID, ds_type_queue)))
				{
					if ((!is_real(ID)) or (!ds_exists(ID, ds_type_queue)))
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
				return (((is_real(ID)) and (ds_exists(ID, ds_type_queue))) ? ds_queue_size(ID) : 0);
			}
			
			// @returns				{any|undefined}
			// @description			Return the head value of this Queue, which is the one that
			//						would be removed first.
			//						Returns {undefined} if this Queue does not exists or is empty.
			static getFirst = function()
			{
				return (((is_real(ID)) and (ds_exists(ID, ds_type_queue))) ? 
					   ds_queue_head(ID) : undefined);
			}
			
			// @returns				{any|undefined}
			// @description			Return the tail value of this Queue, which is the one that
			//						would be removed last.
			//						Returns {undefined} if this Queue does not exists or is empty.
			static getLast = function()
			{
				return (((is_real(ID)) and (ds_exists(ID, ds_type_queue))) ? 
					   ds_queue_tail(ID) : undefined);
			}
			
			// @returns				{bool|undefined}
			// @description			Check if this Data Structure has any values in it.
			//						Returns {undefined} if this Data Structure does not exists.
			static isEmpty = function()
			{
				return (((is_real(ID)) and (ds_exists(ID, ds_type_queue))) ? 
					   ds_queue_empty(ID) : undefined);
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{function} function
			// @argument			{bool} readOnly
			// @description			Execute a provided function once for each Data Structure element.
			//						The Data Structure can be treated as read-only for this operation,
			//						in which case it will not be modified in order to read its values.
			//						The provided function can read variables provided by it, either
			//						by requiring the same named arguments or via the argument array.
			//						The provided variables are:
			//						- argument[0]: {int} _i
			//						- argument[1]: {any} _value
			static forEach = function(__function, _readOnly)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_queue)))
				{
					var _size = ds_queue_size(ID);
					
					if (_size > 0)
					{
						var _queue = ID;
					
						if (_readOnly)
						{
							var _dataCopy = ds_queue_create();
							ds_queue_copy(_dataCopy, ID);
						
							_queue = _dataCopy;
						}
					
						var _i = 0;
					
						repeat (_size)
						{
							var _value = ds_queue_dequeue(_queue);
						
							__function(_i, _value);
						
							++_i;
						}
					
						if (_readOnly)
						{
							ds_queue_destroy(_dataCopy);
						}
					}
				}
			}
			
			// @argument			{any} ...
			// @description			Add one or more values at the tail of this Queue.
			static add = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_queue)))
				{
					var _i = 0;
		
					repeat (argument_count)
					{
						ds_queue_enqueue(ID, argument[_i]);
						
						++_i;
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
				if ((is_real(ID)) and (ds_exists(ID, ds_type_queue)))
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
								_values[_i] = ds_queue_dequeue(ID);
								
								++_i;
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
				if ((is_real(ID)) and (ds_exists(ID, ds_type_queue)))
				{
					//|General initialization.
					var _size = ds_queue_size(ID);
					
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
					
					//|Data Structure preparation.
					var _dataCopy = ds_queue_create();
					ds_queue_copy(_dataCopy, ID);
					
					//|Content loop.
					var _i = 0;
					
					repeat (min(_size, _elementNumber))
					{
						//|Get Data Structure Element.
						var _newElement = string(ds_queue_dequeue(_dataCopy));
						
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
					
					//|Data structure clean-up.
					ds_queue_destroy(_dataCopy);
					
					return _string;
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			// @returns				{any[]}
			// @description			Create an array with all values of this Queue.
			static toArray = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_queue)))
				{
					var _size = ds_queue_size(ID);
					
					if (_size > 0)
					{
						var _dataCopy = ds_queue_create();
						ds_queue_copy(_dataCopy, ID);
						
						var _array = array_create(_size, undefined);
						
						var _i = 0;
						
						repeat (_size)
						{
							_array[_i] = ds_queue_dequeue(_dataCopy);
							
							++_i;
						}
						
						ds_queue_destroy(_dataCopy);
						
						return _array;
					}
				}
				
				return [];
			}
			
			// @argument			{any[]} array
			// @argument			{bool} startFromEnd?
			// @description			Add values from the specified array to this Queue, starting
			//						from either the start of the array or its end.
			static fromArray = function(_array, _startFromEnd)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_queue)))
				{
					if (is_array(_array))
					{
						var _size = array_length(_array);
						
						var _i = ((_startFromEnd) ? (_size - 1) : 0);
						
						repeat (_size)
						{
							ds_queue_enqueue(ID, _array[_i]);
							
							if (_startFromEnd)
							{
								--_i;
							}
							else
							{
								++_i;
							}
						}
					}
				}
			}
			
			// @returns				{string}
			// @description			Return an encoded string of this Data Structure,
			//						which can later be decoded to recreate it.
			static toEncodedString = function()
			{
				return (((is_real(ID)) and (ds_exists(ID, ds_type_queue))) ? 
					   ds_queue_write(ID) : string(undefined));
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
				
				if ((!is_real(ID)) or (!ds_exists(ID, ds_type_queue)))
				{
					self.construct();
				}
				
				ds_queue_read(ID, _string, _legacy);
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		argument_original = array_create(argument_count, undefined);
		
		var _i = 0;
		repeat (argument_count)
		{
			argument_original[_i] = argument[_i];
			
			++_i;
		}
		
		if (argument_count <= 0)
		{
			self.construct();
		}
		else
		{
			script_execute_ext(method_get_index(self.construct), argument_original);
		}
		
	#endregion
}
