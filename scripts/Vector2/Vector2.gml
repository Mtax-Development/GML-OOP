/// @function				Vector2()
/// @argument				{real} x?
/// @argument				{real} y?
///							
/// @description			Construct a Vector container for X and Y coordinate pair.
///							
///							Construction types:
///							- Two values: {real} x, {real} y
///							- One number for all values: {real} value
///							- Empty: {void|undefined}
///							- From array: {real[]} array
///							   Array positions will be applied depending on its size:
///							   1: array[0] will be set to x and y.
///							   2+: array[0] will be set to x, array[1] will be set to y.
///							- Constructor copy: {Vector2} other
function Vector2() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty
				x = undefined;
				y = undefined;
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					switch (instanceof(argument[0]))
					{
						case "Vector2":
						case "Scale":
							//|Construction type: Constructor copy.
							//|Construction type: From Scale.
							var _other = argument[0];
							
							x = _other.x;
							y = _other.y;
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
											break;
											
											case 2:
											default:
												x = _array[0];
												y = _array[1];
											break;
										}
									}
									else
									{
										//|Construction type: One number for all values.
										x = argument[0];
										y = argument[0];
									}
								break;
								
								case 2:
								default:
									//|Construction type: Two values.
									x = argument[0];
									y = argument[1];
								break;
							}
						break;
					}
				}
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(x)) and (is_real(y)) and (!is_nan(x)) and (!is_nan(y))
						and (!is_infinity(x)) and (!is_infinity(y)));
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{real|Vector2} value
			// @description			Add to the values of this Vector2 the specified value or the
			//						values of other specified Vector2.
			static add = function()
			{
				if (instanceof(argument[0]) == "Vector2")
				{
					var _other = argument[0];
					
					x += _other.x;
					y += _other.y;
				}
				else
				{
					var _value = argument[0];
					
					x += _value;
					y += _value;
				}
			}
			
			// @argument			{real|Vector2} value
			// @description			Substract the values of this Vector2 the specified value or the
			//						values of other specified Vector2.
			static substract = function()
			{
				if (instanceof(argument[0]) == "Vector2")
				{
					var _other = argument[0];
					
					x -= _other.x;
					y -= _other.y;
				}
				else
				{
					var _value = argument[0];
					
					x -= _value;
					y -= _value;
				}
			}
			
			// @argument			{real|Vector2} value
			// @description			Multiply the values of this Vector2 by specified value or the
			//						values of other specified Vector2.
			static multiply = function()
			{
				if (instanceof(argument[0]) == "Vector2")
				{
					var _other = argument[0];
					
					x *= _other.x;
					y *= _other.y;
				}
				else
				{
					var _value = argument[0];
					
					x *= _value;
					y *= _value;
				}
			}
			
			// @argument			{real|Vector2} value
			// @description			Divide the values of this Vector2 by specified value or the
			//						values of other specified Vector2.
			//						Attempts of division by 0 are ignored.
			static divide = function()
			{
				if (instanceof(argument[0]) == "Vector2")
				{
					var _other = argument[0];
					
					if (_other.x != 0)
					{
						x /= _other.x;
					}
					
					if (_other.y != 0)
					{
						y /= _other.y;
					}
				}
				else
				{
					var _value = argument[0];
					
					if (_value != 0)
					{
						x /= _value;
						y /= _value;
					}
				}
			}
			
			// @description			Swap the x and y values of this Vector2 with each other.
			static flip = function()
			{
				var _x = x;
				var _y = y;
				
				x = _y;
				y = _x;
			}
			
			// @description			Reverse the x and y values.
			static mirror = function()
			{
				x = -x;
				y = -y;
			}
			
			// @description			Reverse the x value.
			static mirrorX = function()
			{
				x = -x;
			}
			
			// @description			Reverse the y value.
			static mirrorY = function()
			{
				y = -y;
			}
			
			// @argument			{int} device?
			// @description			Set the values to the ones of the cursor.
			static setCursor = function(_device)
			{
				if (_device == undefined)
				{
					x = mouse_x;
					y = mouse_y;
				}
				else
				{
					x = device_mouse_x(_device);
					y = device_mouse_y(_device);
				}
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{Vector2|Scale} other
			// @returns				{bool}
			// @description			Check if the values of this Vector2 are equal to the values of
			//						specified other one.
			static equals = function(_other)
			{
				return ((x == _other.x) and (y == _other.y));
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the values of this Container.
			static toString = function(_multiline)
			{
				var _mark_separator = ((_multiline) ? "\n" : ", ");
				var _string = ("x: " + string(x) + _mark_separator + "y: " + string(y));
				
				return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
			}
			
			// @returns				{real[]}
			// @description			Return an array containing all values of this Container.
			static toArray = function()
			{
				return [x, y];
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
