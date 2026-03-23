//  @function				Ellipse()
/// @argument				location {Vector4}
/// @argument				fill_color? {int:color|Color2}
/// @argument				fill_alpha? {real}
/// @argument				outline_size? {int}
/// @argument				outline_color? {int:color}
/// @argument				outline_alpha? {real}
/// @argument				precision? {int:divisibleBy4}
/// @description			Constructs an Ellipse Shape, which is a Circle that can be extended at
///							single axis to fit between two points of its specified location. It is
///							a series of triangles placed circularly from center, the amount of which
///							equals the specified precision.
//							
//							Construction types:
//							- New constructor
//							- From Circle: circle {Circle}
//							- Empty: {void}
//							- Constructor copy: other {Ellipse}
function Ellipse() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				location = undefined;
				fill_color = undefined;
				fill_alpha = undefined;
				outline_size = undefined;
				outline_color = undefined;
				outline_alpha = undefined;
				precision = undefined;
				
				var _scope = self;
				event =
				{
					beforeRender: new Callback(undefined, [], _scope),
					afterRender: new Callback(undefined, [], _scope),
					getPrimitiveRenderData: new Callback(function(_data) {return _data;}, [], _scope),
				};
				
				if (argument_count > 0)
				{
					if (is_instanceof(argument[0], Ellipse))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						location = ((is_instanceof(_other.location, Vector4))
									? new Vector4(_other.location) : _other.location);
						fill_color = ((is_instanceof(_other.fill_color, Color2))
									  ? new Color2(_other.fill_color) : _other.fill_color);
						fill_alpha = _other.fill_alpha;
						outline_size = _other.outline_size;
						outline_color = _other.outline_color;
						outline_alpha = _other.outline_alpha;
						precision = _other.precision;
						
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
					else if (is_instanceof(argument[0], Circle))
					{
						//|Construction type: From Circle.
						var _circle = argument[0];
						
						location = new Vector4((_circle.location.x - _circle.radius),
											   (_circle.location.y - _circle.radius),
											   (_circle.location.x + _circle.radius),
											   (_circle.location.y + _circle.radius));
						fill_color = ((is_instanceof(_circle.fill_color, Color2))
									  ? new Color2(_circle.fill_color) : _circle.fill_color);
						fill_alpha = _circle.fill_alpha;
						outline_size = _circle.outline_size;
						outline_color = _circle.outline_color;
						outline_alpha = _circle.outline_alpha;
						precision = _circle.precision;
						
						if (is_struct(_circle.event))
						{
							event.beforeRender.setAll(_circle.event.beforeRender);
							event.afterRender.setAll(_circle.event.afterRender);
						}
						else
						{
							event = _circle.event;
						}
					}
					else
					{
						//|Construction type: New constructor.
						location = argument[0];
						fill_color = (((argument_count > 1)) ? argument[1] : undefined);
						fill_alpha = (((argument_count > 2) and (argument[2] != undefined))
									  ? argument[2] : 1);
						outline_size = (((argument_count > 3) and (argument[3] != undefined))
										? argument[3] : 0);
						outline_color = ((argument_count > 4) ? argument[4] : undefined);
						outline_alpha = (((argument_count > 5) and (argument[5] != undefined))
										 ? argument[5] : 1);
						precision = ((argument_count > 6) ? argument[6] : 24);
					}
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_instanceof(location, Vector4)) and (location.isFunctional()));
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			other {Ellipse}
			/// @returns			{bool}
			/// @description		Check if specified constructor has equivalent properties.
			static equals = function(_other)
			{
				return ((is_instanceof(_other, Ellipse)) and (fill_alpha == _other.fill_alpha) and
						(outline_size == _other.outline_size) and
						(outline_color == _other.outline_color) and
						(outline_alpha == _other.outline_alpha) and
						(precision == _other.precision) and ((location == _other.location) or
						((string_copy(instanceof(location), 1, 6) == "Vector") and
						 (location.equals(_other.location)))) and
						((fill_color == _other.fill_color) or
						 ((string_copy(instanceof(fill_color), 1, 5) == "Color") and
						 (fill_color.equals(_other.fill_color)))));
			}
			
			/// @argument			object {handle:object|handle:instance}
			/// @argument			precise? {bool}
			/// @argument			excludedInstance? {handle:instance}
			/// @argument			list? {bool|List}
			/// @argument			listOrdered? {bool}
			/// @argument			includeOutline? {bool}
			/// @returns			{handle:instance|List}
			/// @description		Check for a collision within this Shape with instances of the
			///						specified object.
			///						If specified, the location can be extended to include area up to
			///						outer edge of the outline.
			///						Returns the ID of a single colliding instance or noone.
			///						If List use is specified, a List will be returned instead, either
			///						empty or containing IDs of the colliding instances.
			///						The additions to that List can be ordered by distance from the
			///						center of the Shape if specified.
			static collision = function(_object, _precise = false, _excludedInstance, _list = false,
										_listOrdered = false, _includeOutline = false)
			{
				var _list_created = false;
				
				try
				{
					var _location = ((_includeOutline) ? self.getOutlineLocation() : location);
					
					if (_list)
					{
						if (!is_instanceof(_list, List))
						{
							_list = new List();
							_list_created = true;
						}
						
						if ((is_real(_excludedInstance)) and (instance_exists(_excludedInstance)))
						{
							with (_excludedInstance)
							{
								collision_ellipse_list(_location.x1, _location.y1, _location.x2,
													   _location.y2, _object, _precise, true,
													   _list.ID, _listOrdered);
							}
						}
						else
						{
							collision_ellipse_list(_location.x1, _location.y1, _location.x2,
												   _location.y2, object, _precise, false, _list.ID,
												   _listOrdered);
						}
					
						return _list;
					}
					else
					{
						if ((is_real(_excludedInstance)) and (instance_exists(_excludedInstance)))
						{				
							with (_excludedInstance)
							{
								return collision_ellipse(_location.x1, _location.y1, _location.x2,
														 _location.y2, _object, _precise, true);
							}
						}
						else
						{
							return collision_ellipse(_location.x1, _location.y1, _location.x2,
													 _location.y2, _object, _precise, false);
						}
					}
				}
				catch (_exception)
				{
					ErrorReport.report([other, self, "collision()"], _exception);
					
					if (_list_created)
					{
						_list.destroy();
					}
				}
				
				return noone;
			}
			
			/// @argument			point {Vector2}
			/// @argument			includeOutline? {bool}
			/// @returns			{bool}
			/// @description		Checks whether the specified point in space is within this Shape.
			///						If specified, the location can be extended to include area up to
			///						outer edge of the outline.
			static containsPoint = function(_point, _includeOutline = false)
			{
				try
				{
					var _location = ((_includeOutline) ? self.getOutlineLocation() : location);
					
					if (point_in_rectangle(_point.x, _point.y, _location.x1, _location.y1,
										   _location.x2, _location.y2))
					{
						var _vertex_location = self.getVertexLocation(_location, undefined, true);
						var _center = _vertex_location[0];
						var _center_x = _center[0];
						var _center_y = _center[1];
						var _vertex_count = array_length(_vertex_location);
						var _vertex_location_start = _vertex_location[1];
						var _vertex_location_end = _vertex_location[(_vertex_count - 2)];
						
						if (point_in_triangle(_point.x, _point.y, _center_x, _center_y,
											  _vertex_location_start[0], _vertex_location_start[1],
											  _vertex_location_end[0], _vertex_location_end[1]))
						{
							return true;
						}
						
						var _segment_count = 4;
						var _vertex_count_outer = (_vertex_count - 2);
						var _vertex_count_segment = (_vertex_count_outer / _segment_count);
						var _segment_y_part = real(_point.y < _center_y);
						var _segment = ((_point.x < _center_x) ? (1 + _segment_y_part)
															   : (3 * _segment_y_part));
						var _i = ((_segment * _vertex_count_segment));
						repeat (_vertex_count_segment + 2)
						{
							var _point_current = _vertex_location[(_i mod _vertex_count)];
							var _point_next = _vertex_location[((_i + 1) mod _vertex_count)];
							
							if (point_in_triangle(_point.x, _point.y, _center_x, _center_y,
												  _point_current[0], _point_current[1],
												  _point_next[0], _point_next[1]))
							{
								return true;
							}
							
							++_i;
						}
					}
				}
				catch (_exception)
				{
					ErrorReport.report([other, self, "containsPoint()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			device? {int}
			/// @argument			GUI? {bool}
			/// @argument			includeOutline? {bool}
			/// @returns			{bool}
			//  @see				display_set_gui_size()
			/// @description		Check if the system cursor location is over this Shape.
			///						If specified, the location can be extended to include area up to
			///						outer edge of the outline.
			///						A target device can be specified for use with multiple cursor
			///						input sources. Then, the position can also be calculated according
			///						to the size of the GUI layer.
			static cursorOver = function(_device, _GUI = false, _includeOutline = false)
			{
				try
				{
					var _cursor_x = mouse_x;
					var _cursor_y = mouse_y;
					
					if (_device != undefined)
					{
						if (_GUI)
						{
							_cursor_x = device_mouse_x_to_gui(_device);
							_cursor_y = device_mouse_y_to_gui(_device);
						}
						else
						{
							_cursor_x = device_mouse_x(_device);
							_cursor_y = device_mouse_y(_device);
						}
					}
					
					return self.containsPoint(new Vector2(_cursor_x, _cursor_y), _includeOutline);
				}
				catch (_exception)
				{
					ErrorReport.report([other, self, "cursorOver()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			button {constant:mb_*}
			/// @argument			device? {int}
			/// @argument			GUI? {bool}
			/// @argument			includeOutline? {bool}
			/// @returns			{bool}
			//  @see				display_set_gui_size()
			/// @description		Check if the system cursor location is over this Shape while the
			///						specified mouse or touch input was pressed this frame.
			///						If specified, the location can be extended to include area up to
			///						outer edge of the outline.
			///						A target device can be specified for use with multiple cursor
			///						input sources. Then, the position can also be calculated according
			///						to the size of the GUI layer.
			static cursorPressed = function(_button, _device, _GUI = false, _includeOutline = false)
			{
				try
				{
					return (((_device == undefined) ? mouse_check_button_pressed(_button)
													: device_mouse_check_button_pressed(_device,
																						_button))
							and (self.cursorOver(_device, _GUI, _includeOutline)));
				}
				catch (_exception)
				{
					ErrorReport.report([other, self, "cursorPressed()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			button {constant:mb_*}
			/// @argument			device? {int}
			/// @argument			GUI? {bool}
			/// @argument			includeOutline? {bool}
			/// @returns			{bool}
			//  @see				display_set_gui_size()
			/// @description		Check if the system cursor location is over this Shape while the
			///						specified mouse or touch input is being pressed or held.
			///						If specified, the location can be extended to include area up to
			///						outer edge of the outline.
			///						A target device can be specified for use with multiple cursor
			///						input sources. Then, the position can also be calculated according
			///						to the size of the GUI layer.
			static cursorHeld = function(_button, _device, _GUI = false, _includeOutline = false)
			{
				try
				{
					return (((_device == undefined) ? mouse_check_button(_button)
													: device_mouse_check_button(_device, _button))
							and (self.cursorOver(_device, _GUI, _includeOutline)));
				}
				catch (_exception)
				{
					ErrorReport.report([other, self, "cursorHeld()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			button {constant:mb_*}
			/// @argument			device? {int}
			/// @argument			GUI? {bool}
			/// @argument			includeOutline? {bool}
			/// @returns			{bool}
			//  @see				display_set_gui_size()
			/// @description		Check if the system cursor location is over this Shape while the
			///						the specified mouse or touch input was released this frame.
			///						If specified, the location can be extended to include area up to
			///						outer edge of the outline.
			///						A target device can be specified for use with multiple cursor
			///						input sources. Then, the position can also be calculated according
			///						to the size of the GUI layer.
			static cursorReleased = function(_button, _device, _GUI = false, _includeOutline = false)
			{
				try
				{
					return (((_device == undefined) ? mouse_check_button_released(_button)
													: device_mouse_check_button_released(_device,
																						 _button))
							and (self.cursorOver(_device, _GUI, _includeOutline)));
				}
				catch (_exception)
				{
					ErrorReport.report([other, self, "cursorReleased()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			location? {Vector4}
			/// @argument			precision? {int:divisibleBy4}
			/// @argument			startWithCenter? {bool}
			/// @returns			{real[+]}
			/// @description		Return an array containing nested arrays with point locations,
			///						resulting in this Shape when connected. If specified, the center
			///						point of this Shape will be added at beginning of returned array.
			///						The amount of locations returned will be increased by the
			///						specified curve precision. 
			//  @author				Adapted from code by YoYo Games (https://github.com/YoYoGames/
			//						GameMaker-HTML5/blob/9143e2770e2d6a333f2bdcbe640d1f45f7258d6b/
			//						scripts/yyWebGL.js#L3507-L3607)
			static getVertexLocation = function(_location = location, _precision = precision,
												_startWithCenter = false)
			{
				var _result = [];
				
				try
				{
					var _segment_count = 4;
					_precision = clamp(((_precision div _segment_count) * _segment_count),
									   _segment_count, 64);
					var _pi = 3.14159265;
					var _curve_vertex_count = ((_precision / _segment_count) + 1);
					var _curve_sin = array_create((_precision + 1), 0);
					var _curve_cos = array_create((_precision + 1), 1);
					var _i = 1;
					repeat (_precision + 1)
					{
						_curve_sin[_i] = sin(_i * 2 * _pi / _precision);
						_curve_cos[_i] = cos(_i * 2 * _pi / _precision);
						
						++_i;
					}
					
					var _center_x = mean(_location.x1, _location.x2);
					var _center_y = mean(_location.y1, _location.y2);
					var _radius_x = (abs(_location.x1 - _location.x2) * 0.5);
					var _radius_y = (abs(_location.y1 - _location.y2) * 0.5);
					var _centerArrayOffset = real(bool(_startWithCenter));
					var _vertex_count = (_precision + 1);
					_result = array_create(_vertex_count, undefined);
					
					if (_startWithCenter)
					{
						_result[0] = [_center_x, _center_y];
					}
					
					var _i = 0;
					repeat (_vertex_count)
					{
						_result[(_i + _centerArrayOffset)] =
						 [(_center_x + (_radius_x * _curve_cos[_i])),
						  (_center_y + (_radius_y * _curve_sin[_i]))];
						
						++_i;
					}
				}
				catch (_exception)
				{
					ErrorReport.report([other, self, "getVertexLocation()"], _exception);
				}
				
				return _result;
			}
			
			/// @argument			location? {Vector4}
			/// @argument			fill_color? {int:color|Color2}
			/// @argument			fill_alpha? {real}
			/// @argument			outline_size? {int}
			/// @argument			outline_color? {int:color}
			/// @argument			outline_alpha? {real}
			/// @argument			precision? {int:divisibleBy4}
			/// @argument			outline? {bool|all}
			/// @returns			{any[+]} | On error: {undefined}
			//  @see				getVertexLocation()
			/// @description		Return an array containg rendering data for each vertex resulting
			///						in this Shape, consisting of its primitive type, location, color
			///						and alpha value, based on the data of this constructor or its
			///						specified replaced parts. Up to two nested values will be returned
			///						in that array, depending on whether it was specified to return
			///						only data for outline, not return it and use only fill instead, or
			///						to contain all of this data. Each will be represented at following
			///						array positions, nested in the primary array:
			///						- array[0]: primitive type {constant:pr_*}
			///						- array[1]: vertex data {any[]}
			///						  - array[1][0]: location {real[]}
			///						  - array[1][1]: color {int:color}
			///						  - array[1][2]: alpha {real}
			static getPrimitiveRenderData = function(_location = location, _fill_color = fill_color,
													 _fill_alpha = fill_alpha,
													 _outline_size = outline_size,
													 _outline_color = outline_color,
													 _outline_alpha = outline_alpha,
													 _precision = precision, _outline = all)
			{
				try
				{
					var _result = [];
					var _primitive = [];
					var _segment_count = 4;
					var _vertex_location_base = undefined;
					var _color = _outline_color;
					
					if (((!_outline) or (_outline == all)) and (_fill_color != undefined)
					and (_fill_alpha > 0))
					{
						_vertex_location_base = self.getVertexLocation(_location, _precision, true);
						var _color2 = _fill_color;
						
						if (is_instanceof(_fill_color, Color2))
						{
							_color = _fill_color.color1;
							_color2 = _fill_color.color2;
						}
						else
						{
							_color = _fill_color;
						}
						
						array_push(_primitive, [pr_trianglefan, _vertex_location_base, _color2,
												_fill_alpha]);
					}
					
					if (((_outline) or (_outline == all)) and (_outline_color != undefined)
					and (_outline_alpha > 0) and (_outline_size >= 1))
					{
						var _vertex_location = [];
						var _vertex_color_offset_outline = 2;
						var _vertex_location_inner = ((_vertex_location_base)
													  ?? self.getVertexLocation(_location, _precision,
																				true));
						var _vertex_location_outer =
						 self.getVertexLocation(self.getOutlineLocation(_location, _outline_size),
												_precision);
						var _i = 0;
						repeat (array_length(_vertex_location_outer))
						{
							array_push(_vertex_location, _vertex_location_inner[(_i + 1)],
									   _vertex_location_outer[_i]);
							
							++_i;
						}
						
						array_push(_primitive, [pr_trianglestrip, _vertex_location, _outline_color,
												_outline_alpha, _vertex_color_offset_outline]);
					}
					
					var _i = [0, 0];
					repeat (array_length(_primitive))
					{
						var _vertex_data_current = [];
						var _primitive_current = _primitive[_i[0]];
						var _primitive_type = _primitive_current[0];
						var _primitive_location = _primitive_current[1];
						var _vertex_color = _primitive_current[2];
						var _vertex_alpha = _primitive_current[3];
						var _vertex_count = array_length(_primitive_location);
						
						if (_primitive_type != pr_trianglefan)
						{
							_color = _vertex_color;
						}
						
						_i[1] = 0;
						repeat (_vertex_count)
						{
							var _vertex_location_current = _primitive_location[_i[1]];
							
							array_push(_vertex_data_current, [_vertex_location_current, _color,
															  _vertex_alpha]);
							
							_color = _vertex_color;
							
							++_i[1];
						}	
						
						array_push(_result, [_primitive_type, _vertex_data_current]);
						
						++_i[0];
					}
					
					return event.getPrimitiveRenderData.execute(undefined, [_result]);
				}
				catch (_exception)
				{
					ErrorReport.report([other, self, "getPrimitiveRenderData()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			location? {Vector4}
			/// @argument			outline_size? {int}
			/// @returns			{Vector4}
			/// @description		Return the location of outer edge of the outline, using data of
			///						this constructor or specified temporarily replaced parts.
			static getOutlineLocation = function(_location = location, _outline_size = outline_size)
			{
				try
				{
					return new Vector4(_location).sort(true).grow(_outline_size);
				}
				catch (_exception)
				{
					ErrorReport.report([other, self, "getOutlineLocation()"], _exception);
				}
				
				return undefined;
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			location? {Vector4}
			/// @argument			fill_color? {int:color|Color2}
			/// @argument			fill_alpha? {real}
			/// @argument			outline_size? {int}
			/// @argument			outline_color? {int:color}
			/// @argument			outline_alpha? {real}
			/// @argument			precision? {int:divisibleBy4}
			/// @description		Execute the draw of this Shape as a primitive, using data of this
			///						constructor or specified temporarily replaced parts.
			static render = function(_location = location, _fill_color = fill_color,
									 _fill_alpha = fill_alpha, _outline_size = outline_size,
									 _outline_color = outline_color, _outline_alpha = outline_alpha,
									 _precision = precision)
			{
				var _location_original = location;
				var _fill_color_original = fill_color;
				var _fill_alpha_original = fill_alpha;
				var _outline_color_original = outline_color;
				var _outline_alpha_original = outline_alpha;
				var _outline_size_original = outline_size;
				var _precision_original = precision;
				
				location = _location;
				fill_color = _fill_color;
				fill_alpha = _fill_alpha;
				outline_color = _outline_color;
				outline_alpha = _outline_alpha;
				outline_size = _outline_size;
				precision = _precision;
				
				try
				{
					if (self.isFunctional())
					{
						event.beforeRender.execute();
						
						var _primitive = self.getPrimitiveRenderData();
						var _i = [0, 0];
						repeat (array_length(_primitive))
						{
							var _primitive_current = _primitive[_i[0]];
							var _vertex_data = _primitive_current[1];
							
							draw_primitive_begin(_primitive_current[0]);
							{
								_i[1] = 0;
								repeat (array_length(_vertex_data))
								{
									var _vertex_data_current = _vertex_data[_i[1]];
									var _vertex_location_current = _vertex_data_current[0];
									
									draw_vertex_color(_vertex_location_current[0],
													  _vertex_location_current[1],
													  _vertex_data_current[1],
													  _vertex_data_current[2]);
									
									++_i[1];
								}
							}
							draw_primitive_end();
							
							++_i[0];
						}
						
						event.afterRender.execute();
					}
					else
					{
						ErrorReport.report([other, self, "render()"],
										   ("Attempted to render an invalid Shape: " +
											"{" + string(self) + "}"));
					}
				}
				catch (_exception)
				{
					ErrorReport.report([other, self, "render()"], _exception);
				}
				finally
				{
					location = _location_original;
					fill_color = _fill_color_original;
					fill_alpha = _fill_alpha_original;
					outline_color = _outline_color_original;
					outline_alpha = _outline_alpha_original;
					outline_size = _outline_size_original;
					precision = _precision_original;
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
					var _color = [fill_color, outline_color];
					var _color_count = array_length(_color);
					var _string_color = array_create(_color_count, "");
					var _mark_separator_inline = ", ";
					var _i = 0;
					repeat (_color_count)
					{
						if (is_real(_color[_i]))
						{
							switch (_color[_i])
							{
								case c_aqua: _string_color[_i] = "Aqua"; break;
								case c_black: _string_color[_i] = "Black"; break;
								case c_blue: _string_color[_i] = "Blue"; break;
								case c_dkgray: _string_color[_i] = "Dark Gray"; break;
								case c_fuchsia: _string_color[_i] = "Fuchsia"; break;
								case c_gray: _string_color[_i] = "Gray"; break;
								case c_green: _string_color[_i] = "Green"; break;
								case c_lime: _string_color[_i] = "Lime"; break;
								case c_ltgray: _string_color[_i] = "Light Gray"; break;
								case c_maroon: _string_color[_i] = "Maroon"; break;
								case c_navy: _string_color[_i] = "Navy"; break;
								case c_olive: _string_color[_i] = "Olive"; break;
								case c_orange: _string_color[_i] = "Orange"; break;
								case c_purple: _string_color[_i] = "Purple"; break;
								case c_red: _string_color[_i] = "Red"; break;
								case c_teal: _string_color[_i] = "Teal"; break;
								case c_white: _string_color[_i] = "White"; break;
								case c_yellow: _string_color[_i] = "Yellow"; break;
								default:
									if (_colorHSV)
									{
										_string_color[_i] =
										("(" +
										 "Hue: " + string(color_get_hue(_color[_i]))
												 + _mark_separator_inline +
										 "Saturation: " + string(color_get_saturation(_color[_i]))
														+ _mark_separator_inline +
										 "Value: " + string(color_get_value(_color[_i])) +
										 ")");
									}
									else
									{
										_string_color[_i] =
										("(" +
										 "Red: " + string(color_get_red(_color[_i]))
												 + _mark_separator +
										 "Green: " + string(color_get_green(_color[_i]))
												   + _mark_separator +
										 "Blue: " + string(color_get_blue(_color[_i])) +
										 ")");
									}
								break;
							}
						}
						else
						{
							_string_color[_i] = ((is_instanceof(_color[_i], Color2))
												 ? _color[_i].toString(false, _colorHSV)
												 : string(_color[_i]));
						}
						
						++_i;
					}
					
					_string = ("Location: " + string(location) + _mark_separator +
							   "Fill Color: " + string(_string_color[0]) + _mark_separator +
							   "Fill Alpha: " + string(fill_alpha) + _mark_separator +
							   "Outline Size: " + string(outline_size) + _mark_separator +
							   "Outline Color: " + string(_string_color[1]) + _mark_separator +
							   "Outline Alpha: " + string(outline_alpha) +
							   "Precision: " + string(precision));
				}
				
				return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
			}
			
			/// @returns			{real[+]}
			/// @description		Return an array containing values of all properties of this Shape.
			///						Properties with multiple values will be returned in nested arrays.
			static toArray = function()
			{
				var _location = ((is_instanceof(location, Vector4)) ? location.toArray() : location);
				var _fill_color = ((is_instanceof(fill_color, Color2)) ? fill_color.toArray()
																	   : fill_color);
				
				return [_location, _fill_color, fill_alpha, outline_size, outline_color,
						outline_alpha, precision];
			}
			
			/// @argument			location? {Vector4}
			/// @argument			fill_color? {int:color|Color2}
			/// @argument			fill_alpha? {real}
			/// @argument			outline_size? {int}
			/// @argument			outline_color? {int:color}
			/// @argument			outline_alpha? {real}
			/// @argument			precision? {int:divisibleBy4}
			/// @argument			outline? {bool|all}
			/// @argument			vertexBuffer? {VertexBuffer|VertexBuffer[]}
			/// @returns			{VertexBuffer.PrimitiveRenderData|
			///						 VertexBuffer.PrimitiveRenderData[]} | On error: {undefined}
			/// @description		Return rendering data of this constructor in a Vertex Buffer,
			///						using its current data or specified temporarily replaced parts.
			///						Multiple values can be returned in an array, depending on whether
			///						it was specified to return only data for outline, use only fill
			///						instead or to return data for all parts. If existing Vertex Buffer
			///						is to be specified, two separate Vertex Buffers must be specified
			///						for them. Data for invisible or invalid render will be excluded.
			static toVertexBuffer = function(_location = location, _fill_color = fill_color,
											 _fill_alpha = fill_alpha, _outline_size = outline_size,
											 _outline_color = outline_color,
											 _outline_alpha = outline_alpha, _precision = precision,
											 _outline = all, _vertexBuffer)
			{
				var _vertexBuffer_fill = undefined;
				var _vertexBuffer_outline = undefined;
				
				try
				{
					var _renderData = [];
					var _vertexBuffer_wasActive = ((_outline == all) ? [false, false] : [false]);
					
					if (_vertexBuffer != undefined)
					{
						if (_outline == all)
						{
							_vertexBuffer_fill = _vertexBuffer[0];
							_vertexBuffer_outline = _vertexBuffer[1];
							
							if (_vertexBuffer_fill == _vertexBuffer_outline)
							{
								throw ("Cannot submit multiple different primitive types into the " +
									   "same Vertex Buffer.");
							}
							
							_vertexBuffer_wasActive = [_vertexBuffer_fill.active,
													   _vertexBuffer_outline.active];
						}
						else if (_outline)
						{
							_vertexBuffer_fill = _vertexBuffer;
							_vertexBuffer_wasActive = [_vertexBuffer_fill.active];
						}
						else
						{
							_vertexBuffer_outline = _vertexBuffer;
							_vertexBuffer_wasActive = [_vertexBuffer_outline.active];
						}
					}
					
					if (((!_outline) or (_outline == all)) and (_fill_color != undefined)
					and (_fill_alpha > 0))
					{
						if (!is_instanceof(_vertexBuffer_fill, VertexBuffer))
						{
							_vertexBuffer_fill = new VertexBuffer();
						}
						
						array_push(_renderData, _vertexBuffer_fill
												.createPrimitiveRenderData(pr_trianglefan));
					}
					
					if (((_outline) or (_outline == all)) and (_outline_color != undefined)
					and (_outline_alpha > 0) and (_outline_size >= 1))
					{
						var _primitiveType_outline = ((_outline_size > 1) ? pr_trianglestrip
																		  : pr_linestrip);
						
						if (!is_instanceof(_vertexBuffer_outline, VertexBuffer))
						{
							_vertexBuffer_outline = new VertexBuffer();
						}
						
						array_push(_renderData, _vertexBuffer_outline
												.createPrimitiveRenderData(_primitiveType_outline));
					}
					
					var _primitive = self.getPrimitiveRenderData(_location, _fill_color, _fill_alpha,
																 _outline_size, _outline_color,
																 _outline_alpha, _precision,
																 _outline);
					var _vertex = new Vector2();
					var _i = [0, 0];
					repeat (array_length(_primitive))
					{
						var _renderData_current = _renderData[_i[0]];
						var _vertexBuffer_current = _renderData_current.vertexBuffer;
						var _primitive_current = _primitive[_i[0]];
						var _vertex_data = _primitive_current[1];
						_vertexBuffer_current.setActive(_renderData_current.vertexFormat);
						_i[1] = 0;
						repeat (array_length(_vertex_data))
						{
							var _vertex_data_current = _vertex_data[_i[1]];
							var _vertex_location_current = _vertex_data_current[0];
							
							_vertexBuffer_current
							 .setLocation2D(_vertex.setAll(_vertex_location_current))
							 .setColor(_vertex_data_current[1], _vertex_data_current[2])
							 .setUV();
							
							++_i[1];
						}
						
						if (!_vertexBuffer_wasActive[_i[0]])
						{
							_vertexBuffer_current.setActive(false);
						}
						
						++_i[0];
					}
					
					return ((array_length(_renderData) == 1) ? _renderData[0] : _renderData);
				}
				catch (_exception)
				{
					if (_vertexBuffer == undefined)
					{
						if (_vertexBuffer_fill != undefined)
						{
							_vertexBuffer_fill.destroy();
						}
						
						if (_vertexBuffer_outline != undefined)
						{
							_vertexBuffer_outline.destroy();
						}
					}
					
					ErrorReport.report([other, self, "toVertexBuffer()"], _exception);
				}
				
				return undefined;
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static constructor = Ellipse;
		
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
