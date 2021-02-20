/// @function				Surface()
/// @argument				{Vector2} size
///
///	@description			Constructs a Surface resource, a separate canvas for graphics drawing.
///
///							Construction methods:
///							- New constructor
///							- Constructor copy: {Surface} other
function Surface() constructor	
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				ID = undefined;
				size = undefined;
				onRecreate = undefined;
				
				if ((argument_count > 0) and (instanceof(argument[0]) == "Surface"))
				{
					//|Construction method: Constructor copy.
					var _other = argument[0];
					
					size = _other.size;
					onRecreate = _other.onRecreate;
					ID = surface_create(size.x, size.y);
					surface_copy(ID, 0, 0, _other.ID);
				}
				else
				{
					//|Construction method: New constructor.
					size = argument[0];
					onRecreate = undefined;
					ID = surface_create(size.x, size.y);
				}
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (surface_exists(ID)));
			}
			
			// @description			Create this Surface if it was destroyed.
			static create = function()
			{
				if (!((is_real(ID)) and (surface_exists(ID))))
				{
					ID = surface_create(size.x, size.y);
					
					if (is_method(onRecreate))
					{
						onRecreate();
					}
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{Surface|surface} other
			// @argument			{Vector4} other_part?
			// @description			Copy content of other Surface to a specified location on this one.
			static copy = function(_location, _other)
			{
				var _surface_source = (instanceof(_other) == "Surface" ? _other.ID : _other);
					
				if ((is_real(_surface_source)) and (surface_exists(_surface_source)))
				{
					if (argument_count > 2)
					{
						if (!(is_real(ID)) and (surface_exists(ID)))
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
						}
						
						var _other_part = argument[2];
						
						surface_copy_part(ID, _location.x, _location.y, _surface_source, 
											_other_part.x1, _other_part.y1, _other_part.x2,
											_other_part.y2);
					}
					else
					{
						self.create();
						
						surface_copy(ID, _location.x, _location.y, _surface_source);
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
					_errorReport.reportConstructorMethod(self, _callstack, _methodName,
															_errorText);
				}
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
			
		#endregion
		#region <Setters>
			
			// @argument			{Vector2} size
			// @descirption			Set the size of the Surface.
			static setSize = function(_size)
			{
				size = _size;
				
				if (!((is_real(ID)) and (surface_exists(ID))))
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setSize";
					var _errorText = ("Attempted to change size of an invalid Surface: " +
									  "{" + string(ID) + "}" + "\n" +
									  "Recreating the Surface with the target size.");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					ID = surface_create(size.x, size.y);
				}
				else
				{
					surface_resize(ID, size.x, size.y);
				}	
			}
			
		#endregion
		#region <Getters>
			
			// @description			Check whether this Surface is the current draw target.
			static isTarget = function()
			{
				return (((is_real(ID)) and (surface_exists(ID))) ? (surface_get_target() == ID)
																 : false);
			}
			
			// @argument			{Vector2} location
			// @argument			{bool} getFull?
			// @returns				{int:color|int:color:abgr32bit} | On error: {undefined}
			// @description			Get the pixel color on a specific spot on a Surface.
			//						A full abgr 32bit information can be obtainted if specified,
			//						otherwise {Color} will be returned.
			static getPixel = function(_location, _getFull)
			{
				if ((is_real(ID)) and (surface_exists(ID)))
				{	
					return (_getFull ? surface_getpixel_ext(ID, _location.x, _location.y) :
									   surface_getpixel(ID, _location.x, _location.y));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getPixel";
					var _errorText = ("Attempted to get data from an invalid Surface: " +
									  "{" + string(ID) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{ptr}
			// @description			Get the pointer to texture page of this Surface.
			static getTexture = function()
			{
				if (!((is_real(ID)) and (surface_exists(ID))))
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
			
		#endregion
		#region <Execution>
			
			// @argument			{bool} setAsTarget
			// @description			Place this Surface on the top of target stack or remove it.
			static target = function(_setAsTarget)
			{
				if (_setAsTarget)
				{
					if (!((is_real(ID)) and (surface_exists(ID))))
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "target";
						var _errorText = ("Attempted to set an invalid Surface as render target: " +
										  "{" + string(ID) + "}" + "\n" +
										  "Recreating the Surface and providing setting it.");
						_errorReport.reportConstructorMethod(self, _callstack, _methodName,
															 _errorText);
						
						self.create();
					}
					
					surface_set_target(ID);
				}
				else
				{
					if ((is_real(ID)) and (surface_exists(ID)) and (surface_get_target() == ID))
					{
						surface_reset_target();
					}
				}
			}
			
			// @argument			{Vector2} location?
			// @argument			{Scale} scale?
			// @argument			{Angle} angle?
			// @argument			{int:color} color?
			// @argument			{real} alpha?
			// @description			Execute the draw.
			static render = function(_location)
			{
				if ((is_real(ID)) and (surface_exists(ID)))
				{
					if (_location == undefined) {_location = new Vector2(0, 0);}
					
					if (argument_count > 1)
					{
						var _scale = ((argument[1] != undefined) ? argument[1] : new Scale(1, 1));
						var _angle = ((argument_count > 2) and (argument[2] != undefined) ? 
									 argument[2] : new Angle(0));
						var _color = ((argument_count > 3) and (argument[3] != undefined) ? 
									 argument[3] : c_white);
						var _alpha = ((argument_count > 4) and (argument[4] != undefined) ? 
									 argument[4] : 1);
						
						draw_surface_ext(ID, _location.x, _location.y, _scale.x, _scale.y,
										 _angle.value, _color, _alpha);
					}
					else
					{
						draw_surface(ID, _location.x, _location.y);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "render";
					var _errorText = ("Attempted to render an invalid Surface: " +
									  "{" + string(ID) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Surface|surface} target?
			// @argument			{Vector2} location?
			// @argument			{Scale} scale?
			// @argument			{Angle} angle?
			// @argument			{int:color} color?
			// @argument			{real} alpha?
			// @description			Execute the draw to a specified target, ignoring the target stack.
			static render_target = function(_target, _location)
			{
				if ((is_real(ID)) and (surface_exists(ID)))
				{
					if (_target == undefined) {_target = application_surface;}
					if (_location == undefined) {_location = new Vector2(0, 0);}
					
					var _renderTarget = (instanceof(_target) == "Surface" ? _target.ID : _target);
					
					if (surface_exists(_renderTarget))
					{
						var _targetStack = new Stack();
						var _currentTarget = surface_get_target();
						
						while ((_currentTarget != _renderTarget) 
						and (_currentTarget != application_surface))
						{
							_targetStack.add(_currentTarget);
							
							surface_reset_target();
							
							_currentTarget = surface_get_target();
						}
						
						if (argument_count > 2)
						{
							var _scale = ((argument[2] != undefined) ? argument[2] : new Scale());
							var _angle = (((argument_count > 3) and (argument[3] != undefined)) ? 
										 argument[3] : new Angle(0));
							var _color = (((argument_count > 4) and (argument[4] != undefined)) ? 
										 argument[4] : c_white);
							var _alpha = (((argument_count > 5) and (argument[5] != undefined)) ? 
										 argument[5] : 1);
							
							draw_surface_ext(ID, _location.x, _location.y, _scale.x, _scale.y, 
											 _angle.value, _color, _alpha);
						}
						else
						{
							draw_surface(ID, _location.x, _location.y);
						}
						
						repeat(_targetStack.getSize())
						{
							surface_set_target(_targetStack.remove());
						}
						
						_targetStack = _targetStack.destroy();
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "render";
					var _errorText = ("Attempted to render an invalid Surface: " +
									  "{" + string(ID) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Vector4} part_location
			// @argument			{Vector2} location?
			// @argument			{Scale} scale?
			// @argument			{int:color} color?
			// @argument			{real} alpha?
			// @description			Execute the draw of a specified part of the Surface.
			static render_part = function(_part_location, _location)
			{
				if ((is_real(ID)) and (surface_exists(ID)))
				{
					if (_location == undefined) {_location = new Vector2(0, 0);}
					
					if (argument_count > 2)
					{
						var _scale = ((argument[2] != undefined) ? argument[2] : new Scale());
						var _color = (((argument_count > 3) and (argument[3] != undefined)) ? 
									 argument[3] : c_white);
						var _alpha = (((argument_count > 4) and (argument[4] != undefined)) ? 
									 argument[4] : 1);
						
						draw_surface_part_ext(ID, _part_location.x1, _part_location.y1, 
											  _part_location.x2, _part_location.y2, 
											  _location.x, _location.y, _scale.x, 
											  _scale.y, _color, _alpha);
					}
					else
					{
						draw_surface_part(ID, _part_location.x1, _part_location.y1, 
										  _part_location.x2, _part_location.y2, 
										  _location.x, _location.y);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "render";
					var _errorText = ("Attempted to render an invalid Surface: " +
									  "{" + string(ID) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Vector2} location?
			// @argument			{Vector4} part_location?
			// @argument			{Scale} scale?
			// @argument			{Color4|color} color?
			// @argument			{real} alpha?
			// @argument			{Angle} angle?
			// @description			Execute the draw with specified alternations.
			static render_general = function(_part_location, _location, _scale, 
											 _color, _alpha, _angle)
			{
				if ((is_real(ID)) and (surface_exists(ID)))
				{
					if (_part_location == undefined) {_part_location = new Vector4(0, 0, 
																				   size.x, size.y);}
					if (_location == undefined) {_location = new Vector2(0, 0);}
					
					if (_scale == undefined) {_scale = new Scale();}
					if (_color == undefined) {_color = c_white;}
					if (_alpha == undefined) {_alpha = 1;}
					if (_angle == undefined) {_angle = new Angle(0);}
					
					var _color_x1y1, _color_x1y2, _color_x2y1, _color_x2y2;
					
					if (instanceof(_color) == "Color4")
					{
						_color_x1y1 = _color.color1;
						_color_x1y2 = _color.color2;
						_color_x2y1 = _color.color3;
						_color_x2y2 = _color.color4;
					}
					else
					{
						_color_x1y1 = _color;
						_color_x1y2 = _color;
						_color_x2y1 = _color;
						_color_x2y2 = _color;
					}
					
					draw_surface_general(ID, _part_location.x1, _part_location.y1, 
										 _part_location.x2, _part_location.y2, 
										 _location.x, _location.y, _scale.x, 
										 _scale.y, _angle.value, _color_x1y1, 
										 _color_x2y1, _color_x2y2, _color_x1y2, 
										 _alpha);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "render";
					var _errorText = ("Attempted to render an invalid Surface: " +
									  "{" + string(ID) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Vector2} size
			// @argument			{Vector2} location?
			// @argument			{int:color} color?
			// @argument			{real} alpha?
			// @description			Execute the draw by forcing the Surface to match a specific size.
			static render_size = function(_size, _location)
			{
				if ((is_real(ID)) and (surface_exists(ID)))
				{
					if (_location == undefined) {_location = new Vector2(0, 0);}
					
					if (argument_count > 2)
					{
						var _color = ((argument[2] != undefined) ? argument[2] : c_white);
						var _alpha = ((argument_count > 3) and (argument[3] != undefined) ? 
									 argument[3] : 1);
						
						draw_surface_stretched_ext(ID, _location.x, _location.y, _size.x,
												   _size.y, _color, _alpha);
					}
					else
					{
						draw_surface_stretched(ID, _location.x, _location.y, _size.x, _size.y);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "render";
					var _errorText = ("Attempted to render an invalid Surface: " +
									  "{" + string(ID) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Vector2} location?
			// @argument			{Scale} scale?
			// @argument			{int:color} color?
			// @argument			{real} alpha?
			// @description			Execute the tiled draw across the Room from the starting location.
			static render_tiled = function(_location)
			{
				if ((is_real(ID)) and (surface_exists(ID)))
				{
					if (_location == undefined) {_location = new Vector2(0, 0);}
					
					if (argument_count > 1)
					{
						var _scale = (((argument_count > 1) and (argument[1] != undefined)) ? 
									 argument[1] : new Scale());
						var _color = (((argument_count > 2) and (argument[2] != undefined)) ? 
									 argument[2] : c_white);
						var _alpha = (((argument_count > 3) and (argument[3] != undefined)) ? 
									 argument[3] : 1);
						
						draw_surface_tiled_ext(ID, _location.x, _location.y, _scale.x, 
											   _scale.y, _color, _alpha);
					}
					else
					{
						draw_surface_tiled(ID, _location.x, _location.y);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "render";
					var _errorText = ("Attempted to render an invalid Surface: " +
									  "{" + string(ID) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{int:color} color
			// @argument			{real} alpha?
			// @description			Set the entire content of this Surface to the specified color.
			static clear = function(_color, _alpha)
			{
				self.create();
				
				if (_alpha == undefined) {_alpha = 1;}
				
				var _wasTarget = (surface_get_target() == ID)
				
				if (!_wasTarget)
				{
					surface_set_target(ID);
				}
				
				if (_alpha >= 1)
				{
					draw_clear(_color);
				}
				else
				{
					draw_clear_alpha(_color, _alpha);
				}
				
				if (!_wasTarget)
				{
					surface_reset_target();
				}
			}
			
			// @argument			{int} mrt
			// @description			Set the Multi-Render Target of this Surface for Shader operations.
			static setMRT = function(_mrt)
			{
				if (!((is_real(ID)) and (surface_exists(ID))))
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setMRT";
					var _errorText = ("Attempted to set a property of an invalid Surface: " +
										"{" + string(ID) + "}" + "\n" +
										"Recreating the Surface and providing setting its property.");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
						
					self.create();
				}
				
				if ((is_real(ID)) and (surface_exists(ID)))
				{
					surface_set_target_ext(_mrt, ID);
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the ID and size of this Surface.
			static toString = function()
			{
				if (is_real(ID))
				{
					var _text_destroyed = ((surface_exists(ID)) ? "" : "; destroyed");
					
					return (instanceof(self) + "(" + string(ID) + ": " + string(size) + 
							_text_destroyed +")");
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			// @argument			{string} filename
			// @argument			{Vector4} part?
			// @description			Save the content of this Surface to disk as a .png file.
			static toFile = function(_filename)
			{
				if ((is_real(ID)) and (surface_exists(ID)))
				{
					if (argument_count > 1)
					{
						var _part = argument[1];
						
						surface_save_part(ID, _filename, _part.x1, _part.y1, _part.x2, _part.y2);
					}
					else
					{
						surface_save(ID, _filename);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "toFile";
					var _errorText = ("Attempted to convert an invalid Surface: " +
									  "{" + string(ID) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Buffer} buffer
			// @argument			{int} offset?
			// @argument			{int} modulo?
			// @description			Copy information from the specified Buffer to this Surface.
			//						A byte offset can be specified for where the operation will start.
			//						A modulo value can be specified for number of bytes left after
			//						every written line for storing additional data.
			static fromBuffer = function(_buffer, _offset, _modulo)
			{
				self.create();
				
				if ((is_real(ID)) and (surface_exists(ID)))
				{
					if ((instanceof(_buffer) == "Buffer") and (is_real(_buffer.ID))
					and (buffer_exists(_buffer.ID)))
					{
						if (_offset == undefined) {_offset = 0;}
					
						buffer_set_surface(_buffer.ID, ID, _offset);
					}
				}
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
