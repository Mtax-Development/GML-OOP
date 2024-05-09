//  @function				Grid()
/// @argument				size {Vector2}
/// @description			Constructs a Grid Data Structure, which stores data in a model similar to
///							a two-dimensional array. Each value is stored in its own cell and where it
///							can be read or modified invidually or by operating multiple cells at once
///							in a region or a disk of the Grid.
//							
//							Construction types:
//							- New constructor
//							- Wrapper: grid {int:grid}
//							- Empty: {void|undefined}
//							- Constructor copy: other {Grid}
function Grid() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
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
							
							size = ((is_instanceof(_other.size, Vector2)) ? new Vector2(_other.size)
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
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_handle(ID)) and (ds_exists(ID, ds_type_grid)));
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
			
			/// @argument			value? {any}
			/// @description		Set all values of the Grid to a specified value.
			static clear = function(_value = false)
			{
				try
				{
					ds_grid_clear(ID, _value);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "clear()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			other {Grid}
			/// @description		Replace all data of this Grid with data from another one after
			///						resizing this Grid to match its size.
			static copy = function(_other)
			{
				if ((is_instanceof(_other, Grid)) and (_other.isFunctional()))
				{
					if (!self.isFunctional())
					{
						ID = ds_grid_create(0, 0);
					}
					
					ds_grid_copy(ID, _other.ID);
					
					if (is_instanceof(size, Vector2))
					{
						size.x = ds_grid_width(ID);
						size.y = ds_grid_height(ID);
					}
					else
					{
						size = new Vector2(ds_grid_width(ID), ds_grid_height(ID));
					}
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
			
			/// @argument			value... {any}
			/// @returns			{bool}
			/// @description		Check if this Data Structure contains at least one of the
			///						specified values.
			static contains = function()
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "contains()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			location {Vector4}
			/// @argument			value... {any}
			/// @returns			{bool}
			/// @description		Check if this Data Structure contains at least one of the
			///						specified values in the specified region.
			static containsRegion = function(_location)
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "containsRegion()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			location {Vector2}
			/// @argument			radius {int}
			/// @argument			value... {any}
			/// @returns			{bool}
			/// @description		Check if this Data Structure contains at least one of the
			///						specified values in the specified disk.
			static containsDisk = function(_location, _radius)
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "containsDisk()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			value... {any}
			/// @returns			{int}
			/// @description		Return the number of times the specified values occur in this
			///						Data Structure.
			static count = function()
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "count()"], _exception);
				}
				
				return 0;
			}
			
			/// @argument			location {Vector2}
			/// @returns			{any|undefined}
			/// @description		Return the value of cell at the specified position in this Grid.
			///						Returns {undefined} if this Grid does not exist or the position is
			///						outside it.
			static getValue = function(_location)
			{
				try
				{
					return ds_grid_get(ID, _location.x, _location.y);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getValue()"], _exception);
				}
			}
			
			/// @returns			{int}
			/// @description		Return the amount of cells in this Grid.
			static getCellCount = function()
			{
				try
				{
					return (ds_grid_width(ID) * ds_grid_height(ID));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getCellNumber()"], _exception);
				}
				
				return 0;
			}
			
			/// @argument			position {int}
			/// @returns			{any[]}
			/// @description		Return all values on the specified x position in an array or an
			///						empty array if that position is outside of this Grid.
			static getRow = function(_position)
			{
				try
				{
					if (_position == clamp(_position, 0, (ds_grid_height(ID) - 1)))
					{
						var _row = [];
						var _i = 0;
						repeat (ds_grid_width(ID))
						{
							array_push(_row, ds_grid_get(ID, _i, _position));
							
							++_i;
						}
						
						return _row;
					}
					else
					{
						return [];
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getRow()"], _exception);
				}
				
				return [];
			}
			
			/// @argument			position {int}
			/// @returns			{any[]}
			/// @description		Return all values on the specified y position in an array or an
			///						empty array if that position is outside of this Grid.
			static getColumn = function(_position)
			{
				try
				{
					if (_position == clamp(_position, 0, (ds_grid_width(ID) - 1)))
					{
						var _column = [];
						var _i = 0;
						repeat (ds_grid_height(ID))
						{
							array_push(_column, ds_grid_get(ID, _position, _i));
							
							++_i;
						}
						
						return _column;
					}
					else
					{
						return [];
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getColumn()"], _exception);
				}
			}
			
			/// @argument			location? {Vector4}
			/// @returns			{real} | On error: {undefined}
			/// @description		Return the lowest numerical value found in cells within the
			///						specified region of this Grid.
			///						If the region contains values other than numerical, it might be
			///						found instead and will be returned as {undefined}.
			static getMinimum = function(_location)
			{
				try
				{
					var _result = ((_location == undefined)
								   ? ds_grid_get_min(ID, 0, 0, ds_grid_width(ID), ds_grid_height(ID))
								   : ds_grid_get_min(ID, _location.x1, _location.y1, _location.x2,
													 _location.y2));
					
					return ((is_real(_result) ? _result : undefined));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getMinimum()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			location {Vector2}
			/// @argument			radius {int}
			/// @returns			{real} | On error: {undefined}
			/// @description		Return the lowest numerical value found in cells within the
			///						specified disk of this Grid.
			///						If the disk contains values other than numerical, it might be
			///						found instead and will be returned as {undefined}.
			static getMinimumDisk = function(_location, _radius)
			{
				try
				{
					var _result = ds_grid_get_disk_min(ID, _location.x, _location.y, _radius);
					
					return ((is_real(_result) ? _result : undefined));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getMinimumDisk()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			location? {Vector4}
			/// @returns			{real} | On error: {undefined}
			/// @description		Return the highest numerical value found in cells within the
			///						specified region of this Grid.
			///						If the region contains values other than numerical, it might be
			///						found instead and will be returned as {undefined}.
			static getMaximum = function(_location)
			{
				try
				{
					var _result = ((_location == undefined)
								   ? ds_grid_get_max(ID, 0, 0, ds_grid_width(ID), ds_grid_height(ID))
								   : ds_grid_get_max(ID, _location.x1, _location.y1, _location.x2,
													 _location.y2));
					
					return ((is_real(_result) ? _result : undefined));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getMaximum()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			location {Vector2}
			/// @argument			radius {int}
			/// @returns			{real} | On error: {undefined}
			/// @description		Return the highest numerical value found in cells within the
			///						specified disk of this Grid.
			///						If the disk contains values other than numerical, it might be
			///						found instead and will be returned as {undefined}.
			static getMaximumDisk = function(_location, _radius)
			{
				try
				{
					var _result = ds_grid_get_disk_max(ID, _location.x, _location.y, _radius);
					
					return ((is_real(_result) ? _result : undefined));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getMaximumDisk()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			location? {Vector4}
			/// @returns			{real} | On error: {undefined}
			/// @description		Return the mean number of numerical values found in cells within
			///						the specified region of this Grid.
			///						If the region contains no numerical values, 0 will be returned.
			static getMean = function(_location)
			{
				try
				{	
					return ((_location == undefined) ? ds_grid_get_mean(ID, 0, 0, ds_grid_width(ID),
																		ds_grid_height(ID))
													 : ds_grid_get_mean(ID, _location.x1,
																		_location.y1, _location.x2,
																		_location.y2));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getMean()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			location {Vector2}
			/// @argument			radius {int}
			/// @returns			{real} | On error: {undefined}
			/// @description		Return the mean number of numerical values found in cells within
			///						the specified disk of this Grid.
			///						If the disk contains no numerical values, 0 will be returned.
			static getMeanDisk = function(_location, _radius)
			{
				try
				{
					return ds_grid_get_disk_mean(ID, _location.x, _location.y, _radius);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getMeanDisk()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			location? {Vector4}
			/// @returns			{real|undefined}
			/// @description		Return the sum of numerical values found in cells within
			///						the specified region of this Grid.
			///						Strings containing only numbers will also be included. Other 
			///						values will be ignored. If this Grid does not exist or the region
			///						contains no values that can be summed, {undefined} will be
			///						returned.
			static getSum = function(_location)
			{
				try
				{
					var _result = ((_location == undefined)
								   ? ds_grid_get_sum(ID, 0, 0, ds_grid_width(ID), ds_grid_height(ID))
								   : ds_grid_get_sum(ID, _location.x1, _location.y1, _location.x2,
													 _location.y2));
					
					return (((!is_nan(_result)) and (is_real(_result))) ? _result : undefined);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getSum()"], _exception);
				}
				
				return undefined
			}
			
			/// @argument			location {Vector2}
			/// @argument			radius {int}
			/// @returns			{real|undefined}
			/// @description		Return the sum of numerical values found in cells within
			///						the specified disk of this Grid.
			///						Strings containing only numbers will also be included. Other 
			///						values will be ignored. If this Grid does not exist or the disk
			///						contains no values that can be summed, {undefined} will be
			///						returned.
			static getSumDisk = function(_location, _radius)
			{
				try
				{
					var _result = ds_grid_get_disk_sum(ID, _location.x, _location.y, _radius);
					
					return (((!is_nan(_result)) and (is_real(_result))) ? _result : undefined);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getSumDisk()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			value {any}
			/// @argument			location? {Vector4}
			/// @returns			{Vector2|undefined}
			/// @description		Get the location of a cell containing the specified value
			///						in the specified region of this Grid.
			///						Returns {undefined} if this Grid or the specified value does not
			///						exist.
			static getValueLocation = function(_value, _location)
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getValueLocation()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			value {any}
			/// @argument			location {Vector2}
			/// @argument			radius {int}
			/// @returns			{Vector2|undefined}
			/// @description		Get the location of a cell containing the specified value 
			///						in the specified disk of this Grid.
			///						Returns {undefined} if this Grid or the specified value does not
			///						exist.
			static getValueLocationDisk = function(_value, _location, _radius)
			{
				try
				{
					var _location_x = ds_grid_value_disk_x(ID, _location.x, _location.y, _radius,
														   _value);
					var _location_y = ds_grid_value_disk_y(ID, _location.x, _location.y, _radius,
														   _value);
					
					return ((_location_x >= 0) and (_location_y >= 0))
							? new Vector2(_location_x, _location_y) : undefined;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getValueLocationDisk()"], _exception);
				}
				
				return undefined;
			}
			
		#endregion
		#region <Setters>
			
			/// @argument			size {Vector2}
			/// @description		Change the size of this Grid. If the specified size is lower than
			///						current, values from the end will be removed. If the specified
			///						size is higher than current, values in new cells will be set to
			///						the default value of 0.
			static setSize = function(_size)
			{
				try
				{
					ds_grid_resize(ID, _size.x, _size.y);
					
					if (is_instanceof(size, Vector2))
					{
						size.x = _size.x;
						size.y = _size.y;
					}
					else
					{
						size = new Vector2(_size.x, _size.y);
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setSize()"], _exception);
				}
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			function {function}
			/// @argument			argument? {any}
			/// @returns			{any[]}
			/// @description		Execute a function once for each element in this Data Structure.
			///						The following arguments will be provided to the function and can
			///						be accessed in it by using their name or the argument array:
			///						- argument[0]: _x {int}
			///						- argument[1]: _y {int}
			///						- argument[2]: _value {any}
			///						- argument[3]: _argument {any}
			static forEach = function(__function, _argument)
			{
				var _dataCopy = ds_grid_create(0, 0);
				
				try
				{
					var _size_x = ds_grid_width(ID);
					var _size_y = ds_grid_height(ID);
					ds_grid_copy(_dataCopy, ID);
					var _functionReturn = [];
					var _y = 0;
					repeat (_size_y)
					{
						var _x = 0;
						repeat (_size_x)
						{
							var _value = ds_grid_get(_dataCopy, _x, _y);
							
							try
							{
								array_push(_functionReturn, __function(_x, _y, _value, _argument));
							}
							catch (_exception)
							{
								new ErrorReport().report([other, self, "forEach()", "function()"],
														 _exception);
							}
							
							++_x;
						}
						
						++_y;
					}
					
					return _functionReturn;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "forEach()"], _exception);
				}
				finally
				{
					ds_grid_destroy(_dataCopy);
				}
				
				return [];
			}
			
			/// @argument			value... {any}
			/// @argument			location... {Vector2}
			/// @description		Replace any number of values in the specified cells in this Grid
			///						by the specified values.
			static set = function()
			{
				var _i = 0;
				repeat (argument_count div 2)
				{
					try
					{
						var _value = argument[_i];
						var _location = argument[(_i + 1)];
							
						ds_grid_set(ID, _location.x, _location.y, _value);
					}
					catch (_exception)
					{
						new ErrorReport().report([other, self, "set()"], _exception);
					}
					
					_i += 2;
				}
				
				return self;
			}
			
			/// @argument			value {any}
			/// @argument			location? {Vector4}
			/// @description		Replace the values of cells of the specified region in this Grid
			///						by the specified value.
			static setRegion = function(_value, _location)
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setRegion()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {any}
			/// @argument			location {Vector2}
			/// @argument			radius {int}
			/// @description		Replace the values of cells of the specified disk in this Grid by
			///						the specified value.
			static setDisk = function(_value, _location, _radius)
			{
				try
				{
					ds_grid_set_disk(ID, _location.x, _location.y, _radius, _value);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setDisk()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			target {Vector2}
			/// @argument			source {Vector4}
			/// @argument			other? {Grid}
			/// @description		Copy values of cells from the specified region in this or
			///						specified other Grid and replace the values of cells in the 
			///						region of the same size in this Grid, starting from the specified
			///						target location.
			static setRegionCopied = function(_target, _source, _other = self)
			{
				try
				{
					ds_grid_set_grid_region(ID, _other.ID, _source.x1, _source.y1, _source.x2,
											_source.y2, _target.x, _target.y);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setRegionCopied()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value... {real|string}
			/// @argument			location... {Vector2}
			/// @description		Add the specified values to any number of values in the specified
			///						cells of this Grid.
			///						The values will be replaced if they are not the same type as the 
			///						one already existing in the cell.
			static add = function(_value, _location)
			{
				var _i = 0;
				repeat (argument_count div 2)
				{
					_value = argument[_i];
					_location = argument[(_i + 1)];
					
					try
					{
						ds_grid_add(ID, _location.x, _location.y, _value);
					}
					catch (_exception)
					{
						new ErrorReport().report([other, self, "add()"], _exception);
					}
					
					_i += 2;
				}
				
				return self;
			}
			
			/// @argument			value {real|string}
			/// @argument			location? {Vector4}
			/// @description		Add the specified value to values in cells in the specified
			///						region of this Grid.
			///						The values will be replaced if they are not the same type as the 
			///						one already existing in the cell.
			static addRegion = function(_value, _location)
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "addRegion()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real|string}
			/// @argument			location {Vector2}
			/// @argument			radius {int}
			/// @description		Add the specified value to values in cells in the specified disk
			///						of this Grid.
			///						The values will be replaced if they are not the same type as the 
			///						one already existing in the cell.
			static addDisk = function(_value, _location, _radius)
			{
				try
				{
					ds_grid_add_disk(ID, _location.x, _location.y, _radius, _value);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "addDisk()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			target {Vector2}
			/// @argument			source {Vector4}
			/// @argument			other? {Grid}
			/// @description		Copy values of cells from the specified region of this or 
			///						specified other Grid and add them to values of cells in the
			///						region of the same size in this Grid, starting from the specified
			///						target location.
			///						The value will be replaced if it is not the same type as the 
			///						one already existing in the cell.
			static addRegionCopied = function(_target, _source, _other = self)
			{
				try
				{
					ds_grid_add_grid_region(ID, _other.ID, _source.x1, _source.y1, _source.x2,
												_source.y2, _target.x, _target.y);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "addRegionCopied()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value... {real}
			/// @argument			location... {Vector2}
			/// @description		Multiply by the specified values any number of numerical values
			///						in the specified cells of this Grid.
			static multiply = function(_value, _location)
			{
				var _i = 0;
				repeat (argument_count div 2)
				{
					try
					{
						_value = argument[_i];
						_location = argument[(_i + 1)];
						
						ds_grid_multiply(ID, _location.x, _location.y, _value);
					}
					catch (_exception)
					{
						new ErrorReport().report([other, self, "multiply()"], _exception);
					}
					
					_i += 2;
				}
				
				return self;
			}
			
			/// @argument			value {real}
			/// @argument			location? {Vector4}
			/// @description		Multiply by the specified value the numerical values in cells in
			///						the specified region of this Grid.
			static multiplyRegion = function(_value, _location)
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "multiplyRegion()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real}
			/// @argument			location {Vector2}
			/// @argument			radius {int}
			/// @description		Multiply by the specified value the numerical values in cells in
			///						the specified disk of this Grid.
			static multiplyDisk = function(_value, _location, _radius)
			{
				try
				{
					ds_grid_multiply_disk(ID, _location.x, _location.y, _radius, _value);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "multiplyDisk()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			target {Vector2}
			/// @argument			source {Vector4}
			/// @argument			other? {Grid}
			/// @description		Copy values of cells from the specified region of this or 
			///						specified other Grid and multiply by them the number values of
			///						cells in the region of the same size in this Grid, starting from 
			///						the specified target location.
			static multiplyRegionCopied = function(_target, _source, _other = self)
			{
				try
				{
					ds_grid_multiply_grid_region(ID, _other.ID, _source.x1, _source.y1, _source.x2,
												 _source.y2, _target.x, _target.y);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "multiplyRegionCopied()"], _exception);
				}
				
				return self;
			}
			
			/// @description		Flip the cells of this Grid horizontally.
			static mirrorX = function()
			{
				var _target = ds_grid_create(0, 0);
				
				try
				{
					var _size_x = ds_grid_width(ID);
					var _size_y = ds_grid_height(ID);
					ds_grid_resize(_target, _size_x, _size_y);
					var _size_x_index = (_size_x - 1);
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
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "mirrorX()"], _exception);
				}
				finally
				{
					ds_grid_destroy(_target);
				}
				
				return self;
			}
			
			/// @description		Flip the cells of this Grid vertically.
			static mirrorY = function()
			{
				var _target = ds_grid_create(0, 0);
				
				try
				{
					var _size_x = ds_grid_width(ID);
					var _size_y = ds_grid_height(ID);
					ds_grid_resize(_target, _size_x, _size_y);
					var _size_y_index = (_size_y - 1);
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
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "mirrorY()"], _exception);
				}
				finally
				{
					ds_grid_destroy(_target);
				}
				
				return self;
			}
			
			/// @description		Swap the columns and rows of this Grid.
			static transpose = function()
			{
				var _target = ds_grid_create(0, 0);
				
				try
				{
					var _size_x = ds_grid_width(ID);
					var _size_y = ds_grid_height(ID);
					ds_grid_resize(_target, _size_y, _size_x);
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
					
					if (is_instanceof(size, Vector2))
					{
						size.x = _size_y;
						size.y = _size_x;
					}
					else
					{
						size = new Vector2(_size_y, _size_x);
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "transpose()"], _exception);
				}
				finally
				{
					ds_grid_destroy(_target);
				}
				
				return self;
			}
			
			/// @argument			column {int}
			/// @argument			orderAscending {bool}
			/// @description		Sort all cells in this Grid by individually sorting the specified
			///						vertical cell column and then applying its sort order to other
			///						columns.
			static sort = function(_column, _orderAscending)
			{
				try
				{
					ds_grid_sort(ID, _column, _orderAscending);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "sort()"], _exception);
				}
				
				return self;
			}
			
			/// @description		Randomize positions of all cells in this Grid.
			static shuffle = function()
			{
				try
				{
					ds_grid_shuffle(ID);
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
			static toString = function(_multiline = false, _elementNumber = 10, _elementLength,
									   _mark_separator = ", ", _mark_cut = "...",
									   _mark_elementStart = "[", _mark_elementEnd = "]",
									   _mark_sizeSeparator = " - ")
			{
				if (self.isFunctional())
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
			
			/// @returns			{any[]}
			/// @description		Create an array with values of all cells in this Grid.
			static toArray = function()
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "tpArray()"], _exception);
				}
				
				return [[], []];
			}
			
			/// @argument			array {any[]}
			/// @argument			default? {any}
			/// @description		Replace this Grid with one that has the size and values of the
			///						specified 1D or 2D array.
			///						Since arrays can have columns of varying sizes and represent no
			///						value in some Grid cells, a default value will be used in such 
			///						cases.
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
						
						if (self.isFunctional())
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
					return ds_grid_write(ID);
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
						ID = ds_grid_create(0, 0);
					}
					
					ds_grid_read(ID, _string, _legacy);
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
