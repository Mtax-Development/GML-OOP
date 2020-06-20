/// @function				Ellipse();
/// @argument				location {Vector4}
/// @argument				alpha? {real}
/// @argument				color? {color | Color2 | undefined}
/// @argument				isOutline? {bool}
///
/// @description			Constructs an ellipse connected by two points
///							in a space, which can be rendered with its full
///							configuration or operated in other ways.
function Ellipse(_location) constructor
{
	#region [Methods]
		
		// @description			Execute the draw.
		static render = function()
		{
			if ((alpha > 0) and (color != undefined))
			{
				draw_set_alpha(alpha);
				
				if (isOutline)
				{
					draw_set_color(color);
					draw_ellipse(location.x1, location.y1, location.x2, location.y2, true);
				}
				else
				{
					if (instanceof(color) == "Color2")
					{
						draw_ellipse_color(location.x1, location.y1, location.x2, location.y2,
										   color.color1, color.color2, false);
					}
					else
					{
						draw_set_color(color);
						draw_ellipse(location.x1, location.y1, location.x2, location.y2, false);
					}
				}
			}
		}
		
	#endregion
	#region [Constructor]
		
		location = _location;
		alpha = (argument_count >= 2 ? argument[1] : 1);
		color = (argument_count >= 3 ? argument[2] : undefined);
		isOutline = (argument_count >= 4 ? argument[3] : false);
		
	#endregion
}