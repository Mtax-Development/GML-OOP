/// @function				Grid()
/// @argument				{Vector2} size
///
/// @description			Constructs a Grid Data Structure, which stores data in a model similar to
///							the one used by 2D array. Each value is stored in its own cell and they
///							can be read or modified invidually or by handling multiple cells at once
///							in a region or disk of the Grid.
///
///							Construction methods:
///							- New constructor
///							- Wrapper: {int:grid} grid
///							- Constructor copy: {Grid} other
function Grid() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				ID = undefined;
				
				var _instanceof = instanceof(argument[0]);
					
				if (_instanceof == "Vector2")
				{
					//|Construction method: New constructor.
					var _size = argument[0];
						
					ID = ds_grid_create(_size.x, _size.y);
				}
				else if (_instanceof == "Grid")
				{
					//|Construction method: Constructor copy.
					self.copy(argument[0]);
				}
				else if (is_real(argument[0]) and (ds_exists(argument[0], ds_type_grid)))
				{
					//|Construction method: Wrapper.
					ID = argument[0];
				}
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (ds_exists(ID, ds_type_grid)));
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
					
					ID = undefined;
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
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "clear";
					var _errorText = ("Attempted to clear an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
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
						ID = ds_grid_create(0, 0);
					}
					
					ds_grid_copy(ID, _other.ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "copy";
					var _errorText = ("Attempted to perform a copy operation on invalid " +
									  "Data Structures:\n" + 
									  "Self: " + "{" + string(self) + "}" + "\n" +
									  "Other: " + "{" + string(_other) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{Vector2} location
			// @returns				{any|undefined}
			// @description			Return the value of cell at the specified position in this Grid.
			//						Returns {undefined} if this Grid does not exist or the specified
			//						location is out of its bounds.
			static getValue = function(_location)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					return ds_grid_get(ID, _location.x, _location.y);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getValue";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
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
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getSize";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
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
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getSize_x";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return 0;
				}
			}
			
			// @returns				{int}
			// @description			Return the height of this Grid.
			static getSize_y = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					return ds_grid_height(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getSize_y";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return 0;
				}
			}
			
			// @returns				{int}
			// @description			Return the number of all cells in this Grid.
			static getCellNumber = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					return (ds_grid_width(ID) * ds_grid_height(ID));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getCellNumber";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return 0;
				}
			}
			
			// @argument			{Vector4} location
			// @returns				{any} | On error: {undefined}
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
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getMax";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @returns				{any} | On error: {undefined}
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
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getMax_disk";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{Vector4} location
			// @returns				{any} | On error: {undefined}
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
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getMin";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @returns				{any} | On error: {undefined}
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
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getMin_disk";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{Vector4} location
			// @returns				{real} | On error: {undefined}
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
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getMean";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @returns				{real} | On error: {undefined}
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
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getMean_disk";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{Vector4} location
			// @returns				{real} | On error: {undefined}
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
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getSum";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @returns				{real} | On error: {undefined}
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
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getSum_disk";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
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
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "valueExists";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
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
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "valueExists_disk";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return false;
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{any} value
			// @returns				{Vector2|undefined}
			// @description			Get the location of a cell containing the specified value
			//						in the specified region of this Grid.
			//						Returns {undefined} if this Grid or the specified value does not
			//						exist.
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
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getValueLocation";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @argument			{any} value
			// @returns				{Vector2|undefined}
			// @description			Get the location of a cell containing the specified value 
			//						in the specified disk in a Grid.
			//						Returns {undefined} if this Grid or the specified value does not
			//						exist.
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
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getValueLocation_disk";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{function} function
			// @argument			{any} argument?
			// @description			Execute the specified function once for each element in this Data
			//						Structure.
			//						The arguments below will be provided to the function and can be
			//						accessed by using their name or the argument array:
			//						- argument[0]: {int} _x
			//						- argument[1]: {int} _y
			//						- argument[2]: {any} _value
			//						- argument[3]: {any} _argument
			static forEach = function(__function, _argument)
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
								
								__function(_x, _y, _value, _argument);
								
								_x++;
							}
							
							_y++;
						}
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "forEach";
					var _errorText = ("Attempted to iterate through an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{any} value
			// @argument			...
			// @description			Perform a replacement of any number of pairs of specified
			//						numbers and values of cells in the specified locations.
			static set = function(_location, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _i = 0;
					repeat (argument_count div 2)
					{
						_location = argument[_i];
						_value = argument[_i + 1];
						
						ds_grid_set(ID, _location.x, _location.y, _value);
						
						_i += 2;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "set";
					var _errorText = ("Attempted to write to an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
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
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "set_region";
					var _errorText = ("Attempted to write to an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
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
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "set_disk";
					var _errorText = ("Attempted to write to an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
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
					else
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "set_region_copied";
						var _errorText = ("Attempted to copy from an invalid Data Structure: " + 
										  "{" + string(_other) + "}");
						_errorReport.reportConstructorMethod(self, _callstack, _methodName,
															 _errorText);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "set_region_copied";
					var _errorText = ("Attempted to write to an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{real|string} value
			// @argument			...
			// @description			Perform an addition of any number of pairs of specified numbers
			//						and values of cells in the specified locations.
			//						The value will be replaced if it is not the same type as the 
			//						one already existing in the cell.
			static add = function(_location, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _i = 0;
					repeat (argument_count div 2)
					{
						_location = argument[_i];
						_value = argument[_i + 1];
						
						ds_grid_add(ID, _location.x, _location.y, _value);
						
						_i += 2;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "add";
					var _errorText = ("Attempted to write to an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Vector4} location
			// @argument			{real|string} value
			// @description			Add the specified value to already existing values in cells
			//						of the specified region in this Grid.
			//						The value will be replaced if it is not the same type as the 
			//						one already existing in the cell.
			static add_region = function(_location, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					ds_grid_add_region(ID, _location.x1, _location.y1, _location.x2, _location.y2,
									   _value);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "add_region";
					var _errorText = ("Attempted to write to an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @argument			{real|string} value
			// @description			Adds the specified value to already existing values in cells
			//						of the specified disk in this Grid.
			//						The value will be replaced if it is not the same type as the 
			//						one already existing in the cell.
			static add_disk = function(_location, _radius, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					ds_grid_add_disk(ID, _location.x, _location.y, _radius, _value);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "add_disk";
					var _errorText = ("Attempted to write to an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Vector4} source
			// @argument			{Vector2} target
			// @argument			{Grid} other?
			// @description			Copy values of cells from the specified region of this or 
			//						other Grid and add them to values of cells in the region of 
			//						the same size in this Grid, starting from the specified 
			//						target location.
			//						The value will be replaced if it is not the same type as the 
			//						one already existing in the cell.
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
					else
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "add_region_copied";
						var _errorText = ("Attempted to copy from an invalid Data Structure: " + 
										  "{" + string(_other) + "}");
						_errorReport.reportConstructorMethod(self, _callstack, _methodName,
															 _errorText);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "add_region_copied";
					var _errorText = ("Attempted to write to an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{real} value
			// @argument			...
			// @description			Perform a multiplication of any number of pairs of specified
			//						numbers and values of cells in the specified locations.
			//						Grid by a specified amount.
			static multiply = function(_location, _value)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _i = 0;
					repeat (argument_count div 2)
					{
						_location = argument[_i];
						_value = argument[_i + 1];
						
						ds_grid_multiply(ID, _location.x, _location.y, _value);
						
						_i += 2;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "multiply";
					var _errorText = ("Attempted to write to an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
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
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "multiply_region";
					var _errorText = ("Attempted to write to an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
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
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "multiply_disk";
					var _errorText = ("Attempted to write to an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
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
					else
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "multiply_region_copied";
						var _errorText = ("Attempted to copy from an invalid Data Structure: " + 
										  "{" + string(_other) + "}");
						_errorReport.reportConstructorMethod(self, _callstack, _methodName,
															 _errorText);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "multiply_region_copied";
					var _errorText = ("Attempted to write to an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
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
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "resize";
					var _errorText = ("Attempted to resize an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
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
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "sort";
					var _errorText = ("Attempted to sort an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @description			Randomize positions of all cells in this Grid.
			static shuffle = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					ds_grid_shuffle(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "shuffle";
					var _errorText = ("Attempted to shuffle an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @argument			{int|all} elementNumber?
			// @argument			{int|all} elementLength?
			// @argument			{string} mark_separator?
			// @argument			{string} mark_cut?
			// @argument			{string} mark_elementStart?
			// @argument			{string} mark_elementEnd?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented by the data of this Data Structure.
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
					var _mark_elementStart_length = string_length(_mark_elementStart);
					var _mark_elementEnd_length = string_length(_mark_elementEnd);
					var _mark_linebreak = (_multiline ? "\n" : "");
					
					var _string = ((_multiline) ? "" : (instanceof(self) + "("));
					
					var _string_lengthLimit = (string_length(_string) + _elementLength +
											   _mark_elementStart_length + _mark_elementEnd_length);
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
						
						if (_multiline)
						{
							_string += _mark_linebreak;
						}
						else
						{
							//|Cut strings and add cut or separation marks if appriopate.
							if (_elementLength != all)
							{
								var _string_length = string_length(_string);
								
								//|If the current element is not the last, add a separator or cut it
								// if it would be too long.
								if (_y < (_size_y - 1))
								{
									if ((_string_length + _mark_separator_length) >= 
										 _string_lengthLimit_cut)
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
									//|If the current element is last, cut it if it would be too 
									// long, but expand the length check by the length of the cut 
									// mark.
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
					else
					{
						return [[], []];
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "toArray";
					var _errorText = ("Attempted to convert an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return [[], []];
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
							
							++_i;
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
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "fromArray";
					var _errorText = ("Attempted to read an invalid array: " + 
									  "{" + string(_array) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
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
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "toEncodedString";
					var _errorText = ("Attempted to read an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return string(undefined);
				}
			}
			
			// @argument			{string} string
			// @argument			{bool} legacy?
			// @description			Decode the previously encoded string of the same Data 
			//						Structure and recreate it into this one.
			//						Use the "legacy" argument if that string was created
			//						in old versions of GameMaker with different encoding.
			static fromEncodedString = function(_string, _legacy)
			{
				if (_legacy == undefined) {_legacy = false;}
				
				if ((!is_real(ID)) or (!ds_exists(ID, ds_type_grid)))
				{
					ID = ds_grid_create(0, 0);
				}
				
				ds_grid_read(ID, _string, _legacy);
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
		
		script_execute_ext(method_get_index(self.construct), argument_original);
		
	#endregion
}
