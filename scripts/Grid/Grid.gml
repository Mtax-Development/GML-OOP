/// @function				Grid()
/// @argument				{Vector2} size
///							
/// @description			Constructs a Grid Data Structure, which stores data in a model similar to
///							the one used by 2D arrays. Each value is stored in its own cell and they
///							can be read or modified invidually or by operating multiple cells at once
///							in a region or a disk of the Grid.
///							
///							Construction types:
///							- New constructor
///							- Wrapper: {int:grid} grid
///							- Empty: {void|undefined}
///							- Constructor copy: {Grid} other
function Grid() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				ID = undefined;
				size = undefined;
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					switch (instanceof(argument[0]))
					{
						case "Grid":
							//|Construction type: Constructor copy.
							var _other = argument[0];
							
							size = ((instanceof(_other.size) == "Vector2") ? new Vector2(_other.size)
																		   : _other.size);
							
							ID = ds_grid_create(size.x, size.y);
							ds_grid_copy(ID, _other.ID);
						break;
						
						case "Vector2":
							//|Construction type: New constructor.
							size = new Vector2(argument[0]);
							
							ID = ds_grid_create(size.x, size.y);
						break;
						
						default:
							//|Construction type: Wrapper.
							ID = argument[0];
							
							size = new Vector2(ds_grid_width(ID), ds_grid_height(ID));
						break;
					}
				}
				
				return self;
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
			static destroy = function(_deepScan = false)
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
			static clear = function(_value = false)
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
				
				return self;
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
					
					size = new Vector2(ds_grid_width(ID), ds_grid_height(ID));
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
				
				return self;
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{any} value...
			// @returns				{bool} | On error: {undefined}
			// @description			Check if this Data Structure contains at least one of the
			//						specified values.
			static contains = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _size_x = ds_grid_width(ID);
					var _size_y = ds_grid_height(ID);
					
					var _i = 0;
					repeat (argument_count)
					{
						if (ds_grid_value_exists(ID, 0, 0, _size_x, _size_y, argument[_i]))
						{
							return true;
						}
						
						++_i;
					}
					
					return false;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "contains";
					var _errorText = ("Attempted to read an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{Vector4} location
			// @argument			{any} value...
			// @returns				{bool} | On error: {undefined}
			// @description			Check if this Data Structure contains at least one of the
			//						specified values in the specified region.
			static containsRegion = function(_location)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _i = 1;
					repeat ((argument_count - 1))
					{
						if (ds_grid_value_exists(ID, _location.x1, _location.y1, _location.x2,
												 _location.y2, argument[_i]))
						{
							return true;
						}
						
						++_i;
					}
					
					return false;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "containsRegion";
					var _errorText = ("Attempted to read an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @argument			{any} value...
			// @returns				{bool} | On error: {undefined}
			// @description			Check if this Data Structure contains at least one of the
			//						specified values in the specified disk.
			static containsDisk = function(_location, _radius)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _i = 2;
					repeat ((argument_count - 2))
					{
						if (ds_grid_value_disk_exists(ID, _location.x, _location.y, _radius,
													  argument[_i]))
						{
							return true;
						}
						
						++_i;
					}
					
					return false;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "containsDisk";
					var _errorText = ("Attempted to read an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{any} value...
			// @returns				{int} | On error: {undefined}
			// @description			Return the number of times the specified values occur in this
			//						Data Structure.
			static count = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _result = 0;
					
					var _size_x = ds_grid_width(ID);
					var _size_y = ds_grid_height(ID);
					
					var _y = 0;
					repeat (_size_y)
					{
						var _x = 0;
						repeat (_size_x)
						{
							var _value = ds_grid_get(ID, _x, _y);
							
							var _i = 0;
							repeat (argument_count)
							{
								if (_value == argument[_i])
								{
									++_result;
								}
								
								++_i;
							}
							
							++_x;
						}
						
						++_y;
					}
					
					return _result;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "count";
					var _errorText = ("Attempted to read an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
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
			
			// @returns				{int}
			// @description			Return the number of cells in this Grid.
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
			
			// @argument			{Vector4} location?
			// @returns				{real} | On error: {undefined}
			// @description			Return the lowest numerical value found in cells within the
			//						specified region of this Grid.
			//						If the region contains values other than numerical, it might be
			//						found instead and will be returned as {undefined}.
			static getMinimum = function(_location)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _result = ((_location == undefined)
								   ? ds_grid_get_min(ID, 0, 0, ds_grid_width(ID), ds_grid_height(ID))
								   : ds_grid_get_min(ID, _location.x1, _location.y1, _location.x2,
													 _location.y2));
					
					return ((is_real(_result) ? _result : undefined));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getMinimum";
					var _errorText = ("Attempted to read an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @returns				{real} | On error: {undefined}
			// @description			Return the lowest numerical value found in cells within the
			//						specified disk of this Grid.
			//						If the disk contains values other than numerical, it might be
			//						found instead and will be returned as {undefined}.
			static getMinimumDisk = function(_location, _radius)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _result = ds_grid_get_disk_min(ID, _location.x, _location.y, _radius);
					
					return ((is_real(_result) ? _result : undefined));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getMinimumDisk";
					var _errorText = ("Attempted to read an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{Vector4} location?
			// @returns				{real} | On error: {undefined}
			// @description			Return the highest numerical value found in cells within the
			//						specified region of this Grid.
			//						If the region contains values other than numerical, it might be
			//						found instead and will be returned as {undefined}.
			static getMaximum = function(_location)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _result = ((_location == undefined)
								   ? ds_grid_get_max(ID, 0, 0, ds_grid_width(ID), ds_grid_height(ID))
								   : ds_grid_get_max(ID, _location.x1, _location.y1, _location.x2,
													 _location.y2));
					
					return ((is_real(_result) ? _result : undefined));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getMaximum";
					var _errorText = ("Attempted to read an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @returns				{real} | On error: {undefined}
			// @description			Return the highest numerical value found in cells within the
			//						specified disk of this Grid.
			//						If the disk contains values other than numerical, it might be
			//						found instead and will be returned as {undefined}.
			static getMaximumDisk = function(_location, _radius)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _result = ds_grid_get_disk_max(ID, _location.x, _location.y, _radius);
					
					return ((is_real(_result) ? _result : undefined));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getMaximumDisk";
					var _errorText = ("Attempted to read an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{Vector4} location?
			// @returns				{real} | On error: {undefined}
			// @description			Return the mean number of numerical values found in cells within
			//						the specified region of this Grid.
			//						If the region contains no numerical values, 0 will be returned.
			static getMean = function(_location)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{	
					return ((_location == undefined) ? ds_grid_get_mean(ID, 0, 0, ds_grid_width(ID),
																		ds_grid_height(ID))
													 : ds_grid_get_mean(ID, _location.x1,
																		_location.y1, _location.x2,
																		_location.y2));
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
			// @description			Return the mean number of numerical values found in cells within
			//						the specified disk of this Grid.
			//						If the disk contains no numerical values, 0 will be returned.
			static getMeanDisk = function(_location, _radius)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					return ds_grid_get_disk_mean(ID, _location.x, _location.y, _radius);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getMeanDisk";
					var _errorText = ("Attempted to read an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{Vector4} location?
			// @returns				{real|undefined}
			// @description			Return the sum of numerical values found in cells within
			//						the specified region of this Grid.
			//						Strings containing only numbers will also be included. Other 
			//						values will be ignored. If this Grid does not exist or the region
			//						contains no values that can be summed, {undefined} will be
			//						returned.
			static getSum = function(_location)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _result = ((_location == undefined)
								   ? ds_grid_get_sum(ID, 0, 0, ds_grid_width(ID), ds_grid_height(ID))
								   : ds_grid_get_sum(ID, _location.x1, _location.y1, _location.x2,
													 _location.y2));
					
					return (((!is_nan(_result)) and (is_real(_result))) ? _result : undefined);
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
			// @returns				{real|undefined}
			// @description			Return the sum of numerical values found in cells within
			//						the specified disk of this Grid.
			//						Strings containing only numbers will also be included. Other 
			//						values will be ignored. If this Grid does not exist or the disk
			//						contains no values that can be summed, {undefined} will be
			//						returned.
			static getSumDisk = function(_location, _radius)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _result = ds_grid_get_disk_sum(ID, _location.x, _location.y, _radius);
					
					return (((!is_nan(_result)) and (is_real(_result))) ? _result : undefined);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getSumDisk";
					var _errorText = ("Attempted to read an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{any} value
			// @argument			{Vector4} location?
			// @returns				{Vector2|undefined}
			// @description			Get the location of a cell containing the specified value
			//						in the specified region of this Grid.
			//						Returns {undefined} if this Grid or the specified value does not
			//						exist.
			static getValueLocation = function(_value, _location)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _location_x, _location_y;
					
					if (_location == undefined)
					{
						var _size_x = ds_grid_width(ID);
						var _size_y = ds_grid_height(ID);
						
						_location_x = ds_grid_value_x(ID, 0, 0, _size_x, _size_y, _value);
						_location_y = ds_grid_value_y(ID, 0, 0, _size_x, _size_y, _value);
					}
					else
					{
						_location_x = ds_grid_value_x(ID, _location.x1, _location.y1, _location.x2,
													  _location.y2, _value);
						_location_y = ds_grid_value_y(ID, _location.x1, _location.y1, _location.x2,
													  _location.y2, _value);
					}
					
					return ((_location_x >= 0) and (_location_y >= 0)) ? new Vector2(_location_x,
																					 _location_y)
																	   : undefined;
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
			
			// @argument			{any} value
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @returns				{Vector2|undefined}
			// @description			Get the location of a cell containing the specified value 
			//						in the specified disk of this Grid.
			//						Returns {undefined} if this Grid or the specified value does not
			//						exist.
			static getValueLocationDisk = function(_value, _location, _radius)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _location_x = ds_grid_value_disk_x(ID, _location.x, _location.y, _radius,
														   _value);
					var _location_y = ds_grid_value_disk_y(ID, _location.x, _location.y, _radius,
														   _value);
					
					return ((_location_x >= 0) and (_location_y >= 0))
							? new Vector2(_location_x, _location_y) : undefined;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getValueLocationDisk";
					var _errorText = ("Attempted to read an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{Vector2} size
			// @description			Change the size of this Grid.
			//						New cells will have their values set to 0.
			static setSize = function(_size)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					size = new Vector2(_size);
					
					ds_grid_resize(ID, size.x, size.y);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setSize";
					var _errorText = ("Attempted to set a property of an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{function} function
			// @argument			{any} argument?
			// @returns				{any[]}
			// @description			Execute a function once for each element in this Data Structure.
			//						The following arguments will be provided to the function and can
			//						be accessed in it by using their name or the argument array:
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
					
					var _functionReturn = [];
					
					var _y = 0;
					repeat (_size_y)
					{
						var _x = 0;
						repeat (_size_x)
						{
							var _value = ds_grid_get(ID, _x, _y);
							
							array_push(_functionReturn, __function(_x, _y, _value, _argument));
							
							++_x;
						}
						
						++_y;
					}
					
					return _functionReturn;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "forEach";
					var _errorText = ("Attempted to iterate through an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{any} value...
			// @argument			{Vector2} location...
			// @description			Replace any number of values in the specified cells in this Grid
			//						by the specified values.
			static set = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _i = 0;
					repeat (argument_count div 2)
					{
						_value = argument[_i];
						_location = argument[(_i + 1)];
						
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
				
				return self;
			}
			
			// @argument			{any} value
			// @argument			{Vector4} location?
			// @description			Replace the values of cells of the specified region in this Grid
			//						by the specified value.
			static setRegion = function(_value, _location)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					if (_location == undefined)
					{
						ds_grid_set_region(ID, 0, 0, ds_grid_width(ID), ds_grid_height(ID), _value);
					}
					else
					{
						ds_grid_set_region(ID, _location.x1, _location.y1, _location.x2,
										   _location.y2, _value);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setRegion";
					var _errorText = ("Attempted to write to an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{any} value
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @description			Replace the values of cells of the specified disk in this Grid by
			//						the specified value.
			static setDisk = function(_value, _location, _radius)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					ds_grid_set_disk(ID, _location.x, _location.y, _radius, _value);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setDisk";
					var _errorText = ("Attempted to write to an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{Vector2} target
			// @argument			{Vector4} source
			// @argument			{Grid} other?
			// @description			Copy values of cells from the specified region in this or
			//						specified other Grid and replace the values of cells in the 
			//						region of the same size in this Grid, starting from the specified
			//						target location.
			static setRegionCopied = function(_target, _source, _other = self)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					if ((_other == self) or (((instanceof(_other) == "Grid")) 
					and (is_real(_other.ID)) and (ds_exists(_other.ID, ds_type_grid))))
					{
						ds_grid_set_grid_region(ID, _other.ID, _source.x1, _source.y1, 
												_source.x2, _source.y2, _target.x, _target.y);
					}
					else
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "setRegionCopied";
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
					var _methodName = "setRegionCopied";
					var _errorText = ("Attempted to write to an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{real|string} value...
			// @argument			{Vector2} location...
			// @description			Add the specified values to any number of values in the specified
			//						cells of this Grid.
			//						The values will be replaced if they are not the same type as the 
			//						one already existing in the cell.
			static add = function(_value, _location)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _i = 0;
					repeat (argument_count div 2)
					{
						_value = argument[_i];
						_location = argument[(_i + 1)];
						
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
				
				return self;
			}
			
			// @argument			{real|string} value
			// @argument			{Vector4} location?
			// @description			Add the specified value to values in cells in the specified
			//						region of this Grid.
			//						The values will be replaced if they are not the same type as the 
			//						one already existing in the cell.
			static addRegion = function(_value, _location)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					if (_location == undefined)
					{
						ds_grid_add_region(ID, 0, 0, ds_grid_width(ID), ds_grid_height(ID), _value);
					}
					else
					{
						ds_grid_add_region(ID, _location.x1, _location.y1, _location.x2,
										   _location.y2, _value);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "addRegion";
					var _errorText = ("Attempted to write to an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{real|string} value
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @description			Add the specified value to values in cells in the specified disk
			//						of this Grid.
			//						The values will be replaced if they are not the same type as the 
			//						one already existing in the cell.
			static addDisk = function(_value, _location, _radius)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					ds_grid_add_disk(ID, _location.x, _location.y, _radius, _value);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "addDisk";
					var _errorText = ("Attempted to write to an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{Vector2} target
			// @argument			{Vector4} source
			// @argument			{Grid} other?
			// @description			Copy values of cells from the specified region of this or 
			//						specified other Grid and add them to values of cells in the
			//						region of the same size in this Grid, starting from the specified
			//						target location.
			//						The value will be replaced if it is not the same type as the 
			//						one already existing in the cell.
			static addRegionCopied = function(_target, _source, _other = self)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					if ((_other == self) or (((instanceof(_other) == "Grid")) 
					and (is_real(_other.ID)) and (ds_exists(_other.ID, ds_type_grid))))
					{
						ds_grid_add_grid_region(ID, _other.ID, _source.x1, _source.y1, _source.x2,
												_source.y2, _target.x, _target.y);
					}
					else
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "addRegionCopied";
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
					var _methodName = "addRegionCopied";
					var _errorText = ("Attempted to write to an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{real} value...
			// @argument			{Vector2} location...
			// @description			Multiply by the specified values any number of numerical values
			//						in the specified cells of this Grid.
			static multiply = function(_value, _location)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _i = 0;
					repeat (argument_count div 2)
					{
						_value = argument[_i];
						_location = argument[(_i + 1)];
						
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
				
				return self;
			}
			
			// @argument			{real} value
			// @argument			{Vector4} location?
			// @description			Multiply by the specified value the numerical values in cells in
			//						the specified region of this Grid.
			static multiplyRegion = function(_value, _location)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					if (_location == undefined)
					{
						ds_grid_multiply_region(ID, 0, 0, ds_grid_width(ID), ds_grid_height(ID),
												_value);
					}
					else
					{
						ds_grid_multiply_region(ID, _location.x1, _location.y1, _location.x2,
												_location.y2, _value);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "multiplyRegion";
					var _errorText = ("Attempted to write to an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{real} value
			// @argument			{Vector2} location
			// @argument			{int} radius
			// @description			Multiply by the specified value the numerical values in cells in
			//						the specified disk of this Grid.
			static multiplyDisk = function(_value, _location, _radius)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					ds_grid_multiply_disk(ID, _location.x, _location.y, _radius, _value);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "multiplyDisk";
					var _errorText = ("Attempted to write to an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{Vector2} target
			// @argument			{Vector4} source
			// @argument			{Grid} other?
			// @description			Copy values of cells from the specified region of this or 
			//						specified other Grid and multiply by them the number values of
			//						cells in the region of the same size in this Grid, starting from 
			//						the specified target location.
			static multiplyRegionCopied = function(_target, _source, _other = self)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					if ((_other == self) or (((instanceof(_other) == "Grid"))
					and (is_real(_other.ID)) and (ds_exists(_other.ID, ds_type_grid))))
					{
						ds_grid_multiply_grid_region(ID, _other.ID, _source.x1, _source.y1,
													 _source.x2, _source.y2, _target.x, _target.y);
					}
					else
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "multiplyRegionCopied";
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
					var _methodName = "multiplyRegionCopied";
					var _errorText = ("Attempted to write to an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @description			Flip the cells of this Grid horizontally.
			static mirrorX = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _size_x = ds_grid_width(ID);
					var _size_y = ds_grid_height(ID);
					var _size_x_index = (_size_x - 1);
					
					var _target = ds_grid_create(_size_x, _size_y);
					
					var _x = 0;
					repeat (_size_x)
					{
						var _y = 0;
						repeat (_size_y)
						{
							ds_grid_set(_target, (_size_x_index - _x), _y, ds_grid_get(ID, _x, _y));
							
							++_y;
						}
						
						++_x;
					}
					
					ds_grid_copy(ID, _target);
					ds_grid_destroy(_target);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "mirrorX";
					var _errorText = ("Attempted to reorder an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @description			Flip the cells of this Grid vertically.
			static mirrorY = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _size_x = ds_grid_width(ID);
					var _size_y = ds_grid_height(ID);
					var _size_y_index = (_size_y - 1);
					
					var _target = ds_grid_create(_size_x, _size_y);
					
					var _x = 0;
					repeat (_size_x)
					{
						var _y = 0;
						repeat (_size_y)
						{
							ds_grid_set(_target, _x, (_size_y_index - _y), ds_grid_get(ID, _x, _y));
							
							++_y;
						}
						
						++_x;
					}
					
					ds_grid_copy(ID, _target);
					ds_grid_destroy(_target);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "mirrorY";
					var _errorText = ("Attempted to reorder an invalid Data Structure: " + 
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @description			Swap the columns and rows of this Grid.
			static transpose = function()
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					var _size_x = ds_grid_width(ID);
					var _size_y = ds_grid_height(ID);
					
					var _target = ds_grid_create(_size_y, _size_x);
					
					var _x = 0;
					repeat (_size_x)
					{
						var _y = 0;
						repeat (_size_y)
						{
							ds_grid_set(_target, _y, _x, ds_grid_get(ID, _x, _y));
							
							++_y;
						}
						
						++_x;
					}
					
					ds_grid_copy(ID, _target);
					ds_grid_destroy(_target);
					
					size = new Vector2(ds_grid_width(ID), ds_grid_height(ID));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "shuffle";
					var _errorText = ("Attempted to reorder an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{int} column
			// @argument			{bool} orderAscending
			// @description			Sort all cells in this Grid by individually sorting the specified
			//						vertical cell column and then applying its sort order to other
			//						columns.
			static sort = function(_column, _orderAscending)
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					ds_grid_sort(ID, _column, _orderAscending);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "sort";
					var _errorText = ("Attempted to reorder an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
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
					var _errorText = ("Attempted to reorder an invalid Data Structure: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
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
			// @argument			{string} mark_sizeSeparator?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented by the data of this Data Structure.
			static toString = function(_multiline = false, _elementNumber = 10, _elementLength,
									   _mark_separator = ", ", _mark_cut = "...",
									   _mark_elementStart = "[", _mark_elementEnd = "]",
									   _mark_sizeSeparator = " - ")
			{
				if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
				{
					//|General initialization.
					var _size_x = ds_grid_width(ID);
					var _size_y = ds_grid_height(ID);
					
					if (_elementNumber == all)
					{
						_elementNumber = _size_y;
					}
					
					if (!is_real(_elementLength)) {_elementLength = ((_multiline) ? 15 : 30);}
					
					var _mark_separator_length = string_length(_mark_separator);
					var _mark_cut_length = string_length(_mark_cut);
					var _mark_elementStart_length = string_length(_mark_elementStart);
					var _mark_elementEnd_length = string_length(_mark_elementEnd);
					
					var _string = "";
					var _string_size = (string(_size_x) + "x" + string(_size_y));
					
					if (!_multiline)
					{
						_string += (instanceof(self) + "(" + _string_size);
						
						if ((_size_x > 0) and (_size_y > 0))
						{
							_string += _mark_sizeSeparator;
						}
					}
					
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
							
							++_x;
						}
						
						if (_multiline)
						{
							_string += "\n";
						}
						else
						{
							//|Cut strings and add cut or separation marks if appropriate.
							if (_elementLength != all)
							{
								var _string_length = string_length(_string);
								
								//|If the current element is not the last, add a separator or cut it
								// if it would be too long.
								if (_y < (_size_y - 1))
								{
									if ((_string_length + _mark_separator_length) >
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
						
						++_y;
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
								
								++_x;
							}
							
							++_y;
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
						
						var _size_y = max(_array_y_max, 1);
						
						if ((is_real(ID)) and (ds_exists(ID, ds_type_grid)))
						{
							ds_grid_resize(ID, _size_x, _size_y);
						}
						else
						{
							ID = ds_grid_create(_size_x, _size_y);
						}
						
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
									++_y;
								}
							}
							else
							{
								ds_grid_set(ID, _x, _y, _array[_x]);
							}
							
							++_x;
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
				
				return self;
			}
			
			// @returns				{string}
			// @description			Encode this Data Structure into a string, from which it can be
			//						recreated.
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
			// @description			Decode a string to which a Data Structure of the same type was
			//						previously encoded into this one.
			//						Use the "legacy" argument if that string was created in old
			//						versions of GameMaker with different encoding.
			static fromEncodedString = function(_string, _legacy = false)
			{
				if ((!is_real(ID)) or (!ds_exists(ID, ds_type_grid)))
				{
					ID = ds_grid_create(0, 0);
				}
				
				ds_grid_read(ID, _string, _legacy);
				
				return self;
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

