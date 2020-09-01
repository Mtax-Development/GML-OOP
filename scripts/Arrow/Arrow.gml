/// @function				Arrow()
/// @argument				{Vector4} location
/// @argument				{real} alpha? 
/// @argument				{color|undefined} color?
/// @argument				{real} size?
///
/// @description			Constructs an Arrow connected by two points
///							in a space, which can be rendered with its
///							full configuration or operated in other ways.
function Arrow(_location) constructor
{
	#region [Methods]
		
		// @description			Execute the draw.
		static render = function()
		{
			if ((alpha > 0) and (color != undefined))
			{
				draw_set_alpha(alpha);
				draw_set_color(color);
				
				draw_arrow(location.x1, location.y1, location.x2, location.y2, size);
			}
		}
		
	#endregion
	#region [Constructor]
		
		location = _location;
		alpha = (((argument_count > 1) and (argument[1] != undefined)) ? argument[1] : 1);
		color = ((argument_count > 2) ? argument[2] : undefined);
		size  = (((argument_count > 3) and (argument[3] != undefined)) ? argument[3] : 1);
		
	#endregion
}
