/// @function				Ellipse()
/// @argument				{Vector4} location
/// @argument				{real} alpha?
/// @argument				{color|Color2|undefined} fill?
/// @argument				{color|Outline|undefined} outline?
///
/// @description			Constructs an Ellipse connected by two points
///							in a space, which can be rendered with its full
///							configuration or operated in other ways.
function Ellipse(_location) constructor
{
	#region [Methods]
		
		// @description			Execute the draw.
		static render = function()
		{
			if ((alpha > 0) and (fill != undefined))
			{
				draw_set_alpha(alpha);
				
				if (instanceof(fill) == "Color2")
				{
					draw_ellipse_color(location.x1, location.y1, location.x2, location.y2,
									   fill.color1, fill.color2, false);
				}
				else
				{
					draw_set_color(fill);
					draw_ellipse(location.x1, location.y1, location.x2, location.y2, false);
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
						
						for (var _i = 0; _i < outline.size; _i += outline.spacing)
						{
							draw_ellipse((location.x1 - _i), (location.y1 - _i), (location.x2 + _i), 
										 (location.y2 + _i), true);
						}
					}
				}
				else
				{
					if (alpha > 0)
					{
						draw_set_alpha(alpha);
						draw_set_color(outline);
				
						draw_ellipse(location.x1, location.y1, location.x2, location.y2, true);
					}
				}
			}
		}
		
	#endregion
	#region [Constructor]
		
		location = _location;
		alpha = (argument_count >= 2 ? argument[1] : 1);
		fill = (argument_count >= 3 ? argument[2] : undefined);
		outline = (argument_count >= 4 ? argument[3] : undefined);
		
	#endregion
}
