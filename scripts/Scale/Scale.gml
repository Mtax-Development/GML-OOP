/// @function				Scale()
/// @argument				{real} x?
/// @argument				{real} y?
///
/// @description			Constructs a Scale container that can be used for drawing or
///							manipulated in other ways.
///
///							Construction methods:
///							- Two values: {real} x, {real} y
///							- One number for all values: {real} value
///							- Default (1) for all values: {void}
///							- From array: {real[]} array
///							   Array positions will be applied depending on its size:
///								1: array[0] will be set to x and y.
///								2 or more: array[0] will be set to x, array[1] will be set to y.
///							- From Vector2: {Vector2} vector
///							- Constructor copy: {Scale} other
function Scale() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				if ((argument_count > 0) and (instanceof(argument[0]) == "Scale"))
				{
					//|Construction method: Constructor copy.
					var _other = argument[0];
					
					x = _other.x;
					y = _other.y;
				}
				else
				{
					switch(argument_count)
					{
						case 0:
							//|Construction method: Default (1) for all values.
							x = 1;
							y = 1;
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
							else if (instanceof(argument[0]) == "Vector2")
							{
								//|Construction method: From Vector2.
								var _vector = argument[0];
								
								x = _vector.x;
								y = _vector.y;
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
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(x)) and (is_real(y)));
			}
			
		#endregion
		#region <Setters>
			
			// @description			Reverse the x/y values of the scale.
			static mirror = function()
			{
				x = -x;
				y = -y;
			}
			
			// @description			Reverse the x value of the scale.
			static mirror_x = function()
			{
				x = -x;
			}
			
			// @description			Reverse the y value of the scale.
			static mirror_y = function()
			{
				y = -y;
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with both values of the Scale.
			static toString = function()
			{
				var _mark_separator = ", ";
				
				return (instanceof(self) + 
						"(" + 
						"x: " + string(x) + _mark_separator +
						"y: " + string(y) +
						")");
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
