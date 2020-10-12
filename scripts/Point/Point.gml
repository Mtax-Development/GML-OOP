/// @function				Point()
/// @argument				{Vector2} location
/// @argument				{real} alpha?
/// @argument				{color|undefined} color?
///
/// @description			Constructs a Point in a space, which can be rendered as a single
///							pixel with its full configuration or operated in other ways.
function Point(_location) constructor
{
	#region [Methods]
		#region <Management>
			
			static construct = function(_location)
			{
				location = _location;
				alpha = (((argument_count > 1) and (argument[1] != undefined)) ? argument[1] : 1);
				color = ((argument_count > 2) ? argument[2] : undefined);
			}
			
		#endregion
		#region <Execution>
			
			// @description			Execute the draw.
			static render = function()
			{
				if ((alpha > 0) and (color != undefined))
				{
					draw_set_alpha(alpha);
					draw_set_color(color);
					
					draw_point(location.x, location.y);
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
							collision_point_list(other.location.x, other.location.y, _object, 
												 _precise, true, _list.ID, _listOrdered);
						}
					}
					else
					{
						collision_point_list(location.x, location.y, _object, _precise, false, 
											 _list.ID, _listOrdered);
					}
					
					return _list;
				}
				else
				{
					if (_excludedInstance)
					{				
						with (_excludedInstance)
						{
							return collision_point(other.location.x, other.location.y, _object, 
												   _precise, true);
						}
					}
					else
					{
						return collision_point(location.x, location.y, _object, _precise, false);
					}
				}
			}
			
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape.
			static mouseOver = function()
			{
				return location.equals(new Vector2(mouse_x, mouse_y));
			}
			
			// @argument			{mousebutton} button
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape while the specified
			//						mouse button is pressed or held.
			static click_hold = function(_button)
			{
				return ((mouse_check_button(_button)) 
				and (location.equals(new Vector2(mouse_x, mouse_y))))
			}
			
			// @argument			{mousebutton} button
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape while the specified
			//						mouse button was pressed in this frame.
			static click_pressed = function(_button)
			{
				return ((mouse_check_button_pressed(_button)) 
				and (location.equals(new Vector2(mouse_x, mouse_y))))
			}
			
			// @argument			{mousebutton} button
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape while the specified
			//						mouse button was released in this frame.
			static click_released = function(_button)
			{
				return ((mouse_check_button_released(_button)) 
				and (location.equals(new Vector2(mouse_x, mouse_y))))
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
