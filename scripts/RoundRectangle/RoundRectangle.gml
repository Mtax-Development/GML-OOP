/// @function				RoundRectangle()
/// @argument				{Vector4} location
/// @argument				{Vector2} radius?
/// @argument				{color|Color2} fill_color?
/// @argument				{real} fill_alpha?
/// @argument				{color} outline_color?
/// @argument				{real} outline_alpha?
///
/// @description			Constructs a Round Rectangle Shape.
function RoundRectangle() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				location = argument[0];
				radius = (((argument_count > 1) and (argument[1] != undefined)) ? argument[1]
																				: new Vector2(1, 1));
				fill_color = ((argument_count > 2) ? argument[2] : undefined);
				fill_alpha = ((argument_count > 3) ? argument[3] : undefined);
				outline_color = ((argument_count > 4) ? argument[4] : undefined);
				outline_alpha = ((argument_count > 5) ? argument[5] : undefined);
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
			//						If specified, the additions to that List can be ordered by 
			//						distance from the center of the Shape.
			//						Note: This Shape will be treated as a non-rounded Rectangle for
			//							  this operation.
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
							collision_rectangle_list(other.location.x1, other.location.y1, 
													 other.location.x2, other.location.y2,
													 _object, _precise, true, _list.ID,
													 _listOrdered);
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
													   other.location.x2, other.location.y2,
													   _object, _precise, true);
						}
					}
					else
					{
						return collision_rectangle(location.x1, location.y1, location.x2, location.y2,
												   _object, _precise, false);
					}
				}
			}
				
			// @argument			{int} device?
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape.
			//						Note: This Shape will be treated as a non-rounded Rectangle for
			//							  this operation.
			static cursorOver = function(_device)
			{
				var _cursor = ((_device == undefined) ? new Vector2(mouse_x, mouse_y)
													  : new Vector2(device_mouse_x(_device),
																	device_mouse_y(_device)));
				
				return location.isBetween(_cursor);
			}
			
			// @argument			{mousebutton} button
			// @argument			{int} device?
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape while its specified
			//						mouse button is pressed or held.
			//						Note: This Shape will be treated as a non-rounded Rectangle for
			//							  this operation.
			static cursorHold = function(_button, _device)
			{
				var _cursor = ((_device == undefined) ? new Vector2(mouse_x, mouse_y)
													  : new Vector2(device_mouse_x(_device),
																	device_mouse_y(_device)));
				
				if (location.isBetween(_cursor))
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
			//						Note: This Shape will be treated as a non-rounded Rectangle for
			//							  this operation.
			static cursorPressed = function(_button, _device)
			{
				var _cursor = ((_device == undefined) ? new Vector2(mouse_x, mouse_y)
													  : new Vector2(device_mouse_x(_device),
																	device_mouse_y(_device)));
				
				if (location.isBetween(_cursor))
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
			//						Note: This Shape will be treated as a non-rounded Rectangle for
			//							  this operation.
			static cursorReleased = function(_button, _device)
			{
				var _cursor = ((_device == undefined) ? new Vector2(mouse_x, mouse_y)
													  : new Vector2(device_mouse_x(_device),
																	device_mouse_y(_device)));
				
				if (location.isBetween(_cursor))
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
					
					if (instanceof(fill_color) == "Color2")
					{
						_color1 = fill_color.color1;
						_color2 = fill_color.color2;
					}
					
					draw_set_alpha(fill_alpha);
					
					draw_roundrect_color_ext(location.x1, location.y1, location.x2, location.y2,
											 radius.x, radius.y, _color1, _color2, false);
				}
				
				if ((outline_color != undefined) and (outline_alpha > 0))
				{
					draw_set_alpha(outline_alpha);
					
					draw_roundrect_color_ext(location.x1, location.y1, location.x2, location.y2,
											 radius.x, radius.y, outline_color, outline_color, true);
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
		
		if (argument_count <= 0)
		{
			self.construct();
		}
		else
		{
			script_execute_ext(method_get_index(self.construct), argument_original);
		}
		
	#endregion
}
