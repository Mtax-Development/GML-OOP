/// @function				RoundRectangle();
/// @argument				location {Vector4}
/// @argument				alpha? {real}
/// @argument				color? {color | Color2}
/// @argument				isOutline? {bool}
/// @argument				radius? {Vector2}
function RoundRectangle(_location) constructor
{
	#region [Methods]
	
		static render = function()
		{
			if ((color != undefined) and (alpha > 0))
			{
				if (radius != undefined)
				{
					if (isOutline)
					{
						draw_set_color(color);
						draw_roundrect_ext(location.x1, location.y1, location.x2, location.y2,
										   radius.x, radius.y, true);
					}
					else
					{
						if (instanceof(color) == "Color2")
						{
							draw_roundrect_color_ext(location.x1, location.y1, location.x2, location.y2,
													 radius.x, radius.y, color.color1, color.color2, 
													 false);
						}
						else
						{
							draw_set_color(color);
							draw_roundrect_ext(location.x1, location.y1, location.x2, location.y2,
											   radius.x, radius.y, false);
						}
					}
				}
				else
				{
					if (isOutline)
					{
						draw_set_color(color);
						draw_roundrect(location.x1, location.y1, location.x2, location.y2, true);
					}
					else
					{
						if (instanceof(color) == "Color2")
						{
							draw_roundrect_color(location.x1, location.y1, location.x2, location.y2,
												 color.color1, color.color2, false);
						}
						else
						{
							draw_set_color(color);
							draw_roundrect(location.x1, location.y1, location.x2, location.y2, false);
						}
					}
				}
			}
		}
	
	#endregion
	#region [Constructor]
	
		location = _location;
		alpha	  = (argument_count >= 2 ? argument[1] : 1);
		color	  = (argument_count >= 3 ? argument[2] : undefined);
		isOutline = (argument_count >= 4 ? argument[3] : false);
		radius	  = (argument_count >= 5 ? argument[4] : undefined);

	#endregion
}