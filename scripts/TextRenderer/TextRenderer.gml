//  @function				TextRenderer()
/// @argument				string {any:string}
/// @argument				font {Font}
/// @argument				location {Vector2}
/// @argument				align? {TextAlign}
/// @argument				scale? {Scale|int}
/// @argument				angle? {Angle}
/// @argument				color? {int:color}
/// @argument				alpha? {real}
/// @description			Constructs a handler containing information for string rendering.
//							
//							Construction types:
//							- New constructor
//							- Empty: {void|undefined}
//							- Constructor copy: other {TextRenderer}
function TextRenderer() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				ID = "";
				font = undefined;
				location = undefined;
				align = undefined;
				scale = undefined;
				angle = undefined;
				color = undefined;
				alpha = undefined;
				
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
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (is_instanceof(argument[0], TextRenderer))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						ID = _other.ID;
						font = ((is_instanceof(_other.font, Font)) ? new Font(_other.font.ID)
																   : _other.font);
						location = ((is_instanceof(_other.location, Vector2))
									? new Vector2(_other.location) : _other.location);
						scale = ((is_instanceof(_other.scale, Scale)) ? new Scale(_other.scale)
																	  : _other.scale);
						angle = ((is_instanceof(_other.angle, Angle)) ? new Angle(_other.angle)
																	  : _other.angle);
						align = ((is_instanceof(_other.align, TextAlign)) ? new TextAlign(_other.align)
																		  : _other.align);
						color = _other.color;
						alpha = _other.alpha;
						
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
						//Construction type: New constructor.
						ID = string(argument[0]);
						font = ((argument_count > 1) ? argument[1] : undefined);
						location = ((argument_count > 2) ? argument[2] : undefined);
						align = (((argument_count > 3) and (argument[3] != undefined))
								 ? argument[3] : new TextAlign());
						scale = (((argument_count > 4) and (argument[4] != undefined))
								 ? argument[4] : new Scale(1, 1));
						angle = (((argument_count > 5) and (argument[5] != undefined))
								 ? argument[5] : new Angle(0));
						color = (((argument_count > 6) and (argument[6] != undefined))
								 ? argument[6] : c_white);
						alpha = (((argument_count > 7) and (argument[7] != undefined))
								 ? argument[7] : 1);
					}
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				//+TODO: Scale, Angle checks.
				return ((is_real(alpha)) and (is_instanceof(font, Font)) and (font.isFunctional())
						and (is_instanceof(location, Vector2)) and (location.isFunctional())
						and (is_instanceof(align, TextAlign)) and (align.isFunctional()));
			}
			
		#endregion
		#region <Getters>
			
			/// @returns			{Vector2} | On error: {undefined}
			/// @description		Return the number of pixels the text would occupy after rendering.
			static getPixelSize = function(_scale = scale)
			{
				var _font_original = draw_get_font();
				
				//+TODO: Document _scale argument.
				
				try
				{
					draw_set_font(font.ID);
					
					var _string = string(ID);
					var _scale_x = 1;
					var _scale_y = 1;
					
					if (is_instanceof(_scale, Scale))
					{
						_scale_x = _scale.x;
						_scale_y = _scale.y;
					}
					else if (is_real(_scale))
					{
						var _font_point_size_multiplier = (round(_scale) / font_get_size(font.ID));
						_scale_x = _font_point_size_multiplier;
						_scale_y = _font_point_size_multiplier;
					}
					
					var _pixelSize_x = (string_width(_string) * _scale_x);
					var _pixelSize_y = (string_height(_string) * _scale_y);
					
					return new Vector2(_pixelSize_x, _pixelSize_y);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getPixelSize()"], _exception);
				}
				finally
				{
					draw_set_font(_font_original);
				}
				
				return undefined;
			}
			
			/// @returns			{Vector4} | On error: {undefined}
			/// @description		Return a boundry for the space the text occupies in pixels, offset
			///						from its origin.
			static getBoundaryOffset = function()
			{
				//+TODO: _scale argument support.
				var _font_original = draw_get_font();
				
				try
				{
					draw_set_font(font.ID);
					
					var _string = string(ID);
					var _x1 = undefined;
					var _y1 = undefined;
					var _x2 = undefined;
					var _y2 = undefined;
					var _size_x = string_width(_string);
					var _size_y = string_height(_string);
					
					switch (align.x)
					{
						case fa_left:
							_x1 = 0;
							_x2 = _size_x;
						break;
						
						case fa_center:
							var _size_x_half = (_size_x * 0.5);
							_x1 = (-_size_x_half);
							_x2 = _size_x_half;
						break;
						
						case fa_right:
							_x1 = (-_size_x);
							_x2 = 0;
						break;
					}
					
					switch (align.y)
					{
						case fa_top:
							_y1 = 0;
							_y2 = _size_y;
						break;
						
						case fa_middle:
							var _size_y_half = (_size_y * 0.5);
							_y1 = (-_size_y_half);
							_y2 = _size_y_half;
						break;
						
						case fa_bottom:
							_y1 = (-_size_y);
							_y2 = 0;
						break;
					}
					
					return new Vector4(_x1, _y1, _x2, _y2);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getBoundaryOffset()"], _exception);
				}
				finally
				{
					draw_set_font(_font_original);
				}
				
				return undefined;
			}
			
		#endregion
		#region <Setters>
			
			/// @argument			boundary {Vector2}
			/// @argument			mark_separator? {string}
			/// @argument			mark_cut? {string}
			/// @description		Attempt to fit the text into the specified boundary by adding line
			///						breaks between words split by the specified separator if they would
			///						exceed the boundary horizontally upon render. The text will be cut
			///						short if it would then exceed the vertical boundary.
			static wrapText = function(_boundary, _mark_separator = " ", _mark_cut = "...")
			{
				var _string_original = ID;
				
				try
				{
					var _parser = new StringParser(ID);
					
					if ((location.x + _parser.getPixelSize(font).x +
						 self.getBoundaryOffset().x1) > _boundary.x)
					{
						var _text_target = "";
						var _newLine = "\n";
						var _newLine_length = string_length(_newLine);
						var _word = _parser.split(_mark_separator);
						_parser.ID = "";
						
						if (!is_array(_word))
						{
							_word = [_word];
						}
						
						var _word_count = array_length(_word);
						var _i = 0;
						repeat (_word_count)
						{
							//|Add separator before the word unless it is the first one or previous
							// ended with a line break.
							var _word_target = (((_i > 0)
												and (!((string_count(_newLine, _word[(_i - 1)]) > 0)
												and (string_last_pos(_newLine, _word[_i - 1]) ==
												(string_length(_word[_i - 1]) - _newLine_length -
												 1)))))
												? (_mark_separator + _word[_i]) : _word[_i]);
							_parser.ID += _word_target;
							ID = _parser.ID;
							
							if ((location.x + _parser.getPixelSize(font).x +
								 self.getBoundaryOffset().x1) > _boundary.x)
							{
								_parser.ID = (_text_target + _newLine + _word[_i]);
								
								if ((location.y + _parser.getPixelSize(font).y +
									 self.getBoundaryOffset().y1) > _boundary.y)
								{
									ID = (_text_target + _mark_cut);
									
									return self;
								}
								else
								{
									_text_target += (_newLine + _word[_i]);
								}
							}
							else
							{
								if ((location.y + _parser.getPixelSize(font).y +
									 self.getBoundaryOffset().y1) > _boundary.y)
								{
									ID = (_text_target + _mark_cut);
									
									return self;
								}
								
								_text_target += _word_target;
							}
							
							_parser.ID = _text_target;
							
							++_i;
						}
					}
					
					ID = _parser.ID;
				}
				catch (_exception)
				{
					ID = _string_original;
					
					new ErrorReport().report([other, self, "wrapText()"], _exception);
				}
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			string? {any:string}
			/// @argument			font? {Font}
			/// @argument			location? {Vector2}
			/// @argument			align? {TextAlign}
			/// @argument			scale? {Scale|int}
			/// @argument			angle? {Angle}
			/// @argument			color? {int:color}
			/// @argument			alpha? {real}
			/// @description		Execute the draw of the text, using data of this constructor or
			///						specified replaced parts of it for this call only.
			static render = function(_string, _font, _location, _align, _scale, _angle, _color, _alpha)
			{
				var _string_original = ID;
				var _font_original = font;
				var _location_original = location;
				var _align_original = align;
				var _scale_original = scale;
				var _angle_original = angle;
				var _color_original = color;
				var _alpha_original = alpha;
				
				ID = (_string ?? ID);
				font = (_font ?? font);
				location = (_location ?? location);
				align = (_align ?? align);
				scale = (_scale ?? scale);
				angle = (_angle ?? angle);
				color = (_color ?? color);
				alpha = (_alpha ?? alpha);
				
				try
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
					
					if (alpha > 0)
					{
						draw_set_font(font.ID);
						draw_set_halign(align.x);
						draw_set_valign(align.y);
						
						var _location_x = round(location.x);
						var _location_y = round(location.y);
						var _scale_x = 1;
						var _scale_y = 1;
						var _angle_value = 0;
						
						if (is_instanceof(scale, Scale))
						{
							_scale_x = scale.x;
							_scale_y = scale.y;
						}
						else if (is_real(scale))
						{
							var _font_point_size_multiplier = (round(scale) / font_get_size(font.ID));
							_scale_x = _font_point_size_multiplier;
							_scale_y = _font_point_size_multiplier;
						}
						
						if (is_instanceof(angle, Angle))
						{
							_angle_value = angle.value;
						}
						
						if ((_scale_x != 1) or (_scale_y != 1) or (_angle_value != 0))
						{
							if (is_instanceof(color, Color4))
							{
								draw_text_transformed_color(_location_x, _location_y, string(ID),
															_scale_x, _scale_y, _angle_value,
															color.color1, color.color2, color.color3,
															color.color4, alpha);
							}
							else
							{
								draw_set_color(color);
								draw_set_alpha(alpha);
								draw_text_transformed(_location_x, _location_y, string(ID), _scale_x,
													  _scale_y, _angle_value);
							}
						}
						else
						{
							if (is_instanceof(color, Color4))
							{
								draw_text_color(_location_x, _location_y, string(ID), color.color1,
												color.color2, color.color3, color.color4, alpha);
							}
							else
							{
								draw_set_color(color);
								draw_set_alpha(alpha);
								draw_text(_location_x, _location_y, string(ID));
							}
						}
					}
					
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "render()"], _exception);
				}
				finally
				{
					ID = _string_original;
					font = _font_original;
					location = _location_original;
					align = _align_original;
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
			/// @argument			elementLength? {int|all}
			/// @argument			mark_separator? {string}
			/// @argument			mark_cut? {string}
			/// @argument			mark_linebreak? {string}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented with the text preview.
			static toString = function(_multiline = false, _full = false, _colorHSV = false,
									   _elementLength = 30, _mark_cut = "...", _mark_linebreak = ", ")
			{
				var _string = "";
				var _string_text = string(ID);
				var _mark_separator = ((_multiline) ? "\n" : ", ");
				var _mark_separator_inline = ", ";
				var _cutMark = "...";
				var _lengthLimit = 30;
				var _lengthLimit_cut = (_lengthLimit + string_length(_cutMark));
				
				if ((!_multiline) or (is_string(_mark_linebreak)))
				{
					if (!is_string(_mark_linebreak)) {_mark_linebreak = " "};
					
					_string_text = string_replace_all(_string_text, "\n", _mark_linebreak);
					_string_text = string_replace_all(_string_text, "\r", _mark_linebreak);
				}
				
				if ((_elementLength != all) and (string_length(_string_text) > _lengthLimit_cut))
				{
					_string_text = (string_copy(_string_text, 1, _lengthLimit) + _cutMark);
				}
				
				if (_full)
				{
					var _string_color;
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
					
					_string = ("Text: " + _string_text + _mark_separator +
							   "Font: " + string(font) + _mark_separator +
							   "Location: " + string(location) + _mark_separator +
							   "Align: " + string(align) + _mark_separator +
							   "Scale: " + string(scale) + _mark_separator +
							   "Angle: " + string(angle) + _mark_separator +
							   "Color: " + string(_string_color) + _mark_separator +
							   "Alpha: " + string(alpha));
				}
				else
				{
					_string = _string_text;
				}
				
				return ((_multiline) ? _string : instanceof(self) + "(" + _string + ")");
			}
			
			/// @returns			{VertexBuffer.PrimitiveRenderData} | On error: {undefined}
			/// @description		Return rendering data of this constructor in a Vertex Buffer.
			///						If used with a SDF Font, rendering data will be returned with event
			///						setup to resolve SDF rendering through a built-in Shader.
			static toVertexBuffer = function()
			{
				var _vertexBuffer = undefined;
				var _renderData = undefined;
				var _font_original = draw_get_font();
				
				try
				{
					draw_set_font(font.ID);
					
					var _string = string(ID);
					var _align_multiplier = align.getMultiplier();
					var _font_data = font_get_info(font.ID);
					var _font_size = _font_data.size;
					var _origin_x = (round(location.x) - _font_data.sdfSpread);
					var _location_x = _origin_x;
					var _location_y = (round(location.y) - _font_data.sdfSpread);
					var _char_count = string_length(_string);
					var _char_isLinebreak = false;
					var _line_vertexData = [[]];
					var _line_index = 0;
					var _line_text = [""];
					var _linebreak_offset = string_height("\n");
					var _linebreak_chain = 0;
					var _vertex = new Vector2();
					var _texture = font_get_texture(font.ID);
					var _texelSize_x = texture_get_texel_width(_texture);
					var _texelSize_y = texture_get_texel_height(_texture);
					var _vertex_order = [[0, 1, 2, 3], [2, 3, 0, 1]];
					var _vertex_order_index = 0;
					var _vertex_count = array_length(_vertex_order[0]);
					var _uv_x = undefined;
					var _uv_y = undefined;
					var _i = [1, 0, 0];
					repeat (_char_count)
					{
						if (_i[0] > _char_count)
						{
							break;
						}
						
						var _char = string_char_at(_string, _i[0]);
						
						if ((_char == "\n") or (_char == "\r"))
						{
							_char_isLinebreak = true;
							var _char_next = string_char_at(_string, (_i[0] + 1));
							
							if (((_char == "\n") and (_char_next == "\r"))
							or  ((_char == "\r") and (_char_next == "\n")))
							{
								//|Two different line-breaks after each other produce a single offset.
								++_i[0];
							}
							
							++_linebreak_chain;
						}
						else
						{
							if (_linebreak_chain > 0)
							{
								_location_x = _origin_x;
								_location_y += (_linebreak_offset * _linebreak_chain);
								_vertex_order_index = 0;
								
								if (_uv_x != undefined)
								{
									var _linebreak_vertexData = [_location_x, _location_y, _uv_x,
																 _uv_y, 0, _char_isLinebreak];
									array_push(_line_vertexData[_line_index], _linebreak_vertexData,
											   _linebreak_vertexData);
									++_line_index;
									_line_vertexData[_line_index] = [];
									_line_text[_line_index] = "";
								}
								
								_linebreak_chain = 0;
							}
							
							var _char_data = (struct_get(_font_data.glyphs, _char)
											  ?? struct_get(_font_data.glyphs, "▯"));
							
							if (_char_data != undefined)
							{
								_line_text[_line_index] += _char;
								_char_isLinebreak = false;
								var _offset_x = (struct_get(_char_data, "offset") ?? 0);
								var _location_x_offset = round(_location_x + _offset_x);
								var _char_uv_x1 = (_char_data.x * _texelSize_x);
								var _char_uv_y1 = (_char_data.y * _texelSize_y);
								var _char_uv_x2 = (_char_uv_x1 + (_char_data.w * _texelSize_x));
								var _char_uv_y2 = (_char_uv_y1 + (_char_data.h * _texelSize_y));
								
								//|Vertex ordering is swapped after each character, as their building
								// finishes at different vertical level each time.
								var _vertex_order_current = _vertex_order[_vertex_order_index];
								var _vertex_location = [[_location_x_offset, _location_y],
														[(_location_x_offset + _char_data.w),
														 _location_y],
														[_location_x_offset,
														 (_location_y + _char_data.h)],
														[(_location_x_offset + _char_data.w),
														 (_location_y + _char_data.h)]];
								var _vertex_uv = [[_char_uv_x1, _char_uv_y1],
												  [_char_uv_x2, _char_uv_y1],
												  [_char_uv_x1, _char_uv_y2],
												  [_char_uv_x2, _char_uv_y2]];
								_i[2] = 0;
								repeat (_vertex_count)
								{
									var _vertex_index = _vertex_order_current[_i[2]];
									_uv_x = _vertex_uv[_vertex_index][0];
									_uv_y = _vertex_uv[_vertex_index][1];
									
									array_push(_line_vertexData[_line_index],
											   [_vertex_location[_vertex_index][0],
												_vertex_location[_vertex_index][1], _uv_x, _uv_y,
												_offset_x, _char_isLinebreak]);
									
									++_i[2];
								}
								
								_vertex_order_index = ((_vertex_order_index + 1) mod 2);
								
								if (_i[0] < _char_count)
								{
									_location_x += _char_data.shift;
									
									var _char_kerning = struct_get(_char_data, "kerning");
									
									if (is_array(_char_kerning))
									{
										var _ord_next = string_ord_at(_string, (_i[0] + 1));
										_i[1] = 0;
										repeat (array_length(_char_kerning) div 2)
										{
											if (_char_kerning[_i[1]] == _ord_next)
											{
												_location_x += _char_kerning[(_i[1] + 1)];
												
												break;
											}
											
											_i[1] += 2;
										}
									}
								}
							}
						}
						
						++_i[0];
					}
					
					_vertexBuffer = new VertexBuffer();
					_renderData = _vertexBuffer.createPrimitiveRenderData(pr_trianglestrip, undefined,
																		  _texture);
					
					if (_font_data.sdfEnabled)
				{
					_renderData.event.beforeRender.callback = shader_set;
					array_push(_renderData.event.beforeRender.argument, __yy_sdf_shader);
					_renderData.event.afterRender.callback = shader_reset;
				}
					
					_vertexBuffer.setActive(_renderData.passthroughFormat);
					{
						var _line_size_x_affect = sign(_align_multiplier.x);
						var _align_offset_y = round(string_height(_string) * _align_multiplier.y);
						var _i = [0, 0];
						repeat (array_length(_line_vertexData))
						{
							var _lineData_current = _line_vertexData[_i[0]];
							var _lineData_count = array_length(_lineData_current);
							
							if (_lineData_count > 0)
							{
								//|If final vertices are a linebreak, ones before them are calculated
								// when applicable.
								var _vertex_final = ((_lineData_current[(_lineData_count - 1)][5])
													 ? max((_lineData_count - 3), 0)
													 : (_lineData_count - 1));
								var _align_offset_x = round(string_width(_line_text[_i[0]]) *
															_align_multiplier.x);
								_i[1] = 0;
								repeat (_lineData_count)
								{
									var _glyphData_current = _line_vertexData[_i[0]][_i[1]];
									
									_vertexBuffer
									 .setLocation(_vertex.set((_glyphData_current[0] -
															   _align_offset_x),
															  (_glyphData_current[1] - 
															   _align_offset_y)))
									 .setColor(color, alpha)
									 .setUV(_glyphData_current[2], _glyphData_current[3]);
									
									++_i[1];
								}
							}
							
							++_i[0];
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
				
				draw_set_font(_font_original);
				
				return _renderData;
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static constructor = TextRenderer;
		
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
