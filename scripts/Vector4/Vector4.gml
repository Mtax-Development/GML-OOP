//  @function				Vector4()
/// @argument				x1? {real}
/// @argument				y1? {real}
/// @argument				x2? {real}
/// @argument				y2? {real}
///							
/// @description			Construct a Vector container for two x and y coordinate pairs.
//							
//							Construction types:
//							- Four numbers: x1 {real}, y1 {real}, x2 {real}, y2 {real}
//							- One number for all values: {real} value
//							- Number pair: first {real}, second {real}
//							   First number will be set to x1 and y1.
//							   Second number will be set to x2 and y2.
//							- From array: array {real[]}
//							   Array positions will be applied depending on its size:
//								1: array[0] will be set to all values.
//								2: array[0] will be set to x1 and y1, array[1] will be set to 
//								   x2 and y2.
//								4+: array[0] will be set to x1, array[1] will be set to y1,
//									array[2] will be set to x2, array[3] will be set to y2.
//							- From Scale or Vector2: other {Scale|Vector2}
//							- Vector2 pair: first {Vector2}, second {Vector2}
//							- Empty: {void|undefined}
//							- Constructor copy: other {Vector4}
function Vector4() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				x1 = undefined;
				y1 = undefined;
				x2 = undefined;
				y2 = undefined;
				
				if (argument_count > 0)
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
						switch (argument_count)
						{
							case 1:
								var _argument_instanceof = instanceof(argument[0]);
								
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
								else if ((_argument_instanceof == "Vector2")
								or (_argument_instanceof == "Scale"))
								{
									//|Construction type: From Scale or Vector2.
									var _other = argument[0];
									
									x1 = _other.x;
									y1 = _other.y;
									x2 = _other.x;
									y2 = _other.y;
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
							
							default:
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
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(x1)) and (is_real(y1)) and (is_real(x2)) and (is_real(y2))
						and (!is_nan(x1)) and (!is_nan(y1)) and (!is_nan(x2)) and (!is_nan(y2))
						and (!is_infinity(x1)) and (!is_infinity(y1)) and (!is_infinity(x2))
						and (!is_infinity(y2)));
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			value... {any}
			/// @returns			{bool}
			/// @description		Check if this Vector4 contains at least one of the specified
			///						values.
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
			
			/// @argument			other {real|Vector2|Vector4}
			/// @returns			{bool}
			/// @description		Check if the respective values are equal to the specified value.
			static equals = function(_value)
			{
				try
				{
					if (is_real(_value))
					{
						return ((x1 == _value) and (y1 == _value) and (x2 == _value)
								and (y2 == _value));
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "equals()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			value? {real|Vector2|Vector4}
			/// @returns			{Vector2|Vector4} | On error: {undefined}
			/// @description		Return the sum of either the values of this Vector4 as a Vector2
			///						or them added to the specified value or the ones of the specified
			///						Vector2 or Vector4 as a Vector4.
			static sum = function()
			{
				try
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
				
				catch (_exception)
				{
					new ErrorReport().report([other, self, "sum()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			value? {real|Vector2|Vector4}
			/// @returns			{Vector2|Vector4} | On error: {undefined}
			/// @description		Return the difference between either the values of this Vector4
			///						as a Vector2 or them and the specified value or the ones of the
			///						specified Vector2 or Vector4 as a Vector4.
			static difference = function()
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "difference()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			value? {real|Vector2|Vector4}
			/// @returns			{Vector2|Vector4} | On error: {undefined}
			/// @description		Return the result of multiplication of either the values of this
			///						Vector4 as a Vector2 or them multiplied by the specified value or
			///						the ones of the specified Vector2 or Vector4 as a Vector4.
			static product = function()
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "product()"], _exception);
				}
			}
			
			/// @argument			value {real|Vector2|Vector4}
			/// @returns			{Vector4} | On error: {undefined}
			/// @description		Return the result of division of the values of this Vector4
			///						divided by the specified value or the ones of the specified
			///						Vector2 or Vector4. Attempts of division by 0 are ignored.
			static quotient = function(_value)
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "quotient()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			normalize? {bool}
			/// @returns			{real} | On error: {undefined}
			/// @description		Return the sum of each value of this Vector4 being multiplied by
			///						its respective other value, which is an expression of the angular
			///						reliationship between its two points. The returned value can be
			///						normalized, which will place it between -1 and 1.
			static dotProduct = function(_normalize = false)
			{
				try
				{
					return ((_normalize) ? dot_product_normalized(x1, y1, x2, y2)
										 : dot_product(x1, y1, x2, y2));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "dotProduct()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			value {real|Vector2|Vector4}
			/// @returns			{Vector2|Vector4} | On error: {undefined}
			/// @description		Return the point at specified respective precentages within the
			///						x and y values.
			static interpolate = function(_value)
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "interpolate()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			value {real|Vector2}
			/// @returns			{Vector2} | On error: {undefined}
			/// @description		Return the percentage value representing the specified value
			///						inside of the boundaries made by the values of this Vector4 as a
			///						numerical value in which one whole number is one full percentage.
			static percent = function(_value)
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "percent()"], _exception);
				}
			}
			
			/// @argument			fromSecond? {bool}
			/// @returns			{Angle} | On error: {undefined}
			/// @description		Return the Angle from first set of the values of this Vector4
			///						towards the second, or if specified, from second set of values
			///						towards the first.
			static getAngle = function(_fromSecond = false)
			{
				try
				{
					return ((_fromSecond) ? new Angle(point_direction(x2, y2, x1, y1))
										  : new Angle(point_direction(x1, y1, x2, y2)));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "sum()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{real} | On error: {undefined}
			/// @description		Return the shortest distance between two points.
			static getDistance = function()
			{
				try
				{
					return point_distance(x1, y1, x2, y2);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getDistance()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			target {Vector2}
			/// @returns			{Vector2} | On error: {undefined}
			/// @description		Return the value pair that is the closest to the specified target.
			static getClosest = function(_target)
			{
				try
				{
					var _difference_x1 = abs(_target.x - x1);
					var _difference_y1 = abs(_target.y - y1);
					var _difference_x2 = abs(_target.x - x2);
					var _difference_y2 = abs(_target.y - y2);
					var _minimum_x = min(_difference_x1, _difference_x2);
					var _minimum_y = min(_difference_y1, _difference_y2);
					
					return new Vector2(((_minimum_x == _difference_x1) ? x1 : x2),
									   ((_minimum_y == _difference_y1) ? y1 : y2));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getClosest()"], _exception);
				}
			}
			
			/// @argument			separate? {bool}
			/// @returns			{real|Vector2} | On error: {undefined}
			/// @description		Return the lowest of all values or if the values are specified to
			///						be separated, the lowest of each value pair.
			static getMinimum = function(_separate = false)
			{
				try
				{
					return ((_separate) ? new Vector2(min(x1, x2), min(y1, y2))
										: min(x1, y1, x2, y2));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getMinimum()"], _exception);
				}
			}
			
			/// @argument			separate? {bool}
			/// @returns			{real|Vector2} | On error: {undefined}
			/// @description		Return the highest of all values or if the values are specified
			///						to be separated, the highlowest of each value pair.
			static getMaximum = function(_separate = false)
			{
				try
				{
					return ((_separate) ? new Vector2(max(x1, x2), max(y1, y2))
										: max(x1, y1, x2, y2));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getMaximum()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{Vector2} | On error: {undefined}
			/// @description		Return the middle point of this Vector4.
			static getMiddle = function()
			{
				try
				{
					return new Vector2(mean(x1, x2), mean(y1, y2));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getMiddle()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{real} | On error: {undefined}
			/// @description		Return the vector length.
			static getMagnitude = function()
			{
				try
				{
					return sqrt((x1 * x1) + (y1 * y1) + (x2 * x2) + (y2 * y2));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getMagnitude()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			magnitude? {real}
			/// @returns			{Vector4} | On error: {undefined}
			/// @description		Return the unit vector of this Vector4, which will have its
			///						values placed between -1 and 1, but with the same direction.
			///						These values are then multiplied by the specified magnitude.
			static getNormalized = function(_magnitude = 1)
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getNormalized()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			booleanSign? {bool}
			/// @returns			{Vector4} | On error: {undefined}
			/// @description		Return a Vector4 with each respective value representing the sign
			///						of the number: -1 for a negative number, 0 for itself and 1 for a
			///						positive number. If the result is specified to be returned as the
			///						boolean sign, -1 will be set for 0 as well.
			static getSign = function(_booleanSign = false)
			{
				try
				{
					if (_booleanSign)
					{
						return new Vector4(((x1 > 0) ? 1 : -1), ((y1 > 0) ? 1 : -1),
										   ((x2 > 0) ? 1 : -1), ((y2 > 0) ? 1 : -1))
					}
					else
					{
						return new Vector4(sign(x1), sign(y1), sign(x2), sign(y2));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getSign()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			location {Vector2}
			/// @returns			{bool} | On error: {undefined}
			/// @description		Check if a point in space is within this Vector4.
			static isBetween = function(_location)
			{
				try
				{
					return ((_location.x == clamp(_location.x, x1, x2)) 
							and (_location.y == clamp(_location.y, y1, y2)));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "isBetween()"], _exception);
				}
			}
			
		#endregion
		#region <Setters>
			
			/// @argument			value {real|Vector2|Vector4}
			/// @description		Add to the values of this Vector4 the specified value or the
			///						values of other specified Vector4 or Vector2.
			static add = function(_value)
			{
				try
				{
					var _result_x1 = x1;
					var _result_y1 = y1;
					var _result_x2 = x2;
					var _result_y2 = y2;
					
					switch (instanceof(_value))
					{
						case "Vector4":
							_result_x1 += _value.x1;
							_result_y1 += _value.y1;
							_result_x2 += _value.x2;
							_result_y2 += _value.y2;
						break;
						
						case "Vector2":
							_result_x1 += _value.x;
							_result_y1 += _value.y;
							_result_x2 += _value.x;
							_result_y2 += _value.y;
						break;
						
						default:
							_result_x1 += _value;
							_result_y1 += _value;
							_result_x2 += _value;
							_result_y2 += _value;
						break;
					}
					
					x1 = _result_x1;
					y1 = _result_y1;
					x2 = _result_x2;
					y2 = _result_y2;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "add()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real|Vector2|Vector4}
			/// @description		Substract from the values of this Vector4 the specified value or 
			///						the values of other specified Vector4 or Vector2.
			static substract = function(_value)
			{
				try
				{
					var _result_x1 = x1;
					var _result_y1 = y1;
					var _result_x2 = x2;
					var _result_y2 = y2;
					
					switch (instanceof(_value))
					{
						case "Vector4":
							_result_x1 -= _value.x1;
							_result_y1 -= _value.y1;
							_result_x2 -= _value.x2;
							_result_y2 -= _value.y2;
						break;
						
						case "Vector2":
							_result_x1 -= _value.x;
							_result_y1 -= _value.y;
							_result_x2 -= _value.x;
							_result_y2 -= _value.y;
						break;
						
						default:
							_result_x1 -= _value;
							_result_y1 -= _value;
							_result_x2 -= _value;
							_result_y2 -= _value;
						break;
					}
					
					x1 = _result_x1;
					y1 = _result_y1;
					x2 = _result_x2;
					y2 = _result_y2;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "substract()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real|Vector2|Vector4}
			/// @description		Multiply the values of this Vector4 the specified value or the 
			///						values of other specified Vector4 or Vector2.
			static multiply = function(_value)
			{
				try
				{
					var _result_x1 = x1;
					var _result_y1 = y1;
					var _result_x2 = x2;
					var _result_y2 = y2;
					
					switch (instanceof(_value))
					{
						case "Vector4":
							_result_x1 *= _value.x1;
							_result_y1 *= _value.y1;
							_result_x2 *= _value.x2;
							_result_y2 *= _value.y2;
						break;
						
						case "Vector2":
							_result_x1 *= _value.x;
							_result_y1 *= _value.y;
							_result_x2 *= _value.x;
							_result_y2 *= _value.y;
						break;
						
						default:
							_result_x1 *= _value;
							_result_y1 *= _value;
							_result_x2 *= _value;
							_result_y2 *= _value;
						break;
					}
					
					x1 = _result_x1;
					y1 = _result_y1;
					x2 = _result_x2;
					y2 = _result_y2;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "multiply()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real|Vector2|Vector4}
			/// @description		Divide the values of this Vector4 the specified value or the 
			///						values of other specified Vector4 or Vector2. Attempts of
			///						division by 0 are ignored.
			static divide = function(_value)
			{
				try
				{
					var _result_x1 = x1;
					var _result_y1 = y1;
					var _result_x2 = x2;
					var _result_y2 = y2;
					
					switch (instanceof(_value))
					{
						case "Vector4":
							if (_value.x1 != 0)
							{
								_result_x1 /= _value.x1;
							}
							
							if (_value.y1 != 0)
							{
								_result_y1 /= _value.y1;
							}
							
							if (_value.x2 != 0)
							{
								_result_x2 /= _value.x2;
							}
							
							if (_value.y2 != 0)
							{
								_result_y2 /= _value.y2;
							}
						break;
						
						case "Vector2":
							if (_value.x != 0)
							{
								_result_x1 /= _value.x;
								_result_x2 /= _value.x;
							}
							
							if (_value.y != 0)
							{
								_result_y1 /= _value.y;
								_result_y2 /= _value.y;
							}
						break;
						
						default:
							if (_value != 0)
							{
								_result_x1 /= _value;
								_result_y1 /= _value;
								_result_x2 /= _value;
								_result_y2 /= _value;
							}
						break;
					}
					
					x1 = _result_x1;
					y1 = _result_y1;
					x2 = _result_x2;
					y2 = _result_y2;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "divide()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			target {Vector4}
			/// @argument			rate {Vector4}
			/// @description		Move the x and y values towards the specified target with the
			///						specified rate without exceeding it.
			static approach = function(_target, _rate)
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "approach()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			boundary {Vector4}
			/// @description		Restrict the values of this Vector4 to the boundaries of other
			///						specified Vector4.
			static clampTo = function(_boundary)
			{
				try
				{
					var _minimum_x = min(_boundary.x1, _boundary.x2);
					var _maximum_x = max(_boundary.x1, _boundary.x2);
					var _minimum_y = min(_boundary.y1, _boundary.y2);
					var _maximum_y = max(_boundary.y1, _boundary.y2);
					var _result_x1 = clamp(x1, _minimum_x, _maximum_x);
					var _result_y1 = clamp(y1, _minimum_y, _maximum_y);
					var _result_x2 = clamp(x2, _minimum_x, _maximum_x);
					var _result_y2 = clamp(y2, _minimum_y, _maximum_y);
					
					x1 = _result_x1;
					y1 = _result_y1;
					x2 = _result_x2;
					y2 = _result_y2;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "clampTo()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real|Vector2|Vector4}
			/// @description		Perform a calculation with the specified value by substracting
			///						its respective values from the first set of values and adding
			///						them to the second set.
			static grow = function(_value)
			{				
				try
				{
					var _result_x1 = x1;
					var _result_y1 = y1;
					var _result_x2 = x2;
					var _result_y2 = y2;
					
					switch (instanceof(_value))
					{
						case "Vector4":
							_result_x1 -= _value.x1;
							_result_y1 -= _value.y1;
							_result_x2 += _value.x2;
							_result_y2 += _value.y2;
						break;
						
						case "Vector2":
							_result_x1 -= _value.x;
							_result_y1 -= _value.y;
							_result_x2 += _value.x;
							_result_y2 += _value.y;
						break;
						
						default:
							_result_x1 -= _value;
							_result_y1 -= _value;
							_result_x2 += _value;
							_result_y2 += _value;
						break;
					}
					
					x1 = _result_x1;
					y1 = _result_y1;
					x2 = _result_x2;
					y2 = _result_y2;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "grow()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real|Vector2|Vector4}
			/// @description		Perform a calculation with the specified value by adding its
			///						respective values to the first set of values and substracting
			///						them from the second set.
			static shrink = function(_value)
			{
				try
				{
					var _result_x1 = x1;
					var _result_y1 = y1;
					var _result_x2 = x2;
					var _result_y2 = y2;
					
					switch (instanceof(_value))
					{
						case "Vector4":
							_result_x1 += _value.x1;
							_result_y1 += _value.y1;
							_result_x2 -= _value.x2;
							_result_y2 -= _value.y2;
						break;
						
						case "Vector2":
							_result_x1 += _value.x;
							_result_y1 += _value.y;
							_result_x2 -= _value.x;
							_result_y2 -= _value.y;
						break;
						
						default:
							_result_x1 += _value;
							_result_y1 += _value;
							_result_x2 -= _value;
							_result_y2 -= _value;
						break;
					}
					
					x1 = _result_x1;
					y1 = _result_y1;
					x2 = _result_x2;
					y2 = _result_y2;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "shrink()"], _exception);
				}
				
				return self;
			}
			
			/// @description		Swap the x and y values.
			static flip = function()
			{
				var _result_x1 = y1;
				var _result_y1 = x1;
				var _result_x2 = y2;
				var _result_y2 = x2;
				
				x1 = _result_x1;
				y1 = _result_y1;
				x2 = _result_x2;
				y2 = _result_y2;
				
				return self;
			}
			
			/// @description		Reverse the x and y values.
			static mirror = function()
			{
				try
				{
					var _result_x1 = (-x1);
					var _result_y1 = (-y1);
					var _result_x2 = (-x2);
					var _result_y2 = (-y2); 
					
					x1 = _result_x1;
					y1 = _result_y1;
					x2 = _result_x2;
					y2 = _result_y2;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "mirror()"], _exception);
				}
				
				return self;
			}
			
			/// @description		Reverse the x values.
			static mirrorX = function()
			{
				try
				{
					var _result_x1 = (-x1);
					var _result_x2 = (-x2);
					
					x1 = _result_x1;
					x2 = _result_x2;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "mirrorX()"], _exception);
				}
				
				return self;
			}
			
			/// @description		Reverse the y values.
			static mirrorY = function()
			{
				try
				{
					var _result_y1 = (-y1);
					var _result_y2 = (-y2);
					
					y1 = _result_y1;
					y2 = _result_y2;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "mirrorY()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			orderAscending {bool}
			/// @description		Sort the first and second set of values so each of them is higher
			///						than the other one, depending on the specified order.
			static sort = function(_orderAscending)
			{
				try
				{
					var _result_x1, _result_y1, _result_x2, _result_y2;
					
					switch (_orderAscending)
					{
						case false:
							_result_x1 = max(x1, x2);
							_result_y1 = max(y1, y2);
							_result_x2 = min(x1, x2);
							_result_y2 = min(y1, y2);
						break;
						
						case true:
							_result_x1 = min(x1, x2);
							_result_y1 = min(y1, y2);
							_result_x2 = max(x1, x2);
							_result_y2 = max(y1, y2);
						break;
					}
					
					x1 = _result_x1;
					y1 = _result_y1;
					x2 = _result_x2;
					y2 = _result_y2;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "sort()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			x1? {real}
			/// @argument			y1? {real}
			/// @argument			x2? {real}
			/// @argument			y2? {real}
			/// @description		Set each value of this Vector4.
			static set = function(_x1 = x1, _y1 = y1, _x2 = x2, _y2 = y2)
			{
				x1 = _x1;
				y1 = _y1;
				x2 = _x2;
				y2 = _y2;
			}
			
			/// @argument			value {real|Vector2|Vector4|Scale}
			/// @description		Set all of values to the ones of the specified value.
			static setAll = function(_value)
			{
				try
				{
					var _result_x1, _result_y1, _result_x2, _result_y2;
					
					if (is_real(_value))
					{
						_result_x1 = _value;
						_result_y1 = _value;
						_result_x2 = _value;
						_result_y2 = _value;
					}
					else if (instanceof(_value) == "Vector4")
					{
						_result_x1 = _value.x1;
						_result_y1 = _value.y1;
						_result_x2 = _value.x2;
						_result_y2 = _value.y2;
					}
					else
					{
						_result_x1 = _value.x;
						_result_y1 = _value.y;
						_result_x2 = _value.x;
						_result_y2 = _value.y;
					}
					
					x1 = _result_x1;
					y1 = _result_y1;
					x2 = _result_x2;
					y2 = _result_y2;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setAll()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value? {real|Vector2|Vector4|Scale}
			/// @description		Set all of the values of to their equivalents rounded down or the
			///						ones of the specified value.
			static setFloor = function(_value)
			{
				try
				{
					var _result_x1, _result_y1, _result_x2, _result_y2;
					
					if (_value == undefined)
					{
						_result_x1 = floor(x1);
						_result_y1 = floor(y1);
						_result_x2 = floor(x2);
						_result_y2 = floor(y2);
					}
					else if (is_real(_value))
					{
						var _value_floor = floor(_value);
						_result_x1 = _value_floor;
						_result_y1 = _value_floor;
						_result_x2 = _value_floor;
						_result_y2 = _value_floor;
					}
					else if (instanceof(_value) == "Vector4")
					{
						_result_x1 = floor(_value.x1);
						_result_y1 = floor(_value.y1);
						_result_x2 = floor(_value.x2);
						_result_y2 = floor(_value.y2);
					}
					else
					{
						var _value_x_floor = floor(_value.x);
						var _value_y_floor = floor(_value.y);
						_result_x1 = _value_x_floor;
						_result_y1 = _value_y_floor;
						_result_x2 = _value_x_floor;
						_result_y2 = _value_y_floor;
					}
					
					x1 = _result_x1;
					y1 = _result_y1;
					x2 = _result_x2;
					y2 = _result_y2;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setFloor()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value? {real|Vector2|Vector4|Scale}
			/// @description		Set all of the values of to their equivalents rounded down or up
			///						or the ones of the specified value.
			static setRound = function(_value)
			{
				try
				{
					var _result_x1, _result_y1, _result_x2, _result_y2;
					
					if (_value == undefined)
					{
						_result_x1 = round(x1);
						_result_y1 = round(y1);
						_result_x2 = round(x2);
						_result_y2 = round(y2);
					}
					else if (is_real(_value))
					{
						var _value_round = round(_value);
						_result_x1 = _value_round;
						_result_y1 = _value_round;
						_result_x2 = _value_round;
						_result_y2 = _value_round;
					}
					else if (instanceof(_value) == "Vector4")
					{
						_result_x1 = round(_value.x1);
						_result_y1 = round(_value.y1);
						_result_x2 = round(_value.x2);
						_result_y2 = round(_value.y2);
					}
					else
					{
						var _value_x_round = round(_value.x);
						var _value_y_round = round(_value.y);
						_result_x1 = _value_x_round;
						_result_y1 = _value_y_round;
						_result_x2 = _value_x_round;
						_result_y2 = _value_y_round;
					}
					
					x1 = _result_x1;
					y1 = _result_y1;
					x2 = _result_x2;
					y2 = _result_y2;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setRound()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value? {real|Vector2|Vector4|Scale}
			/// @description		Set all of the values of to their equivalents rounded up or the
			///						ones of the specified value.
			static setCeil = function(_value)
			{
				try
				{
					var _result_x1, _result_y1, _result_x2, _result_y2;
					
					if (_value == undefined)
					{
						_result_x1 = ceil(x1);
						_result_y1 = ceil(y1);
						_result_x2 = ceil(x2);
						_result_y2 = ceil(y2);
					}
					else if (is_real(_value))
					{
						var _value_ceil = ceil(_value);
						_result_x1 = _value_ceil;
						_result_y1 = _value_ceil;
						_result_x2 = _value_ceil;
						_result_y2 = _value_ceil;
					}
					else if (instanceof(_value) == "Vector4")
					{
						_result_x1 = ceil(_value.x1);
						_result_y1 = ceil(_value.y1);
						_result_x2 = ceil(_value.x2);
						_result_y2 = ceil(_value.y2);
					}
					else
					{
						var _value_x_ceil = ceil(_value.x);
						var _value_y_ceil = ceil(_value.y);
						_result_x1 = _value_x_ceil;
						_result_y1 = _value_y_ceil;
						_result_x2 = _value_x_ceil;
						_result_y2 = _value_y_ceil;
					}
					
					x1 = _result_x1;
					y1 = _result_y1;
					x2 = _result_x2;
					y2 = _result_y2;
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
					if (is_real(_device))
					{
						var _mouse_x = device_mouse_x(_device);
						var _mouse_y = device_mouse_y(_device);
						
						x1 = _mouse_x;
						y1 = _mouse_y;
						x2 = _mouse_x;
						y2 = _mouse_y;
					}
					else
					{
						x1 = mouse_x;
						y1 = mouse_y;
						x2 = mouse_x;
						y2 = mouse_y;
					}
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
			///						Content will be represented with the output of X and then Y
			///						values of this Vector4.
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
			
			/// @returns			{real[]}
			/// @description		Return an array containing all values of this Container.
			static toArray = function()
			{
				return [x1, y1, x2, y2];
			}
			
			/// @returns			{Vector2[]}
			/// @description		Return an array of two Vector2 with the values of this Vector4.
			static split = function()
			{
				return [new Vector2(x1, y1), new Vector2(x2, y2)];
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
			var _value = variable_struct_get(prototype, _name);
			
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
