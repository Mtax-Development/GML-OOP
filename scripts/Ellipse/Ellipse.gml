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
						
						if (is_real(outline.color))
						{
							draw_set_color(outline.color);
						}
						
						var _i = 0;
						
						repeat (outline.size)
						{
							var _spacing = (_i + (outline.spacing * _i));
							
							draw_ellipse((location.x1 - _spacing), (location.y1 - _spacing), 
										 (location.x2 + _spacing), (location.y2 + _spacing),
										 true);
							
							++_i;
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
			
		// @argument			{object} object
		// @argument			{bool} precise?
		// @argument			{instance} excludedInstance?
		// @argument			{bool|List} list?
		// @argument			{bool} listOrdered?
		// @returns				{int|List}
		// @description			Check for a collision within this Shape with instances of the
		//						specified object.
		//						Returns the ID of a single colliding instance or noone.
		//						If List use is specified, a List will be returned instead, either
		//						empty or containing IDs of the colliding instances.
		//						If specified, the additions to that List can be ordered by distance
		//						from the center of the Shape.
		static collision = function(_object)
		{
			var _precise = (((argument_count > 1) and (argument[1] != undefined)) ? 
						   argument[1] : false);
			var _excludedInstance = ((argument_count > 2) ? argument[2] : undefined);
			var _list = ((argument_count > 3) ? argument[3] : undefined);
			var _listOrdered = (((argument_count > 4) and (argument[4] != undefined)) ? 
							   argument[4] : false);
			
			if (_list)
			{
				if (instanceof(_list) != "List")
				{
					_list = new List();
				}
				
				if (_excludedInstance)
				{
					with (_excludedInstance)
					{
						collision_ellipse_list(other.location.x1, other.location.y1, 
											   other.location.x2, other.location.y2,
											   _object, _precise, true, _list.ID,
											   _listOrdered);
					}
				}
				else
				{
					collision_ellipse_list(location.x1, location.y1, location.x2, location.y2,
										   _object, _precise, false, _list.ID, _listOrdered);
				}
				
				return _list;
			}
			else
			{
				if (_excludedInstance)
				{				
					with (_excludedInstance)
					{
						return collision_ellipse(other.location.x1, other.location.y1, 
												 other.location.x2, other.location.y2,
												 _object, _precise, true);
					}
				}
				else
				{
					return collision_ellipse(location.x1, location.y1, location.x2, location.y2,
											 _object, _precise, false);
				}
			}
		}
		
	#endregion
	#region [Constructor]
		
		location = _location;
		alpha = (((argument_count > 1) and (argument[1] != undefined)) ? argument[1] : 1);
		fill = ((argument_count > 2) ? argument[2] : undefined);
		outline = ((argument_count > 3) ? argument[3] : undefined);
		
	#endregion
}
