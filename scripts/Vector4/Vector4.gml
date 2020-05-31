/// @function				Vector4();
/// @description			Constructs a four value x1-x2/y1-y2 vector.
///							Construction methods:
///							- {real} x1, x2, y1, y2 
///							- {real} (single for all values)
///							- {Vector2}, {Vector2}
///							- {Vector4}
///							- {real[]} (with the following structure: [x1, x2, y1, y2])
function Vector4() constructor
{
	if (argument_count == 4)
	{
		x1 = argument[0];
		x2 = argument[1];
		y1 = argument[2];
		y2 = argument[3];
	}
	else if ((argument_count == 2) and (is_struct(argument[0])) and (is_struct(argument[1])))
	{		
		x1 = argument[0].x;
		x2 = argument[1].x;
		y1 = argument[0].y;
		y2 = argument[1].y;
	}
	else if (argument_count == 1)
	{
		if (is_struct(argument[0]))
		{
			x1 = argument[0].x1;
			x2 = argument[0].x2;
			y1 = argument[0].y1;
			y2 = argument[0].y2;
		}
		else if (is_array(argument[0]))
		{
			var array = argument[0];
			
			x1 = array[0];
			x2 = array[1];
			y1 = array[2];
			y2 = array[3];
		}
		else
		{
			x1 = argument[0];
			x2 = argument[0];
			y1 = argument[0];
			y2 = argument[0];
		}
	}
	
#region [Basic Calculations]
	
	static Add = function(_other)
	{
		x1 += _other.x1;
		x2 += _other.x2;
		y1 += _other.y1;
		y2 += _other.y2;
	}
	
	static Substract = function(_other)
	{
		x1 -= _other.x1;
		x2 -= _other.x2;
		y1 -= _other.y1;
		y2 -= _other.y2;
	}
	
	static Multiply = function(_other)
	{
		x1 *= _other.x1;
		x2 *= _other.x2;
		y1 *= _other.y1;
		y2 *= _other.y2;
	}
	
	static Divide = function(_other)
	{
		x1 /= _other.x1;
		x2 /= _other.x2;
		y1 /= _other.y1;
		y2 /= _other.y2;
	}
	
#endregion
#region [Re-typing]

	static ToString = function()
	{
		return (string(x1) + "-" + string(x2) + "/" + string(y1) + "-" + string(y2));
	}
	
	static ToFormattedString = function()
	{
		return 
		"x1: " + string(x1) + "\n" +
		"x2: " + string(x2) + "\n" +
		"y1: " + string(y1) + "\n" +
		"y2: " + string(y2);
	}
	
	static ToArray = function()
	{
		return [x1, x2, y1, y2];
	}

#endregion
#region [Asserts]

	static Equals = function(_other)
	{
		return ((x1 == _other.x1) and (x2 == _other.x2) and (y1 == _other.y1) and (y2 == _other.y2))
	}

#endregion
}