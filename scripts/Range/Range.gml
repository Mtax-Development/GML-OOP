/// @function				Range();
/// @argument				minimum {real}
/// @argument				maximum {real}
///
/// @description			Construct a two-value numeric range with two different numbers.
function Range(_minimum, _maximum) constructor
{
	#region [Methods]
		#region <Randomization>
			
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
			
			// @argument			{real}
			// @description			Check whether a number is between or equal to the range.
			static is_between = function(_number)
			{
				return (_number == clamp(_number, minimum, maximum));
			}

		#endregion
		#region <Typing>
			
			// @description			Override the string conversion with a simple value output.
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
