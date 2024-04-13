//  @function				Range()
/// @argument				minimum {real}
/// @argument				maximum {real}
/// @description			Constructs a container for two-value numeric Range with different numbers.
//							
//							Construction types:
//							- New constructor
//							- Empty: {void|undefined}
//							- Constructor copy: other {Range}
function Range() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				minimum = undefined;
				maximum = undefined;
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (is_instanceof(argument[0], Range))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						minimum = _other.minimum;
						maximum = _other.maximum;
					}
					else
					{
						//|Construction type: New constructor.
						minimum = argument[0];
						maximum = argument[1];
					}
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(minimum)) and (is_real(maximum)));
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			value {real}
			/// @returns			{real} | On error: {any}
			/// @description		Restrict the specified number to boundaries of this Range.
			static clampTo = function(_value)
			{
				try
				{
					return clamp(_value, minimum, maximum);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "clampTo()"], _exception);
				}
				
				return _value;
			}
			
			/// @argument			value {real}
			/// @returns			{real} | On error: {any}
			/// @description		Return the value at the position within this Range of the 
			///						specified precentage.
			static interpolate = function(_value)
			{
				try
				{
					return lerp(minimum, maximum, _value);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "interpolate()"], _exception);
				}
				
				return _value;
			}
			
			/// @returns			{real} | On error: {any}
			/// @description		Return the percentage value representing the specified value
			///						inside of the Range as a numerical value in which one whole
			///						number is one full percentage.
			static percent = function(_value)
			{
				try
				{
					return ((_value - minimum) / (maximum - minimum));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "percent()"], _exception);
				}
				
				return _value;
			}
			
			/// @returns			{real} | On error: {undefined}
			/// @description		Return a random real number from this Range.
			static randomReal = function()
			{
				try
				{
					return random_range(minimum, maximum);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "randomReal()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{int} | On error: {undefined}
			/// @description		Return a random integer number from this Range.
			static randomInt = function()
			{
				try
				{
					return irandom_range(minimum, maximum);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "randomInt()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{real} | On error: {undefined}
			/// @description		Return the middle point of this Range.
			static getMiddle = function()
			{
				try
				{
					return lerp(minimum, maximum, 0.5);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getMiddle()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			value {real}
			/// @returns			{bool}
			/// @description		Check whether a number is in or equal to borders of this Range.
			static isBetween = function(_value)
			{
				try
				{
					return (_value == clamp(_value, minimum, maximum));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "isBetween()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			value {real}
			/// @returns			{bool}
			/// @description		Check whether a number is equal to the boundaries of this Range.
			static isBoundary = function(_value)
			{
				return ((_value == minimum) or (_value == maximum));
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
				var _mark_separator = ((_multiline) ? "\n" : " - ");
				var _string = (string(minimum) + _mark_separator + string(maximum));
				
				return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
			}
			
			/// @returns			{real[]}
			/// @description		Return an array containing all values of this Container.
			static toArray = function()
			{
				return [minimum, maximum];
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
