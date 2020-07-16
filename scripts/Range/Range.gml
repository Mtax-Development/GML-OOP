/// @function				Range()
/// @argument				{real} minimum
/// @argument				{real} maximum
///
/// @description			Construct a container for two-value numeric Range with different numbers.
function Range(_minimum, _maximum) constructor
{
	#region [Methods]
		#region <Operations>
			
			// @returns				{real}
			// @description			Return a random real number from the range.
			static random_real = function()
			{
				return random_range(minimum, maximum);
			}
			
			// @returns				{int}
			// @description			Return a random integer number from the range.
			static random_int = function()
			{
				return irandom_range(minimum, maximum);
			}
			
		#endregion
		#region <Asserts>
			
			// @argument			{real} number
			// @description			Check whether a number is between or equal to the range.
			static isBetween = function(_number)
			{
				return (_number == clamp(_number, minimum, maximum));
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Overrides the string conversion with a simple value output.
			static toString = function()
			{
				return (string(minimum) + "-" + string(maximum));
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		minimum = _minimum;
		maximum = _maximum;
		
	#endregion
}
