/// @function				Color3()
/// @argument				{color} color1?
/// @argument				{color} color2?
/// @argument				{color} color3?
///
/// @description			Constructs a container for three colors.
///
///							Construction methods:
///							- Three colors: {color} color1, {color} color2, {color} color3
///							- Default (white) for all values: {void}
///							- One color for all values: {color} color
///							- Color2 + Color: {Color2} other, {color} color 
///							   In any order, it will be reflected in the values of this constructor.
///							- Constructor copy: {Color3} other

function Color3() constructor
{
	#region [Methods]
		#region <Management>
			
			static construct = function()
			{
				if ((argument_count > 0) and (instanceof(argument[0]) == "Color3"))
				{
					//|Construction method: Constructor copy.
					var _other = argument[0];
					
					color1 = _other.color1;
					color2 = _other.color2;
					color3 = _other.color3;
				}
				else
				{
					//|Construction method: Default (white) for all values.
					color1 = c_white;
					color2 = c_white;
					color3 = c_white;
					
					switch (argument_count)
					{
						case 1:
							//|Construction method: One color for all values.
							var _color = argument[0];
							
							color1 = _color;
							color2 = _color;
							color3 = _color;
						break;
					
						case 2:
							//|Construction method: Color2 + Color.
							if (instanceof(argument[0]) == "Color2")
							{
								var _other = argument[0];
								var _color = argument[1];
								
								color1 = _other.color1;
								color2 = _other.color2;
								color3 = _color;
							}
							else if (instanceof(argument[1]) == "Color2")
							{
								var _color = argument[0];
								var _other = argument[1];
								
								color1 = _color;
								color2 = _other.color1;
								color3 = _other.color2;
							}
						break;
					
						case 3:
							color1 = argument[0];
							color2 = argument[1];
							color3 = argument[2];
						break;
					}
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} useHSV?
			// @returns				{string}
			// @description			Create a string representing the constructor.
			//						Overrides the string() conversion.
			//						Content will be represented as a color name or value for each 
			//						color.
			//						If it is equal to one of built-in color constants, its name will
			//						be used. Otherwise exact RGB values will be displayed. HSV can 
			//						be specified to be used instead. The constant for Silver is the
			//						same as for Light Gray and cannot be differentiated; Light Gray
			//						will be used in its place.
			static toString = function(_useHSV)
			{
				var _colors = [color1, color2, color3];
				
				var _colors_count = array_length(_colors);
				
				var _result = (instanceof(self) + "(");
				var _mark_separator = ", ";
				
				var _i = 0;
				
				repeat (_colors_count)
				{
					var _string_color = "";
					
					switch (_colors[_i])
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
								 "Hue: " + string(color_get_hue(_colors[_i])) + _mark_separator +
								 "Saturation: " + string(color_get_saturation(_colors[_i])) +
												_mark_separator +
								 "Value: " + string(color_get_value(_colors[_i])) +
								 ")");
							}
							else
							{
								_string_color = 
								("(" +
								 "Red: " + string(color_get_red(_colors[_i])) + _mark_separator +
								 "Green: " + string(color_get_green(_colors[_i])) + _mark_separator +
								 "Blue: " + string(color_get_blue(_colors[_i])) +
								 ")");
							}
						break;
					}
					
					_result += _string_color;
					
					if (_i < (_colors_count - 1))
					{
						_result += _mark_separator;
					}
					
					++_i;
				}
				
				_result += ")";
				
				return _result;
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
