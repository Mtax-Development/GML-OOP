/// @function				Vector4();
/// @description			Constructs a four-value numeric x1-x2/y1-y2 vector.
/// @argument				x1?
/// @argument				x2?
/// @argument				y1?
/// @argument				y2?
///
///							Construction methods:
///							- {real} x1, x2, y1, y2 
///							- {real} (single for all values)
///							- {Vector2}, {Vector2}
///							- {Vector4}
///							- {real[]} (with the following structure: [x1, x2, y1, y2])
///							- {void} (instance's x/y will be set to all values)
function Vector4() constructor
{
	#region [Methods]
		#region <Basic Calculations>
	
			static add = function(_other)
			{
				x1 += _other.x1;
				x2 += _other.x2;
				y1 += _other.y1;
				y2 += _other.y2;
			}
	
			static substract = function(_other)
			{
				x1 -= _other.x1;
				x2 -= _other.x2;
				y1 -= _other.y1;
				y2 -= _other.y2;
			}
	
			static multiply = function(_other)
			{
				x1 *= _other.x1;
				x2 *= _other.x2;
				y1 *= _other.y1;
				y2 *= _other.y2;
			}
	
			static divide = function(_other)
			{
				x1 /= _other.x1;
				x2 /= _other.x2;
				y1 /= _other.y1;
				y2 /= _other.y2;
			}
			
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
		#region <Typing>

			static toString = function()
			{
				return (string(x1) + "-" + string(x2) + "/" + string(y1) + "-" + string(y2));
			}
	
			static toFormattedString = function()
			{
				return 
				("x1: " + string(x1) + "\n" +
				 "x2: " + string(x2) + "\n" +
				 "y1: " + string(y1) + "\n" +
				 "y2: " + string(y2));
			}
	
			static toArray = function()
			{
				return [x1, x2, y1, y2];
			}

		#endregion
		#region <Asserts>

			static equals = function(_other)
			{
				return ((x1 == _other.x1) and (x2 == _other.x2) and (y1 == _other.y1) and (y2 == _other.y2));
			}
	
			static is_between = function(_x, _y)
			{
				return ((_x == clamp(_x, x1, y2)) and (_y == clamp(_y, y1, y2)));
			}

		#endregion
	#endregion
	#region [Constructor]

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
		else if (argument_count == 0)
		{
			x1 = self.x;
			x2 = self.x;
			y1 = self.y;
			y1 = self.y;
		}

	#endregion
}
