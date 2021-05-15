/// @function				RangedValue()
/// @argument				{Range} range
/// @argument				{real} value?
///							
/// @description			Construct a container for a value closed in the specified Range.
///							
///							Construction methods:
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
				//|Construction method: Empty.
				range = undefined;
				value = undefined;
				value_original = undefined;
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (instanceof(argument[0]) == "RangedValue")
					{
						//|Construction method: Constructor copy.
						var _other = argument[0];
						
						range = ((instanceof(_other.range) == "Range") ? new Range(_other.range)
																	   : _other.range);
						value = _other.value;
						value_original = _other.value_original;
					}
					else
					{
						//|Construction method: New constructor.
						range = argument[0];
						
						var _value = (((argument_count > 1) and (argument[1] != undefined))
									  ? argument[1] : range.minimum);
						
						value = clamp(_value, range.minimum, range.maximum);
						value_original = value;
					}
				}
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
			// @description			Check if the value is equal to the boundaries of the Range.
			static isBoundary = function()
			{
				return ((value == range.minimum) or (value == range.maximum));
			}
			
			// @returns				{bool}
			// @description			Check if the value is equal to the value of another Ranged Value.
			static equals = function(_other)
			{
				return (value == _other.value);
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{real} value
			// @description			Set the value to specified number, clamped to the Range.
			static set = function(_value)
			{
				value = clamp(_value, range.minimum, range.maximum);
			}
			
			// @description			Set the value to the minimum boundary of the Range.
			static setMinimum = function()
			{
				value = range.minimum;
			}
			
			// @description			Set the value to the maximum boundary of the Range.
			static setMaximum = function()
			{
				value = range.maximum;
			}
			
			// @description			Set the value to the state it had upon constructor creation.
			static setOriginal = function()
			{
				value = value_original;
			}
			
			// @returns				{real}
			// @description			Set the value the middle point of the Range.
			static setMiddle = function()
			{
				value = lerp(range.minimum, range.maximum, 0.5);
			}
			
			// @argument			{real} value
			// @description			Add the specified number to the value.
			static add = function(_value)
			{
				value = clamp((value + _value), range.minimum, range.maximum);
			}
			
			// @argument			{real} value
			// @argument			{bool} inclusive?
			// @description			Add the specified number to the value, then wrap it to the
			//						furthest boundary if it is outside of the Range. The value will
			//						also be wrapped if inclusive wrapping is specified and the value
			//						equals the Range.
			static addWrap = function(_value, _inclusive)
			{
				value += _value;
				
				var _rangeDifference = (range.maximum - range.minimum);
				
				value = ((((value - range.minimum) mod _rangeDifference) + _rangeDifference) 
						 mod _rangeDifference + range.minimum);
				
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
			}
			
			// @argument			{real} value
			// @returns				{real}
			// @description			Set the value to a position within the Range of the 
			//						specified precentage.
			static interpolate = function(_value)
			{
				value = clamp(lerp(range.minimum, range.maximum, _value),
							  range.minimum, range.maximum);
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the values of this Container.
			static toString = function(_multiline)
			{
				if (self.isFunctional())
				{
					var _mark_separator = ((_multiline) ? "\n" : ", ");
					var _mark_separator_inline = "-";
				
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
