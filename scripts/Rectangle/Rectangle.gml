//  @function				Rectangle()
/// @argument				location {Vector4}
/// @argument				fill_color? {int:color|Color4}
/// @argument				fill_alpha? {real}
/// @argument				outline_color? {int:color|Color4}
/// @argument				outline_size? {int}
/// @argument				outline_alpha? {real}
/// @description			Constructs a Rectangle shape.
//							
//							Construction types:
//							- New constructor
//							- Empty: {void}
//							- Constructor copy: other {Rectangle}
function Rectangle() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				location = undefined;
				fill_color = undefined;
				fill_alpha = undefined;
				outline_color = undefined;
				outline_size = undefined;
				outline_alpha = undefined;
				
				event =
				{
					beforeRender: new Callback(undefined, [], other),
					afterRender: new Callback(undefined, [], other)
				};
				
				if (argument_count > 0)
				{
					if (is_instanceof(argument[0], Rectangle))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						location = ((is_instanceof(_other.location, Vector4))
									? new Vector4(_other.location) : _other.location);
						fill_color = ((is_instanceof(_other.fill_color, Color4))
									  ? new Color4(_other.fill_color) : _other.fill_color);
						fill_alpha = _other.fill_alpha;
						outline_color = ((is_instanceof(_other.outline_color, Color4))
										 ? new Color4(_other.outline_color) : _other.outline_color);
						outline_size = _other.outline_size;
						outline_alpha = _other.outline_alpha;
						
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
						//|Construction type: New constructor.
						location = argument[0];
						fill_color = (((argument_count > 1)) ? argument[1] : undefined);
						fill_alpha = (((argument_count > 2) and (argument[2] != undefined))
									  ? argument[2] : 1);
						outline_color = ((argument_count > 3) ? argument[3] : undefined);
						outline_size = (((argument_count > 4) and (argument[4] != undefined))
										? argument[4] : 0);
						outline_alpha = (((argument_count > 5) and (argument[5] != undefined))
										 ? argument[5] : 1);
					}
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_instanceof(location, Vector4)) and (location.isFunctional()));
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			other {Rectangle}
			/// @returns			{bool}
			/// @description		Check if specified constructor has equivalent properties.
			static equals = function(_other)
			{
				return ((is_instanceof(_other, Rectangle)) and (fill_alpha == _other.fill_alpha)
						and (outline_size == _other.outline_size)
						and (outline_alpha == _other.outline_alpha)
						and ((location == _other.location)
						or ((string_copy(instanceof(location), 1, 6) == "Vector")
						and (location.equals(_other.location))))
						and ((fill_color == _other.fill_color)
						or ((string_copy(instanceof(fill_color), 1, 5) == "Color")
						and (fill_color.equals(_other.fill_color))))
						and ((outline_color == _other.outline_color)
						or ((string_copy(instanceof(outline_color), 1, 5) == "Color")
						and (outline_color.equals(_other.outline_color)))));
			}
			
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
								collision_rectangle_list(other.location.x1, other.location.y1,
														 other.location.x2, other.location.y2,
														 _object, _precise, true, _list.ID,
														 _listOrdered);
							}
						}
						else
						{
							collision_rectangle_list(location.x1, location.y1, location.x2,
													 location.y2, _object, _precise, false, _list.ID,
													 _listOrdered);
						}
						
						return _list;
					}
					else
					{
						if ((is_real(_excludedInstance)) and (instance_exists(_excludedInstance)))
						{
							with (_excludedInstance)
							{
								return collision_rectangle(other.location.x1, other.location.y1, 
														   other.location.x2, other.location.y2,
														   _object,  _precise, true);
							}
						}
						else
						{
							return collision_rectangle(location.x1, location.y1, location.x2,
													   location.y2, _object, _precise, false);
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
			
			/// @argument			point {Vector2}
			/// @returns			{bool}
			/// @description		Checks whether a point in space is within this Rectangle.
			static containsPoint = function(_point)
			{
				try
				{
					return point_in_rectangle(_point.x, _point.y, location.x1, location.y1,
											  location.x2, location.y2);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "containsPoint()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			device? {int}
			/// @argument			GUI? {bool}
			/// @returns			{bool}
			/// @description		Check if the system cursor is over this Shape.
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
					
					return ((_cursor_x == clamp(_cursor_x, location.x1, location.x2)) 
							and (_cursor_y == clamp(_cursor_y, location.y1, location.y2)));
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
			/// @description		Check if the system cursor is over this Shape while its specified
			///						mouse button is pressed or held.
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
					
					if ((_cursor_x == clamp(_cursor_x, location.x1, location.x2))
					and (_cursor_y == clamp(_cursor_y, location.y1, location.y2)))
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
			/// @description		Check if the system cursor is over this Shape while its specified
			///						mouse button was pressed in this frame.
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
					
					if ((_cursor_x == clamp(_cursor_x, location.x1, location.x2))
					and (_cursor_y == clamp(_cursor_y, location.y1, location.y2)))
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
			/// @description		Check if the system cursor is over this Shape while the specified
			///						mouse button was released in this frame.
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
					
					if ((_cursor_x == clamp(_cursor_x, location.x1, location.x2))
					and (_cursor_y == clamp(_cursor_y, location.y1, location.y2)))
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
			
			/// @argument			location? {Vector4}
			/// @argument			fill_color? {int:color|Color4}
			/// @argument			fill_alpha? {real}
			/// @argument			outline_color? {int:color|Color4}
			/// @argument			outline_size? {int}
			/// @argument			outline_alpha? {real}
			/// @description		Execute the draw of this Shape as a sprite, using data of this
			///						constructor or its specified temporarily replaced parts.
			static render = function(_location, _fill_color, _fill_alpha, _outline_color,
									 _outline_size, _outline_alpha)
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
				var _fill_color_original = fill_color;
				var _fill_alpha_original = fill_alpha;
				var _outline_color_original = outline_color;
				var _outline_size_original = outline_size;
				var _outline_alpha_original = outline_alpha;
				
				location = (_location ?? location);
				fill_color = (_fill_color ?? fill_color);
				fill_alpha = (_fill_alpha ?? fill_alpha);
				outline_color = (_outline_color ?? outline_color);
				outline_size = (_outline_size ?? outline_size);
				outline_alpha = (_outline_alpha ?? outline_alpha);
				
				try
				{
					if (self.isFunctional())
					{
						event.beforeRender.execute();
						
						var _x1 = min(location.x1, location.x2);
						var _x2 = max(location.x1, location.x2);
						var _y1 = min(location.y1, location.y2);
						var _y2 = max(location.y1, location.y2);
						var _width = (_x2 - _x1);
						var _height = (_y2 - _y1);
						
						if ((fill_color != undefined) and (fill_alpha > 0))
						{
							var _color1, _color2, _color3, _color4;
							
							if (is_instanceof(fill_color, Color4))
							{
								_color1 = fill_color.color1;
								_color2 = fill_color.color2;
								_color3 = fill_color.color3;
								_color4 = fill_color.color4;
							}
							else
							{
								_color1 = fill_color;
								_color2 = fill_color;
								_color3 = fill_color;
								_color4 = fill_color;
							}
							
							draw_sprite_general(_pixel, 0, 0, 0, 1, 1, _x1, _y1, _width, _height, 0,
												_color1, _color2, _color3, _color4, fill_alpha);
						}
						
						if ((outline_color != undefined) and (outline_size != 0)
						and (outline_alpha > 0))
						{
							var _color1, _color2, _color3, _color4;
							
							if (is_instanceof(outline_color, Color4))
							{
								_color1 = outline_color.color1;
								_color2 = outline_color.color2;
								_color3 = outline_color.color3;
								_color4 = outline_color.color4;
							}
							else
							{
								_color1 = outline_color;
								_color2 = outline_color;
								_color3 = outline_color;
								_color4 = outline_color;
							}
							
							//|Top.
							draw_sprite_general(_pixel, 0, 0, 0, 1, 1, (_x1 - outline_size),
												(_y1 - outline_size), (_width + outline_size),
												outline_size, 0, _color1, _color2, _color2, _color1,
												outline_alpha);
							
							//|Left.
							draw_sprite_general(_pixel, 0, 0, 0, 1, 1, (_x1 - outline_size), _y1,
												outline_size, (_height + outline_size), 0, _color1,
												_color1, _color4, _color4, outline_alpha);
							
							//|Bottom.
							draw_sprite_general(_pixel, 0, 0, 0, 1, 1, (_x1),
												(_y2 + outline_size), ((_width + outline_size)),
												(-outline_size), 0, _color4, _color3, _color3, _color4,
												outline_alpha);
							
							//|Right.
							draw_sprite_general(_pixel, 0, 0, 0, 1, 1, (_x2 + outline_size),
												(_y1 - outline_size), (-outline_size),
												(_height + outline_size), 0, _color2, _color2, _color3,
												_color3, outline_alpha);
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
					fill_color = _fill_color_original;
					fill_alpha = _fill_alpha_original;
					outline_color = _outline_color_original;
					outline_size = _outline_size_original;
					outline_alpha = _outline_alpha_original;
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
					var _color = [fill_color, outline_color];
					var _color_count = array_length(_color);
					var _string_color = array_create(_color_count, "");
					var _mark_separator_inline = ", ";
					
					var _i = 0;
					repeat (_color_count)
					{
						if (is_real(_color[_i]))
						{
							switch (_color[_i])
							{
								case c_aqua: _string_color[_i] = "Aqua"; break;
								case c_black: _string_color[_i] = "Black"; break;
								case c_blue: _string_color[_i] = "Blue"; break;
								case c_dkgray: _string_color[_i] = "Dark Gray"; break;
								case c_fuchsia: _string_color[_i] = "Fuchsia"; break;
								case c_gray: _string_color[_i] = "Gray"; break;
								case c_green: _string_color[_i] = "Green"; break;
								case c_lime: _string_color[_i] = "Lime"; break;
								case c_ltgray: _string_color[_i] = "Light Gray"; break;
								case c_maroon: _string_color[_i] = "Maroon"; break;
								case c_navy: _string_color[_i] = "Navy"; break;
								case c_olive: _string_color[_i] = "Olive"; break;
								case c_orange: _string_color[_i] = "Orange"; break;
								case c_purple: _string_color[_i] = "Purple"; break;
								case c_red: _string_color[_i] = "Red"; break;
								case c_teal: _string_color[_i] = "Teal"; break;
								case c_white: _string_color[_i] = "White"; break;
								case c_yellow: _string_color[_i] = "Yellow"; break;
								default:
									if (_colorHSV)
									{
										_string_color[_i] =
										("(" +
										 "Hue: " + string(color_get_hue(_color[_i]))
												 + _mark_separator_inline +
										 "Saturation: " + string(color_get_saturation(_color[_i]))
														+ _mark_separator_inline +
										 "Value: " + string(color_get_value(_color[_i])) +
										 ")");
									}
									else
									{
										_string_color[_i] =
										("(" +
										 "Red: " + string(color_get_red(_color[_i]))
												 + _mark_separator_inline +
										 "Green: " + string(color_get_green(_color[_i]))
												   + _mark_separator_inline +
										 "Blue: " + string(color_get_blue(_color[_i])) +
										 ")");
									}
								break;
							}
						}
						else
						{
							if (is_instanceof(_color[_i], Color4))
							{
								_string_color[_i] = _color[_i].toString(false, _colorHSV);
							}
							else
							{
								_string_color[_i] = string(_color[_i]);
							}
						}
						
						++_i;
					}
					
					_string = ("Location: " + string(location) + _mark_separator +
							   "Fill Color: " + _string_color[0] + _mark_separator +
							   "Fill Alpha: " + string(fill_alpha) + _mark_separator +
							   "Outline Color: " + _string_color[1] + _mark_separator +
							   "Outline Size: " + string(outline_size) + _mark_separator +
							   "Outline Alpha: " + string(outline_alpha));
				}
				
				return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
			}
			
			/// @returns			{real[+]}
			/// @description		Return an array containing values of all properties of this Shape.
			///						Properties with multiple values will be returned in nested arrays.
			static toArray = function()
			{
				var _location = ((is_instanceof(location, Vector4)) ? location.toArray() : location);
				var _fill_color = ((is_instanceof(fill_color, Color4)) ? fill_color.toArray()
																		: fill_color);
				var _outline_color = ((is_instanceof(outline_color, Color4))
									  ? outline_color.toArray() : outline_color);
				
				return [_location, _fill_color, fill_alpha, _outline_color, outline_size,
						outline_alpha];
			}
			
			/// @argument			outline? {bool|all}
			/// @argument			location? {Vector4}
			/// @argument			fill_color? {int:color|Color4}
			/// @argument			fill_alpha? {real}
			/// @argument			outline_color? {int:color|Color4}
			/// @argument			outline_size? {int}
			/// @argument			outline_alpha? {real}
			/// @returns			{VertexBuffer.PrimitiveRenderData|
			///						 VertexBuffer.PrimitiveRenderData[]} | On error: {undefined}
			/// @description		Return rendering data of this constructor in a Vertex Buffer, using
			///						its current data or its specified temporarily replaced parts.
			///						Either a single value or an array of two values will be returned,
			///						depending on whether the fill or outline were specified as the only
			///						returned value or both as {all}.
			static toVertexBuffer = function(_outline = false, _location, _fill_color, _fill_alpha,
											 _outline_color, _outline_size, _outline_alpha)
			{
				var _vertexBuffer_fill = undefined;
				var _vertexBuffer_outline = undefined;
				var _location_original = location;
				var _fill_color_original = fill_color;
				var _fill_alpha_original = fill_alpha;
				var _outline_color_original = outline_color;
				var _outline_size_original = outline_size;
				var _outline_alpha_original = outline_alpha;
				
				location = (_location ?? location);
				fill_color = (_fill_color ?? fill_color);
				fill_alpha = (_fill_alpha ?? fill_alpha);
				outline_color = (_outline_color ?? outline_color);
				outline_size = (_outline_size ?? outline_size);
				outline_alpha = (_outline_alpha ?? outline_alpha);
				
				try
				{
					var _result = [];
					var _vertex = new Vector2();
					
					if ((!_outline) or (_outline == all))
					{
						fill_color = ((is_real(fill_color)) ? fill_color : c_white);
						fill_alpha = ((fill_alpha > 0) ? fill_alpha : 0);
						_vertexBuffer_fill = new VertexBuffer();
						var _renderData_fill = _vertexBuffer_fill
												.createPrimitiveRenderData(pr_trianglestrip);
						
						_vertexBuffer_fill
						 .setActive(_renderData_fill.passthroughFormat)
							.setLocation(_vertex.set(location.x1, location.y1))
							.setColor(fill_color, fill_alpha)
							.setUV()
							
							.setLocation(_vertex.set(location.x2, location.y1))
							.setColor(fill_color, fill_alpha)
							.setUV()
							
							.setLocation(_vertex.set(location.x1, location.y2))
							.setColor(fill_color, fill_alpha)
							.setUV()
							
							.setLocation(_vertex.set(location.x2, location.y2))
							.setColor(fill_color, fill_alpha)
							.setUV()
						 .setActive(false);
						
						array_push(_result, _renderData_fill);
					}
					
					if (((_outline) or (_outline == all)) and (outline_size >= 1))
					{
						outline_color = ((is_real(outline_color)) ? outline_color : c_white);
						outline_alpha = ((outline_alpha > 0) ? outline_alpha : 0);
						var _point = [[[(location.x2 + outline_size), (location.y1 - outline_size)],
									   [(location.x1 - outline_size), (location.y1 - outline_size)],
									   [(location.x2 + outline_size), location.y1],
									   [(location.x1 - outline_size), location.y1]],
									  [[(location.x1 - outline_size), location.y1],
									   [(location.x1 - outline_size), (location.y2 + outline_size)],
									   [location.x1, location.y1],
									   [location.x1, (location.y2 + outline_size)]],
									  [[location.x1, (location.y2 + outline_size)],
									   [(location.x2 + outline_size), (location.y2 + outline_size)],
									   [location.x1, location.y2],
									   [(location.x2 + outline_size), location.y2]],
									  [[(location.x2 + outline_size), location.y2],
									   [(location.x2 + outline_size), location.y1],
									   [location.x2, location.y2], [location.x2, location.y1]]];
						_vertexBuffer_outline = new VertexBuffer();
						var _renderData_outline = _vertexBuffer_outline
												   .createPrimitiveRenderData(pr_trianglestrip);
						
						with (_vertexBuffer_outline)
						{
							setActive(_renderData_outline.passthroughFormat);
							{
								var _i = [0, 0];
								repeat (array_length(_point))
								{
									_i[1] = 0;
									repeat (array_length(_point[_i[0]]))
									{
										var _point_current = _point[_i[0]][_i[1]];
										
										setLocation(_vertex.set(_point_current[0], _point_current[1]));
										setColor(other.outline_color, other.outline_alpha);
										setUV();
										
										++_i[1];
									}
									
									++_i[0];
								}
							}
							setActive(false);
						}
						
						array_push(_result, _renderData_outline);
					}
					
					return ((array_length(_result) == 1) ? _result[0] : _result);
				}
				catch (_exception)
				{
					if (_vertexBuffer_fill != undefined)
					{
						_vertexBuffer_fill.destroy();
					}
					
					if (_vertexBuffer_outline != undefined)
					{
						_vertexBuffer_outline.destroy();
					}
					
					new ErrorReport().report([other, self, "toVertexBuffer()"], _exception);
				}
				finally
				{
					location = _location_original;
					fill_color = _fill_color_original;
					fill_alpha = _fill_alpha_original;
					outline_color = _outline_color_original;
					outline_size = _outline_size_original;
					outline_alpha = _outline_alpha_original;
				}
				
				return undefined;
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static constructor = Rectangle;
		
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
