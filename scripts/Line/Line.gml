/// @function				Line()
/// @argument				location {Vector4}
/// @argument				alpha? {real}
/// @argument				color? {color | color2 | undefined}
/// @argument				width? {real}
///
/// @description			Construct a Line connected by two points
///							in a space, which can be rendered with its
///							full configuration or operated in other ways.
function Line(_location) constructor
{
	#region [Methods]
		
		// @description			Execute the draw.
		static render = function()
		{
			if ((alpha > 0) and (color != undefined) and (width > 0))
			{
				draw_set_alpha(alpha);
				
				if (width > 1)
				{
					if (instanceof(color) == "Color2")
					{
						draw_line_width_color(location.x1, location.y1, location.x2, location.y2,
											  width, color.color1, color.color2);
					}
					else
					{
						draw_set_color(color)
						
						draw_line_width(location.x1, location.y1, location.x2, location.y2, width);
					}
				}
				else
				{
					if (instanceof(color) == "Color2")
					{
						draw_line_color(location.x1, location.y1, location.x2, location.y2,
										color.color1, color.color2);
					}
					else
					{
						draw_set_color(color);
						
						draw_line(location.x1, location.y1, location.x2, location.y2);
					}
				}
			}
		}
		
	#endregion
	#region [Constructor]
	
		location = _location;
		alpha = (argument_count >= 2 ? argument[1] : 1);
		color = (argument_count >= 3 ? argument[2] : undefined);
		width = (argument_count >= 4 ? argument[3] : 1);
	
	#endregion
}
