/// @function				Vector2()
/// @argument				x?
/// @argument				y?
///
/// @description			Constructs a two-value numeric x/y Vector container.
///
///							Construction methods:
///							- {real}, {real} (x, y)
///							- {real} (single for both values)
///							- {real[]} (with the following structure: [x, y])
///							- {Vector2}
///							- {void} (instance's own x/y will be set to both values)
function Vector2() constructor
{
	#region [Methods]
		#region <Operations>
			
			// @argument			other {Vector2}
			// @description			Add to values of the current Vector2 from other one's.
			static add = function(_other)
			{
				x += _other.x;
				y += _other.y;
			}
			
			// @argument			other {Vector2}
			// @description			Substract from values of the current Vector2 by other one's.
			static substract = function(_other)
			{
				x -= _other.x;
				y -= _other.y;
			}
			
			// @argument			other {Vector2}
			// @description			Multiply values of the current Vector2 by other one's.
			static multiply = function(_other)
			{
				x *= _other.x;
				y *= _other.y;
			}
						
			// @argument			other {Vector2}
			// @description			Divide values of the current Vector2 by other one's.
			static divide = function(_other)
			{
				x /= _other.x;
				y /= _other.y;
			}
			
			// @description			Swap the X and Y values of this Vector2.
			static flip = function()
			{
				var x_new = y;
				var y_new = x;
			
				x = y_new;
				y = x_new;
			}
	
		#endregion
		#region <Typing>
			
			// @returns				{string}
			// @description			Override the string conversion with a simple value output.
			static toString = function()
			{
				return (string(x) + "/" + string(y));
			}
			
			// @returns				{string}
			// @description			Create a multi-line string with value output.
			static toFormattedString = function()
			{
				return 
				"x: " + string(x) + "\n" +
				"y: " + string(y);
			}
			
			// @returns				{real[]}
			// @description			Return an array containing all values of the Vector.
			static toArray = function()
			{
				return [x, y];
			}

		#endregion
		#region <Asserts>
			
			// @argument			other {Vector2}
			// @returns				{bool}
			// @description			Check whether two Vector2 have the same values.
			static equals = function(_other)
			{
				return ((x == _other.x) and (y == _other.y));
			}

		#endregion
	#endregion
	#region [Constructor]
	
		switch (argument_count)
		{
			case 2:	
				x = argument[0];
				y = argument[1];
			break;
			
			case 1:
				if (is_array(argument[0]))
				{
					var array = argument[0];
					
					x = array[0];
					y = array[1];
				}
				else if (instanceof(argument[0]) == "Vector2")
				{
					x = argument[0].x;
					y = argument[0].y;
				}
				else
				{
					x = argument[0];
					y = argument[0];
				}
			break;
			
			case 0:
				x = other.x;
				y = other.y;
			break;
		}

	#endregion
}
