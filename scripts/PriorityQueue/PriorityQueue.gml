/// @function				PriorityQueue()
///
/// @description			Constructs a Priority Queue Data Structure, which stores data in
///							a linear model that orders the values based on their priority.
function PriorityQueue() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				ID = ds_priority_create();
			}
			
			// @argument			{bool} deepScan?
			// @returns				{undefined}
			// @description			Remove the internal information from the memory.
			//						A deep scan can be performed before the removal, which will 
			//						iterate through this and all other Data Structures contained
			//						in it to destroy them as well.
			static destroy = function(_deepScan)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					if (_deepScan)
					{
						repeat (ds_priority_size(ID))
						{
							var _value = ds_priority_delete_max(ID);
							
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
					
					ds_priority_destroy(ID);
				}
				
				return undefined;
			}
			
			// @description			Remove data from this Data Structure.
			static clear = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					ds_priority_clear(ID);
				}
			}
			
			// @argument			{PriorityQueue} other
			// @description			Replace data of this Priority Queue with data from another one.
			static copy = function(_other)
			{
				if ((instanceof(_other) == "PriorityQueue") and (is_real(_other.ID)) 
				and (ds_exists(_other.ID, ds_type_priority)))
				{
					if ((!is_real(ID)) or (!ds_exists(ID, ds_type_priority)))
					{
						self.construct();
					}
					
					ds_priority_copy(ID, _other.ID);
				}
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{int}
			// @description			Return the number of values in this Data Structure.
			static getSize = function()
			{
				return (((is_real(ID)) and (ds_exists(ID, ds_type_priority))) ? 
					   ds_priority_size(ID) : 0);
			}
			
			// @returns				{any|undefined}
			// @description			Return any value with the highest priority in this Priority Queue.
			//						Returns {undefined} if this Priority Queue does not exists or is
			//						empty.
			static getFirst = function()
			{
				return (((is_real(ID)) and (ds_exists(ID, ds_type_priority))) ? 
					   ds_priority_find_max(ID) : undefined);
			}
			
			// @returns				{any|undefined}
			// @description			Return any value with the lowest priority in this Priority Queue.
			//						Returns {undefined} if this Priority Queue does not exists or is
			//						empty.
			static getLast = function()
			{
				return (((is_real(ID)) and (ds_exists(ID, ds_type_priority))) ? 
					   ds_priority_find_min(ID) : undefined);
			}
			
			// @argument			{any} value
			// @returns				{any|undefined}
			// @description			Return the priority of a specified value.
			static getPriority = function(_value)
			{
				return (((is_real(ID)) and (ds_exists(ID, ds_type_priority))) ? 
					   ds_priority_find_priority(ID, _value) : undefined);
			}
			
			// @returns				{bool|undefined}
			// @description			Check if this Data Structure has any values in it.
			//						Returns {undefined} if this Data Structure does not exists.
			static isEmpty = function()
			{
				return (((is_real(ID)) and (ds_exists(ID, ds_type_priority))) ? 
					   ds_priority_empty(ID) : undefined);
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
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					var _size = ds_priority_size(ID);
					
					if (_size > 0)
					{
						var _priorityQueue = ID;
					
						if (_readOnly)
						{
							var _dataCopy = ds_priority_create();
							ds_priority_copy(_dataCopy, ID);
						
							_priorityQueue = _dataCopy;
						}
					
						var _i = 0;
					
						repeat (_size)
						{
							var _value = ds_priority_delete_max(_priorityQueue);
						
							__function(_i, _value);
						
							++_i;
						}
					
						if (_readOnly)
						{
							ds_priority_destroy(_dataCopy);
						}
					}
				}
			}
			
			// @argument			{any} value
			// @argument			{any} priority
			// @argument			...
			// @description			Add one or more value and priority pairs to this Priority Queue.
			static add = function(_value, _priority)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					var _i = 0;
					
					repeat (argument_count div 2)
					{
						ds_priority_add(ID, argument[_i], argument[_i + 1]);
						
						_i += 2;
					}
				}
			}
			
			// @argument			{any} value
			// @argument			{any} priority
			// @description			Set the priority of already existing value.
			static changePriority = function(_value, _priority)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					ds_priority_change_priority(ID, _value, _priority);
				}
			}
			
			// @argument			{any} value
			// @description			Remove the specified value from this Priority Queue.
			static remove = function(_value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					if (ds_priority_size(ID) > 0)
					{
						ds_priority_delete_value(ID, _value);
					}
				}
			}
			
			// @returns				{any|undefined}
			// @description			Remove and return any value with the lowest priority in this 
			//						Priority Queue.
			//						Returns {undefined} if this Priority Queue does not exists or is
			//						empty.
			static removeMin = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					if (ds_priority_size(ID) > 0)
					{
						return ds_priority_delete_min(ID);
					}
				}

				return undefined;
			}
			
			// @returns				{any|undefined}
			// @description			Remove and return any value with the highest priority in this 
			//						Priority Queue.
			//						Returns {undefined} if this Priority Queue does not exists or is
			//						empty.
			static removeMax = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)) 
				and (ds_priority_size(ID) > 0))
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
			
			// @argument			{bool} multiline
			// @argument			{int|all} elementNumber
			// @argument			{int|all} elementLength
			// @argument			{string|undefined} mark_separator
			// @argument			{string|undefined} mark_cut
			// @argument			{string|undefined} mark_elementStart
			// @argument			{string|undefined} mark_elementEnd
			// @argument			{string|undefined} mark_section
			// @returns				{string}
			// @description			Create a string representing the constructor.
			//						Overrides the string() conversion.
			static toString = function(_multiline, _elementNumber, _elementLength, _mark_separator,
									   _mark_cut, _mark_elementStart, _mark_elementEnd, _mark_section)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					//|General initialization.
					var _size = ds_priority_size(ID);
					
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
					if (_mark_section == undefined) {_mark_section = ": ";}
					
					var _mark_separator_length = string_length(_mark_separator);
					var _mark_cut_length = string_length(_mark_cut);
					var _mark_linebreak = (_multiline ? "\n" : "");
					
					var _string = ((_multiline) ? "" : (instanceof(self) + "("));
					
					var _string_lengthLimit = (string_length(_string) + _elementLength);
					var _string_lengthLimit_cut = (_string_lengthLimit + _mark_cut_length);
					
					//|Data Structure preparation.
					var _dataCopy = ds_priority_create();
					ds_priority_copy(_dataCopy, ID);
					
					//|Content loop.
					var _i = 0;
					
					repeat (min(_size, _elementNumber))
					{
						//|Get Data Structure Element.
						var _priority = string(ds_priority_find_priority(_dataCopy, 
											   ds_priority_find_max(_dataCopy)));
						
						var _value = string(ds_priority_delete_max(_dataCopy));
						
						var _newElement = (_priority + _mark_section + _value);
						
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
					ds_priority_destroy(_dataCopy);
					
					return _string;
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			// @returns				{any[]}
			// @description			Create an array with all values of this PriorityQueue.
			static toArray = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					var _size = ds_priority_size(ID);
					
					if (_size > 0)
					{
						var _dataCopy = ds_priority_create();
						ds_priority_copy(_dataCopy, ID);
						
						var _priorities = array_create(_size, undefined);
						var _values = array_create(_size, undefined);
						
						var _i = 0;
						
						repeat (_size)
						{
							_priorities[_i] = ds_priority_find_priority(_dataCopy, 
											  ds_priority_find_max(_dataCopy));
							
							_values[_i] = ds_priority_delete_max(_dataCopy);
							
							++_i;
						}
						
						ds_priority_destroy(_dataCopy);
						
						return [_priorities, _values];
					}
				}
			}
			
			// @argument			{any[]} array
			// @description			Add priority and value pairs from the specified array to 
			//						this PriorityQueue.
			//						The first dimension of the array must contain priorities
			//						and the second their value pairs.
			//						Values that are not provided for a priority will be set to
			//						{undefined}.
			static fromArray = function(_array)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_priority)))
				{
					if ((is_array(_array)) and (array_length(_array) >= 2)
					and (is_array(_array[0])) and (is_array(_array[1])))
					{
						var _priorities = _array[0];
						var _values = _array[1];
						
						var _priorities_length = array_length(_priorities);
						var _values_length = array_length(_values);
						
						var _i = 0;
						
						repeat (_priorities_length)
						{
							var _value = ((_i < _values_length) ? _values[_i] : undefined);
							
							ds_priority_add(ID, _value, _priorities[_i]);
							
							++_i;
						}
					}
				}
			}
			
			// @returns				{string}
			// @description			Return an encoded string of this Data Structure,
			//						which can later be decoded to recreate it.
			static toEncodedString = function()
			{
				return (((is_real(ID)) and (ds_exists(ID, ds_type_priority))) ? 
					   ds_priority_write(ID) : string(undefined));
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
				
				if ((!is_real(ID)) or (!ds_exists(ID, ds_type_priority)))
				{
					self.construct();
				}
				
				ds_priority_clear(ID); //|Filler call to prevent a silent application crash.
				
				ds_priority_read(ID, _string);
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		self.construct();
		
	#endregion
}
