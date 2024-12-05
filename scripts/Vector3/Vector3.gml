//  @function				Vector3()
/// @argument				x? {real}
/// @argument				y? {real}
/// @argument				z? {real}
/// @description			Constructs a Vector container for three-dimensional coordinates:
///							x, y and z.
//							
//							Construction types:
//							- Three numbers: x {real}, y {real}, z {real}
//							- One number for all values: value {real}
//							- From array: array {real[]}
//							   Array positions will be applied depending on its size:
//							   1: array[0] will be set to x and y.
//							   3+: array[0] will be set to x, array[1] will be set to y, array[2] will
//								   be set to z.
//							- Vector2 + value: vector {Vector2}, value {real}
//							- Empty: {void|undefined}
//							- Constructor copy: other {Vector3}
function Vector3() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				x = undefined;
				y = undefined;
				z = undefined;
				
				if (argument_count > 0)
				{
					switch (instanceof(argument[0]))
					{
						case "Vector3":
							//|Construction type: Constructor copy.
							var _other = argument[0];
							
							x = _other.x;
							y = _other.y;
							z = _other.z;
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
												z = _array[0];
											break;
											case 3:
											default:
												x = _array[0];
												y = _array[1];
												z = _array[2];
											break;
										}
									}
									else
									{
										//|Construction type: One number for all values.
										x = argument[0];
										y = argument[0];
										z = argument[0];
									}
								break;
								case 2:
									//|Construction type: Vector2 + value.
									var _vector = argument[0];
									var _value = argument[1];
									
									x = _vector.x;
									y = _vector.y;
									z = _value;
								break
								default:
									//|Construction type: Three numbers.
									x = argument[0];
									y = argument[1];
									z = argument[2];
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
				return ((is_real(x)) and (is_real(y)) and (is_real(z)) and (!is_nan(x))
						and (!is_nan(y)) and (!is_nan(z)) and (!is_infinity(x)) and (!is_infinity(y))
						and (!is_infinity(z)));
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			value... {any}
			/// @returns			{bool}
			/// @description		Check if this Vector3 contains at least one of the specified
			///						values.
			static contains = function()
			{
				var _i = 0;
				repeat (argument_count)
				{
					var _value = argument[_i];
					
					if ((x == _value) or (y == _value) or (z == _value))
					{
						return true;
					}
					
					++_i;
				}
				
				return false;
			}
			
			/// @argument			value {real|Vector3}
			/// @returns			{bool}
			/// @description		Check if all values of this constructor are the same as the
			///						specified number or respective values of other Vector3.
			static equals = function(_value)
			{
				if (is_instanceof(_value, Vector3))
				{
					return ((x == _value.x) and (y == _value.y) and (z == _value.z));
				}
				else if (is_real(_value))
				{
					return ((x == _value) and (y == _value) and (z == _value.z));
				}
				
				return false;
			}
			
			/// @argument			value {real|Vector3}
			/// @returns			{bool}
			/// @description		Check if all values of this Vector3 are higher than the specified
			///						value or respective values of the specified Vector3.
			static exceeds = function(_value)
			{
				try
				{
					if (is_real(_value))
					{
						return ((x > _value) and (y > _value) and (z > _value));
					}
					else
					{
						return ((x > _value.x) and (y > _value.y) and (z > _value.z));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "exceeds()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			value {real|Vector3}
			/// @returns			{bool}
			/// @description		Check if all values of this Vector3 are lower than the specified
			///						value or respective values of the specified Vector3.
			static subceeds = function(_value)
			{
				try
				{
					if (is_real(_value))
					{
						return ((x < _value) and (y < _value) and (z < _value));
					}
					else
					{
						return ((x < _value.x) and (y < _value.y) and (z < _value.z));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "exceeds()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			value? {real|Vector3}
			/// @returns			{real|Vector3} | On error: {undefined}
			/// @description		Return the sum of either the values of this Vector3 or them added
			///						to the specified value or the ones of the specified Vector3.
			static sum = function()
			{
				try
				{
					if ((argument_count > 0) and (argument[0] != undefined))
					{
						var _value = argument[0];
						var _sum_x, _sum_y, _sum_z;
						
						if (is_real(_value))
						{
							_sum_x = (x + _value);
							_sum_y = (y + _value);
							_sum_z = (z + _value);
						}
						else
						{
							_sum_x = (x + _value.x);
							_sum_y = (y + _value.y);
							_sum_z = (z + _value.z);
						}
						
						return new Vector3(_sum_x, _sum_y, _sum_z);
					}
					else
					{
						return (x + y + z);
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "sum()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			value? {real|Vector3}
			/// @returns			{real|Vector3} | On error: {undefined}
			/// @description		Return the difference between either the values of this Vector3 or
			///						them and the specified value or the ones of the specified Vector3.
			static difference = function()
			{
				try
				{
					if ((argument_count > 0) and (argument[0] != undefined))
					{
						var _value = argument[0];
						var _difference_x, _difference_y, _difference_z;
						
						if (is_real(_value))
						{
							_difference_x = abs(x - _value);
							_difference_y = abs(y - _value);
							_difference_z = abs(z - _value);
						}
						else
						{
							_difference_x = abs(x - _value.x);
							_difference_y = abs(y - _value.y);
							_difference_z = abs(z - _value.z);
						}
						
						return new Vector3(_difference_x, _difference_y, _difference_z);
					}
					else
					{
						return abs(x - y - z);
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "difference()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			value? {real|Vector3}
			/// @returns			{real|Vector3} | On error: {undefined}
			/// @description		Return the result of multiplication of either the values of this
			///						Vector3 or them multiplied by the specified value or the ones of
			///						the specified Vector3.
			static product = function()
			{
				try
				{
					if ((argument_count > 0) and (argument[0] != undefined))
					{
						var _value = argument[0];
						var _product_x, _product_y, _product_z;
						
						if (is_real(_value))
						{
							_product_x = (x * _value);
							_product_y = (y * _value);
							_product_z = (z * _value);
						}
						else
						{
							_product_x = (x * _value.x);
							_product_y = (y * _value.y);
							_product_z = (z * _value.z);
						}
						
						return new Vector3(_product_x, _product_y, _product_z);
					}
					else
					{
						return (x * y * z);
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "product()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			value {real|Vector3}
			/// @returns			{Vector3} | On error: {undefined}
			/// @description		Return the result of division of the values of this Vector3
			///						divided by the specified value or the ones of the specified
			///						Vector3. Attempts of division by 0 are ignored.
			static quotient = function(_value)
			{
				try
				{
					var _quotient_x = x;
					var _quotient_y = y;
					var _quotient_z = z;
					
					if (is_real(_value))
					{
						if (_value != 0)
						{
							_quotient_x = (x / _value);
							_quotient_y = (y / _value);
							_quotient_z = (z / _value);
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
						
						if (_value.z != 0)
						{
							_quotient_z = (z / _value.z);
						}
					}
					
					return new Vector3(_quotient_x, _quotient_y, _quotient_z);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "product()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{real} | On error: {undefined}
			/// @description		Return the lowest of all values.
			static getMinimum = function()
			{
				try
				{
					return min(x, y, z);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getMinimum()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{real} | On error: {undefined}
			/// @description		Return the highest of all values.
			static getMaximum = function()
			{
				try
				{
					return max(x, y, z);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getMaximum()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{real} | On error: {undefined}
			/// @description		Return the vector length.
			static getMagnitude = function()
			{
				try
				{
					return sqrt((x * x) + (y * y) + (z * z));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getMagnitude()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			magnitude? {real}
			/// @returns			{Vector3} | On error: {undefined}
			/// @description		Return the unit vector of this Vector3, which will have its
			///						values placed between -1 and 1, but with the same direction.
			///						These values are then multiplied by the specified magnitude.
			static getNormalized = function(_magnitude = 1)
			{
				try
				{
					var _length = sqrt((x * x) + (y * y) + (z * z));
					var _x = x;
					var _y = y;
					var _z = z;
					
					if (_length != 0)
					{
						_x = ((x / _length) * _magnitude);
						_y = ((y / _length) * _magnitude);
						_z = ((z / _length) * _magnitude);
					}
					
					return new Vector3(_x, _y, _z);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getNormalized()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			booleanSign? {bool}
			/// @returns			{Vector3} | On error: {undefined}
			/// @description		Return a Vector3 with each respective value representing the sign
			///						of the number: -1 for a negative number, 0 for itself and 1 for a
			///						positive number. If the result is specified to be returned as the
			///						boolean sign, -1 will be set for 0 as well.
			static getSign = function(_booleanSign = false)
			{
				try
				{
					if (_booleanSign)
					{
						return new Vector3(((x > 0) ? 1 : -1), ((y > 0) ? 1 : -1),
										  ((z > 0) ? 1 : -1));
					}
					else
					{
						return new Vector3(sign(x), sign(y), sign(z));
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
			
			/// @argument			value {real|Vector3}
			/// @description		Add to the values of this Vector3 the specified value or values of
			///						other specified Vector3.
			static add = function(_value)
			{
				try
				{
					var _result_x = x;
					var _result_y = y;
					var _result_z = z;
					
					if (is_real(_value))
					{
						_result_x += _value;
						_result_y += _value;
						_result_z += _value;
					}
					else
					{
						_result_x += _value.x;
						_result_y += _value.y;
						_result_z += _value.z;
					}
					
					x = _result_x;
					y = _result_y;
					z = _result_z;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "add()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real|Vector3}
			/// @description		Substract from the values of this Vector3 the specified value or
			///						values of other specified Vector3.
			static substract = function(_value)
			{
				try
				{
					var _result_x = x;
					var _result_y = y;
					var _result_z = z;
					
					if (is_real(_value))
					{
						_result_x -= _value;
						_result_y -= _value;
						_result_z -= _value;
					}
					else
					{
						_result_x -= _value.x;
						_result_y -= _value.y;
						_result_z -= _value.z;
					}
					
					x = _result_x;
					y = _result_y;
					z = _result_z;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "substract()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real|Vector3}
			/// @description		Multiply the values of this Vector3 by specified value or values
			///						of other specified Vector3.
			static multiply = function(_value)
			{
				try
				{
					var _result_x = x;
					var _result_y = y;
					var _result_z = z;
					
					if (is_real(_value))
					{
						_result_x *= _value;
						_result_y *= _value;
						_result_z *= _value;
					}
					else
					{
						_result_x *= _value.x;
						_result_y *= _value.y;
						_result_z *= _value.z;
					}
					
					x = _result_x;
					y = _result_y;
					z = _result_z;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "multiply()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real|Vector3}
			/// @description		Divide the values of this Vector3 by specified value or values of
			///						other specified Vector3. Attempts of division by 0 are ignored.
			static divide = function(_value)
			{
				try
				{
					if (is_real(_value))
					{
						if (_value != 0)
						{
							x /= _value;
							y /= _value;
							z /= _value;
						}
					}
					else
					{
						if (_value.x != 0)
						{
							x /= _value.x;
						}
						
						if (_value.y != 0)
						{
							y /= _value.y;
						}
						
						if (_value.z != 0)
						{
							z /= _value.z;
						}
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "divide()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			target {Vector3}
			/// @argument			rate {Vector3}
			/// @description		Move all values towards the specified target with respective rate
			///						without exceeding it.
			static approach = function(_target, _rate)
			{
				try
				{
					var _value_array = [x, y, z];
					var _target_array = [_target.x, _target.y, _target.z];
					var _rate_array = [abs(_rate.x), abs(_rate.y), abs(_rate.z)];
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
					z = _value_array[2];
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "approach()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real|Vector3}
			/// @description		Perform a calculation with the specified value by adding to its
			///						respective values with the same sign as the values of this
			///						Vector3.
			static grow = function(_value)
			{
				try
				{
					var _result_x = x;
					var _result_y = y;
					var _result_z = z;
					
					if (is_real(_value))
					{
						_result_x += (abs(_value) * sign(x));
						_result_y += (abs(_value) * sign(y));
						_result_z += (abs(_value) * sign(z));
					}
					else
					{
						_result_x += (abs(_value.x) * sign(x));
						_result_y += (abs(_value.y) * sign(y));
						_result_z += (abs(_value.z) * sign(z));
					}
					
					x = _result_x;
					y = _result_y;
					z = _result_z;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "grow()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real|Vector3}
			/// @description		Perform a calculation with the specified value by substracting it
			///						from its respective values with the same sign as the values of
			///						this Vector3.
			static shrink = function(_value)
			{
				try
				{
					var _result_x = x;
					var _result_y = y;
					var _result_z = z;
					
					if (is_real(_value))
					{
						_result_x -= (abs(_value) * sign(x));
						_result_y -= (abs(_value) * sign(y));
						_result_z -= (abs(_value) * sign(z));
					}
					else
					{
						_result_x -= (abs(_value.x) * sign(x));
						_result_y -= (abs(_value.y) * sign(y));
						_result_z -= (abs(_value.z) * sign(z));
					}
					
					x = _result_x;
					y = _result_y;
					z = _result_z;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "shrink()"], _exception);
				}
				
				return self;
			}
			
			/// @description		Reverse all values.
			static mirror = function()
			{
				try
				{
					var _result_x = (-x);
					var _result_y = (-y);
					var _result_z = (-z);
					
					x = _result_x;
					y = _result_y;
					z = _result_z;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "mirror()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			x? {real}
			/// @argument			y? {real}
			/// @argument			z? {real}
			/// @description		Set each value of this Vector3.
			static set = function(_x = x, _y = y, _z)
			{
				x = _x;
				y = _y;
				z = _z;
				
				return self;
			}
			
			/// @argument			value {real|real[]|Vector3}
			/// @description		Set all of the values to one specified value or first three values
			///						of the specified array.
			static setAll = function(_value)
			{
				try
				{
					var _result_x, _result_y, _result_z;
					
					if (is_real(_value))
					{
						_result_x = _value;
						_result_y = _value;
						_result_z = _value;
					}
					else if (is_array(_value))
					{
						_result_x = _value[0];
						_result_y = _value[1];
						_result_z = _value[2];
					}
					else
					{
						_result_x = _value.x;
						_result_y = _value.y;
						_result_z = _value.z;
					}
					
					x = _result_x;
					y = _result_y;
					z = _result_z;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setAll()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value? {real|Vector3}
			/// @description		Set all of the values of to their equivalents or the ones of the
			///						specified value rounded down.
			static setFloor = function(_value)
			{
				try
				{
					var _result_x, _result_y, _result_z;
					
					if (_value == undefined)
					{
						_result_x = floor(x);
						_result_y = floor(y);
						_result_z = floor(z);
					}
					else if (is_real(_value))
					{
						var _value_floor = floor(_value);
						_result_x = _value_floor;
						_result_y = _value_floor;
						_result_z = _value_floor;
					}
					else
					{
						_result_x = floor(_value.x);
						_result_y = floor(_value.y);
						_result_z = floor(_value.z);
					}
					
					x = _result_x;
					y = _result_y;
					z = _result_z;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setFloor()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value? {real|Vector3}
			/// @description		Set all of the values of to their equivalents or the ones of the
			///						specified value rounded down or up.
			static setRound = function(_value)
			{
				try
				{
					var _result_x, _result_y, _result_z;
					
					if (_value == undefined)
					{
						_result_x = round(x);
						_result_y = round(y);
						_result_z = round(z);
					}
					else if (is_real(_value))
					{
						var _value_round = round(_value);
						_result_x = _value_round;
						_result_y = _value_round;
						_result_z = _value_round;
					}
					else
					{
						_result_x = round(_value.x);
						_result_y = round(_value.y);
						_result_z = round(_value.z);
					}
					
					x = _result_x;
					y = _result_y;
					z = _result_z;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setRound()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value? {real|Vector3}
			/// @description		Set all of the values of to their equivalents or the ones of the
			///						specified value rounded up.
			static setCeil = function(_value)
			{
				try
				{
					var _result_x, _result_y, _result_z;
					
					if (_value == undefined)
					{
						_result_x = ceil(x);
						_result_y = ceil(y);
						_result_z = ceil(z);
					}
					else if (is_real(_value))
					{
						var _value_ceil = ceil(_value);
						_result_x = _value_ceil;
						_result_y = _value_ceil;
						_result_z = _value_ceil;
					}
					else
					{
						_result_x = ceil(_value.x);
						_result_y = ceil(_value.y);
						_result_z = ceil(_value.z);
					}
					
					x = _result_x;
					y = _result_y;
					z = _result_z;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setCeil()"], _exception);
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
				var _string = ("x: " + string(x) + _mark_separator + "y: " + string(y) +
							   _mark_separator + "z:" + string(z));
				
				return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
			}
			
			/// @returns			{real[]}
			/// @description		Return an array containing all values of this Container.
			static toArray = function()
			{
				return [x, y, z];
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static constructor = Vector3;
		
		static prototype = {};
		var _property = variable_struct_get_names(prototype);
		var _i = 0;
		repeat (array_length(_property))
		{
			var _name = _property[_i];
			var _value = variable_struct_get(prototype, _name);
			
			variable_struct_set(self, _name, ((is_method(_value)) ? method(self, _value) : _value));
			
			++_i;
		}
		
		var _argument = array_create(argument_count, undefined);
		var _i = 0;
		repeat (argument_count)
		{
			_argument[_i] = argument[_i];
			
			++_i;
		}
		
		script_execute_ext(self.construct, _argument);
		
	#endregion
}
