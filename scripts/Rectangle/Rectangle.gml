/// @function				Rectangle()
/// @argument				{Vector4} location
/// @argument				{color|Color4} fill_color?
/// @argument				{real} fill_alpha?
/// @argument				{color|Color4} outline_color?
/// @argument				{int} outline_size?
/// @argument				{real} outline_alpha?
///							
/// @description			Constructs a Rectangle Shape.
///							
///							Construction types:
///							- New constructor.
///							- Empty: {void|undefined}
///							- Constructor copy: {Rectangle} other
function Rectangle() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				location = undefined;
				fill_color = undefined;
				fill_alpha = undefined;
				outline_color = undefined;
				outline_size = undefined;
				outline_alpha = undefined;
				
				if (argument_count > 0)
				{
					if (instanceof(argument[0]) == "Rectangle")
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						location = ((instanceof(_other.location) == "Vector4")
									? new Vector4(_other.location) : _other.location);
						fill_color = ((instanceof(_other.fill_color) == "Color4")
									  ? new Color4(_other.fill_color) : _other.fill_color);
						fill_alpha = _other.fill_alpha;
						outline_color = ((instanceof(_other.outline_color) == "Color4")
										 ? new Color4(_other.outline_color) : _other.outline_color);
						outline_size = _other.outline_size;
						outline_alpha = _other.outline_alpha;
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
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((instanceof(location) == "Vector4") and (location.isFunctional()));
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{object} object
			// @argument			{bool} precise?
			// @argument			{int:instance} excludedInstance?
			// @argument			{bool|List} list?
			// @argument			{bool} listOrdered?
			// @returns				{int|List}
			// @description			Check for a collision within this Shape with instances of the
			//						specified object.
			//						Returns the ID of a single colliding instance or noone.
			//						If List use is specified, a List will be returned instead, either
			//						empty or containing IDs of the colliding instances.
			//						If specified, the additions to that List can be ordered by 
			//						distance from the center of the Shape.
			static collision = function(_object, _precise = false, _excludedInstance, _list = false,
										_listOrdered = false)
			{
				if (_list)
				{
					if (instanceof(_list) != "List")
					{
						_list = new List();
					}
					
					if ((is_real(_excludedInstance)) and (instance_exists(_excludedInstance)))
					{
						with (_excludedInstance)
						{
							collision_rectangle_list(other.location.x1, other.location.y1,
													 other.location.x2, other.location.y2,
													 _object, _precise, true, _list.ID, _listOrdered);
						}
					}
					else
					{
						collision_rectangle_list(location.x1, location.y1, location.x2, location.y2,
												 _object, _precise, false, _list.ID, _listOrdered);
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
													   other.location.x2, other.location.y2, _object,
													   _precise, true);
						}
					}
					else
					{
						return collision_rectangle(location.x1, location.y1, location.x2, location.y2,
												   _object, _precise, false);
					}
				}
			}
			
			// @argument			{Vector2} point
			// @returns				{bool}
			// @description			Checks whether a point in space is within this Rectangle.
			static containsPoint = function(_point)
			{
				return point_in_rectangle(_point.x, _point.y, location.x1, location.y1, location.x2,
										  location.y2);
			}
			
			// @argument			{int} device?
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape.
			static cursorOver = function(_device)
			{
				var _cursor_x, _cursor_y;
				
				if (_device == undefined)
				{
					_cursor_x = mouse_x;
					_cursor_y = mouse_y;
				}
				else
				{
					_cursor_x = device_mouse_x(_device);
					_cursor_y = device_mouse_y(_device);
				}
				
				return ((_cursor_x == clamp(_cursor_x, location.x1, location.x2)) 
						and (_cursor_y == clamp(_cursor_y, location.y1, location.y2)));
			}
			
			// @argument			{constant:mb_*} button
			// @argument			{int} device?
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape while its specified
			//						mouse button is pressed or held.
			static cursorHold = function(_button, _device)
			{
				var _cursor_x, _cursor_y;
				
				if (_device == undefined)
				{
					_cursor_x = mouse_x;
					_cursor_y = mouse_y;
				}
				else
				{
					_cursor_x = device_mouse_x(_device);
					_cursor_y = device_mouse_y(_device);
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
			
			// @argument			{constant:mb_*} button
			// @argument			{int} device?
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape while its specified
			//						mouse button was pressed in this frame.
			static cursorPressed = function(_button, _device)
			{
				var _cursor_x, _cursor_y;
				
				if (_device == undefined)
				{
					_cursor_x = mouse_x;
					_cursor_y = mouse_y;
				}
				else
				{
					_cursor_x = device_mouse_x(_device);
					_cursor_y = device_mouse_y(_device);
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
			
			// @argument			{constant:mb_*} button
			// @argument			{int} device?
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape while the specified
			//						mouse button was released in this frame.
			static cursorReleased = function(_button, _device)
			{
				var _cursor_x, _cursor_y;
				
				if (_device == undefined)
				{
					_cursor_x = mouse_x;
					_cursor_y = mouse_y;
				}
				else
				{
					_cursor_x = device_mouse_x(_device);
					_cursor_y = device_mouse_y(_device);
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
			
		#endregion
		#region <Execution>
			
			// @description			Execute the draw of this Shape as a form.
			//						NOTE: Form drawing produces inconsistent results across devices
			//						and export targets due to their technical differences.
			//						Sprite drawing should be used instead for accurate results.
			static render = function()
			{
				if (self.isFunctional())
				{
					if ((fill_color != undefined) and (fill_alpha > 0))
					{
						var _color1, _color2, _color3, _color4;
						
						if (instanceof(fill_color) == "Color4")
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
						
						draw_set_alpha(fill_alpha);
						
						draw_rectangle_color(location.x1, location.y1, location.x2, location.y2,
											 _color1, _color2, _color3, _color4, false);
					}
				
					if ((outline_color != undefined) and (outline_size != 0) and (outline_alpha > 0))
					{
						var _color1, _color2, _color3, _color4;
						
						if (instanceof(outline_color) == "Color4")
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
						
						draw_set_alpha(outline_alpha);
					
						var _i = 0;
						repeat (outline_size)
						{
							draw_rectangle_color((location.x1 - _i), (location.y1 - _i),
												 (location.x2 + _i), (location.y2 + _i),
												 _color1, _color2, _color3, _color4, true);
						
							++_i;
						}
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "render";
					var _errorText = ("Attempted to render an invalid Shape: " +
									  "{" + string(self) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @argument			{bool} full?
			// @argument			{bool} color_HSV?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the properties of this Shape.
			static toString = function(_multiline = false, _full = false, _color_HSV = false)
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
									if (_color_HSV)
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
							if (instanceof(_color[_i]) == "Color4")
							{
								_string_color[_i] = _color[_i].toString(false, _color_HSV);
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
