/// @function				Angle();
/// @argument				value? {real}
///
/// @description			Construct an 360-degree angle that's wrapped in a
///							range of 0 to 359 (as 0 and 360 are the same values).
///							If an asset (such as sprite) is rendered at angle of 0,
///							it will be drawn in its default, unrotated state.
///							Upon modifying the angle, positive values rotate
///							it anti-clockwise, negative clockwise.
function Angle() constructor
{
	#region [Methods]
		#region <Manipulation>
			
			// @description			Change the value of the angle and wrap it.
			static modify = function(_value)
            {
                value += _value;
                value -= (360 * (floor(value / 360)))
            }
	
		#endregion
		#region <Calculations>
			
			// @returns				{real}
			// @description			Returns the difference between two angles, considering wrap.
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
		#region <Typing>

			// @description			Override the string conversion with a simple value output.
			static toString = function()
			{
				return string(value);
			}

		#endregion
	#endregion
	#region [Constructor]

		value = 0;
		
		if (argument_count >= 1)
		{
			self.modify(argument[0]);
		}
		
	#endregion
}
