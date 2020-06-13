/// @function				Vector2();
/// @argument				x?
/// @argument				y?
/// @description			Constructs a two-value numeric x/y vector.
///
///							Construction methods:
///							- {real} x, y
///							- {real} (single for both values)
///							- {Vector2}
///							- {real[]} (with the following structure: [x, y])
///							- {void} (instance's own x/y will be set to both values)
function Vector2() constructor
{
	#region [Methods]
		#region <Basic Calculations>
			
			// @argument			other {Vector2}
			// @description			Add values of the current Vector2 from other one.
			static add = function(_other)
			{
				x += _other.x;
				y += _other.y;
			}
			
			// @argument			other {Vector2}
			// @description			Substract values of the current Vector2 from other one.
			static substract = function(_other)
			{
				x -= _other.x;
				y -= _other.y;
			}
			
			// @argument			other {Vector2}
			// @description			Multiply values of the current Vector2 by other one.
			static multiply = function(_other)
			{
				x *= _other.x;
				y *= _other.y;
			}
						
			// @argument			otHer {Vector2}
			// @description			Divide values of the current Vector2 by other one.
			static divide = function(_other)
			{
				x /= _other.x;
				y /= _other.y;
			}
			
			// @description			Swap X and Y values of this Vector2.
			static flip = function()
			{
				var x_new = y;
				var y_new = x;
			
				x = y_new;
				y = x_new;
			}
	
		#endregion
		#region <Typing>
			
			// @description			Override the string conversion with a simple value output.
			// @returns				{string}
			static toString = function()
			{
				return (string(x) + "/" + string(y));
			}
			
			// @description			Create a multi-line string with value output.
			// @returns				{string}
			static toFormattedString = function()
			{
				return 
				"x: " + string(x) + "\n" +
				"y: " + string(y);
			}
			
			// @description			Return an array containing all values of the Vector.
			// @returns				{array}
			static toArray = function()
			{
				return [x, y];
			}

		#endregion
		#region <Asserts>
			
			// @argument			other {Vector2}
			// @description			Check whether two Vector2 have the same values.
			// @returns				{bool}
			static equals = function(_other)
			{
				return ((x == _other.x) and (y == _other.y));
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
		else if (argument_count == 0)
		{
			x = other.x
			y = other.y
		}

	#endregion
}
