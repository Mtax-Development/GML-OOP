/// @function				RangedValue()
/// @argument				{Range} range
/// @argument				{real} value?
///
/// @description			Construct a container for a value closed in the specified Range.
function RangedValue() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function(_range)
			{
				range = _range;
				
				var _value = ((argument_count > 1) and (argument[1] != undefined)) ?
							 argument[1] : range.minimum;
				
				value = clamp(_value, range.minimum, range.maximum);
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
			
			// @description			Set the value to its initial value.
			static set_original = function()
			{
				value = argument_original[0];
			}
			
			// @returns				{real}
			// @description			Set the value the middle point of the Range.
			static set_middle = function()
			{
				value = lerp(range.minimum, range.maximum, 0.5);
			}
			
			// @argument			{real} value
			// @description			Add the specified value to the value.
			static add = function(_value)
			{
				value = clamp((value + _value), range.minimum, range.maximum);
			}
			
			//+TODO: add_loop()
			
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
			// @description			Create a string representing the constructor.
			//						Overrides the string() conversion.
			static toString = function()
			{
				return (instanceof(self) + "(" + string(value) + ", " + 
						string(range.minimum) + "-" + string(range.maximum) + ")");
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		argument_original = array_create(2, undefined)
		
		var _i = 0;
		
		repeat (argument_count)
		{
			argument_original[_i] = argument[_i];
			
			++_i;
		}
		
		self.construct(argument_original[0], argument_original[1]);
		
	#endregion
}