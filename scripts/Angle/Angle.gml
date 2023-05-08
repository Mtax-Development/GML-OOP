//  @function				Angle()
/// @argument				value? {real}
///							
/// @description			Construct a container for a 360-degree Angle, wrapped from 0 to 359.
///							
//							Construction types:
//							- New constructor
//							- Default value: {void}
//							- Empty: {undefined}
//							- Constructor copy: other {Angle}
function Angle() constructor
/// @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize the constructor.
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
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(value)) and (!is_nan(value)) and (!is_infinity(value)));
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			value {real|Angle}
			/// @returns			{bool}
			/// @description		Check if the value of this Angle is equal to the specified one.
			static equals = function(_value)
			{
				try
				{
					var _value_other = ((is_real(_value) ? _value : _value.value));
					_value_other -= (360 * (floor(_value_other / 360)));
					var _value_wrapped = (value - (360 * (floor(value / 360))));
					
					return (_value_wrapped == _value_other);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "equals()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			value {real|Angle}
			/// @returns			{real} | On error: {undefined}
			/// @description		Returns the difference between this and the specified Angle.
			static difference = function(_value)
			{
				try
				{
					var _value_other = ((is_real(_value) ? _value : _value.value));
					_value_other -= (360 * (floor(_value_other / 360)));
					var _value_wrapped = (value - (360 * (floor(value / 360))));
					var _result = (max(_value_wrapped, _value_other) -
								   min(_value_wrapped, _value_other));
					
					return ((180 < _result) ? (360 - _result) : _result);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "difference()"], _exception);
				}
				
				return undefined;
			}
			
		#endregion
		#region <Setters>
			
			/// @argument			value {real|Angle}
			/// @description		Set the value to the specified one after wrapping it.
			static set = function(_value)
			{
				try
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
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "set()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real|Angle}
			/// @description		Change the value of this Angle and wrap it.
			static modify = function(_value)
			{
				try
				{
					value += ((is_real(_value)) ? _value : (_value.value));
					value -= (360 * (floor(value / 360)));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "modify()"], _exception);
				}
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented as the value of this Container.
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
		
		static prototype = {};
		var _property = variable_struct_get_names(prototype);
		var _i = 0;
		repeat (array_length(_property))
		{
			var _name = _property[_i];
			var _value = variable_struct_get(prototype, _property[_i]);
			
			variable_struct_set(self, _name, ((is_method(_value)) ? method(self, _value) : _value));
			
			++_i;
		}
		
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
