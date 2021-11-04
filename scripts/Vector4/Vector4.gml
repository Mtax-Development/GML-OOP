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
///							- Vector2 pair: {Vector2} first, {Vector2} second
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
									//|Construction type: Vector2 pair.
									var _first = argument[0];
									var _second = argument[1];
									
									x1 = _first.x;
									y1 = _first.y;
									x2 = _second.x;
									y2 = _second.y;
								}
								else
								{
									//|Construction type: Number pair.
									var _first = argument[0];
									var _second = argument[1];
									
									x1 = _first;
									y1 = _first;
									x2 = _second;
									y2 = _second;
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
				
				return self;
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
			
			// @argument			{real|Vector2|Vector4} other
			// @returns				{bool}
			// @description			Check if the respective values are equal to the specified value.
			static equals = function(_value)
			{
				if (is_real(_value))
				{
					return ((x1 == _value) and (y1 == _value) and (x2 == _value) and (y2 == _value));
				}
				else if (instanceof(_value) == "Vector2")
				{
					return ((x1 == _value.x) and (y1 == _value.y) and (x2 == _value.x)
							and (y2 == _value.y));
				}
				else
				{
					return ((x1 == _value.x1) and (y1 == _value.y1) and (x2 == _value.x2)
							and (y2 == _value.y2));
				}
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
			// @returns				{Vector2|Vector4}
			// @description			Return the point at specified respective precentages within the
			//						x and y values.
			static interpolate = function(_value)
			{
				switch (instanceof(_value))
				{
					case "Vector2":
						return new Vector2(lerp(x1, x2, _value.x), lerp(y1, y2, _value.y));
					break;
					
					case "Vector4":
						return new Vector4(lerp(x1, x2, _value.x1), lerp(y1, y2, _value.y1),
										   lerp(x1, x2, _value.x2), lerp(y1, y2, _value.y2));
					break;
					
					default:
						return new Vector2(lerp(x1, x2, _value), lerp(y1, y2, _value));
					break;
				}
			}
			
			// @argument			{real|Vector2} value
			// @returns				{Vector2}
			// @description			Return the percentage value representing the specified value
			//						inside of the boundaries made by the values of this Vector4 as a
			//						numerical value in which one whole number is one full percentage.
			static percent = function(_value)
			{
				var _result_x, _result_y;
				
				switch (instanceof(_value))
				{
					case "Vector2":
						_result_x = ((_value.x - x1) / (x2 - x1));
						_result_y = ((_value.y - y1) / (y2 - y1));
					break;
					
					default:
						_result_x = ((_value - x1) / (x2 - x1));
						_result_y = ((_value - y1) / (y2 - y1));
					break;
				}
				
				return new Vector2((is_nan(_result_x) ? 1 : _result_x),
								   (is_nan(_result_y) ? 1 : _result_y));
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
			// @description			Return the length of this Vector.
			static getMagnitude = function()
			{
				return sqrt((x1 * x1) + (y1 * y1) + (x2 * x2) + (y2 * y2));
			}
			
			// @argument			{real} magnitude?
			// @description			Return the unit Vector of this Vector2, which will have its values
			//						put into a range of -1 to 1, but with the same direction. These
			//						values can be then multiplied by the specified magnitude.
			static getNormalized = function(_magnitude = 1)
			{
				var _length = sqrt((x1 * x1) + (y1 * y1) + (x2 * x2) + (y2 * y2));
				
				var _x1 = x1;
				var _y1 = y1;
				var _x2 = x2;
				var _y2 = y2;
				
				if (_length != 0)
				{
					_x1 = ((x1 / _length) * _magnitude);
					_y1 = ((y1 / _length) * _magnitude);
					_x2 = ((x2 / _length) * _magnitude);
					_y2 = ((y2 / _length) * _magnitude);
				}
				
				return new Vector4(_x1, _y1, _x2, _y2);
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
				
				return self;
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
				
				return self;
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
				
				return self;
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
				
				return self;
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
				
				return self;
			}
			
			// @argument			{Vector4} boundary
			// @description			Restrict the values of this Vector4 to the boundaries of other
			//						specified Vector4.
			static clampTo = function(_boundary)
			{
				var _minimum_x = min(_boundary.x1, _boundary.x2);
				var _maximum_x = max(_boundary.x1, _boundary.x2);
				var _minimum_y = min(_boundary.y1, _boundary.y2);
				var _maximum_y = max(_boundary.y1, _boundary.y2);
				
				x1 = clamp(x1, _minimum_x, _maximum_x);
				y1 = clamp(y1, _minimum_y, _maximum_y);
				x2 = clamp(x2, _minimum_x, _maximum_x);
				y2 = clamp(y2, _minimum_y, _maximum_y);
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
				
				return self;
			}
			
			// @description			Reverse the x and y values.
			static mirror = function()
			{
				x1 = (-x1);
				y1 = (-y1);
				x2 = (-x2);
				y2 = (-y2);
				
				return self;
			}
			
			// @description			Reverse the x values.
			static mirrorX = function()
			{
				x1 = (-x1);
				x2 = (-x2);
				
				return self;
			}
			
			// @description			Reverse the y values.
			static mirrorY = function()
			{
				y1 = (-y1);
				y2 = (-y2);
				
				return self;
			}
			
			// @argument			{real} value
			// @description			Set all of the values to one specified value.
			static set = function(_value)
			{
				x1 = _value;
				y1 = _value;
				x2 = _value;
				y2 = _value;
				
				return self;
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
			
			// @returns				{Vector2[]}
			// @description			Return an array of two Vector2 with the values of this Vector4.
			static split = function()
			{
				return [new Vector2(x1, y1), new Vector2(x2, y2)];
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
