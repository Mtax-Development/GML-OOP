//  @function				Point()
/// @argument				location {Vector2}
/// @argument				color? {int:color}
/// @argument				alpha? {real}
/// @description			Constructs a Point shape, which is a single pixel.
//							
//							Construction types:
//							- New constructor
//							- Empty: {void}
//							- Constructor copy: {Point} other
function Point() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				location = undefined;
				color = undefined;
				alpha = undefined;
				
				event =
				{
					beforeRender: new Callback(undefined, [], other),
					afterRender: new Callback(undefined, [], other)
				};
				
				if (argument_count > 0)
				{
					if (is_instanceof(argument[0], Point))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						location = ((is_instanceof(_other.location, Vector2))
									? new Vector2(_other.location) : _other.location);
						color = _other.color;
						alpha = _other.alpha;
						
						if (is_struct(_other.event))
						{
							event.beforeRender.setAll(_other.event.beforeRender);
							event.afterRender.setAll(_other.event.afterRender);
						}
						else
						{
							event = _other.event;
						}
					}
					else
					{
						location = argument[0];
						color = (((argument_count > 1) and (argument[1] != undefined)) ? argument[1]
																					   : c_white);
						alpha = (((argument_count > 2) and (argument[2] != undefined)) ? argument[2]
																					   : 1);
					}
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_instanceof(location, Vector2)) and (location.isFunctional()));
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			object {int:object}
			/// @argument			precise? {bool}
			/// @argument			excludedInstance? {int:instance}
			/// @argument			list? {bool|List}
			/// @argument			listOrdered? {bool}
			/// @returns			{int|List}
			/// @description		Check for a collision within this Shape with instances of the
			///						specified object.
			///						Returns the ID of a single colliding instance or noone.
			///						If List use is specified, a List will be returned instead, either
			///						empty or containing IDs of the colliding instances.
			///						If specified, the additions to that List can be ordered by 
			///						distance from the center of the Shape.
			static collision = function(_object, _precise = false, _excludedInstance, _list = false,
										_listOrdered = false)
			{
				var _list_created = false;
				
				try
				{
					if (_list)
					{
						if (!is_instanceof(_list, List))
						{
							_list = new List();
							_list_created = true;
						}
						
						if ((is_real(_excludedInstance)) and (instance_exists(_excludedInstance)))
						{
							with (_excludedInstance)
							{
								collision_point_list(other.location.x, other.location.y, _object,
													 _precise, true, _list.ID, _listOrdered);
							}
						}
						else
						{
							collision_point_list(location.x, location.y, _object, _precise, false,
												 _list.ID, _listOrdered);
						}
						
						return _list;
					}
					else
					{
						if ((is_real(_excludedInstance)) and (instance_exists(_excludedInstance)))
						{
							with (_excludedInstance)
							{
								return collision_point(other.location.x, other.location.y, _object,
													   _precise, true);
							}
						}
						else
						{
							return collision_point(location.x, location.y, _object, _precise, false);
						}
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "collision()"], _exception);
					
					if (_list_created)
					{
						_list.destroy();
					}
				}
				
				return noone;
			}
			
			/// @argument			device? {int}
			/// @argument			GUI? {bool}
			/// @returns			{bool}
			/// @description		Check if the cursor is over this Shape.
			///						If the device is specified, the position of the cursor on the GUI
			///						layer can be used.
			static cursorOver = function(_device, _GUI = false)
			{
				try
				{
					var _cursor_x, _cursor_y;
					
					if (_device == undefined)
					{
						_cursor_x = mouse_x;
						_cursor_y = mouse_y;
					}
					else
					{
						if (_GUI)
						{
							_cursor_x = device_mouse_x_to_gui(_device);
							_cursor_y = device_mouse_y_to_gui(_device);
						}
						else
						{
							_cursor_x = device_mouse_x(_device);
							_cursor_y = device_mouse_y(_device);
						}
					}
					
					return ((_cursor_x == location.x) and (_cursor_y == location.y));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "cursorOver()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			button {constant:mb_*}
			/// @argument			device? {int}
			/// @argument			GUI? {bool}
			/// @returns			{bool}
			/// @description		Check if the cursor is over this Shape while its specified mouse
			///						button is pressed or held.
			///						If the device is specified, the position of the cursor on the GUI
			///						layer can be used.
			static cursorHold = function(_button, _device, _GUI = false)
			{
				try
				{
					var _cursor_x, _cursor_y;
					
					if (_device == undefined)
					{
						_cursor_x = mouse_x;
						_cursor_y = mouse_y;
					}
					else
					{
						if (_GUI)
						{
							_cursor_x = device_mouse_x_to_gui(_device);
							_cursor_y = device_mouse_y_to_gui(_device);
						}
						else
						{
							_cursor_x = device_mouse_x(_device);
							_cursor_y = device_mouse_y(_device);
						}
					}
					
					if ((_cursor_x == location.x) and (_cursor_y == location.y))
					{
						return ((_device == undefined) ? mouse_check_button(_button)
													   : device_mouse_check_button(_device, _button))
					}
					else
					{
						return false;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "cursorHold()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			button {constant:mb_*}
			/// @argument			device? {int}
			/// @argument			GUI? {bool}
			/// @returns			{bool}
			/// @description		Check if the cursor is over this Shape while its specified mouse
			///						button was pressed in this frame.
			///						If the device is specified, the position of the cursor on the GUI
			///						layer can be used.
			static cursorPressed = function(_button, _device, _GUI = false)
			{
				try
				{
					var _cursor_x, _cursor_y;
					
					if (_device == undefined)
					{
						_cursor_x = mouse_x;
						_cursor_y = mouse_y;
					}
					else
					{
						if (_GUI)
						{
							_cursor_x = device_mouse_x_to_gui(_device);
							_cursor_y = device_mouse_y_to_gui(_device);
						}
						else
						{
							_cursor_x = device_mouse_x(_device);
							_cursor_y = device_mouse_y(_device);
						}
					}
					
					if ((_cursor_x == location.x) and (_cursor_y == location.y))
					{	
						return ((_device == undefined) ? mouse_check_button_pressed(_button)
													   : device_mouse_check_button_pressed(_device,
																						   _button))
					}
					else
					{
						return false;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "cursorPressed()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			button {constant:mb_*}
			/// @argument			device? {int}
			/// @argument			GUI? {bool}
			/// @returns			{bool}
			/// @description		Check if the cursor is over this Shape while the specified mouse
			///						button was released in this frame.
			///						If the device is specified, the position of the cursor on the GUI
			///						layer can be used.
			static cursorReleased = function(_button, _device, _GUI = false)
			{
				try
				{
					var _cursor_x, _cursor_y;
					
					if (_device == undefined)
					{
						_cursor_x = mouse_x;
						_cursor_y = mouse_y;
					}
					else
					{
						if (_GUI)
						{
							_cursor_x = device_mouse_x_to_gui(_device);
							_cursor_y = device_mouse_y_to_gui(_device);
						}
						else
						{
							_cursor_x = device_mouse_x(_device);
							_cursor_y = device_mouse_y(_device);
						}
					}
					
					if ((_cursor_x == location.x) and (_cursor_y == location.y))
					{	
						return ((_device == undefined) ? mouse_check_button_released(_button)
													   : device_mouse_check_button_released(_device,
																							_button))
					}
					else
					{
						return false;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "cursorReleased()"], _exception);
				}
				
				return false;
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			location? {Vector2}
			/// @argument			color? {int:color}
			/// @argument			alpha? {real}
			/// @description		Execute the draw of this Shape as a sprite, using data of this
			///						constructor or its specified temporarily replaced parts.
			static render = function(_location, _color, _alpha)
			{
				static _pixel = function()
				{
					var _surface = surface_create(1, 1);
					surface_set_target(_surface);
					{
						draw_clear(c_white);
					}
					surface_reset_target();
					
					var _sprite = sprite_create_from_surface(_surface, 0, 0, 1, 1, false, false, 0, 0);
					surface_free(_surface);
					
					return _sprite;
				}();
				
				var _location_original = location;
				var _color_original = color;
				var _alpha_original = alpha;
				
				location = (_location ?? location);
				color = (_color ?? color);
				alpha = (_alpha ?? alpha);
				
				try
				{
					if (self.isFunctional())
					{
						event.beforeRender.execute();
						
						if (alpha > 0)
						{
							draw_sprite_ext(_pixel, 0, location.x, location.y, -1, -1, 0, color,
											alpha);
						}
						
						event.afterRender.execute();
					}
					else
					{
						new ErrorReport().report([other, self, "render()"],
												 ("Attempted to render an invalid Shape: " +
												  "{" + string(self) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "render()"], _exception);
				}
				finally
				{
					location = _location_original;
					color = _color_original;
					alpha = _alpha_original;
				}
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @argument			full? {bool}
			/// @argument			colorHSV? {bool}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented with the properties of this Shape.
			static toString = function(_multiline = false, _full = false, _colorHSV = false)
			{
				var _string = "";
				var _mark_separator = ((_multiline) ? "\n" : ", ");
				
				if (!_full)
				{
					_string = ("Location: " + string(location));
				}
				else
				{
					var _string_color;
					var _mark_separator_inline = ", ";
					
					if (is_real(color))
					{
						switch (color)
						{
							case c_aqua: _string_color = "Aqua"; break;
							case c_black: _string_color = "Black"; break;
							case c_blue: _string_color = "Blue"; break;
							case c_dkgray: _string_color = "Dark Gray"; break;
							case c_fuchsia: _string_color = "Fuchsia"; break;
							case c_gray: _string_color = "Gray"; break;
							case c_green: _string_color = "Green"; break;
							case c_lime: _string_color = "Lime"; break;
							case c_ltgray: _string_color = "Light Gray"; break;
							case c_maroon: _string_color = "Maroon"; break;
							case c_navy: _string_color = "Navy"; break;
							case c_olive: _string_color = "Olive"; break;
							case c_orange: _string_color = "Orange"; break;
							case c_purple: _string_color = "Purple"; break;
							case c_red: _string_color = "Red"; break;
							case c_teal: _string_color = "Teal"; break;
							case c_white: _string_color = "White"; break;
							case c_yellow: _string_color = "Yellow"; break;
							default:
								if (_colorHSV)
								{
									_string_color =
									("(" +
									 "Hue: " + string(color_get_hue(color))
											 + _mark_separator_inline +
									 "Saturation: " + string(color_get_saturation(color))
													+ _mark_separator_inline +
									 "Value: " + string(color_get_value(color)) +
									 ")");
								}
								else
								{
									_string_color =
									("(" +
									 "Red: " + string(color_get_red(color)) + _mark_separator_inline +
									 "Green: " + string(color_get_green(color))
											   + _mark_separator_inline +
									 "Blue: " + string(color_get_blue(color)) +
									 ")");
								}
							break;
						}
					}
					else
					{
						_string_color = string(color);
					}
				
					var _string = ("Location: " + string(location) + _mark_separator +
								   "Color: " + _string_color + _mark_separator +
								   "Alpha: " + string(alpha));
				}
				
				return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
			}
			
			/// @argument			location? {Vector2}
			/// @argument			color? {int:color}
			/// @argument			alpha? {real}
			/// @returns			{VertexBuffer.PrimitiveRenderData} | On error: {undefined}
			/// @description		Return rendering data of this constructor in a Vertex Buffer, using
			///						its current data or its specified temporarily replaced parts.
			///						Either a single value or an array of two values will be returned,
			///						depending on whether the fill or outline were specified as the only
			///						returned value or both as {all}.
			static toVertexBuffer = function(_location, _color, _alpha)
			{
				var _vertexBuffer = undefined;
				var _renderData = undefined;
				var _location_original = location;
				var _color_original = color;
				var _alpha_original = alpha;
				
				location = (_location ?? location);
				color = (_color ?? color);
				alpha = (_alpha ?? alpha);
				
				try
				{
					color = ((is_real(color)) ? color : c_white);
					alpha = ((alpha > 0) ? alpha : 0);
					_vertexBuffer = new VertexBuffer();
					_renderData = _vertexBuffer.createPrimitiveRenderData(pr_pointlist);
					
					_vertexBuffer
					 .setActive(_renderData.passthroughFormat)
						.setLocation(location)
						.setColor(color, alpha)
						.setUV()
					 .setActive(false);
				}	
				catch (_exception)
				{
					if (_vertexBuffer != undefined)
					{
						_vertexBuffer.destroy();
					}
					
					new ErrorReport().report([other, self, "toVertexBuffer()"], _exception);
				}
				
				location = _location_original;
				color = _color_original;
				alpha = _alpha_original;
				
				return _renderData;
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static constructor = Point;
		
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
