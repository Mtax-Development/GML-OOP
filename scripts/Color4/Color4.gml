/// @function				Color4()
/// @argument				{int:color} color1?
/// @argument				{int:color} color2?
/// @argument				{int:color} color3?
/// @argument				{int:color} color4?
///							
/// @description			Constructs a container for four colors.
///							For rectangular shapes, these colors are organized by the following 
///							coordinates:
///							- color1: X1 Y1
///							- color2: X2 Y1
///							- color3: X2 Y2
///							- color4: X1 Y2
///							
///							Construction types:
///							- New constructor.
///							- Default for all values: {void|undefined}
///							   The color values will be set to white.
///							- One color for all values: {int:color} color
///							- Color2 + color + color: {Color2} other, {int:color} color,
///													  {int:color} color
///							   In any order, it will be reflected in the values of this constructor.
///							- Color2 pair: {Color2} first, {Color2} second
///							- Color3 + color: {Color3} other, {int:color} color
///							   In any order, it will be reflected in the values of this constructor.
///							- Constructor copy: {Color4} other
function Color4() constructor
{
	#region [Methods]
		#region <Management>
			
			static construct = function()
			{
				//|Construction type: Default for all values.
				color1 = c_white;
				color2 = c_white;
				color3 = c_white;
				color4 = c_white;
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (instanceof(argument[0]) == "Color4")
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
					
						color1 = _other.color1;
						color2 = _other.color2;
						color3 = _other.color3;
						color4 = _other.color4;
					}
					else
					{
						switch (argument_count)
						{
							case 1:
								//|Construction type: One color for all values.
								color1 = argument[0];
								color2 = argument[0];
								color3 = argument[0];
								color4 = argument[0];
							break;
							
							case 2:
								if ((instanceof(argument[0]) == "Color2") 
								and (instanceof(argument[1]) == "Color2"))
								{
									//|Construction type: Color2 pair.
									var _first = argument[0];
									var _second = argument[1];
									
									color1 = _first.color1;
									color2 = _first.color2;
									color3 = _second.color1;
									color4 = _second.color2;
								}
								else
								{
									//|Construction type: Color3 + color.
									if (instanceof(argument[0]) == "Color3")
									{
										var _color3 = argument[0];
										
										color1 = _color3.color1;
										color2 = _color3.color2;
										color3 = _color3.color3;
										color4 = argument[1];
									}
									else if (instanceof(argument[1]) == "Color3")
									{
										var _color3 = argument[1];
									
										color1 = argument[0];
										color2 = _color3.color1;
										color3 = _color3.color2;
										color4 = _color3.color3;
									}
								}
							break;
							
							case 3:
								//|Construction type: Color2 + color + color.
								if (instanceof(argument[0]) == "Color2")
								{
									var _color2 = argument[0];
								
									color1 = _color2.color1;
									color2 = _color2.color2;
									color3 = argument[1];
									color4 = argument[2];
								}
								else if (instanceof(argument[1]) == "Color2")
								{
									var _color2 = argument[1];
								
									color1 = argument[0];
									color2 = _color2.color1;
									color3 = _color2.color2;
									color4 = argument[2];
								}
								else if (instanceof(argument[2]) == "Color2")
								{
									var _color2 = argument[2];
								
									color1 = argument[0];
									color2 = argument[1];
									color3 = _color2.color1;
									color4 = _color2.color2;
								}
							break;
							
							case 4:
								//|Construction type: New constructor.
								color1 = argument[0];
								color2 = argument[1];
								color3 = argument[2];
								color4 = argument[3];
							break;
						}
					}
				}
				
				return self;
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(color1)) and (is_real(color2)) and (is_real(color3))
						and (is_real(color4)));
			}
			
		#endregion
		#region <Setters>
			
			// @description			Invert the order of colors.
			static reverse = function()
			{
				var _color1 = color1;
				var _color2 = color2;
				var _color3 = color3;
				var _color4 = color4;
				
				color1 = _color4;
				color2 = _color3;
				color3 = _color2;
				color4 = _color1;
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @argument			{bool} colorHSV?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented as color names for built-in constants
			//						or RGB value, unless use of HSV is specified.
			//						NOTE: The constant for Silver is the same as for Light Gray. It
			//						cannot be differentiated and will not be represented.
			static toString = function(_multiline = false, _colorHSV = false)
			{
				var _color = [color1, color2, color3, color4];
				var _color_count = array_length(_color);
				var _string_color = array_create(_color_count, "");
				
				var _mark_separator = ((_multiline) ? "\n" : ", ");
				var _mark_separator_inline = ", ";
				
				var _string = "";
				
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
						_string_color[_i] = string(_color[_i]);
					}
					
					_string += _string_color[_i];
					
					if (_i < (_color_count - 1))
					{
						_string += _mark_separator;
					}
					
					++_i;
				}
				
				return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
			}
			
			// @returns				{int[]}
			// @description			Return an array containing all values of this Container.
			static toArray = function()
			{
				return [color1, color2, color3, color4];
			}
			
			// @returns				{Color2[]}
			// @description			Return an array of two Color2 with the values of this Color4.
			static split = function()
			{
				return [new Color2(color1, color2), new Color2(color3, color4)];
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

