/// @function				Vector2();
/// @argument				x
/// @argument				y?
/// @description			Constructs a two-value numeric x/y vector.
///
///							Construction methods:
///							- {real} x, y
///							- {real} (single for both values)
///							- {Vector2}
///							- {real[]} (with the following structure: [x, y])
function Vector2() constructor
{
	#region [Methods]
		#region <Basic Calculations>
	
		static add = function(_other)
		{
			x += _other.x;
			y += _other.y;
		}
	
		static substract = function(_other)
		{
			x -= _other.x;
			y -= _other.y;
		}
	
		static multiply = function(_other)
		{
			x *= _other.x;
			y *= _other.y;
		}
	
		static divide = function(_other)
		{
			x /= _other.x;
			y /= _other.y;
		}
	
		#endregion
		#region <Typing>

		static toString = function()
		{
			return (string(x) + "/" + string(y));
		}
	
		static toFormattedString = function()
		{
			return 
			"x: " + string(x) + "\n" +
			"y: " + string(y);
		}
	
		static toArray = function()
		{
			return [x, y];
		}

		#endregion
		#region <Asserts>

		static equals = function(_other)
		{
			return ((x == _other.x) and (y == _other.y));
		}
	
		static is_between = function(_number)
		{
			return (_number == clamp(_number, x, y));
		}

		#endregion
	#endregion
	#region [Constructor]

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

	#endregion
}
