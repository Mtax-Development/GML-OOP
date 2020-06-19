/// @function				Ellipse();
/// @argument				location {Vector4}
/// @argument				alpha? {real}
/// @argument				color? {color | Color2}
/// @argument				isOutline? {bool}
function Ellipse(_location) constructor
{
	#region [Methods]
	
		static render = function()
		{
			if ((color != undefined) and (alpha > 0))
			{
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