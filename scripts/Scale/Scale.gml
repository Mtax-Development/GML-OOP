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
///							- Constructor copy: {Scale} other
function Scale() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				switch(argument_count)
				{
					case 0:
						//|Construction method: Default (1) for all values.
						x = 1;
						y = 1;
					break;
		
					case 1:
						if (instanceof(argument[0]) == "Scale")
						{
							//|Construction method: Constructor copy.
							var _other = argument[0];
							
							x = _other.x;
							y = _other.y;
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
			// @description			Create a string representing the constructor.
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
		
		switch (argument_count)
		{
			case 0:
				self.construct();
			break;
			
			case 1:
				self.construct(argument_original[0]);
			break;
			
			case 2:
			default:
				self.construct(argument_original[0], argument_original[1]);
			break;
		}
		
	#endregion
}
