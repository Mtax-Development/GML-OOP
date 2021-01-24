/// @function				Triangle()
/// @argument				{Vector2} location1
/// @argument				{Vector2} location2
/// @argument				{Vector2} location3
/// @argument				{color|Color3} fill_color?
///	@argument				{real} fill_alpha?
/// @argument				{color|Color3} outline_color?
/// @argument				{real} outline_alpha?
///
/// @description			Constructs a Triangle Shape.
function Triangle() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				location1 = argument[0];
				location2 = argument[1];
				location3 = argument[2];
				fill_color = ((argument_count > 3) ? argument[3] : undefined);
				fill_alpha = (((argument_count > 4) and (argument[4] != undefined)) ? argument[4]
																					: 1);
				outline_color = ((argument_count > 5) ? argument[5] : undefined);
				outline_alpha = (((argument_count > 6) and (argument[6] != undefined)) ? argument[6]
																					   : 1);
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{Vector2} point
			// @returns				{bool}
			// @description			Checks whether a point in space is within this Triangle.
			static pointIn = function(_point)
			{
				return point_in_triangle(_point.x, _point.y, location1.x, location1.y,
										 location2.x, location2.y, location3.x, location3.y);
			}
			
			// @argument			{int} device?
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape.
			static cursorOver = function(_device)
			{
				var _cursor = ((_device == undefined) ? new Vector2(mouse_x, mouse_y)
													  : new Vector2(device_mouse_x(_device),
																	device_mouse_y(_device)));
				
				return point_in_triangle(_cursor.x, _cursor.y, location1.x, location1.y, location2.x,
										 location2.y, location3.x, location3.y);
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
				
				if (point_in_triangle(_cursor.x, _cursor.y, location1.x, location1.y, location2.x,
									  location2.y, location3.x, location3.y))
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
				
				if (point_in_triangle(_cursor.x, _cursor.y, location1.x, location1.y, location2.x,
									  location2.y, location3.x, location3.y))
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
				
				if (point_in_triangle(_cursor.x, _cursor.y, location1.x, location1.y, location2.x,
									  location2.y, location3.x, location3.y))
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
			static render = function()
			{
				if ((fill_color != undefined) and (fill_alpha > 0))
				{
					var _color1 = fill_color;
					var _color2 = fill_color;
					var _color3 = fill_color;
					
					if (instanceof(fill_color) == "Color3")
					{
						_color1 = fill_color.color1;
						_color2 = fill_color.color2;
						_color3 = fill_color.color3;
					}
					
					draw_set_alpha(fill_alpha);
					
					draw_triangle_color(location1.x, location1.y, location2.x, location2.y, 
										location3.x, location3.y, _color1, _color2, _color3, false);
				}
				
				if ((outline_color != undefined) and (outline_alpha > 0))
				{
					var _color1 = outline_color;
					var _color2 = outline_color;
					var _color3 = outline_color;
					
					if (instanceof(outline_color) == "Color3")
					{
						_color1 = outline_color.color1;
						_color2 = outline_color.color2;
						_color3 = outline_color.color3;
					}
					
					draw_set_alpha(outline_alpha);
					
					draw_triangle_color(location1.x, location1.y, location2.x, location2.y, 
										location3.x, location3.y, _color1, _color2, _color3, true);
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
				var _mark_separator_multi = " / ";
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
				
				var _string = ("Location: " + string(location1) + _mark_separator_multi
											+ string(location2) + _mark_separator_multi
											+ string(location3) + _mark_separator +
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
