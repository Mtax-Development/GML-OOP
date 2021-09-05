/// @function				Vector4()
/// @argument				{real} x1?
/// @argument				{real} y1?
/// @argument				{real} x2?
/// @argument				{real} y2?
///							
/// @description			Construct a Vector container for two x and y coordinate pairs.
///							
///							Construction types:
///							- Four numbers: {real} x1, {real} y1, {real} x2, {real} y2
///							- One number for all values: {real} value
///							- Number pair: {real} first, {real} second
///							   First number will be set to x1 and y1.
///							   Second number will be set to x2 and y2.
///							- From array: {real[]} array
///							   Array positions will be applied depending on its size:
///								1: array[0] will be set to all values.
///								2: array[0] will be set to x1 and y1, array[1] will be set to 
///								   x2 and y2.
///								4+: array[0] will be set to x1, array[1] will be set to y1,
///									array[2] will be set to x2, array[3] will be set to y2.
///							- From two Vector2: {Vector2} pair1, {Vector2} pair2
///							- Empty: {void|undefined}
///							- Constructor copy: {Vector4} other
function Vector4() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				x1 = undefined;
				y1 = undefined;
				x2 = undefined;
				y2 = undefined;
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (instanceof(argument[0]) == "Vector4")
					{
						//|Construction type: Constructor copy.
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
									//|Construction type: From array.
									var _array = argument[0];
									
									switch (array_length(_array))
									{
										case 1:
											x1 = _array[0];
											y1 = _array[0];
											x2 = _array[0];
											y2 = _array[0];
										break;
									
										case 2:
											x1 = _array[0];
											y1 = _array[0];
											x2 = _array[1];
											y2 = _array[1];
										break;
										
										case 4:
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
									//|Construction type: One number for all values.
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
									//|Construction type: From two Vector2.
									var _pair1 = argument[0];
									var _pair2 = argument[1];
									
									x1 = _pair1.x;
									y1 = _pair1.y;
									x2 = _pair2.x;
									y2 = _pair2.y;
								}
								else
								{
									//|Construction type: Number pair.
									var _pair1 = argument[0];
									var _pair2 = argument[1];
									
									x1 = _pair1;
									y1 = _pair1;
									x2 = _pair2;
									y2 = _pair2;
								}
							break;
							
							case 4:
								//|Construction type: Four numbers.
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
				return ((is_real(x1)) and (is_real(y1)) and (is_real(x2)) and (is_real(y2))
						and (!is_nan(x1)) and (!is_nan(y1)) and (!is_nan(x2)) and (!is_nan(y2))
						and (!is_infinity(x1)) and (!is_infinity(y1)) and (!is_infinity(x2))
						and (!is_infinity(y2)));
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{any} value...
			// @returns				{bool}
			// @description			Check if this Vector4 contains at least one of the specified
			//						values.
			static contains = function()
			{
				var _i = 0;
				repeat (argument_count)
				{
					var _value = argument[_i];
					
					if ((x1 == _value) or (y1 == _value) or (x2 == _value) or (y2 == _value))
					{
						return true;
					}
					
					++_i;
				}
				
				return false;
			}
			
			// @argument			{Vector4} other
			// @returns				{bool}
			// @description			Check if this and the specified Vector4 have the same values.
			static equals = function(_other)
			{
				return ((x1 == _other.x1) and (y1 == _other.y1) and (x2 == _other.x2)
						and (y2 == _other.y2));
			}
			
			// @argument			{real|Vector2|Vector4} value?
			// @returns				{Vector2|Vector4}
			// @description			Return the sum of either the values of this Vector4 as a Vector2
			//						or them added to the specified value or the ones of the specified
			//						Vector2 or Vector4 as a Vector4.
			static sum = function()
			{
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					var _value = argument[0];
					var _sum_x1, _sum_y1, _sum_x2, _sum_y2;
					
					if (is_real(_value))
					{
						_sum_x1 = (x1 + _value);
						_sum_y1 = (y1 + _value);
						_sum_x2 = (x2 + _value);
						_sum_y2 = (y2 + _value);
					}
					else
					{
						switch (instanceof(_value))
						{
							case "Vector2":
								_sum_x1 = (x1 + _value.x);
								_sum_y1 = (y1 + _value.y);
								_sum_x2 = (x2 + _value.x);
								_sum_y2 = (y2 + _value.y);
							break;
							
							case "Vector4":
							default:
								_sum_x1 = (x1 + _value.x1);
								_sum_y1 = (y1 + _value.y1);
								_sum_x2 = (x2 + _value.x2);
								_sum_y2 = (y2 + _value.y2);
							break;
						}
					}
					
					return new Vector4(_sum_x1, _sum_y1, _sum_x2, _sum_y2);
				}
				else
				{
					var _sum_x = (x1 + x2);
					var _sum_y = (y1 + y2);
					
					return new Vector2(_sum_x, _sum_y);
				}
			}
			
			// @argument			{real|Vector2|Vector4} value?
			// @returns				{real|real[]}
			// @description			Return the sum of the x values of either this Vector4 or them
			//						added to the specified value of the x values of the specified
			//						Vector2 or Vector4 in an array.
			static sumX = function()
			{
				if ((argument_count > 0) and (argument[0] != self))
				{
					var _value = argument[0];
					var _sum_x1, _sum_x2;
					
					if (is_real(_value))
					{
						_sum_x1 = (x1 + _value);
						_sum_x2 = (x2 + _value);
					}
					else
					{
						switch (instanceof(_value))
						{
							case "Vector2":
								_sum_x1 = (x1 + _value.x);
								_sum_x2 = (x2 + _value.x);
							break;
							
							case "Vector4":
							default:
								_sum_x1 = (x1 + _value.x1);
								_sum_x2 = (x2 + _value.x2);
							break;
						}
					}
					
					return [_sum_x1, _sum_x2];
				}
				else
				{
					return (x1 + x2);
				}
			}
			
			// @argument			{real|Vector2|Vector4} value?
			// @returns				{real|real[]}
			// @description			Return the sum of the y values of either this Vector4 or them
			//						added to the specified value of the y values of the specified
			//						Vector2 or Vector4 in an array.
			static sumY = function()
			{
				if ((argument_count > 0) and (argument[0] != self))
				{
					var _value = argument[0];
					var _sum_y1, _sum_y2;
					
					if (is_real(_value))
					{
						_sum_y1 = (y1 + _value);
						_sum_y2 = (y2 + _value);
					}
					else
					{
						switch (instanceof(_value))
						{
							case "Vector2":
								_sum_y1 = (y1 + _value.y);
								_sum_y2 = (y2 + _value.y);
							break;
							
							case "Vector4":
							default:
								_sum_y1 = (y1 + _value.y1);
								_sum_y2 = (y2 + _value.y2);
							break;
						}
					}
					
					return [_sum_y1, _sum_y2];
				}
				else
				{
					return (y1 + y2);
				}
			}
			
			// @argument			{real|Vector2|Vector4} value?
			// @returns				{Vector2|Vector4}
			// @description			Return the difference between either the values of this Vector4
			//						as a Vector2 or them and the specified value or the ones of the
			//						specified Vector2 or Vector4 as a Vector4.
			static difference = function()
			{
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					var _value = argument[0];
					var _difference_x1, _difference_y1, _difference_x2, _difference_y2;
					
					if (is_real(_value))
					{
						_difference_x1 = abs(x1 - _value);
						_difference_y1 = abs(y1 - _value);
						_difference_x2 = abs(x2 - _value);
						_difference_y2 = abs(y2 - _value);
					}
					else
					{
						switch (instanceof(_value))
						{
							case "Vector2":
								_difference_x1 = abs(x1 - _value.x);
								_difference_y1 = abs(y1 - _value.y);
								_difference_x2 = abs(x2 - _value.x);
								_difference_y2 = abs(y2 - _value.y);
							break;
							
							case "Vector4":
							default:
								_difference_x1 = abs(x1 - _value.x1);
								_difference_y1 = abs(y1 - _value.y1);
								_difference_x2 = abs(x2 - _value.x2);
								_difference_y2 = abs(y2 - _value.y2);
							break;
						}
					}
					
					return new Vector4(_difference_x1, _difference_y1, _difference_x2,
									   _difference_y2);
				}
				else
				{
					var _difference_x = abs(x1 - x2);
					var _difference_y = abs(y1 - y2);
					
					return new Vector2(_difference_x, _difference_y);
				}
			}
			
			// @argument			{real|Vector2|Vector4} value?
			// @returns				{real|real[]}
			// @description			Return the difference between the x values of either this Vector4
			//						or them and the specified value or the ones of the specified
			//						Vector2 or Vector4 in an array.
			static differenceX = function()
			{
				if ((argument_count > 0) and (argument[0] != self))
				{
					var _value = argument[0];
					var _difference_x1, _difference_x2;
					
					if (is_real(_value))
					{
						_difference_x1 = abs(x1 - _value);
						_difference_x2 = abs(x2 - _value);
					}
					else
					{
						switch (instanceof(_value))
						{
							case "Vector2":
								_difference_x1 = abs(x1 - _value.x);
								_difference_x2 = abs(x2 - _value.x);
							break;
							
							case "Vector4":
							default:
								_difference_x1 = abs(x1 - _value.x1);
								_difference_x2 = abs(x2 - _value.x2);
							break;
						}
					}
					
					return [_difference_x1, _difference_x2];
				}
				else
				{
					return abs(x1 - x2);
				}
			}
			
			// @argument			{real|Vector2|Vector4} value?
			// @returns				{real|real[]}
			// @description			Return the difference between the y values of either this Vector4
			//						or them and the specified value or the ones of the specified
			//						Vector2 or Vector4 in an array.
			static differenceY = function()
			{
				if ((argument_count > 0) and (argument[0] != self))
				{
					var _value = argument[0];
					var _difference_y1, _difference_y2;
					
					if (is_real(_value))
					{
						_difference_y1 = abs(y1 - _value);
						_difference_y2 = abs(y2 - _value);
					}
					else
					{
						switch (instanceof(_value))
						{
							case "Vector2":
								_difference_y1 = abs(y1 - _value.y);
								_difference_y2 = abs(y2 - _value.y);
							break;
							
							case "Vector4":
							default:
								_difference_y1 = abs(y1 - _value.y1);
								_difference_y2 = abs(y2 - _value.y2);
							break;
						}
					}
					
					return [_difference_y1, _difference_y2];
				}
				else
				{
					return abs(y1 - y2);
				}
			}
			
			// @argument			{real|Vector2|Vector4} value?
			// @returns				{Vector2|Vector4}
			// @description			Return the result of multiplication of either the values of this
			//						Vector4 as a Vector2 or them multiplied by the specified value or
			//						the ones of the specified Vector2 or Vector4 as a Vector4.
			static product = function()
			{
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					var _value = argument[0];
					var _product_x1, _product_y1, _product_x2, _product_y2;
					
					if (is_real(_value))
					{
						_product_x1 = (x1 * _value);
						_product_y1 = (y1 * _value);
						_product_x2 = (x2 * _value);
						_product_y2 = (y2 * _value);
					}
					else
					{
						switch (instanceof(_value))
						{
							case "Vector2":
								_product_x1 = (x1 * _value.x);
								_product_y1 = (y1 * _value.y);
								_product_x2 = (x2 * _value.x);
								_product_y2 = (y2 * _value.y);
							break;
							
							case "Vector4":
							default:
								_product_x1 = (x1 * _value.x1);
								_product_y1 = (y1 * _value.y1);
								_product_x2 = (x2 * _value.x2);
								_product_y2 = (y2 * _value.y2);
							break;
						}
					}
					
					return new Vector4(_product_x1, _product_y1, _product_x2, _product_y2);
				}
				else
				{
					var _product_x = (x1 * x2);
					var _product_y = (y1 * y2);
					
					return new Vector2(_product_x, _product_y);
				}
			}
			
			// @argument			{real|Vector2|Vector4} value?
			// @returns				{real|real[]}
			// @description			Return the result of multiplication of the x values of either
			//						this Vector4 or them multiplied by the specified value or the
			//						ones of the specified Vector2 or Vector4 as a Vector4.
			static productX = function()
			{
				if ((argument_count > 0) and (argument[0] != self))
				{
					var _value = argument[0];
					var _product_x1, _product_x2;
					
					if (is_real(_value))
					{
						_product_x1 = (x1 * _value);
						_product_x2 = (x2 * _value);
					}
					else
					{
						switch (instanceof(_value))
						{
							case "Vector2":
								_product_x1 = (x1 * _value.x);
								_product_x2 = (x2 * _value.x);
							break;
							
							case "Vector4":
							default:
								_product_x1 = (x1 * _value.x1);
								_product_x2 = (x2 * _value.x2);
							break;
						}
					}
					
					return [_product_x1, _product_x2];
				}
				else
				{
					return (x1 * x2);
				}
			}
			
			// @argument			{real|Vector2|Vector4} value?
			// @returns				{real|real[]}
			// @description			Return the result of multiplication of the y values of either
			//						this Vector4 or them multiplied by the specified value or the
			//						ones of the specified Vector2 or Vector4 as a Vector4.
			static productY = function()
			{
				if ((argument_count > 0) and (argument[0] != self))
				{
					var _value = argument[0];
					var _product_y1, _product_y2;
					
					if (is_real(_value))
					{
						_product_y1 = (y1 * _value);
						_product_y2 = (y2 * _value);
					}
					else
					{
						switch (instanceof(_value))
						{
							case "Vector2":
								_product_y1 = (y1 * _value.y);
								_product_y2 = (y2 * _value.y);
							break;
							
							case "Vector4":
							default:
								_product_y1 = (y1 * _value.y1);
								_product_y2 = (y2 * _value.y2);
							break;
						}
					}
					
					return [_product_y1, _product_y2];
				}
				else
				{
					return (y1 * y2);
				}
			}
			
			// @argument			{real|Vector2|Vector4} value
			// @returns				{Vector4}
			// @description			Return the result of division of the values of this Vector4
			//						divided by the specified value or the ones of the specified
			//						Vector2 or Vector4.
			//						Attempts of division by 0 are ignored.
			static quotient = function(_value)
			{
				var _quotient_x1 = x1;
				var _quotient_y1 = y1;
				var _quotient_x2 = x2;
				var _quotient_y2 = y2;
				
				if (is_real(_value))
				{
					if (_value != 0)
					{
						_quotient_x1 = (x1 / _value);
						_quotient_y1 = (y1 / _value);
						_quotient_x2 = (x2 / _value);
						_quotient_y2 = (y2 / _value);
					}
				}
				else
				{
					switch (instanceof(_value))
					{
						case "Vector2":
							if (_value.x != 0)
							{
								_quotient_x1 = (x1 / _value.x);
								_quotient_x2 = (x2 / _value.x);
							}
							
							if (_value.y != 0)
							{
								_quotient_y1 = (y1 / _value.y);
								_quotient_y2 = (y2 / _value.y);
							}
						break;
						
						case "Vector4":
						default:
							if (_value.x1 != 0)
							{
								_quotient_x1 = (x1 / _value.x1);
							}
							
							if (_value.y1 != 0)
							{
								_quotient_y1 = (y1 / _value.y1);
							}
							
							if (_value.x2 != 0)
							{
								_quotient_x2 = (x2 / _value.x2);
							}
							
							if (_value.y2 != 0)
							{
								_quotient_y2 = (y2 / _value.y2);
							}
						break;
					}
				}
				
				return new Vector4(_quotient_x1, _quotient_y1, _quotient_x2, _quotient_y2);
			}
			
			// @argument			{real|Vector2|Vector4} value
			// @returns				{real[]}
			// @description			Return the result of division of the x values of this Vector4
			//						divided by the specified value or values of specified Vector2 or
			//						Vector4 in an array.
			static quotientX = function(_value)
			{
				var _quotient_x1 = x1;
				var _quotient_x2 = x2;
				
				if (is_real(_value))
				{
					if (_value != 0)
					{
						_quotient_x1 = (x1 / _value);
						_quotient_x2 = (x2 / _value);
					}
				}
				else
				{
					switch (instanceof(_value))
					{
						case "Vector2":
							if (_value.x != 0)
							{
								_quotient_x1 = (x1 / _value.x);
								_quotient_x2 = (x2 / _value.x);
							}
						break;
						
						case "Vector4":
							if (_value.x1 != 0)
							{
								_quotient_x1 = (x1 / _value.x1);
							}
							
							if (_value.x2 != 0)
							{
								_quotient_x2 = (x2 / _value.x2);
							}
						break;
					}
				}
				
				return [_quotient_x1, _quotient_x2];
			}
			
			// @argument			{real|Vector2|Vector4} value
			// @returns				{real[]}
			// @description			Return the result of division of the y values of this Vector4
			//						divided by the specified value or values of specified Vector2 or
			//						Vector4 in an array.
			static quotientY = function(_value)
			{
				var _quotient_y1 = y1;
				var _quotient_y2 = y2;
				
				if (is_real(_value))
				{
					if (_value != 0)
					{
						_quotient_y1 = (y1 / _value);
						_quotient_y2 = (y2 / _value);
					}
				}
				else
				{
					switch (instanceof(_value))
					{
						case "Vector2":
							if (_value.y != 0)
							{
								_quotient_y1 = (y1 / _value.y);
								_quotient_y2 = (y2 / _value.y);
							}
						break;
						
						case "Vector4":
							if (_value.y1 != 0)
							{
								_quotient_y1 = (y1 / _value.y1);
							}
							
							if (_value.y2 != 0)
							{
								_quotient_y2 = (y2 / _value.y2);
							}
						break;
					}
				}
				
				return [_quotient_y1, _quotient_y2];
			}
			
			// @argument			{Vector2} value
			// @returns				{Vector2}
			// @description			Return the point at specified respective precentages within the
			//						x and y values.
			static interpolate = function(_value)
			{
				return new Vector2(lerp(x1, x2, _value.x), lerp(y1, y2, _value.y));
			}
			
			// @argument			{real} value
			// @returns				{real}
			// @description			Return the point at specified precentage within the x values.
			static interpolateX = function(_value)
			{
				return lerp(x1, x2, _value);
			}
			
			// @argument			{real} value
			// @returns				{real}
			// @description			Return the point at specified precentage within the y values.
			static interpolateY = function(_value)
			{
				return lerp(y1, y2, _value);
			}
			
			// @returns				{Vector2[]}
			// @description			Return an array of two Vector2 with the values of this Vector4.
			static split = function()
			{
				return [Vector2(x1, y1), Vector2(x2, y2)];
			}
			
			// @returns				{real}
			// @description			Return the direction from the first point towards the second.
			static getAngle1to2 = function()
			{
				return point_direction(x1, y1, x2, y2);
			}
			
			// @returns				{real}
			// @description			Return the direction from the second point towards the first.
			static getAngle2to1 = function()
			{
				return point_direction(x2, y2, x1, y1);
			}
			
			// @returns				{real}
			// @description			Return the shortest distance between two points.
			static getDistance = function()
			{
				return point_distance(x1, y1, x2, y2);
			}
			
			// @returns				{real}
			// @description			Return the lowest of all values.
			static getMinimum = function()
			{
				return min(x1, y1, x2, y2);
			}
			
			// @returns				{real}
			// @description			Return the highest of all values.
			static getMaximum = function()
			{
				return max(x1, y1, x2, y2);
			}
			
			// @returns				{Vector2}
			// @description			Return the middle point of this Vector4.
			static getMiddle = function()
			{
				return new Vector2(lerp(x1, x2, 0.5), lerp(y1, y2, 0.5));
			}
			
			// @returns				{real}
			// @description			Return the middle point between the x values of this Vector4.
			static getMiddleX = function()
			{
				return lerp(x1, x2, 0.5);
			}
			
			// @returns				{real}
			// @description			Return the middle point between the y values of this Vector4.
			static getMiddleY = function()
			{
				return lerp(y1, y2, 0.5);
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
		#region <Setters>
			
			// @argument			{real|Vector2|Vector4} value
			// @description			Add to the values of this Vector4 the specified value or the
			//						values of other specified Vector4 or Vector2.
			static add = function(_value)
			{
				if (instanceof(_value) == "Vector4")
				{
					x1 += _value.x1;
					y1 += _value.y1;
					x2 += _value.x2;
					y2 += _value.y2;
				}
				else if (instanceof(_value) == "Vector2")
				{
					x1 += _value.x;
					y1 += _value.y;
					x2 += _value.x;
					y2 += _value.y;
				}
				else
				{
					x1 += _value;
					y1 += _value;
					x2 += _value;
					y2 += _value;
				}
			}
			
			// @argument			{real|Vector2|Vector4} value
			// @description			Substract from the values of this Vector4 the specified value or 
			//						the values of other specified Vector4 or Vector2.
			static substract = function(_value)
			{
				if (instanceof(_value) == "Vector4")
				{
					x1 -= _value.x1;
					y1 -= _value.y1;
					x2 -= _value.x2;
					y2 -= _value.y2;
				}
				else if (instanceof(argument[0]) == "Vector2")
				{
					var _other = argument[0];
					
					x1 -= _value.x;
					y1 -= _value.y;
					x2 -= _value.x;
					y2 -= _value.y;
				}
				else
				{
					x1 -= _value;
					y1 -= _value;
					x2 -= _value;
					y2 -= _value;
				}
			}
			
			// @argument			{real|Vector2|Vector4} value
			// @description			Multiply the values of this Vector4 the specified value or the 
			//						values of other specified Vector4 or Vector2.
			static multiply = function(_value)
			{
				if (instanceof(_value) == "Vector4")
				{
					x1 *= _value.x1;
					y1 *= _value.y1;
					x2 *= _value.x2;
					y2 *= _value.y2;
				}
				else if (instanceof(_value) == "Vector2")
				{
					x1 *= _value.x;
					y1 *= _value.y;
					x2 *= _value.x;
					y2 *= _value.y;
				}
				else
				{
					x1 *= _value;
					y1 *= _value;
					x2 *= _value;
					y2 *= _value;
				}
			}
			
			// @argument			{real|Vector2|Vector4} value
			// @description			Divide the values of this Vector4 the specified value or the 
			//						values of other specified Vector4 or Vector2.
			//						Attempts of division by 0 are ignored.
			static divide = function(_value)
			{
				if (instanceof(_value) == "Vector4")
				{
					if (_value.x1 != 0)
					{
						x1 /= _value.x1;
					}
					
					if (_value.y1 != 0)
					{
						y1 /= _value.y1;
					}
					
					if (_value.x2 != 0)
					{
						x2 /= _value.x2;
					}
					
					if (_value.y2 != 0)
					{
						y2 /= _value.y2;
					}
				}
				else if (instanceof(_value) == "Vector2")
				{
					if (_value.x != 0)
					{
						x1 /= _value.x;
					}
					
					if (_value.y != 0)
					{
						y1 /= _value.y;
					}
					
					if (_value.x != 0)
					{
						x2 /= _value.x;
					}
					
					if (_value.y != 0)
					{
						y2 /= _value.y;
					}
				}
				else
				{
					if (_value != 0)
					{
						x1 /= _value;
						y1 /= _value;
						x2 /= _value;
						y2 /= _value;
					}
				}
			}
			
			// @argument			{Vector4} target
			// @argument			{Vector4} rate
			// @description			Move the x and y values towards the specified target with the
			//						specified rate without exceeding it.
			static approach = function(_target, _rate)
			{
				var _value_array = [x1, y1, x2, y2];
				var _target_array = [_target.x1, _target.y1, _target.x2, _target.y2];
				var _rate_array = [abs(_rate.x1), abs(_rate.y1), abs(_rate.x2), abs(_rate.y2)];
				
				var _i = 0;
				repeat (array_length(_value_array))
				{
					if (_value_array[_i] > _target_array[_i])
					{
						_value_array[_i] -= _rate_array[_i];
						
						if (_value_array[_i] < _target_array[_i])
						{
							_value_array[_i] = _target_array[_i];
						}
					}
					else if (_value_array[_i] < _target_array[_i])
					{
						_value_array[_i] += _rate_array[_i];
						
						if (_value_array[_i] > _target_array[_i])
						{
							_value_array[_i] = _target_array[_i];
						}
					}
					
					++_i;
				}
				
				x1 = _value_array[0];
				y1 = _value_array[1];
				x2 = _value_array[2];
				y2 = _value_array[3];
			}
			
			// @description			Swap the x and y values.
			static flip = function()
			{
				var _x1 = x1;
				var _y1 = y1;
				var _x2 = x2;
				var _y2 = y2;
				
				x1 = _y1;
				y1 = _x1;
				x2 = _y2;
				y2 = _x2;
			}
			
			// @argument			{real} value
			// @description			Set all of the values to one specified value.
			static set = function(_value)
			{
				x1 = _value;
				y1 = _value;
				x2 = _value;
				y2 = _value;
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the output of X and then Y
			//						values of this Vector4.
			static toString = function(_multiline = false)
			{
				if (self.isFunctional())
				{
					var _mark_separator = ((_multiline) ? "\n" : ", ");
					
					var _string = ("x1: " + string(x1) + _mark_separator +
								   "y1: " + string(y1) + _mark_separator +
								   "x2: " + string(x2) + _mark_separator +
								   "y2: " + string(y2));
					
					return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
				}
				else
				{
					return (instanceof(self) + "<>");
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
