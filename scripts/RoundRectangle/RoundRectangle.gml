/// @function				RoundRectangle()
/// @argument				{Vector4} location
/// @argument				{real} alpha?
/// @argument				{color|Color2|undefined} fill?
/// @argument				{color|Outline|undefined} outline?
/// @argument				{Vector2|undefined} radius?
///
/// @description			Constructs a Round Rectangle connected by two
///							points in a space, which can be rendered with
///							its full configuration or operated in other ways.
function RoundRectangle(_location) constructor
{
	#region [Methods]
		
		// @description			Execute the draw.
		static render = function()
		{
			if ((alpha > 0) and (fill != undefined))
			{
				draw_set_alpha(alpha);
				
				if (radius != undefined)
				{
					if (instanceof(fill) == "Color2")
					{
						draw_roundrect_color_ext(location.x1, location.y1, location.x2, location.y2,
												 radius.x, radius.y, fill.color1, fill.color2, false);
					}
					else
					{
						draw_set_color(fill);
						draw_roundrect_ext(location.x1, location.y1, location.x2, location.y2,
										   radius.x, radius.y, false);
					}
					
				}
				else
				{
					if (instanceof(fill) == "Color2")
					{
						draw_roundrect_color(location.x1, location.y1, location.x2, location.y2,
											 fill.color1, fill.color2, false);
					}
					else
					{
						draw_set_color(fill);
						draw_roundrect(location.x1, location.y1, location.x2, location.y2, false);
					}
				}
			}
			
			if (outline != undefined)
			{
				if (instanceof(outline) == "Outline")
				{
					if ((outline.alpha > 0) and (outline.size > 0))
					{
						draw_set_alpha(outline.alpha);
						draw_set_color(outline.color);
						
						if (radius != undefined)
						{
							for (var i = 0; i < outline.size; i += outline.spacing)
							{
								draw_roundrect_ext((location.x1 - i), (location.y1 - i), 
												   (location.x2 + i), (location.y2 + i), 
												   radius.x, radius.y, true);
							}
						}
						else
						{
							for (var i = 0; i < outline.size; i += outline.spacing)
							{
								draw_roundrect((location.x1 - i), (location.y1 - i),
											   (location.x2 + i), (location.y2 + i), 
											   true);
							}
						}
					}
				}
				else
				{
					if (alpha > 0)
					{
						draw_set_alpha(alpha);
						draw_set_color(outline);
						
						if (radius != undefined)
						{
							draw_roundrect_ext(location.x1, location.y1, location.x2, location.y2,
											   radius.x, radius.y, true);
						}
						else
						{
							draw_roundrect(location.x1, location.y1, location.x2, location.y2, true);
						}
					}
				}
			}
		}
		
	#endregion
	#region [Constructor]
		
		location = _location;
		alpha	 = (argument_count >= 2 ? argument[1] : 1);
		fill	 = (argument_count >= 3 ? argument[2] : undefined);
		outline	 = (argument_count >= 4 ? argument[3] : undefined);
		radius	 = (argument_count >= 5 ? argument[4] : undefined);
		
	#endregion
}
