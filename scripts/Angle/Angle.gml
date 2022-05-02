/// @function				Angle()
/// @argument				{real} value?
///							
/// @description			Construct a container for a 360-degree Angle, wrapped from 0 to 359.
///							
///							Construction types:
///							- New constructor.
///							- Default value: {void}
///							- Empty: {undefined}
///							- Constructor copy: {Angle} other
function Angle() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				value = undefined;
				
				if (argument_count > 0)
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
						value = argument[0];
						value -= (360 * (floor(value / 360)));
					}
				}
				else
				{
					//|Construction type: Default value.
					value = 0;
				}
				
				return self;
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(value)) and (!is_nan(value)) and (!is_infinity(value)));
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{real|Angle} value
			// @returns				{bool}
			// @description			Check if the value of this Angle is equal to the specified one.
			static equals = function(_value)
			{
				var _value_other = ((is_real(_value) ? _value : _value.value));
				_value_other -= (360 * (floor(_value_other / 360)));
				
				var _value_wrapped = (value - (360 * (floor(value / 360))));
				
				return (_value_wrapped == _value_other);
			}
			
			// @argument			{real|Angle} value
			// @returns				{real}
			// @description			Returns the difference between this and the specified Angle.
			static difference = function(_value)
			{
				var _value_other = ((is_real(_value) ? _value : _value.value));
				_value_other -= (360 * (floor(_value_other / 360)));
				
				var _value_wrapped = (value - (360 * (floor(value / 360))));
				
				var _result = (max(_value_wrapped, _value_other) - min(_value_wrapped, _value_other));
				
				return ((180 < _result) ? (360 - _result) : _result);
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{real|Angle} value
			// @description			Set the value to the specified one after wrapping it.
			static set = function(_value)
			{
				if (is_real(_value))
				{
					value = _value;
				}
				else
				{
					value = _value.value;
				}
				
				value -= (360 * (floor(value / 360)));
				
				return self;
			}
			
			// @argument			{real|Angle} value
			// @description			Change the value of this Angle and wrap it.
			static modify = function(_value)
			{
				value += ((is_real(_value)) ? _value : (_value.value));
				value -= (360 * (floor(value / 360)));
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented as the value of this Container.
			static toString = function(_multiline = false)
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

