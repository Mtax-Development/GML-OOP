/// @function				Point()
/// @argument				location {Vector2}
/// @argument				alpha? {real}
/// @argument				color? {color | undefined}
///
///  @description			Constructs a Point in a space, which can be rendered as a single
///							pixel with its full configuration or operated in other ways.
function Point(_location) constructor
{
	#region [Methods]
	
		// @description			Execute the draw.
		static render = function()
		{
			if ((alpha > 0) and (color != undefined))
			{
				draw_set_alpha(alpha);
				draw_set_color(color);
				
				draw_point(location.x, location.y);
			}
		}
		
	#endregion
	#region [Constructor]
	
		location = _location;
		alpha = (argument_count >= 2 ? argument[1] : 1);
		color = (argument_count >= 3 ? argument[2] : undefined);
	
	#endregion
}