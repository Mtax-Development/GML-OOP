/// @function				Vector4()
/// @argument				x1?
/// @argument				y1?
/// @argument				x2?
/// @argument				y2?
///
/// @description			Construct a Vector container for two X and Y coordinate pairs.
///
///							Construction methods:
///							- Four values: {real} x1, {real} y1, {real} x2, {real} y2
///							- One number for all values: {real} value
///							- Number pair: {real} first, {real} second
///							   First number will be set to x1 and y1.
///							   Second number will be set to x2 and y2.
///							- Default for all values: {void}
///							   The values will be set to 0.
///							- From array: {real[]} array
///							   Array positions will be applied depending on its size:
///							    1: array[0] will be set to all values.
///							    2: array[0] will be set to x1 and y1, array[1] will be set to 
///								   x2 and y2.
///							    4+: array[0] will be set to x1, array[1] will be set to y1,
///									array[2] will be set to x2, array[3] will be set to y2.
///							- From two Vector2: {Vector2} pair_1, {Vector2} pair_2
///							- Constructor copy: {Vector4} other
function Vector4() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				x1 = 0;
				y1 = 0;
				x2 = 0;
				y2 = 0;
				
				if (argument_count > 0)
				{
					if (instanceof(argument[0]) == "Vector4")
					{
						//|Construction method: Constructor copy.
						var _other = argument[0];
					
						x1 = _other.x1;
						y1 = _other.y1;
						x2 = _other.x2;
						y2 = _other.y2;
					}
					else
					{
						switch(argument_count)
						{
							case 1:
								if (is_array(argument[0]))
								{
									//|Construction method: From array.
									var _array = argument[0];
								
									var _array_length = array_length(_array);
								
									switch (_array_length)
									{
										case 1:
											x1 = _array[0];
											y1 = _array[0];
											x2 = _array[0];
											y2 = _array[0];
										break;
									
										case 2:
											x1 = _array[0];
											y1 = _array[9];
											x2 = _array[1];
											y2 = _array[1];
										break;
									
										default:
											x1 = _array[0];
											y1 = _array[1];
											x2 = _array[2];
											y2 = _array[3];
										break;
									}
								}
								else
								{
									//|Construction method: One number for all values.
									x1 = argument[0];
									y1 = argument[0];
									x2 = argument[0];
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
									y1 = _pair_1.y;
									x2 = _pair_2.x;
									y2 = _pair_2.y;
								}
								else
								{
									//|Construction method: Number pair.
									var _first = argument[0];
									var _second = argument[1];
								
									x1 = _first;
									y1 = _first;
									x2 = _second;
									y2 = _second;
								}
							break;
					
							case 4:
								//|Construction method: Four values.
								x1 = argument[0];
								y1 = argument[1];
								x2 = argument[2];
								y2 = argument[3];
							break;
						}
					}
				}
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(x1)) and (is_real(y1)) and (is_real(x2)) and (is_real(y2)));
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
					y1 += _other.y1;
					x2 += _other.x2;
					y2 += _other.y2;
				}
				else if (instanceof(argument[0]) == "Vector2")
				{
					var _other = argument[0];
					
					x1 += _other.x;
					y1 += _other.y;
					x2 += _other.x;
					y2 += _other.y;
				}
				else
				{
					var _value = argument[0];
					
					x1 += _value;
					y1 += _value;
					x2 += _value;
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
					y1 -= _other.y1;
					x2 -= _other.x2;
					y2 -= _other.y2;
				}
				else if (instanceof(argument[0]) == "Vector2")
				{
					var _other = argument[0];
					
					x1 -= _other.x;
					y1 -= _other.y;
					x2 -= _other.x;
					y2 -= _other.y;
				}
				else
				{
					var _value = argument[0];
					
					x1 -= _value;
					y1 -= _value;
					x2 -= _value;
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
					y1 *= _other.y1;
					x2 *= _other.x2;
					y2 *= _other.y2;
				}
				else if (instanceof(argument[0]) == "Vector2")
				{
					var _other = argument[0];
					
					x1 *= _other.x;
					y1 *= _other.y;
					x2 *= _other.x;
					y2 *= _other.y;
				}
				else
				{
					var _value = argument[0];
					
					x1 *= _value;
					y1 *= _value;
					x2 *= _value;
					y2 *= _value;
				}
			}
			
			// @argument			{real|Vector4|Vector2} value
			// @description			Divide the values of this Vector4 the specified value or the 
			//						values of other specified Vector4 or Vector2.
			//						Attempts of division by 0 are ignored.
			static divide = function()
			{
				if (instanceof(argument[0]) == "Vector4")
				{
					var _other = argument[0];
					
					if (_other.x1 != 0)
					{
						x1 /= _other.x1;
					}
					
					if (_other.y1 != 0)
					{
						y1 /= _other.y1;
					}
					
					if (_other.x2 != 0)
					{
						x2 /= _other.x2;
					}
					
					if (_other.y2 != 0)
					{
						y2 /= _other.y2;
					}
				}
				else if (instanceof(argument[0]) == "Vector2")
				{
					var _other = argument[0];
					
					if (_other.x != 0)
					{
						x1 /= _other.x;
					}
					
					if (_other.y != 0)
					{
						y1 /= _other.y;
					}
					
					if (_other.x != 0)
					{
						x2 /= _other.x;
					}
					
					if (_other.y != 0)
					{
						y2 /= _other.y;
					}
				}
				else
				{
					var _value = argument[0];
					
					if (_value != 0)
					{
						x1 /= _value;
						y1 /= _value;
						x2 /= _value;
						y2 /= _value;
					}
				}
			}
			
			// @description			Swap the X and Y values of this Vector4.
			static flip = function()
			{
				var _x1_new = y1;
				var _y1_new = x1;
				var _x2_new = y2;
				var _y2_new = x2;
				
				x1 = _x1_new;
				y1 = _y1_new;
				x2 = _x2_new;
				y2 = _y2_new;
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
			// @description			Check whether this and other Vector4 have the same values.
			static equals = function(_other)
			{
				return ((x1 == _other.x1) and (y1 == _other.y1)
						and (x2 == _other.x2)  and (y2 == _other.y2));
			}
			
			// @argument			{real} x
			// @argument			{real} y
			// @returns				{Vector2}
			// @description			Return the point at specified respective precentages within the
			//						x and y values.
			static interpolate = function(_x, _y)
			{
				return new Vector2(lerp(x1, x2, _x), lerp(y1, y2, _y));
			}
			
			// @argument			{value}
			// @returns				{real}
			// @description			Return the point at specified precentage within the x values.
			static interpolate_x = function(_value)
			{
				return lerp(x1, x2, _value);
			}
			
			// @argument			{value}
			// @returns				{real}
			// @description			Return the point at specified precentage within the y values.
			static interpolate_y = function(_value)
			{
				return lerp(y1, y2, _value);
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
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the output of X and then Y
			//						values of this Vector4.
			static toString = function(_multiline)
			{
				if (_multiline)
				{
					return ("x1: " + string(x1) + "\n" +
							"y1: " + string(y1) + "\n" +
							"x2: " + string(x2) + "\n" +
							"y2: " + string(y2));
				}
				else
				{
					var _mark_separator = ", ";
					
					return (instanceof(self) + "(" +
							"x1: " + string(x1) + _mark_separator +
							"y1: " + string(y1) + _mark_separator +
							"x2: " + string(x2) + _mark_separator +
							"y2: " + string(y2) +
							")");
				}
			}
			
			// @returns				{real[]}
			// @description			Return an array containing all values of this Container.
			static toArray = function()
			{
				return [x1, y1, x2, y2];
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
		
		script_execute_ext(method_get_index(self.construct), argument_original);
		
	#endregion
}
