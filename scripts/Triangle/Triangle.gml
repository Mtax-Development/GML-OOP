/// @function				Triangle()
/// @argument				{Vector2} location1
/// @argument				{Vector2} location2
/// @argument				{Vector2} location3
/// @argument				{real} alpha?
/// @argument				{color|Color3|undefined} fill?
/// @argument				{color|undefined} outline?
///
/// @description			Constructs a Triangle connected by three points
///							in a space, which can be rendered with its full
///							configuration or operated in other ways.
function Triangle(_location1, _location2, _location3) constructor
{
	#region [Methods]
		#region <Management>
			
			static construct = function(_location1, _location2, _location3)
			{
				location1 = _location1;
				location2 = _location2;
				location3 = _location3;
				alpha	  = (((argument_count > 3) and (argument[3] != undefined)) ? argument[3] : 1);
				fill	  = (argument_count > 4 ? argument[4] : undefined);
				outline   = (argument_count > 5 ? argument[5] : undefined);
			}
			
		#endregion
		#region <Execution>
			
			// @description			Execute the draw.
			static render = function()
			{
				if ((alpha > 0) and (fill != undefined))
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
								for (var _i = 0; _i < outline.size; _i++)
								{
									draw_triangle_color((location1.x), (location1.y), (location2.x), 
														(location2.y), (location3.x), (location3.y), 
														fill.color1, fill.color2, fill.color3, true);
								}
							}
							else
							{
								draw_set_color(outline.color);
								
								for (var _i = 0; _i < outline.size; _i++)
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
						if (alpha > 0)
						{
							draw_set_alpha(alpha);
							draw_set_color(outline);
							
							draw_triangle(location1.x, location1.y, location2.x, location2.y,
										  location3.x, location3.y, true);
						}
					}
				}
			}
			
			// @argument			{Vector2} point
			// @returns				{bool}
			// @description			Checks whether a point in space is within this Triangle.
			static pointIn = function(_point)
			{
				return point_in_triangle(_point.x, _point.y, location1.x, location1.y,
										 location2.x, location2.y, location3.x, location3.y);
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		argument_original = array_create(argument_count, undefined);
		
		var _i = 0;
		repeat (argument_count)
		{
			argument_original[_i] = argument[_i];
			
			++_i;
		}
		
		if (argument_count <= 0)
		{
			self.construct();
		}
		else
		{
			script_execute_ext(method_get_index(self.construct), argument_original);
		}
		
	#endregion
}
