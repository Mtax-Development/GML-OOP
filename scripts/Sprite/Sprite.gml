/// @function				Sprite()
///							
/// @description			Constructs a Sprite resource used to render its frames.
///							
///							Construction types:
///							- Wrapper: {int:sprite} sprite
///							- File: {string:path} path, {int} frameCount?, {Vector2} origin?,
///									{bool} removeBackground?, {bool} smoothRemovedBackground?
///							- From Surface: {int:surface|Surface} surface, {Vector4} part,
///											{Vector2} origin?, {bool} removeBackground?,
///											{bool} smoothRemovedBackground?
///							- Empty: {void|undefined}
///							- Constructor copy: {Sprite} other
function Sprite() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				ID = undefined;
				name = string(undefined);
				size = undefined;
				frameCount = undefined;
				origin = undefined;
				boundary = undefined;
				speed = undefined;
				speed_type = undefined;
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (instanceof(argument[0]) == "Sprite")
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
					
						ID = sprite_duplicate(_other.ID);
						name = sprite_get_name(ID);
						size = new Vector2(sprite_get_width(ID), sprite_get_height(ID));
						frameCount = sprite_get_number(ID);
						origin = new Vector2(sprite_get_xoffset(ID), sprite_get_yoffset(ID));
						boundary = new Vector4(sprite_get_bbox_left(ID), sprite_get_bbox_top(ID),
											   sprite_get_bbox_right(ID), sprite_get_bbox_bottom(ID));
						boundary_mode = sprite_get_bbox_mode(ID);
						speed = sprite_get_speed(ID);
						speed_type = sprite_get_speed_type(ID);
					}
					else
					{
						if ((is_string(argument[0])) and (file_exists(argument[0])))
						{
							//|Construction type: File.
							var _path = argument[0];
							var _frameCount = (((argument_count > 1) and (argument[1] != undefined))
											   ? argument[1] : 0);
							var _removeBackground = (((argument_count > 2) and
													  (argument[2] != undefined))
													  ? argument[2] : false);
							var _smoothRemovedBackground = (((argument_count > 3) and
															(argument[3] != undefined))
															? argument[3] : false);
							
							var _origin_x, _origin_y;
							
							if ((argument_count > 4) and (instanceof(argument[4]) == "Vector2"))
							{
								var _origin = argument[4];
								
								_origin_x = _origin.x;
								_origin_y = _origin.y;
							}
							else
							{
								_origin_x = 0;
								_origin_y = 0;
							}
							
							ID = sprite_add(_path, _frameCount, _removeBackground,
											_smoothRemovedBackground, _origin_x, _origin_y);
							
							name = sprite_get_name(ID);
							size = new Vector2(sprite_get_width(ID), sprite_get_height(ID));
							frameCount = sprite_get_number(ID);
							origin = new Vector2(sprite_get_xoffset(ID), sprite_get_yoffset(ID));
							boundary = new Vector4(sprite_get_bbox_left(ID), sprite_get_bbox_top(ID),
												   sprite_get_bbox_right(ID),
												   sprite_get_bbox_bottom(ID));
							boundary_mode = sprite_get_bbox_mode(ID);
							speed = sprite_get_speed(ID);
							speed_type = sprite_get_speed_type(ID);
						}
						else if ((argument_count > 1) and (instanceof(argument[1]) == "Vector4"))
						{
							//|Construction type: From Surface.
							var _surface = ((instanceof(argument[0]) == "Surface") ? argument[0].ID
																				   : argument[0]);
							var _part = argument[1];
							
							var _origin_x, _origin_y;
							
							if ((argument_count > 2) and (instanceof(argument[2]) == "Vector2"))
							{
								var _origin = argument[2];
								
								_origin_x = _origin.x;
								_origin_y = _origin.y;
							}
							else
							{
								_origin_x = 0;
								_origin_y = 0;
							}
							
							var _removeBackground = (((argument_count > 3) and
													 (argument[3] != undefined))
													 ? argument[3] : false);
							var _smoothRemovedBackground = (((argument_count > 4) and
															(argument[4] != undefined))
															? argument[4] : false);
							
							ID = sprite_create_from_surface(_surface, _part.x1, _part.y1, _part.x2,
															_part.y2, _removeBackground,
															_smoothRemovedBackground, _origin_x,
															_origin_y);
						}
						else if (is_real(argument[0]))
						{
							//|Construction type: Wrapper.
							ID = argument[0];
							name = sprite_get_name(ID);
							size = new Vector2(sprite_get_width(ID), sprite_get_height(ID));
							frameCount = sprite_get_number(ID);
							origin = new Vector2(sprite_get_xoffset(ID), sprite_get_yoffset(ID));
							boundary = new Vector4(sprite_get_bbox_left(ID), sprite_get_bbox_top(ID),
												   sprite_get_bbox_right(ID),
												   sprite_get_bbox_bottom(ID));
							boundary_mode = sprite_get_bbox_mode(ID);
							speed = sprite_get_speed(ID);
							speed_type = sprite_get_speed_type(ID);
						}
					}
				}
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (sprite_exists(ID)));
			}
			
			// @returns				{undefined}
			// @description			Remove the internal information from the memory if this Sprite
			//						was creating during the runtime only.
			static destroy = function()
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					sprite_delete(ID);
					
					ID = undefined;
				}
				
				return undefined;
			}
			
			// @argument			{Sprite|int:sprite} other
			// @description			Replace this Sprite with another one if this Sprite was created
			//						during the runtime only.
			static replace = function(_other)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					if (instanceof(_other) == "Sprite")
					{
						if (_other.isFunctional())
						{
							sprite_assign(ID, _other.ID);
							
							size = new Vector2(sprite_get_width(ID), sprite_get_height(ID));
							frameCount = sprite_get_number(ID);
							origin = new Vector2(sprite_get_xoffset(ID), sprite_get_yoffset(ID));
							boundary = new Vector4(sprite_get_bbox_left(ID),
												   sprite_get_bbox_top(ID),
												   sprite_get_bbox_right(ID),
												   sprite_get_bbox_bottom(ID));
							boundary_mode = sprite_get_bbox_mode(ID);
							speed = sprite_get_speed(ID);
							speed_type = sprite_get_speed_type(ID);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "replace";
							var _errorText = ("Attempted to replace a Sprite by an invalid one:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Other: " + "{" + string(_other) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
					}
					else if ((is_real(_other.ID)) and (sprite_exists(_other.ID)))
					{
						sprite_assign(ID, _other);
					}
					else
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "replace";
						var _errorText = ("Attempted to replace a Sprite by an invalid one:\n" +
										  "Self: " + "{" + string(self) + "}" + "\n" +
										  "Other: " + "{" + string(_other) + "}");
						_errorReport.reportConstructorMethod(self, _callstack, _methodName,
															 _errorText);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "replace";
					var _errorText = ("Attempted to replace an invalid Sprite: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Sprite|int:sprite} other
			// @description			Add the frames of another Sprite after the frames of this Sprite.
			//						The added frames will be resized to the size of this Sprite.
			static merge = function(_other)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					if (instanceof(_other) == "Sprite")
					{
						if (_other.isFunctional())
						{
							var _copy_self = sprite_duplicate(ID);
							var _copy_other = sprite_duplicate(_other.ID);
							
							sprite_merge(_copy_self, _copy_other);
							sprite_assign(ID, _copy_self);
							
							sprite_delete(_copy_self);
							sprite_delete(_copy_other);
							
							frameCount = sprite_get_number(ID);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "merge";
							var _errorText = ("Attempted to merge a Sprite with an invalid one:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Other: " + "{" + string(_other) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
					}
					else if ((is_real(_other.ID)) and (sprite_exists(_other.ID)))
					{
						sprite_merge(ID, _other);
					}
					else
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "merge";
						var _errorText = ("Attempted to merge a Sprite with an invalid one:\n" +
											"Self: " + "{" + string(self) + "}" + "\n" +
											"Other: " + "{" + string(_other) + "}");
						_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																_errorText);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "merge";
					var _errorText = ("Attempted to merge an invalid Sprite: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{struct:nineslice}
			// @description			Return a struct representing the Nine Slice of this Sprite.
			//						Changes to the properties of that struct will have an immediate
			//						effect.
			static getNineslice = function()
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					return sprite_get_nineslice(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getNineslice";
					var _errorText = ("Attempted to get a property of an invalid Sprite: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{int} frame?
			// @returns				{pointer}
			// @description			Return a pointer for the texture page of the specified frame
			//						of this Sprite.
			static getTexture = function(_frame)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					var _frame_value = ((_frame != undefined) ? _frame : 0);
					
					return sprite_get_texture(ID, _frame_value);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getTexture";
					var _errorText = ("Attempted to get a property of an invalid Sprite: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return pointer_invalid;
				}
			}
			
			// @argument			{int} frame?
			// @argument			{bool} full?
			// @returns				{Vector4|real[]}
			// @description			Return the UV coordinates for the location of the specified frame
			//						of this Sprite on its texture page.
			//						It will be returned as an Vector4 if the full information is not
			//						requested. Otherwise, an array with 8 elements will be returned
			//						with the following data at respective positions:
			//						- array[0]: {real} UV left
			//						- array[1]: {real} UV top
			//						- array[2]: {real} UV right
			//						- array[3]: {real} UV bottom
			//						- array[4]: {int} pixels trimmed from left
			//						- array[5]: {int} pixels trimmed from right
			//						- array[6]: {real} x percentage of pixels on the texture page
			//						- array[7]: {real} y percentage of pixels on the texture page
			static getUV = function(_frame = 0, _full = false)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					var _uv = sprite_get_uvs(ID, _frame);
					
					return ((_full) ? _uv : new Vector4(_uv[0], _uv[1], _uv[2], _uv[3]));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getUV";
					var _errorText = ("Attempted to get a property of an invalid Sprite: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{struct:nineslice}
			// @description			Set a Nine Slice struct that is bound to another or no other
			//						Sprite to this Sprite.
			static setNineslice = function(_nineslice)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					sprite_set_nineslice(ID, _nineslice);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setNineslice";
					var _errorText = ("Attempted to set a property of an invalid Sprite: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{real} speed
			// @argument			{constant:spritespeed_*} type?
			// @description			Set the animation speed of this Sprite for every object instance.
			static setSpeed = function(_speed, _type = spritespeed_framespersecond)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					speed = _speed;
					speed_type = _type;
					
					sprite_set_speed(ID, speed, speed_type);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setSpeed";
					var _errorText = ("Attempted to set a property of an invalid Sprite: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{constant:bboxmode_*} boundaryMode?
			// @argument			{constant:bboxkind_*} boundaryType?
			// @argument			{Vector4} boundary?
			// @argument			{int} alphaTolerance?
			// @argument			{bool} separateMasks?
			// @description			Set the collision mask properties of this Sprite if it was created
			//						during the runtime only.
			//						The boundary is calculated differently depending on its mode:
			//						- The boundary itself has to be specified only if the manual mode
			//						  is used.
			//						- Alpha tolerance has to be specified only if the mode is not Full
			//						  Image and will be used to ignore pixels which have the alpha
			//						  value that equal or exceed it.
			//						A separate mask can be created for each frame of this Sprite,
			//						which can be used if their shape or alpha values are to affect the
			//						collision mask.
			static setCollisionMask = function(_boundaryMode = bboxmode_automatic,
											   _boundaryType = bboxkind_rectangular, _boundary,
											   _alphaTolerance, _separateMasks = false)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					var _boundary_x1, _boundary_y1, _boundary_x2, _boundary_y2;
				
					if ((_boundaryMode == 0) or (_boundaryMode == 1))
					{
						_boundary_x1 = 0;
						_boundary_y1 = 0;
						_boundary_x2 = 0;
						_boundary_y2 = 0;
					}
					else if (_boundary == undefined)
					{
						_boundary_x1 = 0;
						_boundary_y1 = 0;
						_boundary_x2 = sprite_get_width(ID);
						_boundary_y2 = sprite_get_height(ID);
					}
					else
					{
						_boundary_x1 = _boundary.x1;
						_boundary_y1 = _boundary.y1;
						_boundary_x2 = _boundary.x2;
						_boundary_y2 = _boundary.y2;
					}
					
					if ((_alphaTolerance == undefined) or (_boundaryMode == 1))
					{
						_alphaTolerance = 0;
					}
					
					sprite_collision_mask(ID, _separateMasks, _boundaryMode, _boundary_x1,
										  _boundary_y1, _boundary_x2, _boundary_y2, _boundaryType,
										  _alphaTolerance);
					sprite_set_bbox_mode(ID, _boundaryMode); //|This has to be set separately.
					
					boundary = new Vector4(sprite_get_bbox_left(ID), sprite_get_bbox_top(ID),
										   sprite_get_bbox_right(ID), sprite_get_bbox_bottom(ID));
					boundary_mode = sprite_get_bbox_mode(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setCollisionMask";
					var _errorText = ("Attempted to set a property of an invalid Sprite: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{Vector2} location
			// @argument			{int} frame?
			// @argument			{Scale} scale?
			// @argument			{Angle} angle?
			// @argument			{int:color} color?
			// @argument			{int} alpha?
			// @description			Draw this Sprite to the current Surface.
			static render = function(_location, _frame = 0, _scale = new Scale(1, 1),
									 _angle = new Angle(0), _color = c_white, _alpha = 1)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					draw_sprite_ext(ID, _frame, _location.x, _location.y, _scale.x, _scale.y,
									_angle.value, _color, _alpha);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "render";
					var _errorText = ("Attempted to render an invalid Sprite: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{Vector4} part
			// @argument			{int} frame?
			// @argument			{Scale} scale?
			// @argument			{int:color} color?
			// @argument			{int} alpha?
			// @description			Draw only the specified rectangular part of this Sprite to the
			//						current Surface.
			//						The top left point of the part will be treated as the origin point
			//						for this draw.
			static renderPart = function(_location, _part, _frame = 0)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					if (argument_count > 3)
					{
						var _scale = argument[3];
						var _scale_x, _scale_y;
						
						if (_scale == undefined)
						{
							_scale_x = 1;
							_scale_y = 1;
						}
						else
						{
							_scale_x = _scale.x;
							_scale_y = _scale.y;
						}
						
						var _color_value = (((argument_count > 4) and (argument[4] != undefined))
											? argument[4] : c_white);
						var _alpha_value = (((argument_count > 5) and (argument[5] != undefined))
											? argument[5] : 1);
						
						draw_sprite_part_ext(ID, _frame, _part.x1, _part.y1, _part.x2, _part.y2,
											 _location.x, _location.y, _scale_x, _scale_y,
											 _color_value, _alpha_value);
					}
					else
					{
						draw_sprite_part(ID, _frame, _part.x1, _part.y1, _part.x2, _part.y2,
										 _location.x, _location.y);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "renderPart";
					var _errorText = ("Attempted to render an invalid Sprite: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{Vector4} part?
			// @argument			{int} frame?
			// @argument			{Scale} scale?
			// @argument			{Angle} angle?
			// @argument			{int:color|Color4} color?
			// @argument			{int} alpha?
			// @description			Draw this Sprite with the specified alternations to the current
			//						Surface.
			//						The top left point of the part will be treated as the origin point
			//						for this draw.
			static renderGeneral = function(_location, _part, _frame = 0, _scale, _angle, _color,
											_alpha = 1)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					var _part_x1, _part_y1, _part_x2, _part_y2;
					
					if (_part == undefined)
					{
						_part_x1 = 0;
						_part_y1 = 0;
						_part_x2 = sprite_get_width(ID);
						_part_y2 = sprite_get_height(ID);
					}
					else
					{
						_part_x1 = _part.x1;
						_part_y1 = _part.y1;
						_part_x2 = _part.x2;
						_part_y2 = _part.y2;
					}
					
					var _scale_x, _scale_y;
					
					if (_scale == undefined)
					{
						_scale_x = 1;
						_scale_y = 1;
					}
					else
					{
						_scale_x = _scale.x;
						_scale_y = _scale.y;
					}
					
					var _angle_value = ((_angle != undefined) ? _angle.value : 0);
					
					var _color_x1y1, _color_x2y1, _color_x2y2, _color_x1y2;
					
					if (_color == undefined)
					{
						_color_x1y1 = c_white;
						_color_x2y1 = c_white;
						_color_x2y2 = c_white;
						_color_x1y2 = c_white;
					}
					else if (is_real(_color))
					{
						_color_x1y1 = _color;
						_color_x2y1 = _color;
						_color_x2y2 = _color;
						_color_x1y2 = _color;
					}
					else
					{
						_color_x1y1 = _color.color1;
						_color_x2y1 = _color.color2;
						_color_x2y2 = _color.color3;
						_color_x1y2 = _color.color4;
					}
					
					draw_sprite_general(ID, _frame, _part_x1, _part_y1, _part_x2, _part_y2,
										_location.x, _location.y, _scale_x, _scale_y, _angle_value,
										_color_x1y1, _color_x2y1, _color_x2y2, _color_x1y2,
										_alpha);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "renderGeneral";
					var _errorText = ("Attempted to render an invalid Sprite: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{Vector2} size
			// @argument			{int} frame?
			// @argument			{int:color} color?
			// @argument			{int} alpha?
			// @description			Draw this Sprite after scaling it to match the specified size to
			//						the current Surface.
			//						The top left point of this Sprite is treated as the origin point
			//						for this draw.
			static renderSize = function(_location, _size, _frame = 0)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					if (argument_count > 3)
					{
						var _color_value = ((argument[3] != undefined) ? argument[3] : c_white);
						var _alpha_value = (((argument_count > 4) and (argument[4] != undefined))
											? argument[4] : 1);
						
						draw_sprite_stretched_ext(ID, _frame, _location.x, _location.y, _size.x,
												  _size.y, _color_value, _alpha_value);
					}
					else
					{
						draw_sprite_stretched(ID,_frame, _location.x, _location.y, _size.x,
											  _size.y);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "renderSize";
					var _errorText = ("Attempted to render an invalid Sprite: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Vector2} offset?
			// @argument			{int} frame?
			// @argument			{Scale} scale?
			// @argument			{int:color} color?
			// @argument			{int} alpha?
			// @description			Draw this Sprite tiled through the entire view, the target created
			//						Surface or if neither are used, the current Room.
			static renderTiled = function(_offset, _frame = 0)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
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
					
					if (argument_count > 2)
					{
						var _scale_x, _scale_y;
						var _scale = argument[2];
						
						if (_scale == undefined)
						{
							_scale_x = 1;
							_scale_y = 1;
						}
						else
						{
							_scale_x = _scale.x;
							_scale_y = _scale.y;
						}
						
						var _color_value = (((argument_count > 4) and (argument[4] != undefined))
											? argument[4] : c_white);
						var _alpha_value = (((argument_count > 5) and (argument[5] != undefined))
											? argument[5] : 1);
						
						draw_sprite_tiled_ext(ID, _frame, _offset_x, _offset_y, _scale_x,
											  _scale_y, _color_value, _alpha_value);
					}
					else
					{
						draw_sprite_tiled(ID, _frame, _offset_x, _offset_y);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "renderTiled";
					var _errorText = ("Attempted to render an invalid Sprite: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Vector2} location1
			// @argument			{Vector2} location2
			// @argument			{Vector2} location3
			// @argument			{Vector2} location4
			// @argument			{int} frame?
			// @argument			{real} alpha?
			// @description			Draw this Sprite with perspective altered by its edges.
			static renderPerspective = function(_location1, _location2, _location3, _location4,
												_frame = 0, _alpha = 1)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					draw_sprite_pos(ID, _frame, _location1.x, _location1.y, _location2.x,
									_location2.y, _location3.x, _location3.y, _location4.x,
									_location4.y, _alpha);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "renderPerspective";
					var _errorText = ("Attempted to render an invalid Sprite: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{bool} load
			// @returns				{int:0} | On error: {int:-1}
			// @description			Load or unload the texture page of this Sprite in the memory.
			static load = function(_load)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					switch (_load)
					{
						case true: return sprite_prefetch(ID) break;
						case false: return sprite_flush(ID); break;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "load";
					var _errorText = ("Attempted to manage an invalid Sprite: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return -1;
				}
			}
			
			// @argument			{Sprite} other
			// @returns				{Sprite} | On error: {noone}
			// @description			Multiply the value and saturation of the colors of this Sprite by
			//						the alpha values of other one and return it as a new Sprite.
			static generateAlphaMap = function(_other)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					if (instanceof(_other) == "Sprite") and (_other.isFunctional())
					{
						var _copy_self = new Sprite(ID);
						var _copy_other = sprite_duplicate(_other.ID);
						
						sprite_set_alpha_from_sprite(_copy_self.ID, _copy_other);
						
						sprite_delete(_copy_other);
						
						return _copy_self;
					}
					else
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "generateAlphaMap";
						var _errorText = ("Attempted to alter a Sprite using an invalid one:\n" +
										  "Self: " + "{" + string(self) + "}" + "\n" +
										  "Other: " + "{" + string(_other) + "}");
						_errorReport.reportConstructorMethod(self, _callstack, _methodName,
															 _errorText);
						
						return noone;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "generateAlphaMap";
					var _errorText = ("Attempted to alter an invalid Sprite: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return noone;
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @argument			{bool} full?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the details of this Sprite.
			static toString = function(_multiline = false, _full = false)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					var _string = "";
					var _mark_separator = ((_multiline) ? "\n" : ", ");
					
					if (_full)
					{
						var _string_speed_type = "";
						
						if (is_real(speed))
						{
							switch(speed_type)
							{
								case spritespeed_framespersecond:
									_string_speed_type = " Frames Per Second";
								break;
								
								case spritespeed_framespergameframe:
									_string_speed_type = " Frames Per Application Frame";
								break;
							}
						}
						
						_string = ("Name: " + string(name) + _mark_separator +
								   "Size: " + string(size) + _mark_separator +
								   "Frame Count: " + string(frameCount) + _mark_separator +
								   "Origin: " + string(origin) + _mark_separator +
								   "Speed: " + string(speed) + _string_speed_type);
					}
					else
					{
						_string = string(name);
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
			// @description			Save this Sprite to the specified .png file, either only its one
			//						specified frame or all of them in one file in a horoziontal strip.
			static toFile = function(_path, _frame)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					if (_frame != undefined)
					{
						sprite_save(ID, _frame, _path);
					}
					else
					{
						sprite_save_strip(ID, _path);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "toFile";
					var _errorText = ("Attempted to convert an invalid Sprite: " +
									  "{" + string(ID) + "}");
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
