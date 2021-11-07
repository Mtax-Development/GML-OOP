/// @function				Line()
/// @argument				{Vector4} location
/// @argument				{real} size?
/// @argument				{int:color|Color2|Color4} color?
/// @argument				{real} alpha?
///							
/// @description			Construct a Line Shape.
///							
///							Construction types:
///							- New constructor.
///							- Empty: {void|undefined}
///							- Constructor copy: {Line} other
function Line() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				location = undefined;
				size = undefined;
				color = undefined;
				alpha = undefined;
				
				event =
				{
					beforeRender:
					{
						callback: undefined,
						argument: undefined
					},
					
					afterRender:
					{
						callback: undefined,
						argument: undefined
					}
				};
				
				if (argument_count > 0)
				{
					if (instanceof(argument[0]) == "Line")
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						location = ((instanceof(_other.location) == "Vector4")
									? new Vector4(_other.location) : _other.location);
						size = _other.size;
						
						switch (instanceof(_other.color))
						{
							case "Color4":
								color = new Color4(_other.color);
							break;
							
							case "Color2":
								color = new Color2(_other.color);
							break;
							
							default:
								color = _other.color;
							break;
						}
						
						alpha = _other.alpha;
						
						if (is_struct(_other.event))
						{
							event.beforeRender.callback = _other.event.beforeRender.callback;
							event.beforeRender.argument = _other.event.beforeRender.argument;
							event.afterRender.callback = _other.event.afterRender.callback;
							event.afterRender.argument = _other.event.afterRender.argument;
						}
						else
						{
							event = _other.event;
						}
					}
					else
					{
						//|Construction type: New constructor.
						location = argument[0];
						size = (((argument_count > 1) and (argument[1] != undefined)) ? argument[1]
																					  : 1);
						color = (((argument_count > 2) and (argument[2] != undefined)) ? argument[2] 
																					   : c_white);
						alpha = (((argument_count > 3) and (argument[3] != undefined)) ? argument[3]
																					   : 1);
					}
				}
				
				return self;
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((instanceof(location) == "Vector4") and (location.isFunctional())
						and (is_real(size)));
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{object} object
			// @argument			{bool} precise?
			// @argument			{int:instance} excludedInstance?
			// @argument			{bool|List} list?
			// @argument			{bool} listOrdered?
			// @returns				{int|List}
			// @description			Check for a collision within this Shape with instances of the
			//						specified object, treating the size of this Shape as 1.
			//						Returns the ID of a single colliding instance or noone.
			//						If List use is specified, a List will be returned instead, either
			//						empty or containing IDs of the colliding instances.
			//						If specified, the additions to that List can be ordered by 
			//						distance from the center of the Shape.
			static collision = function(_object, _precise = false, _excludedInstance, _list = false,
										_listOrdered = false)
			{
				if (_list)
				{
					if (instanceof(_list) != "List")
					{
						_list = new List();
					}
					
					if ((is_real(_excludedInstance)) and (instance_exists(_excludedInstance)))
					{
						with (_excludedInstance)
						{
							collision_line_list(other.location.x1, other.location.y1,
												other.location.x2, other.location.y2,
												_object, _precise, true, _list.ID, _listOrdered);
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
					if ((is_real(_excludedInstance)) and (instance_exists(_excludedInstance)))
					{
						with (_excludedInstance)
						{
							return collision_line(other.location.x1, other.location.y1,
												  other.location.x2, other.location.y2, _object,
												  _precise, true);
						}
					}
					else
					{
						return collision_line(location.x1, location.y1, location.x2, location.y2,
											  _object, _precise, false);
					}
				}
			}
			
		#endregion
		#region <Execution>
			
			// @description			Execute the draw of this Shape as a sprite.
			static render = function()
			{
				static __createPixelSprite = function()
				{
					var _surface = surface_create(1, 1);
					
					surface_set_target(_surface);
					{
						draw_clear(c_white);
					}
					surface_reset_target();
					
					var _sprite = sprite_create_from_surface(_surface, 0, 0, 1, 1, false, false, 0,
															 0);
					
					surface_free(_surface);
					
					return _sprite;
				}
				
				static _pixelSprite = __createPixelSprite();
				
				if (self.isFunctional())
				{
					if ((alpha > 0) and (size != 0))
					{
						if ((is_struct(event))) and (is_method(event.beforeRender.callback))
						{
							script_execute_ext(method_get_index(event.beforeRender.callback),
											   ((is_array(event.beforeRender.argument)
												? event.beforeRender.argument
												: [event.beforeRender.argument])));
						}
						
						var _color1, _color2, _color3, _color4;
						
						switch (instanceof(color))
						{
							case "Color4":
								_color1 = color.color1;
								_color2 = color.color2;
								_color3 = color.color3;
								_color4 = color.color4;
							break;
							
							case "Color2":
								_color1 = color.color1;
								_color2 = color.color2;
								_color3 = color.color2;
								_color4 = color.color1;
							break;
							
							default:
								_color1 = color;
								_color2 = color;
								_color3 = color;
								_color4 = color;
							break;
						}
						
						var _sizeOffset = (size * 0.5);
						
						var _distance = point_distance(location.x1, location.y1, location.x2,
													   location.y2);
						var _angle = point_direction(location.x1, location.y1, location.x2,
													 location.y2);
						
						var _x1 = (location.x1 + lengthdir_x(_sizeOffset, (_angle + 90)));
						var _y1 = (location.y1 + lengthdir_y(_sizeOffset, (_angle + 90)));
						
						draw_sprite_general(_pixelSprite, 0, 0, 0, 1, 1, _x1, _y1, _distance, size,
											_angle, _color1, _color2, _color3, _color4, alpha);
						
						if ((is_struct(event))) and (is_method(event.afterRender.callback))
						{
							script_execute_ext(method_get_index(event.afterRender.callback),
											   ((is_array(event.afterRender.argument)
												? event.afterRender.argument
												: [event.afterRender.argument])));
						}
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "render";
					var _errorText = ("Attempted to render an invalid Shape: " +
									  "{" + string(self) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @argument			{bool} full?
			// @argument			{bool} color_HSV?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the properties of this Shape.
			static toString = function(_multiline = false, _full = false, _color_HSV = false)
			{
				var _string = "";
				
				var _mark_separator = ((_multiline) ? "\n" : ", ");
				
				if (!_full)
				{
					_string = ("Location: " + string(location) + _mark_separator +
							   "Size: " + string(size));
				}
				else
				{
					var _string_color;
					var _mark_separator_inline = ", ";
					
					if (is_real(color))
					{
						switch (color)
						{
							case c_aqua: _string_color = "Aqua"; break;
							case c_black: _string_color = "Black"; break;
							case c_blue: _string_color = "Blue"; break;
							case c_dkgray: _string_color = "Dark Gray"; break;
							case c_fuchsia: _string_color = "Fuchsia"; break;
							case c_gray: _string_color = "Gray"; break;
							case c_green: _string_color = "Green"; break;
							case c_lime: _string_color = "Lime"; break;
							case c_ltgray: _string_color = "Light Gray"; break;
							case c_maroon: _string_color = "Maroon"; break;
							case c_navy: _string_color = "Navy"; break;
							case c_olive: _string_color = "Olive"; break;
							case c_orange: _string_color = "Orange"; break;
							case c_purple: _string_color = "Purple"; break;
							case c_red: _string_color = "Red"; break;
							case c_teal: _string_color = "Teal"; break;
							case c_white: _string_color = "White"; break;
							case c_yellow: _string_color = "Yellow"; break;
							default:
								if (_color_HSV)
								{
									_string_color = 
									("(" +
									 "Hue: " + string(color_get_hue(color)) + _mark_separator_inline +
									 "Saturation: " + string(color_get_saturation(color))
													+ _mark_separator_inline +
									 "Value: " + string(color_get_value(color)) +
									 ")");
								}
								else
								{
									_string_color = 
									("(" +
									 "Red: " + string(color_get_red(color)) + _mark_separator_inline +
									 "Green: " + string(color_get_green(color))
											   + _mark_separator_inline +
									 "Blue: " + string(color_get_blue(color)) +
									 ")");
								}
							break;
						}
					}
					else
					{
						if (instanceof(color) == "Color2")
						{
							_string_color = color.toString(false, _color_HSV);
						}
						else
						{
							_string_color = string(color);
						}
					}
				
					_string = ("Location: " + string(location) + _mark_separator +
							   "Size: " + string(size) + _mark_separator +
							   "Color: " + _string_color + _mark_separator +
							   "Alpha: " + string(alpha));
				}
				
				return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
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
		
		script_execute_ext(method_get_index(self.construct), argument_original);
		
	#endregion
}
