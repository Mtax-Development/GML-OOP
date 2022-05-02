/// @function				RoundRectangle()
/// @argument				{Vector4} location
/// @argument				{Vector2} radius?
/// @argument				{int:color|Color2} fill_color?
/// @argument				{real} fill_alpha?
/// @argument				{int:color} outline_color?
/// @argument				{real} outline_alpha?
///							
/// @description			Constructs a Round Rectangle Shape.
///							
///							Construction types:
///							- New constructor.
///							- Empty: {void|undefined}
///							- Constructor copy: {RoundRectangle} other
function RoundRectangle() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				location = undefined;
				radius = undefined;
				fill_color = undefined;
				fill_alpha = undefined;
				outline_color = undefined;
				outline_alpha = undefined;
				
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
					if (instanceof(argument[0]) == "RoundRectangle")
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						location = ((instanceof(_other.location) == "Vector4")
									? new Vector4(_other.location) : _other.location);
						radius = ((instanceof(_other.radius) == "Vector2")
								  ? new Vector2(_other.radius) : _other.radius);
						fill_color = ((instanceof(_other.fill_color) == "Color2")
									  ? new Color2(_other.fill_color) : _other.fill_color);
						fill_alpha = _other.fill_alpha;
						outline_color = _other.outline_color;
						outline_alpha = _other.outline_alpha;
						
						if (is_struct(_other.event))
						{
							event = {};
							
							var _eventList = variable_struct_get_names(_other.event);
							
							var _i = [0, 0];
							repeat (array_length(_eventList))
							{
								var _event = {};
								var _other_event = variable_struct_get(_other.event,
																	   _eventList[_i[0]]);
								var _eventPropertyList = variable_struct_get_names(_other_event);
								
								_i[1] = 0;
								repeat (array_length(_eventPropertyList))
								{
									var _property = variable_struct_get(_other_event,
																		_eventPropertyList[_i[1]]);
									
									var _value = _property;
									
									if (is_array(_property))
									{
										_value = [];
										
										array_copy(_value, 0, _property, 0, array_length(_property));
									}
									
									variable_struct_set(_event, _eventPropertyList[_i[1]], _value);
									
									++_i[1];
								}
								
								variable_struct_set(event, _eventList[_i[0]], _event);
								
								++_i[0];
							}
						}
						else
						{
							event = _other.event;
						}
					}
					else
					{
						//|Construction type: Constructor copy.
						location = argument[0];
						radius = (((argument_count > 1) and (argument[1] != undefined))
								  ? argument[1] : new Vector2(1, 1));
						fill_color = ((argument_count > 2) ? argument[2] : undefined);
						fill_alpha = ((argument_count > 3) ? argument[3] : undefined);
						outline_color = ((argument_count > 4) ? argument[4] : undefined);
						outline_alpha = ((argument_count > 5) ? argument[5] : undefined);
					}
				}
				
				return self;
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return (((instanceof(location) == "Vector4") and (location.isFunctional()))
						and ((instanceof(radius) == "Vector2") and (radius.isFunctional())));
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
			//						specified object, treating this Shape as an unrounded Rectangle.
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
					if ((is_real(_excludedInstance)) and (instance_exists(_excludedInstance)))
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
			
			// @argument			{Vector2} point
			// @returns				{bool}
			// @description			Checks whether a point in space is within this Rectangle, treating
			//						this Shape as an unrounded Rectangle.
			static containsPoint = function(_point)
			{
				return point_in_rectangle(_point.x, _point.y, location.x1, location.y1, location.x2,
										  location.y2);
			}
			
			// @argument			{int} device?
			// @argument			{bool} GUI?
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape, treating this Shape
			//						as an unrounded Rectangle.
			//						If the device is specified, the position of the cursor on the GUI
			//						layer can be used.
			static cursorOver = function(_device, _GUI = false)
			{
				var _cursor_x, _cursor_y;
				
				if (_device == undefined)
				{
					_cursor_x = mouse_x;
					_cursor_y = mouse_y;
				}
				else
				{
					if (_GUI)
					{
						_cursor_x = device_mouse_x_to_gui(_device);
						_cursor_y = device_mouse_y_to_gui(_device);
					}
					else
					{
						_cursor_x = device_mouse_x(_device);
						_cursor_y = device_mouse_y(_device);
					}
				}
				
				return ((_cursor_x == clamp(_cursor_x, location.x1, location.x2)) 
						and (_cursor_y == clamp(_cursor_y, location.y1, location.y2)));
			}
			
			// @argument			{constant:mb_*} button
			// @argument			{int} device?
			// @argument			{bool} GUI?
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape while its specified
			//						mouse button is pressed or held, treating this Shape as an
			//						unrounded Rectangle.
			//						If the device is specified, the position of the cursor on the GUI
			//						layer can be used.
			static cursorHold = function(_button, _device, _GUI = false)
			{
				var _cursor_x, _cursor_y;
				
				if (_device == undefined)
				{
					_cursor_x = mouse_x;
					_cursor_y = mouse_y;
				}
				else
				{
					if (_GUI)
					{
						_cursor_x = device_mouse_x_to_gui(_device);
						_cursor_y = device_mouse_y_to_gui(_device);
					}
					else
					{
						_cursor_x = device_mouse_x(_device);
						_cursor_y = device_mouse_y(_device);
					}
				}
				
				if ((_cursor_x == clamp(_cursor_x, location.x1, location.x2))
				and (_cursor_y == clamp(_cursor_y, location.y1, location.y2)))
				{	
					return ((_device == undefined) ? mouse_check_button(_button)
												   : device_mouse_check_button(_device, _button))
				}
				else
				{
					return false;
				}
			}
			
			// @argument			{constant:mb_*} button
			// @argument			{int} device?
			// @argument			{bool} GUI?
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape while its specified
			//						mouse button was pressed in this frame, treating this Shape as an
			//						unrounded Rectangle.
			//						If the device is specified, the position of the cursor on the GUI
			//						layer can be used.
			static cursorPressed = function(_button, _device, _GUI = false)
			{
				var _cursor_x, _cursor_y;
				
				if (_device == undefined)
				{
					_cursor_x = mouse_x;
					_cursor_y = mouse_y;
				}
				else
				{
					if (_GUI)
					{
						_cursor_x = device_mouse_x_to_gui(_device);
						_cursor_y = device_mouse_y_to_gui(_device);
					}
					else
					{
						_cursor_x = device_mouse_x(_device);
						_cursor_y = device_mouse_y(_device);
					}
				}
				
				if ((_cursor_x == clamp(_cursor_x, location.x1, location.x2))
				and (_cursor_y == clamp(_cursor_y, location.y1, location.y2)))
				{	
					return ((_device == undefined) ? mouse_check_button_pressed(_button)
												   : device_mouse_check_button_pressed(_device,
																					   _button))
				}
				else
				{
					return false;
				}
			}
			
			// @argument			{constant:mb_*} button
			// @argument			{int} device?
			// @argument			{bool} GUI?
			// @returns				{bool}
			// @description			Check if the system cursor is over this Shape while the specified
			//						mouse button was released in this frame, treating this Shape as an
			//						unrounded Rectangle.
			//						If the device is specified, the position of the cursor on the GUI
			//						layer can be used.
			static cursorReleased = function(_button, _device, _GUI = false)
			{
				var _cursor_x, _cursor_y;
				
				if (_device == undefined)
				{
					_cursor_x = mouse_x;
					_cursor_y = mouse_y;
				}
				else
				{
					if (_GUI)
					{
						_cursor_x = device_mouse_x_to_gui(_device);
						_cursor_y = device_mouse_y_to_gui(_device);
					}
					else
					{
						_cursor_x = device_mouse_x(_device);
						_cursor_y = device_mouse_y(_device);
					}
				}
				
				if ((_cursor_x == clamp(_cursor_x, location.x1, location.x2))
				and (_cursor_y == clamp(_cursor_y, location.y1, location.y2)))
				{	
					return ((_device == undefined) ? mouse_check_button_released(_button)
												   : device_mouse_check_button_released(_device,
																						_button))
				}
				else
				{
					return false;
				}
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{Vector2} location?
			// @argument			{real} radius?
			// @argument			{int:color|Color2} fill_color?
			// @argument			{real} fill_alpha?
			// @argument			{int:color} outline_color?
			// @argument			{real} outline_alpha?
			// @description			Execute the draw of this Shape as a form, using data of this
			//						constructor or specified replaced parts of it for this call only.
			//						NOTE: Form drawing produces inconsistent results across devices
			//						and export targets due to their technical differences.
			//						Sprite drawing should be used instead for accurate results.
			static render = function(_location, _radius, _fill_color, _fill_alpha, _outline_color,
									 _outline_alpha)
			{
				var _location_original = location;
				var _radius_original = radius;
				var _fill_color_original = fill_color;
				var _fill_alpha_original = fill_alpha;
				var _outline_color_original = outline_color;
				var _outline_alpha_original = outline_alpha;
				
				location = (_location ?? location);
				radius = (_radius ?? radius);
				fill_color = (_fill_color ?? fill_color);
				fill_alpha = (_fill_alpha ?? fill_alpha);
				outline_color = (_outline_color ?? outline_color);
				outline_alpha = (_outline_alpha ?? outline_alpha);
				
				if (self.isFunctional())
				{
					if ((is_struct(event)) and (event.beforeRender.callback != undefined))
					{
						var _callback = ((is_array(event.beforeRender.callback))
										 ? event.beforeRender.callback
										 : [event.beforeRender.callback]);
						var _callback_count = array_length(_callback);
						var _argument = ((is_array(event.beforeRender.argument))
										 ? event.beforeRender.argument
										 : array_create(_callback_count,
														event.beforeRender.argument));
						
						var _i = 0;
						repeat (_callback_count)
						{
							if (is_method(_callback[_i]))
							{
								script_execute_ext(method_get_index(_callback[_i]),
												   ((is_array(_argument[_i]) ? _argument[_i]
																			 : [_argument[_i]])));
							}
							
							++_i;
						}
					}
					
					var _location_x1 = round(location.x1);
					var _location_y1 = round(location.y1);
					var _location_x2 = round(location.x2);
					var _location_y2 = round(location.y2);
					
					if ((fill_color != undefined) and (fill_alpha > 0))
					{
						var _color1, _color2;
						
						if (instanceof(fill_color) == "Color2")
						{
							_color1 = fill_color.color1;
							_color2 = fill_color.color2;
						}
						else
						{
							_color1 = fill_color;
							_color2 = fill_color;
						}
						
						if (instanceof(fill_color) == "Color2")
						{
							_color1 = fill_color.color1;
							_color2 = fill_color.color2;
						}
						
						draw_set_alpha(fill_alpha);
						
						draw_roundrect_color_ext(_location_x1, _location_y1, _location_x2,
												 _location_y2, radius.x, radius.y, _color1, _color2,
												 false);
					}
				
					if ((outline_color != undefined) and (outline_alpha > 0))
					{
						draw_set_alpha(outline_alpha);
					
						draw_roundrect_color_ext(_location_x1, _location_y1, _location_x2,
												 _location_y2, radius.x, radius.y, outline_color,
												 outline_color, true);
					}
					
					if ((is_struct(event)) and (event.afterRender.callback != undefined))
					{
						var _callback = ((is_array(event.afterRender.callback))
										 ? event.afterRender.callback : [event.afterRender.callback]);
						var _callback_count = array_length(_callback);
						var _argument = ((is_array(event.afterRender.argument))
										 ? event.afterRender.argument
										 : array_create(_callback_count, event.afterRender.argument));
						
						var _i = 0;
						repeat (_callback_count)
						{
							if (is_method(_callback[_i]))
							{
								script_execute_ext(method_get_index(_callback[_i]),
												   ((is_array(_argument[_i]) ? _argument[_i]
																			 : [_argument[_i]])));
							}
							
							++_i;
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
				
				location = _location_original;
				radius = _radius_original;
				fill_color = _fill_color_original;
				fill_alpha = _fill_alpha_original;
				outline_color = _outline_color_original;
				outline_alpha = _outline_alpha_original;
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @argument			{bool} full?
			// @argument			{bool} colorHSV?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the properties of this Shape.
			static toString = function(_multiline = false, _full = false, _colorHSV = false)
			{
				var _string = "";
				var _mark_separator = ((_multiline) ? "\n" : ", ");
				
				if (!_full)
				{
					_string = ("Location: " + string(location) + _mark_separator +
							   "Radius: " + string(radius));
				}
				else
				{
					var _color = [fill_color, outline_color];
					var _color_count = array_length(_color);
					var _string_color = array_create(_color_count, "");
					
					var _mark_separator_inline = ", ";
					
					var _i = 0;
					repeat (_color_count)
					{
						if (is_real(_color[_i]))
						{
							switch (_color[_i])
							{
								case c_aqua: _string_color[_i] = "Aqua"; break;
								case c_black: _string_color[_i] = "Black"; break;
								case c_blue: _string_color[_i] = "Blue"; break;
								case c_dkgray: _string_color[_i] = "Dark Gray"; break;
								case c_fuchsia: _string_color[_i] = "Fuchsia"; break;
								case c_gray: _string_color[_i] = "Gray"; break;
								case c_green: _string_color[_i] = "Green"; break;
								case c_lime: _string_color[_i] = "Lime"; break;
								case c_ltgray: _string_color[_i] = "Light Gray"; break;
								case c_maroon: _string_color[_i] = "Maroon"; break;
								case c_navy: _string_color[_i] = "Navy"; break;
								case c_olive: _string_color[_i] = "Olive"; break;
								case c_orange: _string_color[_i] = "Orange"; break;
								case c_purple: _string_color[_i] = "Purple"; break;
								case c_red: _string_color[_i] = "Red"; break;
								case c_teal: _string_color[_i] = "Teal"; break;
								case c_white: _string_color[_i] = "White"; break;
								case c_yellow: _string_color[_i] = "Yellow"; break;
								default:
									if (_colorHSV)
									{
										_string_color[_i] =
										("(" +
										 "Hue: " + string(color_get_hue(_color[_i]))
												 + _mark_separator_inline +
										 "Saturation: " + string(color_get_saturation(_color[_i]))
														+ _mark_separator_inline +
										 "Value: " + string(color_get_value(_color[_i])) +
										 ")");
									}
									else
									{
										_string_color[_i] =
										("(" +
										 "Red: " + string(color_get_red(_color[_i]))
												 + _mark_separator_inline +
										 "Green: " + string(color_get_green(_color[_i]))
												   + _mark_separator_inline +
										 "Blue: " + string(color_get_blue(_color[_i])) +
										 ")");
									}
								break;
							}
						}
						else
						{
							if (instanceof(_color[_i]) == "Color2")
							{
								_string_color[_i] = _color[_i].toString(false, _colorHSV);
							}
							else
							{
								_string_color[_i] = string(_color[_i]);
							}
						}
						
						++_i;
					}
					
					_string = ("Location: " + string(location) + _mark_separator +
							   "Radius: " + string(radius) + _mark_separator +
							   "Fill Color: " + _string_color[0] + _mark_separator +
							   "Fill Alpha: " + string(fill_alpha) + _mark_separator +
							   "Outline Color: " + _string_color[1] + _mark_separator +
							   "Outline Alpha: " + string(outline_alpha));
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

