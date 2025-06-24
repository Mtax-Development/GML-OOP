//  @function				Cube()
/// @argument				location {Vector3}
/// @argument				scale {Vector3}
/// @argument				angle? {EulerAngle}
/// @argument				sprite? {Sprite}
/// @argument				color? {int:color}
/// @argument				alpha? {real}
/// @description			Constructs a three-dimensional Cube Shape, bound by six rectangular faces.
///							Its location is its center, from which it is scaled.
//							
//							Construction types:
//							- New constructor
//							- Empty: {void}
//							- Constructor copy: other {Cube}
function Cube() constructor
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
				
				if (argument_count > 0)
				{
					if (is_instanceof(argument[0], Cube))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						location = ((is_instanceof(_other.location, Vector3))
									? new Vector3(_other.location) : _other.location);
						scale = ((is_instanceof(_other.scale, Vector3)) ? new Vector3(_other.scale)
																		: _other.scale);
						angle = ((is_instanceof(_other.angle, EulerAngle))
								 ? new EulerAngle(_other.angle) : _other.angle);
						sprite = ((is_instanceof(_other.sprite, Vector3)) ? new Vector3(_other.scale)
																		  : _other.scale);
						color = _other.color;
						alpha = _other.alpha;
					}
					else
					{
						//|Construction type: New constructor.
						location = argument[0];
						scale = argument[1];
						angle = ((argument_count > 2) ? argument[2] : undefined);
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
						((is_instanceof(scale, Vector3)) and (scale.isFunctional())) and
						(is_real(color)) and (is_real(alpha)));
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
			/// @argument			scale? {Vector3}
			/// @argument			angle? {EulerAngle}
			/// @argument			sprite? {Sprite}
			/// @argument			color? {int:color}
			/// @argument			alpha? {real}
			/// @argument			vertexBuffer? {VertexBuffer}
			/// @argument			excludedFace? {int|int[]}
			/// @returns			{VertexBuffer.PrimitiveRenderData[]}
			/// @description		Return rendering data of this constructor in Vertex Buffers, using
			///						its current data or specified temporarily replaced parts. A single
			///						Vertex Buffer can be specified instead to place rendering data in
			///						it, instead of creating several new ones. If specified while being
			///						currently active, it will not be deactivated after this operation.
			///						Rendering data for six faces will be returned in an array, except
			///						for faces that were excluded by specifying their numbers, starting
			///						from 1 in following order: Top, Bottom, Left, Front, Right, Back.
			static toVertexBuffer = function(_location = location, _scale = scale, _angle = angle,
											 _sprite = sprite, _color = color, _alpha = alpha,
											 _vertexBuffer, _excludedFace = [])
			{
				var _result = [];
				var _vertexBuffer_face = undefined;
				var _renderData = undefined;
				var _side =
				[
					//|Top (Normal Y-):
					[[(-1), (-1), 1], [(-1), (-1), (-1)], [1, (-1), 1], [1, (-1), 1],
					 [(-1), (-1), (-1)], [1, (-1), (-1)]],
					 //|Bottom (Normal Y+):
					[[(-1), 1, (-1)], [(-1), 1, 1], [1, 1, (-1)], [1, 1, (-1)], [(-1), 1, 1],
					 [1, 1, 1]],
					//|Left (Normal X-):
					[[(-1), 1, (-1)], [(-1), (-1), (-1)], [(-1), 1, 1], [(-1), 1, 1],
					 [(-1), (-1), (-1)], [(-1), (-1), 1]],
					 //|Front (Normal Z+):
					[[1, 1, 1], [1, (-1), 1], [(-1), 1, 1], [(-1), 1, 1], [1, (-1), 1],
					 [(-1), (-1), 1]],
					//|Right (Normal X+):
					[[1, 1, 1], [1, (-1), 1], [1, 1, (-1)], [1, 1, (-1)], [1, (-1), 1],
					 [1, (-1), (-1)]],
					//|Back (Normal Z-):
					[[(-1), 1, (-1)], [(-1), (-1), (-1)], [1, 1, (-1)], [1, 1, (-1)],
					 [(-1), (-1), (-1)], [1, (-1), (-1)]]
				];
				var _side_count = array_length(_side);
				var _side_normal = [[0, 0, 1], [1, 0, 0], [0, 0, (-1)], [(-1), 0, 0], [0, 1, 0],
									[0, (-1), 0]];
				var _side_front = _side[3];
				
				try
				{
					var _vertexBuffer_wasActive = false;
					
					if (_vertexBuffer != undefined)
					{
						_vertexBuffer_wasActive = _vertexBuffer.active;
					}
					
					if (!is_array(_excludedFace))
					{
						_excludedFace = [_excludedFace];
					}
					
					var _angle_x = 0;
					var _angle_y = 0;
					var _angle_z = 0;
					
					if (is_instanceof(_angle, EulerAngle))
					{
						_angle_x = (-_angle.y);
						_angle_y = (-_angle.x);
						_angle_z = (-_angle.z);
					}
					
					var _sprite_frame_data = array_create(_side_count, [undefined, 0, 0, 0, 0]);
					
					if (is_instanceof(_sprite, Sprite))
					{
						var _sprite_frame_count = sprite_get_number(_sprite.ID);
						var _sprite_size_x = sprite_get_width(_sprite.ID);
						var _sprite_size_y = sprite_get_height(_sprite.ID);
						
						var _sprite_image_order = undefined;
						switch (_sprite_frame_count)
						{
							case 1:
								//|Image order: All sides.
								_sprite_image_order = [1, 1, 1, 1, 1, 1];
							break;
							case 2:
								//|Image order: Top and bottom, All sides.
								_sprite_image_order = [1, 1, 2, 2, 2, 2];
							break;
							case 3:
								//|Image order: Top, Bottom, All sides.
								_sprite_image_order = [1, 2, 3, 3, 3, 3];
							break;
							case 4:
								//|Image order: Top, Bottom, Left and right, Front and back.
								_sprite_image_order = [1, 2, 3, 4, 3, 4];
							break;
							case 5:
								//|Image order: Top and bottom, Left, Front, Right, Back.
								_sprite_image_order = [1, 1, 2, 3, 4, 5];
							break;
							case 6:
								//|Image order: Top, Bottom, Left, Front, Right, Back.
								_sprite_image_order = [1, 2, 3, 4, 5, 6];
							break;
						}
						
						var _i = 0;
						repeat (array_length(_sprite_image_order))
						{
							var _texture = sprite_get_texture(_sprite.ID,
															  (_sprite_image_order[_i] - 1));
							var _uv = texture_get_uvs(_texture);
							
							_sprite_frame_data[_i] = [_texture, _uv[0], _uv[1], _uv[2], _uv[3]];
							
							++_i;
						}
					}
					
					var _vertex = new Vector3();
					var _normal = new Vector3();
					var _matrix_rotation = matrix_build(0, 0, 0, _angle_x, _angle_y, _angle_z, 1, 1,
														1);
					var _i = [0, 0];
					repeat (_side_count)
					{
						if (!array_contains(_excludedFace, (_i[0] + 1)))
						{
							var _side_current = _side[_i[0]];
							var _side_normal_current = _side_normal[(_i[0] div 6)];
							_normal.set(_side_normal_current[0], _side_normal_current[1],
									 	_side_normal_current[2]);
							var _sprite_frame_data_current = _sprite_frame_data[_i[0]];
							var _uv_topFlipMultiplier = _side_current[0][1];
							
							_vertexBuffer_face = (_vertexBuffer ?? new VertexBuffer());
							_renderData = _vertexBuffer_face
							 .createPrimitiveRenderData(pr_trianglelist, vertex_position_3d,
														_sprite_frame_data_current[0]);
							
							if (!_vertexBuffer_wasActive)
							{
								_vertexBuffer_face.setActive(_renderData.vertexFormat);
							}
							
							_i[1] = 0;
							repeat (array_length(_side_current))
							{
								var _side_vertexOffset_current = _side_current[_i[1]];
								var _uv_order = _side_front[_i[1]];
								var _transform = matrix_transform_vertex
								(
									_matrix_rotation, (_scale.x * _side_vertexOffset_current[0]),
									(_scale.y * _side_vertexOffset_current[1]), ((_scale.z *
									_side_vertexOffset_current[2]))
								);
								
								_vertexBuffer_face
								 .setLocation3D(_vertex.set((_location.x + _transform[0]),
															(_location.y + _transform[1]),
															((-_location.z) + _transform[2])))
								 .setNormal(_normal)
								 .setUV(((_uv_order[0] == (-_uv_topFlipMultiplier))
										 ? _sprite_frame_data_current[1]
										 : _sprite_frame_data_current[3]),
								 		((_uv_order[1] == (-_uv_topFlipMultiplier))
										 ? _sprite_frame_data_current[2]
										 : _sprite_frame_data_current[4]))
								 .setColor(_color, _alpha);
								
								++_i[1];
							}
							
							if (!_vertexBuffer_wasActive)
							{
								_vertexBuffer_face.setActive(false);
							}
							
							array_push(_result, _renderData);
						}
						
						++_i[0];
					}
					
					if ((_vertexBuffer != undefined) and (!_vertexBuffer_wasActive))
					{
						_vertexBuffer_face.setActive(false);
					}
				}
				catch (_exception)
				{
					if ((_vertexBuffer == undefined) and (array_length(_result) == 0)
					and (_vertexBuffer_face != undefined))
					{
						_vertexBuffer_face.destroy();
					}
					
					new ErrorReport().report([other, self, "toVertexBuffer()"], _exception);
				}
				
				return _result;
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static constructor = Cube;
		
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