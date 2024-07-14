//  @function				RangedValue()
/// @argument				range {Range}
/// @argument				value? {real}
/// @description			Constructs a container for a value closed in the specified Range.
//							
//							Construction types:
//							- New constructor
//							   Unspecified value will be set to the minimum value of the Range.
//							- Empty: {void|undefined}
//							- Constructor copy: other {Range}
function RangedValue() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				range = undefined;
				value = undefined;
				value_original = undefined;
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (is_instanceof(argument[0], RangedValue))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						range = ((is_instanceof(_other.range, Range)) ? new Range(_other.range)
																	  : _other.range);
						value = _other.value;
						value_original = _other.value_original;
					}
					else
					{
						//|Construction type: New constructor.
						range = argument[0];
						var _value = (((argument_count > 1) and (argument[1] != undefined))
									  ? argument[1] : range.minimum);
						value = clamp(_value, range.minimum, range.maximum);
						value_original = value;
					}
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(value)) and (is_instanceof(range, Range)) and (range.isFunctional()));
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			value {real|RangedValue}
			/// @returns			{bool}
			/// @description		Check if the value is the same as the specified number or value
			///						of specified Ranged Value.
			static equals = function(_value)
			{
				if (is_instanceof(_value, RangedValue))
				{
					return (value == _value.value);
				}
				else if (is_real(_value))
				{
					return (value == _value);
				}
				
				return false;
			}
			
			/// @returns			{real} | On error: {undefined}
			/// @description		Return the percentage value representing the value inside of the
			///						Range as a numerical value in which one whole number is one full
			///						percentage.
			static percent = function()
			{
				try
				{
					return ((value - range.minimum) / (range.maximum - range.minimum));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "percent()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{bool}
			/// @description		Check if the value is equal to either boundary of the Range.
			static isBoundary = function()
			{
				try
				{
					return ((value == range.minimum) or (value == range.maximum));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "isBoundary()"], _exception);
				}
				
				return false;
			}
			
			/// @returns			{bool}
			/// @description		Check if the value is equal to the minimum boundary of the Range.
			static isMinimum = function()
			{
				try
				{
					return ((value == range.minimum));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "isMinimum()"], _exception);
				}
				
				return false;
			}
			
			/// @returns			{bool}
			/// @description		Check if the value is equal to the maximum boundary of the Range.
			static isMaximum = function()
			{
				try
				{
					return ((value == range.maximum));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "isMaximum()"], _exception);
				}
				
				return false;
			}
			
		#endregion
		#region <Setters>
			
			/// @argument			value {real}
			/// @description		Modify the value by the specified number.
			static modify = function(_value)
			{
				try
				{
					value = clamp((value + _value), range.minimum, range.maximum);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "modify()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real}
			/// @argument			inclusive? {bool}
			/// @description		Modify the value by the specified number, then wrap it to the
			///						furthest boundary if it is outside of the Range. The value will
			///						also be wrapped if inclusive wrapping is specified and the value
			///						equals the Range.
			static modifyWrap = function(_value, _inclusive = false)
			{
				try
				{
					var _result = (value + _value);
					var _rangeDifference = (range.maximum - range.minimum);
					_result = (((((_result - range.minimum) mod _rangeDifference) + _rangeDifference) 
								mod _rangeDifference) + range.minimum);
					
					if (_inclusive)
					{
						var _value_sign = sign(_value);
						
						if (_value_sign > 0)
						{
							if (_result == range.minimum)
							{
								_result = range.maximum;
							}
						}
						else if (_value_sign < 0)
						{
							if (_result == range.maximum)
							{
								_result = range.minimum;
							}
						}
					}
					
					value = _result;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "modifyWrap()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real}
			/// @description		Modify the value by the specified number, then continously bounce
			///						it back towards the Range if it would exceed its boundary.
			static modifyBounce = function(_value)
			{
				try
				{
					var _result = value;
					var _rangeDifference = abs(range.maximum - range.minimum);
					var _modulo = (_value mod (_rangeDifference * 2));
					
					if (_modulo > 0)
					{
						var _distance = abs(value - range.maximum);
						
						if (_modulo <= _distance)
						{
							_result += _modulo;
						}
						else if ((_modulo > _distance) and (_modulo <= (_rangeDifference + _distance)))
						{
							_result = (range.maximum - (_modulo - _distance));
						}
						else if (_modulo > (_rangeDifference + _distance))
						{
							_result = (range.minimum + (_modulo - (_distance + _rangeDifference)));
						}
					}
					else if (_modulo < 0)
					{
						_modulo = abs(_modulo);
						
						var _distance = abs(value - range.minimum);
						
						if (_modulo <= _distance)
						{
							_result -= _modulo;
						}
						else if ((_modulo > _distance) and (_modulo <= (_rangeDifference + _distance)))
						{
							_result = (range.minimum + (_modulo - _distance));
						}
						else if (_modulo > (_rangeDifference + _distance))
						{
							_result = (range.maximum - (_modulo - (_distance + _rangeDifference)));
						}
					}
					
					value = _result;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "modifyBounce()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real}
			/// @returns			{real}
			/// @description		Set the value to a position within the Range of the specified
			///						precentage.
			static interpolate = function(_value)
			{
				try
				{
					value = clamp(lerp(range.minimum, range.maximum, _value), range.minimum,
								  range.maximum);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "interpolate()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real}
			/// @description		Set the value to specified number, clamped to the Range.
			static set = function(_value)
			{
				try
				{
					value = clamp(_value, range.minimum, range.maximum);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "set()"], _exception);
				}
				
				return self;
			}
			
			/// @description		Set the value to the minimum boundary of the Range.
			static setMinimum = function()
			{
				try
				{
					value = range.minimum;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setMinimum()"], _exception);
				}
				
				return self;
			}
			
			/// @description		Set the value to the maximum boundary of the Range.
			static setMaximum = function()
			{
				try
				{
					value = range.maximum;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setMaximum()"], _exception);
				}
				
				return self;
			}
			
			/// @description		Set the value to the state it had upon construction.
			static setOriginal = function()
			{
				value = value_original;
				
				return self;
			}
			
			/// @returns			{real}
			/// @description		Set the value the middle point of the Range.
			static setMiddle = function()
			{
				try
				{
					value = lerp(range.minimum, range.maximum, 0.5);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setMiddle()"], _exception);
				}
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented with the values of this Container.
			static toString = function(_multiline = false)
			{
				if (self.isFunctional())
				{
					var _mark_separator = ((_multiline) ? "\n" : ", ");
					var _mark_separator_inline = " - ";
					var _string = (string(value) + _mark_separator + string(range.minimum) +
								   _mark_separator_inline + string(range.maximum));
					
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
		
		static constructor = RangedValue;
		
		static prototype = {};
		var _property = variable_struct_get_names(prototype);
		var _i = 0;
		repeat (array_length(_property))
		{
			var _name = _property[_i];
			var _value = variable_struct_get(prototype, _name);
			
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
