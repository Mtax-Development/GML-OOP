//  @function				Surface()
/// @argument				size {Vector2}
/// @description			Constructs a Surface resource, a separate canvas for graphics rendering.
//							
//							Construction types:
//							- New constructor
//							- Wrapper: surface {int:surface}
//							- Empty: {void|undefined}
//							- Constructor copy: other {Surface}
function Surface() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				ID = undefined;
				size = undefined;
				
				event =
				{
					beforeCreation: new Callback(undefined, [], other),
					afterCreation: new Callback(undefined, [], other),
					beforeActivation: new Callback(undefined, [], other),
					afterActivation: new Callback(undefined, [], other),
					beforeDeactivation: new Callback(undefined, [], other),
					afterDeactivation: new Callback(undefined, [], other),
					beforeRender: new Callback(undefined, [], other),
					afterRender: new Callback(undefined, [], other)
				};
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (is_instanceof(argument[0], Surface))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						size = ((is_instanceof(_other.size, Vector2)) ? new Vector2(_other.size)
																	  : _other.size);
						
						if (is_struct(_other.event))
						{
							event.beforeCreation.setAll(_other.event.beforeCreation);
							event.afterCreation.setAll(_other.event.afterCreation);
							event.beforeActivation.setAll(_other.event.beforeActivation);
							event.afterActivation.setAll(_other.event.afterActivation);
							event.beforeDeactivation.setAll(_other.event.beforeDeactivation);
							event.afterDeactivation.setAll(_other.event.afterDeactivation);
							event.beforeRender.setAll(_other.event.beforeRender);
							event.afterRender.setAll(_other.event.afterRender);
						}
						else
						{
							event = _other.event;
						}
						
						ID = surface_create(max(1, size.x), max(1, size.y));
						surface_copy(ID, 0, 0, _other.ID);
					}
					else if (is_handle(argument[0]))
					{
						//|Construction type: Wrapper.
						ID = argument[0];
						size = new Vector2(surface_get_width(ID), surface_get_height(ID));
					}
					else
					{
						//|Construction type: New constructor.
						size = argument[0];
						ID = surface_create(max(1, size.x), max(1, size.y));
					}
					
					surface_set_target(ID);
					{
						draw_clear_alpha(c_black, 0);
					}
					surface_reset_target();
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_handle(ID)) and (surface_exists(ID)));
			}
			
			/// @description		Create this Surface if it does not exists.
			static create = function()
			{
				if (!self.isFunctional())
				{
					event.beforeCreation.execute();
					
					if ((is_instanceof(size, Vector2)) and (size.isFunctional()))
					{
						ID = surface_create(max(1, size.x), max(1, size.y));
					}
					else
					{
						new ErrorReport().report([other, self, "create()"],
												 ("Attempted to create a Surface of invalid size: " +
												  "\n" + "Self: " + "{" + string(self) + "}" + "\n" +
												  "Size: " + "{" + string(size) + "}" + "\n" +
												  "Replacing the size property with a single pixel " +
												  "size and creating the Surface with it."));
						
						ID = surface_create(1, 1);
					}
					
					surface_set_target(ID);
					{
						draw_clear_alpha(c_black, 0);
					}
					surface_reset_target();
					
					event.afterCreation.execute();
				}
				
				return self;
			}
			
			/// @returns			{undefined}
			/// @description		Remove the internal information from the memory.
			static destroy = function()
			{
				if (self.isFunctional())
				{
					surface_free(ID);
				}
				
				return undefined;
			}
			
			/// @argument			color? {int:color}
			/// @argument			alpha? {real}
			/// @description		Set the entire content of this Surface to the specified color.
			static clear = function(_color = c_black, _alpha)
			{
				try
				{
					self.create();
					
					var _target = (surface_get_target() == ID)
					
					if (!_target)
					{
						surface_set_target(ID);
					}
					
					if (_alpha == undefined)
					{
						draw_clear(_color);
					}
					else
					{
						draw_clear_alpha(_color, _alpha);
					}
					
					if (!_target)
					{
						surface_reset_target();
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "clear()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			location {Vector2}
			/// @argument			other {Surface|int:surface}
			/// @argument			other_part? {Vector4}
			/// @description		Copy content of other Surface to a specified location on this
			///						Surface.
			static copy = function(_location, _other, _other_part)
			{
				try
				{
					var _other_value = ((is_instanceof(_other, Surface)) ? _other.ID : _other);
						
					if ((is_handle(_other_value)) and (surface_exists(_other_value)))
					{
						if (_other_part != undefined)
						{
							if (!self.isFunctional())
							{
								new ErrorReport().report([other, self, "copy()"],
														 ("Attempted to copy part of a Surface to " +
														  "an invalid Surface: " + "\n" +
														  "Self: " + "{" + string(self) + "}" + "\n" +
														  "Other: " + "{" + string(_other) + "}" +
														  "\n" + "Writing it to a recreated " +
														  "Surface."));
								
								self.create();
							}
							
							surface_copy_part(ID, _location.x, _location.y, _other_value,
											  _other_part.x1, _other_part.y1, _other_part.x2,
											  _other_part.y2);
						}
						else
						{
							self.create();
							
							surface_copy(ID, _location.x, _location.y, _other_value);
						}
					}
					else
					{
						new ErrorReport().report([other, self, "copy()"],
												 ("Attempted to copy data from an invalid Surface: " +
												  "\n" + "Self: " + "{" + string(self) + "}" + "\n" +
												  "Other: " + "{" + string(_other) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "copy()"], _exception);
				}
				
				return self;
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			other {Surface}
			/// @returns			{bool}
			/// @description		Check if the specified constructor uses the same resource.
			static equals = function(_other)
			{
				return ((is_instanceof(_other, Surface)) and (ID == _other.ID));
			}
			
			/// @argument			location {Vector2}
			/// @argument			getFull? {bool}
			/// @returns			{int:color|int:color:abgr32bit} | On error: {undefined}
			/// @description		Get the pixel color on a specific spot on a Surface.
			///						A full abgr 32bit information can be obtainted if specified.
			static getPixel = function(_location, _getFull = false)
			{
				try
				{	
					return ((_getFull) ? surface_getpixel_ext(ID, _location.x, _location.y)
									   : surface_getpixel(ID, _location.x, _location.y));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getPixel()"], _exception);
				}
			}
			
			/// @returns			{pointer}
			/// @description		Get the pointer to texture page of this Surface.
			static getTexture = function()
			{
				if (!self.isFunctional())
				{
					new ErrorReport().report([other, self, "getTexture()"],
											 ("Attempted to get texture of an invalid Surface: " +
											  "{" + string(ID) + "}" + "\n" +
											  "Recreating the Surface and providing its texture."));
					
					self.create();
				}
				
				return surface_get_texture(ID);
			}
			
			/// @returns			{Vector2}
			/// @description		Get the texel size of the texture page of this Surface.
			static getTexel = function()
			{
				if (!self.isFunctional())
				{
					new ErrorReport().report([other, self, "getTexel()"],
											 ("Attempted to get texture of an invalid Surface: " +
											  "{" + string(ID) + "}" + "\n" +
											  "Recreating the Surface and providing its texture."));
					
					self.create();
				}
				
				var _texture = surface_get_texture(ID);
				
				return new Vector2(texture_get_texel_width(_texture),
								   texture_get_texel_height(_texture));
			}
			
			/// @returns			{bool}
			/// @description		Check whether this Surface is the current draw target.
			static isActive = function()
			{
				return ((self.isFunctional()) ? (surface_get_target() == ID) : false);
			}
			
		#endregion
		#region <Setters>
			
			/// @argument			size {Vector2}
			/// @description		Set the size of the Surface.
			static setSize = function(_size)
			{
				if ((is_instanceof(_size, Vector2)) and (_size.isFunctional()))
				{
					var _size_x = max(1, _size.x);
					var _size_y = max(1, _size.y);
					
					if (is_instanceof(size, Vector2))
					{
						size.x = _size_x;
						size.y = _size_y;
					}
					else
					{
						size = new Vector2(_size_x, _size_y);
					}
					
					if (!self.isFunctional())
					{
						new ErrorReport().report([other, self, "setSize()"],
												 ("Attempted to change size of an invalid " +
												  "Surface: " +
												  "{" + string(ID) + "}" + "\n" +
												  "Recreating the Surface with the target size."));
						
						self.create();
					}
					else
					{
						surface_resize(ID, _size_x, _size_y);
					}
				}
				else
				{
					new ErrorReport().report([other, self, "setSize()"],
											 ("Attempted to set invalid size of a Surface: " + "\n" +
											  "Surface: " + "{" + string(self) + "}" + "\n" +
											  "Size: " + "{" + string(_size) + "}"));
				}
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			location? {Vector2|Vector4}
			/// @argument			scale? {Scale}
			/// @argument			angle? {Angle}
			/// @argument			color? {int:color|Color4}
			/// @argument			alpha? {real}
			/// @argument			part? {Vector4}
			/// @argument			origin? {Vector2}
			/// @argument			target? {Surface|int:surface}
			/// @description		Draw this Surface or a part of it to the currently active or
			///						specified Surface.
			static render = function(_location, _scale, _angle, _color = c_white, _alpha = 1, _part,
									 _origin, _target)
			{
				var _targetStack = undefined;
				
				try
				{
					if (self.isFunctional())
					{
						event.beforeRender.execute();
						
						if (_target != undefined)
						{
							var _target_value = ((is_instanceof(_target, Surface)) ? _target.ID
																				   : _target);
							
							if ((is_handle(_target_value)) and (surface_exists(_target_value))
							and (_target_value != ID))
							{
								_targetStack = ds_stack_create();
								
								var _currentTarget = surface_get_target();
								
								while ((_currentTarget != _target_value) and (_currentTarget > 0)
								and (_currentTarget != application_surface))
								{
									ds_stack_push(_targetStack, _currentTarget);
									
									surface_reset_target();
									
									_currentTarget = surface_get_target();
								}
								
								surface_set_target(_target_value);
							}
							else
							{
								new ErrorReport().report([other, self, "render()"],
														 ("Attempted to render to an invalid " +
														  "Surface: " + "\n" +
														  "Self: " + "{" + string(self) + "}" + "\n" +
														  "Other: " + "{" + string(_target) + "}"));
							}
						}
						
						var _scale_x = 1;
						var _scale_y = 1;
						
						if (_scale != undefined)
						{
							_scale_x = _scale.x;
							_scale_y = _scale.y;
						}
						
						var _origin_x = 0;
						var _origin_y = 0;
						
						if (_origin != undefined)
						{
							_origin_x = _origin.x;
							_origin_y = _origin.y;
						}
						
						var _size_x = surface_get_width(ID);
						var _size_y = surface_get_height(ID);
						var _location_x = 0;
						var _location_y = 0;
						
						if (_location != undefined)
						{
							if (is_instanceof(_location, Vector4))
							{
								_scale_x = (((_location.x2 - _location.x1) / _size_x) * _scale_x);
								_scale_y = (((_location.y2 - _location.y1) / _size_y) * _scale_y);
								_location_x = _location.x1 + (_origin_x * _scale_x);
								_location_y = _location.y1 + (_origin_y * _scale_y);
							}
							else
							{
								_location_x = _location.x;
								_location_y = _location.y;
							}
						}
						
						var _color_x1y1, _color_x2y1, _color_x2y2, _color_x1y2;
						
						if (is_real(_color))
						{
							_color_x1y1 = _color;
							_color_x2y1 = _color;
							_color_x2y2 = _color;
							_color_x1y2 = _color;
						}
						else
						{
							_color_x1y1 = _color.color1;
							_color_x2y1 = _color.color2;
							_color_x2y2 = _color.color3;
							_color_x1y2 = _color.color4;
						}
						
						var _part_x1, _part_y1, _part_x2, _part_y2;
						
						if (_part != undefined)
						{
							_part_x1 = clamp(_part.x1, 0, _size_x);
							_part_y1 = clamp(_part.y1, 0, _size_y);
							_part_x2 = clamp(_part.x2, 0, (_size_x - _part_x1));
							_part_y2 = clamp(_part.y2, 0, (_size_y - _part_y1));
						}
						else
						{
							_part_x1 = 0;
							_part_y1 = 0;
							_part_x2 = _size_x;
							_part_y2 = _size_y;
						}
						
						var _angle_value = 0;
						
						if (_angle != undefined)
						{
							_angle_value = _angle.value;
						}
						
						var _origin_transformed_x = (_part_x1 - lerp(_part_x1, (_part_x1 + _part_x2),
																	 ((_origin_x * _scale_x) /
																	  _size_x)));
						var _origin_transformed_y = (_part_y1 - lerp(_part_y1, (_part_y1 + _part_y2),
																	 ((_origin_y * _scale_y) /
																	  _size_y)));
						var _angle_dcos = dcos(_angle_value);
						var _angle_dsin = dsin(_angle_value);
						_location_x = (_location_x + (_origin_transformed_x * _angle_dcos) +
									   (_origin_transformed_y * _angle_dsin));
						_location_y = (_location_y - (_origin_transformed_x * _angle_dsin) +
									   (_origin_transformed_y * _angle_dcos));
						
						draw_surface_general(ID, _part_x1, _part_y1, _part_x2, _part_y2, _location_x,
											 _location_y, _scale_x, _scale_y, _angle_value,
											 _color_x1y1, _color_x2y1, _color_x2y2, _color_x1y2,
											 _alpha);
						
						if (is_handle(_targetStack))
						{
							surface_reset_target();
							
							repeat (ds_stack_size(_targetStack))
							{
								surface_set_target(ds_stack_pop(_targetStack));
							}
						}
						
						event.afterRender.execute();
					}
					else
					{
						new ErrorReport().report([other, self, "render()"],
												 ("Attempted to render an invalid Surface: " +
												  "{" + string(ID) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "render()"], _exception);
				}
				finally
				{
					if (is_handle(_targetStack))
					{
						ds_stack_destroy(_targetStack);
					}
				}
				
				return self;
			}
			
			/// @argument			offset? {Vector2}
			/// @argument			scale? {Scale}
			/// @argument			color? {int:color}
			/// @argument			alpha? {real}
			/// @description		Draw this Surface tiled across the target created Surface or the
			///						entire Room if none is set.
			static renderTiled = function(_offset, _scale, _color = c_white, _alpha = 1)
			{
				try
				{
					if (self.isFunctional())
					{
						event.beforeRender.execute();
						
						var _offset_x, _offset_y;
						
						if (_offset != undefined)
						{
							_offset_x = _offset.x;
							_offset_y = _offset.y;
						}
						else
						{
							_offset_x = 0;
							_offset_y = 0;
						}
						
						var _scale_x, _scale_y;
						
						if (_scale != undefined)
						{
							_scale_x = _scale.x;
							_scale_y = _scale.y;
						}
						else
						{
							_scale_x = 1;
							_scale_y = 1;
						}
						
						draw_surface_tiled_ext(ID, _offset_x, _offset_y, _scale_x, _scale_y, _color,
											   _alpha);
						
						event.afterRender.execute();
					}
					else
					{
						new ErrorReport().report([other, self, "renderTiled()"],
												 ("Attempted to render an invalid Surface: " +
												  "{" + string(ID) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "renderTiled()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			target {bool}
			/// @description		Place this Surface on the top of target stack or remove it.
			static setActive = function(_target)
			{
				switch (_target)
				{
					case true:
						if (!self.isFunctional())
						{
							new ErrorReport().report([other, self, "setActive()"],
													 ("Attempted to set an invalid Surface as the " +
													  "render target: " +  "{" + string(ID) + "}" +
													  "\n" + "Recreating the Surface and setting " +
													  "it as target."));
							
							self.create();
						}
						
						event.beforeActivation.execute();
						surface_set_target(ID);
						event.afterActivation.execute();
					break;
					case false:
						if (surface_get_target() == ID)
						{
							event.beforeDeactivation.execute();
							surface_reset_target();
							event.afterDeactivation.execute();
						}
					break;
				}
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented with the properties of this Surface.
			static toString = function(_multiline = false)
			{
				if (is_handle(ID))
				{
					var _string = "";
					var _mark_separator = ((_multiline) ? "\n" : ", ");
					var _text_nonexistent = ((surface_exists(ID)) ? "" : " (nonexistent)");
					
					_string = ("ID: " + string(ID) + _text_nonexistent + _mark_separator +
							   "Size: " + string(size));
					
					return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			/// @argument			path {string:path}
			/// @argument			part? {Vector4}
			/// @description		Save the content of this Surface or a rectangular part of it to
			///						the specified PNG file.
			static toFile = function(_path, _part)
			{
				try
				{
					if (self.isFunctional())
					{
						if (_part != undefined)
						{
							surface_save_part(ID, _path, _part.x1, _part.y1, _part.x2, _part.y2);
						}
						else
						{
							surface_save(ID, _path);
						}
					}
					else
					{
						new ErrorReport().report([other, self, "toFile()"],
												 ("Attempted to convert an invalid Surface: " +
												  "{" + string(ID) + "}"));
					}
				}
				return self;
			}
			
			/// @argument			buffer {Buffer}
			/// @argument			offset? {int}
			/// @description		Copy information from the specified Buffer to this Surface.
			///						A byte offset can be specified for where the data load will begin.
			static fromBuffer = function(_buffer, _offset = 0)
			{
				try
				{
					self.create();
					
					if (self.isFunctional())
					{
						if ((is_instanceof(_buffer, Buffer)) and (_buffer.isFunctional()))
						{
							buffer_set_surface(_buffer.ID, ID, _offset);
						}
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "fromBuffer()"], _exception);
				}
				
				return self;
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static constructor = Surface;
		
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
