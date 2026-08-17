//  @function			Triangle()
/// @argument			location1 {Vector2}
/// @argument			location2 {Vector2}
/// @argument			location3 {Vector2}
/// @argument			fill_color? {int:color|Color3}
/// @argument			fill_alpha? {real}
/// @argument			outline_scale? {real}
/// @argument			outline_color? {int:color|Color3}
/// @argument			outline_alpha? {real}
/// @description		Constructs a two-dimensional Triangle Shape, connecting three specified
///						points. The size of its outline is specified by scaled proportionally to the
///						fill, enlarging it without altering its proportions.
//						
//						Construction types:
//						- New constructor
//						- Empty: {void}
//						- Constructor copy: other {Triangle}
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
		outline_scale = undefined;
		outline_color = undefined;
		outline_alpha = undefined;
		
		var _scope = self;
		event =
		{
			beforeRender: new Callback(undefined, [], _scope),
			afterRender: new Callback(undefined, [], _scope),
			getPrimitiveRenderData: new Callback
			(
				function(_data)
				{
					return _data;
				},
				
				[], _scope
			),
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
				outline_scale = _other.outline_scale;
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
				fill_alpha = (((argument_count > 4) and (argument[4] != undefined)) ? argument[4]
																					: 1);
				outline_scale = ((argument_count > 5) ? argument[5] : 0);
				outline_color = ((argument_count > 6) ? argument[6] : undefined);
				outline_alpha = (((argument_count > 7) and (argument[7] != undefined)) ? argument[7]
																					   : 1);
			}
		}
		
		return self;
	}
	
	/// @returns			{bool}
	/// @description		Check if this constructor is functional.
	static isFunctional = function()
	{
		return (((is_instanceof(location1, Vector2)) and (location1.isFunctional())) and
				((is_instanceof(location2, Vector2)) and (location2.isFunctional())) and
				((is_instanceof(location3, Vector2)) and (location3.isFunctional())));
	}
	
   #endregion
   #region <Getters>
	
	/// @argument			other {Triangle}
	/// @returns			{bool}
	/// @description		Check if specified constructor has equivalent properties.
	static equals = function(_other)
	{
		return ((is_instanceof(_other, Triangle)) and (fill_alpha == _other.fill_alpha) and
				(outline_scale == _other.outline_scale) and
				(outline_alpha == _other.outline_alpha) and
				((location1 == _other.location1) or
				 ((string_copy(instanceof(location1), 1, 6) == "Vector") and
				 (location1.equals(_other.location1)))) and
				((location2 == _other.location2) or
				 ((string_copy(instanceof(location2), 1, 6) == "Vector") and
				 (location2.equals(_other.location2)))) and
				((location3 == _other.location3) or
				 ((string_copy(instanceof(location3), 1, 6) == "Vector") and
				 (location3.equals(_other.location3)))) and
				((fill_color == _other.fill_color) or
				 ((string_copy(instanceof(fill_color), 1, 5) == "Color") and
				 (fill_color.equals(_other.fill_color)))) and
				((outline_color == _other.outline_color) or
				 ((string_copy(instanceof(outline_color), 1, 5) == "Color") and
				 (outline_color.equals(_other.outline_color)))));
	}
	
	/// @argument			point {Vector2}
	/// @argument			includeOutline? {bool}
	/// @returns			{bool}
	/// @description		Checks whether a point in space is within this Shape. Its location can
	///						include the outer edge of the outline if specified.
	static containsPoint = function(_point, _includeOutline = false)
	{
		try
		{
			var _location1 = location1;
			var _location2 = location2;
			var _location3 = location3;
			
			if (_includeOutline)
			{
				var _location_outline = self.getOutlineLocation();
				
				_location1 = _location_outline[0];
				_location2 = _location_outline[1];
				_location3 = _location_outline[2];
			}
			
			return point_in_triangle(_point.x, _point.y, _location1.x, _location1.y, _location2.x,
									 _location2.y, _location3.x, _location3.y);
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
	/// @description		Check if the system cursor location is over this Shape. The location of
	///						this Shape can include the outer edge of its outline if specified. A
	///						target device can be specified for use with multiple cursor input sources.
	///						In that case, its position can also be specified to be calculated
	///						according to current GUI layer size.
	static cursorOver = function(_device, _GUI = false, _includeOutline = false)
	{
		try
		{
			var _location1 = location1;
			var _location2 = location2;
			var _location3 = location3;
			var _cursor_x = mouse_x;
			var _cursor_y = mouse_y;
			
			if (_includeOutline)
			{
				var _location_outline = self.getOutlineLocation();
				
				_location1 = _location_outline[0];
				_location2 = _location_outline[1];
				_location3 = _location_outline[2];
			}
			
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
			
			return point_in_triangle(_cursor_x, _cursor_y, _location1.x, _location1.y, _location2.x,
									 _location2.y, _location3.x, _location3.y);
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
	/// @description		Check if the system cursor location is over this Shape while its specified
	///						input is being held this frame. The location of this Shape can include the
	///						outer edge of its outline if specified. A target device can be specified
	///						for use with multiple cursor input sources. In that case, its position can
	///						also be specified to be calculated according to current GUI layer size.
	static cursorHold = function(_button, _device, _GUI = false, _includeOutline = false)
	{
		try
		{
			var _location1 = location1;
			var _location2 = location2;
			var _location3 = location3;
			var _cursor_x = mouse_x;
			var _cursor_y = mouse_y;
			
			if (_includeOutline)
			{
				var _location_outline = self.getOutlineLocation();
				
				_location1 = _location_outline[0];
				_location2 = _location_outline[1];
				_location3 = _location_outline[2];
			}
			
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
			
			if (point_in_triangle(_cursor_x, _cursor_y, _location1.x, _location1.y, _location2.x,
								  _location2.y, _location3.x, _location3.y))
			{
				return ((_device == undefined) ? mouse_check_button(_button)
											   : device_mouse_check_button(_device, _button));
			}
			else
			{
				return false;
			}
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "cursorHold()"], _exception);
		}
		
		return false;
	}
	
	/// @argument			button {constant:mb_*}
	/// @argument			device? {int}
	/// @argument			GUI? {bool}
	/// @argument			includeOutline? {bool}
	/// @returns			{bool}
	//  @see				display_set_gui_size()
	/// @description		Check if the system cursor location is over this Shape while its specified
	///						input was pressed this frame. The location of this Shape can include the
	///						outer edge of its outline if specified. A target device can be specified
	///						for use with multiple cursor input sources. In that case, its position can
	///						also be specified to be calculated according to current GUI layer size.
	static cursorPressed = function(_button, _device, _GUI = false, _includeOutline = false)
	{
		try
		{
			var _location1 = location1;
			var _location2 = location2;
			var _location3 = location3;
			var _cursor_x = mouse_x;
			var _cursor_y = mouse_y;
			
			if (_includeOutline)
			{
				var _location_outline = self.getOutlineLocation();
				
				_location1 = _location_outline[0];
				_location2 = _location_outline[1];
				_location3 = _location_outline[2];
			}
			
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
			
			if (point_in_triangle(_cursor_x, _cursor_y, _location1.x, _location1.y, _location2.x,
								  _location2.y, _location3.x, _location3.y))
			{
				return ((_device == undefined) ? mouse_check_button_pressed(_button)
											   : device_mouse_check_button_pressed(_device, _button));
			}
			else
			{
				return false;
			}
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
	/// @description		Check if the system cursor location is over this Shape while its specified
	///						input was released this frame. The location of this Shape can include the
	///						outer edge of its outline if specified. A target device can be specified
	///						for use with multiple cursor input sources. In that case, its position can
	///						also be specified to be calculated according to current GUI layer size.
	static cursorReleased = function(_button, _device, _GUI = false, _includeOutline = false)
	{
		try
		{
			var _location1 = location1;
			var _location2 = location2;
			var _location3 = location3;
			var _cursor_x = mouse_x;
			var _cursor_y = mouse_y;
			
			if (_includeOutline)
			{
				var _location_outline = self.getOutlineLocation();
				
				_location1 = _location_outline[0];
				_location2 = _location_outline[1];
				_location3 = _location_outline[2];
			}
			
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
			
			if (point_in_triangle(_cursor_x, _cursor_y, _location1.x, _location1.y, _location2.x,
								  _location2.y, _location3.x, _location3.y))
			{
				return ((_device == undefined) ? mouse_check_button_released(_button)
											   : device_mouse_check_button_released(_device,
																					_button));
			}
			else
			{
				return false;
			}
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "cursorReleased()"], _exception);
		}
		
		return false;
	}
	
	/// @argument			location? {Vector4}
	/// @argument			outline? {bool|all}
	/// @argument			outline_scale? {real}
	/// @returns			{real[+]}
	/// @description		Return an array containing nested arrays with point locations, resulting
	///						in this Shape when connected. Up to two nested values will be returned in
	///						that array, depending on whether it was specified to return only data for
	///						outline, not return it and use only fill instead, or to contain all of
	///						this data.
	static getVertexLocation = function(_location1 = location1, _location2 = location2,
										_location3 = location3, _outline = false,
										_outline_scale = outline_scale)
	{
		var _result = [];
		
		try
		{
			if ((!_outline) or (_outline == all))
			{
				array_push(_result,
						   [[_location1.x, _location1.y], [_location2.x, _location2.y],
							[_location3.x, _location3.y]]);
			}
			
			if ((_outline) or (_outline == all))
			{
				var _outline_location = self.getOutlineLocation(_location1, _location2, _location3,
																_outline_scale);
				var _outline1 = _outline_location[0];
				var _outline2 = _outline_location[1];
				var _outline3 = _outline_location[2];
				
				array_push(_result,
						   [[_outline1.x, _outline1.y], [_outline2.x, _outline2.y],
							[_location1.x, _location1.y], [_location1.x, _location1.y],
							[_outline2.x, _outline.y], [_location2.x, _location2.y],
							
							[_location3.x, _location3.y], [_location2.x, _location2.y],
							[_outline3.x, _outline3.y], [_outline3.x, _outline3.y],
							[_location2.x, _location2.y], [_outline2.x, _outline2.y],
							
							[_outline3.x, _outline3.y], [_outline1.x, _outline1.y],
							[_location3.x, _location3.y], [_location3.x, _location3.y],
							[_outline1.x, _outline1.y], [_location1.x, _location1.y]]);
			}
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "getVertexLocation()"], _exception);
		}
		
		return _result;
	}
	
	/// @argument			location1? {Vector2}
	/// @argument			location2? {Vector2}
	/// @argument			location3? {Vector2}
	/// @argument			fill_color? {int:color|Color3}
	/// @argument			fill_alpha? {real}
	/// @argument			outline_scale? {real}
	/// @argument			outline_color? {int:color|Color3}
	/// @argument			outline_alpha? {real}
	/// @argument			outline? {bool|all}
	/// @returns			{any[+]} | On error: {undefined}
	//  @see				getVertexLocation()
	/// @description		Return an array containg rendering data for each vertex resulting in this
	///						Shape, consisting of its primitive type, location, color and alpha value,
	///						based on the data of this constructor or its specified replaced parts. Up
	///						to two nested values will be returned in that array, depending on whether
	///						it was specified to return only data for outline, not return it and use
	///						only fill instead, or to contain all of this data. Each will be
	///						represented at following array positions, nested in the primary array:
	///						- array[0]: primitive type {constant:pr_*}
	///						- array[1]: vertex data {any[]}
	///						  - array[1][0]: location {real[]}
	///						  - array[1][1]: color {int:color}
	///						  - array[1][2]: alpha {real}
	static getPrimitiveRenderData = function(_location1 = location1, _location2 = location2,
											 _location3 = location3, _fill_color = fill_color,
											 _fill_alpha = fill_alpha, _outline_scale = outline_scale,
											 _outline_color = outline_color,
											 _outline_alpha = outline_alpha, _outline = all)
	{
		try
		{
			var _primitive = [];
			var _fill_color_isColor2 = is_instanceof(_fill_color, Color2);
			var _vertex_location = self.getVertexLocation(_location1, _location2, _location3,
														  _outline, _outline_scale);
			
			if (((!_outline) or (_outline == all)) and (_fill_color != undefined)
			and (_fill_alpha > 0))
			{
				var _vertex_fill = array_first(_vertex_location);
				var _fill_color1 = _fill_color;
				var _fill_color2 = _fill_color;
				var _fill_color3 = _fill_color;
				
				if (is_instanceof(_fill_color, Color3))
				{
					_fill_color1 = _fill_color.color1;
					_fill_color2 = _fill_color.color2;
					_fill_color3 = _fill_color.color3;
				}
				
				var _vertex_data = [[_vertex_fill[0], _fill_color1, _fill_alpha],
									[_vertex_fill[1], _fill_color2, _fill_alpha],
									[_vertex_fill[2], _fill_color3, _fill_alpha]];
				
				array_push(_primitive, [pr_trianglelist, _vertex_data]);
			}
			
			if (((_outline) or (_outline == all)) and (_outline_color != undefined)
			and (_outline_alpha > 0))
			{
				var _vertex_outline = array_last(_vertex_location);
				var _outline_color1 = _outline_color;
				var _outline_color2 = _outline_color;
				var _outline_color3 = _outline_color;
				
				if (is_instanceof(_outline_color, Color3))
				{
					_outline_color1 = _outline_color.color1;
					_outline_color2 = _outline_color.color2;
					_outline_color3 = _outline_color.color3;
				}
				
				var _vertex_data = [[_vertex_outline[0], _outline_color1, _outline_alpha],
									[_vertex_outline[1], _outline_color2, _outline_alpha],
									[_vertex_outline[2], _outline_color1, _outline_alpha],
									[_vertex_outline[3], _outline_color1, _outline_alpha],
									[_vertex_outline[4], _outline_color2, _outline_alpha],
									[_vertex_outline[5], _outline_color2, _outline_alpha],
									
									[_vertex_outline[6], _outline_color3, _outline_alpha],
									[_vertex_outline[7], _outline_color2, _outline_alpha],
									[_vertex_outline[8], _outline_color3, _outline_alpha],
									[_vertex_outline[9], _outline_color3, _outline_alpha],
									[_vertex_outline[10], _outline_color2, _outline_alpha],
									[_vertex_outline[11], _outline_color2, _outline_alpha],
									
									[_vertex_outline[12], _outline_color3, _outline_alpha],
									[_vertex_outline[13], _outline_color1, _outline_alpha],
									[_vertex_outline[14], _outline_color3, _outline_alpha],
									[_vertex_outline[15], _outline_color3, _outline_alpha],
									[_vertex_outline[16], _outline_color1, _outline_alpha],
									[_vertex_outline[17], _outline_color1, _outline_alpha]];
				
				array_push(_primitive, [pr_trianglelist, _vertex_data]);
			}
			
			return event.getPrimitiveRenderData.execute(undefined, [_primitive]);
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "getPrimitiveRenderData()"], _exception);
		}
		
		return undefined;
	}
	
	/// @argument			location1? {Vector2}
	/// @argument			location2? {Vector2}
	/// @argument			location3? {Vector2}
	/// @argument			outline_scale? {real}
	/// @returns			{Vector2[]}
	/// @description		Return the locations of outer edge of the outline, using data of this
	///						constructor or specified temporarily replaced parts.
	static getOutlineLocation = function(_location1 = location1, _location2 = location2,
										 _location3 = location3, _outline_scale = outline_scale)
	{
		try
		{
			var _center_x = mean(_location1.x, _location2.x, _location3.x);
			var _center_y = mean(_location1.y, _location2.y, _location3.y);
			var _outline_x1 = (_center_x + ((_location1.x - _center_x) * _outline_scale));
			var _outline_y1 = (_center_y + ((_location1.y - _center_y) * _outline_scale));
			var _outline_x2 = (_center_x + ((_location2.x - _center_x) * _outline_scale));
			var _outline_y2 = (_center_y + ((_location2.y - _center_y) * _outline_scale));
			var _outline_x3 = (_center_x + ((_location3.x - _center_x) * _outline_scale));
			var _outline_y3 = (_center_y + ((_location3.y - _center_y) * _outline_scale));
			
			return [new Vector2(_outline_x1, _outline_y1), new Vector2(_outline_x2, _outline_y2),
					new Vector2(_outline_x3, _outline_y3)];
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "getOutlineLocation()"], _exception);
		}
		
		return undefined;
	}
	
   #endregion
   #region <Execution>
	
	/// @argument			location1? {Vector2}
	/// @argument			location2? {Vector2}
	/// @argument			location3? {Vector2}
	/// @argument			fill_color? {int:color|Color3}
	/// @argument			fill_alpha? {real}
	/// @argument			outline_scale? {real}
	/// @argument			outline_color? {int:color|Color3}
	/// @argument			outline_alpha? {real}
	/// @description		Execute the draw of this Shape as a primitive, using data of this
	///						constructor or specified temporarily replaced parts.
	static render = function(_location1 = location1, _location2 = location2, _location3 = location3,
							 _fill_color = fill_color, _fill_alpha = fill_alpha,
							 _outline_scale = outline_scale, _outline_color = outline_color,
							 _outline_alpha = outline_alpha)
	{
		var _location1_original = location1;
		var _location2_original = location2;
		var _location3_original = location3;
		var _fill_color_original = fill_color;
		var _fill_alpha_original = fill_alpha;
		var _outline_scale_original = outline_scale;
		var _outline_color_original = outline_color;
		var _outline_alpha_original = outline_alpha;
		
		location1 = _location1;
		location2 = _location2;
		location3 = _location3;
		fill_color = _fill_color;
		fill_alpha = _fill_alpha;
		outline_scale = _outline_scale;
		outline_color = _outline_color;
		outline_alpha = _outline_alpha;
		
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
					_string_color[_i] = ((is_instanceof(_color[_i], Color3))
										 ? _color[_i].toString(false, _colorHSV)
										 : string(_color[_i]));
				}
				
				++_i;
			}
			
			_string = ("Location: " + "(" + string(location1) + _mark_separator_inline
										  + string(location2) + _mark_separator_inline
										  + string(location3) + ")" + _mark_separator +
					   "Fill Color: " + _string_color[0] + _mark_separator +
					   "Fill Alpha: " + string(fill_alpha) + _mark_separator +
					   "Outline Scale: " + string(outline_scale) + _mark_separator +
					   "Outline Color: " + _string_color[1] + _mark_separator +
					   "Outline Alpha: " + string(outline_alpha));
		}
		
		return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
	}
	
	/// @returns			{real[+]}
	/// @description		Return an array containing values of all properties of this Shape.
	///						Properties with multiple values will be returned in nested arrays.
	static toArray = function()
	{
		var _location1 = ((is_instanceof(location1, Vector4)) ? location1.toArray() : location1);
		var _location2 = ((is_instanceof(location2, Vector4)) ? location2.toArray() : location2);
		var _location3 = ((is_instanceof(location3, Vector4)) ? location3.toArray() : location3);
		var _fill_color = ((is_instanceof(fill_color, Color3)) ? fill_color.toArray() : fill_color);
		var _outline_color = ((is_instanceof(outline_color, Color4)) ? outline_color.toArray()
																	 : outline_color);
		
		return [_location1, _location2, _location3, _fill_color, fill_alpha, outline_scale,
				_outline_color, outline_alpha];
	}
	
	/// @argument			location1? {Vector2}
	/// @argument			location2? {Vector2}
	/// @argument			location3? {Vector2}
	/// @argument			fill_color? {int:color|Color3}
	/// @argument			fill_alpha? {real}
	/// @argument			outline_scale? {real}
	/// @argument			outline_color? {int:color|Color3}
	/// @argument			outline_alpha? {real}
	/// @argument			outline? {bool|all}
	/// @argument			vertexBuffer? {VertexBuffer|VertexBuffer[]}
	/// @returns			{VertexBuffer.PrimitiveRenderData|
	///						 VertexBuffer.PrimitiveRenderData[]} | On error: {undefined}
	/// @description		Return rendering data of this constructor in a Vertex Buffer, using its
	///						current data or specified temporarily replaced parts. Multiple values can
	///						be returned in an array if separate Vertex Buffers were specified for fill
	///						and outline. Data for invisible or invalid render will be excluded.
	static toVertexBuffer = function(_location1 = location1, _location2 = location2,
									 _location3 = location3, _fill_color = fill_color,
									 _fill_alpha = fill_alpha, _outline_scale = outline_scale,
									 _outline_color = outline_color, _outline_alpha = outline_alpha,
									 _outline = all, _vertexBuffer)
	{
		var _vertexBuffer_fill = undefined;
		var _vertexBuffer_outline = undefined;
		
		try
		{
			var _renderData = [];
			var _vertexBuffer_wasActive = [false, false];
			
			if (_vertexBuffer != undefined)
			{
				if (_outline == all)
				{
					if (is_array(_vertexBuffer))
					{
						_vertexBuffer_fill = _vertexBuffer[0];
						_vertexBuffer_outline = _vertexBuffer[1];
					}
					else
					{
						_vertexBuffer_fill = _vertexBuffer;
						_vertexBuffer_outline = _vertexBuffer;
					}
					
					_vertexBuffer_wasActive = [_vertexBuffer_fill.active,
											   _vertexBuffer_outline.active];
				}
				else if (_outline)
				{
					_vertexBuffer_outline = _vertexBuffer;
					_vertexBuffer_wasActive = [_vertexBuffer_outline.active];
				}
				else
				{
					_vertexBuffer_fill = _vertexBuffer;
					_vertexBuffer_wasActive = [_vertexBuffer_fill.active];
				}
			}
			else
			{
				_vertexBuffer_fill = new VertexBuffer();
				_vertexBuffer_outline = _vertexBuffer_fill;
			}
			
			if (((!_outline) or (_outline == all)) and (_fill_color != undefined)
			and (_fill_alpha > 0))
			{
				array_push(_renderData, _vertexBuffer_fill
										 .createPrimitiveRenderData(pr_trianglelist));
			}
			
			if (((_outline) or (_outline == all)) and (_outline_color != undefined)
			and (_outline_alpha > 0) and (_outline_scale >= 1))
			{
				array_push(_renderData, _vertexBuffer_outline
										 .createPrimitiveRenderData(pr_trianglelist));
			}
			
			var _primitive = self.getPrimitiveRenderData(_location1, _location2, _location3,
														 _fill_color, _fill_alpha, _outline_scale,
														 _outline_color, _outline_alpha, _outline);
			var _primitive_count = array_length(_primitive);
			var _vertex = new Vector2();
			var _i = [0, 0];
			repeat (_primitive_count)
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
				
				++_i[0];
			}
			
			var _i = 0;
			repeat (_primitive_count)
			{
				if (!_vertexBuffer_wasActive[_i])
				{
					_renderData[_i].vertexBuffer.setActive(false);
				}
				
				++_i;
			}
			
			return ((_vertexBuffer_fill == _vertexBuffer_outline) or
					(array_length(_renderData) == 1) ? _renderData[0] : _renderData);
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
