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
		#region <Management>
			
			static construct = function(_location, _radius)
			{
				location = _location;
				radius	 = _radius;
				alpha	 = (((argument_count > 2) and (argument[2] != undefined)) ? argument[2] : 1);
				fill	 = ((argument_count > 3) ? argument[3] : undefined);
				outline	 = ((argument_count > 4) ? argument[4] : undefined);
			}
			
		#endregion
		#region <Execution>
			
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
							
							if (is_real(outline.color))
							{
								draw_set_color(outline.color);
							}
							
							var _i = 0;
							
							repeat (outline.size)
							{
								var _spacing = (_i + (outline.spacing * _i));
								
								draw_circle(location.x, location.y, (radius + _spacing), true);
								
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
							
							draw_circle(location.x, location.y, radius, true);
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
							collision_circle_list(other.location.x, other.location.y, other.radius, 
												  _object, _precise, true, _list.ID, _listOrdered);
						}
					}
					else
					{
						collision_circle_list(location.x, location.y, radius, _object, _precise, 
											  false, _list.ID, _listOrdered);
					}
				
					return _list;
				}
				else
				{
					if (_excludedInstance)
					{				
						with (_excludedInstance)
						{
							return collision_circle(other.location.x, other.location.y, other.radius, 
												    _object, _precise, true);
						}
					}
					else
					{
						return collision_circle(location.x, location.y, radius, _object, _precise, 
												false);
					}
				}
			}
			
			// @argument			{Vector2} point
			// @returns				{bool}
			// @description			Check whether a point in space is within this Circle.
			static pointIn = function(_point)
			{
				return point_in_circle(_point.x, _point.y, location.x, location.y, radius);
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
