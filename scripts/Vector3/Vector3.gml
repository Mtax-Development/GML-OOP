//  @function				Vector3()
/// @argument				x? {real}
/// @argument				y? {real}
/// @argument				z? {real}
/// @description			Constructs a Vector container for three-dimensional coordinates:
///							x, y and z.
//							
//							Construction types:
//							- Three numbers: x {real}, y {real}, z {real}
//							- One number for all values: value {real}
//							- From array: array {real[]}
//							   Array positions will be applied depending on its size:
//							   1: array[0] will be set to x and y.
//							   3+: array[0] will be set to x, array[1] will be set to y, array[2] will
//								   be set to z.
//							- Vector2 + value: vector {Vector2}, value {real}
//							- Empty: {void|undefined}
//							- Constructor copy: other {Vector3}
function Vector3() constructor
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
					switch (instanceof(argument[0]))
					{
						case "Vector3":
							//|Construction type: Constructor copy.
							var _other = argument[0];
							
							x = _other.x;
							y = _other.y;
							z = _other.z;
						break;
						default:
							switch (argument_count)
							{
								case 1:
									if (is_array(argument[0]))
									{
										//|Construction type: From array.
										var _array = argument[0];
										switch (array_length(_array))
										{
											case 1:
												x = _array[0];
												y = _array[0];
												z = _array[0];
											break;
											case 3:
											default:
												x = _array[0];
												y = _array[1];
												z = _array[2];
											break;
										}
									}
									else
									{
										//|Construction type: One number for all values.
										x = argument[0];
										y = argument[0];
										z = argument[0];
									}
								break;
								case 2:
									//|Construction type: Vector2 + value.
									var _vector = argument[0];
									var _value = argument[1];
									
									x = _vector.x;
									y = _vector.y;
									z = _value;
								break
								default:
									//|Construction type: Three numbers.
									x = argument[0];
									y = argument[1];
									z = argument[2];
								break;
							}
						break;
					}
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(x)) and (is_real(y)) and (is_real(z)) and (!is_nan(x))
						and (!is_nan(y)) and (!is_nan(z)) and (!is_infinity(x)) and (!is_infinity(y))
						and (!is_infinity(z)));
			}
			
		#endregion
		#region <Setters>
			
			/// @argument			x? {real}
			/// @argument			y? {real}
			/// @argument			z? {real}
			/// @description		Set each value of this Vector3.
			static set = function(_x = x, _y = y, _z)
			{
				x = _x;
				y = _y;
				z = _z;
				
				return self;
			}
			
			/// @argument			value {real|real[]|Vector3}
			/// @description		Set all of the values to one specified value or first three values
			///						of the specified array.
			static setAll = function(_value)
			{
				try
				{
					var _result_x, _result_y, _result_z;
					
					if (is_real(_value))
					{
						_result_x = _value;
						_result_y = _value;
						_result_z = _value;
					}
					else if (is_array(_value))
					{
						_result_x = _value[0];
						_result_y = _value[1];
						_result_z = _value[2];
					}
					else
					{
						_result_x = _value.x;
						_result_y = _value.y;
						_result_z = _value.z;
					}
					
					x = _result_x;
					y = _result_y;
					z = _result_z;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setAll()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value? {real|Vector3}
			/// @description		Set all of the values of to their equivalents or the ones of the
			///						specified value rounded down.
			static setFloor = function(_value)
			{
				try
				{
					var _result_x, _result_y, _result_z;
					
					if (_value == undefined)
					{
						_result_x = floor(x);
						_result_y = floor(y);
						_result_z = floor(z);
					}
					else if (is_real(_value))
					{
						var _value_floor = floor(_value);
						_result_x = _value_floor;
						_result_y = _value_floor;
						_result_z = _value_floor;
					}
					else
					{
						_result_x = floor(_value.x);
						_result_y = floor(_value.y);
						_result_z = floor(_value.z);
					}
					
					x = _result_x;
					y = _result_y;
					z = _result_z;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setFloor()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value? {real|Vector3}
			/// @description		Set all of the values of to their equivalents or the ones of the
			///						specified value rounded down or up.
			static setRound = function(_value)
			{
				try
				{
					var _result_x, _result_y, _result_z;
					
					if (_value == undefined)
					{
						_result_x = round(x);
						_result_y = round(y);
						_result_z = round(z);
					}
					else if (is_real(_value))
					{
						var _value_round = round(_value);
						_result_x = _value_round;
						_result_y = _value_round;
						_result_z = _value_round;
					}
					else
					{
						_result_x = round(_value.x);
						_result_y = round(_value.y);
						_result_z = round(_value.z);
					}
					
					x = _result_x;
					y = _result_y;
					z = _result_z;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setRound()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value? {real|Vector3}
			/// @description		Set all of the values of to their equivalents or the ones of the
			///						specified value rounded up.
			static setCeil = function(_value)
			{
				try
				{
					var _result_x, _result_y, _result_z;
					
					if (_value == undefined)
					{
						_result_x = ceil(x);
						_result_y = ceil(y);
						_result_z = ceil(z);
					}
					else if (is_real(_value))
					{
						var _value_ceil = ceil(_value);
						_result_x = _value_ceil;
						_result_y = _value_ceil;
						_result_z = _value_ceil;
					}
					else
					{
						_result_x = ceil(_value.x);
						_result_y = ceil(_value.y);
						_result_z = ceil(_value.z);
					}
					
					x = _result_x;
					y = _result_y;
					z = _result_z;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setCeil()"], _exception);
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
							   _mark_separator + "z:" + string(z));
				
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
		
		static constructor = Vector3;
		
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
}
