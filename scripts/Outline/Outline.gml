/// @function				Outline
/// @argument				{real} size
/// @argument				{color|Color3|Color4} color?
/// @argument				{real} alpha?
/// @argument				{real} spacing?
///
/// @description			Construct a container for information about Outline drawing for shapes.
///
///							Construction methods:
///							- New constructor
///							- Constructor copy: {Outline} other
function Outline() constructor
{
	#region [Methods]
		#region <Management>
			
			static construct = function()
			{
				if ((argument_count > 0) and (instanceof(argument[0]) == "Outline"))
				{
					//|Construction method: Constructor copy.
					var _other = argument[0];
				
					size = _other.size;
					color = _other.color;
					alpha = _other.alpha;
					spacing = _other.spacing;
				}
				else
				{
					//|Construction method: New constructor.
					size = (((argument_count > 0) and (argument[0] != undefined)) ? argument[0]
																				  : 1);
					color = (((argument_count > 1) and (argument[1] != undefined)) ? argument[1]
																				   : c_white);
					alpha = (((argument_count > 2) and (argument[2] != undefined)) ? argument[2]
																				   : 1);
					spacing = (((argument_count > 3) and (argument[3] != undefined)) ? argument[3]
																					 : 0);
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} useHSV?
			// @description			Create a string representing the constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the Outline information.
			//						For the color output, if it is equal to one of built-in color
			//						constants, its name will be used. Otherwise exact RGB values 
			//						will be displayed. HSV can be specified to be used instead. 
			//						The constant for Silver is the same as for Light Gray and 
			//						cannot be differentiated; Light Gray will be used in its place.
			static toString = function(_useHSV)
			{
				var _string_color = "";
				var _mark_separator = ", ";
				
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
						if (_useHSV)
						{
							_string_color = 
							("(" +
							 "Hue: " + string(color_get_hue(color)) + ", " +
							 "Saturation: " + string(color_get_saturation(color)) + ", " +
							 "Value: " + string(color_get_value(color)) +
							 ")");
						}
						else
						{
							_string_color = 
							("(" +
							 "Red: " + string(color_get_red(color)) + ", " +
							 "Green: " + string(color_get_green(color)) + ", " +
							 "Blue: " + string(color_get_blue(color)) +
							 ")");
						}
					break;
				}
				
				return (instanceof(self) + 
						"(" + 
						"Size: " + string(size) + _mark_separator +
						"Color: " + _string_color + _mark_separator +
						"Alpha: " + string(alpha) + _mark_separator +
						"Spacing: " + string(spacing) +
						")");
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
