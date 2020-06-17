/// @function				Triangle();
/// @argument				location1 {Vector2}
/// @argument				location2 {Vector2}
/// @argument				location3 {Vector2}
/// @argument				alpha? {real}
/// @argument				fill? {color | Color3 | undefined}
/// @argument				outline? {color | undefined}
///
/// @description			Constructrs a triangle connected by three points
///							in a space, which can be rendered or operated in
///							other ways.
function Triangle(_location1, _location2, _location3) constructor
{
	#region [Methods]
	
		static render = function()
		{
			if ((fill != undefined) and (alpha > 0))
			{
				draw_set_alpha(alpha);
				
				if (instanceof(fill) == "Color3")
				{
					draw_triangle_color(location1.x, location1.y, location2.x, location2.y,
										location3.x, location3.y, fill.color1, fill.color2,
										fill.color3, false);
				}
				else
				{
					draw_set_color(fill);
						
					draw_triangle(location1.x, location1.y, location2.x, location2.y,
								  location3.x, location3.y, false);
				}
			}
			
			if (outline != undefined)
			{
				/* +TODO: Outline() constructor support.
				if (instanceof(outline) == "Outline")
				{
					if (outline.size > 0) and (outline.alpha > 0)
					{
						draw_set_alpha(outline.alpha);
						
						if (instanceof(outline.color) == "Color3")
						{
							for (var i = 0; i < outline.size; i++)
							{
								draw_triangle_color((location1.x), (location1.y), (location2.x), 
													(location2.y), (location3.x), (location3.y), 
													fill.color1, fill.color2, fill.color3, true);
							}
						}
						else
						{
							draw_set_color(outline.color);
							
							for (var i = 0; i < outline.size; i++)
							{
								draw_triangle((location1.x), (location1.y), (location2.x), 
											  (location2.y), (location3.x), (location3.y), 
											  true);
							}
						}
					}
				}
				else*/
				{
					draw_set_alpha(alpha);
					draw_set_color(outline);
				
					draw_triangle(location1.x, location1.y, location2.x, location2.y,
								  location3.x, location3.y, true);
				}
			}

		}
	
	#endregion
	#region [Constructor]
	
		location1 = _location1;
		location2 = _location2;
		location3 = _location3;
		alpha	  = (argument_count >= 4 ? argument[3] : 1);
		fill	  = (argument_count >= 5 ? argument[4] : undefined);
		outline   = (argument_count >= 6 ? argument[5] : undefined);
	
	#endregion
}
