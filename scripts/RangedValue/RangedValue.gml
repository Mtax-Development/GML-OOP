/// @function				RangedValue()
/// @argument				{Range} range
/// @argument				{real} value?
///							
/// @description			Construct a container for a value closed in the specified Range.
///							
///							Construction types:
///							- New constructor
///							   Unspecified value will be set to the minimum value of the Range.
///							- Empty: {void|undefined}
///							- Constructor copy: {Range} other
function RangedValue() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				range = undefined;
				value = undefined;
				value_original = undefined;
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (instanceof(argument[0]) == "RangedValue")
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						range = ((instanceof(_other.range) == "Range") ? new Range(_other.range)
																	   : _other.range);
						value = _other.value;
						value_original = _other.value_original;
					}
					else
					{
						//|Construction type: New constructor.
						range = argument[0];
						
						var _value = (((argument_count > 1) and (argument[1] != undefined))
									  ? argument[1] : range.minimum);
						value = clamp(_value, range.minimum, range.maximum);
						value_original = value;
					}
				}
				
				return self;
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(value)) and (instanceof(range) == "Range")
						and (range.isFunctional()));
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{bool}
			// @description			Check if the value is equal to the value of another Ranged Value.
			static equals = function(_other)
			{
				return (value == _other.value);
			}
			
			// @returns				{real}
			// @description			Return the percentage value representing the value inside of the
			//						Range as a numerical value in which one whole number is one full
			//						percentage.
			static percent = function()
			{
				return ((value - range.minimum) / (range.maximum - range.minimum));
			}
			
			// @returns				{bool}
			// @description			Check if the value is equal to either boundary of the Range.
			static isBoundary = function()
			{
				return ((value == range.minimum) or (value == range.maximum));
			}
			
			// @returns				{bool}
			// @description			Check if the value is equal to the minimum boundary of the Range.
			static isMinimum = function()
			{
				return ((value == range.minimum));
			}
			
			// @returns				{bool}
			// @description			Check if the value is equal to the maximum boundary of the Range.
			static isMaximum = function()
			{
				return ((value == range.maximum));
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{real} value
			// @description			Modify the value by the specified number.
			static modify = function(_value)
			{
				value = clamp((value + _value), range.minimum, range.maximum);
				
				return self;
			}
			
			// @argument			{real} value
			// @argument			{bool} inclusive?
			// @description			Modify the value by the specified number, then wrap it to the
			//						furthest boundary if it is outside of the Range. The value will
			//						also be wrapped if inclusive wrapping is specified and the value
			//						equals the Range.
			static modifyWrap = function(_value, _inclusive = false)
			{
				value += _value;
				
				var _rangeDifference = (range.maximum - range.minimum);
				
				value = (((((value - range.minimum) mod _rangeDifference) + _rangeDifference) 
						 mod _rangeDifference) + range.minimum);
				
				if (_inclusive)
				{
					var _value_sign = sign(_value);
					
					if (_value_sign > 0)
					{
						if (value == range.minimum)
						{
							value = range.maximum;
						}
					}
					else if (_value_sign < 0)
					{
						if (value == range.maximum)
						{
							value = range.minimum;
						}
					}
				}
				
				return self;
			}
			
			// @argument			{real} value
			// @description			Modify the value by the specified number, then continously bounce
			//						it back towards the Range if it would exceed its boundary.
			static modifyBounce = function(_value)
			{
				var _rangeDifference = abs(range.maximum - range.minimum);
				var _modulo = (_value mod (_rangeDifference * 2));
				
				if (_modulo > 0)
				{
					var _distance = abs(value - range.maximum);
					
					if (_modulo <= _distance)
					{
						value += _modulo;
					}
					else if ((_modulo > _distance) and (_modulo <= (_rangeDifference + _distance)))
					{
						value = (range.maximum - (_modulo - _distance));
					}
					else if (_modulo > (_rangeDifference + _distance))
					{
						value = (range.minimum + (_modulo - (_distance + _rangeDifference)));
					}
				}
				else if (_modulo < 0)
				{
					_modulo = abs(_modulo);
					
					var _distance = abs(value - range.minimum);
					
					if (_modulo <= _distance)
					{
						value -= _modulo;
					}
					else if ((_modulo > _distance) and (_modulo <= (_rangeDifference + _distance)))
					{
						value = (range.minimum + (_modulo - _distance));
					}
					else if (_modulo > (_rangeDifference + _distance))
					{
						value = (range.maximum - (_modulo - (_distance + _rangeDifference)));
					}
				}
				
				return self;
            }
			
			// @argument			{real} value
			// @returns				{real}
			// @description			Set the value to a position within the Range of the 
			//						specified precentage.
			static interpolate = function(_value)
			{
				value = clamp(lerp(range.minimum, range.maximum, _value),
							  range.minimum, range.maximum);
				
				return self;
			}
			
			// @argument			{real} value
			// @description			Set the value to specified number, clamped to the Range.
			static set = function(_value)
			{
				value = clamp(_value, range.minimum, range.maximum);
				
				return self;
			}
			
			// @description			Set the value to the minimum boundary of the Range.
			static setMinimum = function()
			{
				value = range.minimum;
				
				return self;
			}
			
			// @description			Set the value to the maximum boundary of the Range.
			static setMaximum = function()
			{
				value = range.maximum;
				
				return self;
			}
			
			// @description			Set the value to the state it had upon constructor creation.
			static setOriginal = function()
			{
				value = value_original;
				
				return self;
			}
			
			// @returns				{real}
			// @description			Set the value the middle point of the Range.
			static setMiddle = function()
			{
				value = lerp(range.minimum, range.maximum, 0.5);
				
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
				if (self.isFunctional())
				{
					var _mark_separator = ((_multiline) ? "\n" : ", ");
					var _mark_separator_inline = " - ";
				
					var _string = (string(value) + _mark_separator + string(range.minimum) +
								   _mark_separator_inline + string(range.maximum));
				
					return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
				}
				else
				{
					return (instanceof(self) + "<>");
				}
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

