//  @function				Line()
/// @argument				location {Vector4}
/// @argument				size? {real}
/// @argument				color? {int:color|Color2|Color4}
/// @argument				alpha? {real}
/// @description			Constructs a Line shape.
//							
//							Construction types:
//							- New constructor
//							- Empty: {void}
//							- Constructor copy: other {Line}
function Line() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				location = undefined;
				size = undefined;
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
				
				if (argument_count > 0)
				{
					if (is_instanceof(argument[0], Line))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						location = ((is_instanceof(_other.location, Vector4))
									? new Vector4(_other.location) : _other.location);
						size = _other.size;
						
						switch (instanceof(_other.color))
						{
							case "Color4":
								color = new Color4(_other.color);
							break;
							
							case "Color2":
								color = new Color2(_other.color);
							break;
							
							default:
								color = _other.color;
							break;
						}
						
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
						//|Construction type: New constructor.
						location = argument[0];
						size = (((argument_count > 1) and (argument[1] != undefined)) ? argument[1]
																					  : 1);
						color = (((argument_count > 2) and (argument[2] != undefined)) ? argument[2] 
																					   : c_white);
						alpha = (((argument_count > 3) and (argument[3] != undefined)) ? argument[3]
																					   : 1);
					}
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_instanceof(location, Vector4)) and (location.isFunctional())
						and (is_real(size)));
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			object {int:object}
			/// @argument			precise? {bool}
			/// @argument			excludedInstance? {int:instance}
			/// @argument			list? {bool|List}
			/// @argument			listOrdered? {bool}
			/// @returns			{int|List}
			/// @description		Check for a collision within this Shape with instances of the
			///						specified object, treating the size of this Shape as 1.
			///						Returns the ID of a single colliding instance or noone.
			///						If List use is specified, a List will be returned instead, either
			///						empty or containing IDs of the colliding instances.
			///						If specified, the additions to that List can be ordered by 
			///						distance from the center of the Shape.
			static collision = function(_object, _precise = false, _excludedInstance, _list = false,
										_listOrdered = false)
			{
				var _list_created = false;
				
				try
				{
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
								collision_line_list(other.location.x1, other.location.y1,
													other.location.x2, other.location.y2,
													_object, _precise, true, _list.ID, _listOrdered);
							}
						}
						else
						{
							collision_line_list(location.x1, location.y1, location.x2, location.y2,
												_object, _precise, false, _list.ID, _listOrdered);
						}
					
						return _list;
					}
					else
					{
						if ((is_real(_excludedInstance)) and (instance_exists(_excludedInstance)))
						{
							with (_excludedInstance)
							{
								return collision_line(other.location.x1, other.location.y1,
													  other.location.x2, other.location.y2, _object,
													  _precise, true);
							}
						}
						else
						{
							return collision_line(location.x1, location.y1, location.x2, location.y2,
												  _object, _precise, false);
						}
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "collision()"], _exception);
					
					if (_list_created)
					{
						_list.destroy();
					}
				}
				
				return noone;
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			location? {Vector4}
			/// @argument			size? {real}
			/// @argument			color? {int:color|Color2|Color4}
			/// @argument			alpha? {real}
			/// @description		Execute the draw of this Shape as a sprite, using data of this
			///						constructor or specified replaced parts of it for this call only.
			static render = function(_location, _size, _color, _alpha)
			{
				static _pixel = function()
				{
					var _surface = surface_create(1, 1);
					surface_set_target(_surface);
					{
						draw_clear(c_white);
					}
					surface_reset_target();
					
					var _sprite = sprite_create_from_surface(_surface, 0, 0, 1, 1, false, false, 0, 0);
					surface_free(_surface);
					
					return _sprite;
				}();
				
				var _location_original = location;
				var _size_original = size;
				var _color_original = color;
				var _alpha_original = alpha;
				
				location = (_location ?? location);
				size = (_size ?? size);
				color = (_color ?? color);
				alpha = (_alpha ?? alpha);
				
				try
				{
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
													   ? method_get_index(_callback[_i])
													   : _callback[_i]);
								
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
						
						if ((alpha > 0) and (size != 0))
						{
							var _color1, _color2, _color3, _color4;
							
							switch (instanceof(color))
							{
								case "Color4":
									_color1 = color.color1;
									_color2 = color.color2;
									_color3 = color.color3;
									_color4 = color.color4;
								break;
								
								case "Color2":
									_color1 = color.color1;
									_color2 = color.color2;
									_color3 = color.color2;
									_color4 = color.color1;
								break;
								
								default:
									_color1 = color;
									_color2 = color;
									_color3 = color;
									_color4 = color;
								break;
							}
							
							var _sizeOffset = (size * 0.5);
							var _distance = point_distance(location.x1, location.y1, location.x2,
														   location.y2);
							var _angle = point_direction(location.x1, location.y1, location.x2,
														 location.y2);
							var _x1 = (location.x1 + lengthdir_x(_sizeOffset, (_angle + 90)));
							var _y1 = (location.y1 + lengthdir_y(_sizeOffset, (_angle + 90)));
							
							draw_sprite_general(_pixel, 0, 0, 0, 1, 1, _x1, _y1, _distance, size,
												_angle, _color1, _color2, _color3, _color4, alpha);
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
													   ? method_get_index(_callback[_i])
													   : _callback[_i]);
								
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
					location = _location_original;
					size = _size_original;
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
					_string = ("Location: " + string(location) + _mark_separator +
							   "Size: " + string(size));
				}
				else
				{
					var _string_color;
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
									 "Hue: " + string(color_get_hue(color)) + _mark_separator_inline +
									 "Saturation: " + string(color_get_saturation(color))
													+ _mark_separator_inline +
									 "Value: " + string(color_get_value(color)) +
									 ")");
								}
								else
								{
									_string_color =
									("(" +
									 "Red: " + string(color_get_red(color)) + _mark_separator_inline +
									 "Green: " + string(color_get_green(color))
											   + _mark_separator_inline +
									 "Blue: " + string(color_get_blue(color)) +
									 ")");
								}
							break;
						}
					}
					else
					{
						if (is_instanceof(color, Color2))
						{
							_string_color = color.toString(false, _colorHSV);
						}
						else
						{
							_string_color = string(color);
						}
					}
				
					_string = ("Location: " + string(location) + _mark_separator +
							   "Size: " + string(size) + _mark_separator +
							   "Color: " + _string_color + _mark_separator +
							   "Alpha: " + string(alpha));
				}
				
				return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
			}
			
			/// @returns			{VertexBuffer.PrimitiveRenderData} | On error: {undefined}
			/// @description		Return data formatted for rendering this Shape through a Vertex
			///						Buffer and the default passthrough Shader.
			static toVertexBuffer = function()
			{
				var _vertexBuffer = undefined;
				
				try
				{
					var _vertex = new Vector2();
					var _size = ((size > 0) ? (size * 0.5) : 0.5);
					var _color = ((is_real(color)) ? color : c_white);
					var _alpha = ((alpha > 0) ? alpha : 0);
					var _angle = point_direction(location.x1, location.y1, location.x2, location.y2);
					var _angle_left = (_angle - 90);
					var _angle_right = (_angle + 90);
					_vertexBuffer = new VertexBuffer();
					var _renderData = _vertexBuffer.createPrimitiveRenderData(pr_trianglestrip);
					
					_vertexBuffer
					 .setActive(_renderData.passthroughFormat)
						.setLocation(_vertex.set((location.x1 + lengthdir_x(_size, _angle_right)),
												 (location.y1 + lengthdir_y(_size, _angle_right))))
						.setColor(_color, _alpha)
						.setUV()
						
						.setLocation(_vertex.set((location.x2 + lengthdir_x(_size, _angle_right)),
												 (location.y2 + lengthdir_y(_size, _angle_right))))
						.setColor(_color, _alpha)
						.setUV()
						
						.setLocation(_vertex.set((location.x1 + lengthdir_x(_size, _angle_left)),
												 (location.y1 + lengthdir_y(_size, _angle_left))))
						.setColor(_color, _alpha)
						.setUV()
						
						.setLocation(_vertex.set((location.x2 + lengthdir_x(_size, _angle_left)),
												 (location.y2 + lengthdir_y(_size, _angle_left))))
						.setColor(_color, _alpha)
						.setUV()
					 .setActive(false);
					
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
				
				return undefined;
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static constructor = Line;
		
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
