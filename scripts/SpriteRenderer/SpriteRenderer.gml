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
/// @argument				target? {Surface|int:surface}
/// @description			Constructs a handler storing information for Sprite rendering.
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
				
				event =
				{
					beforeRender: new Callback(undefined, [], other),
					afterRender: new Callback(undefined, [], other)
				};
				
				if (argument_count > 0)
				{
					if (is_instanceof(argument[0], SpriteRenderer))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						sprite = ((is_instanceof(_other.sprite, Sprite))
								  ? new Sprite(_other.sprite.ID) : _other.sprite);
						
						switch (instanceof(_other.location))
						{
							case "Vector2":
								location = new Vector2(_other.location);
							break;
							case "Vector4":
								location = new Vector4(_other.location);
							break;
							default:
								location = _other.location;
							break;
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
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_instanceof(sprite, Sprite)) and (sprite.isFunctional())
						and ((is_instanceof(location, Vector2))
						or (is_instanceof(location, Vector4))) and (location.isFunctional())
						and (is_real(frame)) and (is_instanceof(scale, Scale))
						and (scale.isFunctional()) and (is_instanceof(angle, Angle))
						and (angle.isFunctional()) and ((is_real(color))
						or (is_instanceof(color, Color4))) and (is_real(alpha))
						and ((part == undefined) or ((is_instanceof(part, Vector4))
						and (part.isFunctional()))) and ((origin == undefined)
						or ((is_instanceof(origin, Vector2)) and (origin.isFunctional())))
						and ((target == undefined) or ((is_real(target))
						or ((is_instanceof(target, Surface)) and (target.isFunctional())))));
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			other {SpriteRenderer}
			/// @returns			{bool}
			/// @description		Check if specified constructor has equivalent properties.
			static equals = function(_other)
			{
				return (((sprite == _other.sprite) or ((is_instanceof(_other.sprite, Sprite))
						and (sprite.equals(_other.sprite))) and ((location == _other.location)
						or ((string_copy(instanceof(location), 1, 6) == "Vector")
						and (location.equals(_other.location)))) and (frame == _other.frame)
						and ((scale == _other.scale) or ((is_instanceof(scale, Scale)
						and (scale.equals(_other.scale))))) and ((angle == _other.angle)
						or ((is_instanceof(angle, Angle) and (angle.equals(_other.angle)))))
						and ((color == _other.color)
						or ((string_copy(instanceof(fill_color), 1, 5) == "Color")
						and (color.equals(_other.color)))) and (alpha == _other.alpha)
						and ((part == _other.part) or ((is_instanceof(part, Vector4)
						and (part.equals(_other.part))))) and ((origin == _other.origin)
						or ((is_instanceof(origin, Vector2) and (origin.equals(_other.origin)))))
						and ((target == _other.target) or ((is_instanceof(target, Surface)
						and (target.equals(_other.target)))))));
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
			/// @argument			target? {Surface|int:surface}
			/// @description		Execute the draw, using data of this constructor or its specified
			///						temporarily replaced parts.
			static render = function(_sprite, _location, _frame, _scale, _angle, _color, _alpha,
									 _part, _origin, _target)
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
				
				sprite = (_sprite ?? sprite);
				location = (_location ?? location);
				frame = (_frame ?? frame);
				scale = (_scale ?? scale);
				angle = (_angle ?? angle);
				color = (_color ?? color);
				alpha = (_alpha ?? alpha);
				part = (_part ?? part);
				origin = (_origin ?? origin);
				target = (_target ?? target);
				
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
			/// @returns			{VertexBuffer.PrimitiveRenderData} | On error: {undefined}
			/// @description		Return rendering data of this constructor in a Vertex Buffer, using
			///						its current data or its specified temporarily replaced parts.
			static toVertexBuffer = function(_sprite, _location, _frame, _scale, _angle, _color,
											 _alpha, _part, _origin)
			{
				var _vertexBuffer = undefined;
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
				
				sprite = (_sprite ?? sprite);
				location = (_location ?? location);
				frame = (_frame ?? frame);
				scale = (_scale ?? scale);
				angle = (_angle ?? angle);
				color = (_color ?? color);
				alpha = (_alpha ?? ((alpha > 0) ? alpha : 0));
				part = (_part ?? part);
				origin = (_origin ?? origin);
				
				try
				{
					var _size_x = sprite_get_width(sprite.ID);
					var _size_y = sprite_get_height(sprite.ID);
					var _scale_x = scale.x;
					var _scale_y = scale.y;
					
					var _origin_x, _origin_y;
					
					if (origin != undefined)
					{
						_origin_x = origin.x;
						_origin_y = origin.y;
					}
					else
					{
						_origin_x = sprite_get_xoffset(sprite.ID);
						_origin_y = sprite_get_yoffset(sprite.ID);
					}
					
					var _location_x, _location_y;
					
					if ((is_instanceof(location, Vector4)))
					{
						_scale_x = (((location.x2 - location.x1) / _size_x) * _scale_x);
						_scale_y = (((location.y2 - location.y1) / _size_y) * _scale_y);
						_location_x = location.x1 + (_origin_x * _scale_x);
						_location_y = location.y1 + (_origin_y * _scale_y);
					}
					else
					{
						_location_x = location.x;
						_location_y = location.y;
					}
					
					var _color_x1y1, _color_x2y1, _color_x2y2, _color_x1y2;
					
					if (is_real(color))
					{
						_color_x1y1 = color;
						_color_x2y1 = color;
						_color_x2y2 = color;
						_color_x1y2 = color;
					}
					else
					{
						_color_x1y1 = color.color1;
						_color_x2y1 = color.color2;
						_color_x2y2 = color.color3;
						_color_x1y2 = color.color4;
					}
					
					var _part_x1, _part_y1, _part_x2, _part_y2;
					
					if (part != undefined)
					{
						_part_x1 = clamp(part.x1, 0, _size_x);
						_part_y1 = clamp(part.y1, 0, _size_y);
						_part_x2 = clamp(part.x2, 0, (_size_x - _part_x1));
						_part_y2 = clamp(part.y2, 0, (_size_y - _part_y1));
					}
					else
					{
						_part_x1 = 0;
						_part_y1 = 0;
						_part_x2 = _size_x;
						_part_y2 = _size_y;
					}
					
					var _size_x_part = (_size_x - (_size_x - _part_x2));
					var _size_y_part = (_size_y - (_size_y - _part_y2));
					var _size_x_part_scaled = (_size_x_part * _scale_x);
					var _size_y_part_scaled = (_size_y_part * _scale_y);
					
					var _origin_transformed_x = (_part_x1 - lerp(_part_x1, (_part_x1 + _part_x2),
																 ((_origin_x * _scale_x) / _size_x)));
					var _origin_transformed_y = (_part_y1 - lerp(_part_y1, (_part_y1 + _part_y2),
																 ((_origin_y * _scale_y) / _size_y)));
					
					var _angle_dcos = dcos(angle.value);
					var _angle_dsin = dsin(angle.value);
					var _angle_rotated = (angle.value - 90);
					var _location_x1y1 = [(_location_x + (_origin_transformed_x * _angle_dcos) +
										  (_origin_transformed_y * _angle_dsin)),
										  (_location_y - (_origin_transformed_x * _angle_dsin) +
										  (_origin_transformed_y * _angle_dcos))];
					var _location_x2y1 = [_location_x1y1[0] + lengthdir_x(_size_x_part_scaled,
																		  angle.value),
										  _location_x1y1[1] + lengthdir_y(_size_x_part_scaled,
																		  angle.value)];
					var _location_x2y2 = [_location_x2y1[0] + lengthdir_x(_size_y_part_scaled,
																		  _angle_rotated),
										  _location_x2y1[1] + lengthdir_y(_size_y_part_scaled,
																		  _angle_rotated)];
					var _location_x1y2 = [_location_x2y2[0] - lengthdir_x(_size_x_part_scaled,
																		  angle.value),
										  _location_x2y2[1] - lengthdir_y(_size_x_part_scaled,
																		  angle.value)];
					
					var _vertex = new Vector2();
					var _texture = sprite_get_texture(sprite.ID, frame);
					var _texelSize_x = texture_get_texel_width(_texture);
					var _texelSize_y = texture_get_texel_height(_texture);
					var _uv = texture_get_uvs(_texture);
					var _uv_x1 = (_uv[0] + (_part_x1 * _texelSize_x));
					var _uv_y1 = (_uv[1] + (_part_y1 * _texelSize_y));
					var _uv_x2 = (_uv_x1 + (_size_x_part * _texelSize_x));
					var _uv_y2 = (_uv_y1 + (_size_y_part * _texelSize_y));
					_vertexBuffer = new VertexBuffer();
					_renderData = _vertexBuffer.createPrimitiveRenderData(pr_trianglestrip, undefined,
																		  _texture);
					_vertexBuffer
					 .setActive(_renderData.passthroughFormat)
						.setLocation(_vertex.set(_location_x2y1[0], _location_x2y1[1]))
						.setColor(_color_x2y1, alpha)
						.setUV(_uv_x2, _uv_y1)
						
						.setLocation(_vertex.set(_location_x2y2[0], _location_x2y2[1]))
						.setColor(_color_x2y2, alpha)
						.setUV(_uv_x2, _uv_y2)
						
						.setLocation(_vertex.set(_location_x1y1[0], _location_x1y1[1]))
						.setColor(_color_x1y1, alpha)
						.setUV(_uv_x1, _uv_y1)
						
						.setLocation(_vertex.set(_location_x1y2[0], _location_x1y2[1]))
						.setColor(_color_x1y2, alpha)
						.setUV(_uv_x1, _uv_y2)
					 .setActive(false);
				}
				catch (_exception)
				{
					if (_vertexBuffer != undefined)
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
