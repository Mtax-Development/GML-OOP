/// @function				Vector2();
/// @description			Constructs a two-value numeric x/y vector.
///							Construction methods:
///							- {real} x, y
///							- {real} (single for both values)
///							- {Vector2}
///							- {real[]} (with the following structure: [x, y])
function Vector2() constructor
{
	if (argument_count == 2)
	{
		x = argument[0];
		y = argument[1];
	}
	else if (argument_count == 1)
	{
		if (is_struct(argument[0]))
		{
			x = argument[0].x;
			y = argument[0].y;

		}
		else if (is_array(argument[0]))
		{
			var array = argument[0];
			
			x = array[0];
			y = array[1];
		}
		else
		{
			x = argument[0];
			y = argument[0];
		}
	}
	
#region [Basic Calculations]
	
	static Add = function(_other)
	{
		x += _other.x;
		y += _other.y;
	}
	
	static Substract = function(_other)
	{
		x -= _other.x;
		y -= _other.y;
	}
	
	static Multiply = function(_other)
	{
		x *= _other.x;
		y *= _other.y;
	}
	
	static Divide = function(_other)
	{
		x /= _other.x;
		y /= _other.y;
	}
	
#endregion
#region [Re-typing]

	static ToString = function()
	{
		return (string(x) + "/" + string(y));
	}
	
	static ToFormattedString = function()
	{
		return 
		"x: " + string(x) + "\n" +
		"y: " + string(y);
	}
	
	static ToArray = function()
	{
		return [x, y];
	}

#endregion
#region [Asserts]

	static Equals = function(_other)
	{
		return ((x == _other.x) and (y == _other.y));
	}
	
	static IsBetween = function(_number)
	{
		return (_number == clamp(_number, x, y));
	}

#endregion

}
