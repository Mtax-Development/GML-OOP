/// @function				Angle()
/// @argument				{real} value?
///
/// @description			Construct a container for a 360 degree Angle, wrapped from 0 to 359.
function Angle(_value) constructor
{
	#region [Methods]
		#region <Management>
			
			// @argument			{real} value
			// @description			Change the value of the Angle and wrap it.
			static modify = function(_value)
            {
                value += _value;
                value -= (360 * (floor(value / 360)))
            }
			
		#endregion
		#region <Calculations>
			
			// @returns				{real}
			// @description			Returns the difference between two Angles, considering wrap.
			static difference = function(_other)
			{
				result = (max(value, _other.value) - min(value, _other.value));

				if (180 < result) 
				{
					result = (360 - result);
				}
				
				return result;
			}
			
		#endregion
		#region <Conversion>
			
			// @description			Overrides the string conversion with a simple value output.
			static toString = function()
			{
				return string(value);
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		value = 0;
		
		if (_value != undefined)
		{
			self.modify(_value);
		}
		
	#endregion
}
