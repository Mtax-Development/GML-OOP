/// @function				RangedValue()
/// @argument				{Range} range
/// @argument				{real} value?
///
/// @description			Construct a container for a value closed in the specified Range.
///
///							Construction methods:
///							- New constructor
///							   If the value if not specified, it will be set to the minimal value of
///							   the specified Range.
///							- Constructor copy: {Range} other
function RangedValue() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				if ((argument_count > 0) and (instanceof(argument[0]) == "RangedValue"))
				{
					//|Construction method: Constructor copy.
					var _other = argument[0];
					
					range = _other.range;
					value = _other.value;
					value_original = _other.value_original;
				}
				else
				{
					//|Construction method: New constructor.
					range = argument[0];
				
					var _value = ((argument_count > 1) and (argument[1] != undefined)) ?
								 argument[1] : range.minimum;
				
					value = clamp(_value, range.minimum, range.maximum);
					value_original = value;
				}
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{bool}
			// @description			Check whether the value is equal to the boundaries of the Range.
			static isBoundary = function()
			{
				return ((value == range.minimum) or (value == range.maximum));
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
			static set_minimum = function()
			{
				value = range.minimum;
			}
			
			// @description			Set the value to the maximum boundary of the Range.
			static set_maximum = function()
			{
				value = range.maximum;
			}
			
			// @description			Set the value to the state it had upon constructor creation.
			static set_original = function()
			{
				value = value_original;
			}
			
			// @returns				{real}
			// @description			Set the value the middle point of the Range.
			static set_middle = function()
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
			//						furthest boundary if it is outside or equal to the Range.
			//						If the Range is specified as inclusive for this operation,
			//						the value will not be wrapped if it would equal the Range.
			static add_wrap = function(_value, _inclusive)
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
			
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the Range and value information 
			//						in the following format: value, range.minimum-range.maximum.
			static toString = function()
			{
				return (instanceof(self) + "(" + string(value) + ", " + 
						string(range.minimum) + "-" + string(range.maximum) + ")");
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
		
		if (argument_count <= 0)
		{
			self.construct();
		}
		else
		{
			script_execute_ext(method_get_index(self.construct), argument_original);
		}
		
	#endregion
}
