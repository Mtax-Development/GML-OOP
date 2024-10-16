//  @function				Triangle()
/// @argument				location1 {Vector2}
/// @argument				location2 {Vector2}
/// @argument				location3 {Vector2}
/// @argument				fill_color? {int:color|Color3}
/// @argument				fill_alpha? {real}
/// @argument				outline_color? {int:color|Color3}
/// @argument				outline_alpha? {real}
/// @description			Constructs a Triangle shape.
//							
//							Construction types:
//							- New constructor
//							- Empty: {void}
//							- Constructor copy: other {Triangle}
function Triangle() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				location1 = undefined;
				location2 = undefined;
				location3 = undefined;
				fill_color = undefined;
				fill_alpha = undefined;
				outline_color = undefined;
				outline_alpha = undefined;
				
				event =
				{
					beforeRender: new Callback(undefined, [], other),
					afterRender: new Callback(undefined, [], other)
				};
				
				if (argument_count > 0)
				{
					if (is_instanceof(argument[0], Triangle))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						location1 = ((is_instanceof(_other.location1, Vector2))
									 ? new Vector2(_other.location1) : _other.location1);
						location2 = ((is_instanceof(_other.location2, Vector2))
									 ? new Vector2(_other.location2) : _other.location2);
						location3 = ((is_instanceof(_other.location3, Vector2))
									 ? new Vector2(_other.location3) : _other.location3);
						fill_color = ((is_instanceof(_other.fill_color, Color3))
									  ? new Color3(_other.fill_color) : _other.fill_color);
						fill_alpha = _other.fill_alpha;
						outline_color = ((is_instanceof(_other.outline_color, Color3))
										 ? new Color3(_other.outline_color) : _other.outline_color);
						outline_alpha = _other.outline_alpha;
						
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
						location1 = argument[0];
						location2 = ((argument_count > 1) ? argument[1] : undefined);
						location3 = ((argument_count > 2) ? argument[2] : undefined);
						fill_color = ((argument_count > 3) ? argument[3] : undefined);
						fill_alpha = (((argument_count > 4) and (argument[4] != undefined))
									  ? argument[4] : 1);
						outline_color = ((argument_count > 5) ? argument[5] : undefined);
						outline_alpha = (((argument_count > 6) and (argument[6] != undefined))
										 ? argument[6] : 1);
					}
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return (((is_instanceof(location1, Vector2)) and (location1.isFunctional()))
						and ((is_instanceof(location2, Vector2)) and (location2.isFunctional()))
						and ((is_instanceof(location3, Vector2)) and (location3.isFunctional())));
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			point {Vector2}
			/// @returns			{bool}
			/// @description		Checks whether a point in space is within this Triangle.
			static containsPoint = function(_point)
			{
				try
				{
					return point_in_triangle(_point.x, _point.y, location1.x, location1.y, location2.x,
											location2.y, location3.x, location3.y);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "containsPoint()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			device? {int}
			/// @argument			GUI? {bool}
			/// @returns			{bool}
			/// @description		Check if the system cursor is over this Shape.
			///						If the device is specified, the position of the cursor on the GUI
			///						layer can be used.
			static cursorOver = function(_device, _GUI = false)
			{
				try
				{
					var _cursor_x, _cursor_y;
					
					if (_device == undefined)
					{
						_cursor_x = mouse_x;
						_cursor_y = mouse_y;
					}
					else
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
					
					return point_in_triangle(_cursor_x, _cursor_y, location1.x, location1.y,
											 location2.x, location2.y, location3.x, location3.y);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "cursorOver()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			button {constant:mb_*}
			/// @argument			device? {int}
			/// @argument			GUI? {bool}
			/// @returns			{bool}
			/// @description		Check if the system cursor is over this Shape while its specified
			///						mouse button is pressed or held.
			///						If the device is specified, the position of the cursor on the GUI
			///						layer can be used.
			static cursorHold = function(_button, _device, _GUI = false)
			{
				try
				{
					var _cursor_x, _cursor_y;
					
					if (_device == undefined)
					{
						_cursor_x = mouse_x;
						_cursor_y = mouse_y;
					}
					else
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
					
					if (point_in_triangle(_cursor_x, _cursor_y, location1.x, location1.y, location2.x,
										  location2.y, location3.x, location3.y))
					{	
						return ((_device == undefined) ? mouse_check_button(_button)
													   : device_mouse_check_button(_device, _button))
					}
					else
					{
						return false;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "cursorHold()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			button {constant:mb_*}
			/// @argument			device? {int}
			/// @argument			GUI? {bool}
			/// @returns			{bool}
			/// @description		Check if the system cursor is over this Shape while its specified
			///						mouse button was pressed in this frame.
			///						If the device is specified, the position of the cursor on the GUI
			///						layer can be used.
			static cursorPressed = function(_button, _device, _GUI = false)
			{
				try
				{
					var _cursor_x, _cursor_y;
					
					if (_device == undefined)
					{
						_cursor_x = mouse_x;
						_cursor_y = mouse_y;
					}
					else
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
					
					if (point_in_triangle(_cursor_x, _cursor_y, location1.x, location1.y, location2.x,
										  location2.y, location3.x, location3.y))
					{	
						return ((_device == undefined) ? mouse_check_button_pressed(_button)
													   : device_mouse_check_button_pressed(_device,
																						   _button))
					}
					else
					{
						return false;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "cursorPressed()"], _exception);
				}
				
				return false;
			}
			
			/// @argument			button {constant:mb_*}
			/// @argument			device? {int}
			/// @argument			GUI? {bool}
			/// @returns			{bool}
			/// @description		Check if the system cursor is over this Shape while the specified
			///						mouse button was released in this frame.
			///						If the device is specified, the position of the cursor on the GUI
			///						layer can be used.
			static cursorReleased = function(_button, _device, _GUI = false)
			{
				try
				{
					var _cursor_x, _cursor_y;
					
					if (_device == undefined)
					{
						_cursor_x = mouse_x;
						_cursor_y = mouse_y;
					}
					else
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
					
					if (point_in_triangle(_cursor_x, _cursor_y, location1.x, location1.y, location2.x,
										  location2.y, location3.x, location3.y))
					{	
						return ((_device == undefined) ? mouse_check_button_released(_button)
													   : device_mouse_check_button_released(_device,
																							_button))
					}
					else
					{
						return false;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "cursorReleased()"], _exception);
				}
				
				return false;
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			location1? {Vector2}
			/// @argument			location2? {Vector2}
			/// @argument			location3? {Vector2}
			/// @argument			fill_color? {int:color|Color3}
			/// @argument			fill_alpha? {real}
			/// @argument			outline_color? {int:color|Color3}
			/// @argument			outline_alpha? {real}
			/// @description		Execute the draw of this Shape as a form.
			///						NOTE: Form drawing produces inconsistent results across devices
			///						and export targets due to their technical differences.
			///						Sprite drawing should be used instead for accurate results.
			static render = function(_location1, _location2, _location3, _fill_color, _fill_alpha,
									 _outline_color, _outline_alpha)
			{
				var _location1_original = location1;
				var _location2_original = location2;
				var _location3_original = location3;
				var _fill_color_original = fill_color;
				var _fill_alpha_original = fill_alpha;
				var _outline_color_original = outline_color;
				var _outline_alpha_original = outline_alpha;
				
				location1 = (_location1 ?? location1);
				location2 = (_location2 ?? location2);
				location3 = (_location3 ?? location3);
				fill_color = (_fill_color ?? fill_color);
				fill_alpha = (_fill_alpha ?? fill_alpha);
				outline_color = (_outline_color ?? outline_color);
				outline_alpha = (_outline_alpha ?? outline_alpha);
				
				try
				{
					if (self.isFunctional())
					{
						event.beforeRender.execute();
						
						if ((fill_color != undefined) and (fill_alpha > 0))
						{
							var _color1, _color2, _color3;
							
							if (is_instanceof(fill_color, Color3))
							{
								_color1 = fill_color.color1;
								_color2 = fill_color.color2;
								_color3 = fill_color.color3;
							}
							else
							{
								_color1 = fill_color;
								_color2 = fill_color;
								_color3 = fill_color;
							}
							
							draw_set_alpha(fill_alpha);
							
							draw_triangle_color(location1.x, location1.y, location2.x, location2.y,
												location3.x, location3.y, _color1, _color2, _color3,
												false);
						}
						
						if ((outline_color != undefined) and (outline_alpha > 0))
						{
							var _color1, _color2, _color3;
							
							if (is_instanceof(outline_color, Color3))
							{
								_color1 = outline_color.color1;
								_color2 = outline_color.color2;
								_color3 = outline_color.color3;
							}
							else
							{
								var _color1 = outline_color;
								var _color2 = outline_color;
								var _color3 = outline_color;
							}
							
							draw_set_alpha(outline_alpha);
							
							draw_triangle_color(location1.x, location1.y, location2.x, location2.y,
												location3.x, location3.y, _color1, _color2, _color3,
												true);
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
					location1 = _location1_original;
					location2 = _location2_original;
					location3 = _location3_original;
					fill_color = _fill_color_original;
					fill_alpha = _fill_alpha_original;
					outline_color = _outline_color_original;
					outline_alpha = _outline_alpha_original;
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
				var _mark_separator_inline = ", ";
				
				if (!_full)
				{
					_string = ("Location: " + "(" + string(location1) + _mark_separator_inline
											+ string(location2) + _mark_separator_inline
											+ string(location3) + ")");
				}
				else
				{
					var _color = [fill_color, outline_color];
					var _color_count = array_length(_color);
					var _string_color = array_create(_color_count, "");
					var _mark_separator = ((_multiline) ? "\n" : ", ");
					
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
												 + _mark_separator_inline +
										 "Green: " + string(color_get_green(_color[_i]))
												   + _mark_separator_inline +
										 "Blue: " + string(color_get_blue(_color[_i])) +
										 ")");
									}
								break;
							}
						}
						else
						{
							if (is_instanceof(_color[_i], Color3))
							{
								_string_color[_i] = _color[_i].toString(false, _colorHSV);
							}
							else
							{
								_string_color[_i] = string(_color[_i]);
							}
						}
						
						++_i;
					}
					
					_string = ("Location: " + "(" + string(location1) + _mark_separator_inline
											+ string(location2) + _mark_separator_inline
											+ string(location3) + ")" + _mark_separator +
							   "Fill Color: " + _string_color[0] + _mark_separator +
							   "Fill Alpha: " + string(fill_alpha) + _mark_separator +
							   "Outline Color: " + _string_color[1] + _mark_separator +
							   "Outline Alpha: " + string(outline_alpha));
				}
				
				return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
			}
			
			/// @argument			outline? {bool|all}
			/// @argument			location1? {Vector2}
			/// @argument			location2? {Vector2}
			/// @argument			location3? {Vector2}
			/// @argument			fill_color? {int:color|Color3}
			/// @argument			fill_alpha? {real}
			/// @argument			outline_color? {int:color|Color3}
			/// @argument			outline_alpha? {real}
			/// @returns			{VertexBuffer.PrimitiveRenderData|
			///						 VertexBuffer.PrimitiveRenderData[]} | On error: {undefined}
			/// @description		Return rendering data of this constructor in a Vertex Buffer, using
			///						its current data or its specified temporarily replaced parts.
			///						Either a single value or an array of two values will be returned,
			///						depending on whether the fill or outline were specified as the only
			///						returned value or both as {all}.
			static toVertexBuffer = function(_outline = false, _location1, _location2, _location3,
											 _fill_color, _fill_alpha, _outline_color, _outline_alpha)
			{
				var _vertexBuffer_fill = undefined;
				var _vertexBuffer_outline = undefined;
				var _location1_original = location1;
				var _location2_original = location2;
				var _location3_original = location3;
				var _fill_color_original = fill_color;
				var _fill_alpha_original = fill_alpha;
				var _outline_color_original = outline_color;
				var _outline_alpha_original = outline_alpha;
				
				location1 = (_location1 ?? location1);
				location2 = (_location2 ?? location2);
				location3 = (_location3 ?? location3);
				fill_color = (_fill_color ?? fill_color);
				fill_alpha = (_fill_alpha ?? fill_alpha);
				outline_color = (_outline_color ?? outline_color);
				outline_alpha = (_outline_alpha ?? outline_alpha);
				
				try
				{
					var _result = [];
					
					if ((!_outline) or (_outline == all))
					{
						fill_color = ((is_real(fill_color)) ? fill_color : c_white);
						fill_alpha = ((fill_alpha > 0) ? fill_alpha : 0);
						_vertexBuffer_fill = new VertexBuffer();
						var _renderData_fill = _vertexBuffer_fill
												.createPrimitiveRenderData(pr_trianglestrip);
						
						_vertexBuffer_fill
						 .setActive(_renderData_fill.passthroughFormat)
							.setLocation(location1)
							.setColor(fill_color, fill_alpha)
							.setUV()
							
							.setLocation(location2)
							.setColor(fill_color, fill_alpha)
							.setUV()
							
							.setLocation(location3)
							.setColor(fill_color, fill_alpha)
							.setUV()
						 .setActive(false);
						
						array_push(_result, _renderData_fill);
					}
					
					if ((_outline) or (_outline == all))
					{
						outline_color = ((is_real(outline_color)) ? outline_color : c_white);
						outline_alpha = ((outline_alpha > 0) ? outline_alpha : 0);
						_vertexBuffer_outline = new VertexBuffer();
						var _renderData_outline = _vertexBuffer_outline
												   .createPrimitiveRenderData(pr_linestrip);
						
						_vertexBuffer_outline
						 .setActive(_renderData_outline.passthroughFormat)
							.setLocation(location1)
							.setColor(outline_color, outline_alpha)
							.setUV()
							
							.setLocation(location2)
							.setColor(outline_color, outline_alpha)
							.setUV()
							
							.setLocation(location3)
							.setColor(outline_color, outline_alpha)
							.setUV()
							
							.setLocation(location1)
							.setColor(outline_color, outline_alpha)
							.setUV()
						 .setActive(false);
						 
						 array_push(_result, _renderData_outline);
					}
					
					return ((array_length(_result) == 1) ? _result[0] : _result);
				}
				catch (_exception)
				{
					if (_vertexBuffer_fill != undefined)
					{
						_vertexBuffer_fill.destroy();
					}
					
					if (_vertexBuffer_outline != undefined)
					{
						_vertexBuffer_outline.destroy();
					}
					
					new ErrorReport().report([other, self, "toVertexBuffer()"], _exception);
				}
				finally
				{
					location1 = _location1_original;
					location2 = _location2_original;
					location3 = _location3_original;
					fill_color = _fill_color_original;
					fill_alpha = _fill_alpha_original;
					outline_color = _outline_color_original;
					outline_alpha = _outline_alpha_original;
				}
				
				return undefined;
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static constructor = Triangle;
		
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
