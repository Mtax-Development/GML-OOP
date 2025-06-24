//  @function				Plane()
/// @argument				location {Vector3}
/// @argument				scale {Scale}
/// @argument				angle? {EulerAngle}
/// @argument				sprite? {Sprite|SpriteRenderer}
/// @argument				color? {int:color}
/// @argument				alpha? {real}
/// @description			Constructs a three-dimensional representation of a two-dimensional Plane
///							Shape. Its location is its center, from which it is scaled.
//							
//							Construction types:
//							- New constructor
//							- Empty: {void}
//							- Constructor copy: other {Plane}
function Plane() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				location = undefined;
				scale = undefined;
				angle = undefined;
				sprite = undefined;
				color = undefined;
				alpha = undefined;
				
				var _scope = self;
				event =
				{
					beforeRender: new Callback(undefined, [], _scope),
					afterRender: new Callback(undefined, [], _scope)
				};
				
				if (argument_count > 0)
				{
					if (is_instanceof(argument[0], Plane))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						location = ((is_instanceof(_other.location, Vector3))
									? new Vector3(_other.location) : _other.location);
						scale = ((is_instanceof(_other.scale, Scale)) ? new Scale(_other.scale)
																	  : _other.scale);
						angle = ((is_instanceof(_other.angle, EulerAngle))
								 ? new EulerAngle(_other.angle) : _other.angle);
						sprite = ((is_instanceof(_other.sprite, Sprite))
								  ? new Sprite(_other.sprite)
								  : ((is_instanceof(_other.sprite, SpriteRenderer))
									 ? new SpriteRenderer(_other.sprite)
									 : _other.sprite));
						color = _other.color;
						alpha = _other.alpha;
						
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
						location = argument[0];
						scale = argument[1];
						angle = ((argument_count > 2) ? argument[2] : new EulerAngle(0, 0, 0));
						sprite = ((argument_count > 3) ? argument[3] : undefined);
						color = (((argument_count > 4) and (argument[4] != undefined)) ? argument[4]
																					   : c_white);
						alpha = (((argument_count > 5) and (argument[5] != undefined)) ? argument[5]
																					   : 1);
					}
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return (((is_instanceof(location, Vector3)) and (location.isFunctional())) and
						((is_instanceof(scale, Scale)) and (scale.isFunctional())) and
						((angle == undefined) or ((is_instanceof(angle, EulerAngle)) and
						 (angle.isFunctional()))) and ((sprite == undefined) or
						(((is_instanceof(sprite, Sprite)) or
						 (is_instanceof(sprite, SpriteRenderer))) and (sprite.isFunctional(true)))) and
						((is_real(color)) or ((is_instanceof(color, Color4)) and
						 (color.isFunctional()))) and (is_real(alpha)));
			}
			
		#endregion
		#region <Getters>
			
			/// @returns			{real[]:matrix}
			/// @description		Return current transformation matrix of this Shape.
			static getTransform = function()
			{
				var _transform = matrix_multiply(matrix_build(0, 0, 0, (-angle.y), 0, 0, 1, 1, 1),
												 matrix_build(0, 0, 0, 0, (-angle.x), 0, 1, 1, 1));
				_transform = matrix_multiply(_transform,
											 matrix_build(0, 0, 0, 0, 0, (-angle.z), 1, 1, 1));
				_transform = matrix_multiply(_transform,
											 matrix_build(location.x, location.y, (-location.z), 0, 0,
														  0, 1, 1, 1));
				
				return _transform;
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			location? {Vector2|Vector4}
			/// @argument			scale? {Scale}
			/// @argument			angle? {Angle}
			/// @argument			sprite? {Sprite|SpriteRenderer}
			/// @argument			color? {int:color|Color4}
			/// @argument			alpha? {real}
			/// @description		Execute the draw, using data of this constructor or its specified
			///						temporarily replaced parts.
			static render = function(_location, _scale, _angle, _sprite, _color, _alpha)
			{
				var _matrix_original = matrix_get(matrix_world);
				var _location_original = location;
				var _scale_original = scale;
				var _angle_original = angle;
				var _sprite_original = sprite;
				var _color_original = color;
				var _alpha_original = alpha;
				
				sprite = (_sprite ?? sprite);
				location = (_location ?? location);
				scale = (_scale ?? scale);
				angle = (_angle ?? angle);
				color = (_color ?? color);
				alpha = (_alpha ?? alpha);
				
				try
				{
					if (self.isFunctional())
					{
						event.beforeRender.execute();
						
						matrix_set(matrix_world, matrix_multiply(_matrix_original,
																 self.getTransform()));
						
						if (is_instanceof(sprite, Sprite))
						{
							var _scale_sprite = new Scale(((scale.x * 2) /
														   sprite_get_width(sprite.ID)),
														  ((scale.y * 2) /
														   sprite_get_height(sprite.ID)));
							
							sprite.render(new Vector2(((-_scale.x) * 0.5), ((-_scale.y) * 0.5)), 0,
										  _scale_sprite, undefined, color, alpha);
						}
						else if (is_instanceof(sprite, SpriteRenderer))
						{
							var _offset = ((is_instanceof(sprite.location, Vector2))
										   ? sprite.location : new Vector2(0, 0));
							var _sprite_size_x = sprite_get_width(sprite.sprite.ID);
							var _sprite_size_y = sprite_get_height(sprite.sprite.ID);
							var _scale_sprite = new Scale((sprite.scale.x * ((scale.x * 2) /
														   _sprite_size_x)),
														  (sprite.scale.y * ((scale.y * 2) /
														   _sprite_size_y)));
							var _origin = new Vector2((_sprite_size_x * 0.5), (_sprite_size_y * 0.5))
							
							sprite.render(undefined, _offset, undefined, _scale_sprite, undefined,
										  undefined, undefined, undefined, _origin);
						}
						else
						{
							static _pixel = function()
							{
								var _surface = surface_create(1, 1);
								surface_set_target(_surface);
								{
									draw_clear(c_white);
								}
								surface_reset_target();
								
								var _sprite = sprite_create_from_surface(_surface, 0, 0, 1, 1, false,
																		 false, 0, 0);
								surface_free(_surface);
								
								return _sprite;
							}();
							
							var _color1, _color2, _color3, _color4;
								
							if (is_instanceof(color, Color4))
							{
								_color1 = color.color1;
								_color2 = color.color2;
								_color3 = color.color3;
								_color4 = color.color4;
							}
							else
							{
								_color1 = color;
								_color2 = color;
								_color3 = color;
								_color4 = color;
							}
							
							draw_sprite_general(_pixel, 0, 0, 0, 1, 1, (-scale.x), (-scale.y),
												(scale.x * 2), (scale.y * 2), 0, _color1, _color2,
												_color3, _color4, alpha);
						}
						
						event.afterRender.execute();
					}
					else
					{
						new ErrorReport().report([other, self, "render()"],
												 ("Attempted to render an invalid Shape: " +
												  "{" + string(self) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "render()"], _exception);
				}
				finally
				{
					matrix_set(matrix_world, _matrix_original);
					sprite = _sprite_original;
					location = _location_original;
					scale = _scale_original;
					angle = _angle_original;
					color = _color_original;
					alpha = _alpha_original;
				}
				
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
			///						Content will be represented with the properties of this Shape.
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
					var _string_color = string(color);
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
					
					_string = ("Location: " + string(location) + _mark_separator +
							   "Scale: " + string(scale) + _mark_separator +
							   "Angle: " + string(angle) + _mark_separator +
							   "Color: " + _string_color + _mark_separator +
							   "Alpha: " + string(alpha));
				}
				
				return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
			}
			
			/// @argument			location? {Vector3}
			/// @argument			scale? {Scale}
			/// @argument			angle? {EulerAngle}
			/// @argument			sprite? {Sprite|SpriteRenderer}
			/// @argument			color? {int:color}
			/// @argument			alpha? {real}
			/// @argument			stretchCroppedTexture? {bool}
			/// @returns			{VertexBuffer.PrimitiveRenderData[]}
			/// @description		Return rendering data of this constructor in Vertex Buffers, using
			///						its current data or specified temporarily replaced parts.
			///						If using a Sprite with texture group setting set to crop fully
			///						transparent pixels around edges of the image, resulting Shape
			///						will be made smaller to remove that transparency, unless specified
			///						to stretch the image without transparency to full Shape size.
			static toVertexBuffer = function(_location = location, _scale = scale, _angle = angle,
											 _sprite = sprite, _color = color, _alpha = alpha,
											 _stretchCroppedTexture = false)
			{
				var _vertexBuffer = undefined;
				var _renderData = undefined;
				
				try
				{
					var _offset = [[(-1), (-1)], [1, (-1)], [(-1), 1], [1, 1]];
					var _offset_count = array_length(_offset);
					var _angle_x = 0;
					var _angle_y = 0;
					var _angle_z = 0;
					
					if (is_instanceof(_angle, EulerAngle))
					{
						_angle_x = _angle.x;
						_angle_y = _angle.y;
						_angle_z = _angle.z;
					}
					
					var _texture = undefined;
					var _uv_order = undefined;
					var _frame = 0;
					var _offset_spriteRenderer_x = 0;
					var _offset_spriteRenderer_y = 0;
					var _offset_trim_x = 0;
					var _offset_trim_y = 0;
					var _scale_uv_x = _scale.x;
					var _scale_uv_y = _scale.y;
					var _sprite_size_scale_x = 1;
					var _sprite_size_scale_y = 1;
					
					if (is_instanceof(_sprite, SpriteRenderer))
					{
						if (is_instanceof(_sprite.location, Vector2))
						{
							_offset_spriteRenderer_x = _sprite.location.x;
							_offset_spriteRenderer_y = _sprite.location.y;
						}
						
						_frame = _sprite.frame;
						_color = _sprite.color;
						_alpha = _sprite.alpha;
						
						if (is_instanceof(_sprite.scale, Scale))
						{
							_scale = new Scale((_sprite.scale.x * _scale.x),
											   (_sprite.scale.y * _scale.y));
						}
						
						_sprite = _sprite.sprite;
					}
					
					if (is_instanceof(_sprite, Sprite))
					{
						_texture = sprite_get_texture(_sprite.ID, _frame);
						var _texelSize_x = texture_get_texel_width(_texture);
						var _texelSize_y = texture_get_texel_height(_texture);
						var _sprite_size_x = sprite_get_width(_sprite.ID);
						var _sprite_size_y = sprite_get_height(_sprite.ID);
						var _uv = texture_get_uvs(_texture);
						_uv_order = [[_uv[0], _uv[1]], [_uv[0], _uv[3]], [_uv[2], _uv[1]],
									 [_uv[2], _uv[3]]];
						
						if (!_stretchCroppedTexture)
						{
							var _trim = _sprite.getTextureTrim(_frame);
							_sprite_size_scale_x = (_scale.x / _sprite_size_x);
							_sprite_size_scale_y = (_scale.y / _sprite_size_y);
							_scale_uv_x = (_scale.x * _uv[6]);
							_scale_uv_y = (_scale.y * _uv[7]);
							_offset_trim_x = ((_trim.x1 - _trim.x2) * _sprite_size_scale_x);
							_offset_trim_y = ((_trim.y1 - _trim.y2) * _sprite_size_scale_y);
						}
					}
					else
					{
						_uv_order = array_create(_offset_count, [0, 0]);
					}
					
					var _vertex = new Vector3();
					var _normal = new Vector3(0, 1, 0);
					var _matrix_rotation = matrix_build(0, 0, 0, _angle_x, _angle_y, _angle_z, 1, 1,
														1);
					_vertexBuffer = new VertexBuffer();
					_renderData = _vertexBuffer.createPrimitiveRenderData(pr_trianglestrip,
																		  vertex_position_3d,
																		  _texture);
					
					_vertexBuffer.setActive(_renderData.vertexFormat);
					{
						var _i = 0;
						repeat (_offset_count)
						{
							var _offset_current = _offset[_i];
							var _uv_order_current = _uv_order[_i];
							var _transform = matrix_transform_vertex
							(
								_matrix_rotation,
								((_scale_uv_y * _offset_current[0]) + _offset_trim_y +
								 _offset_spriteRenderer_y),
								((_scale_uv_x * _offset_current[1]) + _offset_trim_x +
								 _offset_spriteRenderer_x), 0
							);
							
							_vertexBuffer
							 .setLocation3D(_vertex.set((_location.x + _transform[1]),
														(_location.y + _transform[0]),
														((-_location.z) + _transform[2])))
							 .setNormal(_normal)
							 .setUV(_uv_order_current[0], _uv_order_current[1])
							 .setColor(_color, _alpha);
							
							++_i;
						}
					}
					_vertexBuffer.setActive(false);
				}
				catch (_exception)
				{
					if (_vertexBuffer != undefined)
					{
						_vertexBuffer.destroy();
					}
					
					new ErrorReport().report([other, self, "toVertexBuffer()"], _exception);
				}
				
				return _renderData;
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static constructor = Plane;
		
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