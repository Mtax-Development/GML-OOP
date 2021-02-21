/// @function				Angle()
/// @argument				{real} value?
///
/// @description			Construct a container for a 360-degree Angle, wrapped from 0 to 359.
///
///							Construction methods:
///							- New constructor: {int} value
///							   Unspecified value will be set to 0.
///							- Constructor copy: {Angle} other
function Angle() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				value = 0;
				
				if (argument_count > 0)
				{
					if (instanceof(argument[0]) == "Angle")
					{
						//|Construction method: Constructor copy.
						var _other = argument[0];
						
						value = _other.value;
					}
					else if (is_real(argument[0]))
					{
						//|Construction method: New constructor.
						value = argument[0];
					}
				}
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return (is_real(value));
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{Angle} other
			// @returns				{real}
			// @description			Returns the difference between two Angles, considering wrapping.
			static difference = function(_other)
			{
				var _result = (max(value, _other.value) - min(value, _other.value));
				
				return ((180 < _result) ? (360 - _result) : _result);
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{real} value
			// @description			Change the value of this Angle and wrap it.
			static modify = function(_value)
            {
                value += _value;
                value -= (360 * (floor(value / 360)));
            }
			
		#endregion
		#region <Conversion>
			
			// @description			Create a string representing this constructor.
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
		
		script_execute_ext(method_get_index(self.construct), argument_original);
		
	#endregion
}
