/// @function				Angle()
/// @argument				{real} value?
///							
/// @description			Construct a container for a 360-degree Angle, wrapped from 0 to 359.
///							
///							Construction types:
///							- New constructor.
///							- Default value: {void|undefined}
///							- Constructor copy: {Angle} other
function Angle() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Default value.
				value = 0;
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (instanceof(argument[0]) == "Angle")
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						value = _other.value;
					}
					else if (is_real(argument[0]))
					{
						//|Construction type: New constructor.
						value += argument[0];
						value -= (360 * (floor(value / 360)));
					}
				}
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(value)) and (!is_nan(value)) and (!is_infinity(value)));
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{Angle} other
			// @returns				{real}
			// @description			Returns the difference between this Angle and an other one, taking
			//						wrapping into account.
			static difference = function(_other)
			{
				var _result = (max(value, _other.value) - min(value, _other.value));
				
				return ((180 < _result) ? (360 - _result) : _result);
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{real} value
			// @description			Set the value to the specified number after wrapping it.
			static set = function(_value)
			{
				value = _value;
				value -= (360 * (floor(value / 360)));
			}
			
			// @argument			{real} value
			// @description			Change the value of this Angle and wrap it.
			static modify = function(_value)
			{
				value += _value;
				value -= (360 * (floor(value / 360)));
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented as the value of this Container.
			static toString = function(_multiline)
			{
				if (is_real(value))
				{
					var _string = string(value);
					
					return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
				}
				else
				{
					return (instanceof(self) + "<>");
				}
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
