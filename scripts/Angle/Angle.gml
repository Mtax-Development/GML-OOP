function Angle(_value) constructor
{
	value = clamp(_value, 0, 359);
	
	static Modify = function(_value)
	{
		value += _value;
		
		if (value >= 360)
		{
			value -= 360;
		}
		else if (value < 0)
		{
			value = (360 - value);
		}
	}
}
