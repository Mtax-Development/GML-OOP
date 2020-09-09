/// @function				Line()
/// @argument				{Vector4} location
/// @argument				{real} alpha?
/// @argument				{color|color2|undefined} color?
/// @argument				{real} width?
///
/// @description			Construct a Line connected by two points
///							in a space, which can be rendered with its
///							full configuration or operated in other ways.
function Line(_location) constructor
{
	#region [Methods]
		#region <Execution>
			
			// @description			Execute the draw.
			static render = function()
			{
				if ((alpha > 0) and (color != undefined) and (width > 0))
				{
					draw_set_alpha(alpha);
					
					if (width > 1)
					{
						if (instanceof(color) == "Color2")
						{
							draw_line_width_color(location.x1, location.y1, location.x2, location.y2,
												  width, color.color1, color.color2);
						}
						else
						{
							draw_set_color(color);
							
							draw_line_width(location.x1, location.y1, location.x2, location.y2, 
											width);
						}
					}
					else
					{
						if (instanceof(color) == "Color2")
						{
							draw_line_color(location.x1, location.y1, location.x2, location.y2,
											color.color1, color.color2);
						}
						else
						{
							draw_set_color(color);
							
							draw_line(location.x1, location.y1, location.x2, location.y2);
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
			//						If specified, the additions to that List can be ordered by 
			//						distance from the center of the Shape.
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
							collision_line_list(other.location.x1, other.location.y1, 
												other.location.x2, other.location.y2,
												_object, _precise, true, _list.ID,
												_listOrdered);
						}
					}
					else
					{
						collision_line_list(location.x1, location.y1, location.x2, location.y2,
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
							return collision_line(other.location.x1, other.location.y1, 
												  other.location.x2, other.location.y2,
												  _object, _precise, true);
						}
					}
					else
					{
						return collision_line(location.x1, location.y1, location.x2, location.y2,
											  _object, _precise, false);
					}
				}
			}
			
			//+TODO: Line width support on collision
			
		#endregion
	#endregion
	#region [Constructor]
		
		location = _location;
		alpha = (((argument_count > 1) and (argument[1] != undefined)) ? argument[1] : 1);
		color = ((argument_count > 2) ? argument[2] : undefined);
		width = (((argument_count > 3) and (argument[3] != undefined)) ? argument[3] : 1);
		
	#endregion
}
