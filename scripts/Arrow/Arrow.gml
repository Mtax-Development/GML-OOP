/// @function				Arrow()
/// @argument				{Vector4} location
/// @argument				{real} size?
/// @argument				{color} color?
/// @argument				{real} alpha?
///
/// @description			Constructs an Arrow Shape, which is a Line starting at x1 y1 with a
///							Triangle of the specified size at x2 y2.
function Arrow(_location) constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function(_location)
			{
				location = _location;
				size  = (((argument_count > 1) and (argument[1] != undefined)) ? argument[1] : 1);
				color = (((argument_count > 2) and (argument[2] != undefined)) ? argument[2] 
																			   : c_white);
				alpha = (((argument_count > 3) and (argument[3] != undefined)) ? argument[3] : 1);
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return (is_real(size)) and (is_real(color)) and (is_real(alpha)) and
						((instanceof(location) == "Vector4") and (location.isFunctional()));
			}
			
		#endregion
		#region <Execution>
			
			// @description			Execute the draw of this Shape as a form.
			//						Note: Form drawing produces inconsistent results across devices
			//							  and export targets due to their technical differences.
			//							  Sprite drawing should be used instead for accurate results.
			static render = function()
			{
				if (alpha > 0)
				{
					draw_set_alpha(alpha);
					draw_set_color(color);
					
					draw_arrow(location.x1, location.y1, location.x2, location.y2, size);
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
								 "Saturation: " + string(color_get_saturation(color)) + 
												_mark_separator_inline +
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
					_text_color = string(color);
				}
				
				var _string = ("Location: " + string(location) + _mark_separator +
							   "Color: " + _text_color + _mark_separator +
							   "Alpha: " + string(alpha) + _mark_separator +
							   "Size: " + string(size));
				
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
