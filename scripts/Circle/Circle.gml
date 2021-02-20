/// @function				Circle()
/// @argument				{Vector2} location
/// @argument				{real} radius
/// @argument				{color|Color2} fill_color?
/// @argument				{real} fill_alpha?
/// @argument				{color} outline_color?
/// @argument				{real} outline_alpha?
///
/// @description			Constructs a Circle Shape.
function Circle() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				location = argument[0];
				radius = argument[1];
				fill_color = ((argument_count > 2) ? argument[2] : undefined);
				fill_alpha = (((argument_count > 3) and (argument[3] != undefined)) ? argument[3]
																					: 1);
				outline_color = ((argument_count > 4) ? argument[4] : undefined);
				outline_alpha = (((argument_count > 5) and (argument[5] != undefined)) ? argument[5]
																					   : 1);
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(radius)) and (instanceof(location) == "Vector2") 
						and (location.isFunctional()));
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{object} object
			// @argument			{bool} precise?
			// @argument			{instance} excludedInstance?
			// @argument			{bool|List} list?
			// @argument			{bool} listOrdered?
			// @returns				{int|List}
			// @description			Check for a collision within this Shape with instances of the
			//						specified object.
			//						Returns the ID of a single colliding instance or noone.
			//						If List use is specified, a List will be returned instead, either
			//						empty or containing IDs of the colliding instances.
			//						The additions to that List can be ordered by distance from the
			//						center of the Shape if specified.
			static collision = function(_object)
			{
				var _precise = (((argument_count > 1) and (argument[1] != undefined)) ? argument[1]
																					  : false);
				var _excludedInstance = ((argument_count > 2) ? argument[2] : undefined);
				var _list = ((argument_count > 3) ? argument[3] : undefined);
				var _listOrdered = (((argument_count > 4) and (argument[4] != undefined)) ? 
								   argument[4] : false);
				
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
							collision_circle_list(other.location.x, other.location.y, other.radius, 
												  _object, _precise, true, _list.ID, _listOrdered);
						}
					}
					else
					{
						collision_circle_list(location.x, location.y, radius, _object, _precise, 
											  false, _list.ID, _listOrdered);
					}
				
					return _list;
				}
				else
				{
					if ((is_real(_excludedInstance)) and (instance_exists(_excludedInstance)))
					{				
						with (_excludedInstance)
						{
							return collision_circle(other.location.x, other.location.y, other.radius, 
												    _object, _precise, true);
						}
					}
					else
					{
						return collision_circle(location.x, location.y, radius, _object, _precise, 
												false);
					}
				}
			}
			
			// @argument			{Vector2} point
			// @returns				{bool}
			// @description			Check whether a point in space is within this Circle.
			static pointIn = function(_point)
			{
				return point_in_circle(_point.x, _point.y, location.x, location.y, radius);
			}
			
			// @argument			{int} device?
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape.
			static cursorOver = function(_device)
			{
				var _cursor = ((_device == undefined) ? new Vector2(mouse_x, mouse_y)
													  : new Vector2(device_mouse_x(_device),
																	device_mouse_y(_device)));
				
				return point_in_circle(_cursor.x, _cursor.y, location.x, location.y, radius);
			}
			
			// @argument			{mousebutton} button
			// @argument			{int} device?
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape while its specified
			//						mouse button is pressed or held.
			static cursorHold = function(_button, _device)
			{
				var _cursor = ((_device == undefined) ? new Vector2(mouse_x, mouse_y)
													  : new Vector2(device_mouse_x(_device),
																	device_mouse_y(_device)));
				
				if (point_in_circle(_cursor.x, _cursor.y, location.x, location.y, radius))
				{	
					return ((_device == undefined) ? mouse_check_button(_button)
												   : device_mouse_check_button(_device, _button))
				}
				else
				{
					return false;
				}
			}
			
			// @argument			{mousebutton} button
			// @argument			{int} device?
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape while its specified
			//						mouse button was pressed in this frame.
			static cursorPressed = function(_button, _device)
			{
				var _cursor = ((_device == undefined) ? new Vector2(mouse_x, mouse_y)
													  : new Vector2(device_mouse_x(_device),
																	device_mouse_y(_device)));
				
				if (point_in_circle(_cursor.x, _cursor.y, location.x, location.y, radius))
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
			
			// @argument			{mousebutton} button
			// @argument			{int} device?
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape while the specified
			//						mouse button was released in this frame.
			static cursorReleased = function(_button, _device)
			{
				var _cursor = ((_device == undefined) ? new Vector2(mouse_x, mouse_y)
													  : new Vector2(device_mouse_x(_device),
																	device_mouse_y(_device)));
				
				if (point_in_circle(_cursor.x, _cursor.y, location.x, location.y, radius))
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
			//						Note: Form drawing produces inconsistent results across devices
			//							  and export targets due to their technical differences.
			//							  Sprite drawing should be used instead for accurate results.
			//						Note: Form drawing of this Shape is dependant on the circle
			//							  precision, as set using built-in function
			//							  draw_set_circle_precision().
			static render = function()
			{
				if ((fill_color != undefined) and (fill_alpha > 0))
				{
					draw_set_alpha(fill_alpha);
					
					var _color1 = fill_color;
					var _color2 = fill_color;
					
					if (instanceof(fill_color) == "Color2")
					{
						_color1 = fill_color.color1;
						_color2 = fill_color.color2;
					}
					
					draw_circle_color(location.x, location.y, radius, _color1, _color2, false);
				}
				
				if ((outline_color != undefined) and (outline_alpha > 0))
				{
					draw_set_alpha(outline_alpha);
					
					draw_circle_color(location.x, location.y, radius, outline_color, outline_color,
									  true);
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the properties of this Shape.
			static toString = function(_multiline, _color_HSV)
			{
				var _color = [fill_color, outline_color];
				var _color_count = array_length(_color);
				var _text_color = array_create(_color_count, "");
				
				var _mark_separator = ((_multiline) ? "\n" : ", ");
				var _mark_separator_inline = ", ";
				
				var _i = 0;
				repeat (_color_count)
				{
					if (is_real(_color[_i]))
					{
						switch (_color[_i])
						{
							case c_aqua: _text_color[_i] = "Aqua"; break;
							case c_black: _text_color[_i] = "Black"; break;
							case c_blue: _text_color[_i] = "Blue"; break;
							case c_dkgray: _text_color[_i] = "Dark Gray"; break;
							case c_fuchsia: _text_color[_i] = "Fuchsia"; break;
							case c_gray: _text_color[_i] = "Gray"; break;
							case c_green: _text_color[_i] = "Green"; break;
							case c_lime: _text_color[_i] = "Lime"; break;
							case c_ltgray: _text_color[_i] = "Light Gray"; break;
							case c_maroon: _text_color[_i] = "Maroon"; break;
							case c_navy: _text_color[_i] = "Navy"; break;
							case c_olive: _text_color[_i] = "Olive"; break;
							case c_orange: _text_color[_i] = "Orange"; break;
							case c_purple: _text_color[_i] = "Purple"; break;
							case c_red: _text_color[_i] = "Red"; break;
							case c_teal: _text_color[_i] = "Teal"; break;
							case c_white: _text_color[_i] = "White"; break;
							case c_yellow: _text_color[_i] = "Yellow"; break;
							default:
								if (_color_HSV)
								{
									_text_color[_i] = 
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
									_text_color[_i] = 
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
						var _color_instanceof = instanceof(_color[_i]);
						
						if ((_color_instanceof == "Color2") or (_color_instanceof == "Color3")
						or (_color_instanceof == "Color4"))
						{
							_text_color[_i] = _color[_i].toString(false, _color_HSV);
						}
						else
						{
							_text_color[_i] = string(_color[_i]);
						}
					}
					
					++_i;
				}
				
				var _string = ("Location: " + string(location) + _mark_separator +
							   "Radius: " + string(radius) + _mark_separator +
							   "Fill Color: " + _text_color[0] + _mark_separator +
							   "Fill Alpha: " + string(fill_alpha) + _mark_separator +
							   "Outline Color: " + _text_color[1] + _mark_separator +
							   "Outline Alpha: " + string(outline_alpha));
				
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
