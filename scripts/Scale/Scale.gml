/// @function				Scale()
/// @argument				{real} x?
/// @argument				{real} y?
///							
/// @description			Constructs a Scale container that can be used for drawing or
///							manipulated in other ways.
///							
///							Construction types:
///							- Two values: {real} x, {real} y
///							- One number for all values: {real} value
///							- Default for all values: {void|undefined}
///							- From array: {real[]} array
///							   Array positions will be applied depending on its size:
///								1: array[0] will be set to x and y.
///								2+: array[0] will be set to x, array[1] will be set to y.
///							- From Vector2: {Vector2} other
///							- Constructor copy: {Scale} other
function Scale() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
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
										
										switch ( array_length(_array))
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
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(x)) and (is_real(y)) and (!is_nan(x)) and (!is_nan(y)));
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{any} value...
			// @returns				{bool}
			// @description			Check if this Scale contains at least one of the specified values.
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
			
			// @argument			{Scale} other
			// @returns				{bool}
			// @description			Check if this and the specified Scale have the same values.
			static equals = function(_other)
			{
				return ((x == _other.x) and (y == _other.y));
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
			
			// @argument			{Scale} target
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
			
			// @argument			{real|Scale} value
			// @description			Perform a calculation with the specified value by adding it to
			//						respective values with the same sign as the values of this Scale.
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
			
			// @argument			{real|Scale} value
			// @description			Perform a calculation with the specified value by substracting it
			//						from its respective values with the same sign as the values of
			//						this Scale.
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
			
			// @description			Reverse the x and y values.
			static mirror = function()
			{
				x = (-x);
				y = (-y);
				
				return self;
			}
			
			// @description			Reverse the x value.
			static mirrorX = function()
			{
				x = (-x);
				
				return self;
			}

			// @description			Reverse the y value.
			static mirrorY = function()
			{
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

