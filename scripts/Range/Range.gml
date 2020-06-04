/// @function				Range();
/// @Description			Construct a two-value numeric range with two different numbers.
function Range(_min, _max) constructor
{
	minimum = _min;
	maximum = _max;


#region [Randomization]

	static random_real = function()
	{
		return random_range(minimum, maximum);
	}
	
	static random_int = function()
	{
		return irandom_range(minimum, maximum);
	}
	
#endregion
#region [Asserts]

	static is_between = function(_number)
	{
		return (_number == clamp(_number, minimum, maximum));
	}

#endregion
}
