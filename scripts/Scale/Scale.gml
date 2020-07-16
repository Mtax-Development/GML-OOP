/// @function				Scale()
/// @argument				{real} x?
/// @argument				{real} y?
///
/// @description			Constructs a Vector2-like Scale container, ready
///							to be used with draw-related code, as well as 
///							manipulated using its own functions.
///
///							Construction methods:
///							- {void} (creates default scale with values of 1)
///							- {real} (populates both scales with the same value)
///							- {real}, {real}
function Scale() constructor
{
	#region [Methods]
		#region <Operations>
			
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
			
			// @description			Reverse the x/y values of the scale.
			static mirror = function()
			{
				self.mirror_x();
				self.mirror_y();
			}
			
		#endregion
		#region <Conversion>
			
			// @description			Overrides the string conversion with a simple value output.
			static toString = function()
			{
				return (string(x) + "/" + string(y));
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		switch(argument_count)
		{
			case 0:
				x = 1;
				y = 1;
			break;
		
			case 1:
				x = argument[0];
				y = argument[0];
			break;
		
			case 2:
				x = argument[0];
				y = argument[1];
			break;
		}
		
	#endregion
}
