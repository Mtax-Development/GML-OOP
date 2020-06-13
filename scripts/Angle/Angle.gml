/// @function				Angle();
/// @argument				value? {real}
///
/// @description			Construct an 360-degree angle that's wrapped in a
///							range of 0 to 359 (as 0 and 360 are the same values).
///							If an asset (such as sprite) is rendered at an angle
///							of 0, it will be drawn in unrotated state, as in sprite
///							editor. Upon modifying the angle, positive values rotate
///							it clockwise, negative in opposite direction.
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
			modify(argument[0]);
		}
		
	#endregion
}
