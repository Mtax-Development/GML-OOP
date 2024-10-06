//  @function				Sprite()
/// @description			Constructs a Sprite resource used to render its image frames.
//							
//							Construction types:
//							- Wrapper: sprite {int:sprite}
//							- From file: path {string:path}, frameCount? {int}, origin? {Vector2},
//										 removeBackground? {bool}, smoothRemovedBackground? {bool}
//							- From Surface: surface {int:surface|Surface}, part {Vector4|all},
//											origin? {Vector2}, removeBackground? {bool},
//											smoothRemovedBackground? {bool}
//							- Empty: {void|undefined}
//							- Constructor copy: other {Sprite}
function Sprite() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				ID = undefined;
				name = string(undefined);
				size = undefined;
				frameCount = undefined;
				origin = undefined;
				boundary = undefined;
				boundary_mode = undefined;
				speed = undefined;
				speed_type = undefined;
				
				event =
				{
					beforeRender: new Callback(undefined, [], other),
					afterRender: new Callback(undefined, [], other)
				};
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (is_instanceof(argument[0], Sprite))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
					
						ID = sprite_duplicate(_other.ID);
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
						
						if (is_struct(_other.event))
						{
							event.beforeRender.setAll(_other.event.beforeRender);
							event.afterRender.setAll(_other.event.afterRender);
						}
						else
						{
							event = _other.event;
						}
					}
					else
					{
						if ((is_string(argument[0])) and (file_exists(argument[0])))
						{
							//|Construction type: From file.
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
							
							if ((argument_count > 4) and (is_instanceof(argument[4], Vector2)))
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
						else if ((argument_count > 1) and ((argument[1] == all)
						or (is_instanceof(argument[1], Vector4))))
						{
							//|Construction type: From Surface.
							var _surface = ((is_instanceof(argument[0], Surface)) ? argument[0].ID
																				  : argument[0]);
							var _part_x1, _part_y1, _part_x2, _part_y2;
							
							if (argument[1] == all)
							{
								_part_x1 = 0;
								_part_y1 = 0;
								_part_x2 = surface_get_width(_surface);
								_part_y2 = surface_get_height(_surface);
							}
							else
							{
								var _part = argument[1];
								var _part_minimum_x = min(_part.x1, _part.x2);
								var _part_maximum_x = max(_part.x1, _part.x2);
								var _part_minimum_y = min(_part.y1, _part.y2);
								var _part_maximum_y = max(_part.y1, _part.y2);
								_part_x1 = _part_minimum_x;
								_part_y1 = _part_minimum_y;
								_part_x2 = (_part_maximum_x - _part_minimum_x);
								_part_y2 = (_part_maximum_y - _part_minimum_y);
							}
							
							var _origin_x, _origin_y;
							
							if ((argument_count > 2) and (is_instanceof(argument[2], Vector2)))
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
							
							ID = sprite_create_from_surface(_surface, _part_x1, _part_y1, _part_x2,
															_part_y2, _removeBackground,
															_smoothRemovedBackground, _origin_x,
															_origin_y);
						}
						else if ((is_handle(argument[0])) or (is_real(argument[0])))
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
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return (((is_handle(ID)) or (is_real(ID))) and (sprite_exists(ID)));
			}
			
			/// @returns			{undefined}
			/// @description		Remove the internal information from the memory.
			///						Applicable only if this Sprite was created during the runtime.
			static destroy = function()
			{
				if (self.isFunctional())
				{
					sprite_delete(ID);
					
					ID = undefined;
				}
				
				return undefined;
			}
			
			/// @argument			other {Sprite|int:sprite}
			/// @description		Replace this Sprite with another one.
			///						Applicable only if this Sprite was created during the runtime.
			static replace = function(_other)
			{
				try
				{
					sprite_assign(ID, ((is_instanceof(_other, Sprite)) ? _other.ID : _other));
					
					var _size_x = sprite_get_width(ID);
					var _size_y = sprite_get_height(ID);
					
					if (is_instanceof(size, Vector2))
					{
						size.x = _size_x;
						size.y = _size_y;
					}
					else
					{
						size = new Vector2(_size_x, _size_y);
					}
					
					frameCount = sprite_get_number(ID);
					
					var _origin_x = sprite_get_xoffset(ID);
					var _origin_y = sprite_get_yoffset(ID);
					
					if (is_instanceof(origin, Vector2))
					{
						origin.x = _origin_x;
						origin.y = _origin_y;
					}
					else
					{
						origin = new Vector2(_origin_x, _origin_y);
					}
					
					var _boundary_x1 = sprite_get_bbox_left(ID);
					var _boundary_y1 = sprite_get_bbox_top(ID);
					var _boundary_x2 = sprite_get_bbox_right(ID);
					var _boundary_y2 = sprite_get_bbox_bottom(ID);
					
					if (is_instanceof(boundary, Vector4))
					{
						boundary.x1 = _boundary_x1;
						boundary.y1 = _boundary_y1;
						boundary.x2 = _boundary_x2;
						boundary.y2 = _boundary_y2;
					}
					else
					{
						boundary = new Vector4(_boundary_x1, _boundary_y1, _boundary_x2,
											   _boundary_y2);
					}
					
					boundary_mode = sprite_get_bbox_mode(ID);
					speed = sprite_get_speed(ID);
					speed_type = sprite_get_speed_type(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "replace()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			other {Sprite|int:sprite}
			/// @description		Add the frames of another Sprite after the frames of this Sprite.
			///						The added frames will be resized to the size of this Sprite.
			static merge = function(_other)
			{
				if (self.isFunctional())
				{
					if (is_instanceof(_other, Sprite))
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
							new ErrorReport().report([other, self, "merge()"],
													 ("Attempted to merge a Sprite with an invalid " +
													  "one:" + "\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Other: " + "{" + string(_other) + "}"));
						}
					}
					else if ((is_handle(_other)) and (sprite_exists(_other)))
					{
						sprite_merge(ID, _other);
						
						frameCount = sprite_get_number(ID);
					}
					else
					{
						new ErrorReport().report([other, self, "merge()"],
												 ("Attempted to merge a Sprite with an invalid " +
												  "one:" + "\n" +
												  "Self: " + "{" + string(self) + "}" + "\n" +
												  "Other: " + "{" + string(_other) + "}"));
					}
				}
				else
				{
					new ErrorReport().report([other, self, "merge()"],
											 ("Attempted to merge an invalid Sprite: " +
											  "{" + string(ID) + "}"));
				}
				
				return self;
			}
			
		#endregion
		#region <Getters>
			
			/// @returns			{struct:nineslice} | On error: {noone}
			/// @description		Return a struct representing the Nine Slice of this Sprite.
			///						Changes to the properties of that struct will have an immediate
			///						effect.
			static getNineslice = function()
			{
				try
				{
					return sprite_get_nineslice(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getNineslice()"], _exception);
				}
				
				return noone;
			}
			
			/// @argument			frame? {int}
			/// @returns			{pointer}
			/// @description		Return a pointer for the texture page of the specified frame
			///						of this Sprite.
			static getTexture = function(_frame = 0)
			{
				try
				{
					return sprite_get_texture(ID, _frame);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getTexture()"], _exception);
				}
			}
			
			/// @argument			frame? {int}
			/// @returns			{Vector2} | On error: {undefined}
			/// @description		Get the texel size of the texture page of the specified frame of
			///						this Sprite.
			static getTexel = function(_frame = 0)
			{
				try
				{
					var _texture = sprite_get_texture(ID, _frame);
					
					return new Vector2(texture_get_texel_width(_texture),
									   texture_get_texel_height(_texture));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getTexel()"], _exception);
				}
			}
			
			/// @argument			frame? {int}
			/// @argument			full? {bool}
			/// @returns			{Vector4|real[8]} | On error: {undefined}
			/// @description		Return the UV coordinates for the location of the specified frame
			///						of this Sprite on its texture page.
			///						It will be returned as an Vector4 if the full information is not
			///						requested. Otherwise, an array with 8 elements will be returned
			///						with the following data at its respective positions:
			///						- array[0]: UV left {real}
			///						- array[1]: UV top {real}
			///						- array[2]: UV right {real}
			///						- array[3]: UV bottom {real}
			///						- array[4]: pixels trimmed from left {int}
			///						- array[5]: pixels trimmed from right {int}
			///						- array[6]: x percentage of pixels on the texture page {real}
			///						- array[7]: y percentage of pixels on the texture page {real}
			static getUV = function(_frame = 0, _full = false)
			{
				try
				{
					var _uv = sprite_get_uvs(ID, _frame);
					
					return ((_full) ? _uv : new Vector4(_uv[0], _uv[1], _uv[2], _uv[3]));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getUV()"], _exception);
				}
				
				return undefined;
			}
			
		#endregion
		#region <Setters>
			
			/// @argument			nineslice {struct:nineslice}
			/// @description		Set a Nine Slice struct that is bound to another or no other
			///						Sprite to this Sprite.
			static setNineslice = function(_nineslice)
			{
				try
				{
					sprite_set_nineslice(ID, _nineslice);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setNineslice()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			origin {Vector2}
			/// @description		Set the origin point, which is an offset from the top-left pixel
			///						of this Sprite added to its render location and the center of
			///						rotation.
			///						Applicable only if this Sprite is an asset Sprite.
			static setOrigin = function(_origin)
			{
				try
				{
					sprite_set_offset(ID, _origin.x, _origin.y);
					
					origin = _origin;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setOrigin()"], _exception);
				}
			}
			
			/// @argument			speed {real}
			/// @argument			type? {constant:spritespeed_*}
			/// @description		Set the animation speed of this Sprite for every object instance.
			static setSpeed = function(_speed, _type = spritespeed_framespersecond)
			{
				try
				{
					sprite_set_speed(ID, _speed, _type);
					
					speed = _speed;
					speed_type = _type;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setSpeed()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			boundaryMode? {constant:bboxmode_*}
			/// @argument			boundaryType? {constant:bboxkind_*}
			/// @argument			boundary? {Vector4}
			/// @argument			alphaTolerance? {int}
			/// @argument			separateMasks? {bool}
			/// @description		Set the collision mask properties of this Sprite.
			///						Applicable only if this Sprite was created during the runtime.
			///						The boundary is calculated differently depending on its mode:
			///						- The boundary itself has to be specified only if the manual mode
			///						  is used.
			///						- Alpha tolerance has to be specified only if the mode is not
			///						  Full Image and will be used to ignore pixels which have the
			///						  alpha value that equal or exceed it.
			///						A separate mask can be created for each frame of this Sprite,
			///						which can be used if their shape or alpha values are to affect
			///						the collision mask.
			static setCollisionMask = function(_boundaryMode = bboxmode_automatic,
											   _boundaryType = bboxkind_rectangular, _boundary,
											   _alphaTolerance, _separateMasks = false)
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setCollisionMask()"], _exception);
				}
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			location {Vector2|Vector4}
			/// @argument			frame? {int}
			/// @argument			scale? {Scale}
			/// @argument			angle? {Angle}
			/// @argument			color? {int:color|Color4}
			/// @argument			alpha? {real}
			/// @argument			part? {Vector4}
			/// @argument			origin? {Vector2}
			/// @argument			target? {Surface|int:surface}
			/// @description		Draw this Sprite or a part of it to the currently active or
			///						specified Surface.
			static render = function(_location, _frame = 0, _scale, _angle, _color = c_white,
									 _alpha = 1, _part, _origin, _target)
			{
				var _targetStack = undefined;
				
				try
				{
					if (self.isFunctional())
					{
						event.beforeRender.execute();
						
						if (_target != undefined)
						{
							var _target_value = ((is_instanceof(_target, Surface)) ? _target.ID
																				   : _target);
							
							if ((is_handle(_target_value)) and (surface_exists(_target_value)))
							{
								_targetStack = ds_stack_create();
								var _currentTarget = surface_get_target();
								
								while ((_currentTarget != _target_value) and (_currentTarget > 0)
								and (_currentTarget != application_surface))
								{
									ds_stack_push(_targetStack, _currentTarget);
									
									surface_reset_target();
									
									_currentTarget = surface_get_target();
								}
								
								surface_set_target(_target_value);
							}
							else
							{
								new ErrorReport().report([other, self, "render()"],
														 ("Attempted to render to an invalid " +
														  "Surface: " + "\n" +
														  "Self: " + "{" + string(self) + "}" + "\n" +
														  "Other: " + "{" + string(_target) + "}"));
							}
						}
						
						var _size_x = sprite_get_width(ID);
						var _size_y = sprite_get_height(ID);
						var _scale_x = 1;
						var _scale_y = 1;
						
						if (_scale != undefined)
						{
							_scale_x = _scale.x;
							_scale_y = _scale.y;
						}
						
						var _origin_x, _origin_y;
						
						if (_origin != undefined)
						{
							_origin_x = _origin.x;
							_origin_y = _origin.y;
						}
						else
						{
							_origin_x = sprite_get_xoffset(ID);
							_origin_y = sprite_get_yoffset(ID);
						}
						
						var _location_x, _location_y;
						
						if ((is_instanceof(_location, Vector4)))
						{
							_scale_x = (((_location.x2 - _location.x1) / _size_x) * _scale_x);
							_scale_y = (((_location.y2 - _location.y1) / _size_y) * _scale_y);
							_location_x = _location.x1 + (_origin_x * _scale_x);
							_location_y = _location.y1 + (_origin_y * _scale_y);
						}
						else
						{
							_location_x = _location.x;
							_location_y = _location.y;
						}
						
						var _color_x1y1, _color_x2y1, _color_x2y2, _color_x1y2;
						
						if (is_real(_color))
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
						
						var _part_x1, _part_y1, _part_x2, _part_y2;
						
						if (_part != undefined)
						{
							_part_x1 = clamp(_part.x1, 0, _size_x);
							_part_y1 = clamp(_part.y1, 0, _size_y);
							_part_x2 = clamp(_part.x2, 0, (_size_x - _part_x1));
							_part_y2 = clamp(_part.y2, 0, (_size_y - _part_y1));
						}
						else
						{
							_part_x1 = 0;
							_part_y1 = 0;
							_part_x2 = _size_x;
							_part_y2 = _size_y;
						}
						
						var _angle_value = 0;
						
						if (_angle != undefined)
						{
							_angle_value = _angle.value;
						}
						
						var _origin_transformed_x = (_part_x1 - lerp(_part_x1, (_part_x1 + _part_x2),
																	 ((_origin_x * _scale_x) /
																	  _size_x)));
						var _origin_transformed_y = (_part_y1 - lerp(_part_y1, (_part_y1 + _part_y2),
																	 ((_origin_y * _scale_y) /
																	  _size_y)));
						var _angle_dcos = dcos(_angle_value);
						var _angle_dsin = dsin(_angle_value);
						
						_location_x = (_location_x + (_origin_transformed_x * _angle_dcos) +
									   (_origin_transformed_y * _angle_dsin));
						_location_y = (_location_y - (_origin_transformed_x * _angle_dsin) +
									   (_origin_transformed_y * _angle_dcos));
						
						draw_sprite_general(ID, _frame, _part_x1, _part_y1, _part_x2, _part_y2,
											_location_x, _location_y, _scale_x, _scale_y,
											_angle_value, _color_x1y1, _color_x2y1, _color_x2y2,
											_color_x1y2, _alpha);
						
						if (is_handle(_targetStack))
						{
							surface_reset_target();
							
							repeat (ds_stack_size(_targetStack))
							{
								surface_set_target(ds_stack_pop(_targetStack));
							}
						}
						
						event.afterRender.execute();
					}
					else
					{
						new ErrorReport().report([other, self, "render()"],
												 ("Attempted to render an invalid Sprite: " +
												  "{" + string(ID) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "render()"], _exception);
				}
				finally
				{
					if (is_handle(_targetStack))
					{
						ds_stack_destroy(_targetStack);
					}
				}
				
				return self;
			}
			
			/// @argument			offset? {Vector2}
			/// @argument			frame? {int}
			/// @argument			scale? {Scale}
			/// @argument			color? {int:color}
			/// @argument			alpha? {real}
			/// @description		Draw this Sprite repeatedly tiled through the entire view, the
			///						currently active created Surface or if neither are used, the
			///						current Room.
			static renderTiled = function(_offset, _frame = 0)
			{
				try
				{
					if (self.isFunctional())
					{
						event.beforeRender.execute();
						
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
						
						event.afterRender.execute();
					}
					else
					{
						new ErrorReport().report([other, self, "renderTiled()"],
												 ("Attempted to render an invalid Sprite: " +
												  "{" + string(ID) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "renderTiled()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			location1 {Vector2}
			/// @argument			location2 {Vector2}
			/// @argument			location3 {Vector2}
			/// @argument			location4 {Vector2}
			/// @argument			frame? {int}
			/// @argument			alpha? {real}
			/// @description		Draw this Sprite to the currently active Surface with perspective
			///						altered by its boundaries.
			static renderPerspective = function(_location1, _location2, _location3, _location4,
												_frame = 0, _alpha = 1)
			{
				try
				{
					if (self.isFunctional())
					{
						event.beforeRender.execute();
						draw_sprite_pos(ID, _frame, _location1.x, _location1.y, _location2.x,
										_location2.y, _location3.x, _location3.y, _location4.x,
										_location4.y, _alpha);
						event.afterRender.execute();
					}
					else
					{
						new ErrorReport().report([other, self, "renderPerspective()"],
												 ("Attempted to render an invalid Sprite: " +
												  "{" + string(ID) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "renderPerspective()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			load {bool}
			/// @returns			{int:0} | On error: {int:-1}
			/// @description		Load or unload the texture page of this Sprite in the memory.
			static load = function(_load)
			{
				try
				{
					switch (_load)
					{
						case true: return sprite_prefetch(ID) break;
						case false: return sprite_flush(ID); break;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "load()"], _exception);
				}
				
				return -1;
			}
			
			/// @argument			other {Sprite|int:sprite}
			/// @returns			{Sprite} | On error: {noone}
			/// @description		Multiply the value and saturation of the colors of this Sprite by
			///						the alpha values of other one and return it as a separate Sprite.
			static generateAlphaMap = function(_other)
			{
				try
				{
					var _sprite_other = ((is_instanceof(_other, Sprite)) ? _other.ID : _other);
					var _copy_self = sprite_duplicate(ID);
					var _copy_other = sprite_duplicate(_sprite_other);
					
					sprite_set_alpha_from_sprite(_copy_self, _copy_other);
					sprite_delete(_copy_other);
					
					return new Sprite(_copy_self);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "generateAlphaMap()"], _exception);
				}
				
				return noone;
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @argument			full? {bool}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented with the details of this Sprite.
			static toString = function(_multiline = false, _full = false)
			{
				if (self.isFunctional())
				{
					var _string = "";
					var _mark_separator = ((_multiline) ? "\n" : ", ");
					var _string_name = sprite_get_name(ID);
					
					if (_full)
					{
						var _string_size = string(new Vector2(sprite_get_width(ID),
															  sprite_get_height(ID)));
						var _string_frameCount = string(sprite_get_number(ID));
						var _string_origin = string(new Vector2(sprite_get_xoffset(ID),
																sprite_get_yoffset(ID)));
						
						var _string_boundary = string(new Vector4(sprite_get_bbox_left(ID),
																  sprite_get_bbox_top(ID),
																  sprite_get_bbox_right(ID),
																  sprite_get_bbox_bottom(ID)));
						var _string_boundary_mode = "";
						switch (sprite_get_bbox_mode(ID))
						{
							case bboxmode_automatic:
								_string_boundary_mode = "Automatic - ";
							break;
							case bboxmode_fullimage:
								_string_boundary_mode = "Full Image - ";
							break;
							case bboxmode_manual:
								_string_boundary_mode = "Manual - ";
							break;
						}
						
						var _string_speed = string(sprite_get_speed(ID));
						var _string_speed_type = "";
						switch (sprite_get_speed_type(ID))
						{
							case spritespeed_framespersecond:
								_string_speed_type = " Frames Per Second";
							break;
							case spritespeed_framespergameframe:
								_string_speed_type = " Frames Per Application Frame";
							break;
						}
						
						_string = ("Name: " + _string_name + _mark_separator +
								   "Size: " + _string_size + _mark_separator +
								   "Frame Count: " + _string_frameCount + _mark_separator +
								   "Origin: " + _string_origin + _mark_separator +
								   "Boundary: " + _string_boundary_mode + _string_boundary
												+ _mark_separator +
								   "Speed: " + _string_speed + _string_speed_type);
					}
					else
					{
						_string = _string_name;
					}
					
					return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			/// @argument			path {string:path}
			/// @argument			frame? {int}
			/// @description		Save this Sprite to the specified PNG file, either only its one
			///						specified frame or all of them in one file in a horizontal strip.
			///						Applicable only if this Sprite was created during the runtime.
			static toFile = function(_path, _frame)
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "toFile()"], _exception);
				}
				
				return self;
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static constructor = Sprite;
		
		static prototype = {};
		var _property = variable_struct_get_names(prototype);
		var _i = 0;
		repeat (array_length(_property))
		{
			var _name = _property[_i];
			var _value = variable_struct_get(prototype, _name);
			
			variable_struct_set(self, _name, ((is_method(_value)) ? method(self, _value) : _value));
			
			++_i;
		}
		
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
