/// @function				Sprite()
/// @argument				{sprite} sprite
/// @argument				{Vector2} location?
/// @argument				{real} frame?
/// @argument				{real} speed?
/// @argument				{Scale} scale?
/// @argument				{Angle} angle?
/// @argument				{color} color?
/// @argument				{real} alpha?
///
/// @description			Constructs a Sprite resource, intended as a single instance for rendering.
///							It can be rendered if its location is specified.
///
///							Construction methods:
///							- New constructor
///							- Wrapper: {sprite} sprite
///							- Constructor copy: {Sprite} other
function Sprite() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				if ((argument_count > 0) and (instanceof(argument[0]) == "Sprite"))
				{
					//|Construction method: Constructor copy.
					var _other = argument[0];
					
					ID = _other.ID;
					location = _other.location;
					frame = _other.frame;
					speed = _other.speed;
					scale = _other.scale;
					angle = _other.angle;
					color = _other.color;
					alpha = _other.alpha;
				}
				else
				{
					//|Construction method: New constructor.
					ID = argument[0];
					location = ((argument_count > 1) ? argument[1] : undefined);
					frame = (((argument_count > 2) and (argument[2] != undefined)) ? argument[2] 
																				   : 0);
					speed = (((argument_count > 3) and (argument[3] != undefined)) ? argument[3] 
																				   : 0);
					scale = (((argument_count > 4) and (argument[4] != undefined)) ? argument[4] 
																				   : new Scale(1, 1));
					angle = (((argument_count > 5) and (argument[5] != undefined)) ? argument[5] 
																				   : new Angle(0));
					color = (((argument_count > 6) and (argument[6] != undefined)) ? argument[6] 
																				   : c_white);
					alpha = (((argument_count > 7) and (argument[7] != undefined)) ? argument[7] 
																				   : 1);
				}
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (sprite_exists(ID)));
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{string}
			// @description			Return the name of this Sprite.
			static getName = function()
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					return sprite_get_name(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getName";
					var _errorText = ("Attempted to get a property of an invalid Sprite: " +
									  "{" + string(ID) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return string(undefined);
				}
			}
			
			// @returns				{Vector2} | On error: {undefined}
			// @description			Return the width and height of this Sprite.
			static getSize = function()
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					return new Vector2(sprite_get_width(ID), sprite_get_height(ID));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getSize";
					var _errorText = ("Attempted to get a property of an invalid Sprite: " +
									  "{" + string(ID) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{int} | On error: {undefined}
			// @description			Return the number of frames of this Sprite counted from 1.
			static getFrameNumber = function()
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					return sprite_get_number(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getFrameNumber";
					var _errorText = ("Attempted to get a property of an invalid Sprite: " +
									  "{" + string(ID) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{Vector2} | On error: {undefined}
			// @description			Return the origin point offset of this Sprite.
			//						This value is relative to top-left corner of this Sprite.
			static getOrigin = function()
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					return new Vector2(sprite_get_xoffset(ID), sprite_get_yoffset(ID));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getOrigin";
					var _errorText = ("Attempted to get a property of an invalid Sprite: " +
									  "{" + string(ID) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{Vector4} | On error: {undefined}
			// @description			Return the bounding box offsets of this Sprite.
			//						This value is relative to top-left corner of this Sprite.
			static getBoundingBox = function()
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					return new Vector4(sprite_get_bbox_left(ID), sprite_get_bbox_top(ID),
									   sprite_get_bbox_right(ID), sprite_get_bbox_bottom(ID));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getBoundingBox";
					var _errorText = ("Attempted to get a property of an invalid Sprite: " +
									  "{" + string(ID) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{int} frame?
			// @returns				{ptr}
			// @description			Return a pointer for the texture page of the specified frame
			//						of this Sprite.
			static getTexture = function(_frame)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					if (_frame == undefined) {_frame = 0;}
					
					return sprite_get_texture(ID, _frame);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getTexture";
					var _errorText = ("Attempted to get a property of an invalid Sprite: " +
									  "{" + string(ID) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return pointer_invalid;
				}
			}
			
			// @argument			{int} frame?
			// @argument			{bool} full?
			// @returns				{Vector4|real[]}
			// @description			Return the UV coordinates for the location of the specified frame
			//						of this Sprite on its texture page.
			//						It will be returned as an Vector4 or if the full information is
			//						specified, an array with 8 elements will be returned with the
			//						following data at respective positions:
			//						[UV left, UV top, UV right, UV bottom, pixels trimmed from left,
			//						 pixels trimmed from top, pixel data width precentage saved to 
			//						 the texture page, pixel data height precentage saved to the
			//						 texture page].
			static getUVs = function(_frame, _full)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					if (_frame == undefined) {_frame = 0;}
					
					var _uv = sprite_get_uvs(ID, _frame);
					
					return ((_full) ? _uv : new Vector4(_uv[0], _uv[1], _uv[2], _uv[3]));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getUVs";
					var _errorText = ("Attempted to get a property of an invalid Sprite: " +
									  "{" + string(ID) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{bool} copyCallerLocation?
			// @description			Execute the draw and advance the animation.
			static render = function(_copyCallerLocation)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					var _location_x = undefined;
					var _location_y = undefined;
					
					if (_copyCallerLocation)
					{
						_location_x = other.x;
						_location_y = other.y;
					}
					else if (location != undefined)
					{
						_location_x = location.x;
						_location_y = location.y;
					}
					
					if ((is_real(_location_x)) and (is_real(_location_y)))
					{
						draw_sprite_ext(ID, frame, _location_x, _location_y, scale.x, scale.y,
										angle.value, color, alpha);
					}
					if (speed != 0)
					{
						self.advanceFrames(speed);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "render";
					var _errorText = ("Attempted to render a property of an invalid Sprite: " +
									  "{" + string(ID) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @description			Advance the animation frame value by the speed of this Sprite and
			//						wrap it.
			static advanceFrames = function()
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					frame += speed;
		
					var _frame_max = sprite_get_number(ID);
		
					if (frame >= _frame_max)
					{
						frame -= _frame_max;
					}
					else if (frame < 0)
					{
						frame += _frame_max;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "advanceFrames";
					var _errorText = ("Attempted to set a property of an invalid Sprite: " +
									  "{" + string(ID) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @returns				{int:0} | On error: {int:-1}
			// @description			Load the texture page this Sprite is on into the memory.
			static prefetch = function()
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					return sprite_prefetch(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "prefetch";
					var _errorText = ("Attempted to load an invalid Sprite: " +
									  "{" + string(ID) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return -1;
				}
			}
			
			// @returns				{int:0} | On error: {int:-1}
			// @description			Unload the texture page this Sprite is on from the memory.
			static flush = function()
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					return sprite_flush(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "flush";
					var _errorText = ("Attempted to unload an invalid Sprite: " +
									  "{" + string(ID) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return -1;
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} full?
			// @argument			{bool} multiline?
			// @argument			{bool} color_HSV
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the name of this Sprite.
			//						The value for maximum frame will represented as starting from 0.
			static toString = function(_full, _multiline, _color_HSV)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					var _string = "";
					
					var _mark_separator = ((_multiline) ? "\n" : ", ");
					
					if (_full)
					{
						var _text_color = "";
						
						if (is_real(color))
						{
							switch (color)
							{
								case c_aqua: _text_color = "Aqua"; break;
								case c_black: _text_color = "Black"; break;
								case c_blue: _text_color = "Blue"; break;
								case c_dkgray: _text_color = "Dark Gray"; break;
								case c_fuchsia: _text_color = "Fuchsia"; break;
								case c_gray: _text_color = "Gray"; break;
								case c_green: _text_color = "Green"; break;
								case c_lime: _text_color = "Lime"; break;
								case c_ltgray: _text_color = "Light Gray"; break;
								case c_maroon: _text_color = "Maroon"; break;
								case c_navy: _text_color = "Navy"; break;
								case c_olive: _text_color = "Olive"; break;
								case c_orange: _text_color = "Orange"; break;
								case c_purple: _text_color = "Purple"; break;
								case c_red: _text_color = "Red"; break;
								case c_teal: _text_color = "Teal"; break;
								case c_white: _text_color = "White"; break;
								case c_yellow: _text_color = "Yellow"; break;
								default:
									if (_color_HSV)
									{
										_text_color = 
										("(" +
										 "Hue: " + string(color_get_hue(color)) + _mark_separator +
										 "Saturation: " + string(color_get_saturation(color)) + 
														_mark_separator +
										 "Value: " + string(color_get_value(color)) +
										 ")");
									}
									else
									{
										_text_color = 
										("(" +
										 "Red: " + string(color_get_red(color)) + _mark_separator +
										 "Green: " + string(color_get_green(color)) +
												   _mark_separator +
										 "Blue: " + string(color_get_blue(color)) +
										 ")");
									}
								break;
							}
						}
						else
						{
							_text_color = string(color);
						}
						
						_string = ("Name: " + sprite_get_name(ID) + _mark_separator +
								   "Size: " + string(self.getSize()) + _mark_separator +
								   "Location: " + string(location) + _mark_separator +
								   "Frame: " + string(frame) + "/" + 
											   (string(sprite_get_number(ID) - 1)) + _mark_separator +
								   "Speed: " + string(speed) + _mark_separator +
								   "Scale: " + string(scale) + _mark_separator +
								   "Color: " + _text_color + _mark_separator +
								   "Alpha: " + string(alpha));
					}
					else
					{
						_string = sprite_get_name(ID);
					}
					
					return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			// @argument			{string:path} path
			// @argument			{int} frame?
			// @description			Save this Sprite to the specified .png file.
			//						If the frame to be saved is not specified, all frames will be
			//						saved in one file as a horizontal strip of images.
			static toFile = function(_path, _frame)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					if (_frame == undefined)
					{
						sprite_save_strip(ID, _path);
					}
					else
					{
						sprite_save(ID, _frame, _path);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "toFile";
					var _errorText = ("Attempted to convert an invalid Sprite: " +
									  "{" + string(ID) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
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
