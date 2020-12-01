/// @function				Vector2()
/// @argument				x?
/// @argument				y?
///
/// @description			Construct a Vector container for X and Y coordinate pair.
///
///							Construction methods:
///							- Two values: {real} x, {real} y
///							- One number for all values: {real} value
///							- Default for all values: {void}
///							   The values will be set to 0.
///							- From array: {real[]} array
///							   Array positions will be applied depending on its size:
///							   1: array[0] will be set to x and y.
///							   2 or more: array[0] will be set to x, array[1] will be set to y.
///							- Constructor copy: {Vector2} other
function Vector2() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				if ((argument_count > 0) and (instanceof(argument[0]) == "Vector2"))
				{
					//|Construction method: Constructor copy.
					var _other = argument[0];
					
					x = _other.x;
					y = _other.y;
				}
				else
				{
					switch (argument_count)
					{
						case 0:
							//|Construction method: Default for all values.
							var _default = 0;
							
							x = _default;
							y = _default;
						break;
					
						case 1:
							if (is_array(argument[0]))
							{
								//|Construction method: From array.
								var _array = argument[0];
								
								var _array_length = array_length(_array);
								
								switch (_array_length)
								{
									case 1:
										x = _array[0];
										y = _array[0];
									break;
									
									case 2:
										x = _array[0];
										y = _array[1];
									break;
								}
							}
							else
							{
								//|Construction method: One number for all values.
								x = argument[0];
								y = argument[0];
							}
						break;
					
						case 2:
							//|Construction method: Two values.
							x = argument[0];
							y = argument[1];
						break;
					}
				}
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
			static divide = function()
			{
				if (instanceof(argument[0]) == "Vector2")
				{
					var _other = argument[0];
					
					x /= _other.x;
					y /= _other.y;
				}
				else
				{
					var _value = argument[0];
					
					x /= _value;
					y /= _value;
				}
			}
			
			// @description			Swap the X and Y values of this Vector2.
			static flip = function()
			{
				var x_new = y;
				var y_new = x;
				
				x = x_new;
				y = y_new;
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{Vector2} other
			// @returns				{bool}
			// @description			Check if the values of this Vector2 are equal to the values of
			//						other specified Vector2.
			static equals = function(_other)
			{
				return ((x == _other.x) and (y == _other.y));
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the output of X and then Y
			//						values of this Vector2.
			static toString = function(_multiline)
			{
				if (_multiline)
				{
					return ("x: " + string(x) + "\n" +
							"y: " + string(y));
				}
				else
				{
					var _mark_separator = ", ";
					
					return (instanceof(self) + "(" +
							"x: " + string(x) + _mark_separator +
							"y: " + string(y) +
							")");
				}
			}
			
			// @returns				{real[]}
			// @description			Return an array containing all values of this Vector2.
			//						The X value will be set to the first position of that array,
			//						the Y value will be set to the second position of that array.
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
		
		if (argument_count <= 0)
		{
			self.construct();
		}
		else
		{
			script_execute_ext(method_get_index(self.construct), argument_original);
		}
		
	#endregion
}
