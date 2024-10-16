//  @function				Scale()
/// @argument				x? {real}
/// @argument				y? {real}
/// @description			Constructs a Scale container that can be used for drawing or manipulated in
///							other ways.
//							
//							Construction types:
//							- Two values: x {real}, y {real}
//							- One number for all values: value {real}
//							- Default for all values: {void|undefined}
//							- From array: array {real[]}
//							   Array positions will be applied depending on its size:
//								1: array[0] will be set to x and y.
//								2+: array[0] will be set to x, array[1] will be set to y.
//							- From Vector2: other {Vector2}
//							- Constructor copy: other {Scale}
function Scale() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Default for all values.
				x = 1;
				y = 1;
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					switch (instanceof(argument[0]))
					{
						case "Scale":
						case "Vector2":
							//|Construction type: Constructor copy.
							//|Construction type: From Vector2.
							var _other = argument[0];
							x = _other.x;
							y = _other.y;
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
									//|Construction type: Two values.
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
				return ((is_real(x)) and (is_real(y)) and (!is_nan(x)) and (!is_nan(y)));
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			value... {real}
			/// @returns			{bool}
			/// @description		Check if this Scale contains at least one of the specified values.
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
			
			/// @argument			value {real|Scale|Vector2|Vector4}
			/// @returns			{bool}
			/// @description		Check if all values of this constructor are the same as the
			///						specified number or respective values of the specified Scale,
			///						Vector2 or Vector4.
			static equals = function(_value)
			{
				if ((is_instanceof(_value, Scale)) or (is_instanceof(_value, Vector2)))
				{
					return ((x == _value.x) and (y == _value.y));
				}
				else if (is_real(_value))
				{
					return ((x == _value) and (y == _value));
				}
				else if (is_instanceof(_value, Vector4))
				{
					return ((x == _value.x1) and (y == _value.y1) and (x == _value.x2) and
							(y == _value.y2));
				}
				
				return false;
			}
			
			/// @returns			{real} | On error: {undefined}
			/// @description		Return the lowest of all values.
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
			
			/// @returns			{real}
			/// @description		Return the highest of all values.
			static getMaximum = function()
			{
				try
				{
					return max(x, y);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getMaximum()"], _exception);
				}
				
				return undefined;
			}
			
		#endregion
		#region <Setters>
			
			/// @argument			value {real|Scale}
			/// @description		Add to the values of this Scale the specified value or values of
			///						other specified Scale.
			static add = function(_value)
			{
				try
				{
					var _result_x = x;
					var _result_y = y;
					
					if (is_real(_value))
					{
						_result_x += _value;
						_result_y += _value;
					}
					else
					{
						_result_x += _value.x;
						_result_y += _value.y;
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
			
			/// @argument			value {real|Scale}
			/// @description		Substract from the values of this Scale the specified value or
			///						values of other specified Scale.
			static substract = function(_value)
			{
				try
				{
					var _result_x = x;
					var _result_y = y;
					
					if (is_real(_value))
					{
						_result_x -= _value;
						_result_y -= _value;
					}
					else
					{
						_result_x -= _value.x;
						_result_y -= _value.y;
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
			
			/// @argument			value {real|Scale}
			/// @description		Multiply the values of this Scale by specified value or values
			///						of other specified Scale.
			static multiply = function(_value)
			{
				try
				{
					var _result_x = x;
					var _result_y = y;
					
					if (is_real(_value))
					{
						_result_x *= _value;
						_result_y *= _value;
					}
					else
					{
						_result_x *= _value.x;
						_result_y *= _value.y;
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
			
			/// @argument			value {real|Scale}
			/// @description		Divide the values of this Scale by specified value or values of
			///						other specified Scale. Attempts of division by 0 are ignored.
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
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "divide()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			target {Scale}
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
			
			/// @argument			value {real|Scale}
			/// @description		Perform a calculation with the specified value by adding it to
			///						respective values with the same sign as the values of this Scale.
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
			
			/// @argument			value {real|Scale}
			/// @description		Perform a calculation with the specified value by substracting it
			///						from its respective values with the same sign as the values of this
			///						Scale.
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
			
			/// @description		Reverse the x value.
			static mirrorX = function()
			{
				try
				{
					x = (-x);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "mirrorX()"], _exception);
				}
				
				return self;
			}

			/// @description		Reverse the y value.
			static mirrorY = function()
			{
				try
				{
					y = (-y);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "mirrorY()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			x? {real}
			/// @argument			y? {real}
			/// @description		Set each value of this Scale.
			static set = function(_x = x, _y = y)
			{
				x = _x;
				y = _y;
				
				return self;
			}
			
			/// @argument			value {real|real[]|Scale|Vector2}
			/// @description		Set all of the values to one specified value or first two values of
			///						the specified array.
			static setAll = function(_value)
			{
				try
				{
					var _result_x, _result_y;
					
					if (is_real(_value))
					{
						_result_x = _value;
						_result_y = _value;
					}
					else if (is_array(_value))
					{
						_result_x = _value[0];
						_result_y = _value[1];
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
		
		static constructor = Scale;
		
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
