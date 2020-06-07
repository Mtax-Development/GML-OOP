/// @function				Scale();
/// @argument				x? {real}
/// @argument				y? {real}
///
/// @description			Construct a Vector2-like scale container, ready
///							to be used with draw-related code, as well as 
///							manipulated using its own functions.
///
///							Construction methods:
///							- {void} (creates default scale with values of 1)
///							- {real} (populates both scales with the same value)
///							- {real}. {real}
function Scale() constructor
{
	#region [Methods]
		#region <Manipulation>

			static mirror = function()
			{
				x = -x;
				y = -y;
			}
	
			static mirror_x = function()
			{
				x = -x;
			}
	
			static mirror_y = function()
			{
				y = -y;
			}
	
		#endregion
		#region <Typing>
	
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
