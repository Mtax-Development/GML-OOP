/// @function				Color4()
/// @argument				{color} color1?
/// @argument				{color} color2?
/// @argument				{color} color3?
/// @argument				{color} color4?
///
/// @description			Constructs a container for four colors.
///							For rectangular shapes, these colors are organized by the following 
///							coordinates:
///							- color1: X1 Y1
///							- color2: X1 Y2
///							- color3: X2 Y1
///							- color4: X2 Y2
///
///							Construction methods:
///							- Four colors: {color} color1, {color} color2, {color} color3, 
///										   {color} color4
///							- Default (white) for all values: {void}
///							- One color for all values: {color} color
///							- Color2 + color + color: {Color2} other, {Color|color} color, 
///													  {color} color
///							   In any order, it will be reflected in the values of this constructor.
///							- Color2 + Color2: {Color2} color2_1, {Color2} color2_2
///							- Color3 + color: {Color2} other, {color} color
///							   In any order, it will be reflected in the values of this constructor.
///							- Constructor copy: {Color4} other
function Color4() constructor
{
	#region [Methods]
		#region <Management>
			
			static construct = function()
			{
				if ((argument_count > 0) and (instanceof(argument[0]) == "Color4"))
				{
					//|Construction method: Constructor copy.
					var _other = argument[0];
					
					color1 = _other.color1;
					color2 = _other.color2;
					color3 = _other.color3;
					color4 = _other.color4;
				}
				else
				{
					//|Construction method: Default (white) for all values.
					color1 = c_white;
					color2 = c_white;
					color3 = c_white;
					color4 = c_white;
					
					switch (argument_count)
					{
						case 1:
							//|Construction method: One color for all values.
							var _color = argument[0];
							
							color1 = _color;
							color2 = _color;
							color3 = _color;
							color4 = _color;
						break;
					
						case 2:
							if ((instanceof(argument[0]) == "Color2") 
							and (instanceof(argument[1]) == "Color2"))
							{
								//|Construction method: Color2 + Color2
								var _color2_1 = argument[0];
								var _color2_2 = argument[1];
								
								color1 = _color2_1.color1;
								color2 = _color2_1.color2;
								color3 = _color2_2.color1;
								color4 = _color2_2.color2;
							}
							else
							{
								//|Construction method: Color3 + color
								if (instanceof(argument[0]) == "Color3")
								{
									var _color3 = argument[0];
									var _color = argument[1];
									
									color1 = _color3.color1;
									color2 = _color3.color2;
									color3 = _color3.color3;
									color4 = _color;
								}
								else if (instanceof(argument[1]) == "Color3")
								{
									var _color = argument[0];
									var _color3 = argument[1];
									
									color1 = _color;
									color2 = _color3.color1;
									color3 = _color3.color2;
									color4 = _color3.color3;
								}
							}
						break;
					
						case 3:
							//| Construction method: Color2 + color + color
							if (instanceof(argument[0]) == "Color2")
							{
								var _color2 = argument[0];
								var _color_1 = argument[1];
								var _color_2 = argument[2];
								
								color1 = _color2.color1;
								color2 = _color2.color2;
								color3 = _color_1;
								color4 = _color_2;
							}
							else if (instanceof(argument[1]) == "Color2")
							{
								var _color_1 = argument[0];
								var _color2 = argument[1];
								var _color_2 = argument[2];
								
								color1 = _color_1;
								color2 = _color2.color1;
								color3 = _color2.color2;
								color4 = _color_2;
							}
							else if (instanceof(argument[2]) == "Color2")
							{
								var _color_1 = argument[0];
								var _color_2 = argument[1];
								var _color2 = argument[2];
								
								color1 = _color_1;
								color2 = _color_2;
								color3 = _color2.color1;
								color4 = _color2.color2;
							}
						break;
					
						case 4:
							//| Construction method: Four colors.
							var _color_1 = argument[0];
							var _color_2 = argument[1];
							var _color_3 = argument[2];
							var _color_4 = argument[3];
							
							color1 = _color_1;
							color2 = _color_2;
							color3 = _color_3;
							color4 = _color_4;
						break;
					}
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} useHSV?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented as a color name or value for each 
			//						color.
			//						If it is equal to one of built-in color constants, its name will
			//						be used. Otherwise exact RGB values will be displayed. HSV can 
			//						be specified to be used instead. The constant for Silver is the
			//						same as for Light Gray and cannot be differentiated; Light Gray
			//						will be used in its place.
			static toString = function(_color_HSV)
			{
				var _colors = [color1, color2, color3, color4];
				
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
							if (_color_HSV)
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
			
			// @returns				{int[]}
			// @description			Return an array containing all values of this Container.
			static toArray = function()
			{
				return [color1, color2, color3, color4];
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
