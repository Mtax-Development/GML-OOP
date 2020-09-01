/// @function				Point()
/// @argument				{Vector2} location
/// @argument				{real} alpha?
/// @argument				{color|undefined} color?
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
		alpha = (((argument_count > 1) and (argument[1] != undefined)) ? argument[1] : 1);
		color = ((argument_count > 2) ? argument[2] : undefined);
		
	#endregion
}
