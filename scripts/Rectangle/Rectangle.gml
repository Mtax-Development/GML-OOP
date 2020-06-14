/// @function				Rectangle();
/// @argument				location {Vector4}
/// @argument				alpha? {real}
/// @argument				fill? {color | Color4 | undefined}
/// @argument				outline? {color | Outline | undefined}
///
/// @description			Constructs a rectangle connected by four points
///							in a space, which can be rendered or operated in
///							other ways.
function Rectangle(_location) constructor
{
	#region [Methods]
	
		static render = function()
		{
			if ((fill != undefined) and (alpha > 0))
			{
				draw_set_alpha(alpha);
			
				if (is_struct(fill))
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
				if (is_struct(outline))
				{
					if (outline.size > 0) and (outline.alpha > 0)
					{
						draw_set_alpha(outline.alpha);
					
						if (is_struct(outline.color))
						{
							for (var i = 0; i < outline.size; i++)
							{
								draw_rectangle_color((location.x1 - i), (location.y1 - i), (location.x2 + i), (location.y2 + i), 
													 outline.color.x1y1, outline.color.x2y1, outline.color.x2y2, outline.color.x1y2, true);
							}
						}
						else
						{
							draw_set_color(outline.color);
						
							for (var i = 0; i < outline.size; i++)
							{
								draw_rectangle((location.x1 - i), (location.y1 - i), (location.x2 + i), (location.y2 + i), true);
							}
						}
					}
				}
				else
				{
					draw_set_alpha(alpha);
					draw_set_color(outline);
				
					draw_rectangle(location.x1, location.y1, location.x2, location.y2, true);
				}
			}
		}
	
	#endregion
	#region [Constructor]
	
		location = _location;
		alpha	 = (argument_count >= 2 ? argument[1] : 1);
		fill	 = (argument_count >= 3 ? argument[2] : undefined);
		outline	 = (argument_count >= 4 ? argument[3] : undefined);
	
	#endregion
}
