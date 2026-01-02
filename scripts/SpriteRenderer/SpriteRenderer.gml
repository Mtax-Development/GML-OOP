//  @function				SpriteRenderer()
/// @argument				sprite? {Sprite}
/// @argument				location? {Vector2|Vector4}
/// @argument				frame? {int}
/// @argument				scale? {Scale}
/// @argument				angle? {Angle}
/// @argument				color? {int:color|Color4}
/// @argument				alpha? {real}
/// @argument				part? {Vector4}
/// @argument				origin? {Vector2}
/// @argument				target? {Surface|handle:surface}
/// @description			Constructs a Handler storing information for Sprite rendering.
// 							
// 							Construction types:
// 							- New constructor
// 							- Empty: {void}
// 							- Constructor copy: other {SpriteRenderer}
function SpriteRenderer() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				sprite = undefined;
				location = undefined;
				frame = undefined;
				scale = undefined;
				angle = undefined;
				color = undefined;
				alpha = undefined;
				part = undefined;
				origin = undefined;
				target = undefined;
				
				var _scope = self;
				event =
				{
					beforeRender: new Callback(undefined, [], _scope),
					afterRender: new Callback(undefined, [], _scope),
					getPrimitiveRenderData: new Callback(function(_data) {return _data;}, [], _scope),
				};
				
				if (argument_count > 0)
				{
					if (is_instanceof(argument[0], SpriteRenderer))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						sprite = ((is_instanceof(_other.sprite, Sprite))
								  ? new Sprite(_other.sprite.ID) : _other.sprite);
						
						if (is_instanceof(_other.location, Vector2))
						{
							location = new Vector2(_other.location);
						}
						else if (is_instanceof(_other.location, Vector4))
						{
							location = new Vector4(_other.location);
						}
						else
						{
							location = _other.location;
						}
						
						frame = _other.frame;
						scale = ((is_instanceof(_other.scale, Scale)) ? new Scale(_other.scale)
																	  : _other.scale);
						angle = ((is_instanceof(_other.angle, Angle)) ? new Angle(_other.angle)
																	  : _other.angle);
						color = _other.color;
						alpha = _other.alpha;
						part = ((is_instanceof(_other.part, Vector4)) ? new Vector4(_other.part)
																	  : _other.part);
						origin = ((is_instanceof(_other.origin, Vector2)) ? new Vector2(_other.origin)
																		  : _other.origin);
						target = _other.target;
						
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
						//|Construction type: New constructor.
						sprite = argument[0];
						location = ((argument_count > 1) ? argument[1] : undefined);
						frame = (((argument_count > 2) and (argument[2] != undefined)) ? argument[2]
																					   : 0);
						scale = (((argument_count > 3) and (argument[3] != undefined))
								 ? argument[3] : new Scale(1, 1));
						angle = (((argument_count > 4) and (argument[4] != undefined))
								 ? argument[4] : new Angle(0));
						color = (((argument_count > 5) and (argument[5] != undefined)) ? argument[5]
																					   : c_white);
						alpha = (((argument_count > 6) and (argument[6] != undefined)) ? argument[6]
																					   : 1);
						part = ((argument_count > 7) ? argument[7] : undefined);
						origin = ((argument_count > 8) ? argument[8] : undefined);
						target = ((argument_count > 9) ? argument[9] : undefined);
					}
				}
				
				return self;
			}
			
			/// @argument			skip_location? {bool}
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function(_skip_location = false)
			{
				return ((is_instanceof(sprite, Sprite)) and (sprite.isFunctional()) and
						((_skip_location) or ((is_instanceof(location, Vector2)) or
						 (is_instanceof(location, Vector4))) and (location.isFunctional())) and
						(is_real(frame)) and (is_instanceof(scale, Scale)) and
						(scale.isFunctional()) and (is_instanceof(angle, Angle)) and
						(angle.isFunctional()) and ((is_real(color)) or
						(is_instanceof(color, Color4))) and (is_real(alpha)) and
						((part == undefined) or ((is_instanceof(part, Vector4)) and
						 (part.isFunctional()))) and ((origin == undefined) or
						((is_instanceof(origin, Vector2)) and (origin.isFunctional()))) and
						((target == undefined) or ((is_real(target)) or
						 ((is_instanceof(target, Surface)) and (target.isFunctional())))));
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			other {SpriteRenderer}
			/// @returns			{bool}
			/// @description		Check if specified constructor has equivalent properties.
			static equals = function(_other)
			{
				return (((sprite == _other.sprite) or ((is_instanceof(_other.sprite, Sprite)) and
						(sprite.equals(_other.sprite))) and ((location == _other.location) or
						((string_copy(instanceof(location), 1, 6) == "Vector") and
						 (location.equals(_other.location)))) and (frame == _other.frame) and
						((scale == _other.scale) or ((is_instanceof(scale, Scale) and
						 (scale.equals(_other.scale))))) and ((angle == _other.angle) or
						((is_instanceof(angle, Angle) and (angle.equals(_other.angle))))) and
						((color == _other.color) or
						 ((string_copy(instanceof(fill_color), 1, 5) == "Color") and
						 (color.equals(_other.color)))) and (alpha == _other.alpha) and
						((part == _other.part) or ((is_instanceof(part, Vector4) and
						 (part.equals(_other.part))))) and ((origin == _other.origin) or
						 ((is_instanceof(origin, Vector2) and (origin.equals(_other.origin))))) and
						((target == _other.target) or ((is_instanceof(target, Surface) and
						 (target.equals(_other.target)))))));
			}
			
			/// @argument			sprite? {Sprite}
			/// @argument			location? {Vector2|Vector4}
			/// @argument			scale? {Scale}
			/// @argument			angle? {Angle}
			/// @argument			color? {int:color|Color4}
			/// @argument			part? {Vector4}
			/// @argument			origin? {Vector2}
			/// @returns			{real[+]}
			/// @description		Return an array containing nested arrays with point locations
			///						of every vertex of the render of the data of this constructor or
			///						its temporarily replaced parts.
			static getVertexLocation = function(_sprite = sprite, _location = location,
												_scale = scale, _angle = angle, _part = part,
												_origin = origin)
			{
				var _result = [];
				
				try
				{
					var _size_x = sprite_get_width(_sprite.ID);
					var _size_y = sprite_get_height(_sprite.ID);
					var _scale_x = _scale.x;
					var _scale_y = _scale.y;
					var _trim = _sprite.getTextureTrim(0);
					var _nineslice = sprite_get_nineslice(_sprite.ID);
					var _location_x, _location_y, _origin_x, _origin_y;
					var _part_x1 = 0;
					var _part_y1 = 0;
					var _part_x2 = _size_x;
					var _part_y2 = _size_y;
					
					if (_origin != undefined)
					{
						_origin_x = _origin.x;
						_origin_y = _origin.y;
					}
					else
					{
						_origin_x = sprite_get_xoffset(_sprite.ID);
						_origin_y = sprite_get_yoffset(_sprite.ID);
					}
					
					if ((is_instanceof(location, Vector4)))
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
					
					if ((part != undefined) and (!_nineslice.enabled))
					{
						_part_x1 = _part.x1;
						_part_y1 = _part.y1;
						_part_x2 = _part.x2;
						_part_y2 = _part.y2;
					}
					
					_part_x1 = clamp(_part_x1, 0, _size_x);
					_part_y1 = clamp(_part_y1, 0, _size_y);
					_part_x2 = clamp((_part_x2 + _trim.x2), 0, (_size_x - _part_x1));
					_part_y2 = clamp((_part_y2 + _trim.y2), 0, (_size_y - _part_y1));
					
					var _part_whitespace_x1 = max(0, (_trim.x1 - _part_x1));
					var _part_whitespace_y1 = max(0, (_trim.y1 - _part_y1));
					var _size_x_part = (_size_x - (_size_x - _part_x2) - _trim.x1 - _trim.x2 +
										(_trim.x1 - _part_whitespace_x1));
					var _size_y_part = (_size_y - (_size_y - _part_y2) - _trim.y1 - _trim.y2 +
										(_trim.y1 - _part_whitespace_y1));
					var _size_x_part_scaled = (_size_x_part * _scale_x);
					var _size_y_part_scaled = (_size_y_part * _scale_y);
					var _origin_transformed_x = (_part_x1 - lerp(_part_x1, (_part_x1 + _size_x),
																 ((_origin_x * _scale_x) / _size_x)) +
												 (_part_whitespace_x1 * _scale_x));
					var _origin_transformed_y = (_part_y1 - lerp(_part_y1, (_part_y1 + _size_y),
																 ((_origin_y * _scale_y) / _size_y)) +
												 (_part_whitespace_y1 * _scale_y));
					var _angle_dcos = dcos(_angle.value);
					var _angle_dsin = dsin(_angle.value);
					var _angle_rotated = (_angle.value - 90);
					
					var _location_topLeft = [(_location_x + (_origin_transformed_x * _angle_dcos) +
										  (_origin_transformed_y * _angle_dsin)),
										  (_location_y - (_origin_transformed_x * _angle_dsin) +
										  (_origin_transformed_y * _angle_dcos))];
					var _location_topRight = [_location_topLeft[0] + lengthdir_x(_size_x_part_scaled,
																				 _angle.value),
											  _location_topLeft[1] + lengthdir_y(_size_x_part_scaled,
																				 _angle.value)];
					var _location_bottomLeft = [_location_topLeft[0] +
												lengthdir_x(_size_y_part_scaled, _angle_rotated),
												_location_topLeft[1] +
												lengthdir_y(_size_y_part_scaled, _angle_rotated)];
					var _location_bottomRight = [_location_topRight[0] +
												 lengthdir_x(_size_y_part_scaled, _angle_rotated),
												 _location_topRight[1] +
												 lengthdir_y(_size_y_part_scaled, _angle_rotated)];
					
					if (_nineslice.enabled)
					{
						//|Basic nineslice support.
						// Only supports "Stretch" Tile Mode and does not support scale-reliant origin
						// point rotation.
						var _center_x = (_size_x_part_scaled * 0.5);
						var _center_y = (_size_y_part_scaled * 0.5);
						var _nineslice_center =
						[
							(_location_topLeft[0] + lengthdir_x(_center_x, _angle.value) +
							 lengthdir_x((_size_y_part_scaled * 0.5), _angle_rotated)),
							(_location_topLeft[1] + lengthdir_y(_center_y, _angle.value) +
							 lengthdir_y((_size_y_part_scaled * 0.5), _angle_rotated))
						];
						
						var _nineslice_left_x = lengthdir_x(_nineslice.left, _angle.value);
						var _nineslice_left_y = lengthdir_y(_nineslice.left, _angle.value);
						var _nineslice_right_x = lengthdir_x(_nineslice.right, _angle.value);
						var _nineslice_right_y = lengthdir_y(_nineslice.right, _angle.value);
						var _nineslice_top_x = lengthdir_x(_nineslice.top, _angle_rotated);
						var _nineslice_top_y = lengthdir_y(_nineslice.top, _angle_rotated);
						var _nineslice_bottom_x = lengthdir_x(_nineslice.bottom, _angle_rotated);
						var _nineslice_bottom_y = lengthdir_y(_nineslice.bottom, _angle_rotated);
						var _nineslice_left_center = [(_location_topLeft[0] + _nineslice_left_x +
													  lengthdir_x(_center_y, _angle_rotated)),
													  (_location_topLeft[1] + _nineslice_left_y +
													  lengthdir_y(_center_y, _angle_rotated))];
						var _nineslice_right_center = [(_location_topRight[0] - _nineslice_right_x +
													   lengthdir_x(_center_y, _angle_rotated)),
													   (_location_topRight[1] - _nineslice_right_y +
													   lengthdir_y(_center_y, _angle_rotated))];
						var _nineslice_top_center = [(_location_topLeft[0] + _nineslice_top_x +
													 lengthdir_x(_center_x, _angle.value)),
													 (_location_topLeft[1] + _nineslice_top_y +
													 lengthdir_y(_center_x, _angle.value))];
						var _nineslice_bottom_center = [(_location_bottomLeft[0] -
														_nineslice_bottom_x +
														lengthdir_x(_center_x, _angle.value)),
														(_location_bottomLeft[1] -
														_nineslice_bottom_y +
														lengthdir_y(_center_x, _angle.value))];
						var _nineslice_outer_topLeft_x =
						[
							_location_topLeft[0] + _nineslice_left_x,
							_location_topLeft[1] + _nineslice_left_y
						];
						
						var _nineslice_outer_topLeft_y =
						[
							_location_topLeft[0] + _nineslice_top_x,
							_location_topLeft[1] + _nineslice_top_y
						];
						
						var _nineslice_outer_topRight_x =
						[
							_location_topRight[0] - _nineslice_right_x,
							_location_topRight[1] - _nineslice_right_y
						];
						
						var _nineslice_outer_topRight_y =
						[
							_location_topRight[0] + _nineslice_top_x,
							_location_topRight[1] + _nineslice_top_y
						];
						
						var _nineslice_outer_bottomLeft_x =
						[
							_location_bottomLeft[0] + _nineslice_left_x,
							_location_bottomLeft[1] + _nineslice_left_y
						];
						
						var _nineslice_outer_bottomLeft_y =
						[
							_location_bottomLeft[0] - _nineslice_bottom_x,
							_location_bottomLeft[1] - _nineslice_bottom_y
						];
						
						var _nineslice_outer_bottomRight_x =
						[
							_location_bottomRight[0] - _nineslice_right_x,
							_location_bottomRight[1] - _nineslice_right_y
						];
						
						var _nineslice_outer_bottomRight_y =
						[
							_location_bottomRight[0] - _nineslice_bottom_x,
							_location_bottomRight[1] - _nineslice_bottom_y
						];
						
						var _nineslice_inner_topLeft =
						[
							(_nineslice_outer_topLeft_x[0] + _nineslice_top_x),
							(_nineslice_outer_topLeft_x[1] + _nineslice_top_y),
						];
						var _nineslice_inner_topRight =
						[
							(_location_topRight[0] - _nineslice_right_x + _nineslice_top_x),
							(_location_topRight[1] - _nineslice_right_y + _nineslice_top_y)
						];
						
						var _nineslice_inner_bottomLeft =
						[
							(_location_bottomLeft[0] + _nineslice_left_x - _nineslice_bottom_x),
							(_location_bottomLeft[1] + _nineslice_left_y - _nineslice_bottom_y)
						];
						
						var _nineslice_inner_bottomRight =
						[
							(_location_bottomRight[0] - _nineslice_right_x - _nineslice_bottom_x),
							(_location_bottomRight[1] - _nineslice_right_y - _nineslice_bottom_y)
						];
						
						return
						[
							_nineslice_outer_topLeft_x, _nineslice_inner_topLeft, _location_topLeft,
							_location_topLeft, _nineslice_inner_topLeft, _nineslice_outer_topLeft_y,
								
							_nineslice_outer_topRight_x, _nineslice_inner_topRight,
							_nineslice_outer_topLeft_x, _nineslice_outer_topLeft_x,
							_nineslice_inner_topRight, _nineslice_inner_topLeft,
								
							_location_topRight, _nineslice_outer_topRight_y,
							_nineslice_outer_topRight_x, _nineslice_outer_topRight_x,
							_nineslice_outer_topRight_y, _nineslice_inner_topRight,
								
							_nineslice_inner_topLeft, _nineslice_inner_bottomLeft,
							_nineslice_outer_topLeft_y, _nineslice_outer_topLeft_y, 
							_nineslice_inner_bottomLeft, _nineslice_outer_bottomLeft_y,
							
							_nineslice_inner_bottomLeft, _nineslice_outer_bottomLeft_y,
							_nineslice_outer_bottomLeft_x, _nineslice_outer_bottomLeft_x,
							_nineslice_outer_bottomLeft_y, _location_bottomLeft,
							
							_nineslice_inner_bottomRight, _nineslice_outer_bottomRight_x,
							_nineslice_inner_bottomLeft, _nineslice_inner_bottomLeft, 
							_nineslice_outer_bottomRight_x, _nineslice_outer_bottomLeft_x,
								
							_nineslice_outer_bottomRight_x, _location_bottomRight,
							_nineslice_inner_bottomRight, _nineslice_inner_bottomRight,
							_location_bottomRight, _nineslice_outer_bottomRight_y,
							
							_nineslice_outer_topRight_y, _nineslice_outer_bottomRight_y,
							_nineslice_inner_topRight, _nineslice_inner_topRight,
							_nineslice_outer_bottomRight_y, _nineslice_inner_bottomRight,
							
							_nineslice_inner_topRight, _nineslice_right_center, _nineslice_top_center,
							_nineslice_top_center, _nineslice_right_center, _nineslice_center,
							
							_nineslice_right_center, _nineslice_inner_bottomRight,
							_nineslice_center, _nineslice_center, _nineslice_inner_bottomRight,
							_nineslice_bottom_center,
							
							_nineslice_top_center, _nineslice_center, _nineslice_inner_topLeft,
							_nineslice_inner_topLeft, _nineslice_center, _nineslice_left_center,
							
							_nineslice_center, _nineslice_bottom_center, _nineslice_left_center,
							_nineslice_left_center, _nineslice_bottom_center,
							_nineslice_inner_bottomLeft
						];
					}
					else
					{
						return [_location_topRight, _location_bottomRight, _location_topLeft,
								_location_topLeft, _location_bottomRight, _location_bottomLeft];
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getVertexLocation()"], _exception);
				}
				
				return _result;
			}
			
			/// @argument			sprite? {Sprite}
			/// @argument			frame? {int}
			/// @argument			part? {Vector4}
			/// @returns			{any[+]}
			/// @description		Return the texture pointer and UV coordinates for every vertex of
			///						the render of the data of this constructor or its specified
			///						temporarily replaced parts.
			static getUV = function(_sprite = sprite, _frame = frame, _part = part)
			{
				
				var _size_x = sprite_get_width(_sprite.ID);
				var _size_y = sprite_get_height(_sprite.ID);
				var _trim = _sprite.getTextureTrim(_frame);
				var _part_x1 = 0;
				var _part_y1 = 0;
				var _part_x2 = _size_x;
				var _part_y2 = _size_y;
				var _nineslice = sprite_get_nineslice(_sprite.ID);
				
				if ((_part != undefined) and (!_nineslice.enabled))
				{
					_part_x1 = _part.x1;
					_part_y1 = _part.y1;
					_part_x2 = _part.x2;
					_part_y2 = _part.y2;
				}
				
				var _part_trimmed_x1 = clamp((_part_x1 - _trim.x1), 0, _size_x);
				var _part_trimmed_y1 = clamp((_part_y1 - _trim.y1), 0, _size_y);
				var _part_trimmed_x2 = clamp(((_size_x - _part_x2) - (_size_x - (_size_x -
											 _trim.x2)) - _part_x1), 0, _size_x);
				var _part_trimmed_y2 = clamp(((_size_y - _part_y2) - (_size_y - (_size_y -
											 _trim.y2)) - _part_y1), 0, _size_y);
				var _texture = sprite_get_texture(_sprite.ID, _frame);
				var _texel_x = texture_get_texel_width(_texture);
				var _texel_y = texture_get_texel_height(_texture);
				var _uv = texture_get_uvs(_texture);
				var _uv_x1 = (_uv[0] + (_part_trimmed_x1 * _texel_x));
				var _uv_y1 = (_uv[1] + (_part_trimmed_y1 * _texel_y));
				var _uv_x2 = (_uv[2] - (_part_trimmed_x2 * _texel_x));
				var _uv_y2 = (_uv[3] - (_part_trimmed_y2 * _texel_y));
				
				var _uv_topLeft = [_uv_x1, _uv_y1];
				var _uv_topRight = [_uv_x2, _uv_y1];
				var _uv_bottomLeft = [_uv_x1, _uv_y2];
				var _uv_bottomRight = [_uv_x2, _uv_y2];
				
				if (_nineslice.enabled)
				{
					var _nineslice_center_percentage =
					[
						((mean(_nineslice.left, (_size_x - _nineslice.right))) / _size_x),
						((mean(_nineslice.top, (_size_y - _nineslice.bottom))) / _size_y),
					];
					
					var _nineslice_center = [lerp(_uv_x1, _uv_x2, _nineslice_center_percentage[0]),
											 lerp(_uv_y1, _uv_y2, _nineslice_center_percentage[1])];
					var _nineslice_outer_topLeft_x = [(_uv_x1 + (_nineslice.left * _texel_x)),
													  _uv_y1];
					var _nineslice_outer_topLeft_y = [_uv_x1, (_uv_y1 + (_nineslice.top * _texel_y))];
					var _nineslice_inner_topLeft = [_nineslice_outer_topLeft_x[0],
													_nineslice_outer_topLeft_y[1]];
					var _nineslice_outer_topRight_x = [(_uv_x2 - (_nineslice.right * _texel_x)),
													   _uv_y1];
					var _nineslice_outer_topRight_y = [_uv_x2,
													   (_uv_y1 + (_nineslice.top * _texel_y))];
					var _nineslice_inner_topRight = [_nineslice_outer_topRight_x[0],
													 _nineslice_outer_topRight_y[1]];
					var _nineslice_outer_bottomLeft_x = [(_uv_x1 + (_nineslice.left * _texel_x)),
														 _uv_y2];
					var _nineslice_outer_bottomLeft_y = [_uv_x1,
														 (_uv_y2 - (_nineslice.bottom * _texel_y))];
					var _nineslice_inner_bottomLeft = [_nineslice_outer_bottomLeft_x[0],
													   _nineslice_outer_bottomLeft_y[1]];
					var _nineslice_outer_bottomRight_x = [(_uv_x2 - (_nineslice.right * _texel_x)),
														  _uv_y2];
					var _nineslice_outer_bottomRight_y = [_uv_x2,
														  (_uv_y2 - (_nineslice.bottom * _texel_y))];
					var _nineslice_inner_bottomRight = [_nineslice_outer_bottomRight_x[0],
														_nineslice_outer_bottomRight_y[1]];
					var _nineslice_left_center = [_nineslice_inner_topLeft[0],
												  _nineslice_center[1]];
					var _nineslice_right_center = [_nineslice_inner_topRight[0],
												   _nineslice_center[1]];
					var _nineslice_top_center = [_nineslice_center[0], _nineslice_inner_topRight[1]];
					var _nineslice_bottom_center = [_nineslice_center[0],
													_nineslice_inner_bottomRight[1]];
					
					return
					[
						_texture,
						[
							_nineslice_outer_topLeft_x, _nineslice_inner_topLeft, _uv_topLeft,
							_uv_topLeft, _nineslice_inner_topLeft, _nineslice_outer_topLeft_y,
							
							_nineslice_outer_topRight_x, _nineslice_inner_topRight,
							_nineslice_outer_topLeft_x,  _nineslice_outer_topLeft_x,
							_nineslice_inner_topRight, _nineslice_inner_topLeft,
							
							_uv_topRight, _nineslice_outer_topRight_y, _nineslice_outer_topRight_x,
							_nineslice_outer_topRight_x, _nineslice_outer_topRight_y,
							_nineslice_inner_topRight,
							
							_nineslice_inner_topLeft, _nineslice_inner_bottomLeft,
							_nineslice_outer_topLeft_y, _nineslice_outer_topLeft_y, 
							_nineslice_inner_bottomLeft, _nineslice_outer_bottomLeft_y,
							
							_nineslice_inner_bottomLeft, _nineslice_outer_bottomLeft_y,
							_nineslice_outer_bottomLeft_x, _nineslice_outer_bottomLeft_x,
							_nineslice_outer_bottomLeft_y, _uv_bottomLeft,
							
							_nineslice_inner_bottomRight, _nineslice_outer_bottomRight_x,
							_nineslice_inner_bottomLeft, _nineslice_inner_bottomLeft, 
							_nineslice_outer_bottomRight_x, _nineslice_outer_bottomLeft_x,
							
							_nineslice_outer_bottomRight_x, _uv_bottomRight,
							_nineslice_inner_bottomRight, _nineslice_inner_bottomRight,
							_uv_bottomRight, _nineslice_outer_bottomRight_y,
							
							_nineslice_outer_topRight_y, _nineslice_outer_bottomRight_y,
							_nineslice_inner_topRight, _nineslice_inner_topRight,
							_nineslice_outer_bottomRight_y, _nineslice_inner_bottomRight,
							
							_nineslice_inner_topRight, _nineslice_right_center,
							_nineslice_top_center, _nineslice_top_center,
							_nineslice_right_center, _nineslice_center,
							
							_nineslice_right_center, _nineslice_inner_bottomRight,
							_nineslice_center, _nineslice_center, _nineslice_inner_bottomRight,
							_nineslice_bottom_center,
							
							_nineslice_top_center, _nineslice_center, _nineslice_inner_topLeft,
							_nineslice_inner_topLeft, _nineslice_center, _nineslice_left_center,
							
							_nineslice_center, _nineslice_bottom_center, _nineslice_left_center,
							_nineslice_left_center, _nineslice_bottom_center,
							_nineslice_inner_bottomLeft
						]
					];
				}
				else
				{
					return [_texture, [_uv_topRight, _uv_bottomRight, _uv_topLeft, _uv_topLeft,
									   _uv_bottomRight, _uv_bottomLeft]];
				}
			}
			
			/// @argument			sprite? {Sprite}
			/// @argument			location? {Vector2|Vector4}
			/// @argument			frame? {int}
			/// @argument			scale? {Scale}
			/// @argument			angle? {Angle}
			/// @argument			color? {int:color|Color4}
			/// @argument			part? {Vector4}
			/// @argument			origin? {Vector2}
			/// @returns			{any[+]}
			/// @description		Return an array containg rendering data for each vertex rendered
			///						by this constructor, consisting of its primitive type, location,
			///						color and alpha value, based on the data of this constructor or
			///						its specified replaced parts.
			static getPrimitiveRenderData = function(_sprite = sprite, _location = location,
													 _frame = frame, _scale = scale, _angle = angle, 
													 _color = color, _part = part, _origin = origin)
			{
				var _vertex_location = self.getVertexLocation(_sprite, _location, _scale, _angle,
															  _part, _origin);
				var _vertex_uv = self.getUV(_sprite, _frame, _part);
				var _color_topLeft = _color;
				var _color_topRight = _color;
				var _color_bottomLeft = _color;
				var _color_bottomRight = _color;
				
				if (is_instanceof(_color, Color4))
				{
					_color_topLeft = _color.color1;
					_color_topRight = _color.color2;
					_color_bottomRight = _color.color3;
					_color_bottomLeft = _color.color4;
				}
				
				var _vertex_color = (((sprite_get_nineslice(_sprite.ID).enabled))
									 ? array_create(array_length(_vertex_location), _color_topLeft)
									 : [_color_topRight, _color_bottomRight, _color_topLeft,
										_color_topLeft, _color_bottomRight, _color_bottomLeft]);
				
				return event.getPrimitiveRenderData.execute(undefined,
															[[pr_trianglelist, _vertex_location,
															  _vertex_uv, _vertex_color]]);
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			sprite? {Sprite}
			/// @argument			location? {Vector2|Vector4}
			/// @argument			frame? {int}
			/// @argument			scale? {Scale}
			/// @argument			angle? {Angle}
			/// @argument			color? {int:color|Color4}
			/// @argument			alpha? {real}
			/// @argument			part? {Vector4}
			/// @argument			origin? {Vector2}
			/// @argument			target? {Surface|handle:surface}
			/// @description		Execute the draw, using data of this constructor or its specified
			///						temporarily replaced parts.
			static render = function(_sprite = sprite, _location = location, _frame = frame,
									 _scale = scale, _angle = angle, _color = color, _alpha = alpha,
									 _part = part, _origin = origin, _target = target)
			{
				var _sprite_original = sprite;
				var _location_original = location;
				var _frame_original = frame;
				var _scale_original = scale;
				var _angle_original = angle;
				var _color_original = color;
				var _alpha_original = alpha;
				var _part_original = part;
				var _origin_original = origin;
				var _target_original = target;
				
				sprite = _sprite;
				location = _location;
				frame = _frame;
				scale = _scale;
				angle = _angle;
				color = _color;
				alpha = _alpha;
				part = _part;
				origin = _origin;
				target = _target;
				
				if (self.isFunctional())
				{
					event.beforeRender.execute();
					sprite.render(location, frame, scale, angle, color, alpha, part, origin, target);
					event.afterRender.execute();
				}
				else
				{
					new ErrorReport().report([other, self, "render()"],
											 ("Attempted to render through an invalid Sprite " +
											  "renderer: " +
											  "{" + string(self) + "}"));
				}
				
				sprite = _sprite_original;
				location = _location_original;
				frame = _frame_original;
				scale = _scale_original;
				angle = _angle_original;
				color = _color_original;
				alpha = _alpha_original;
				part = _part_original;
				origin = _origin_original;
				target = _target_original;
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @argument			full? {bool}
			/// @argument			colorHSV? {bool}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented with the properties of this
			///						constructor.
			static toString = function(_multiline = false, _full = false, _colorHSV = false)
			{
				var _string = "";
				var _mark_separator = ((_multiline) ? "\n" : ", ");
				
				if (_full)
				{
					var _mark_separator_inline = ", ";
					var _string_color;
					
					if (is_instanceof(color, Color4))
					{
						_string_color = string(color);
					}
					else
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
									 "Red: " + string(color_get_red(color))
									 		 + _mark_separator_inline +
									 "Green: " + string(color_get_green(color))
									 		   + _mark_separator_inline +
									 "Blue: " + string(color_get_blue(color)) +
									 ")");
								}
							break;
						}
					}
					
					_string = ("Sprite: " + string(sprite) + _mark_separator +
							   "Location: " + string(location) + _mark_separator +
							   "Frame: " + string(frame) + _mark_separator +
							   "Scale: " + string(scale) + _mark_separator +
							   "Angle: " + string(angle) + _mark_separator +
							   "Color: " + _string_color + _mark_separator +
							   "Alpha: " + string(alpha) + _mark_separator +
							   "Part: " + string(part) + _mark_separator +
							   "Origin: " + string(origin) + _mark_separator +
							   "Target: " + string(target));
				}
				else
				{
					_string = ("Sprite: " + string(sprite) + _mark_separator +
							   "Location: " + string(location));
				}
				
				return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
			}
			
			/// @returns			{real[+]}
			/// @description		Return an array containing the values of all properties of this
			///						Renderer. If any of properties contain multiple values, they
			///						be returned in a nested array.
			static toArray = function()
			{
				var _sprite = ((is_instanceof(sprite, Sprite)) ? sprite.ID : sprite);
				
				var _location = location;
				switch (instanceof(location))
				{
					case "Vector2":
					case "Vector4":
						_location = location.toArray();
					break;
				}
				
				var _scale = ((is_instanceof(scale, Scale)) ? scale.toArray() : scale);
				var _angle = ((is_instanceof(angle, Angle)) ? angle.value : angle);
				var _color = ((is_instanceof(color, Color4)) ? color.toArray() : color);
				var _part = ((is_instanceof(part, Vector4)) ? part.toArray() : part);
				var _origin = ((is_instanceof(origin, Vector2)) ? origin.toArray() : origin);
				var _target = ((is_instanceof(target, Surface)) ? target.ID : target);
				
				return [_sprite, _location, frame, _scale, _angle, _color, alpha, _part,
						_origin, _target];
			}
			
			/// @argument			sprite? {Sprite}
			/// @argument			location? {Vector2|Vector4}
			/// @argument			frame? {int}
			/// @argument			scale? {Scale}
			/// @argument			angle? {Angle}
			/// @argument			color? {int:color|Color4}
			/// @argument			alpha? {real}
			/// @argument			part? {Vector4}
			/// @argument			origin? {Vector2}
			/// @argument			vertexBuffer? {VertexBuffer}
			/// @returns			{VertexBuffer.PrimitiveRenderData} | On error: {undefined}
			/// @description		Return rendering data of this constructor in a Vertex Buffer,
			///						using its current data or specified temporarily replaced parts.
			static toVertexBuffer = function(_sprite = sprite, _location = location, _frame = frame,
											 _scale = scale, _angle = angle, _color = color,
											 _alpha = alpha, _part = part, _origin = origin,
											 _vertexBuffer)
			{
				var _vertexBuffer_created = false;
				var _renderData = undefined;
				var _sprite_original = sprite;
				var _location_original = location;
				var _frame_original = frame;
				var _scale_original = scale;
				var _angle_original = angle;
				var _color_original = color;
				var _alpha_original = alpha;
				var _part_original = part;
				var _origin_original = origin;
				
				sprite = _sprite;
				location = _location;
				frame = _frame;
				scale = _scale;
				angle = _angle;
				color = _color;
				alpha = ((_alpha > 0) ? _alpha : 0);
				part = _part;
				origin = _origin;
				
				try
				{
					var _primitive = self.getPrimitiveRenderData();
					var _vertex_location = _primitive[1];
					var _texture_data = _primitive[2];
					var _vertex_color = _primitive[3];
					var _texture = _texture_data[0];
					var _vertex_uv = _texture_data[1];
					var _vertex = new Vector2();
					var _vertexBuffer_wasActive = false;
					
					if (is_instanceof(_vertexBuffer, VertexBuffer))
					{
						_vertexBuffer_wasActive = _vertexBuffer.active;
					}
					else
					{
						_vertexBuffer = new VertexBuffer();
						_vertexBuffer_created = true;
					}
					
					_renderData = _vertexBuffer.createPrimitiveRenderData(_primitive[0], undefined,
																		  _texture);
					_vertexBuffer.setActive(_renderData.passthroughFormat);
					
					if (!_vertexBuffer_wasActive)
					{
						_vertexBuffer.setActive(_renderData.vertexFormat);
					}
					
					var _i = 0;
					repeat (array_length(_vertex_location))
					{
						var _vertex_uv_current = _vertex_uv[_i];
						
						_vertexBuffer
						 .setLocation2D(_vertex.setAll(_vertex_location[_i]))
						 .setColor(_vertex_color[_i], alpha)
						 .setUV(_vertex_uv_current[0], _vertex_uv_current[1]);
						
						++_i;
					}
					
					if (!_vertexBuffer_wasActive)
					{
						_vertexBuffer.setActive(false);
					}
				}
				catch (_exception)
				{
					if (_vertexBuffer_created)
					{
						_vertexBuffer.destroy();
					}
					
					new ErrorReport().report([other, self, "toVertexBuffer()"], _exception);
				}
				
				sprite = _sprite_original;
				location = _location_original;
				frame = _frame_original;
				scale = _scale_original;
				angle = _angle_original;
				color = _color_original;
				alpha = _alpha_original;
				part = _part_original;
				origin = _origin_original;
				
				return _renderData;
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static constructor = SpriteRenderer;
		
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
		
		var _argument = array_create(argument_count, undefined);
		var _i = 0;
		repeat (argument_count)
		{
			_argument[_i] = argument[_i];
			
			++_i;
		}
		
		script_execute_ext(self.construct, _argument);
		
	#endregion
}
