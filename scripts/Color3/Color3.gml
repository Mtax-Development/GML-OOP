//  @function				Color3()
/// @argument				color1? {int:color}
/// @argument				color2? {int:color}
/// @argument				color3? {int:color}
/// @description			Constructs a container for three colors.
//							
//							Construction types:
//							- New constructor
//							- Default for all values: {void}
//							   The color values will be set to white.
//							- One color for all values: color {int:color}
//							- Color2 + color: other {Color2}, color {int:color}
//							   In any order, it will be reflected in the values of this constructor.
//							- Constructor copy: other {Color3}
function Color3() constructor
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
				
				if (argument_count > 0)
				{
					if (is_instanceof(argument[0], Color3))
					{
						//|Construction type: Constructor copy.
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
								//|Construction type: One color for all values.
								var _color = argument[0];
								
								color1 = _color;
								color2 = _color;
								color3 = _color;
							break;
							case 2:
								//|Construction type: Color2 + color.
								if (is_instanceof(argument[0], Color2))
								{
									var _other = argument[0];
									var _color = argument[1];
									
									color1 = _other.color1;
									color2 = _other.color2;
									color3 = _color;
								}
								else if (is_instanceof(argument[1], Color2))
								{
									var _color = argument[0];
									var _other = argument[1];
									
									color1 = _color;
									color2 = _other.color1;
									color3 = _other.color2;
								}
							break;
							case 3:
								//|Construction type: New constructor.
								color1 = argument[0];
								color2 = argument[1];
								color3 = argument[2];
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
				return ((is_real(color1)) and (is_real(color2)) and (is_real(color3)));
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			value {int:color|Color3}
			/// @returns			{bool}
			/// @description		Check if all values of this constructor are the same as the
			///						specified color or respective values of the specified Color3.
			static equals = function(_value)
			{
				if (is_instanceof(_value, Color3))
				{
					return ((color1 == _value.color1) and (color2 == _value.color2)
							and (color3 == _value.color3));
				}
				else if (is_real(_value))
				{
					return ((color1 == _value) and (color2 == _value) and (color3 == _value));
				}
				
				return false;
			}
			
		#endregion
		#region <Setters>
			
			/// @description		Invert the order of colors.
			static reverse = function()
			{
				var _color1 = color1;
				var _color3 = color3;
				
				color1 = _color3;
				color3 = _color1;
				
				return self;
			}
			
			/// @argument			color1? {int:color}
			/// @argument			color2? {int:color}
			/// @argument			color3? {int:color}
			/// @description		Set each color value.
			static set = function(_color1 = color1, _color2 = color2, _color3 = color3)
			{
				color1 = _color1;
				color2 = _color2;
				color3 = _color3;
				
				return self;
			}
			
			/// @argument			value {int:color|int:color[]|Color3}
			/// @description		Set all of color values to the ones of the specified value or first
			///						three values of the specified array.
			static setAll = function(_value)
			{
				try
				{
					var _result_color1, _result_color2, _result_color3;
					
					if (is_real(_value))
					{
						_result_color1 = _value;
						_result_color2 = _value;
						_result_color3 = _value;
					}
					else if (is_array(_value))
					{
						_result_color1 = _value[0];
						_result_color2 = _value[1];
						_result_color3 = _value[2];
					}
					else
					{
						_result_color1 = _value.color1;
						_result_color2 = _value.color2;
						_result_color3 = _value.color3;
					}
					
					color1 = _result_color1;
					color2 = _result_color2;
					color3 = _result_color3;
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
				var _color = [color1, color2, color3];
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
				return [color1, color2, color3];
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static constructor = Color3;
		
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
