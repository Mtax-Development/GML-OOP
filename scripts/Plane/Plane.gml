//  @function				Plane()
/// @argument				location {Vector3}
/// @argument				scale {Scale}
/// @argument				angle? {EulerAngle}
/// @argument				sprite? {Sprite}
/// @argument				color? {int:color}
/// @argument				alpha? {real}
/// @description			Constructs a three-dimensional representation of a two-dimensional Plane
///							shape. Its location is the center of the shape, from which it is scaled.
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
						((is_instanceof(scale, Vector3)) and (scale.isFunctional()))
						and (is_real(color)) and (is_real(alpha)));
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
			/// @returns			{VertexBuffer.PrimitiveRenderData[]}
			/// @description		Return rendering data of this constructor in Vertex Buffers, using
			///						its current data or specified temporarily replaced parts.
			///						Rendering data for six faces will be returned in an array.
			static toVertexBuffer = function(_location = location, _scale = scale, _angle = angle,
											 _sprite = sprite, _color = color, _alpha = alpha)
			{
				var _vertexBuffer = undefined;
				var _renderData = undefined;
				
				try
				{
					var _offset = [[-1, -1], [1, -1], [-1, 1], [1, 1]];
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
					
					if (is_instanceof(_sprite, Sprite))
					{
						_texture = sprite_get_texture(_sprite.ID, 0);
						var _texelSize_x = texture_get_texel_width(_texture);
						var _texelSize_y = texture_get_texel_height(_texture);
						var _sprite_size_x = sprite_get_width(_sprite.ID);
						var _sprite_size_y = sprite_get_height(_sprite.ID);
						var _uv = texture_get_uvs(_texture);
						_uv_order = [[_uv[0], _uv[1]], [_uv[0], _uv[3]], [_uv[2], _uv[1]],
									 [_uv[2], _uv[3]]];
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
					_renderData = _vertexBuffer.createPrimitiveRenderData(pr_trianglestrip, undefined,
																		  _texture);
					_vertexBuffer.setActive(_renderData.vertexFormat3D);
					{
						var _i = 0;
						repeat (_offset_count)
						{
							var _offset_current = _offset[_i];
							var _uv_order_current = _uv_order[_i];
							var _transform = matrix_transform_vertex(_matrix_rotation,
																	 (_scale.x * _offset_current[0]),
																	 (_scale.y * _offset_current[1]),
																	 0);
							
							_vertexBuffer
							 .setLocation3D(_vertex.set((_location.x + _transform[1]),
														(_location.y + _transform[0]),
														(_location.z + _transform[2])))
							 .setNormal(_normal)
							 .setUV(_uv_order_current[0], _uv_order_current[1])
							 .setColor(_color, _alpha);
							
							++_i;
						}
					}
					_vertexBuffer.setActive(false);
					
					return _renderData;
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