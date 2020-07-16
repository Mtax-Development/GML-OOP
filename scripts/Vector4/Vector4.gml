/// @function				Vector4()
/// @argument				x1?
/// @argument				x2?
/// @argument				y1?
/// @argument				y2?
///
/// @description			Constructs a four-value numeric x1-x2/y1-y2 Vector container.
///
///							Construction methods:
///							- {real}, {real}, {real}, {real} (x1, x2, y1, y2) 
///							- {real} (single for all values)
///							- {real[]} (with the following structure: [x1, x2, y1, y2])
///							- {Vector2}, {Vector2}
///							- {Vector4}
///							- {void} (instance's own x/y will be set to all appriopate values)
function Vector4() constructor
{
	#region [Methods]
		#region <Operations>
			
			// @argument			{Vector4} other
			// @description			Add to values of the current Vector4 from other one's.
			static add = function(_other)
			{
				x1 += _other.x1;
				x2 += _other.x2;
				y1 += _other.y1;
				y2 += _other.y2;
			}
			
			// @argument			{Vector4} other
			// @description			Substract from values of the current Vector4 by other one's.
			static substract = function(_other)
			{
				x1 -= _other.x1;
				x2 -= _other.x2;
				y1 -= _other.y1;
				y2 -= _other.y2;
			}
			
			// @argument			{Vector4} other
			// @description			Multiply values of the current Vector4 by other one's.
			static multiply = function(_other)
			{
				x1 *= _other.x1;
				x2 *= _other.x2;
				y1 *= _other.y1;
				y2 *= _other.y2;
			}
			
			// @argument			{Vector4} other
			// @description			Divide values of the current Vector4 by other one's.
			static divide = function(_other)
			{
				x1 /= _other.x1;
				x2 /= _other.x2;
				y1 /= _other.y1;
				y2 /= _other.y2;
			}
			
			// @description			Swap the X and Y values of this Vector4.
			static flip = function()
			{
				var x1_new = y1;
				var x2_new = y2;
				var y1_new = x1;
				var y2_new = x2;
				
				x1 = x1_new;
				x2 = x2_new;
				y1 = y1_new;
				y2 = y2_new;
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{real}
			// @description			Return the shortest distance between two points.
			static distance = function()
			{
				return point_distance(x1, y1, x2, y2);
			}
			
			// @returns				{real}
			// @description			Return the direction from the first point towards the second.
			static angle_1to2 = function()
			{
				return point_direction(x1, y1, x2, y2);
			}
			
			// @returns				{real}
			// @description			Return the direction from the second point towards the first.
			static angle_2to1 = function()
			{
				return point_direction(x2, y2, x1, y1);
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Overrides the string conversion with a simple value output.
			static toString = function()
			{
				return (string(x1) + "-" + string(x2) + "/" + string(y1) + "-" + string(y2));
			}
			
			// @returns				{string}
			// @description			Create a multi-line string with value output.
			static toFormattedString = function()
			{
				return 
				("x1: " + string(x1) + "\n" +
				 "x2: " + string(x2) + "\n" +
				 "y1: " + string(y1) + "\n" +
				 "y2: " + string(y2));
			}
			
			// @returns				{real[]}
			// @description			Return an array containing all values of the Vector.
			static toArray = function()
			{
				return [x1, x2, y1, y2];
			}
			
		#endregion
		#region <Asserts>
			
			// @argument			{Vector4} other
			// @returns				{bool}
			// @description			Check whether two Vector4 have the same values.
			static equals = function(_other)
			{
				return ((x1 == _other.x1) and (x2 == _other.x2) 
						and (y1 == _other.y1) and (y2 == _other.y2));
			}
			
			// @argument			{real} x
			// @argument			{real} y
			// @returns				{bool}
			// @description			Check if two x/y values are between the range of this Vector4's.
			static is_between = function(_x, _y)
			{
				return ((_x == clamp(_x, x1, y2)) and (_y == clamp(_y, y1, y2)));
			}
			
		#endregion
	#endregion
	#region [Constructor]
	
		switch(argument_count)
		{
			case 4:
				x1 = argument[0];
				x2 = argument[1];
				y1 = argument[2];
				y2 = argument[3];
			break;
			
			case 2:
				x1 = argument[0].x;
				x2 = argument[1].x;
				y1 = argument[0].y;
				y2 = argument[1].y;
			break;
			
			case 1:
				if (is_array(argument[0]))
				{
					var array = argument[0];
			
					x1 = array[0];
					x2 = array[1];
					y1 = array[2];
					y2 = array[3];
				}
				else if (instanceof(argument[0]) == "Vector4")
				{
					x1 = argument[0].x1;
					x2 = argument[0].x2;
					y1 = argument[0].y1;
					y2 = argument[0].y2;
				}
				else
				{
					x1 = argument[0];
					x2 = argument[0];
					y1 = argument[0];
					y2 = argument[0];
				}
			break;
			
			case 0:
				x1 = other.x;
				x2 = other.x;
				y1 = other.y;
				y1 = other.y;
			break;
		}
		
	#endregion
}
