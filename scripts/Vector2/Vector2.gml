//  @function				Vector2()
/// @argument				x? {real}
/// @argument				y? {real}
///							
/// @description			Construct a Vector container for x and y coordinate pair.
///							
//							Construction types:
//							- Two numbers: x {real}, y {real}
//							- One number for all values: {real} value
//							- From array: array {real[]}
//							   Array positions will be applied depending on its size:
//							   1: array[0] will be set to x and y.
//							   2+: array[0] will be set to x, array[1] will be set to y.
//							- From Scale: scale {Scale}
//							- Empty: {void|undefined}
//							- Constructor copy: other {Vector2}
function Vector2() constructor
/// @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize the constructor.
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
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(x)) and (is_real(y)) and (!is_nan(x)) and (!is_nan(y))
						and (!is_infinity(x)) and (!is_infinity(y)));
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			value... {any}
			/// @returns			{bool}
			/// @description		Check if this Vector2 contains at least one of the specified
			///						values.
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
			
			/// @argument			value {real|Vector2}
			/// @returns			{bool}
			/// @description		Check if the respective values are equal to the specified value.
			static equals = function(_value)
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "equals()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			value? {real|Vector2}
			/// @returns			{real|Vector2} | On error: {undefined}
			/// @description		Return the sum of either the values of this Vector2 or them added
			///						to the specified value or the ones of the specified Vector2.
			static sum = function()
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "sum()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			value? {real|Vector2}
			/// @returns			{real|Vector2} | On error: {undefined}
			/// @description		Return the difference between either the values of this Vector2 or
			///						them and the specified value or the ones of the specified Vector2.
			static difference = function()
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "difference()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			value? {real|Vector2}
			/// @returns			{real|Vector2} | On error: {undefined}
			/// @description		Return the result of multiplication of either the values of this
			///						Vector2 or them multiplied by the specified value or the ones of
			///						the specified Vector2.
			static product = function()
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "product()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			value {real|Vector2}
			/// @returns			{Vector2} | On error: {undefined}
			/// @description		Return the result of division of the values of this Vector2
			///						divided by the specified value or the ones of the specified
			///						Vector2. Attempts of division by 0 are ignored.
			static quotient = function(_value)
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "product()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			other {Vector2}
			/// @argument			normalize? {bool}
			/// @returns			{real} | On error: {undefined}
			/// @description		Return the sum of each value of this and other Vector2 being
			///						multiplied by their respective other value, which is an expression
			///						of the angular reliationship between its two points. The returned
			///						value can be normalized, which will place it between -1 and 1.
			static dotProduct = function(_other, _normalize = false)
			{
				try
				{
					return ((_normalize) ? dot_product_normalized(x, y, _other.x, _other.y)
										 : dot_product(x, y, _other.x, _other.y));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "dotProduct()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			target {Vector2}
			/// @returns			{Angle} | On error: {undefined}
			/// @description		Return the Angle from this Vector2 towards the specified one.
			static getAngle = function(_target)
			{
				try
				{
					return new Angle(point_direction(x, y, _target.x, _target.y));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getAngle()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			other {Vector2}
			/// @returns			{real}
			/// @description		Return the shortest distance between this and the specified
			///						Vector2.
			static getDistance = function(_other)
			{
				try
				{
					return point_distance(x, y, _other.x, _other.y);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getDistance()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{real} | On error: {undefined}
			/// @description		sReturn the lowest of both values.
			static getMinimum = function()
			{
				try
				{
					return min(x, y);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getMinimum()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{real} | On error: {undefined}
			/// @description		Return the highest of both values.
			static getMaximum = function()
			{
				try
				{
					return max(x, y);
				}
				catch (_exception)
				{
					new ErrorRepogrt().report([other, self, "getMaximum()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{real} | On error: {undefined}
			/// @description		Return the vector length.
			static getMagnitude = function()
			{
				try
				{
					return sqrt((x * x) + (y * y));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getMagnitude()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			magnitude? {real}
			/// @returns			{Vector2} | On error: {undefined}
			/// @description		Return the unit vector of this Vector2, which will have its
			///						values placed between -1 and 1, but with the same direction.
			///						These values are then multiplied by the specified magnitude.
			static getNormalized = function(_magnitude = 1)
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getNormalized()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			booleanSign? {bool}
			/// @returns			{Vector2} | On error: {undefined}
			/// @description		Return a Vector2 with each respective value representing the sign
			///						of the number: -1 for a negative number, 0 for itself and 1 for a
			///						positive number. If the result is specified to be returned as the
			///						boolean sign, -1 will be set for 0 as well.
			static getSign = function(_booleanSign = false)
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getSign()"], _exception);
				}
				
				return undefined;
			}
			
		#endregion
		#region <Setters>
			
			/// @argument			value {real|Vector2}
			/// @description		Add to the values of this Vector2 the specified value or the
			///						values of other specified Vector2.
			static add = function(_value)
			{
				try
				{
					var _result_x = x;
					var _result_y = y;
					
					if (instanceof(_value) == "Vector2")
					{
						_result_x += _value.x;
						_result_y += _value.y;
					}
					else
					{
						_result_x += _value;
						_result_y += _value;
					}
					
					x = _result_x;
					y = _result_y;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "add()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real|Vector2}
			/// @description		Substract the values of this Vector2 the specified value or the
			///						values of other specified Vector2.
			static substract = function(_value)
			{
				try
				{
					var _result_x = x;
					var _result_y = y;
					
					if (instanceof(argument[0]) == "Vector2")
					{
						_result_x -= _value.x;
						_result_y -= _value.y;
					}
					else
					{
						_result_x -= _value;
						_result_y -= _value;
					}
					
					x = _result_x;
					y = _result_y;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "substract()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real|Vector2}
			/// @description		Multiply the values of this Vector2 by specified value or the
			///						values of other specified Vector2.
			static multiply = function(_value)
			{
				try
				{
					var _result_x = x;
					var _result_y = y;
					
					if (instanceof(_value) == "Vector2")
					{
						_result_x *= _value.x;
						_result_y *= _value.y;
					}
					else
					{
						_result_x *= _value;
						_result_y *= _value;
					}
					
					x = _result_x;
					y = _result_y;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "multiply()"], _exception);
				}
				
				return self;
			}
			
			//? @argument			value {real|Vector2}
			//? @description		Divide the values of this Vector2 by specified value or the values
			//?						of other specified Vector2. Attempts of division by 0 are ignored.
			static divide = function(_value)
			{
				try
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
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "divide()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			target {Vector2}
			/// @argument			rate {Vector2}
			/// @description		Move the x and y values towards the specified target with the
			///						specified rate without exceeding it.
			static approach = function(_target, _rate)
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "approach()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real|Vector2}
			/// @description		Perform a calculation with the specified value by adding to its
			///						respective values with the same sign as the values of this
			///						Vector2.
			static grow = function(_value)
			{
				try
				{
					var _result_x = x;
					var _result_y = y;
					
					if (is_real(_value))
					{
						_result_x += (abs(_value) * sign(x));
						_result_y += (abs(_value) * sign(y));
					}
					else
					{
						_result_x += (abs(_value.x) * sign(x));
						_result_y += (abs(_value.y) * sign(y));
					}
					
					x = _result_x;
					y = _result_y;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "grow()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real|Vector2}
			/// @description		Perform a calculation with the specified value by substracting it
			///						from its respective values with the same sign as the values of
			///						this Vector2.
			static shrink = function(_value)
			{
				try
				{
					var _result_x = x;
					var _result_y = y;
					
					if (is_real(_value))
					{
						_result_x -= (abs(_value) * sign(x));
						_result_y -= (abs(_value) * sign(y));
					}
					else
					{
						_result_x -= (abs(_value.x) * sign(x));
						_result_y -= (abs(_value.y) * sign(y));
					}
					
					x = _result_x;
					y = _result_y;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "shrink()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			boundary {Vector4}
			/// @description		Restrict the values of this Vector2 to the boundaries of the
			///						specified Vector4.
			static clampTo = function(_boundary)
			{
				try
				{
					var _result_x = x;
					var _result_y = y;
					
					_result_x = clamp(x, min(_boundary.x1, _boundary.x2),
									  max(_boundary.x1, _boundary.x2));
					_result_y = clamp(y, min(_boundary.y1, _boundary.y2),
									  max(_boundary.y1, _boundary.y2));
					
					x = _result_x;
					y = _result_y;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "clampTo()"], _exception);
				}
				
				return self;
			}
			
			/// @description		Swap the x and y values of this Vector2 with each other.
			static flip = function()
			{
				var _result_x = y;
				var _result_y = x;
				
				x = _result_x;
				y = _result_y;
				
				return self;
			}
			
			/// @description		Reverse the x and y values.
			static mirror = function()
			{
				try
				{
					var _result_x = (-x);
					var _result_y = (-y);
					
					x = _result_x;
					y = _result_y;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "mirror()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real|Vector2|Scale}
			/// @description		Set all of the values to one specified value.
			static set = function(_value)
			{
				try
				{
					var _result_x, _result_y;
					
					if (is_real(_value))
					{
						_result_x = _value;
						_result_y = _value;
					}
					else
					{
						_result_x = _value.x;
						_result_y = _value.y;
					}
					
					x = _result_x;
					y = _result_y;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "set()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value? {real|Vector2|Scale}
			/// @description		Set all of the values of to their equivalents rounded down or the
			///						ones of the specified value.
			static setFloor = function(_value)
			{
				try
				{
					var _result_x, _result_y;
					
					if (_value == undefined)
					{
						_result_x = floor(x);
						_result_y = floor(y);
					}
					else if (is_real(_value))
					{
						var _value_floor = floor(_value);
						_result_x = _value_floor;
						_result_y = _value_floor;
					}
					else
					{
						_result_x = floor(_value.x);
						_result_y = floor(_value.y);
					}
					
					x = _result_x;
					y = _result_y;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setFloor()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value? {real|Vector2|Scale}
			/// @description		Set all of the values of to their equivalents rounded down or up
			///						or the ones of the specified value.
			static setRound = function(_value)
			{
				try
				{
					var _result_x, _result_y;
					
					if (_value == undefined)
					{
						_result_x = round(x);
						_result_y = round(y);
					}
					else if (is_real(_value))
					{
						var _value_round = round(_value);
						_result_x = _value_round;
						_result_y = _value_round;
					}
					else
					{
						_result_x = round(_value.x);
						_result_y = round(_value.y);
					}
					
					x = _result_x;
					y = _result_y;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setRound()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value? {real|Vector2|Scale}
			/// @description		Set all of the values of to their equivalents rounded up or the
			///						ones of the specified value.
			static setCeil = function(_value)
			{
				try
				{
					var _result_x, _result_y;
					
					if (_value == undefined)
					{
						_result_x = ceil(x);
						_result_y = ceil(y);
					}
					else if (is_real(_value))
					{
						var _value_ceil = ceil(_value);
						_result_x = _value_ceil;
						_result_y = _value_ceil;
					}
					else
					{
						_result_x = ceil(_value.x);
						_result_y = ceil(_value.y);
					}
					
					x = _result_x;
					y = _result_y;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setCeil()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			device? {int}
			/// @description		Set all of the values to the ones of the cursor.
			static setCursor = function(_device)
			{
				try
				{
					var _result_x, _result_y;
					
					if (is_real(_device))
					{
						_result_x = device_mouse_x(_device);
						_result_y = device_mouse_y(_device);
					}
					else
					{
						_result_x = mouse_x;
						_result_y = mouse_y;
					}
					
					x = _result_x;
					y = _result_y;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setCursor()"], _exception);
				}
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented with the values of this Container.
			static toString = function(_multiline = false)
			{
				var _mark_separator = ((_multiline) ? "\n" : ", ");
				var _string = ("x: " + string(x) + _mark_separator + "y: " + string(y));
				
				return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
			}
			
			/// @returns			{real[]}
			/// @description		Return an array containing all values of this Container.
			static toArray = function()
			{
				return [x, y];
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static prototype = {};
		var _property = variable_struct_get_names(prototype);
		var _i = 0;
		repeat (array_length(_property))
		{
			var _name = _property[_i];
			var _value = variable_struct_get(prototype, _property[_i]);
			
			variable_struct_set(self, _name, ((is_method(_value)) ? method(self, _value) : _value));
			
			++_i;
		}
		
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

