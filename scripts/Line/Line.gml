//  @function			Line()
/// @argument			location {Vector4}
/// @argument			size? {real}
/// @argument			fill_color? {int:color|Color2|Color4}
/// @argument			fill_alpha? {real}
/// @argument			outline_size? {int}
/// @argument			outline_color? {int:color|Color4}
/// @argument			outline_alpha? {real}
/// @description		Constructs a two-dimensional Line Shape, which is a Rectangle rotated towards
///						middle points of its sides, from which it is extended by its specified size.
//						
//						Construction types:
//						- New constructor
//						- From Rectangle: rectangle {Rectangle}
//						- Empty: {void}
//						- Constructor copy: other {Line}
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
		fill_color = undefined;
		fill_alpha = undefined;
		outline_size = undefined;
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
			if (is_instanceof(argument[0], Line))
			{
				//|Construction type: Constructor copy.
				var _other = argument[0];
				
				location = ((is_instanceof(_other.location, Vector4)) ? new Vector4(_other.location)
																	  : _other.location);
				size = _other.size;
				
				if (is_instanceof(_other.fill_color, Color4))
				{
					fill_color = new Color4(_other.fill_color);
				}
				else if (is_instanceof(_other.fill_color, Color2))
				{
					fill_color = new Color2(_other.fill_color)
				}
				else
				{
					fill_color = _other.fill_color;
				}
				
				fill_alpha = _other.fill_alpha;
				outline_size = _other.outline_size;
				outline_color = ((is_instanceof(_other.outline_color, Color4))
								 ? new Color4(_other.outline_color) : _other.outline_color);
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
			else if (is_instanceof(argument[0], Rectangle))
			{
				//|Construction type: From Rectangle.
				var _rectangle = argument[0];
				
				if (is_instanceof(_rectangle.location, Vector4))
				{
					var _center_y = mean(_rectangle.location.y1, _rectangle.location.y2);
					
					location = new Vector4(_rectangle.location.x1, _center_y, _rectangle.location.x2,
										   _center_y);
					size = abs(_rectangle.location.y2 - _rectangle.location.y1);
				}
				else
				{
					location = _other.location;
					size = 1;
				}
				
				if (is_instanceof(_rectangle.fill_color, Color4))
				{
					fill_color = new Color4(_rectangle.fill_color);
				}
				else if (is_instanceof(_rectangle.fill_color, Color2))
				{
					fill_color = new Color2(_rectangle.fill_color);
				}
				else
				{
					fill_color = _rectangle.fill_color;
				}
				
				fill_alpha = _rectangle.fill_alpha;
				outline_size = _rectangle.outline_size;
				outline_color = ((is_instanceof(_rectangle.outline_color, Color4))
								 ? new Color4(_rectangle.outline_color) : _rectangle.outline_color);
				outline_alpha = _rectangle.outline_alpha;
				
				if (is_struct(_rectangle.event))
				{
					event.beforeRender.setAll(_rectangle.event.beforeRender);
					event.afterRender.setAll(_rectangle.event.afterRender);
				}
				else
				{
					event = _rectangle.event;
				}
			}
			else
			{
				//|Construction type: New constructor.
				location = argument[0];
				size = (((argument_count > 1) and (argument[1] != undefined)) ? argument[1] : 1);
				fill_color = (((argument_count > 2)) ? argument[2] : undefined);
				fill_alpha = (((argument_count > 3) and (argument[3] != undefined)) ? argument[3]
																					: 1);
				outline_size = (((argument_count > 4) and (argument[4] != undefined)) ? argument[4]
																					  : 0);
				outline_color = ((argument_count > 5) ? argument[5] : undefined);
				outline_alpha = (((argument_count > 6) and (argument[6] != undefined)) ? argument[6]
																					   : 1);
			}
		}
		
		return self;
	}
	
	/// @returns			{bool}
	/// @description		Check if this constructor is functional.
	static isFunctional = function()
	{
		return ((is_instanceof(location, Vector4)) and (location.isFunctional()) and (is_real(size)));
	}
	
   #endregion
   #region <Getters>
	
	/// @argument			other {Rectangle}
	/// @returns			{bool}
	/// @description		Check if specified constructor has equivalent properties.
	static equals = function(_other)
	{
		return ((is_instanceof(_other, Line)) and (size == _other.size) and
				(fill_alpha == _other.fill_alpha) and (outline_size == _other.outline_size) and
				(outline_alpha == _other.outline_alpha) and ((location == _other.location) or
				((string_copy(instanceof(location), 1, 6) == "Vector") and
				(location.equals(_other.location)))) and ((fill_color == _other.fill_color) or
				((string_copy(instanceof(fill_color), 1, 5) == "Color") and
				(fill_color.equals(_other.fill_color)))) and
				((outline_color == _other.outline_color) or
				 ((string_copy(instanceof(outline_color), 1, 5) == "Color") and
				 (outline_color.equals(_other.outline_color)))));
	}
	
	/// @argument			object {handle:object|handle:instance}
	/// @argument			precise? {bool}
	/// @argument			excludedInstance? {handle:instance}
	/// @argument			list? {bool|List}
	/// @argument			listOrdered? {bool}
	/// @returns			{handle:int|List}
	/// @description		Check for the presence of precise colision masks or bounding boxes of all
	///						instances of the specified object or a single specified instance, treating
	///						the size of this Shape as 1. An ID of any matching instance or {noone}
	///						will be returned, unless specified to return them in a List, in which case
	///						any matching IDs will be added at the end of it. These additions can be 
	///						pecified to be ordered by distance from the center of this Shape. An
	///						instance can be specified to exclude it from the result.
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
						collision_line_list(other.location.x1, other.location.y1, other.location.x2,
											other.location.y2, _object, _precise, true, _list.ID,
											_listOrdered);
					}
				}
				else
				{
					collision_line_list(location.x1, location.y1, location.x2, location.y2, _object,
										_precise, false, _list.ID, _listOrdered);
				}
			
				return _list;
			}
			else
			{
				if ((is_real(_excludedInstance)) and (instance_exists(_excludedInstance)))
				{
					with (_excludedInstance)
					{
						return collision_line(other.location.x1, other.location.y1, other.location.x2,
											  other.location.y2, _object, _precise, true);
					}
				}
				else
				{
					return collision_line(location.x1, location.y1, location.x2, location.y2, _object,
										  _precise, false);
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
	
	/// @argument			location? {Vector4}
	/// @argument			size? {real}
	/// @argument			outline? {bool|all}
	/// @argument			outline_size? {int}
	/// @argument			startWithCenter? {bool}
	/// @returns			{real[+]}
	/// @description		Return an array containing nested arrays with point locations, resulting
	///						in this Shape when connected. Up to two nested values will be returned in
	///						that array, depending on whether it was specified to return only data for
	///						outline, not return it and use only fill instead, or to contain all of
	///						this data. If fill is specified to be returned, it can also be specified
	///						to be built from its center.
	static getVertexLocation = function(_location = location, _size = size, _outline = false,
										_outline_size = outline_size, _startWithCenter = false)
	{
		var _result = [];
		
		try
		{
			var _angle = point_direction(_location.x1, _location.y1, _location.x2, _location.y2);
			var _angle_side = (_angle + 90);
			var _size_half = (_size * 0.5);
			var _location_topLeft = [(_location.x1 + lengthdir_x(_size_half, _angle_side)),
									 (_location.y1 + lengthdir_y(_size_half, _angle_side))];
			var _location_topRight = [(_location.x2 + lengthdir_x(_size_half, _angle_side)),
									  (_location.y2 + lengthdir_y(_size_half, _angle_side))];
			var _location_bottomLeft = [(_location.x1 - lengthdir_x(_size_half, _angle_side)),
										(_location.y1 - lengthdir_y(_size_half, _angle_side))];
			var _location_bottomRight = [(_location.x2 - lengthdir_x(_size_half, _angle_side)),
										 (_location.y2 - lengthdir_y(_size_half, _angle_side))];
			
			if ((!_outline) or (_outline == all))
			{
				if (_startWithCenter)
				{
					var _location_center = [mean(_location.x1, _location.x2),
											mean(_location.y1, _location.y2)];
					
					array_push(_result,
							   [_location_center, _location_topRight, _location_bottomRight,
								_location_center, _location_bottomRight, _location_bottomLeft,
								_location_center, _location_bottomLeft, _location_topLeft,
								_location_center, _location_topLeft, _location_topRight]);
				}
				else
				{
					array_push(_result,
							   [_location_topRight, _location_topLeft, _location_bottomRight,
								_location_bottomRight, _location_topLeft, _location_bottomLeft]);
				}
			}
			
			if ((_outline) or (_outline == all))
			{
				var _offset_outline = [lengthdir_x(_outline_size, _angle),
									   lengthdir_y(_outline_size, _angle)];
				var _offset_outline_side = [lengthdir_x(_outline_size, _angle_side),
											lengthdir_y(_outline_size, _angle_side)];
				var _outline_outerTopLeft = [(_location_topLeft[0] - _offset_outline[0] +
											  _offset_outline_side[0]),
											 (_location_topLeft[1] - _offset_outline[1] +
											  _offset_outline_side[1])];
				var _outline_outerTopRight = [(_location_topRight[0] + _offset_outline[0] +
											   _offset_outline_side[0]),
											  (_location_topRight[1] + _offset_outline[1] +
											  _offset_outline_side[1])];
				var _outline_outerBottomLeft = [(_location_bottomLeft[0] - _offset_outline[0] -
												 _offset_outline_side[0]),
												(_location_bottomLeft[1] - _offset_outline[1] -
												 _offset_outline_side[1])];
				var _outline_outerBottomRight = [(_location_bottomRight[0] + _offset_outline[0] -
												  _offset_outline_side[0]),
												 (_location_bottomRight[1] + _offset_outline[1] -
												  _offset_outline_side[1])];
				var _outline_outerTopInnerLeft = [(_location_topLeft[0] + _offset_outline_side[0]),
												  (_location_topLeft[1] + _offset_outline_side[1])];
				var _outline_innerTopOuterLeft = [(_location_topLeft[0] - _offset_outline[0]),
												  (_location_topLeft[1] - _offset_outline[1])];
				var _outline_outerTopInnerRight = [(_location_topRight[0] + _offset_outline_side[0]),
												   (_location_topRight[1] + _offset_outline_side[1])];
				var _outline_innerTopOuterRight = [(_location_topRight[0] + _offset_outline[0]),
												   (_location_topRight[1] + _offset_outline[1])];
				var _outline_outerBottomInnerLeft = [(_location_bottomLeft[0] -
													  _offset_outline_side[0]),
													 (_location_bottomLeft[1] -
													  _offset_outline_side[1])];
				var _outline_innerBottomOuterLeft = [(_location_bottomLeft[0] - _offset_outline[0]),
													 (_location_bottomLeft[1] - _offset_outline[1])];
				var _outline_outerBottomInnerRight = [(_location_bottomRight[0] -
													   _offset_outline_side[0]),
													  (_location_bottomRight[1] -
													   _offset_outline_side[1])];
				var _outline_innerBottomOuterRight = [(_location_bottomRight[0] + _offset_outline[0]),
													  (_location_bottomRight[1] +
													   _offset_outline[1])];
				
				array_push(_result,
						   [_outline_outerTopRight, _outline_outerTopInnerRight,
							_outline_innerTopOuterRight, _outline_innerTopOuterRight,
							_outline_outerTopInnerRight, _location_topRight,
							_outline_innerTopOuterRight, _location_topRight,
							_outline_innerBottomOuterRight, _outline_innerBottomOuterRight,
							_location_topRight, _location_bottomRight,
							_outline_innerBottomOuterRight, _location_bottomRight,
							_outline_outerBottomRight, _outline_outerBottomRight, 
							_location_bottomRight, _outline_outerBottomInnerRight,
							_location_bottomRight, _location_bottomLeft,
							_outline_outerBottomInnerRight, _outline_outerBottomInnerRight,
							_location_bottomLeft, _outline_outerBottomInnerLeft,
							_location_bottomLeft, _outline_innerBottomOuterLeft,
							_outline_outerBottomInnerLeft, _outline_outerBottomInnerLeft, 
							_outline_innerBottomOuterLeft, _outline_outerBottomLeft,
							_location_topLeft, _outline_innerTopOuterLeft,
							_location_bottomLeft,_location_bottomLeft,
							_outline_innerTopOuterLeft, _outline_innerBottomOuterLeft,
							_outline_outerTopInnerLeft, _outline_outerTopLeft,
							_location_topLeft, _location_topLeft,
							_outline_outerTopLeft, _outline_innerTopOuterLeft,
							_outline_outerTopInnerRight, _outline_outerTopInnerLeft,
							_location_topRight, _location_topRight,
							_outline_outerTopInnerLeft, _location_topLeft]);
			}
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "getVertexLocation()"], _exception);
		}
		
		return _result;
	}
	
	/// @argument			location? {Vector4}
	/// @argument			size? {real}
	/// @argument			fill_color? {int:color|Color2|Color4}
	/// @argument			fill_alpha? {real}
	/// @argument			outline_size? {int}
	/// @argument			outline_color? {int:color|Color4}
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
	static getPrimitiveRenderData = function(_location = location, _size = size,
											 _fill_color = fill_color, _fill_alpha = fill_alpha,
											 _outline_size = outline_size,
											 _outline_color = outline_color,
											 _outline_alpha = outline_alpha, _outline = all)
	{
		try
		{
			var _primitive = [];
			var _fill_color_isColor2 = is_instanceof(_fill_color, Color2);
			var _vertex_location = self.getVertexLocation(_location, _size, _outline, _outline_size,
														  _fill_color_isColor2);
			
			if (((!_outline) or (_outline == all)) and (_fill_color != undefined)
			and (_fill_alpha > 0))
			{
				var _vertex_data = undefined;
				var _vertex_fill = array_first(_vertex_location);
				var _color_fill_x1y1 = _fill_color;
				var _color_fill_x1y2 = _fill_color;
				var _color_fill_x2y1 = _fill_color;
				var _color_fill_x2y2 = _fill_color;
				
				if (_fill_color_isColor2)
				{
					_vertex_data = [[_vertex_fill[0], _fill_color.color1, _fill_alpha],
									[_vertex_fill[1], _fill_color.color2, _fill_alpha],
									[_vertex_fill[2], _fill_color.color2, _fill_alpha],
									[_vertex_fill[3], _fill_color.color1, _fill_alpha],
									[_vertex_fill[4], _fill_color.color2, _fill_alpha],
									[_vertex_fill[5], _fill_color.color2, _fill_alpha],
									[_vertex_fill[6], _fill_color.color1, _fill_alpha],
									[_vertex_fill[7], _fill_color.color2, _fill_alpha],
									[_vertex_fill[8], _fill_color.color2, _fill_alpha],
									[_vertex_fill[9], _fill_color.color1, _fill_alpha],
									[_vertex_fill[10], _fill_color.color2, _fill_alpha],
									[_vertex_fill[11], _fill_color.color2, _fill_alpha]];
				}
				else
				{
					if (is_instanceof(_fill_color, Color4))
					{
						_color_fill_x1y1 = _fill_color.color1;
						_color_fill_x1y2 = _fill_color.color4;
						_color_fill_x2y1 = _fill_color.color2;
						_color_fill_x2y2 = _fill_color.color3;
					}
					
					_vertex_data = [[_vertex_fill[0], _color_fill_x2y1, _fill_alpha],
									[_vertex_fill[1], _color_fill_x1y1, _fill_alpha],
									[_vertex_fill[2], _color_fill_x2y2, _fill_alpha],
									[_vertex_fill[3], _color_fill_x2y2, _fill_alpha],
									[_vertex_fill[4], _color_fill_x1y1, _fill_alpha],
									[_vertex_fill[5], _color_fill_x1y2, _fill_alpha]];
				}
				
				array_push(_primitive, [pr_trianglelist, _vertex_data]);
			}
			
			if (((_outline) or (_outline == all)) and (_outline_color != undefined)
			and (_outline_alpha > 0))
			{
				var _vertex_outline = array_last(_vertex_location);
				var _color_outline_x1y1 = _outline_color;
				var _color_outline_x1y2 = _outline_color;
				var _color_outline_x2y1 = _outline_color;
				var _color_outline_x2y2 = _outline_color;
				
				if (is_instanceof(_outline_color, Color4))
				{
					_color_outline_x1y1 = _outline_color.color1;
					_color_outline_x1y2 = _outline_color.color4;
					_color_outline_x2y1 = _outline_color.color2;
					_color_outline_x2y2 = _outline_color.color3;
				}
				
				var _vertex_data =
				[
					[_vertex_outline[0], _color_outline_x2y1, _outline_alpha],
					[_vertex_outline[1], _color_outline_x2y1, _outline_alpha],
					[_vertex_outline[2], _color_outline_x2y1, _outline_alpha],
					[_vertex_outline[3], _color_outline_x2y1, _outline_alpha],
					[_vertex_outline[4], _color_outline_x2y1, _outline_alpha],
					[_vertex_outline[5], _color_outline_x2y1, _outline_alpha],
					[_vertex_outline[6], _color_outline_x2y1, _outline_alpha],
					[_vertex_outline[7], _color_outline_x2y1, _outline_alpha],
					[_vertex_outline[8], _color_outline_x2y2, _outline_alpha],
					[_vertex_outline[9], _color_outline_x2y2, _outline_alpha],
					[_vertex_outline[10], _color_outline_x2y1, _outline_alpha],
					[_vertex_outline[11], _color_outline_x2y2, _outline_alpha],
					[_vertex_outline[12], _color_outline_x2y2, _outline_alpha],
					[_vertex_outline[13], _color_outline_x2y2, _outline_alpha],
					[_vertex_outline[14], _color_outline_x2y2, _outline_alpha],
					[_vertex_outline[15], _color_outline_x2y2, _outline_alpha],
					[_vertex_outline[16], _color_outline_x2y2, _outline_alpha],
					[_vertex_outline[17], _color_outline_x2y2, _outline_alpha],
					[_vertex_outline[18], _color_outline_x2y2, _outline_alpha],
					[_vertex_outline[19], _color_outline_x1y2, _outline_alpha],
					[_vertex_outline[20], _color_outline_x2y2, _outline_alpha],
					[_vertex_outline[21], _color_outline_x2y2, _outline_alpha],
					[_vertex_outline[22], _color_outline_x1y2, _outline_alpha],
					[_vertex_outline[23], _color_outline_x1y2, _outline_alpha],
					[_vertex_outline[24], _color_outline_x1y2, _outline_alpha],
					[_vertex_outline[25], _color_outline_x1y2, _outline_alpha],
					[_vertex_outline[26], _color_outline_x1y2, _outline_alpha],
					[_vertex_outline[27], _color_outline_x1y2, _outline_alpha],
					[_vertex_outline[28], _color_outline_x1y2, _outline_alpha],
					[_vertex_outline[29], _color_outline_x1y2, _outline_alpha],
					[_vertex_outline[30], _color_outline_x1y1, _outline_alpha],
					[_vertex_outline[31], _color_outline_x1y1, _outline_alpha],
					[_vertex_outline[32], _color_outline_x1y2, _outline_alpha],
					[_vertex_outline[33], _color_outline_x1y2, _outline_alpha],
					[_vertex_outline[34], _color_outline_x1y1, _outline_alpha],
					[_vertex_outline[35], _color_outline_x1y2, _outline_alpha],
					[_vertex_outline[36], _color_outline_x1y1, _outline_alpha],
					[_vertex_outline[37], _color_outline_x1y1, _outline_alpha],
					[_vertex_outline[38], _color_outline_x1y1, _outline_alpha],
					[_vertex_outline[39], _color_outline_x1y1, _outline_alpha],
					[_vertex_outline[40], _color_outline_x1y1, _outline_alpha],
					[_vertex_outline[41], _color_outline_x1y1, _outline_alpha],
					[_vertex_outline[42], _color_outline_x2y1, _outline_alpha],
					[_vertex_outline[43], _color_outline_x1y1, _outline_alpha],
					[_vertex_outline[44], _color_outline_x2y1, _outline_alpha],
					[_vertex_outline[45], _color_outline_x2y1, _outline_alpha],
					[_vertex_outline[46], _color_outline_x1y1, _outline_alpha],
					[_vertex_outline[47], _color_outline_x1y1, _outline_alpha],
				];
				
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
	
   #endregion
   #region <Execution>
	
	/// @argument			location? {Vector4}
	/// @argument			size? {int}
	/// @argument			fill_color? {int:color|Color2|Color4}
	/// @argument			fill_alpha? {real}
	/// @argument			outline_size? {int}
	/// @argument			outline_color? {int:color|Color4}
	/// @argument			outline_alpha? {real}
	/// @description		Execute the draw of this Shape as a primitive, using data of this
	///						constructor or specified temporarily replaced parts.
	static render = function(_location = location, _size = size, _fill_color = fill_color,
							 _fill_alpha = fill_alpha, _outline_size = outline_size,
							 _outline_color = outline_color, _outline_alpha = outline_alpha)
	{
		var _location_original = location;
		var _size_original = size;
		var _fill_color_original = fill_color;
		var _fill_alpha_original = fill_alpha;
		var _outline_color_original = outline_color;
		var _outline_alpha_original = outline_alpha;
		var _outline_size_original = outline_size;
		
		location = _location;
		size = _size;
		fill_color = _fill_color;
		fill_alpha = _fill_alpha;
		outline_color = _outline_color;
		outline_alpha = _outline_alpha;
		outline_size = _outline_size;
		
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
											  _vertex_data_current[1], _vertex_data_current[2]);
							
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
			size = _size_original;
			fill_color = _fill_color_original;
			fill_alpha = _fill_alpha_original;
			outline_color = _outline_color_original;
			outline_alpha = _outline_alpha_original;
			outline_size = _outline_size_original;
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
					_string_color[_i] = (((is_instanceof(_color[_i], Color4)) or
										  (is_instanceof(_color[_i], Color2)))
										 ? _color[_i].toString(false, _colorHSV)
										 : string(_color[_i]));
				}
				
				++_i;
			}
			
			_string = ("Location: " + string(location) + _mark_separator +
					   "Size: " + string(size) + _mark_separator +
					   "Fill Color: " + _string_color[0] + _mark_separator +
					   "Fill Alpha: " + string(fill_alpha) + _mark_separator +
					   "Outline Size: " + string(outline_size) + _mark_separator +
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
		var _location = ((is_instanceof(location, Vector4)) ? location.toArray() : location);
		var _fill_color = (((is_instanceof(fill_color, Color4)) or
							(is_instanceof(fill_color, Color2))) ? fill_color.toArray()
																 : fill_color);
		var _outline_color = ((is_instanceof(outline_color, Color4))
							  ? outline_color.toArray() : outline_color);
		
		return [_location, size, _fill_color, fill_alpha, outline_size, _outline_color,
				outline_alpha];
	}
	
	/// @argument			location? {Vector4}
	/// @argument			size? {real}
	/// @argument			fill_color? {int:color|Color2|Color4}
	/// @argument			fill_alpha? {real}
	/// @argument			outline_size? {int}
	/// @argument			outline_color? {int:color|Color4}
	/// @argument			outline_alpha? {real}
	/// @argument			outline? {bool|all}
	/// @argument			vertexBuffer? {VertexBuffer|VertexBuffer[]}
	/// @returns			{VertexBuffer.PrimitiveRenderData|VertexBuffer.PrimitiveRenderData[]} |
	///						On error: {undefined}
	/// @description		Return rendering data of this constructor in a Vertex Buffer, using its
	///						current data or specified temporarily replaced parts. Multiple values can
	///						be returned in an array, depending on whether it was specified to return
	///						only data for outline, use only fill instead or to return data for all
	///						parts. Data for invisible or invalid render will be excluded.
	static toVertexBuffer = function(_location = location, _size = size,
									 _fill_color = fill_color, _fill_alpha = fill_alpha,
									 _outline_size = outline_size, _outline_color = outline_color,
									 _outline_alpha = outline_alpha, _outline = all,
									 _vertexBuffer)
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
										 .createPrimitiveRenderData(pr_trianglelist));
			}
			
			if (((_outline) or (_outline == all)) and (_outline_color != undefined)
			and (_outline_alpha > 0) and (_outline_size >= 1))
			{
				if (!is_instanceof(_vertexBuffer_outline, VertexBuffer))
				{
					_vertexBuffer_outline = new VertexBuffer();
				}
				
				array_push(_renderData, _vertexBuffer_outline
										 .createPrimitiveRenderData(pr_trianglelist));
			}
			
			var _primitive = self.getPrimitiveRenderData(_location, _size, _fill_color, _fill_alpha,
														 _outline_size, _outline_color,
														 _outline_alpha, _outline);
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
