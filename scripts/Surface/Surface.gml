/// @function				Surface()
/// @argument				{Vector2} size
///							
/// @description			Constructs a Surface resource, a separate canvas for graphics rendering.
///							
///							Construction types:
///							- New constructor
///							- Empty: {void|undefined}
///							- Constructor copy: {Surface} other
function Surface() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				ID = undefined;
				size = undefined;
				
				event =
				{
					beforeCreation:
					{
						callback: undefined,
						argument: undefined
					},
					
					afterCreation:
					{
						callback: undefined,
						argument: undefined
					},
					
					beforeActivation:
					{
						callback: undefined,
						argument: undefined
					},
					
					afterActivation:
					{
						callback: undefined,
						argument: undefined
					},
					
					beforeDeactivation:
					{
						callback: undefined,
						argument: undefined
					},
					
					afterDeactivation:
					{
						callback: undefined,
						argument: undefined
					},
					
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
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (instanceof(argument[0]) == "Surface")
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						size = ((instanceof(_other.size) == "Vector2") ? new Vector2(_other.size)
																	   : _other.size);
						
						if (is_struct(_other.event))
						{
							event.beforeCreation.callback = _other.event.beforeCreation.callback;
							event.beforeCreation.argument = _other.event.beforeCreation.argument;
							event.afterCreation.callback = _other.event.afterCreation.callback;
							event.afterCreation.argument = _other.event.afterCreation.argument;
							
							event.beforeActivation.callback = _other.event.beforeActivation
																		  .callback;
							event.beforeActivation.argument = _other.event.beforeActivation
																		  .argument;
							event.afterActivation.callback = _other.event.afterActivation.callback;
							event.afterActivation.argument = _other.event.afterActivation.argument;
							
							event.beforeDeactivation.callback = _other.event.beforeDeactivation
																	  .callback;
							event.beforeDeactivation.argument = _other.event.beforeDeactivation
																	  .argument;
							event.afterDeactivation.callback = _other.event.afterDeactivation
																	 .callback;
							event.afterDeactivation.argument = _other.event.afterDeactivation
																	 .argument;
							
							event.beforeRender.callback = _other.event.beforeRender.callback;
							event.beforeRender.argument = _other.event.beforeRender.argument;
							event.afterRender.callback = _other.event.afterRender.callback;
							event.afterRender.argument = _other.event.afterRender.argument;
						}
						else
						{
							event = _other.event;
						}
						
						ID = surface_create(max(1, size.x), max(1, size.y));
						surface_copy(ID, 0, 0, _other.ID);
					}
					else
					{
						//|Construction type: New constructor.
						size = argument[0];
						ID = surface_create(max(1, size.x), max(1, size.y));
					}
				}
				
				return self;
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (surface_exists(ID)));
			}
			
			// @description			Create this Surface if it does not exists.
			static create = function()
			{
				if ((!is_real(ID)) or (!surface_exists(ID)))
				{
					if ((is_struct(event))) and (is_method(event.beforeCreation.callback))
					{
						script_execute_ext(method_get_index(event.beforeCreation.callback),
										   ((is_array(event.beforeCreation.argument)
											? event.beforeCreation.argument
											: [event.beforeCreation.argument])));
					}
					
					ID = surface_create(max(1, size.x), max(1, size.y));
					
					if ((is_struct(event))) and (is_method(event.afterCreation.callback))
					{
						script_execute_ext(method_get_index(event.afterCreation.callback),
										   ((is_array(event.afterCreation.argument)
											? event.afterCreation.argument
											: [event.afterCreation.argument])));
					}
				}
				
				return self;
			}
			
			// @returns				{undefined}
			// @description			Remove the internal information from the memory.
			static destroy = function()
			{
				if ((is_real(ID)) and (surface_exists(ID)))
				{
					surface_free(ID);
				}
				
				return undefined;
			}
			
			// @argument			{int:color} color?
			// @argument			{real} alpha?
			// @description			Set the entire content of this Surface to the specified color.
			static clear = function(_color = c_black, _alpha)
			{
				self.create();
				
				var _target = (surface_get_target() == ID)
				
				if (!_target)
				{
					surface_set_target(ID);
				}
				
				if (_alpha == undefined)
				{
					draw_clear(_color);
				}
				else
				{
					draw_clear_alpha(_color, _alpha);
				}
				
				if (!_target)
				{
					surface_reset_target();
				}
				
				return self;
			}
			
			// @argument			{Vector2} location
			// @argument			{Surface|int:surface} other
			// @argument			{Vector4} other_part?
			// @description			Copy content of other Surface to a specified location on this
			//						Surface.
			static copy = function(_location, _other)
			{
				var _other_value = (instanceof(_other) == "Surface" ? _other.ID : _other);
					
				if ((is_real(_other_value)) and (surface_exists(_other_value)))
				{
					if (argument_count > 2)
					{
						if ((!is_real(ID)) or (!surface_exists(ID)))
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "copy";
							var _errorText = ("Attempted to copy part of a Surface to an invalid " +
											  "Surface: " +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Other: " + "{" + string(_other) + "}" + "\n" +
											  "Writing it to a recreated surface.");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
							
							self.create();
						}
						
						var _other_part = argument[2];
						
						surface_copy_part(ID, _location.x, _location.y, _other_value, 
											_other_part.x1, _other_part.y1, _other_part.x2,
											_other_part.y2);
					}
					else
					{
						self.create();
						
						surface_copy(ID, _location.x, _location.y, _other_value);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "copy";
					var _errorText = ("Attempted to copy data from an invalid Surface: " +
									  "Self: " + "{" + string(self) + "}" + "\n" +
									  "Other: " + "{" + string(_other) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{Vector2} location
			// @argument			{bool} getFull?
			// @returns				{int:color|int:color:abgr32bit} | On error: {undefined}
			// @description			Get the pixel color on a specific spot on a Surface.
			//						A full abgr 32bit information can be obtainted if specified.
			static getPixel = function(_location, _getFull = false)
			{
				if ((is_real(ID)) and (surface_exists(ID)))
				{	
					return ((_getFull) ? surface_getpixel_ext(ID, _location.x, _location.y)
									   : surface_getpixel(ID, _location.x, _location.y));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getPixel";
					var _errorText = ("Attempted to get data from an invalid Surface: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{pointer}
			// @description			Get the pointer to texture page of this Surface.
			static getTexture = function()
			{
				if ((!is_real(ID)) or (!surface_exists(ID)))
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getTexture";
					var _errorText = ("Attempted to get texture of an invalid Surface: " +
									  "{" + string(ID) + "}" + "\n" +
									  "Recreating the Surface and providing its texture.");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					self.create();
				}
				
				return surface_get_texture(ID);
			}
			
			// @returns				{Vector2}
			// @description			Get the texel size of the texture page of this Surface.
			static getTexel = function()
			{
				if ((!is_real(ID)) or (!surface_exists(ID)))
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getTexel";
					var _errorText = ("Attempted to get texture of an invalid Surface: " +
									  "{" + string(ID) + "}" + "\n" +
									  "Recreating the Surface and providing its texture.");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					self.create();
				}
				
				var _texture = surface_get_texture(ID);
				
				return new Vector2(texture_get_texel_width(_texture),
								   texture_get_texel_height(_texture));
			}
			
			// @returns				{bool}
			// @description			Check whether this Surface is the current draw target.
			static isActive = function()
			{
				if ((is_real(ID)) and (surface_exists(ID)))
				{
					return (surface_get_target() == ID);
				}
				else
				{
					return false;
				}
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{Vector2} size
			// @descirption			Set the size of the Surface.
			static setSize = function(_size)
			{
				size = _size;
				
				if ((!is_real(ID)) or (!surface_exists(ID)))
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setSize";
					var _errorText = ("Attempted to change size of an invalid Surface: " +
									  "{" + string(ID) + "}" + "\n" +
									  "Recreating the Surface with the target size.");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					self.create();
				}
				else
				{
					surface_resize(ID, max(1, size.x), max(1, size.y));
				}
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{Vector2} location?
			// @argument			{Vector4} part_location?
			// @argument			{Scale} scale?
			// @argument			{Angle} angle?
			// @argument			{int:color|Color4} color?
			// @argument			{real} alpha?
			// @argument			{Surface|int:surface} target?
			// @description			Draw this Surface or a part of it to the currently targeted or
			//						specified Surface.
			static render = function(_location)
			{
				if ((is_real(ID)) and (surface_exists(ID)))
				{
					if ((is_struct(event))) and (is_method(event.beforeRender.callback))
					{
						script_execute_ext(method_get_index(event.beforeRender.callback),
										   ((is_array(event.beforeRender.argument)
											? event.beforeRender.argument
											: [event.beforeRender.argument])));
					}
					
					var _location_x, _location_y;
					
					if (_location != undefined)
					{
						_location_x = _location.x;
						_location_y = _location.y;
					}
					else
					{
						_location_x = 0;
						_location_y = 0;
					}
					
					var _targetStack = undefined;
					
					if ((argument_count > 6) and (argument[6] != undefined))
					{
						var _target = argument[6];
						var _target_value = (instanceof(_target) == "Surface" ? _target.ID
																			  : _target);
						
						if ((is_real(_target_value)) and (surface_exists(_target_value))
						and (_target_value != ID))
						{
							_targetStack = ds_stack_create();
							var _currentTarget = surface_get_target();
							
							while ((_currentTarget != _target_value) and (_currentTarget != 0)
							and (_currentTarget != -1))
							{
								ds_stack_push(_targetStack, _currentTarget);
								
								surface_reset_target();
								
								_currentTarget = surface_get_target();
							}
							
							surface_set_target(_target_value);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "render";
							var _errorText = ("Attempted to render to an invalid Surface: " +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Other: " + "{" + string(_target) + "}");
							_errorReport.reportConstructorMethod(self, _callstack,_methodName,
																 _errorText);
						}
					}
					
					var _part_location = ((argument_count > 1) ? argument[1] : undefined);
					var _scale = ((argument_count > 2) ? argument[2] : undefined);
					var _angle = ((argument_count > 3) ? argument[3] : undefined);
					var _color = ((argument_count > 4) ? argument[4] : undefined);
					var _alpha = ((argument_count > 5) ? argument[5] : undefined);
						
					if (((_angle != undefined) and (_part_location != undefined))
					or (instanceof(_color) == "Color4"))
					{
						var _part_location_x1, _part_location_y1, _part_location_x2,
							_part_location_y2;
							
						if (_part_location != undefined)
						{
							_part_location_x1 = _part_location.x1;
							_part_location_y1 = _part_location.y1;
							_part_location_x2 = _part_location.x2;
							_part_location_y2 = _part_location.y2;
						}
						else
						{
							_part_location_x1 = 0;
							_part_location_y1 = 0;
							_part_location_x2 = size.x;
							_part_location_y2 = size.y;
						}
							
						var _scale_x, _scale_y;
							
						if (_scale != undefined)
						{
							_scale_x = _scale.x;
							_scale_y = _scale.y;
						}
						else
						{
							_scale_x = 1;
							_scale_y = 1;
						}
							
						var _angle_value = ((_angle != undefined) ? _angle.value : 0);
							
						var _color_x1y1, _color_x1y2, _color_x2y1, _color_x2y2;
							
						if (instanceof(_color) == "Color4")
						{
							_color_x1y1 = _color.color1;
							_color_x1y2 = _color.color2;
							_color_x2y1 = _color.color3;
							_color_x2y2 = _color.color4;
						}
						else if (_color != undefined)
						{
							_color_x1y1 = _color;
							_color_x1y2 = _color;
							_color_x2y1 = _color;
							_color_x2y2 = _color;
						}
						else
						{
							_color_x1y1 = c_white;
							_color_x1y2 = c_white;
							_color_x2y1 = c_white;
							_color_x2y2 = c_white;
						}
							
						var _alpha_value = ((_alpha != undefined) ? _alpha : 1);
							
						draw_surface_general(ID, _part_location_x1, _part_location_y1, 
											 _part_location_x2, _part_location_y2, _location_x,
											 _location_y, _scale_x, _scale_y, _angle_value,
											 _color_x1y1, _color_x2y1, _color_x2y2, _color_x1y2,
											 _alpha_value);
					}
					else if (_part_location != undefined)
					{
						if ((_scale != undefined) or (_color != undefined)
						or (_alpha != undefined))
						{
							var _scale_x, _scale_y;
								
							if (_scale != undefined)
							{
								_scale_x = _scale.x;
								_scale_y = _scale.y;
							}
							else
							{
								_scale_x = 1;
								_scale_y = 1;
							}
								
							var _color_value = ((_color != undefined) ? _color : c_white);
							var _alpha_value = ((_alpha != undefined) ? _alpha : 1);
								
							draw_surface_part_ext(ID, _part_location.x1, _part_location.y1,
												  _part_location.x2, _part_location.y2, _location_x,
												  _location_y, _scale_x, _scale_y, _color_value,
												  _alpha_value);
						}
						else
						{
							draw_surface_part(ID, _part_location.x1, _part_location.y1,
											  _part_location.x2, _part_location.y2, _location_x,
											  _location_y);
						}
					}
					else
					{
						var _scale_x, _scale_y;
							
						if (_scale != undefined)
						{
							_scale_x = _scale.x;
							_scale_y = _scale.y;
						}
						else
						{
							_scale_x = 1;
							_scale_y = 1;
						}
							
						var _angle_value = ((_angle != undefined) ? _angle.value : 0);
						var _color_value = ((_color != undefined) ? _color : c_white);
						var _alpha_value = ((_alpha != undefined) ? _alpha : 1);
							
						draw_surface_ext(ID, _location_x, _location_y, _scale_x, _scale_y,
											_angle_value, _color_value, _alpha_value);
					}
					
					if (_targetStack != undefined)
					{
						surface_reset_target();
						
						repeat (ds_stack_size(_targetStack))
						{
							surface_set_target(ds_stack_pop(_targetStack));
						}
						
						ds_stack_destroy(_targetStack);
					}
					
					if ((is_struct(event))) and (is_method(event.afterRender.callback))
					{
						script_execute_ext(method_get_index(event.afterRender.callback),
										   ((is_array(event.afterRender.argument)
											? event.afterRender.argument
											: [event.afterRender.argument])));
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "render";
					var _errorText = ("Attempted to render an invalid Surface: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{Vector2} size
			// @argument			{Vector2} location?
			// @argument			{int:color} color?
			// @argument			{real} alpha?
			// @description			Draw this Surface after scaling it to match the specific size.
			static renderSize = function(_size, _location, _color = c_white, _alpha = 1)
			{
				if ((is_real(ID)) and (surface_exists(ID)))
				{
					if ((is_struct(event))) and (is_method(event.beforeRender.callback))
					{
						script_execute_ext(method_get_index(event.beforeRender.callback),
										   ((is_array(event.beforeRender.argument)
											? event.beforeRender.argument
											: [event.beforeRender.argument])));
					}
					
					var _location_x, _location_y;
					
					if (_location != undefined)
					{
						_location_x = _location.x;
						_location_y = _location.y;
					}
					else
					{
						_location_x = 0;
						_location_y = 0;
					}
					
					draw_surface_stretched_ext(ID, _location_x, _location_y, _size.x, _size.y, _color,
											   _alpha);
					
					if ((is_struct(event))) and (is_method(event.afterRender.callback))
					{
						script_execute_ext(method_get_index(event.afterRender.callback),
										   ((is_array(event.afterRender.argument)
											? event.afterRender.argument
											: [event.afterRender.argument])));
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "renderSize";
					var _errorText = ("Attempted to render an invalid Surface: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{Vector2} offset?
			// @argument			{Scale} scale?
			// @argument			{int:color} color?
			// @argument			{real} alpha?
			// @description			Draw this Surface tiled across the target created Surface or the
			//						entire Room if none is set.
			static renderTiled = function(_offset, _scale, _color = c_white, _alpha = 1)
			{
				if ((is_real(ID)) and (surface_exists(ID)))
				{
					if ((is_struct(event))) and (is_method(event.beforeRender.callback))
					{
						script_execute_ext(method_get_index(event.beforeRender.callback),
										   ((is_array(event.beforeRender.argument)
											? event.beforeRender.argument
											: [event.beforeRender.argument])));
					}
					
					var _offset_x, _offset_y;
					
					if (_offset != undefined)
					{
						_offset_x = _offset.x;
						_offset_y = _offset.y;
					}
					else
					{
						_offset_x = 0;
						_offset_y = 0;
					}
					
					var _scale_x, _scale_y;
					
					if (_scale != undefined)
					{
						_scale_x = _scale.x;
						_scale_y = _scale.y;
					}
					else
					{
						_scale_x = 1;
						_scale_y = 1;
					}
					
					draw_surface_tiled_ext(ID, _offset_x, _offset_y, _scale_x, _scale_y, _color,
										   _alpha);
					
					if ((is_struct(event))) and (is_method(event.afterRender.callback))
					{
						script_execute_ext(method_get_index(event.afterRender.callback),
										   ((is_array(event.afterRender.argument)
											? event.afterRender.argument
											: [event.afterRender.argument])));
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "renderTiled";
					var _errorText = ("Attempted to render an invalid Surface: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{bool} target
			// @description			Place this Surface on the top of target stack or remove it.
			static setActive = function(_target)
			{
				switch (_target)
				{
					case true:
						if ((!is_real(ID)) or (!surface_exists(ID)))
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setActive";
							var _errorText = ("Attempted to set an invalid Surface as the render " +
											  "target: " +
											  "{" + string(ID) + "}" + "\n" +
											  "Recreating the Surface and setting it as target.");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
							
							self.create();
						}
						
						if ((is_struct(event))) and (is_method(event.beforeActivation.callback))
						{
							script_execute_ext(method_get_index(event.beforeActivation.callback),
											   ((is_array(event.beforeActivation.argument)
												? event.beforeActivation.argument
												: [event.beforeActivation.argument])));
						}
						
						surface_set_target(ID);
						
						if ((is_struct(event))) and (is_method(event.afterActivation.callback))
						{
							script_execute_ext(method_get_index(event.afterActivation.callback),
											   ((is_array(event.afterActivation.argument)
												? event.afterActivation.argument
												: [event.afterActivation.argument])));
						}
					break;
					
					case false:
						if ((is_real(ID)) and (surface_exists(ID)) and (surface_get_target() == ID))
						{
							if ((is_struct(event))) and (is_method(event.beforeDeactivation.callback))
							{
								script_execute_ext(method_get_index(event.beforeDeactivation
																		 .callback),
												   ((is_array(event.beforeDeactivation.argument)
													? event.beforeDeactivation.argument
													: [event.beforeDeactivation.argument])));
							}
							
							surface_reset_target();
							
							if ((is_struct(event))) and (is_method(event.afterDeactivation.callback))
							{
								script_execute_ext(method_get_index(event.afterDeactivation.callback),
												   ((is_array(event.afterDeactivation.argument)
													? event.afterDeactivation.argument
													: [event.afterDeactivation.argument])));
							}
						}
					break;
				}
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the properties of this Surface.
			static toString = function(_multiline = false)
			{
				if (is_real(ID))
				{
					var _string = "";
					var _mark_separator = ((_multiline) ? "\n" : ", ");
					
					var _text_nonexistent = ((surface_exists(ID)) ? "" : " (nonexistent)");
					
					_string = ("ID: " + string(ID) + _text_nonexistent + _mark_separator +
							   "Size: " + string(size));
					
					return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			// @argument			{string:path} path
			// @argument			{Vector4} part?
			// @description			Save the content of this Surface or a rectangular part of it to
			//						the specified .png file.
			static toFile = function(_path, _part)
			{
				if ((is_real(ID)) and (surface_exists(ID)))
				{
					if (_part != undefined)
					{
						surface_save_part(ID, _path, _part.x1, _part.y1, _part.x2, _part.y2);
					}
					else
					{
						surface_save(ID, _path);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "toFile";
					var _errorText = ("Attempted to convert an invalid Surface: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{Buffer} buffer
			// @argument			{int} offset?
			// @description			Copy information from the specified Buffer to this Surface.
			//						A byte offset can be specified for where the data load will begin.
			static fromBuffer = function(_buffer, _offset = 0)
			{
				self.create();
				
				if ((is_real(ID)) and (surface_exists(ID)))
				{
					if ((instanceof(_buffer) == "Buffer") and (_buffer.isFunctional()))
					{
						buffer_set_surface(_buffer.ID, ID, _offset);
					}
				}
				
				return self;
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
