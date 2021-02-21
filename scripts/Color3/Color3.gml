/// @function				Color3()
/// @argument				{color} color1?
/// @argument				{color} color2?
/// @argument				{color} color3?
///
/// @description			Constructs a container for three colors.
///
///							Construction methods:
///							- New constructor.
///							- Default for all values: {void}
///							   The values will be set to white.
///							- One color for all values: {color} color
///							- Color2 + color: {Color2} other, {color} color 
///							   In any order, it will be reflected in the values of this constructor.
///							- Constructor copy: {Color3} other
function Color3() constructor
{
	#region [Methods]
		#region <Management>
			
			static construct = function()
			{
				//|Construction method: Default for all values.
				color1 = c_white;
				color2 = c_white;
				color3 = c_white;
				
				if (argument_count > 0)
				{
					if (instanceof(argument[0]) == "Color3")
					{
						//|Construction method: Constructor copy.
						var _other = argument[0];
					
						color1 = _other.color1;
						color2 = _other.color2;
						color3 = _other.color3;
					}
					else
					{
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
								//|Construction method: Color2 + color.
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
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(color1)) and (is_real(color2)) and (is_real(color3)));
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{Color3}
			// @description			Create a copy of this constructor with inverted color order.
			static invertedOrder = function()
			{
				return new Color3(color3, color2, color1);
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
				var _color = [color1, color2, color3];
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
				return [color1, color2, color3];
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
