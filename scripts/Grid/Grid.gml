/// @function				Grid()
///
/// @argument				{int} width
/// @argument				{int} height
/// @description			Constructs a Grid Data Structure, which stores data in a model similar to
///							the one used by 2D array. Each value is stored in its own cell and they
///							can be read or modified invidually or by handling multiple cells at once
///							in a region or disk of the Grid.
function Grid(_width, _height) constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function(_width, _height)
			{
				if ((_width > 0) and (_height > 0))
				{
					ID = ds_grid_create(_width, _height);
				}
				else
				{
					ID = undefined;
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
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					if (_deepScan)
					{
						var _size_x = ds_grid_width(ID);
						var _size_y = ds_grid_height(ID);
						
						if ((_size_x > 0) and (_size_y > 0))
						{
							var _y = 0;
							
							repeat (_size_y)
							{
								var _x = 0;
								
								repeat (_size_x)
								{
									var _value = ds_grid_get(ID, _x, _y);
							
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
									
									_x++;
								}
							
								_y++;
							}
						}
					}
					
					ds_grid_destroy(ID);
				}
				
				return undefined;
			}
			
			// @argument			{any} value?
			// @description			Set all values of the Grid to a specified value.
			static clear = function(_value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					ds_grid_clear(ID, _value);
				}
			}
			
			// @argument			{Grid} other
			// @description			Replace all data of this Grid with data from another one
			//						after resizing this Grid to match its size.
			static copy = function(_other)
			{
				if ((instanceof(_other) == "Grid") and (is_real(_other.ID)) 
				and (ds_exists(_other.ID, ds_type_grid)))
				{
					if ((!is_real(ID)) or (!ds_exists(ID, ds_type_grid)))
					{
						self.construct(originalArguments[0], originalArguments[1]);
					}
					
					ds_grid_copy(ID, _other.ID);
				}
			}
			
		#endregion
		#region <Getters>
		
			//+TODO: getSize? getDimensions?
			
			// @argument			{Vector2} location
			// @returns				{any|undefined}
			// @description			Return the value of cell at the specified position in this Grid.
			static getValue = function(_location)
			{
				//+TODO: Width/height checks. Description what it returns if the value does not exist.
				
				return (((is_real(ID)) and (ds_exists(ID, ds_type_grid))) ? 
					   ds_grid_get(ID, _location.x, _location.y) : undefined);
			}
			
			// @returns				{Vector2}
			// @description			Return the width and height of this Grid.
			static getSize = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					return new Vector2(ds_grid_width(ID), ds_grid_height(ID));
				}
				else
				{
					return new Vector2(0, 0);
				}
			}
			
			// @returns				{int}
			// @description			Return the width of this Grid.
			static getSize_x = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					return ds_grid_width(ID);
				}
				else
				{
					return 0;
				}
			}
			
			// @return				{int}
			// @description			Return the height of this Grid.
			static getSize_y = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					return ds_grid_height(ID);
				}
				else
				{
					return 0;
				}
			}
			
			// @argument			{Vector4} location
			// @returns				{any}
			// @description			Return the highest value in cells within the specified 
			//						region of this Grid.
			static getMax = function(_location)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					return ds_grid_get_max(ID, _location.x1, _location.y1, 
										   _location.x2, _location.y2);
				}
				else
				{
					return undefined;
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @returns				{any}
			// @description			Return the highest value in cells within the specified 
			//						disk of this Grid.
			static getMax_disk = function(_location, _radius)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					return ds_grid_get_disk_max(ID, _location.x, _location.y, _radius);
				}
				else
				{
					return undefined;
				}
			}
			
			// @argument			{Vector4} location
			// @returns				{any}
			// @description			Return the lowest value in cells within the specified 
			//						region of this Grid.
			static getMin = function(_location)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					return ds_grid_get_min(ID, _location.x1, _location.y1, 
										   _location.x2, _location.y2);
				}
				else
				{
					return undefined;
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @returns				{any}
			// @description			Return the lowest value in cells within the specified 
			//						disk of this Grid.
			static getMin_disk = function(_location, _radius)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					return ds_grid_get_disk_min(ID, _location.x, _location.y, _radius);
				}
				else
				{
					return undefined;
				}
			}
			
			// @argument			{Vector4} location
			// @returns				{real}
			// @description			Return the mean number of values in cells within the 
			//						specified region of this Grid.
			static getMean = function(_location)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					return ds_grid_get_mean(ID, _location.x1, _location.y1, 
											_location.x2, _location.y2);
				}
				else
				{
					return undefined;
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @returns				{real}
			// @description			Return the mean number of values in cells within the 
			//						specified disk in this Grid.
			static getMean_disk = function(_location, _radius)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					return ds_grid_get_disk_mean(ID, _location.x, _location.y, _radius);
				}
				else
				{
					return undefined;
				}
			}
			
			// @argument			{Vector4} location
			// @returns				{real}
			// @description			Return the sum of values in cells within the specified 
			//						region of this Grid. Possible only if all values in the
			//						region are numbers.
			static getSum = function(_location)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					return ds_grid_get_sum(ID, _location.x1, _location.y1, 
										   _location.x2, _location.y2);
				}
				else
				{
					return undefined;
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @returns				{real}
			// @description			Return the sum of values in cells within the specified 
			//						disk in this Grid. Possible only if all values in the
			//						disk are numbers.
			static getSum_disk = function(_location, _radius)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					return ds_grid_get_disk_sum(ID, _location.x, _location.y, _radius);
				}
				else
				{
					return undefined;
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{any} value
			// @returns				{bool}
			// @description			Check if the specified value exists in the specified 
			//						region of the Grid.
			static valueExists = function(_location, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					return ds_grid_value_exists(ID, _location.x1, _location.y1, _location.x2, 
												_location.y2, _value);
				}
				else
				{
					return false;
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @argument			{any} value
			// @returns				{bool}
			// @description			Check if the specified value exists in the specified
			//						disk in this Grid.
			static valueExists_disk = function(_location, _radius, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					return ds_grid_value_disk_exists(ID, _location.x, _location.y, _radius, _value);
				}
				else
				{
					return false;
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{any} value
			// @returns				{Vector2|undefined}
			// @description			Get the location of a cell containing the specified value
			//						in the specified region of this Grid.
			//						Returns {undefined} if this Grid or the specified value 
			//						does not exist.
			static getValueLocation = function(_location, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _location_x = ds_grid_value_x(ID, _location.x1, _location.y1, 
													  _location.x2, _location.y2, _value);
					var _location_y = ds_grid_value_y(ID, _location.x1, _location.y1, 
													  _location.x2, _location.y2, _value);
					
					if ((_location_x >= 0) and (_location_y >= 0))
					{
						return new Vector2(_location_x, _location_y);
					}
					else
					{
						return undefined;
					}
				}
				else
				{
					return undefined;
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @argument			{any} value
			// @returns				{Vector2|undefined}
			// @description			Get the location of a cell containing the specified value 
			//						in the specified disk in a Grid.
			//						Returns {undefined} if this Grid or the specified value 
			//						does not exist.
			static getValueLocation_disk = function(_location, _radius, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _location_x = ds_grid_value_disk_x(ID, _location.x, _location.y, 
														   _radius, _value);
					var _location_y = ds_grid_value_disk_y(ID, _location.x, _location.y, 
														   _radius, _value);
					
					if ((_location_x >= 0) and (_location_y >= 0))
					{
						return new Vector2(_location_x, _location_y);
					}
					else
					{
						return undefined;
					}
				}
				else
				{
					return undefined;
				}
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{Vector2} location
			// @argument			{real|string} value
			// @description			Add the specified value to already existing value
			//						in the specified cell in this Grid.
			//						The already existing value must be a number or a string
			//						and it will be replaced if the specified value is of a
			//						different type.
			static add = function(_location, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					ds_grid_add(ID, _location.x, _location.y, _value);
				}
			}
			
			// @argument			{Vector4} location
			// @argument			{real|string} value
			// @description			Add the specified value to already existing values 
			//						in cells of the specified region in this Grid.
			//						The already existing value must be a number or a string
			//						and it will be replaced if the specified value is of a
			//						different type.
			static add_region = function(_location, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					ds_grid_add_region(ID, _location.x1, _location.y1, _location.x2, 
									   _location.y2, _value);
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @argument			{real|string} value
			// @description			Adds the specified value to already existing values 
			//						in cells of the specified disk in this Grid.
			//						The already existing value must be a number or a string
			//						and it will be replaced if the specified value is of a
			//						different type.
			static add_disk = function(_location, _radius, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					ds_grid_add_disk(ID, _location.x, _location.y, _radius, _value);
				}
			}
			
			// @argument			{Vector4} source
			// @argument			{Vector2} target
			// @argument			{Grid} other?
			// @description			Copy values of cells from the specified region of this or 
			//						other Grid and add them to values of cells in the region of 
			//						the same size in this Grid, starting from the specified 
			//						target location.
			//						The already existing value must be a number or a string
			//						and it will be replaced if the specified value is of a
			//						different type.
			static add_region_copied = function(_source, _target, _other)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					if (_other == undefined) {_other = self;}
					
					if (((instanceof(_other) == "Grid")) and (is_real(_other.ID)) 
					and (ds_exists(_other.ID, ds_type_grid)))
					{
						ds_grid_add_grid_region(ID, _other.ID, _source.x1, _source.y1, 
												_source.x2, _source.y2, _target.x, _target.y);
					}
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{any} value
			// @description			Replace the specified value of cell in the specified location
			//						in this Grid.
			static set = function(_location, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					ds_grid_set(ID, _location.x, _location.y, _value);
				}
			}
			
			// @argument			{Vector4} location
			// @argument			{any} value
			// @description			Replace the specified value of cells of the specified region 
			//						in this Grid.
			static set_region = function(_location, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					ds_grid_set_region(ID, _location.x1, _location.y1, _location.x2, 
									   _location.y2, _value);
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @argument			{any} value
			// @description			Replace the specified value of cells of the specified disk 
			//						in this Grid.
			static set_disk = function(_location, _radius, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					ds_grid_set_disk(ID, _location.x, _location.y, _radius, _value);
				}
			}
			
			// @argument			{Vector4} source
			// @argument			{Vector2} target
			// @argument			{Grid} other?
			// @description			Copy values of cells from the specified region of this or 
			//						other Grid and replace the values of cells in the region of 
			//						the same size in this Grid, starting from the specified target
			//						location.
			static set_region_copied = function(_source, _target, _other)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					if (_other == undefined) {_other = self;}
					
					if (((instanceof(_other) == "Grid")) and (is_real(_other.ID)) 
					and (ds_exists(_other.ID, ds_type_grid)))
					{
						ds_grid_set_grid_region(ID, _other.ID, _source.x1, _source.y1, 
												_source.x2, _source.y2, _target.x, _target.y);
					}
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{real} value
			// @description			Multiply a number value in the specified cell in this 
			//						Grid by a specified amount.
			static multiply = function(_location, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					ds_grid_multiply(ID, _location.x, _location.y, _value);
				}
			}
			
			// @argument			{Vector4} location
			// @argument			{real} value
			// @description			Multiply a number value in the specified region in this 
			//						Grid by a specified amount.
			static multiply_region = function(_location, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					ds_grid_multiply_region(ID, _location.x1, _location.y1, 
											_location.x2, _location.y2, _value);
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @argument			{real} value
			// @description			Multiply a number value in the specified disk in this 
			//						Grid by a specified amount.
			static multiply_disk = function(_location, _radius, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					ds_grid_multiply_disk(ID, _location.x, _location.y, _radius, _value);
				}
			}
			
			// @argument			{Vector4} source
			// @argument			{Vector2} target
			// @argument			{Grid} other?
			// @description			Copy values of cells from the specified region of this or 
			//						other Grid and multiply by them the number values of cells
			//						in the region of the same size in this Grid, starting from 
			//						the specified target location.
			static multiply_region_copied = function(_source, _target, _other)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					if (_other == undefined) {_other = self;}
					
					if (((instanceof(_other) == "Grid")) and (is_real(_other.ID)) 
					and (ds_exists(_other.ID, ds_type_grid)))
					{
						ds_grid_multiply_grid_region(ID, _other.ID, _source.x1, _source.y1, 
													 _source.x2, _source.y2, _target.x, _target.y);
					}
				}
			}
			
			// @argument			{Vector2} size
			// @description			Change the size of this Grid. New cells will have their
			//						values set to 0.
			static resize = function(_size)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					ds_grid_resize(ID, _size.x, _size.y);
				}
			}
			
			// @argument			{int} column
			// @argument			{bool} ascending
			// @description			Sort all cells in the specified cell column by their values
			//						if all of the values are of the same type.
			static sort = function(_column, _order_ascending)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					ds_grid_sort(ID, _column, _order_ascending);
				}
			}
			
			// @description			Randomize positions of all cells in this Grid.
			static shuffle = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					ds_grid_shuffle(ID);
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{function} function
			// @description			Execute a provided function once for each Data Structure element.
			//						The provided function can read variables provided by it, either
			//						by requiring the same named arguments or via the argument array.
			//						The provided variables are:
			//						- argument[0]: {int} _x
			//						- argument[1]: {int} _y
			//						- argument[2]: {any} _value
			static forEach = function(__function)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _size_x = ds_grid_width(ID);
					var _size_y = ds_grid_height(ID);
					
					if ((_size_x > 0) and (_size_y > 0))
					{
						var _y = 0;
						
						repeat (_size_y)
						{
							var _x = 0;
							
							repeat (_size_x)
							{
								var _value = ds_grid_get(ID, _x, _y);
								
								__function(_x, _y, _value);
								
								_x++;
							}
							
							_y++;
						}
					}
				}
			}
			
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
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					//|General initialization.
					var _size_x = ds_grid_width(ID);
					var _size_y = ds_grid_height(ID);
					
					switch (_elementNumber)
					{
						case undefined: _elementNumber = 10; break;
						case all: _elementNumber = _size_y; break;
					}
					
					if (_elementLength == undefined) {_elementLength = ((_multiline) ? 15 : 30);}
					if (_mark_separator == undefined) {_mark_separator = ", ";}
					if (_mark_cut == undefined) {_mark_cut = "...";}
					if (_mark_elementStart == undefined) {_mark_elementStart = "[";}
					if (_mark_elementEnd == undefined) {_mark_elementEnd = "]";}
					
					var _mark_separator_length = string_length(_mark_separator);
					var _mark_cut_length = string_length(_mark_cut);
					var _mark_linebreak = (_multiline ? "\n" : "");
					
					var _string = ((_multiline) ? "" : (instanceof(self) + "("));
					
					var _string_lengthLimit = (string_length(_string) + _elementLength);
					var _string_lengthLimit_cut = (_string_lengthLimit + _mark_cut_length);
					
					//|Content loop.
					var _y = 0;
					
					repeat (min(_size_y, _elementNumber))
					{
						var _x = 0;
						
						repeat (_size_x)
						{
							//|Get Data Structure Element.
							var _newElement = string(ds_grid_get(ID, _x, _y));
							
							//|Remove line-breaks.
							_newElement = string_replace_all(_newElement, "\n", " ");
							_newElement = string_replace_all(_newElement, "\r", " ");
							
							//|Limit element length for multiline listing.
							if (_elementLength != all)
							{
								if ((string_length(_newElement)) > _elementLength)
								{
									_newElement = string_copy(_newElement, 1, _elementLength);
									_newElement += _mark_cut;
								}
							}
							
							//|Add the element string with its parts.
							_string += (_mark_elementStart + _newElement + _mark_elementEnd);
							
							_x++;
						}
						
						_string += ((_multiline) ? _mark_linebreak : ""); //+TODO
						
						//|Cut strings and add cut or separation marks if appriopate.
						if (!_multiline)
						{
							if (_elementLength != all)
							{
								var _string_length = string_length(_string);
								
								//|If the current element is not the last, add a separator or cut it
								// if it would be too long.
								if (_y < (_size_y - 1))
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
										if (_y < (_elementNumber - 1))
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
								if (_y < (_elementNumber - 1))
								{
									_string += _mark_separator;
								}
								else if (_elementNumber != _size_y)
								{
									_string += _mark_cut;
								}
							}
						}
						
						_y++;
					}
					
					//|String finish.
					if (_multiline)
					{
						//|Add a cut mark at the end of multiline listing if not all are shown.
						if (_y < _size_y)
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
			
			// @returns				{any[]}
			// @description			Create an array with values of all cells in this Grid.
			static toArray = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _size_x = ds_grid_width(ID);
					var _size_y = ds_grid_height(ID);
					
					if ((_size_x > 0) and (_size_y > 0))
					{
						var _array;
						
						_array[(_size_x - 1)][(_size_y - 1)] = 0;
						
						var _y = 0;
						
						repeat (_size_y)
						{
							var _x = 0;
							
							repeat (_size_x)
							{
								_array[_x][_y] = ds_grid_get(ID, _x, _y);
								
								_x++;
							}
							
							_y++;
						}
						
						return _array;
					}
				}
				else
				{
					return [];
				}
			}
			
			// @argument			{any[]} array
			// @argument			{any} default?
			// @description			Replace this Grid with one that has the size and values of the
			//						specified 1D or 2D array.
			//						Since arrays can have columns of varying sizes and represent no
			//						value in some Grid cells, a default value will be used in such 
			//						cases.
			static fromArray = function(_array, _default)
			{
				if (is_array(_array))
				{
					var _size_x = array_length(_array);
					
					if (_size_x > 0)
					{
						//|Create a list that contains a number of y values after knowing its width.
						// Used for loop boundaries to prevent accessing non-existant values.
						var _array_y_list = array_create(_size_x);
						var _array_y_max = array_length(_array[0]);
						
						var _i = 0;
						
						repeat (_size_x)
						{
							var _array_y_current = array_length(_array[_i]);
							
							if (_array_y_current > _array_y_max)
							{
								_array_y_max = _array_y_current;
							}
							
							_array_y_list[_i] = _array_y_current;
							
							_i++;
						}
						
						//|Replace the Grid.
						if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
						{
							ds_grid_destroy(ID);
						}
						
						var _size_y = max(_array_y_max, 1);
						
						ID = ds_grid_create(_size_x, _size_y);
						ds_grid_clear(ID, _default);
						
						var _x = 0;
						
						repeat (_size_x)
						{
							var _y = 0;
							
							if (_array_y_list[_x] > 0)
							{
								repeat (_array_y_list[_x])
								{
									ds_grid_set(ID, _x, _y, _array[_x][_y]);
									_y++;
								}
							}
							else
							{
								ds_grid_set(ID, _x, _y, _array[_x]);
							}
							
							_x++;
						}
					}
				}
			}
			
			// @returns				{string}
			// @description			Return an encoded string of this Data Structure,
			//						which can later be decoded to recreate it.
			static toEncodedString = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					return ds_grid_write(ID);
				}
				else
				{
					return string(undefined);
				}
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
				
				if ((!is_real(ID)) or (!ds_exists(ID, ds_type_grid)))
				{
					self.construct(originalArguments[0], originalArguments[1]);
				}
				
				ds_grid_read(ID, _string, _legacy);
			}
			
		#endregion
	#endregion
	#region [Constructor]
	
		originalArguments = array_create(argument_count, undefined);
		
		var _i = 0;
		
		repeat (argument_count)
		{
			originalArguments[_i] = argument[_i];
			
			_i++;
		}
		
		self.construct(_width, _height);
		
	#endregion
}