//  @function				TextRenderer()
/// @argument				string {any:string}
/// @argument				font {Font}
/// @argument				location {Vector2}
/// @argument				align? {TextAlign}
/// @argument				scale? {int|Scale}
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
					beforeRender: new Callback(undefined, [], other),
					afterRender: new Callback(undefined, [], other)
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
						//Construction type: New constructor.
						ID = argument[0];
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
				return ((is_real(alpha)) and (is_instanceof(font, Font)) and (font.isFunctional())
						and (is_instanceof(location, Vector2)) and (location.isFunctional())
						and (is_instanceof(align, TextAlign)) and (align.isFunctional())
						and ((is_real(scale)) or ((is_instanceof(scale, Scale))
						and (scale.isFunctional()))) and ((is_instanceof(angle, Angle))
						and (angle.isFunctional())));
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			other {TextRenderer}
			/// @returns			{bool}
			/// @description		Check if specified constructor has equivalent properties.
			static equals = function(_other)
			{
				return ((is_instanceof(_other, TextRenderer)) and (color == _other.color)
						and (alpha == _other.alpha) and (string(ID) == string(_other.ID))
						and ((font == _other.font) or ((is_instanceof(font, Font))
						and (font.equals(_other.font)))) and ((location == _other.location)
						or ((string_copy(instanceof(location), 1, 6) == "Vector")
						and (location.equals(_other.location)))) and ((align == _other.align)
						or ((is_instanceof(align, TextAlign)) and (align.equals(_other.align)))));
			}
			
			/// @argument			scale {int|Scale}
			/// @returns			{Scale}
			/// @description		Return relation of the specified Font size to size of a Font of this
			///						renderer as a Scale. If a Scale is specified, its values will be
			///						returned in a new Scale.
			static getScaleMultiplier = function(_scale = scale)
			{
				var _multiplier_x = 1;
				var _multiplier_y = 1;
				
				try
				{
					if (is_instanceof(_scale, Scale))
					{
						_multiplier_x = _scale.x;
						_multiplier_y = _scale.y;
					}
					else if (is_real(_scale))
					{
						_multiplier_x = (round(_scale) / font_get_size(font.ID));
						_multiplier_y = _multiplier_x;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getScaleMultiplier()"], _exception);
				}
				
				return new Scale(_multiplier_x, _multiplier_y);
			}
			
			/// @argument			scale? {int|Scale}
			/// @returns			{Vector2} | On error: {undefined}
			/// @description		Return the number of pixels the text would occupy when rendered
			///						with either its current or specified Scale, or specified Font size.
			static getPixelSize = function(_scale = scale)
			{
				var _font_original = draw_get_font();
				
				try
				{
					draw_set_font(font.ID);
					
					var _string = string(ID);
					var _scale_multiplier = self.getScaleMultiplier(_scale);
					var _pixelSize_x = (string_width(_string) * _scale_multiplier.x);
					var _pixelSize_y = (string_height(_string) * _scale_multiplier.y);
					
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
			
			/// @argument			scale? {int|Scale}
			/// @returns			{Vector4} | On error: {undefined}
			/// @description		Return a boundry for the space the text occupies in pixels, offset
			///						from its origin, using either its current or specified Scale or
			///						Font size.
			static getBoundaryOffset = function(_scale = scale)
			{
				var _font_original = draw_get_font();
				
				try
				{
					draw_set_font(font.ID);
					
					var _string = string(ID);
					var _x1 = undefined;
					var _y1 = undefined;
					var _x2 = undefined;
					var _y2 = undefined;
					var _scale_multiplier = self.getScaleMultiplier(_scale);
					var _size_x = (string_width(_string) * _scale_multiplier.x);
					var _size_y = (string_height(_string) * _scale_multiplier.y);
					
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
			/// @argument			location? {Vector2}
			/// @argument			scale? {int|Scale}
			/// @argument			mark_separator? {string}
			/// @argument			mark_cut? {string}
			/// @description		Attempt to fit the text into the specified boundary by adding line
			///						breaks between words, split by the specified separator, if they
			///						would exceed the boundary horizontally if rendered using current or
			///						specified temporarily replaced location and scale. The text will be
			///						cut if it would then exceed vertical boundary.
			static wrapText = function(_boundary, _location = location, _scale = scale,
									   _mark_separator = " ", _mark_cut = "...")
			{
				var _string_original = ID;
				
				try
				{
					var _parser = new StringParser(ID);
					
					if ((_location.x + _parser.getPixelSize(font, _scale).x +
						 self.getBoundaryOffset(_scale).x1) > _boundary.x)
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
							
							if ((_location.x + _parser.getPixelSize(font, _scale).x +
								 self.getBoundaryOffset(_scale).x1) > _boundary.x)
							{
								_parser.ID = (_text_target + _newLine + _word[_i]);
								
								if ((_location.y + _parser.getPixelSize(font, _scale).y +
									 self.getBoundaryOffset(_scale).y1) > _boundary.y)
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
								if ((_location.y + _parser.getPixelSize(font, _scale).y +
									 self.getBoundaryOffset(_scale).y1) > _boundary.y)
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
			/// @argument			scale? {int|Scale}
			/// @argument			angle? {Angle}
			/// @argument			color? {int:color}
			/// @argument			alpha? {real}
			/// @description		Execute the draw of the text, using data of this constructor or
			///						its specified temporarily replaced parts.
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
					event.beforeRender.execute();
					
					if (alpha > 0)
					{
						draw_set_font(font.ID);
						draw_set_halign(align.x);
						draw_set_valign(align.y);
						
						var _location_x = round(location.x);
						var _location_y = round(location.y);
						var _scale_multiplier = self.getScaleMultiplier();
						var _angle_value = 0;
						
						if (is_instanceof(angle, Angle))
						{
							_angle_value = angle.value;
						}
						
						if ((_scale_multiplier.x != 1) or (_scale_multiplier.y != 1)
						or (_angle_value != 0))
						{
							if (is_instanceof(color, Color4))
							{
								draw_text_transformed_color(_location_x, _location_y, string(ID),
															_scale_multiplier.x, _scale_multiplier.y,
															_angle_value, color.color1, color.color2,
															color.color3, color.color4, alpha);
							}
							else
							{
								draw_set_color(color);
								draw_set_alpha(alpha);
								draw_text_transformed(_location_x, _location_y, string(ID),
													  _scale_multiplier.x, _scale_multiplier.y,
													  _angle_value);
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
					
					event.afterRender.execute();
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
			
			/// @argument			string? {any:string}
			/// @argument			font? {Font}
			/// @argument			location? {Vector2}
			/// @argument			align? {TextAlign}
			/// @argument			scale? {int|Scale}
			/// @argument			angle? {Angle}
			/// @argument			color? {int:color}
			/// @argument			alpha? {real}
			/// @returns			{VertexBuffer.PrimitiveRenderData} | On error: {undefined}
			/// @description		Return rendering data of this constructor in a Vertex Buffer, using
			///						its current data or its specified temporarily replaced parts.
			///						If a SDF Font is used, rendering data will be returned with event
			///						setup to resolve SDF rendering through a built-in Shader.
			static toVertexBuffer = function(_string, _font, _location, _align, _scale, _angle, _color,
											 _alpha)
			{
				var _vertexBuffer = undefined;
				var _renderData = undefined;
				var _font_previous = draw_get_font();
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
				alpha = (_alpha ?? ((alpha > 0) ? alpha : 0));
				
				try
				{
					draw_set_font(font.ID);
					
					var _scale_multiplier = self.getScaleMultiplier();
					var _angle_value = 0;
					
					if (is_instanceof(angle, Angle))
					{
						_angle_value = angle.value;
					}
					
					ID = string(ID);
					var _font_data = font_get_info(font.ID);
					var _align_multiplier = align.getMultiplier();
					var _origin_absolute_x = round(location.x);
					var _origin_absolute_y = round(location.y);
					var _origin_x = (_origin_absolute_x - (_font_data.sdfSpread *
														   _scale_multiplier.x));
					var _origin_y = (_origin_absolute_y - (_font_data.sdfSpread *
														   _scale_multiplier.y));
					var _location_x = _origin_x;
					var _location_y = _origin_y;
					var _angle_dcos = dcos(_angle_value);
					var _angle_dsin = dsin(_angle_value);
					var _align_offset_x = (string_width(ID) * _scale_multiplier.x *
										   _align_multiplier.x);
					var _align_offset_y = (string_height(ID) * _scale_multiplier.y *
										   _align_multiplier.y);
					var _char_count = string_length(ID);
					var _line_vertexData = [[]];
					var _line_index = 0;
					var _line_text = [""];
					var _linebreak_offset = (string_height("\n") * _scale_multiplier.y);
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
						
						var _char = string_char_at(ID, _i[0]);
						
						if ((_char == "\n") or (_char == "\r"))
						{
							var _char_next = string_char_at(ID, (_i[0] + 1));
							
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
								_linebreak_chain = 0;
								_vertex_order_index = 0;
								
								if (_uv_x != undefined)
								{
									var _linebreak_vertexData = [_location_x, _location_y, _uv_x,
																 _uv_y, 0];
									array_push(_line_vertexData[_line_index], _linebreak_vertexData,
											   _linebreak_vertexData);
									++_line_index;
									_line_vertexData[_line_index] = [];
									_line_text[_line_index] = "";
								}
							}
							
							var _char_data = (struct_get(_font_data.glyphs, _char)
											  ?? struct_get(_font_data.glyphs, "▯"));
							
							if (_char_data != undefined)
							{
								_line_text[_line_index] += _char;
								var _offset_x = ((struct_get(_char_data, "offset") *
												 _scale_multiplier.x) ?? 0);
								var _location_x_offset = (_location_x + _offset_x);
								var _char_uv_x1 = (_char_data.x * _texelSize_x);
								var _char_uv_y1 = (_char_data.y * _texelSize_y);
								var _char_uv_x2 = (_char_uv_x1 + (_char_data.w * _texelSize_x));
								var _char_uv_y2 = (_char_uv_y1 + (_char_data.h * _texelSize_y));
								var _char_size_x = (_char_data.w * _scale_multiplier.x);
								var _char_size_y = (_char_data.h * _scale_multiplier.y);
								
								//|Vertex ordering is swapped after each character, as their building
								// finishes at different vertical level each time.
								var _vertex_order_current = _vertex_order[_vertex_order_index];
								var _vertex_location = [[_location_x_offset, _location_y],
														[(_location_x_offset + _char_size_x),
														 _location_y],
														[_location_x_offset,
														 (_location_y + _char_size_y)],
														[(_location_x_offset + _char_size_x),
														 (_location_y + _char_size_y)]];
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
												_offset_x]);
									
									++_i[2];
								}
								
								_vertex_order_index = ((_vertex_order_index + 1) mod 2);
								
								if (_i[0] < _char_count)
								{
									_location_x += (_char_data.shift * _scale_multiplier.x);
									
									var _char_kerning = struct_get(_char_data, "kerning");
									
									if (is_array(_char_kerning))
									{
										var _ord_next = string_ord_at(ID, (_i[0] + 1));
										_i[1] = 0;
										repeat (array_length(_char_kerning) div 2)
										{
											if (_char_kerning[_i[1]] == _ord_next)
											{
												_location_x += (_char_kerning[(_i[1] + 1)] *
																_scale_multiplier.x);
												
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
						var _align_offset_y = (string_height(ID) * _scale_multiplier.y *
											   _align_multiplier.y);
						var _i = [0, 0];
						repeat (array_length(_line_vertexData))
						{
							var _lineData_current = _line_vertexData[_i[0]];
							var _lineData_count = array_length(_lineData_current);
							
							if (_lineData_count > 0)
							{
								_i[1] = 0;
								repeat (_lineData_count)
								{
									var _glyphData_current = _line_vertexData[_i[0]][_i[1]];
									var _origin_transformed_x = (_glyphData_current[0] -
																 _align_offset_x -
																 _origin_absolute_x);
									var _origin_transformed_y = (_glyphData_current[1] -
																 _align_offset_y -
																 _origin_absolute_y);
									var _glyph_location_x = (_origin_absolute_x +
															 (_origin_transformed_x * _angle_dcos) +
															 (_origin_transformed_y * _angle_dsin));
									var _glyph_location_y = (_origin_absolute_y -
															 (_origin_transformed_x * _angle_dsin) +
															 (_origin_transformed_y * _angle_dcos));
									
									_vertexBuffer
									 .setLocation(_vertex.set(_glyph_location_x,
															  _glyph_location_y))
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
				
				draw_set_font(_font_previous);
				
				ID = _string_original;
				font = _font_original;
				location = _location_original;
				align = _align_original;
				scale = _scale_original;
				angle = _angle_original;
				color = _color_original;
				alpha = _alpha_original;
				
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
