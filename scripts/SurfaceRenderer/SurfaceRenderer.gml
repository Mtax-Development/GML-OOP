//  @function				SurfaceRenderer()
/// @argument				surface? {Surface}
/// @argument				location? {Vector2|Vector4}
/// @argument				scale? {Scale}
/// @argument				angle? {Angle}
/// @argument				color? {int:color|Color4}
/// @argument				alpha? {real}
/// @argument				part? {Vector4}
/// @argument				origin? {Vector2}
/// @argument				target? {Surface|int:surface}
/// @description			Constructs a handler storing information for Surface rendering.
//							
//							Construction types:
//							- New constructor
//							- Empty: {void}
//							- Constructor copy: other {SurfaceRenderer}
function SurfaceRenderer() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				surface = undefined;
				location = undefined;
				scale = undefined;
				angle = undefined;
				color = undefined;
				alpha = undefined;
				part = undefined;
				origin = undefined;
				target = undefined;
				
				event =
				{
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
				
				if (argument_count > 0)
				{
					if (is_instanceof(argument[0], SurfaceRenderer))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						surface = ((is_instanceof(_other.surface, Surface))
								   ? new Surface(_other.surface) : _other.surface);
						
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
							event = {};
							
							var _eventList = variable_struct_get_names(_other.event);
							var _i = [0, 0];
							repeat (array_length(_eventList))
							{
								var _event = {};
								var _other_event = variable_struct_get(_other.event,
																	   _eventList[_i[0]]);
								var _eventPropertyList = variable_struct_get_names(_other_event);
								
								_i[1] = 0;
								repeat (array_length(_eventPropertyList))
								{
									var _property = variable_struct_get(_other_event,
																		_eventPropertyList[_i[1]]);
									var _value = _property;
									
									if (is_array(_property))
									{
										_value = [];
										
										array_copy(_value, 0, _property, 0, array_length(_property));
									}
									
									variable_struct_set(_event, _eventPropertyList[_i[1]], _value);
									
									++_i[1];
								}
								
								variable_struct_set(event, _eventList[_i[0]], _event);
								
								++_i[0];
							}
						}
						else
						{
							event = _other.event;
						}
					}
					else
					{
						//|Construction type: New constructor.
						surface = argument[0];
						location = ((argument_count > 1) ? argument[1] : undefined);
						scale = (((argument_count > 2) and (argument[2] != undefined))
								 ? argument[2] : new Scale(1, 1));
						angle = (((argument_count > 3) and (argument[3] != undefined))
								 ? argument[3] : new Angle(0));
						color = (((argument_count > 4) and (argument[4] != undefined)) ? argument[4]
																					   : c_white);
						alpha = (((argument_count > 5) and (argument[5] != undefined)) ? argument[5]
																					   : 1);
						part = ((argument_count > 6) ? argument[6] : undefined);
						origin = ((argument_count > 7) ? argument[7] : undefined);
						target = ((argument_count > 8) ? argument[8] : undefined);
					}
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_instanceof(surface, Surface)) and (surface.isFunctional())
						and ((is_instanceof(location, Vector2))
						or (is_instanceof(location, Vector4))) and (location.isFunctional())
						and (is_instanceof(scale, Scale)) and (scale.isFunctional())
						and (is_instanceof(angle, Angle)) and (angle.isFunctional())
						and ((is_real(color)) or (is_instanceof(color, Color4))) and (is_real(alpha))
						and ((part == undefined) or ((is_instanceof(part, Vector4))
						and (part.isFunctional()))) and ((origin == undefined)
						or ((is_instanceof(origin, Vector2)) and (origin.isFunctional())))
						and ((target == undefined) or ((is_real(target))
						or ((is_instanceof(target, Surface)) and (target.isFunctional())))));
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			surface? {Surface}
			/// @argument			location? {Vector2|Vector4}
			/// @argument			scale? {Scale}
			/// @argument			angle? {Angle}
			/// @argument			color? {int:color|Color4}
			/// @argument			alpha? {real}
			/// @argument			part? {Vector4}
			/// @argument			origin? {Vector2}
			/// @argument			target? {Surface|int:surface}
			/// @description		Execute the draw, using data of this constructor or specified
			///						replaced parts of it for this call only.
			static render = function(_surface, _location, _scale, _angle, _color, _alpha,
									 _part, _origin, _target)
			{
				var _surface_original = surface;
				var _location_original = location;
				var _scale_original = scale;
				var _angle_original = angle;
				var _color_original = color;
				var _alpha_original = alpha;
				var _part_original = part;
				var _origin_original = origin;
				var _target_original = target;
				
				surface = (_surface ?? surface);
				location = (_location ?? location);
				scale = (_scale ?? scale);
				angle = (_angle ?? angle);
				color = (_color ?? color);
				alpha = (_alpha ?? alpha);
				part = (_part ?? part);
				origin = (_origin ?? origin);
				target = (_target ?? target);
				
				if (self.isFunctional())
				{
					if ((is_struct(event)) and (event.beforeRender.callback != undefined))
					{
						var _callback_isArray = is_array(event.beforeRender.callback);
						var _argument_isArray = is_array(event.beforeRender.argument);
						var _callback = ((_callback_isArray)
										 ? event.beforeRender.callback
										 : [event.beforeRender.callback]);
						var _callback_count = array_length(_callback);
						var _argument = ((_argument_isArray)
										 ? event.beforeRender.argument
										 : array_create(_callback_count,
														event.beforeRender.argument));
						var _i = 0;
						repeat (_callback_count)
						{
							var _callback_index = ((is_method(_callback[_i]))
												   ? method_get_index(_callback[_i]) : _callback[_i]);
							
							try
							{
								script_execute_ext(_callback_index,
												   (((!_callback_isArray) and (_argument_isArray))
													? _argument : ((is_array(_argument[_i])
																   ? _argument[_i]
																   : [_argument[_i]]))));
							}
							catch (_exception)
							{
								new ErrorReport().report([other, self, "render()", "event",
														  "beforeRender"], _exception);
							}
							
							++_i;
						}
					}
					
					surface.render(location, scale, angle, color, alpha, part, origin, target);
					
					if ((is_struct(event)) and (event.afterRender.callback != undefined))
					{
						var _callback_isArray = is_array(event.afterRender.callback);
						var _argument_isArray = is_array(event.afterRender.argument);
						var _callback = ((_callback_isArray)
										 ? event.afterRender.callback
										 : [event.afterRender.callback]);
						var _callback_count = array_length(_callback);
						var _argument = ((_argument_isArray)
										 ? event.afterRender.argument
										 : array_create(_callback_count,
														event.afterRender.argument));
						var _i = 0;
						repeat (_callback_count)
						{
							var _callback_index = ((is_method(_callback[_i]))
												   ? method_get_index(_callback[_i]) : _callback[_i]);
							
							try
							{
								script_execute_ext(_callback_index,
												   (((!_callback_isArray) and (_argument_isArray))
													? _argument : ((is_array(_argument[_i])
																   ? _argument[_i]
																   : [_argument[_i]]))));
							}
							catch (_exception)
							{
								new ErrorReport().report([other, self, "render()", "event",
														  "afterRender"], _exception);
							}
							
							++_i;
						}
					}
				}
				else
				{
					new ErrorReport().report([other, self, "render()"],
											 ("Attempted to render through an invalid Surface " +
											  "renderer: " +
											  "{" + string(self) + "}"));
				}
				
				surface = _surface_original;
				location = _location_original;
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
					
					_string = ("Surface: " + string(surface) + _mark_separator +
							   "Location: " + string(location) + _mark_separator +
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
					_string = ("Surface: " + string(surface) + _mark_separator +
							   "Location: " + string(location));
				}
				
				return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
			}
			
			/// @argument			surface? {Surface}
			/// @argument			location? {Vector2|Vector4}
			/// @argument			scale? {Scale}
			/// @argument			angle? {Angle}
			/// @argument			color? {int:color|Color4}
			/// @argument			alpha? {real}
			/// @argument			part? {Vector4}
			/// @argument			origin? {Vector2}
			/// @returns			{VertexBuffer.PrimitiveRenderData} | On error: {undefined}
			/// @description		Return data formatted for rendering this constructor through a
			///						Vertex Buffer and the default passthrough Shader, using the data
			///						of this constructor or specified replaced parts of it for this
			///						call only.
			static toVertexBuffer = function(_surface, _location, _scale, _angle, _color, _alpha,
											 _part, _origin)
			{
				var _vertexBuffer = undefined;
				var _renderData = undefined;
				var _surface_original = surface;
				var _location_original = location;
				var _scale_original = scale;
				var _angle_original = angle;
				var _color_original = color;
				var _alpha_original = alpha;
				var _part_original = part;
				var _origin_original = origin;
				
				surface = (_surface ?? surface);
				location = (_location ?? location);
				scale = (_scale ?? scale);
				angle = (_angle ?? angle);
				color = (_color ?? color);
				alpha = (_alpha ?? ((alpha > 0) ? alpha : 0));
				part = (_part ?? part);
				origin = (_origin ?? origin);
				
				try
				{
					var _size_x = surface_get_width(surface.ID);
					var _size_y = surface_get_height(surface.ID);
					var _scale_x = scale.x;
					var _scale_y = scale.y;
					
					var _origin_x = 0;
					var _origin_y = 0;
					
					if (origin != undefined)
					{
						_origin_x = origin.x;
						_origin_y = origin.y;
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
					var _texture = surface_get_texture(surface.ID);
					var _texelSize_x = texture_get_texel_width(_texture);
					var _texelSize_y = texture_get_texel_height(_texture);
					var _uv = texture_get_uvs(_texture);
					var _uv_x1 = (_uv[0] + (_part_x1 * _texelSize_x));
					var _uv_y1 = (_uv[1] + (_part_y1 * _texelSize_y));
					var _uv_x2 = (_uv_x1 + (_size_x_part * _texelSize_x));
					var _uv_y2 = (_uv_y1 + (_size_y_part * _texelSize_y));
					var _vertexBuffer = new VertexBuffer();
					var _renderData = _vertexBuffer.createPrimitiveRenderData(pr_trianglestrip,
																			  undefined, _texture);
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
				
				surface = _surface_original;
				location = _location_original;
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
		
		static constructor = SurfaceRenderer;
		
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
