//  @function				EulerAngle()
/// @argument				x? {real|Angle}
/// @argument				y? {real|Angle}
/// @argument				z? {real|Angle}
/// @description			Constructs a Container for three-dimensional 360-degree rotation values,
///							wrapped from 0 to 359.
//							
//							Construction types:
//							- New constructor
//							- One number for all values: value {real|Angle}
//							- Default values: {void}
//							- Empty: {undefined}
//							- Constructor copy: other {EulerAngle}
function EulerAngle() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				x = undefined;
				y = undefined;
				z = undefined;
				
				if (argument_count > 0)
				{
					switch (argument_count)
					{
						case 1:
							if (is_instanceof(argument[0], EulerAngle))
							{
								//|Construction type: Constructor copy.
								var _other = argument[0];
								
								x = _other.x;
								y = _other.y;
								z = _other.z;
							}
							else
							{
								//|Construction type: One number for all values.
								var _value = ((is_instanceof(argument[0], Angle)) ? argument[0].value
																				  : argument[0]);
								
								x = _value;
								y = _value;
								z = _value;
							}
						break;
						default:
							//|Construction type: New constructor.
							x = ((is_instanceof(argument[0], Angle)) ? argument[0].value
																	 : argument[0]);
							y = ((is_instanceof(argument[1], Angle)) ? argument[1].value
																	 : argument[1]);
							z = ((is_instanceof(argument[2], Angle)) ? argument[2].value
																	 : argument[2]);
							x -= (360 * (floor(x / 360)));
							y -= (360 * (floor(y / 360)));
							z -= (360 * (floor(z / 360)));
						break;
					}
				}
				else
				{
					//|Construction type: Default values.
					x = 0;
					y = 0;
					z = 0;
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(x)) and (is_real(y)) and (is_real(z)) and (!is_nan(x)) and
						(!is_nan(y)) and (!is_nan(z)) and (!is_infinity(x)) and (!is_infinity(y)) and
						(!is_infinity(z)));
			}
			
		#endregion
		#region <Setters>
			
			/// @argument			x? {real|Angle}
			/// @argument			y? {real|Angle}
			/// @argument			z? {real|Angle}
			/// @description		Set each value to the specified one after wrapping it.
			static set = function(_x = x, _y = y, _z = z)
			{
				try
				{
					x = ((is_instanceof(_x, Angle)) ? _x.value : _x);
					y = ((is_instanceof(_y, Angle)) ? _y.value : _y);
					z = ((is_instanceof(_z, Angle)) ? _z.value : _z);
					x -= (360 * (floor(x / 360)));
					y -= (360 * (floor(y / 360)));
					z -= (360 * (floor(z / 360)));
				}
				catch (_exception)
				{
					ErrorReport.report([other, self, "set()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real|Angle}
			/// @description		Change each value and wrap it.
			static modify = function(_x = 0, _y = 0, _z = 0)
			{
				try
				{
					x += ((is_instanceof(_x, Angle)) ? _x.value : _x);
					y += ((is_instanceof(_y, Angle)) ? _y.value : _y);
					z += ((is_instanceof(_z, Angle)) ? _z.value : _z);
					x -= (360 * (floor(x / 360)));
					y -= (360 * (floor(y / 360)));
					z -= (360 * (floor(z / 360)));
				}
				catch (_exception)
				{
					ErrorReport.report([other, self, "modify()"], _exception);
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
				var _mark_separator = ((_multiline) ? "\n" : ", ");
				var _string = ("x: " + string(x) + _mark_separator + "y: " + string(y) +
							   _mark_separator + "z: " + string(z));
				
				return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
			}
			
			/// @returns			{real[]}
			/// @description		Return an array containing all values of this Container.
			static toArray = function()
			{
				return [x, y, z];
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static constructor = EulerAngle;
		
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
		
		var _argument = array_create(argument_count, undefined);
		var _i = 0;
		repeat (argument_count)
		{
			_argument[_i] = argument[_i];
			
			++_i;
		}
		
		script_execute_ext(self.construct, _argument);
		
	#endregion
	#region [Static Constructions]
		
		static zero = new EulerAngle(0, 0, 0);
		
	#endregion
}

new EulerAngle();
