/// @function				Range();
/// @argument				minimum {real}
/// @argument				maximum {real}
///
/// @description			Construct a two-value numeric range with two different numbers.
function Range(_min, _max) constructor
{
	#region [Methods]
		#region <Randomization>

			static random_real = function()
			{
				return random_range(minimum, maximum);
			}
	
			static random_int = function()
			{
				return irandom_range(minimum, maximum);
			}
	
		#endregion
		#region <Asserts>

			static is_between = function(_number)
			{
				return (_number == clamp(_number, minimum, maximum));
			}

		#endregion
		#region <Typing>
	
			static toString = function()
			{
				return (string(minimum) + "-" + string(maximum));
			}
	
		#endregion
	#endregion
	#region [Constructor]

		minimum = _min;
		maximum = _max;
	
	#endregion
}
