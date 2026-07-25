//  @function			Vector2()
/// @argument			x? {real}
/// @argument			y? {real}
/// @description		Constructs a Container for x and y coordinate pair.
//						
//						Construction types:
//						- Two numbers: x {real}, y {real}
//						- One number for all values: value {real}
//						- From array: array {real[]}
//						   Array positions will be applied depending on its size:
//						   1: array[0] will be set to x and y.
//						   2+: array[0] will be set to x, array[1] will be set to y.
//						- From Scale: scale {Scale}
//						- Empty: {void|undefined}
//						- Constructor copy: other {Vector2}
function Vector2() constructor
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
		
		if (argument_count > 0)
		{
			if (is_instanceof(argument[0], Vector2))
			{
				//|Construction type: Constructor copy.
				var _other = argument[0];
				x = _other.x;
				y = _other.y;
			}
			else if (is_instanceof(argument[0], Scale))
			{
				//|Construction type: From Scale.
				var _scale = argument[0];
				x = _scale.x;
				y = _scale.y;
			}
			else
			{
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
			}
		}
		
		return self;
	}
	
	/// @returns			{bool}
	/// @description		Check if this constructor is functional.
	static isFunctional = function()
	{
		return ((is_real(x)) and (is_real(y)) and (!is_nan(x)) and (!is_nan(y)) and
				(!is_infinity(x)) and (!is_infinity(y)));
	}
	
  #endregion
   #region <Getters>
	
	/// @argument			value... {any}
	/// @returns			{bool}
	/// @description		Check if this Vector2 contains at least one of the specified values.
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
	
	/// @argument			value {real|Scale|Vector2|Vector4|[]}
	/// @returns			{bool}
	/// @description		Check if all values of this constructor are the same as the specified
	///						number or respective values of the specified Scale, Vector2 or Vector4.
	///						Those values can be specified in an array to check if any of them matches
	///						all of its values with the ones of this constructor.
	static equals = function(_value)
	{
		if ((is_instanceof(_value, Vector2)) or (is_instanceof(_value, Scale)))
		{
			return ((x == _value.x) and (y == _value.y));
		}
		else if (is_real(_value))
		{
			return ((x == _value) and (y == _value));
		}
		else if (is_instanceof(_value, Vector4))
		{
			return ((x == _value.x1) and (y == _value.y1) and (x == _value.x2) and (y == _value.y2));
		}
		else if (is_array(_value))
		{
			var _i = 0;
			repeat (array_length(_value))
			{
				if (self.equals(_value[_i]))
				{
					return true;
				}
				
				++_i;
			}
		}
		
		return false;
	}
	
	/// @argument			value {real|Vector2}
	/// @returns			{bool}
	/// @description		Check if all values of this Vector2 are higher than the specified value or
	///						respective values of the specified Vector2.
	static exceeds = function(_value)
	{
		try
		{
			if (is_real(_value))
			{
				return ((x > _value) and (y > _value));
			}
			else
			{
				return ((x > _value.x) and (y > _value.y));
			}
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "exceeds()"], _exception);
		}
		
		return false;
	}
	
	/// @argument			value {real|Vector2}
	/// @returns			{bool}
	/// @description		Check if all values of this Vector2 are lower than the specified value or
	///						respective values of the specified Vector2.
	static subceeds = function(_value)
	{
		try
		{
			if (is_real(_value))
			{
				return ((x < _value) and (y < _value));
			}
			else
			{
				return ((x < _value.x) and (y < _value.y));
			}
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "subceeds()"], _exception);
		}
		
		return false;
	}
	
	/// @argument			value? {real|Vector2}
	/// @returns			{real|Vector2} | On error: {undefined}
	/// @description		Return the result of respectively adding the values of this
	///						Vector2 to the specified value or its own properties if the value is not
	///						specified.
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
			ErrorReport.report([other, self, "sum()"], _exception);
		}
		
		return undefined;
	}
	
	/// @argument			value {real|Vector2|Vector4}
	/// @returns			{Vector2|Vector4} | On error: {undefined}
	/// @description		Return the result of substracting the specified value from the values of
	///						this Vector2. The result will be returned in a Vector2, unless the
	///						specified value was a Vector4, in which case it will be returned in a
	///						Vector4.
	static difference = function(_value)
	{
		try
		{
			if (is_real(_value))
			{
				return new Vector2((x - _value), (y - _value));
			}
			else if (is_instanceof(_value, Vector4))
			{
				return new Vector4((x - _value.x1), (y - _value.y1), (x - _value.x2),
								   (y - _value.y2));
			}
			else
			{
				return new Vector2((x - _value.x), (y - _value.y));
			}
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "difference()"], _exception);
		}
		
		return undefined;
	}
	
	/// @argument			value? {real|Vector2|Vector4}
	/// @returns			{Vector2|Vector4} | On error: {undefined}
	/// @description		Return the difference using values of this Vector2. If a value was
	///						specified, a constructor with the differences between their respective
	///						values will be returned, either as a Vector4 if specified as such or as a
	///						Vector2 otherwise. If a value was not specified, a number representing the
	///						difference between values of this Vector2 will be returned. This
	///						calculation ignores order of substraction, always returning a non-negative
	///						number.
	static absoluteDifference = function(_value)
	{
		try
		{
			if (_value != undefined)
			{
				if (is_real(_value))
				{
					return new Vector2(abs(x - _value), abs(y - _value));
				}
				else if (is_instanceof(_value, Vector4))
				{
					return new Vector4(abs(x1 - _value.x1), abs(y1 - _value.y1), abs(x2 - _value.x2),
									   abs(y2 - _value.y2));
				}
				else
				{
					return new Vector2(abs(x - _value.x), abs(y - _value.y));
				}
			}
			else
			{
				return abs(x - y);
			}
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "absoluteDifference()"], _exception);
		}
		
		return undefined;
	}
	
	/// @argument			value? {real|Vector2}
	/// @returns			{real|Vector2} | On error: {undefined}
	/// @description		Return the result of respectively multiplying the values of this Vector2
	///						by the specified value or its own properties if the value is not
	///						specified.
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
			ErrorReport.report([other, self, "product()"], _exception);
		}
		
		return undefined;
	}
	
	/// @argument			value {real|Vector2}
	/// @returns			{Vector2} | On error: {undefined}
	/// @description		Return the result of respectively dividing the values of this Vector2 by
	///						the specified value, ignoring divison by 0.
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
			ErrorReport.report([other, self, "quotient()"], _exception);
		}
		
		return undefined;
	}
	
	/// @argument			other {Vector2}
	/// @argument			normalize? {bool}
	/// @returns			{real} | On error: {undefined}
	/// @description		Return the sum of each value of this and other Vector2 being multiplied by
	///						their respective other value, which is an expression of the angular
	///						reliationship between its two points. The returned value can be
	///						normalized, which will place it between -1 and 1.
	static dotProduct = function(_other, _normalize = false)
	{
		try
		{
			return ((_normalize) ? dot_product_normalized(x, y, _other.x, _other.y)
								 : dot_product(x, y, _other.x, _other.y));
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "dotProduct()"], _exception);
		}
		
		return undefined;
	}
	
	/// @argument			other {Vector2}
	/// @returns			{real} | On error: {undefined}
	/// @description		Return the difference between values of this Vector2 multiplied by values
	///						of different axes of the specified Vector2.
	static crossProduct = function(_other)
	{
		try
		{
			return ((x * _other.y) - (y * _other.x));
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "crossProduct()"], _exception);
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
			ErrorReport.report([other, self, "getAngle()"], _exception);
		}
		
		return undefined;
	}
	
	/// @argument			other {Vector2}
	/// @returns			{real}
	/// @description		Return the shortest distance between this and the specified Vector2.
	static getDistance = function(_other)
	{
		try
		{
			return point_distance(x, y, _other.x, _other.y);
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "getDistance()"], _exception);
		}
		
		return undefined;
	}
	
	/// @returns			{real} | On error: {undefined}
	/// @description		Return the lowest of both values.
	static getMinimum = function()
	{
		try
		{
			return min(x, y);
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "getMinimum()"], _exception);
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
			ErrorReport.report([other, self, "getMaximum()"], _exception);
		}
		
		return undefined;
	}
	
	/// @returns			{real}
	/// @description		Return vector length of this Vector2.
	static getMagnitude = function()
	{
		try
		{
			var _power = ((x * x) + (y * y));
			
			return ((_power != 0) ? sqrt(_power) : _power);
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "getMagnitude()"], _exception);
		}
		
		return 0;
	}
	
	/// @argument			magnitude? {real}
	/// @returns			{Vector2}
	/// @description		Return the unit vector of this Vector2, which will have its values placed
	///						between -1 and 1, but with the same direction. These values are then
	///						multiplied by the specified magnitude.
	///						If this operation would be invalid, a directionless vector will be
	///						returned.
	static getNormalized = function(_magnitude = 1)
	{
		try
		{
			var _x = x;
			var _y = y;
			var _power = ((_x * _x) + (_y * _y));
			
			if (_power != 0)
			{
				var _length = sqrt(_power);
				_x = ((_x / _length) * _magnitude);
				_y = ((_y / _length) * _magnitude);
				
				return new Vector2(_x, _y);
			}
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "getNormalized()"], _exception);
		}
		
		return new Vector2(0, 0);
	}
	
	/// @argument			booleanSign? {bool}
	/// @returns			{Vector2} | On error: {undefined}
	/// @description		Return a Vector2 with each respective value representing the sign of the
	///						number: -1 for a negative number, 0 for itself and 1 for a positive
	///						number. If the result is specified to be returned as the boolean sign, -1
	///						will be set for 0 as well.
	static getSign = function(_booleanSign = false)
	{
		try
		{
			if (_booleanSign)
			{
				return new Vector2(((x > 0) ? 1 : (-1)), ((y > 0) ? 1 : (-1)));
			}
			else
			{
				return new Vector2(sign(x), sign(y));
			}
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "getSign()"], _exception);
		}
		
		return undefined;
	}
	
   #endregion
   #region <Setters>
	
	/// @argument			value {real|Vector2}
	/// @description		Add the specified value to respective values of this Vector2.
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
			ErrorReport.report([other, self, "add()"], _exception);
		}
		
		return self;
	}
	
	/// @argument			value {real|Vector2}
	/// @description		Substract the specified value from the respective values of this Vector2.
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
			ErrorReport.report([other, self, "substract()"], _exception);
		}
		
		return self;
	}
	
	/// @argument			value {real|Vector2}
	/// @description		Multiply the specified value by respective values of this Vector2.
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
			ErrorReport.report([other, self, "multiply()"], _exception);
		}
		
		return self;
	}
	
	/// @argument			value {real|Vector2}
	/// @description		Divide respective values of this Vector2 by the specified value, ignoring
	///						division by 0.
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
			ErrorReport.report([other, self, "divide()"], _exception);
		}
		
		return self;
	}
	
	/// @argument			target {real|Vector2}
	/// @argument			rate {real|Vector2}
	/// @description		Move the x and y values towards the specified target with the specified 
	///						without exceeding it.
	static approach = function(_target, _rate)
	{
		try
		{
			var _value_array = [x, y];
			var _target_array = ((is_real(_target)) ? array_create(2, _target)
													: [_target.x, _target.y]);
			var _rate_array = ((is_real(_rate)) ? array_create(2, abs(_rate))
												: [abs(_rate.x), abs(_rate.y)]);
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
			ErrorReport.report([other, self, "approach()"], _exception);
		}
		
		return self;
	}
	
	/// @argument			value {real|Vector2}
	/// @description		Perform a calculation with the specified value by adding to its respective
	///						values with the same sign as the values of this Vector2.
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
			ErrorReport.report([other, self, "grow()"], _exception);
		}
		
		return self;
	}
	
	/// @argument			value {real|Vector2}
	/// @description		Perform a calculation with the specified value by substracting it from its
	///						respective values with the same sign as the values of this Vector2.
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
			ErrorReport.report([other, self, "shrink()"], _exception);
		}
		
		return self;
	}
	
	/// @argument			boundary {Vector4}
	/// @description		Restrict the values of this Vector2 to the boundaries of the specified
	///						Vector4.
	static clamp = function(_boundary)
	{
		try
		{
			var _result_x = x;
			var _result_y = y;
			
			_result_x = clamp(x, min(_boundary.x1, _boundary.x2), max(_boundary.x1, _boundary.x2));
			_result_y = clamp(y, min(_boundary.y1, _boundary.y2), max(_boundary.y1, _boundary.y2));
			
			x = _result_x;
			y = _result_y;
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "clamp()"], _exception);
		}
		
		return self;
	}
	
	/// @argument			value... {real|Vector2}
	/// @description		Set both values to the lowest value among the values of this Vector2, a
	///						specified number or respective values of specified Vector2.
	static setMinimum = function()
	{
		try
		{
			var _result_x = x;
			var _result_y = y;
			var _i = 0;
			repeat (argument_count)
			{
				var _value_current = argument[_i];
				
				if (is_real(_value_current))
				{
					_result_x = min(_result_x, _value_current);
					_result_y = min(_result_y, _value_current);
				}
				else if (is_instanceof(_value_current, Vector2))
				{
					_result_x = min(_result_x, _value_current.x);
					_result_y = min(_result_y, _value_current.y);
				}
				
				++_i;
			}
			
			x = _result_x;
			y = _result_y;
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "setMinimum()"], _exception);
		}
		
		return self;
	}
	
	/// @argument			value... {real|Vector2}
	/// @description		Set both values to the highest value among the values of this Vector2, a
	///						specified number or respective values of specified Vector2.
	static setMaximum = function()
	{
		try
		{
			var _result_x = x;
			var _result_y = y;
			var _i = 0;
			repeat (argument_count)
			{
				var _value_current = argument[_i];
				
				if (is_real(_value_current))
				{
					_result_x = max(_result_x, _value_current);
					_result_y = max(_result_y, _value_current);
				}
				else if (is_instanceof(_value_current, Vector2))
				{
					_result_x = max(_result_x, _value_current.x);
					_result_y = max(_result_y, _value_current.y);
				}
				
				++_i;
			}
			
			x = _result_x;
			y = _result_y;
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "setMaximum()"], _exception);
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
			ErrorReport.report([other, self, "mirror()"], _exception);
		}
		
		return self;
	}
	
	/// @argument			x? {real}
	/// @argument			y? {real}
	/// @description		Set each value of this Vector2.
	static set = function(_x = x, _y = y)
	{
		x = _x;
		y = _y;
		
		return self;
	}
	
	/// @argument			value {real|real[]|Scale|Vector2}
	/// @description		Set all of the values to one specified value or first two values of the
	///						specified array.
	static setAll = function(_value)
	{
		try
		{
			var _result_x = x;
			var _result_y = y;
			
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
			ErrorReport.report([other, self, "setAll()"], _exception);
		}
		
		return self;
	}
	
	/// @argument			value1? {real|real[]|Scale|Vector2}
	/// @argument			value2? {real}
	/// @description		Set all values to equivalent integers after rounding them down.
	///						The numbers used are based on what arguments are provided:
	///						- None: Current constructor properties will be rounded.
	///						- A single number: Will be used for both values.
	///						- A single array: First two positions will be used for x and y
	///										  values, respectively.
	///						- A single constructor: Respective properties will be used.
	///						- Two numbers: Will be used for x and y values, respectively.
	static setFloor = function(_value1, _value2)
	{
		try
		{
			var _result_x = x;
			var _result_y = y;
			
			if (is_real(_value2))
			{
				_result_x = floor(_value1);
				_result_y = floor(_value2);
			}
			else if (_value1 == undefined)
			{
				_result_x = floor(x);
				_result_y = floor(y);
			}
			else if (is_real(_value1))
			{
				_result_x = floor(_value1);
				_result_y = _result_x;
			}
			else if (is_array(_value1))
			{
				_result_x = floor(_value1[0]);
				_result_y = floor(_value1[1]);
			}
			else
			{
				_result_x = floor(_value1.x);
				_result_y = floor(_value1.y);
			}
			
			x = _result_x;
			y = _result_y;
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "setFloor()"], _exception);
		}
		
		return self;
	}
	
	/// @argument			value1? {real|real[]|Scale|Vector2}
	/// @argument			value2? {real}
	/// @description		Set all values to equivalent closest integers. Numbers that are exactly
	///						half-integers will be rounded to closest even integer.
	///						The numbers used are based on what arguments are provided:
	///						- None: Current constructor properties will be rounded.
	///						- A single number: Will be used for both values.
	///						- A single array: First two positions will be used for x and y
	///										  values, respectively.
	///						- A single constructor: Respective properties will be used.
	///						- Two numbers: Will be used for x and y values, respectively.
	static setRound = function(_value1, _value2)
	{
		try
		{
			var _result_x = x;
			var _result_y = y;
			
			if (is_real(_value2))
			{
				_result_x = round(_value1);
				_result_y = round(_value2);
			}
			else if (_value1 == undefined)
			{
				_result_x = round(x);
				_result_y = round(y);
			}
			else if (is_real(_value1))
			{
				_result_x = round(_value1);
				_result_y = _result_x;
			}
			else if (is_array(_value1))
			{
				_result_x = round(_value1[0]);
				_result_y = round(_value1[1]);
			}
			else
			{
				_result_x = round(_value1.x);
				_result_y = round(_value1.y);
			}
			
			x = _result_x;
			y = _result_y;
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "setRound()"], _exception);
		}
		
		return self;
	}
	
	/// @argument			value1? {real|real[]|Scale|Vector2}
	/// @argument			value2? {real}
	/// @description		Set all values to equivalent integers after rounding them up.
	///						The numbers used are based on what arguments are provided:
	///						- None: Current constructor properties will be rounded.
	///						- A single number: Will be used for both values.
	///						- A single array: First two positions will be used for x and y
	///										  values, respectively.
	///						- A single constructor: Respective properties will be used.
	///						- Two numbers: Will be used for x and y values, respectively.
	static setCeil = function(_value1, _value2)
	{
		try
		{
			var _result_x = x;
			var _result_y = y;
			
			if (is_real(_value2))
			{
				_result_x = ceil(_value1);
				_result_y = ceil(_value2);
			}
			else if (_value1 == undefined)
			{
				_result_x = ceil(x);
				_result_y = ceil(y);
			}
			else if (is_real(_value1))
			{
				_result_x = ceil(_value1);
				_result_y = _result_x;
			}
			else if (is_array(_value1))
			{
				_result_x = ceil(_value1[0]);
				_result_y = ceil(_value1[1]);
			}
			else
			{
				_result_x = ceil(_value1.x);
				_result_y = ceil(_value1.y);
			}
			
			x = _result_x;
			y = _result_y;
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "setCeil()"], _exception);
		}
		
		return self;
	}
	
	/// @argument			device? {int}
	/// @argument			GUI? {bool}
	//  @see				display_set_gui_size()
	/// @description		Set all of the values to the ones of the system cursor. A target device
	///						can be specified for cases where multiple cursor inputs are used, and if
	///						it is specified, the position can then be translated to the GUI layer to
	///						depend on its size.
	static setCursor = function(_device, _GUI = false)
	{
		try
		{
			var _cursor_x, _cursor_y;
			
			if (_device == undefined)
			{
				_cursor_x = mouse_x;
				_cursor_y = mouse_y;
			}
			else
			{
				if (_GUI)
				{
					_cursor_x = device_mouse_x_to_gui(_device);
					_cursor_y = device_mouse_y_to_gui(_device);
				}
				else
				{
					_cursor_x = device_mouse_x(_device);
					_cursor_y = device_mouse_y(_device);
				}
			}
			
			x = _cursor_x;
			y = _cursor_y;
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "setCursor()"], _exception);
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
	
	static constructor = Vector2;
	
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
  #region [Static Constructions]
	
	static zero = new Vector2(0, 0);
	static one = new Vector2(1, 1);
	static negative = new Vector2((-1), (-1));
	static left = new Vector2((-1), 0);
	static right = new Vector2(1, 0);
	static up = new Vector2(0, (-1));
	static down = new Vector2(0, 1);
	
  #endregion
}

new Vector2();
