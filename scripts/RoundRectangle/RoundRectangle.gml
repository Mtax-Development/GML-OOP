/// @function				RoundRectangle()
/// @argument				{Vector4} location
/// @argument				{real} alpha?
/// @argument				{color|Color2|undefined} fill?
/// @argument				{color|Outline|undefined} outline?
/// @argument				{Vector2|undefined} radius?
///
/// @description			Constructs a Round Rectangle connected by two
///							points in a space, which can be rendered with
///							its full configuration or operated in other ways.
function RoundRectangle(_location) constructor
{
	#region [Methods]
		#region <Management>
			
			static construct = function(_location)
			{
				location = _location;
				alpha	 = (((argument_count > 1) and (argument[1] != undefined)) ? argument[1] : 1);
				fill	 = ((argument_count > 2) ? argument[2] : undefined);
				outline	 = ((argument_count > 3) ? argument[3] : undefined);
				radius	 = ((argument_count > 4) ? argument[4] : undefined);
			}
			
		#endregion
		#region <Execution>
			
			// @description			Execute the draw.
			static render = function()
			{
				if ((alpha > 0) and (fill != undefined))
				{
					draw_set_alpha(alpha);
					
					if (radius != undefined)
					{
						if (instanceof(fill) == "Color2")
						{
							draw_roundrect_color_ext(location.x1, location.y1, location.x2, 
													 location.y2, radius.x, radius.y, fill.color1, 
													 fill.color2, false);
						}
						else
						{
							draw_set_color(fill);
							draw_roundrect_ext(location.x1, location.y1, location.x2, location.y2,
											   radius.x, radius.y, false);
						}
					
					}
					else
					{
						if (instanceof(fill) == "Color2")
						{
							draw_roundrect_color(location.x1, location.y1, location.x2, location.y2,
												 fill.color1, fill.color2, false);
						}
						else
						{
							draw_set_color(fill);
							draw_roundrect(location.x1, location.y1, location.x2, location.y2, false);
						}
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
							
							if (radius != undefined)
							{
								var _i = 0;
							
								repeat (outline.size)
								{
									var _spacing = (_i + (outline.spacing * _i));
								
									draw_roundrect_ext((location.x1 - _spacing), 
													   (location.y1 - _spacing), 
													   (location.x2 + _spacing), 
													   (location.y2 + _spacing), 
													   radius.x, radius.y, true);
								
									++_i;
								}
							}
							else
							{
								var _i = 0;
							
								repeat (outline.size)
								{
									var _spacing = (_i + (outline.spacing * _i));
								
									draw_roundrect((location.x1 - _spacing), (location.y1 - _spacing), 
												   (location.x2 + _spacing), (location.y2 + _spacing), 
													true);
								
									++_i;
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
						
							if (radius != undefined)
							{
								draw_roundrect_ext(location.x1, location.y1, location.x2, location.y2,
												   radius.x, radius.y, true);
							}
							else
							{
								draw_roundrect(location.x1, location.y1, location.x2, location.y2, 
											   true);
							}
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
			//						specified object, treating this Shape as a non-round Rectangle.
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
							collision_rectangle_list(other.location.x1, other.location.y1, 
													 other.location.x2, other.location.y2,
													 _object, _precise, true, _list.ID,
													 _listOrdered);
						}
					}
					else
					{
						collision_rectangle_list(location.x1, location.y1, location.x2, location.y2,
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
							return collision_rectangle(other.location.x1, other.location.y1, 
													   other.location.x2, other.location.y2,
													   _object, _precise, true);
						}
					}
					else
					{
						return collision_rectangle(location.x1, location.y1, location.x2, location.y2,
												   _object, _precise, false);
					}
				}
			}
				
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape, treating this Shape
			//						as a non-round Rectangle.
			static mouseOver = function()
			{
				return location.isBetween(new Vector2(mouse_x, mouse_y));
			}
			
			// @argument			{mousebutton} button
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape while the specified
			//						mouse button is pressed or held, treating this Shape as a 
			//						non-round Rectangle.
			static click_hold = function(_button)
			{
				return ((mouse_check_button(_button)) 
				and (location.isBetween(new Vector2(mouse_x, mouse_y))))
			}
			
			// @argument			{mousebutton} button
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape while the specified
			//						mouse button was pressed in this frame, treating this Shape as a
			//						non-round Rectangle.
			static click_pressed = function(_button)
			{
				return ((mouse_check_button_pressed(_button)) 
				and (location.isBetween(new Vector2(mouse_x, mouse_y))))
			}
			
			// @argument			{mousebutton} button
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape while the specified
			//						mouse button was released in this frame, treating this Shape as a
			//						non-round Rectangle.
			static click_released = function(_button)
			{
				return ((mouse_check_button_released(_button)) 
				and (location.isBetween(new Vector2(mouse_x, mouse_y))))
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
