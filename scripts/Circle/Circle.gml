/// @function				Circle()
/// @argument				{Vector2} location
/// @argument				{real} radius
/// @argument				{real} alpha?
/// @argument				{color|Color2|undefined} fill?
/// @argument				{color|Outline|undefined} outline?
///
/// @description			Constructs a Circle in a point in the space at
///							specified radius, which can be rendered with its
///							full configuration or operated in other ways.
function Circle(_location, _radius) constructor
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
					draw_circle_color(location.x, location.y, radius, 
									  fill.color1, fill.color2, false);
				}
				else
				{
					draw_set_color(fill);
					
					draw_circle(location.x, location.y, radius, false);
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
							draw_circle(location.x, location.y, (radius + _i), true);
						}
					}
				}
				else
				{
					if (alpha > 0)
					{
						draw_set_alpha(alpha);
						draw_set_color(outline);
					
						draw_circle(location.x, location.y, radius, true);
					}
				}
			}
		}
		
		// @argument			{Vector2} point
		// @returns				{bool}
		// @description			Checks whether a point in space is within this Circle.
		static pointIn = function(_point)
		{
			return point_in_circle(_point.x, _point.y, location.x, location.y, radius);
		}
		
	#endregion
	#region [Constructor]
		
		location = _location;
		radius	 = _radius;
		alpha	 = (((argument_count > 2) and (argument[2] != undefined)) ? argument[2] : 1);
		fill	 = ((argument_count > 3) ? argument[3] : undefined);
		outline	 = ((argument_count > 4) ? argument[4] : undefined);
		
	#endregion
}
