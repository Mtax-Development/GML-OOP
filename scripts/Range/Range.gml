/// @function				Range()
/// @argument				{real} minimum
/// @argument				{real} maximum
///
/// @description			Construct a container for two-value numeric Range with different numbers.
///
///							Construction methods:
///							- New constructor
///							- Constructor copy: {Range} other
function Range() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				if ((argument_count > 0) and (instanceof(argument[0]) == "Range"))
				{
					//|Construction method: Constructor copy.
					var _other = argument[0];
					
					minimum = _other.minimum;
					maximum = _other.maximum;
				}
				else
				{
					//|Construction method: New constructor.
					minimum = argument[0];
					maximum = argument[1];
				}
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
			
			// @returns				{real}
			// @description			Return the middle point of this Range.
			static middle = function()
			{
				return lerp(minimum, maximum, 0.5);
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
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the Range information in the
			//						following format: minimum-maximum.
			static toString = function()
			{
				return (instanceof(self) + "(" + string(minimum) + "-" + string(maximum) + ")");
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
