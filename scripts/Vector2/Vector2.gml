/// @function				Vector2()
/// @argument				{real} x?
/// @argument				{real} y?
///							
/// @description			Construct a Vector container for x and y coordinate pair.
///							
///							Construction types:
///							- Two numbers: {real} x, {real} y
///							- One number for all values: {real} value
///							- From array: {real[]} array
///							   Array positions will be applied depending on its size:
///							   1: array[0] will be set to x and y.
///							   2+: array[0] will be set to x, array[1] will be set to y.
///							- From Scale: {Scale} scale
///							- Empty: {void|undefined}
///							- Constructor copy: {Vector2} other
function Vector2() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				x = undefined;
				y = undefined;
				
				if (argument_count > 0)
				{
					switch (instanceof(argument[0]))
					{
						case "Vector2":
							//|Construction type: Constructor copy.
							var _other = argument[0];
							
							x = _other.x;
							y = _other.y;
						break;
						
						case "Scale":
							//|Construction type: From Scale.
							var _scale = argument[0];
							
							x = _scale.x;
							y = _scale.y;
						break;
						
						default:
							switch (argument_count)
							{
								case 1:
									if (is_array(argument[0]))
									{
										//|Construction type: From array.
										var _array = argument[0];
										
										switch (array_length(_array))
										{
											case 1:
												x = _array[0];
												y = _array[0];
											break;
											
											case 2:
											default:
												x = _array[0];
												y = _array[1];
											break;
										}
									}
									else
									{
										//|Construction type: One number for all values.
										x = argument[0];
										y = argument[0];
									}
								break;
								
								default:
									//|Construction type: Two numbers.
									x = argument[0];
									y = argument[1];
								break;
							}
						break;
					}
				}
				
				return self;
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(x)) and (is_real(y)) and (!is_nan(x)) and (!is_nan(y))
						and (!is_infinity(x)) and (!is_infinity(y)));
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{any} value...
			// @returns				{bool}
			// @description			Check if this Vector2 contains at least one of the specified
			//						values.
			static contains = function()
			{
				var _i = 0;
				repeat (argument_count)
				{
					var _value = argument[_i];
					
					if ((x == _value) or (y == _value))
					{
						return true;
					}
					
					++_i;
				}
				
				return false;
			}
			
			// @argument			{real|Vector2} value
			// @returns				{bool}
			// @description			Check if the respective values are equal to the specified value.
			static equals = function(_value)
			{
				if (is_real(_value))
				{
					return ((x == _value) and (y == _value));
				}
				else
				{
					return ((x == _value.x) and (y == _value.y));
				}
			}
			
			// @argument			{real|Vector2} value?
			// @returns				{real|Vector2}
			// @description			Return the sum of either the values of this Vector2 or them added
			//						to the specified value or the ones of the specified Vector2.
			static sum = function()
			{
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					var _value = argument[0];
					var _sum_x, _sum_y;
					
					if (is_real(_value))
					{
						_sum_x = (x + _value);
						_sum_y = (y + _value);
					}
					else
					{
						_sum_x = (x + _value.x);
						_sum_y = (y + _value.y);
					}
					
					return new Vector2(_sum_x, _sum_y);
				}
				else
				{
					return (x + y);
				}
			}
			
			// @argument			{real|Vector2} value?
			// @returns				{real|Vector2}
			// @description			Return the difference between either the values of this Vector2 or
			//						them and the specified value or the ones of the specified Vector2.
			static difference = function()
			{
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					var _value = argument[0];
					var _difference_x, _difference_y;
					
					if (is_real(_value))
					{
						_difference_x = abs(x - _value);
						_difference_y = abs(y - _value);
					}
					else
					{
						_difference_x = abs(x - _value.x);
						_difference_y = abs(y - _value.y);
					}
					
					return new Vector2(_difference_x, _difference_y);
				}
				else
				{
					return abs(x - y);
				}
			}
			
			// @argument			{real|Vector2} value?
			// @returns				{real|Vector2}
			// @description			Return the result of multiplication of either the values of this
			//						Vector2 or them multiplied by the specified value or the ones of
			//						the specified Vector2.
			static product = function()
			{
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					var _value = argument[0];
					var _product_x, _product_y;
					
					if (is_real(_value))
					{
						_product_x = (x * _value);
						_product_y = (y * _value);
					}
					else
					{
						_product_x = (x * _value.x);
						_product_y = (y * _value.y);
					}
					
					return new Vector2(_product_x, _product_y);
				}
				else
				{
					return (x * y);
				}
			}
			
			// @argument			{real|Vector2} value
			// @returns				{Vector2}
			// @description			Return the result of division of the values of this Vector2
			//						divided by the specified value or the ones of the specified
			//						Vector2.
			//						Attempts of division by 0 are ignored.
			static quotient = function(_value)
			{
				var _quotient_x = x;
				var _quotient_y = y;
				
				if (is_real(_value))
				{
					if (_value != 0)
					{
						_quotient_x = (x / _value);
						_quotient_y = (y / _value);
					}
				}
				else
				{
					if (_value.x != 0)
					{
						_quotient_x = (x / _value.x);
					}
					
					if (_value.y != 0)
					{
						_quotient_y = (y / _value.y);
					}
				}
				
				return new Vector2(_quotient_x, _quotient_y);
			}
			
			// @argument			{Vector2} other
			// @argument			{bool} normalize?
			// @returns				{real}
			// @description			Return the sum of each value of this and other Vector2 being
			//						multiplied by their respective other value, which is an expression
			//						of the angular reliationship between its two points. The returned
			//						value can be normalized, which will place it between -1 and 1.
			static dotProduct = function(_other, _normalize = false)
			{
				return ((_normalize) ? dot_product_normalized(x, y, _other.x, _other.y)
									 : dot_product(x, y, _other.x, _other.y));
			}
			
			// @argument			{Vector2} target
			// @returns				{Angle}
			// @description			Return the Angle from this Vector2 towards the specified one.
			static getAngle = function(_target)
			{
				return new Angle(point_direction(x, y, _target.x, _target.y));
			}
			
			// @argument			{Vector2} other
			// @returns				{real}
			// @description			Return the shortest distance between this and the specified
			//						Vector2.
			static getDistance = function(_other)
			{
				return point_distance(x, y, _other.x, _other.y);
			}
			
			// @returns				{real}
			// @description			Return the lowest of both values.
			static getMinimum = function()
			{
				return min(x, y);
			}
			
			// @returns				{real}
			// @description			Return the highest of both values.
			static getMaximum = function()
			{
				return max(x, y);
			}
			
			// @returns				{real}
			// @description			Return the vector length.
			static getMagnitude = function()
			{
				return sqrt((x * x) + (y * y));
			}
			
			// @argument			{real} magnitude?
			// @returns				{Vector2}
			// @description			Return the unit vector of this Vector2, which will have its
			//						values placed between -1 and 1, but with the same direction.
			//						These values are then multiplied by the specified magnitude.
			static getNormalized = function(_magnitude = 1)
			{
				var _length = sqrt((x * x) + (y * y));
				
				var _x = x;
				var _y = y;
				
				if (_length != 0)
				{
					_x = ((x / _length) * _magnitude);
					_y = ((y / _length) * _magnitude);
				}
				
				return new Vector2(_x, _y);
			}
			
			// @argument			{bool} booleanSign?
			// @returns				{Vector2}
			// @description			Return a Vector2 with each respective value representing the sign
			//						of the number: -1 for a negative number, 0 for itself and 1 for a
			//						positive number. If the result is specified to be returned as the
			//						boolean sign, -1 will be set for 0 as well.
			static getSign = function(_booleanSign = false)
			{
				if (_booleanSign)
				{
					return new Vector2(((x > 0) ? 1 : -1), ((y > 0) ? 1 : -1));
				}
				else
				{
					return new Vector2(sign(x), sign(y));
				}
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{real|Vector2} value
			// @description			Add to the values of this Vector2 the specified value or the
			//						values of other specified Vector2.
			static add = function(_value)
			{
				if (instanceof(_value) == "Vector2")
				{
					x += _value.x;
					y += _value.y;
				}
				else
				{
					x += _value;
					y += _value;
				}
				
				return self;
			}
			
			// @argument			{real|Vector2} value
			// @description			Substract the values of this Vector2 the specified value or the
			//						values of other specified Vector2.
			static substract = function(_value)
			{
				if (instanceof(argument[0]) == "Vector2")
				{
					x -= _value.x;
					y -= _value.y;
				}
				else
				{
					x -= _value;
					y -= _value;
				}
				
				return self;
			}
			
			// @argument			{real|Vector2} value
			// @description			Multiply the values of this Vector2 by specified value or the
			//						values of other specified Vector2.
			static multiply = function(_value)
			{
				if (instanceof(_value) == "Vector2")
				{
					x *= _value.x;
					y *= _value.y;
				}
				else
				{
					x *= _value;
					y *= _value;
				}
				
				return self;
			}
			
			// @argument			{real|Vector2} value
			// @description			Divide the values of this Vector2 by specified value or the
			//						values of other specified Vector2.
			//						Attempts of division by 0 are ignored.
			static divide = function(_value)
			{
				if (instanceof(_value) == "Vector2")
				{
					if (_value.x != 0)
					{
						x /= _value.x;
					}
					
					if (_value.y != 0)
					{
						y /= _value.y;
					}
				}
				else
				{
					if (_value != 0)
					{
						x /= _value;
						y /= _value;
					}
				}
				
				return self;
			}
			
			// @argument			{Vector2} target
			// @argument			{Vector2} rate
			// @description			Move the x and y values towards the specified target with the
			//						specified rate without exceeding it.
			static approach = function(_target, _rate)
			{
				var _value_array = [x, y];
				var _target_array = [_target.x, _target.y];
				var _rate_array = [abs(_rate.x), abs(_rate.y)];
				
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
				
				x = _value_array[0];
				y = _value_array[1];
				
				return self;
			}
			
			// @argument			{real|Vector2} value
			// @description			Perform a calculation with the specified value by adding to its
			//						respective values with the same sign as the values of this
			//						Vector2.
			static grow = function(_value)
			{
				if (is_real(_value))
				{
					x += (abs(_value) * sign(x));
					y += (abs(_value) * sign(y));
				}
				else
				{
					x += (abs(_value.x) * sign(x));
					y += (abs(_value.y) * sign(y));
				}
				
				return self;
			}
			
			// @argument			{real|Vector2} value
			// @description			Perform a calculation with the specified value by substracting it
			//						from its respective values with the same sign as the values of
			//						this Vector2.
			static shrink = function(_value)
			{
				if (is_real(_value))
				{
					x -= (abs(_value) * sign(x));
					y -= (abs(_value) * sign(y));
				}
				else
				{
					x -= (abs(_value.x) * sign(x));
					y -= (abs(_value.y) * sign(y));
				}
				
				return self;
			}
			
			// @argument			{Vector4} boundary
			// @description			Restrict the values of this Vector2 to the boundaries of the
			//						specified Vector4.
			static clampTo = function(_boundary)
			{
				x = clamp(x, min(_boundary.x1, _boundary.x2), max(_boundary.x1, _boundary.x2));
				y = clamp(y, min(_boundary.y1, _boundary.y2), max(_boundary.y1, _boundary.y2));
			}
			
			// @description			Swap the x and y values of this Vector2 with each other.
			static flip = function()
			{
				var _x = x;
				var _y = y;
				
				x = _y;
				y = _x;
				
				return self;
			}
			
			// @description			Reverse the x and y values.
			static mirror = function()
			{
				x = (-x);
				y = (-y);
				
				return self;
			}
			
			// @argument			{real|Vector2|Scale} value
			// @description			Set all of the values to one specified value.
			static set = function(_value)
			{
				if (is_real(_value))
				{
					x = _value;
					y = _value;
				}
				else
				{
					x = _value.x;
					y = _value.y;
				}
				
				return self;
			}
			
			// @argument			{real|Vector2|Scale} value?
			// @description			Set all of the values of to their equivalents rounded down or the
			//						ones of the specified value.
			static setFloor = function(_value)
			{
				if (_value == undefined)
				{
					x = floor(x);
					y = floor(y);
				}
				else if (is_real(_value))
				{
					var _value_floor = floor(_value);
					
					x = _value_floor;
					y = _value_floor;
				}
				else
				{
					x = floor(_value.x);
					y = floor(_value.y);
				}
				
				return self;
			}
			
			// @argument			{real|Vector2|Scale} value?
			// @description			Set all of the values of to their equivalents rounded down or up
			//						or the ones of the specified value.
			static setRound = function(_value)
			{
				if (_value == undefined)
				{
					x = round(x);
					y = round(y);
				}
				else if (is_real(_value))
				{
					var _value_round = round(_value);
					
					x = _value_round;
					y = _value_round;
				}
				else
				{
					x = round(_value.x);
					y = round(_value.y);
				}
				
				return self;
			}
			
			// @argument			{real|Vector2|Scale} value?
			// @description			Set all of the values of to their equivalents rounded up or the
			//						ones of the specified value.
			static setCeil = function(_value)
			{
				if (_value == undefined)
				{
					x = ceil(x);
					y = ceil(y);
				}
				else if (is_real(_value))
				{
					var _value_ceil = ceil(_value);
					
					x = _value_ceil;
					y = _value_ceil;
				}
				else
				{
					x = ceil(_value.x);
					y = ceil(_value.y);
				}
				
				return self;
			}
			
			// @argument			{int} device?
			// @description			Set all of the values to the ones of the cursor.
			static setCursor = function(_device)
			{
				if (is_real(_device))
				{
					x = device_mouse_x(_device);
					y = device_mouse_y(_device);
				}
				else
				{
					x = mouse_x;
					y = mouse_y;
				}
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the values of this Container.
			static toString = function(_multiline = false)
			{
				var _mark_separator = ((_multiline) ? "\n" : ", ");
				var _string = ("x: " + string(x) + _mark_separator + "y: " + string(y));
				
				return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
			}
			
			// @returns				{real[]}
			// @description			Return an array containing all values of this Container.
			static toArray = function()
			{
				return [x, y];
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

