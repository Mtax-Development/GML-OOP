//  @function			Color2()
/// @argument			color1? {int:color}
/// @argument			color2? {int:color}
/// @description		Constructs a Container for two colors.
//						
//						Construction types:
//						- New constructor
//						- Default for all values: {void}
//						   The color values will be set to white.
//						- One color for all values: color {int:color}
//						- Constructor copy: other {Color2}
function Color2() constructor
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
		
		if (argument_count > 0)
		{
			if (argument_count > 1)
			{
				color1 = argument[0];
				color2 = argument[1];
			}
			else if (is_real(argument[0]))
			{
				//|Construction type: One color for all values.
				color1 = argument[0];
				color2 = argument[0];
			}
			else if (is_instanceof(argument[0], Color2))
			{
				//|Construction type: Constructor copy.
				var _other = argument[0];
				
				color1 = _other.color1;
				color2 = _other.color2;
			}
		}
		
		return self;
	}
	
	/// @returns			{bool}
	/// @description		Check if this constructor is functional.
	static isFunctional = function()
	{
		return ((is_real(color1)) and (is_real(color2)));
	}
	
   #endregion
   #region <Getters>
	
	/// @argument			value {int:color|Color2|[]}
	/// @returns			{bool}
	/// @description		Check if all values of this constructor are the same as the specified
	///						color or respective values of the specified Color2. Those values can be
	///						specified in an array to check if any of them matches all of its values
	///						with the ones of this constructor.
	static equals = function(_value)
	{
		if (is_instanceof(_value, Color2))
		{
			return ((color1 == _value.color1) and (color2 == _value.color2));
		}
		else if (is_real(_value))
		{
			return ((color1 == _value) and (color2 == _value));
		}
		else if (is_array(_value))
		{
			var _i = 0;
			repeat (array_length(_value))
			{
				if (self.equals(_value[_i]))
				{
					return true;
				}
				
				++_i;
			}
		}
		
		return false;
	}
	
	/// @argument			other {Color2}
	/// @argument			value {real}
	/// @returns			{Color2} | On error: {undefined}
	/// @description		Return each color with its RGB components blended towards ones of a
	///						respective other one at a specified percentage.
	static interpolate = function(_other, _value)
	{
		try
		{
			var _color1 = make_color_rgb
			(
				lerp(color_get_red(color1), color_get_red(_other.color1), _value),
				lerp(color_get_green(color1), color_get_green(_other.color1), _value),
				lerp(color_get_blue(color1), color_get_blue(_other.color1), _value)
			);
			
			var _color2 = make_color_rgb
			(
				lerp(color_get_red(color2), color_get_red(_other.color2), _value),
				lerp(color_get_green(color2), color_get_green(_other.color2), _value),
				lerp(color_get_blue(color2), color_get_blue(_other.color2), _value)
			);
			
			return new Color2(_color1, _color2);
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "interpolate()"], _exception);
		}
		
		return undefined;
	}
	
   #endregion
   #region <Setters>
	
	/// @description		Invert the order of colors.
	static reverse = function()
	{
		var _color1 = color1;
		var _color2 = color2;
		
		color1 = _color2;
		color2 = _color1;
		
		return self;
	}
	
	/// @argument			color1? {int:color}
	/// @argument			color2? {int:color}
	/// @description		Set each color value.
	static set = function(_color1 = color1, _color2 = color2)
	{
		color1 = _color1;
		color2 = _color2;
		
		return self;
	}
	
	/// @argument			value {int:color|int:color[]|Color2}
	/// @description		Set all of color values to the ones of the specified value or first
	///						two values of the specified array.
	static setAll = function(_value)
	{
		try
		{
			var _result_color1, _result_color2;
			
			if (is_real(_value))
			{
				_result_color1 = _value;
				_result_color2 = _value;
			}
			else if (is_array(_value))
			{
				_result_color1 = _value[0];
				_result_color2 = _value[1];
			}
			else
			{
				_result_color1 = _value.color1;
				_result_color2 = _value.color2;
			}
			
			color1 = _result_color1;
			color2 = _result_color2;
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "setAll()"], _exception);
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
	///						Content will be represented as color names for built-in constants or
	///						values of RGB components, unless specified to use HSV components instead.
	///						NOTE: The constant value for Silver is the same as for Light Gray. It
	///						cannot be differentiated and will not be represented.
	static toString = function(_multiline = false, _colorHSV = false)
	{
		var _color = [color1, color2];
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
							 "Hue: " + string(color_get_hue(_color[_i])) + _mark_separator_inline +
							 "Saturation: " + string(color_get_saturation(_color[_i]))
											+ _mark_separator_inline +
							 "Value: " + string(color_get_value(_color[_i])) +
							 ")");
						}
						else
						{
							_string_color[_i] =
							("(" +
							 "Red: " + string(color_get_red(_color[_i])) + _mark_separator_inline +
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
		return [color1, color2];
	}
	
   #endregion
  #endregion
  #region [Constructor]
	
	static constructor = Color2;
	
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
	
	var _argument = array_create(argument_count, undefined);
	var _i = 0;
	repeat (argument_count)
	{
		_argument[_i] = argument[_i];
		
		++_i;
	}
	
	script_execute_ext(self.construct, _argument);
	
  #endregion
  #region [Static Constructions]
	
	static white = new Color2(c_white, c_white);
	static black = new Color2(c_black, c_black);
	
  #endregion
}

new Color2();
