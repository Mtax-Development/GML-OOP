/// @function				Circle();
/// @argument				location {Vector2}
/// @argument				radius {real}
/// @argument				alpha? {real}
/// @argument				fill? {color | Color2 | undefined}
/// @argument				outline? {color | Outline | undefined}
///
/// @description			Constructs a circle in a point in the space at
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
					draw_circle_color(location.x, location.y, radius, fill.color1, fill.color2, false);
				}
				else
				{
					draw_set_color(fill);
					
					draw_circle(location.x, location.y, radius, false);
				}
			}
		
			if (outline != undefined)
			{
				// +TODO: Draw circle on circle if alpha of both fill and outline is 1.
				if (instanceof(outline) == "Outline")
				{
					if (outline.size > 0) and (outline.alpha > 0)
					{
						draw_set_alpha(outline.alpha);
						draw_set_color(outline.color);
						
						for (var i = 0; i < outline.size; i++)
						{
							draw_circle(location.x, location.y, (radius + i), true);
						}
					}
				}
				else
				{
					draw_set_alpha(alpha);
					draw_set_color(outline);
					
					draw_circle(location.x, location.y, radius, true);
				}
			}
		}
		
	#endregion
	#region [Constructor]
	
		location = _location;
		radius	 = _radius;
		alpha	 = (argument_count >= 3 ? argument[2] : 1);
		fill	 = (argument_count >= 4 ? argument[3] : undefined);
		outline	 = (argument_count >= 5 ? argument[4] : undefined);
	
	#endregion
}
