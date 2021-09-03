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
				//|Construction type: Empty
				x = undefined;
				y = undefined;
				
				if ((argument_count > 0) and (argument[0] != undefined))
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
								
								case 2:
								default:
									//|Construction type: Two numbers.
									x = argument[0];
									y = argument[1];
								break;
							}
						break;
					}
				}
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
			
			// @argument			{Vector2} other
			// @returns				{bool}
			// @description			Check if the values of this Vector2 are equal to the values of
			//						specified other one.
			static equals = function(_other)
			{
				return ((x == _other.x) and (y == _other.y));
			}
			
			// @argument			{Vector2} other?
			// @returns				{real|Vector2}
			// @description			Return the sum of either the values of this Vector2 as a number or
			//						if other one is specified, between the x and y values of each in a
			//						Vector2.
			static sum = function()
			{
				if ((argument_count > 0) and (argument[0] != self))
				{
					var _other = argument[0];
					var _sum_x = (x + _other.x);
					var _sum_y = (y + _other.y);
					
					return new Vector2(_sum_x, _sum_y);
				}
				else
				{
					return (x + y);
				}
			}
			
			// @argument			{Vector2} other
			// @returns				{real}
			// @description			Return the sum of the x values of this and other Vector2.
			static sumX = function(_other)
			{
				return (x + _other.x);
			}
			
			// @argument			{Vector2} other
			// @returns				{real}
			// @description			Return the sum of the x values of this and other Vector2.
			static sumY = function(_other)
			{
				return (y + _other.y);
			}
			
			// @argument			{Vector2} other?
			// @returns				{real|Vector2}
			// @description			Return the difference between either the values of this Vector2 as
			//						a number or if other one is specified, between the x and y values
			//						of each in a Vector2.
			static difference = function()
			{
				if ((argument_count > 0) and (argument[0] != self))
				{
					var _other = argument[0];
					
					var _difference_x = abs(x - _other.x);
					var _difference_y = abs(y - _other.y);
					
					return new Vector2(_difference_x, _difference_y);
				}
				else
				{
					return abs(x - y);
				}
			}
			
			// @argument			{Vector2} other
			// @returns				{real}
			// @description			Return the difference between the x values of this and other
			//						Vector2.
			static differenceX = function(_other)
			{
				return abs(x - _other.x);
			}
			
			// @argument			{Vector2} other
			// @returns				{real}
			// @description			Return the difference between the y values of this and other
			//						Vector2.
			static differenceY = function(_other)
			{
				return abs(y - _other.y);
			}
			
			// @argument			{Vector2} other?
			// @returns				{real|Vector2}
			// @description			Return the result of multiplication of either the values of this
			//						Vector2 as a number or if other one is specified, the x and y
			//						values of each in a Vector2.
			static product = function()
			{
				if ((argument_count > 0) and (argument[0] != self))
				{
					var _other = argument[0];
					
					var _product_x = (x * _other.x);
					var _product_y = (y * _other.y);
					
					return new Vector2(_product_x, _product_y);
				}
				else
				{
					return (x * y);
				}
			}
			
			// @argument			{Vector2} other
			// @returns				{real}
			// @description			Return the result of multiplication of the x values of this and
			//						other Vector2.
			static productX = function(_other)
			{
				return (x * _other.x);
			}
			
			// @argument			{Vector2} other
			// @returns				{real}
			// @description			Return the result of multiplication of the y values of this and
			//						other Vector2.
			static productY = function(_other)
			{
				return (y * _other.y);
			}
			
			// @argument			{Vector2} other
			// @returns				{Vector2}
			// @description			Return the result of the division of the values of this Vector2
			//						divided by the values of other one.
			static quotient = function(_other)
			{
				var _quotient_x = (x / _other.x);
				var _quotient_y = (y / _other.y);
				
				return new Vector2(_quotient_x, _quotient_y);
			}
			
			// @argument			{Vector2} other
			// @returns				{real}
			// @description			Return the result of division of the x value of this Vector2
			//						divided by the values of other one.
			static quotientX = function(_other)
			{
				return (x / _other.x);
			}
			
			// @argument			{Vector2} other
			// @returns				{real}
			// @description			Return the result of division of the y value of this Vector2
			//						divided by the values of other one.
			static quotientY = function(_other)
			{
				return (y / _other.y);
			}
			
			// @returns				{real}
			// @description			Return the lowest of all values.
			static getMinimum = function()
			{
				return min(x, y);
			}
			
			// @returns				{real}
			// @description			Return the highest of all values.
			static getMaximum = function()
			{
				return max(x, y);
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{real|Vector2} value
			// @description			Add to the values of this Vector2 the specified value or the
			//						values of other specified Vector2.
			static add = function()
			{
				if (instanceof(argument[0]) == "Vector2")
				{
					var _other = argument[0];
					
					x += _other.x;
					y += _other.y;
				}
				else
				{
					var _value = argument[0];
					
					x += _value;
					y += _value;
				}
			}
			
			// @argument			{real|Vector2} value
			// @description			Substract the values of this Vector2 the specified value or the
			//						values of other specified Vector2.
			static substract = function()
			{
				if (instanceof(argument[0]) == "Vector2")
				{
					var _other = argument[0];
					
					x -= _other.x;
					y -= _other.y;
				}
				else
				{
					var _value = argument[0];
					
					x -= _value;
					y -= _value;
				}
			}
			
			// @argument			{real|Vector2} value
			// @description			Multiply the values of this Vector2 by specified value or the
			//						values of other specified Vector2.
			static multiply = function()
			{
				if (instanceof(argument[0]) == "Vector2")
				{
					var _other = argument[0];
					
					x *= _other.x;
					y *= _other.y;
				}
				else
				{
					var _value = argument[0];
					
					x *= _value;
					y *= _value;
				}
			}
			
			// @argument			{real|Vector2} value
			// @description			Divide the values of this Vector2 by specified value or the
			//						values of other specified Vector2.
			//						Attempts of division by 0 are ignored.
			static divide = function()
			{
				if (instanceof(argument[0]) == "Vector2")
				{
					var _other = argument[0];
					
					if (_other.x != 0)
					{
						x /= _other.x;
					}
					
					if (_other.y != 0)
					{
						y /= _other.y;
					}
				}
				else
				{
					var _value = argument[0];
					
					if (_value != 0)
					{
						x /= _value;
						y /= _value;
					}
				}
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
			}
			
			// @description			Swap the x and y values of this Vector2 with each other.
			static flip = function()
			{
				var _x = x;
				var _y = y;
				
				x = _y;
				y = _x;
			}
			
			// @description			Reverse the x and y values.
			static mirror = function()
			{
				x = -x;
				y = -y;
			}
			
			// @description			Reverse the x value.
			static mirrorX = function()
			{
				x = -x;
			}
			
			// @description			Reverse the y value.
			static mirrorY = function()
			{
				y = -y;
			}
			
			// @argument			{real} value
			// @description			Set all of the values to one specified value.
			static set = function(_value)
			{
				x = _value;
				y = _value;
			}
			
			// @argument			{int} device?
			// @description			Set all of the values to the ones of the cursor.
			static setCursor = function(_device)
			{
				if (_device == undefined)
				{
					x = mouse_x;
					y = mouse_y;
				}
				else
				{
					x = device_mouse_x(_device);
					y = device_mouse_y(_device);
				}
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
