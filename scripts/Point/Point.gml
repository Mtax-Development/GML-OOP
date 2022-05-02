/// @function				Point()
/// @argument				{Vector2} location
/// @argument				{int:color} color?
/// @argument				{real} alpha?
///							
/// @description			Constructs a Point Shape, which is a single pixel.
///							
///							Construction types:
///							- New constructor.
///							- Empty: {void|undefined}
///							- Constructor copy: {Point} other
function Point() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				location = undefined;
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
					if (instanceof(argument[0]) == "Point")
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						location = ((instanceof(_other.location) == "Vector2")
									? new Vector2(_other.location) : _other.location);
						color = _other.color;
						alpha = _other.alpha;
						
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
						location = argument[0];
						color = (((argument_count > 1) and (argument[1] != undefined)) ? argument[1]
																					   : c_white);
						alpha = (((argument_count > 2) and (argument[2] != undefined)) ? argument[2]
																					   : 1);
					}
				}
				
				return self;
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((instanceof(location) == "Vector2") and (location.isFunctional()));
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
			//						specified object.
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
					if ((is_real(_excludedInstance)) and (instance_exists(_excludedInstance)))
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
			
			// @argument			{int} device?
			// @argument			{bool} GUI?
			// @returns				{bool}
			// @description			Check if the cursor is over this Shape.
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
				
				return ((_cursor_x == location.x) and (_cursor_y == location.y));
			}
			
			// @argument			{constant:mb_*} button
			// @argument			{int} device?
			// @argument			{bool} GUI?
			// @returns				{bool}
			// @description			Check if the cursor is over this Shape while its specified mouse
			//						button is pressed or held.
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
				
				if ((_cursor_x == location.x) and (_cursor_y == location.y))
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
			// @description			Check if the cursor is over this Shape while its specified mouse
			//						button was pressed in this frame.
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
				
				if ((_cursor_x == location.x) and (_cursor_y == location.y))
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
			// @description			Check if the cursor is over this Shape while the specified mouse
			//						button was released in this frame.
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
				
				if ((_cursor_x == location.x) and (_cursor_y == location.y))
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
			// @argument			{int:color} color?
			// @argument			{real} alpha?
			// @description			Execute the draw of this Shape as a sprite, using data of this
			//						constructor or specified replaced parts of it for this call only.
			static render = function(_location, _color, _alpha)
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
				
				var _location_original = location;
				var _color_original = color;
				var _alpha_original = alpha;
				
				location = (_location ?? location);
				color = (_color ?? color);
				alpha = (_alpha ?? alpha);
				
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
					
					if (alpha > 0)
					{
						draw_sprite_ext(_pixelSprite, 0, round(location.x), round(location.y), 1, 1,
										0, color, alpha);
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
				color = _color_original;
				alpha = _alpha_original;
				
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
					_string = ("Location: " + string(location));
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
								if (_colorHSV)
								{
									_string_color =
									("(" +
									 "Hue: " + string(color_get_hue(color))
											 + _mark_separator_inline +
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
						_string_color = string(color);
					}
				
					var _string = ("Location: " + string(location) + _mark_separator +
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

