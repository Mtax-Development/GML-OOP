/// @function				Angle()
/// @argument				{real} value?
///
/// @description			Construct a container for a 360-degree Angle, wrapped from 0 to 359.
function Angle(_value) constructor
{
	#region [Methods]
		#region <Management>
			
			static construct = function(_value)
			{
				value = 0;
				
				if ((_value != undefined) and (_value != 0))
				{
					self.modify(_value);
				}
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{Angle} other
			// @returns				{real}
			// @description			Returns the difference between two Angles, considering wrapping.
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
		#region <Setters>
			
			// @argument			{real} value
			// @description			Change the value of the Angle and wrap it.
			static modify = function(_value)
            {
                value += _value;
                value -= (360 * (floor(value / 360)))
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
		
		argument_original = array_create(argument_count, undefined)
		
		var _i = 0;
		
		repeat (argument_count)
		{
			argument_original = argument[_i];
			
			++_i;
		}
		
		switch (argument_count)
		{
			case 0:
				self.construct();
			break;
			
			default:
				self.construct(argument_original[0]);
			break;
		}
		
	#endregion
}
