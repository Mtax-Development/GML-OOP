/// @function				Line()
/// @argument				{Vector4} location
/// @argument				{real} size?
/// @argument				{color|Color2} color?
/// @argument				{real} alpha?
///
/// @description			Construct a Line Shape.
function Line() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				location = argument[0];
				size = (((argument_count > 1) and (argument[1] != undefined)) ? argument[1] : 1);
				color = (((argument_count > 2) and (argument[2] != undefined)) ? argument[2] 
																			   : c_white);
				alpha = (((argument_count > 3) and (argument[3] != undefined)) ? argument[3] : 1);
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
			//						Note: The size of this Shape will be treated as 1 for this
			//						operation.
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
							collision_line_list(other.location.x1, other.location.y1, 
												other.location.x2, other.location.y2,
												_object, _precise, true, _list.ID,
												_listOrdered);
						}
					}
					else
					{
						collision_line_list(location.x1, location.y1, location.x2, location.y2,
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
							return collision_line(other.location.x1, other.location.y1, 
													other.location.x2, other.location.y2,
													_object, _precise, true);
						}
					}
					else
					{
						return collision_line(location.x1, location.y1, location.x2, location.y2,
												_object, _precise, false);
					}
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
				if ((alpha > 0) and (size != 0))
				{
					draw_set_alpha(alpha);
					
					var _color1 = color;
					var _color2 = color;
					
					if (instanceof(color) == "Color2")
					{
						_color1 = color.color1;
						_color2 = color.color2;
					}
					
					draw_line_width_color(location.x1, location.y1, location.x2, location.y2, size,
										  _color1, _color2);
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
				var _mark_separator = ((_multiline) ? "\n" : ", ");
				var _mark_separator_inline = ", ";
				
				var _text_color;
				
				if (is_real(color))
				{
					switch (color)
					{
						case c_aqua: _text_color = "Aqua"; break;
						case c_black: _text_color = "Black"; break;
						case c_blue: _text_color = "Blue"; break;
						case c_dkgray: _text_color = "Dark Gray"; break;
						case c_fuchsia: _text_color = "Fuchsia"; break;
						case c_gray: _text_color = "Gray"; break;
						case c_green: _text_color = "Green"; break;
						case c_lime: _text_color = "Lime"; break;
						case c_ltgray: _text_color = "Light Gray"; break;
						case c_maroon: _text_color = "Maroon"; break;
						case c_navy: _text_color = "Navy"; break;
						case c_olive: _text_color = "Olive"; break;
						case c_orange: _text_color = "Orange"; break;
						case c_purple: _text_color = "Purple"; break;
						case c_red: _text_color = "Red"; break;
						case c_teal: _text_color = "Teal"; break;
						case c_white: _text_color = "White"; break;
						case c_yellow: _text_color = "Yellow"; break;
						default:
							if (_color_HSV)
							{
								_text_color = 
								("(" +
								 "Hue: " + string(color_get_hue(color)) + _mark_separator_inline +
								 "Saturation: " + string(color_get_saturation(color))
												+ _mark_separator_inline +
								 "Value: " + string(color_get_value(color)) +
								 ")");
							}
							else
							{
								_text_color = 
								("(" +
								 "Red: " + string(color_get_red(color)) + _mark_separator_inline +
								 "Green: " + string(color_get_green(color)) + _mark_separator_inline +
								 "Blue: " + string(color_get_blue(color)) +
								 ")");
							}
						break;
					}
				}
				else
				{
					var _color_instanceof = instanceof(color);
					
					if ((_color_instanceof == "Color2") or (_color_instanceof == "Color3")
					or (_color_instanceof == "Color4"))
					{
						_text_color = color.toString(false, _color_HSV);
					}
					else
					{
						_text_color = string(color);
					}
				}
				
				var _string = ("Location: " + string(location) + _mark_separator +
							   "Size: " + string(size) + _mark_separator +
							   "Color: " + _text_color + _mark_separator +
							   "Alpha: " + string(alpha));
				
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
