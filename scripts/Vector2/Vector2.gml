///@function Vector2
function Vector2(_x, _y) constructor
{
	x = _x;
	y = _y;
	
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
	
	static ToArray = function()
	{
		return [x, y];
	}

#endregion
#region [Asserts]

	static Equals = function(_other)
	{
		return ((x == _other.x) and (y == _other.y))
	}

#endregion
}
