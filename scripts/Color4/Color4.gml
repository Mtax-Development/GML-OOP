//  @function				Color4()
/// @argument				color1? {int:color}
/// @argument				color2? {int:color}
/// @argument				color3? {int:color}
/// @argument				color4? {int:color}
/// @description			Constructs a container for four colors.
//							For rectangular shapes, these colors are organized by the following
//							coordinates:
//							- color1: X1 Y1
//							- color2: X2 Y1
//							- color3: X2 Y2
//							- color4: X1 Y2
//							
//							Construction types:
//							- New constructor
//							- Default for all values: {void|undefined}
//							   The color values will be set to white.
//							- One color for all values: color {int:color}
//							- Color2 + color + color: other {Color2}, color {int:color},
//													  color {int:color}
//							   In any order, it will be reflected in the values of this constructor.
//							- Color2 pair: first {Color2}, second {Color2}
//							- Color3 + color: other {Color3}, color {int:color}
//							   In any order, it will be reflected in the values of this constructor.
//							- Constructor copy: other {Color4}
function Color4() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Default for all values.
				color1 = c_white;
				color2 = c_white;
				color3 = c_white;
				color4 = c_white;
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (is_instanceof(argument[0], Color4))
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
								if ((is_instanceof(argument[0], Color2)) 
								and (is_instanceof(argument[1], Color2)))
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
									if (is_instanceof(argument[0], Color3))
									{
										var _color3 = argument[0];
										
										color1 = _color3.color1;
										color2 = _color3.color2;
										color3 = _color3.color3;
										color4 = argument[1];
									}
									else if (is_instanceof(argument[1], Color3))
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
								if (is_instanceof(argument[0], Color2))
								{
									var _color2 = argument[0];
									
									color1 = _color2.color1;
									color2 = _color2.color2;
									color3 = argument[1];
									color4 = argument[2];
								}
								else if (is_instanceof(argument[1], Color2))
								{
									var _color2 = argument[1];
									
									color1 = argument[0];
									color2 = _color2.color1;
									color3 = _color2.color2;
									color4 = argument[2];
								}
								else if (is_instanceof(argument[2], Color2))
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
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(color1)) and (is_real(color2)) and (is_real(color3))
						and (is_real(color4)));
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			value {int:color|Color4}
			/// @returns			{bool}
			/// @description		Check if all values of this constructor are the same as the
			///						specified color or respective values of the specified Color4.
			static equals = function(_value)
			{
				if (is_instanceof(_value, Color4))
				{
					return ((color1 == _value.color1) and (color2 == _value.color2)
							and (color3 == _value.color3) and (color4 == _value.color4));
				}
				else if (is_real(_value))
				{
					return ((color1 == _value) and (color2 == _value) and (color3 == _value)
							and (color4 == _value));
				}
				
				return false;
			}
			
		#endregion
		#region <Setters>
			
			/// @description		Invert the order of colors.
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
			
			/// @argument			color1? {int:color}
			/// @argument			color2? {int:color}
			/// @argument			color3? {int:color}
			/// @argument			color4? {int:color}
			/// @description		Set each color value.
			static set = function(_color1 = color1, _color2 = color2, _color3 = color3,
								  _color4 = color4)
			{
				color1 = _color1;
				color2 = _color2;
				color3 = _color3;
				color4 = _color4;
				
				return self;
			}
			
			/// @argument			value {int:color|int:color[]|Color4}
			/// @description		Set all of color values to the ones of the specified value or first
			///						four values of the specified array.
			static setAll = function(_value)
			{
				try
				{
					var _result_color1, _result_color2, _result_color3, _result_color4;
					
					if (is_real(_value))
					{
						_result_color1 = _value;
						_result_color2 = _value;
						_result_color3 = _value;
						_result_color4 = _value;
					}
					else if (is_array(_value))
					{
						_result_color1 = _value[0];
						_result_color2 = _value[1];
						_result_color3 = _value[2];
						_result_color4 = _value[3];
					}
					else
					{
						_result_color1 = _value.color1;
						_result_color2 = _value.color2;
						_result_color3 = _value.color3;
						_result_color4 = _value.color4;
					}
					
					color1 = _result_color1;
					color2 = _result_color2;
					color3 = _result_color3;
					color4 = _result_color4;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setAll()"], _exception);
				}
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @argument			colorHSV? {bool}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented as color names for built-in constants
			///						or RGB value, unless use of HSV is specified.
			///						NOTE: The constant for Silver is the same as for Light Gray. It
			///						cannot be differentiated and will not be represented.
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
			
			/// @returns			{int[]:color}
			/// @description		Return an array containing all values of this Container.
			static toArray = function()
			{
				return [color1, color2, color3, color4];
			}
			
			/// @returns			{Color2[]}
			/// @description		Return an array of two Color2 with the values of this Color4.
			static split = function()
			{
				return [new Color2(color1, color2), new Color2(color3, color4)];
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static constructor = Color4;
		
		static prototype = {};
		var _property = variable_struct_get_names(prototype);
		var _i = 0;
		repeat (array_length(_property))
		{
			var _name = _property[_i];
			var _value = variable_struct_get(prototype, _name);
			
			variable_struct_set(self, _name, ((is_method(_value)) ? method(self, _value) : _value));
			
			++_i;
		}
		
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
