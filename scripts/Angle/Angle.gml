/// @function				Angle()
/// @argument				{real} value?
///
/// @description			Construct a container for a 360-degree Angle, wrapped from 0 to 359.
///
///							Construction methods:
///							- New angle: {int} value
///							- Default (0) Angle value: {void}
///							- Constructor copy: {Angle} other
function Angle(_value) constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				if ((argument_count > 0) and (instanceof(argument[0]) == "Angle"))
				{
					//|Construction method: Constructor copy.
					var _other = argument[0];
					
					value = _other.value;
				}
				else
				{
					var _value = ((argument_count > 0) ? argument[0] : undefined);
					
					//|Construction method: Default (0) Angle value
					value = 0;
					
					if ((_value != undefined) and (_value != 0))
					{
						self.modify(_value);
					}
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
			// @description			Change the value of this Angle and wrap it.
			static modify = function(_value)
            {
                value += _value;
                value -= (360 * (floor(value / 360)))
            }
			
		#endregion
		#region <Conversion>
			
			// @description			Create a string representing the constructor.
			//						Overrides the string() conversion.
			//						Content will be represented as the value of this Angle.
			static toString = function()
			{
				return (instanceof(self) + "(" + string(value) + ")");
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
		
		switch (argument_count)
		{
			case 0:
				self.construct();
			break;
			
			case 1:
			default:
				self.construct(argument_original[0]); 
			break;
		}
		
	#endregion
}
