/// @function				Vector4()
/// @argument				x1?
/// @argument				x2?
/// @argument				y1?
/// @argument				y2?
///
/// @description			Construct a Vector container for two X and Y coordinate pairs.
///
///							Construction methods:
///							- Four values: {real} x1, {real} x2, {real} y1, {real} y2
///							- One number for all values: {real} value
///							- One number pair: {real} x, {real} y
///							   First number will be set to all values of X.
///							   Second number will be set to all values of Y.
///							- Default (0) for all values: {void}
///							- From array: {real[]} array
///							   First array position will be set to X1.
///							   Second array position will be set to X2.
///							   Third array position will be set to Y1.
///							   Fourth array position will be set to Y2.
///							- From two Vector2: {Vector2} pair_1, {Vector2} pair_2
///							- Constructor copy: {Vector4} other
function Vector4() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				switch(argument_count)
				{
					case 0:
						//|Construction method: Default (0) for all values.
						x1 = 0;
						x2 = 0;
						y1 = 0;
						y2 = 0;
					break;
					
					case 1:
						if (is_array(argument[0]))
						{
							//|Construction method: From array.
							var _array = argument[0];
							
							x1 = _array[0];
							x2 = _array[1];
							y1 = _array[2];
							y2 = _array[3];
						}
						else if (instanceof(argument[0]) == "Vector4")
						{
							//|Construction method: Constructor copy.
							x1 = argument[0].x1;
							x2 = argument[0].x2;
							y1 = argument[0].y1;
							y2 = argument[0].y2;
						}
						else
						{
							//|Construction method: One number for all values.
							x1 = argument[0];
							x2 = argument[0];
							y1 = argument[0];
							y2 = argument[0];
						}
					break;
					
					case 2:
						if ((instanceof(argument[0]) == "Vector2") 
						and (instanceof(argument[1]) == "Vector2"))
						{
							//|Construction method: From two Vector2.
							var _pair_1 = argument[0];
							var _pair_2 = argument[1];
							
							x1 = _pair_1.x;
							x2 = _pair_2.x;
							y1 = _pair_1.y;
							y2 = _pair_2.y;
						}
						else
						{
							//|Construction method: One number pair.
							var _x = argument[0];
							var _y = argument[1];
							
							x1 = _x;
							x2 = _x;
							y1 = _y;
							y2 = _y;
						}
					break;
					
					case 4:
						//|Construction method: Four values.
						x1 = argument[0];
						x2 = argument[1];
						y1 = argument[2];
						y2 = argument[3];
					break;
				}
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{real|Vector4|Vector2} value
			// @description			Add to the values of this Vector4 the specified value or the
			//						values of other specified Vector4 or Vector2.
			static add = function()
			{
				if (instanceof(argument[0]) == "Vector4")
				{
					var _other = argument[0];
					
					x1 += _other.x1;
					x2 += _other.x2;
					y1 += _other.y1;
					y2 += _other.y2;
				}
				else if (instanceof(argument[0]) == "Vector2")
				{
					var _other = argument[0];
					
					x1 += _other.x;
					x2 += _other.x;
					y1 += _other.y;
					y2 += _other.y;
				}
				else
				{
					var _value = argument[0];
					
					x1 += _value;
					x2 += _value;
					y1 += _value;
					y2 += _value;
				}
			}
			
			// @argument			{real|Vector4|Vector2} value
			// @description			Substract from the values of this Vector4 the specified value or 
			//						the values of other specified Vector4 or Vector2.
			static substract = function()
			{
				if (instanceof(argument[0]) == "Vector4")
				{
					var _other = argument[0];
					
					x1 -= _other.x1;
					x2 -= _other.x2;
					y1 -= _other.y1;
					y2 -= _other.y2;
				}
				else if (instanceof(argument[0]) == "Vector2")
				{
					var _other = argument[0];
					
					x1 -= _other.x;
					x2 -= _other.x;
					y1 -= _other.y;
					y2 -= _other.y;
				}
				else
				{
					var _value = argument[0];
					
					x1 -= _value;
					x2 -= _value;
					y1 -= _value;
					y2 -= _value;
				}
			}
			
			// @argument			{real|Vector4|Vector2} value
			// @description			Multiply the values of this Vector4 the specified value or the 
			//						values of other specified Vector4 or Vector2.
			static multiply = function()
			{
				if (instanceof(argument[0]) == "Vector4")
				{
					var _other = argument[0];
					
					x1 *= _other.x1;
					x2 *= _other.x2;
					y1 *= _other.y1;
					y2 *= _other.y2;
				}
				else if (instanceof(argument[0]) == "Vector2")
				{
					var _other = argument[0];
					
					x1 *= _other.x;
					x2 *= _other.x;
					y1 *= _other.y;
					y2 *= _other.y;
				}
				else
				{
					var _value = argument[0];
					
					x1 *= _value;
					x2 *= _value;
					y1 *= _value;
					y2 *= _value;
				}
			}
			
			// @argument			{real|Vector4|Vector2} value
			// @description			Divide the values of this Vector4 the specified value or the 
			//						values of other specified Vector4 or Vector2.
			static divide = function()
			{
				if (instanceof(argument[0]) == "Vector4")
				{
					var _other = argument[0];
					
					x1 /= _other.x1;
					x2 /= _other.x2;
					y1 /= _other.y1;
					y2 /= _other.y2;
				}
				else if (instanceof(argument[0]) == "Vector2")
				{
					var _other = argument[0];
					
					x1 /= _other.x;
					x2 /= _other.x;
					y1 /= _other.y;
					y2 /= _other.y;
				}
				else
				{
					var _value = argument[0];
					
					x1 /= _value;
					x2 /= _value;
					y1 /= _value;
					y2 /= _value;
				}
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
			
			// @returns				{Vector2}
			// @description			Return the middle point of this Vector4.
			static getMiddle = function()
			{
				return new Vector2(lerp(x1, x2, 0.5), lerp(y1, y2, 0.5));
			}
			
			// @returns				{real}
			// @description			Return the middle point between the x values of this Vector4.
			static getMiddle_x = function()
			{
				return lerp(x1, x2, 0.5);
			}
			
			// @returns				{real}
			// @description			Return the middle point between the y values of this Vector4.
			static getMiddle_y = function()
			{
				return lerp(y1, y2, 0.5);
			}
			
			// @returns				{real}
			// @description			Return the shortest distance between two points.
			static getDistance = function()
			{
				return point_distance(x1, y1, x2, y2);
			}
			
			// @returns				{real}
			// @description			Return the direction from the first point towards the second.
			static getAngle_1to2 = function()
			{
				return point_direction(x1, y1, x2, y2);
			}
			
			// @returns				{real}
			// @description			Return the direction from the second point towards the first.
			static getAngle_2to1 = function()
			{
				return point_direction(x2, y2, x1, y1);
			}
			
			// @argument			{Vector4} other
			// @returns				{bool}
			// @description			Check whether two Vector4 have the same values.
			static equals = function(_other)
			{
				return ((x1 == _other.x1) and (x2 == _other.x2) 
						and (y1 == _other.y1) and (y2 == _other.y2));
			}
			
			// @argument			{Vector2} location
			// @returns				{bool}
			// @description			Check if a point in space is within this Vector4.
			static isBetween = function(_location)
			{
				return ((_location.x == clamp(_location.x, x1, x2)) 
					   and (_location.y == clamp(_location.y, y1, y2)));
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Create a string representing the constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the output of X and then Y
			//						values of this Vector4.
			static toString = function(_multiline)
			{
				if (_multiline)
				{
					return ("x1: " + string(x1) + "\n" +
							"x2: " + string(x2) + "\n" +
							"y1: " + string(y1) + "\n" +
							"y2: " + string(y2));
				}
				else
				{
					var _mark_separator = ", ";
					
					return (instanceof(self) + "(" +
							"x1: " + string(x1) + _mark_separator +
							"x2: " + string(x2) + _mark_separator +
							"y1: " + string(y1) + _mark_separator +
							"y2: " + string(y2) +
							")");
				}
			}
			
			// @returns				{real[]}
			// @description			Return an array containing all values of the Vector.
			//						The X values will be set to the first and second positions of 
			//						that array, the Y value will be set to the third and fourth 
			//						positions of that array.
			static toArray = function()
			{
				return [x1, x2, y1, y2];
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		argument_original = array_create(argument_count, undefined);
		
		var _i = 0;
		
		repeat (argument_count)
		{
			argument_original[_i] = argument[_i];
			
			++_i;
		}
		
		switch (argument_count)
		{
			case 0:
				self.construct();
			break;
			
			case 1:
				self.construct(argument_original[0]);
			break;
			
			case 2:
				self.construct(argument_original[0], argument_original[1]);
			break;
			
			case 4:
			default:
				self.construct(argument_original[0], argument_original[1], argument_original[2],
							   argument_original[3]);
			break;
		}
		
	#endregion
}
