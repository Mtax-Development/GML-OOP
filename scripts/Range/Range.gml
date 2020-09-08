/// @function				Range()
/// @argument				{real} minimum
/// @argument				{real} maximum
///
/// @description			Construct a container for two-value numeric Range with different numbers.
function Range(_minimum, _maximum) constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function(_minimum, _maximum)
			{
				minimum = _minimum;
				maximum = _maximum;
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{real} number
			// @returns				{bool}
			// @description			Check whether a number is in or equal to borders of this Range.
			static isBetween = function(_value)
			{
				return (_value == clamp(_value, minimum, maximum));
			}
			
			// @argument			{real} number
			// @returns				{bool}
			// @description			Check whether a number is equal to the boundaries of this Range.
			static isBoundary = function(_value)
			{
				return ((_value == minimum) or (_value == maximum));
			}
			
		#endregion
		#region <Execution>
		
			// @returns				{real}
			// @description			Return a random real number from this Range.
			static random_real = function()
			{
				return random_range(minimum, maximum);
			}
			
			// @returns				{int}
			// @description			Return a random integer number from this Range.
			static random_int = function()
			{
				return irandom_range(minimum, maximum);
			}
			
			// @argument			{real} value
			// @returns				{real}
			// @description			Clamp the specified number to boundaries of this Range.
			static clampTo = function(_value)
			{
				return clamp(_value, minimum, maximum);
			}
			
			// @argument			{real} value
			// @returns				{real}
			// @description			Return the value at the position within this Range of the 
			//						specified precentage.
			static interpolate = function(_value)
			{
				return lerp(minimum, maximum, _value);
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Overrides the string conversion with a simple value output.
			static toString = function()
			{
				return (instanceof(self) + "(" + string(minimum) + "-" + string(maximum) + ")");
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		argument_original = [argument[0], argument[1]];
		
		self.construct(argument_original[0], argument_original[1]);
		
	#endregion
}
