//  @function			Cube()
/// @argument			location {Vector3}
/// @argument			scale {Vector3}
/// @argument			angle? {EulerAngle}
/// @argument			sprite? {Sprite}
/// @argument			color? {int:color|int:color[]}
/// @argument			alpha? {real|real[]}
/// @description		Constructs a three-dimensional Cube Shape, made of six rectangular sides. The
///						specified location is its center, from where it is then scaled.
//						
//						Construction types:
//						- New constructor
//						- Empty: {void}
//						- Constructor copy: other {Cube}
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
			if (is_instanceof(argument[0], Cube))
			{
				//|Construction type: Constructor copy.
				var _other = argument[0];
				
				location = ((is_instanceof(_other.location, Vector3)) ? new Vector3(_other.location)
																	  : _other.location);
				scale = ((is_instanceof(_other.scale, Vector3)) ? new Vector3(_other.scale)
																: _other.scale);
				angle = ((is_instanceof(_other.angle, EulerAngle)) ? new EulerAngle(_other.angle)
																   : _other.angle);
				sprite = ((is_instanceof(_other.sprite, Vector3)) ? new Vector3(_other.scale)
																  : _other.scale);
				color = _other.color;
				alpha = _other.alpha;
				
				if (is_array(_other.color))
				{
					color = [];
					array_copy(color, 0, _other.color, 0, array_length(_other.color));
				}
				
				if (is_array(_other.alpha))
				{
					alpha = [];
					array_copy(alpha, 0, _other.alpha, 0, array_length(_other.alpha));
				}
				
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
				location = argument[0];
				scale = argument[1];
				angle = ((argument_count > 2) ? argument[2] : undefined);
				sprite = ((argument_count > 3) ? argument[3] : undefined);
				color = (((argument_count > 4) and (argument[4] != undefined)) ? argument[4]
																			   : c_white);
				alpha = (((argument_count > 5) and (argument[5] != undefined)) ? argument[5] : 1);
			}
		}
		
		return self;
	}
	
	/// @returns			{bool}
	/// @description		Check if this constructor is functional.
	static isFunctional = function()
	{
		return (((is_instanceof(location, Vector3)) and (location.isFunctional())) and
				((is_instanceof(scale, Vector3)) and (scale.isFunctional())) and ((is_real(color)) or
				(is_array(color))) and ((is_real(alpha)) or (is_array(alpha))));
	}
	
   #endregion
   #region <Getters>
	
	/// @argument			location? {Vector3}
	/// @argument			scale? {Vector3}
	/// @argument			angle? {EulerAngle}
	/// @argument			sprite? {Sprite}
	/// @returns			{real[+]}
	/// @description		Return an array containing nested arrays with point locations, resulting
	///						in this Shape when connected. That array is formatted differently,
	///						depending on whether location is specified. If it is, three-dimensional
	///						location data will be included through nested arrays for each side, which
	///						then contain nested arrays for each vertex. If location is not specified,
	///						flat two-dimensional location data will be returned, prepared for
	///						rendering performed by altering the world matrix. In that case, each entry
	///						will be additionally nested with data separated in the following way:
	///						- array[0]: vertex location {real[]}
	///						- array[1]: matrix offset from constructor location {real[]}
	///						- array[2]: matrix rotation {real[]}
	static getVertexLocation = function(_location, _scale = scale, _angle = angle, _sprite = sprite)
	{
		var _result = [];
		
		try
		{
			var _flat = (!is_instanceof(_location, Vector3));
			var _side_sign = self.getVertexSign(_flat);
			var _side_count = array_length(_side_sign);
			var _side_vertex_count = array_length(((is_array(_side_sign[0][0])) ? _side_sign[0]
																				: _side_sign));
			var _angle_x = 0;
			var _angle_y = 0;
			var _angle_z = 0;
			_result = array_create(_side_count, undefined);
			
			if (is_instanceof(_angle, EulerAngle))
			{
				_angle_x = (-_angle.y);
				_angle_y = (-_angle.x);
				_angle_z = (-_angle.z);
			}
			
			var _matrix_rotation = matrix_build(0, 0, 0, _angle_x, _angle_y, _angle_z, 1, 1, 1);
			
			if (_flat)
			{
				var _sprite_frame_scale = [];
				var _sprite_trim_offset = [];
				
				if (is_instanceof(_sprite, Sprite))
				{
					var _i = 0;
					var _sprite_trim_scale = new Scale(_scale.x, _scale.y);
					var _sprite_frame_order = self.getSpriteFrameOrder(_sprite);
					repeat (_side_count)
					{
						var _frame = _sprite_frame_order[_i];
						var _uv = sprite_get_uvs(_sprite.ID, _frame);
						_sprite_frame_scale[_i] = [_uv[6], _uv[7]];
						_sprite_trim_offset[_i] = _sprite.getTextureTrim(_frame, _sprite_trim_scale);
						
						++_i;
					}
				}
				else
				{
					_sprite_frame_scale = array_create(_side_count, [1, 1]);
					_sprite_trim_offset = array_create(_side_count, new Vector2(0, 0));
				}
				
				var _side_scale =
				[
					[_scale.x * _sprite_frame_scale[0][0], _scale.z * _sprite_frame_scale[0][1]],
					[_scale.x * _sprite_frame_scale[1][0], _scale.z * _sprite_frame_scale[1][1]],
					[_scale.z * _sprite_frame_scale[2][0], _scale.y * _sprite_frame_scale[2][1]],
					[_scale.x * _sprite_frame_scale[3][0], _scale.y * _sprite_frame_scale[3][1]],
					[_scale.z * _sprite_frame_scale[4][0], _scale.y * _sprite_frame_scale[4][1]],
					[_scale.x * _sprite_frame_scale[5][0], _scale.y * _sprite_frame_scale[5][1]]
				];
				
				var _side_offset =
				[
					matrix_transform_vertex(_matrix_rotation, _sprite_trim_offset[0].x, (-_scale.y),
											(-_sprite_trim_offset[0].y)),
					matrix_transform_vertex(_matrix_rotation, _sprite_trim_offset[1].x, _scale.y,
											_sprite_trim_offset[1].y),
					matrix_transform_vertex(_matrix_rotation, (-_scale.x), _sprite_trim_offset[2].y,
											(-_sprite_trim_offset[2].x)),
					matrix_transform_vertex(_matrix_rotation, (-_sprite_trim_offset[3].x),
											_sprite_trim_offset[3].y, _scale.z),
					matrix_transform_vertex(_matrix_rotation, _scale.x, _sprite_trim_offset[4].y,
											_sprite_trim_offset[4].x),
					matrix_transform_vertex(_matrix_rotation, _sprite_trim_offset[5].x,
											_sprite_trim_offset[5].y, (-_scale.z))
				];
				
				var _side_rotation_x = [0, 0, 270, 180, 90, 0];
				var _i = [0, 0];
				repeat (_side_count)
				{
					var _side_location_current = array_create(_side_vertex_count, undefined);
					var _side_scale_current = _side_scale[_i[0]];
					var _side_scale_x = _side_scale_current[0];
					var _side_scale_y = _side_scale_current[1];
					var _side_rotation_x_current = _side_rotation_x[_i[0]];
					_i[1] = 0;
					repeat (_side_vertex_count)
					{
						var _side_sign_current = _side_sign[_i[1]];
						
						_side_location_current[_i[1]] = [(_side_scale_x * _side_sign_current[0]),
														 (_side_scale_y * _side_sign_current[1])];
						
						++_i[1];
					}
					
					_result[_i[0]] = [_side_location_current, _side_offset[_i[0]],
									  [_angle_x, (_angle_y + _side_rotation_x_current), _angle_z]];
					
					++_i[0];
				}
			}
			else
			{
				var _sprite_size_scale_x = 1;
				var _sprite_size_scale_y = 1;
				var _side_uv_data = array_create(_side_count, [1, 1, 0, 0]);
				
				if (is_instanceof(_sprite, Sprite))
				{
					_sprite_size_scale_x = (_scale.x / sprite_get_width(_sprite.ID));
					_sprite_size_scale_y = (_scale.y / sprite_get_height(_sprite.ID));
					var _sprite_frame_order = self.getSpriteFrameOrder(_sprite);
					var _i = 0;
					repeat (_side_count)
					{
						var _frame = _sprite_frame_order[_i];
						var _uv = sprite_get_uvs(_sprite.ID, _frame);
						var _trim = _sprite.getTextureTrim(_frame);
						
						_side_uv_data[_i] = [_uv[6], _uv[7],
											 ((_trim.x1 - _trim.x2) * _sprite_size_scale_x),
											 ((_trim.y1 - _trim.y2) * _sprite_size_scale_y)];
						
						++_i;
					}
				}
				
				var _scale_uv =
				[
					[(_scale.x * _side_uv_data[0][0]), _scale.y, (_scale.z * _side_uv_data[0][1])],
					[(_scale.x * _side_uv_data[1][0]), _scale.y, (_scale.z * _side_uv_data[1][1])],
					[_scale.x, (_scale.y * _side_uv_data[2][1]), (_scale.z * _side_uv_data[2][0])],
					[(_scale.x * _side_uv_data[3][0]), (_scale.y * _side_uv_data[3][1]), _scale.z],
					[_scale.x, (_scale.y * _side_uv_data[4][1]), (_scale.z * _side_uv_data[4][0])],
					[(_scale.x * _side_uv_data[5][0]), (_scale.y * _side_uv_data[5][1]), _scale.z]
				];
				
				var _side_offset =
				[
					[_side_uv_data[0][2], 0, (-_side_uv_data[0][3])],
					[_side_uv_data[1][2], 0, _side_uv_data[1][3]],
					[0, _side_uv_data[2][3], (-_side_uv_data[2][2])],
					[(-_side_uv_data[3][2]), _side_uv_data[3][3], 0],
					[0, _side_uv_data[4][3], _side_uv_data[4][2]],
					[_side_uv_data[5][2], _side_uv_data[5][3], 0]
				];
				
				var _i = [0, 0];
				repeat (_side_count)
				{
					var _side_current = _side_sign[_i[0]];
					var _side_current_scale_uv = _scale_uv[_i[0]];
					var _side_current_offset = _side_offset[_i[0]];
					var _side_location_current = array_create(_side_vertex_count, undefined);
					_i[1] = 0;
					repeat (_side_vertex_count)
					{
						var _side_sign_current = _side_current[_i[1]];
						var _transform_location =
						[
							((_side_current_scale_uv[0] * _side_sign_current[0]) +
							 _side_current_offset[0]),
							((_side_current_scale_uv[1] * _side_sign_current[1]) +
							 _side_current_offset[1]),
							((_side_current_scale_uv[2] * _side_sign_current[2]) +
							 _side_current_offset[2])
						];
						
						var _transform = matrix_transform_vertex
						(
							_matrix_rotation, _transform_location[0], _transform_location[1],
							_transform_location[2]
						);
						
						_side_location_current[_i[1]] = [(_location.x + _transform[0]),
														 (_location.y + _transform[1]),
														 ((-_location.z) + _transform[2])];
						
						++_i[1];
					}
					
					_result[_i[0]] = _side_location_current;
					
					++_i[0];
				}
			}
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "getVertexLocation()"], _exception);
		}
		
		return _result;
	}
	
	/// @argument			sprite? {Sprite}
	/// @argument			normalizeToFrame? {bool}
	/// @returns			{any[+]}
	/// @description		Return the UV coordinates for every vertex of each Sprite frame used by
	///						this Shape, along with pointers to respective texture. If specified, UV
	///						values will be normalized to Sprite frames of each pointer, instead of
	///						entire texture page, so its top-left corner will be treated as 0 and
	///						bottom-right corner as 1.
	///						An array will be returned, containing data for every side, nested in
	///						arrays with data then represented at following array positions:
	///						- array[0]: Sprite frame texture {pointer}
	///						- array[1]: UV coordinates {real[]}
	///						  - array[1][0]: U coordinate {real[]}
	///						  - array[1][1]: V coordinate {real[]}
	static getUV = function(_sprite = sprite, _normalizeToFrame = false)
	{
		var _side_count = 6;
		var _result = array_create(_side_count, [(-1), [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0],
														[0, 0]]]);
		
		try
		{
			if (is_instanceof(_sprite, Sprite))
			{
				var _sprite_frame_order = self.getSpriteFrameOrder(_sprite);
				var _i = 0;
				repeat (_side_count)
				{
					var _texture = sprite_get_texture(_sprite.ID, _sprite_frame_order[_i]);
					var _uv = ((_normalizeToFrame) ? [0, 0, 1, 1] : texture_get_uvs(_texture));
					
					_result[_i] = [_texture, [[_uv[2], _uv[1]], [_uv[0], _uv[1]], [_uv[2], _uv[3]],
											  [_uv[2], _uv[3]], [_uv[0], _uv[1]], [_uv[0], _uv[3]]]];
					
					++_i;
				}
			}
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "getUV()"], _exception);
		}
		
		return _result;
	}
	
	/// @argument			location {real[]}
	/// @returns			{Vector3[]} | On error: {undefined}
	/// @see				getVertexLocation()
	/// @description		Return normalized direction of each side of this Shape, based on the
	///						specified separate vertex location arrays, nested in arrays, which
	///						themselves are nested in an array for each side.
	static getNormal = function(_location)
	{
		try
		{
			var _side_count = array_length(_location);
			var _result = array_create(_side_count, undefined);
			var _i = 0;
			repeat (_side_count)
			{
				var _side_current = _location[_i];
				
				_result[_i] = new Vector3((_side_current[1][0] - _side_current[0][0]),
										  (_side_current[1][1] - _side_current[0][1]),
										  (_side_current[1][2] - _side_current[0][2]))
				 .crossProduct(new Vector3((_side_current[2][0] - _side_current[0][0]),
										   (_side_current[2][1] - _side_current[0][1]),
										   (_side_current[2][2] - _side_current[0][2])))
				 .getNormalized();
				
				++_i;
			}
			
			return _result;
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "getNormal()"], _exception);
		}
		
		return undefined;
	}
	
	/// @argument			sprite? {Sprite}
	/// @returns			{int[]}
	/// @description		Return the frame order of this Cube using its current or specified Sprite.
	///						Each of its sides will be represented in following order, depending on the
	///						number of frames that Sprite has:
	///						- 1: Every side.
	///						- 2: Top and bottom, All sides.
	///						- 3: Top, Bottom, All sides.
	///						- 4: Top, Bottom, Left and right, Front and back.
	///						- 5: Top and bottom, Left, Front, Right, Back.
	///						- 6+: Top, Bottom, Left, Front, Right, Back.
	static getSpriteFrameOrder = function(_sprite = sprite)
	{
		var _result = undefined;
		
		try
		{
			switch (sprite_get_number(_sprite.ID))
			{
				case 1: _result = [0, 0, 0, 0, 0, 0]; break;
				case 2: _result = [0, 0, 1, 1, 1, 1]; break;
				case 3: _result = [0, 1, 2, 2, 2, 2]; break;
				case 4: _result = [0, 1, 2, 3, 2, 3]; break;
				case 5: _result = [0, 0, 1, 2, 3, 4]; break;
				default: _result = [0, 1, 2, 3, 4, 5]; break;
			}
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "getSpriteFrameOrder()"], _exception);
		}
		
		return _result;
	}
	
	/// @argument			flat? {bool}
	/// @returns			{int[+]}
	/// @description		Return an array containing nested arrays with multipliers for direction of
	///						offsets used in calculating position of each side of this Cube. The
	///						returned array will either contain values for each vertex in a
	///						three-dimensional space, or if specified to be flat, values for each
	///						vertex in a two-dimensional space for use with a rotation matrix.
	static getVertexSign = function(_flat = false)
	{
		return ((_flat) ? [[1, (-1)], [(-1), (-1)], [1, 1, 1], [1, 1], [(-1), (-1)], [(-1), 1]]
						: [
							//|Top (Normal Y-):
							[[1, (-1), 1], [(-1), (-1), 1], [1, (-1), (-1)], [1, (-1), (-1)],
							 [(-1), (-1), 1], [(-1), (-1), (-1)]],
							//|Bottom (Normal Y+):
							[[1, 1, (-1)], [(-1), 1, (-1)], [1, 1, 1], [1, 1, 1], [(-1), 1, (-1)],
							 [(-1), 1, 1]],
							//|Left (Normal X-):
							[[(-1), (-1), (-1)], [(-1), (-1), 1], [(-1), 1, (-1)], [(-1), 1, (-1)],
							 [(-1), (-1), 1], [(-1), 1, 1]],
							//|Front (Normal Z-):
							[[(-1), (-1), 1], [1, (-1), 1], [(-1), 1, 1], [(-1), 1, 1], [1, (-1), 1],
							 [1, 1, 1]],
							//|Right (Normal X+):
							[[1, (-1), 1], [1, (-1), (-1)], [1, 1, 1], [1, 1, 1], [1, (-1), (-1)],
							 [1, 1, (-1)]],
							//|Back (Normal Z+):
							[[1, (-1), (-1)], [(-1), (-1), (-1)], [1, 1, (-1)], [1, 1, (-1)],
							 [(-1), (-1), (-1)], [(-1), 1, (-1)]]
						  ]);
	}
	
	/// @argument			location? {Vector3}
	/// @argument			scale? {Vector3}
	/// @argument			angle? {EulerAngle}
	/// @argument			sprite? {Sprite}
	/// @returns			{any[+]} | On error: {undefined}
	//  @see				getVertexLocation(), getUV()
	/// @description		Return an array containg rendering data for each vertex resulting in this
	///						Shape, consisting of its primitive type, location and UV of each vertex
	///						nested in arrays for each side, using its current data or temporarily
	///						replaced parts.
	///						Format of that data depends on whether location is specified:
	///						- If it is, data for three-dimensional rendering will be returned.
	///						- If not, flat two-dimensional data will be returned, with location
	///						  prepared for rendering performed by altering the world matrix and UV
	///						  values normalized to each Sprite frame used, instead of the entire
	///						  texture.
	///						In both cases, data will be represented at following array
	///						positions:
	///						- array[0]: primitive type {constant:pr_*}
	///						- array[1]: vertex location data {real[+]}
	///						- array[2]: texture data {any[+]}
	static getPrimitiveRenderData = function(_location, _scale = scale, _angle = angle,
											 _sprite = sprite)
	{
		try
		{
			var _flat = (!is_instanceof(_location, Vector3));
			var _vertex_location = self.getVertexLocation(_location, _scale, _angle, _sprite);
			var _uv = self.getUV(_sprite, _flat);
			
			return event.getPrimitiveRenderData.execute(undefined, [[pr_trianglelist,
																	 _vertex_location, _uv]]);
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "getPrimitiveRenderData()"], _exception);
		}
		
		return undefined;
	}
	
   #endregion
   #region <Execution>
	
	/// @argument			location? {Vector3}
	/// @argument			scale? {Scale}
	/// @argument			angle? {EulerAngle}
	/// @argument			sprite? {Sprite}
	/// @argument			color? {int:color|int:color[]}
	/// @argument			alpha? {real|real[]}
	/// @argument			excludedSide? {int|int[]}
	/// @description		Execute the draw, using data of this constructor or its specified
	///						temporarily replaced parts. Each side can be excluded from this draw by
	///						specifying its number, starting from 1 in following order: Top, Bottom,
	///						Left, Front, Right, Back.
	static render = function(_location = location, _scale = scale, _angle = angle, _sprite = sprite,
							 _color = color, _alpha = alpha, _excludedSide = [])
	{
		var _side_count = 6;
		var _matrix_original = matrix_get(matrix_world);
		var _location_original = location;
		var _scale_original = scale;
		var _angle_original = angle;
		var _sprite_original = sprite;
		var _color_original = color;
		var _alpha_original = alpha;
		
		location = _location;
		scale = _scale;
		angle = _angle;
		sprite = _sprite;
		color = ((is_array(_color)) ? array_create(_side_count, _color) : _color);
		alpha = ((is_array(_alpha)) ? array_create(_side_count, _alpha) : _alpha);
		
		try
		{
			if (self.isFunctional())
			{
				event.beforeRender.execute();
				
				if (!is_array(_excludedSide))
				{
					_excludedSide = [_excludedSide];
				}
				
				var _primitive = self.getPrimitiveRenderData(undefined, undefined, undefined,
															 undefined, true);
				var _rotation_x_side_vertical = [90, 270];
				var _primitive_type = _primitive[0];
				var _transform = _primitive[1];
				var _texture_data = _primitive[2];
				var _i = [0, 0];
				repeat (array_length(_primitive[1]))
				{
					if (!array_contains(_excludedSide, (_i[0] + 1)))
					{
						var _transform_current = _transform[_i[0]];
						var _location_current = _transform_current[0];
						var _offset_current = _transform_current[1];
						var _rotation_current = _transform_current[2];
						var _texture_data_current = _texture_data[_i[0]];
						var _texture_current = _texture_data_current[0];
						var _uv_current = _texture_data_current[1];
						var _color_current = color[_i[0]];
						var _alpha_current = alpha[_i[0]];
						var _matrix_side = _matrix_original;
						var _matrix_transform = matrix_build
						(
							(location.x + _offset_current[0]),
							(location.y + _offset_current[1]),
							((-location.z) + _offset_current[2]), _rotation_current[0],
							_rotation_current[1], _rotation_current[2], 1, 1, 1
						);
						
						if (_i[0] <= 1)
						{
							_matrix_side = matrix_multiply
							(
								_matrix_original,
								matrix_build(0, 0, 0, _rotation_x_side_vertical[_i[0]], 0, 0, 1, 1, 1)
							);
						}
						
						_i[1] = 0;
						draw_primitive_begin_texture(_primitive_type, _texture_current);
						matrix_set(matrix_world, matrix_multiply(_matrix_side, _matrix_transform));
						repeat (array_length(_location_current))
						{
							var _vertex_location_current = _location_current[_i[1]];
							var _vertex_uv_current = _uv_current[_i[1]];
							
							draw_vertex_texture_color(_vertex_location_current[0],
													  _vertex_location_current[1],
													  _vertex_uv_current[0], _vertex_uv_current[1],
													  _color_current, _alpha_current);
							
							++_i[1];
						}
						draw_primitive_end();
					}
					
					++_i[0];
				}
				
				matrix_set(matrix_world, _matrix_original);
				
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
			
			matrix_set(matrix_world, _matrix_original);
		}
		finally
		{
			location = _location_original;
			scale = _scale_original;
			angle = _angle_original;
			sprite = _sprite_original;
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
	/// @argument			color? {int:color|int:color[]}
	/// @argument			alpha? {real|real[]}
	/// @argument			excludedSide? {int|int[]}
	/// @argument			vertexBuffer? {VertexBuffer}
	/// @returns			{VertexBuffer.PrimitiveRenderData[]}
	/// @description		Return rendering data of this constructor in Vertex Buffers, using its
	///						current data or specified temporarily replaced parts. A single Vertex
	///						Buffer can be specified instead to place rendering data in it, instead of
	///						creating several new ones. If specified while being currently active, it
	///						will not be deactivated after this operation. Rendering data for six sides
	///						will be returned in an array, except for sides that were excluded by
	///						specifying their numbers, starting from 1 in following order: Top, Bottom,
	///						Left, Front, Right, Back.
	static toVertexBuffer = function(_location = location, _scale = scale, _angle = angle,
									 _sprite = sprite, _color = color, _alpha = alpha,
									 _excludedSide = [], _vertexBuffer)
	{
		var _result = [];
		var _vertexBuffer_side = undefined;
		
		try
		{
			var _vertexBuffer_wasActive = false;
			
			if (_vertexBuffer != undefined)
			{
				_vertexBuffer_wasActive = _vertexBuffer.active;
			}
			
			if (!is_array(_excludedSide))
			{
				_excludedSide = [_excludedSide];
			}
			
			var _primitive = self.getPrimitiveRenderData(_location, _scale, _angle, _sprite);
			var _primitive_type = _primitive[0];
			var _vertex_location = _primitive[1];
			var _texture_data = _primitive[2];
			var _normal_side = self.getNormal(_vertex_location);
			var _side_count = array_length(_vertex_location);
			
			if (!is_array(_color))
			{
				_color = array_create(_side_count, _color);
			}
			
			if (!is_array(_alpha))
			{
				_alpha = array_create(_side_count, _alpha);
			}
			
			var _vertex = new Vector3();
			var _i = [0, 0];
			repeat (_side_count)
			{
				if (!array_contains(_excludedSide, (_i[0] + 1)))
				{
					var _location_side_current = _vertex_location[_i[0]];
					var _texture_data_current = _texture_data[_i[0]];
					var _uv_current = _texture_data_current[1];
					var _normal_current = _normal_side[_i[0]];
					var _color_current = _color[_i[0]];
					var _alpha_current = _alpha[_i[0]];
					
					_vertexBuffer_side = (_vertexBuffer ?? new VertexBuffer());
					var _renderData = _vertexBuffer_side.createPrimitiveRenderData
					(
						_primitive_type, vertex_position_3d, _texture_data_current[0]
					);
					
					if (!_vertexBuffer_wasActive)
					{
						_vertexBuffer_side.setActive(_renderData.vertexFormat);
					}
					
					_i[1] = 0;
					repeat (array_length(_location_side_current))
					{
						var _vertex_location_current = _location_side_current[_i[1]];
						var _vertex_uv_current = _uv_current[_i[1]];
						
						_vertexBuffer_side
						 .setLocation3D(_vertex.setAll(_vertex_location_current))
						 .setNormal(_normal_current)
						 .setUV(_vertex_uv_current[0], _vertex_uv_current[1])
						 .setColor(_color_current, _alpha_current);
						
						++_i[1];
					}
					
					if (_vertexBuffer == undefined)
					{
						_vertexBuffer_side.setActive(false);
					}
					
					array_push(_result, _renderData);
				}
				
				++_i[0];
			}
			
			if ((_vertexBuffer != undefined) and (!_vertexBuffer_wasActive))
			{
				_vertexBuffer_side.setActive(false);
			}
		}
		catch (_exception)
		{
			if ((_vertexBuffer == undefined) and (array_length(_result) == 0)
			and (_vertexBuffer_side != undefined))
			{
				_vertexBuffer_side.destroy();
			}
			
			ErrorReport.report([other, self, "toVertexBuffer()"], _exception);
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
