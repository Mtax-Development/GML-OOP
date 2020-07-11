/// @function				Surface()
/// @argument				{Vector2} size
///
///	@description			Constructs a Surface resource, which can be rendered
///							or operated in other ways.
function Surface(_size) constructor	
{
	#region [Methods]
		#region <Management>
			
			// @description			Create the Surface if it was destroyed.
			static create = function()
			{
				if (!surface_exists(ID))
				{
					ID = surface_create(size.x, size.y);
				}
			}
			
			// @returns				{undefined}
			// @description			Remove the internal Surface information from the memory.
			static destroy = function()
			{
				if (surface_exists(ID))
				{
					surface_free(ID);
				}
				
				return undefined;
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{Vector2} size
			// @descirption			Set the size of the Surface.
			static setSize = function(_size)
			{
				size = _size;
				
				if (!surface_exists(ID))
				{
					ID = surface_create(size.x, size.y);
				}
				else
				{
					surface_resize(ID, size.x, size.y);
				}	
			}
			
		#endregion
		#region <Getters>
			
			// @description			Check whether this Surface is the current draw target.
			static isTarget = function()
			{
				return (surface_exists(ID) ? (surface_get_target() == ID) : false);
			}
			
			// @argument			{Vector2} location
			// @argument			{bool} getFull?
			// @returns				{color|undefined}
			// @description			Get the pixel color on a specific spot on a Surface.
			//						Returns {undefined} if the surface does not exist.
			static getPixel = function(_location, _getFull)
			{
				if (surface_exists(ID))
				{	
					return (_getFull ? surface_getpixel_ext(ID, _location.x, _location.y) :
									   surface_getpixel(ID, _location.x, _location.y));
				}
				else
				{
					return undefined;
				}
			}
			
			// @returns				{ptr}
			// @description			Get the pointer to Surface's internal texture.
			static getTexture = function()
			{
				self.create();
				
				return surface_get_texture(ID);
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{bool} setAsTarget
			// @description			Place this Surface on the top of target stack or remove it.
			static target = function(_setAsTarget)
			{
				if (_setAsTarget)
				{
					self.create();
				
					surface_set_target(ID);
				}
				else
				{
					if ((surface_exists(ID)) and (surface_get_target() == ID))
					{
						surface_reset_target();
					}
				}
			}
			
			// @argument			{color} color
			// @argument			{real} alpha?
			// @description			Set entire content of the surface to a specified color value.
			static clear = function(_color, _alpha)
			{
				self.create();
				
				if (_alpha == undefined) {_alpha = 1;}
				
				var _wasTarget = (surface_get_target() == ID)
				
				if (!_wasTarget)
				{
					surface_set_target(ID);
				}
				
				if (_alpha >= 1)
				{
					draw_clear(_color);
				}
				else
				{
					draw_clear_alpha(_color, _alpha);
				}
				
				if (!_wasTarget)
				{
					surface_reset_target();
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{Scale} scale?
			// @argument			{Angle} angle?
			// @argument			{color} color?
			// @argument			{real} alpha?
			// @description			Execute the draw.
			static render = function(_location, _scale, _angle, _color, _alpha)
			{
				if (surface_exists(ID))
				{
					if (argument_count > 1)
					{
						if (_scale == undefined) {_scale = new Scale();}
						if (_angle == undefined) {_angle = new Angle();}
						if (_color == undefined) {_color = c_white;}
						if (_alpha == undefined) {_alpha = 1;}
						
						draw_surface_ext(ID, _location.x, _location.y, _scale.x, _scale.y,
										 _angle.value, _color, _alpha);
					}
					else
					{
						draw_surface(ID, _location.x, _location.y);
					}
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{Surface|surface} target?
			// @argument			{Scale} scale?
			// @argument			{Angle} angle?
			// @argument			{color} color?
			// @argument			{real} alpha?
			// @description			Execute the draw to a specified target, ignoring the target stack.
			static render_target = function(_location, _target)
			{
				if (surface_exists(ID))
				{
					if (_target == undefined) {_target = application_surface;}
					
					var _renderTarget = (instanceof(_target) == "Surface" ? _target.ID : _target);
					
					if (surface_exists(_renderTarget))
					{
						var _targetStack = ds_stack_create();
						var _currentTarget = surface_get_target();
						
						while ((_currentTarget != _renderTarget) 
						and (_currentTarget != application_surface))
						{
							ds_stack_push(_targetStack, _currentTarget);
					
							surface_reset_target();
					
							_currentTarget = surface_get_target();
						}
						
						if (argument_count > 2)
						{
							var _scale = (argument_count >= 3 ? argument[2] : new Scale());
							var _angle = (argument_count >= 4 ? argument[3] : new Angle());
							var _color = (argument_count >= 5 ? argument[4] : c_white);
							var _alpha = (argument_count >= 6 ? argument[5] : 1);
				
							draw_surface_ext(ID, _location.x, _location.y, _scale.x, _scale.y, 
											 _angle.value, _color, _alpha);
						}
						else
						{
							draw_surface(ID, _location.x, _location.y);
						}
						
						repeat(ds_stack_size(_targetStack))
						{
							surface_set_target(ds_stack_pop(_targetStack)); //+TODO: MRT support
						}
						
						ds_stack_destroy(_targetStack);
					}
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{Vector4} part_location
			// @argument			{Scale} scale?
			// @argument			{color} color?
			// @argument			{real} alpha?
			// @description			Execute the draw of a specified part of the Surface.
			static render_part = function(_location, _part_location)
			{
				if (surface_exists(ID))
				{
					if (argument_count > 2)
					{
						var _scale = (argument_count >= 3 ? argument[2] : new Scale());
						var _color = (argument_count >= 4 ? argument[3] : c_white);
						var _alpha = (argument_count >= 5 ? argument[4] : 1);
						
						draw_surface_part_ext(ID, _part_location.x1, _part_location.y1, 
											  _part_location.x2, _part_location.y2, 
											  _location.x, _location.y, _scale.x, 
											  _scale.y, _color, _alpha);
					}
					else
					{
						draw_surface_part(ID, _part_location.x1, _part_location.y1, 
										  _part_location.x2, _part_location.y2, 
										  _location.x, _location.y);
					}
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{Vector4} part_location?
			// @argument			{Scale} scale?
			// @argument			{Color4|color} color?
			// @argument			{real} alpha?
			// @argument			{Angle} angle?
			// @description			Execute the draw with specified alternations.
			static render_general = function(_location, _part_location, _scale, 
											 _color, _alpha, _angle)
			{
				if (surface_exists(ID))
				{					 
					if (_part_location == undefined) {_part_location = new Vector4(0, size.x,
																				   0, size.y);}
					
					if (_scale == undefined) {_scale = new Scale();}
					if (_color == undefined) {_color = c_white;}
					if (_alpha == undefined) {_alpha = 1;}
					if (_angle == undefined) {_angle = new Angle();}
					
					var _color_x1y1, _color_x1y2, _color_x2y1, _color_x2y2;
					
					switch (instanceof(_color))
					{
						case "Color4":
							_color_x1y1 = _color.x1y1;
							_color_x1y2 = _color.x1y2;
							_color_x2y1 = _color.x2y1;
							_color_x2y2 = _color.x2y2;
						break;
						
						default:
							_color_x1y1 = _color;
							_color_x1y2 = _color;
							_color_x2y1 = _color;
							_color_x2y2 = _color;
						break;
					}
					
					draw_surface_general(ID, _part_location.x1, _part_location.y1, 
										 _part_location.x2, _part_location.y2, 
										 _location.x, _location.y, _scale.x, 
										 _scale.y, _angle.value, _color_x1y1, 
										 _color_x2y1, _color_x2y2, _color_x1y2, 
										 _alpha);
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{Vector2} size
			// @argument			{color} color?
			// @argument			{real} alpha?
			// @description			Execute the draw by forcing the Surface to match a specific size.
			static render_size = function(_location, _size)
			{
				if (surface_exists(ID))
				{
					if (argument_count > 2)
					{
						var _color = (argument_count >= 3 ? argument[2] : c_white);
						var _alpha = (argument_count >= 4 ? argument[3] : 1);
			
						draw_surface_stretched_ext(ID, _location.x, _location.y, _size.x,
												   _size.y, _color, _alpha);
					}
					else
					{
						draw_surface_stretched(ID, _location.x, _location.y, _size.x, _size.y);
					}
				}
			}
			
			// @argument			{Vector2} location?
			// @argument			{Scale} scale?
			// @argument			{color} color?
			// @argument			{real} alpha?
			// @description			Execute the tiled draw across the Room from the starting location.
			static render_tiled = function()
			{
				if (surface_exists(ID))
				{
					var _location = (argument_count >= 1 ? argument[0] : new Vector2(0, 0));
					
					if (argument_count > 1)
					{
						var _scale = (argument_count >= 2 ? argument[1] : new Scale());
						var _color = (argument_count >= 3 ? argument[2] : c_white);
						var _alpha = (argument_count >= 4 ? argument[3] : 1);
			
						draw_surface_tiled_ext(ID, _location.x, _location.y, _scale.x, 
											   _scale.y, _color, _alpha);
					}
					else
					{
						draw_surface_tiled(ID, _location.x, _location.y);
					}
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{Surface|surface} other
			// @argument			{Vector4} other_part?
			// @description			Copy content of other Surface to a specified location on this one.
			static copy = function(_location, _other)
			{
				self.create();
				
				if (surface_exists(ID))
				{
					var _sourceSurface = (instanceof(_other) == "Surface" ? _other.ID : _other);
			
					if (argument_count > 2)
					{
						var _other_part = argument[2];
						
						surface_copy_part(ID, _location.x, _location.y, _sourceSurface, 
										  _other_part.x1, _other_part.y1, _other_part.x2,
										  _other_part.y2);
					}
					else
					{
						surface_copy(ID, _location.x, _location.y, _sourceSurface);
					}
				}
			}
			
			// @argument			{string} filename
			// @argument			{Vector4} part?
			// @description			Save the content of this Surface to disk as a .png file.
			static save = function(_filename)
			{
				if (surface_exists(ID))
				{
					if (argument_count > 1)
					{
						var _part = argument[1];
						
						surface_save_part(ID, _filename, _part.x1, _part.y1, _part.x2, _part.y2);
					}
					else
					{
						surface_save(ID, _filename);
					}
				}
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		size = _size;
		
		ID = surface_create(size.x, size.y);
		
	#endregion
}
