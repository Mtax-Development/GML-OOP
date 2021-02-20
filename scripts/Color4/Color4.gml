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
		#region <Getters>
			
			// @returns				{Color4}
			// @description			Create a copy of this constructor with inverted color order.
			static invertedOrder = function()
			{
				return new Color4(color4, color3, color2, color1);
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @argument			{bool} color_HSV?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented as color names for built-in constants
			//						or RGB value, unless use of HSV is specified.
			//						Note: The constant for Silver is the same as for Light Gray, so it
			//							  cannot be differentiated and will not be represented.
			static toString = function(_multiline, _color_HSV)
			{
				var _color = [color1, color2, color3, color4];
				var _color_count = array_length(_color);
				var _text_color = array_create(_color_count, "");
				
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
						_text_color[_i] = string(_color[_i]);
					}
					
					_string += _text_color[_i];
					
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
