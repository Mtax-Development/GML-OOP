/// @function				Rectangle()
/// @argument				{Vector4} location
/// @argument				{real} alpha?
/// @argument				{color|Color4|undefined} fill?
/// @argument				{color|Outline|undefined} outline?
///
/// @description			Constructs a Rectangle connected by two points
///							in a space, which can be rendered with its full
///							configuration or operated in other ways.
function Rectangle(_location) constructor
{
	#region [Methods]
		
		// @description			Execute the draw.
		static render = function()
		{
			if ((alpha > 0) and (fill != undefined))
			{
				draw_set_alpha(alpha);
			
				if (instanceof(fill) == "Color4")
				{
					draw_rectangle_color(location.x1, location.y1, location.x2, location.y2,
										 fill.x1y1, fill.x2y1, fill.x2y2, fill.x1y2, false);
				}
				else
				{
					draw_set_color(fill);

					draw_rectangle(location.x1, location.y1, location.x2, location.y2, false);
				}
			}
			
			if (outline != undefined)
			{
				if (instanceof(outline) == "Outline")
				{
					if (outline.size > 0) and (outline.alpha > 0)
					{
						draw_set_alpha(outline.alpha);
						
						if (instanceof(outline.color) == "Color4")
						{
							for (var i = 0; i < outline.size; i += outline.spacing)
							{
								draw_rectangle_color((location.x1 - i), (location.y1 - i), 
													 (location.x2 + i), (location.y2 + i), 
													 outline.color.x1y1, outline.color.x2y1, 
													 outline.color.x2y2, outline.color.x1y2, 
													 true);
							}
						}
						else
						{
							draw_set_color(outline.color);
							
							for (var i = 0; i < outline.size; i += outline.spacing)
							{
								draw_rectangle((location.x1 - i), (location.y1 - i), 
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
				
						draw_rectangle(location.x1, location.y1, location.x2, location.y2, true);
					}
				}
			}
		}
		
		// @argument			{Vector2} point
		// @returns				{bool}
		// @description			Checks whether a point in space is within this Rectangle.
		static pointIn = function(_point)
		{
			return point_in_rectangle(_point.x, _point.y, location.x1, location.y1,
									  location.x2, location.y2);
		}
		
	#endregion
	#region [Constructor]
		
		location = _location;
		alpha	 = (argument_count >= 2 ? argument[1] : 1);
		fill	 = (argument_count >= 3 ? argument[2] : undefined);
		outline	 = (argument_count >= 4 ? argument[3] : undefined);
		
	#endregion
}
