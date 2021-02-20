/// @function				ParticleType()
///
/// @description			Construct a Particle Type resource, a particle configuration for creation
///							within Particle System.
///
///							Construction methods:
///							- New constructor
///							- Constructor copy: {ParticleType} other
function ParticleType() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				if ((argument_count > 0) and (instanceof(argument[0]) == "ParticleType"))
				{
					//|Construction method: Constructor copy.
					var _other = argument[0];
					
					ID = part_type_create();
					
					shape = pt_shape_pixel;
					
					if (_other.sprite != undefined)
					{
						self.setSprite(_other.sprite, _other.sprite_animate, _other.sprite_stretch,
									   _other.sprite_random);
					}
					else if (_other.shape != undefined)
					{
						self.setShape(_other.shape);
					}
					
					self.setSize(_other.size, _other.size_increase, _other.size_wiggle);
					self.setScale(_other.scale);
					self.setSpeed(_other.speed, _other.speed_increase, _other.speed_wiggle);
					self.setDirection(_other.direction, _other.direction_increase, 
									  _other.direction_wiggle);
					self.setOrientation(_other.orientation, _other.orientation_increase, 
										_other.orientation_wiggle, _other.orientation_relative);
					self.setGravity(_other.gravity_amount, _other.gravity_direction);
					self.setLife(_other.life);
					self.setBlend(_other.blend_additive);
					
					switch (_other.color_type)
					{
						case "color":
						case "Color2":
						case "Color3":
							self.setColor(_other.color);
						break;
						
						case "mix":
							self.setColor_mix(_other.color);
						break;
						
						case "rgb":
							self.setColor_rgb(_other.color[0], _other.color[1], _other.color[2]);
						break;
						
						case "hsv":
							self.setColor_hsv(_other.color[0], _other.color[1], _other.color[2]);
						break;
					}
					
					if (is_array(_other.alpha))
					{
						if (_other.alpha[2] != undefined)
						{
							self.setAlpha(_other.alpha[0], _other.alpha[1], _other.alpha[2]);
						}
						else if (_other.alpha[1] != undefined)
						{
							self.setAlpha(_other.alpha[0], _other.alpha[1]);
						}
						else
						{
							self.setAlpha(_other.alpha[0]);
						}
					}
					
					if (_other.step_type != undefined)
					{
						self.setStep(_other.step_type, _other.step_number);
					}
					
					if (_other.death_type != undefined)
					{
						self.setDeath(_other.death_type, _other.death_number);
					}
				}
				else
				{
					//|Construction method: New constructor.
					ID = part_type_create();
					
					shape = pt_shape_pixel;
					
					sprite = undefined;
					sprite_animate = false;
					sprite_stretch = false;
					sprite_random = false;
					
					size = 1;
					size_increase = 0;
					size_wiggle = 0;
					
					scale = new Scale(1, 1);
					
					speed = 1;
					speed_increase = 0;
					speed_wiggle = 0;
					
					direction = 0;
					direction_increase = 0;
					direction_wiggle = 0;
					
					orientation = 0;
					orientation_increase = 0;
					orientation_wiggle = 0;
					orientation_relative = false;
					
					gravity_amount = 0;
					gravity_direction = undefined;
					
					life = 100;
					
					blend_additive = false;
					
					color = c_white;
					color_type = "color";
					
					alpha = [1, undefined, undefined];	
					
					step_type = undefined;
					step_number = 0;
					
					death_type = undefined;
					death_number = 0;
				}
			}
			
			// @returns				{undefined}
			// @description			Remove the internal information from the memory.
			static destroy = function()
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					part_type_destroy(ID);
					
					ID = undefined;
				}
				
				return undefined;
			}
			
			// @description			Reset all properties to default.
			static clear = function()
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					part_type_clear(ID);
				}
				else
				{
					ID = part_type_create();
				}
				
				shape = pt_shape_pixel;
				
				sprite = undefined;
				sprite_animate = false;
				sprite_stretch = false;
				sprite_random = false;
				
				size = 1;
				size_increase = 0;
				size_wiggle = 0;
				
				scale = new Scale(1, 1);
				
				speed = 1;
				speed_increase = 0;
				speed_wiggle = 0;
				
				direction = 0;
				direction_increase = 0;
				direction_wiggle = 0;
				
				orientation = 0;
				orientation_increase = 0;
				orientation_wiggle = 0;
				orientation_relative = false;
				
				gravity_amount = 0;
				gravity_direction = undefined;
				
				life = 100;
				
				blend_additive = false;
				
				color = c_white;
				color_type = "color";
				
				alpha = [1, undefined, undefined];	
				
				step_type = undefined;
				step_number = 0;
				
				death_type = undefined;
				death_number = 0;
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{pt_shape_*} shape
			// @description			Set the shape property of this Particle Type.
			static setShape = function(_shape)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					shape = _shape;
					
					sprite = undefined;
					sprite_animate = false;
					sprite_stretch = false;
					sprite_random = false;
					
					part_type_shape(ID, shape);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setShape";
					var _errorText = ("Attempted to set a property of an invalid Particle Type:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Sprite} sprite
			// @argument			{bool} sprite_animate
			// @argument			{bool} sprite_stretch
			// @argument			{bool} sprite_random
			// @description			Set the sprite properties of this Particle Type.
			static setSprite = function(_sprite, _animate, _stretch, _random)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					sprite = _sprite;
					sprite_animate = ((_animate != undefined) ? _animate : false);
					sprite_stretch = ((_stretch != undefined) ? _stretch : false);
					sprite_random = ((_random != undefined) ? _random : false);
					
					shape = undefined;
					
					part_type_sprite(ID, sprite.ID, sprite_animate, sprite_stretch,
									 sprite_random);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setSprite";
					var _errorText = ("Attempted to set a property of an invalid Particle Type:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{real|Range} size
			// @argument			{real} increase?
			// @argument			{real} wiggle?
			// @description			Set the size properties of this Particle Type.
			static setSize = function(_size, _increase, _wiggle)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					size = _size;
					size_increase = ((_increase != undefined) ? _increase : 0);
					size_wiggle = ((_wiggle != undefined) ? _wiggle : 0);
					
					var _size_minimum, _size_maximum;
					
					if (instanceof(size) == "Range")
					{
						_size_minimum = size.minimum;
						_size_maximum = size.maximum;
					}
					else
					{
						_size_minimum = size;
						_size_maximum = size;
					}
					
					part_type_size(ID, _size_minimum, _size_maximum, 
								   size_increase, size_wiggle);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setSize";
					var _errorText = ("Attempted to set a property of an invalid Particle Type:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Scale} scale
			// @description			Set the scale property of this Particle Type.
			static setScale = function(_scale)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					scale = _scale;
					
					part_type_scale(ID, scale.x, scale.y);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setScale";
					var _errorText = ("Attempted to set a property of an invalid Particle Type:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{real|Range} speed
			// @argument			{real} speed_increase?
			// @argument			{real} speed_wiggle?
			// @description			Set the speed properties of this Particle Type.
			static setSpeed = function(_speed, _increase, _wiggle)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					speed = _speed;
					speed_increase = ((_increase != undefined) ? _increase : 0);
					speed_wiggle = ((_wiggle != undefined) ? _wiggle : 0);
					
					var _speed_minimum, _speed_maximum;
					
					if (instanceof(speed) == "Range")
					{
						_speed_minimum = speed.minimum;
						_speed_maximum = speed.maximum;
					}
					else
					{
						_speed_minimum = speed;
						_speed_maximum = speed;
					}
					
					part_type_speed(ID, _speed_minimum, _speed_maximum, 
									speed_increase, speed_wiggle);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setSpeed";
					var _errorText = ("Attempted to set a property of an invalid Particle Type:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{real|Angle|Range} direction
			// @argument			{real} increase?
			// @argument			{real} wiggle?
			// @description			Set the direction properties of this Particle Type.
			static setDirection = function(_direction, _increase, _wiggle)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{					
					direction = _direction
					direction_increase = ((_increase != undefined) ? _increase : 0);
					direction_wiggle = ((_wiggle != undefined) ? _wiggle : 0);
					
					var _direction_minimum, _direction_maximum;
					
					switch(instanceof(direction))
					{
						case "Range":
							_direction_minimum = direction.minimum;
							_direction_maximum = direction.maximum;
						break;
						
						case "Angle":
							_direction_minimum = direction.value;
							_direction_maximum = direction.value;
						break;
						
						default:
							_direction_minimum = direction;
							_direction_maximum = direction;
						break;
					}
					
					part_type_direction(ID, _direction_minimum, _direction_maximum, 
										direction_increase, direction_wiggle);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setDirection";
					var _errorText = ("Attempted to set a property of an invalid Particle Type:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{real|Range} orientation
			// @argument			{real} increase?
			// @argument			{real} wiggle?
			// @argument			{bool} relative?
			// @description			Set the orientation propierties of this Particle Type.
			static setOrientation = function(_orientation, _increase, _wiggle, _relative)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					orientation = _orientation;
					orientation_increase = ((_increase != undefined) ? _increase : 0);
					orientation_wiggle = ((_wiggle != undefined) ? _wiggle : 0);
					orientation_relative = ((_relative != undefined) ? _relative : false);
					
					var _orientation_minimum, _orientation_maximum;
					
					switch(instanceof(orientation))
					{
						case "Range":
							_orientation_minimum = orientation.minimum;
							_orientation_maximum = orientation.maximum;
						break;
						
						case "Angle":
							_orientation_minimum = orientation.value;
							_orientation_maximum = orientation.value;
						break;
						
						default:
							_orientation_minimum = orientation;
							_orientation_maximum = orientation;
						break;
					}
					
					part_type_orientation(ID, _orientation_minimum, _orientation_maximum, 
										  orientation_increase, orientation_wiggle, 
										  orientation_relative);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setOrientation";
					var _errorText = ("Attempted to set a property of an invalid Particle Type:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{real} amount
			// @argument			{Angle} direction
			// @description			Set the gravity properties of this Particle Type.
			static setGravity = function(_amount, _direction)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					gravity_amount = _amount;
					gravity_direction = _direction;
					
					part_type_gravity(ID, gravity_amount, gravity_direction.value);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setGravity";
					var _errorText = ("Attempted to set a property of an invalid Particle Type:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{int|Range} life
			// @description			Set the life length property of this Particle Type.
			static setLife = function(_life)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					life = _life;
					
					var _life_minimum, _life_maximum;
					
					if (instanceof(life) == "Range")
					{
						_life_minimum = life.minimum;
						_life_maximum = life.maximum;
					}
					else
					{
						_life_minimum = life;
						_life_maximum = life;
					}
					
					part_type_life(ID, _life_minimum, _life_maximum);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setLife";
					var _errorText = ("Attempted to set a property of an invalid Particle Type:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{bool} blend_additive
			// @description			Set the blending property of this Particle Type.
			static setBlend = function(_blend_additive)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					blend_additive = _blend_additive;
					
					part_type_blend(ID, blend_additive);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setBlend";
					var _errorText = ("Attempted to set a property of an invalid Particle Type:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{color|Color2|Color3} color
			// @description			Set the color property of this Particle Type to dynamic gradient
			//						change that has effect over the life time of this Particle Type.
			static setColor = function(_color)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					color = _color;
					
					switch(instanceof(color))
					{
						case "Color3":
							color_type = "Color3";
						
							part_type_color3(ID, color.color1, color.color2, 
											 color.color3);
						break;
						
						case "Color2":
							color_type = "Color2";
					
							part_type_color2(ID, color.color1, color.color2);
						break;
						
						default:
							color_type = "color";
						
							part_type_color1(ID, color);
						break;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setColor";
					var _errorText = ("Attempted to set a property of an invalid Particle Type:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Color2} colors
			// @description			Set the color property of this Particle Type to static
			//						random value between the two specified colors.
			static setColor_mix = function(_colors)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					color = _colors;
					color_type = "mix";
					
					part_type_color_mix(ID, color.color1, color.color2);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setColor_mix";
					var _errorText = ("Attempted to set a property of an invalid Particle Type:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{real|Range} red
			// @argument			{real|Range} green
			// @argument			{real|Range} blue
			// @description			Set the color property of this Particle Type to static 
			//						random value within the Ranges of specified RGB values.
			static setColor_rgb = function(_red, _green, _blue)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					color = [_red, _green, _blue];
					color_type = "rgb";
					
					var _red_minimum, _red_maximum, 
						_green_minimum, _green_maximum, 
						_blue_minimum, _blue_maximum;
					
					if (instanceof(_red) == "Range")
					{
						_red_minimum = _red.minimum;
						_red_maximum = _red.maximum;
					}
					else
					{
						_red_minimum = _red;
						_red_maximum = _red;
					}
					
					if (instanceof(_green) == "Range")
					{
						_green_minimum = _green.minimum;
						_green_maximum = _green.maximum;
					}
					else
					{
						_green_minimum = _green;
						_green_maximum = _green;
					}
					
					if (instanceof(_blue) == "Range")
					{
						_blue_minimum = _blue.minimum;
						_blue_maximum = _blue.maximum;
					}
					else
					{
						_blue_minimum = _blue;
						_blue_maximum = _blue;
					}
					
					part_type_color_rgb(ID, _red_minimum, _red_maximum,
										_green_minimum, _green_maximum, _blue_minimum,
										_blue_maximum);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setColor_rgb";
					var _errorText = ("Attempted to set a property of an invalid Particle Type:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
		
			// @argument			{real|Range} hue
			// @argument			{real|Range} saturation
			// @argument			{real|Range} value
			// @description			Set the color property of this Particle Type to static 
			//						random value within the Ranges of specified HSV values.
			static setColor_hsv = function(_hue, _saturation, _value)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					color = [_hue, _saturation, _value];
					color_type = "hsv";
					
					var _hue_minimum, _hue_maximum, 
						_saturation_minimum, _saturation_maximum, 
						_value_minimum, _value_maximum;
					
					if (instanceof(_hue) == "Range")
					{
						_hue_minimum = _hue.minimum;
						_hue_maximum = _hue.maximum;
					}
					else
					{
						_hue_minimum = _hue;
						_hue_maximum = _hue;
					}
					
					if (instanceof(_saturation) == "Range")
					{
						_saturation_minimum = _saturation.minimum;
						_saturation_maximum = _saturation.maximum;
					}
					else
					{
						_saturation_minimum = _saturation;
						_saturation_maximum = _saturation;
					}
					
					if (instanceof(_value) == "Range")
					{
						_value_minimum = _value.minimum;
						_value_maximum = _value.maximum;
					}
					else
					{
						_value_minimum = _value;
						_value_maximum = _value;
					}
					
					part_type_color_hsv(ID, _hue_minimum, _hue_maximum,
										_saturation_minimum, _saturation_maximum, 
										_value_minimum, _value_maximum);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setColor_hsv";
					var _errorText = ("Attempted to set a property of an invalid Particle Type:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @function			{real} alpha1
			// @function			{real} alpha2?
			// @function			{real} alpha3?
			// @description			Set the alpha property of this Particle Type.
			static setAlpha = function(_alpha1)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{				
					switch(argument_count)
					{
						case 1:
							alpha = [_alpha1, undefined, undefined];
					
							part_type_alpha1(ID, alpha[0]);
						break;
						
						case 2:
							alpha = [_alpha1, argument[1], undefined];
						
							part_type_alpha2(ID, alpha[0], alpha[1]);
						break;
						
						case 3:
							alpha = [_alpha1, argument[1], argument[2]];
						
							part_type_alpha3(ID, alpha[0], alpha[1], alpha[2]);
						break;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setAlpha";
					var _errorText = ("Attempted to set a property of an invalid Particle Type:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{ParticleType} step_type
			// @argument			{int} step_number
			// @description			Set the step stream properties of this Particle Type.
			static setStep = function(_step_type, _step_number)
			{
				if ((is_real(ID)) and (part_type_exists(ID)) and (_step_type != undefined)
				and (is_real(_step_type.ID)) and (ID != _step_type.ID) 
				and (part_type_exists(_step_type.ID)))
				{
					step_type = _step_type;
					step_number = _step_number;
					
					part_type_step(ID, step_number, step_type.ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setStep";
					var _errorText = ("Attempted to set a property of an invalid Particle Type:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{ParticleType} death_type
			// @argument			{int} death_number
			// @description			Set the death stream properties of this Particle Type.
			static setDeath = function(_death_type, _death_number)
			{
				if ((is_real(ID)) and (part_type_exists(ID)) and (_death_type != undefined)
				and (is_real(_death_type.ID)) and (ID != _death_type.ID) 
				and (part_type_exists(_death_type.ID)))
				{
					death_type = _death_type;
					death_number = _death_number;
					
					part_type_death(ID, death_number, death_type.ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setDeath";
					var _errorText = ("Attempted to set a property of an invalid Particle Type:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{ParticleSystem} particleSystem
			// @argument			{Vector2} location
			// @argument			{int} number?
			// @argument			{color} color?
			// @description			Directly create the particle(s) of this type in a space.
			static create = function(_particleSystem, _location, _number, _color)
			{
				if ((is_real(ID)) and (part_type_exists(ID)) and (_particleSystem != undefined)
				and (is_real(_particleSystem.ID)) and (part_system_exists(_particleSystem.ID)))
				{
					if (_number == undefined) {_number = 1;}
					
					if (_color != undefined)
					{
						part_particles_create_color(_particleSystem.ID, _location.x, _location.y,
													ID, _color, _number);
					}
					else
					{
						part_particles_create(_particleSystem.ID, _location.x, _location.y, 
											  ID, _number);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "create";
					var _errorText = ("Attempted to create particles using an invalid Particle " +
									  "Type or Particle System:\n" +
									  "Self: " + "{" + string(self) + "}" + "\n" +
									  "Target: " + "{" + string(_particleSystem) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{ParticleSystem} particleSystem
			// @argument			{Rectangle|Triangle|Line|Circle|Ellipse} shape
			// @argument			{int} number?
			// @argument			{color} color?
			// @description			Directly create the particle(s) of this within random
			//						spots of a Shape.
			static createShape = function(_particleSystem, _shape, _number, _color)
			{
				if ((is_real(ID)) and (part_type_exists(ID)) and (_particleSystem != undefined)
				and (is_real(_particleSystem.ID)) and (part_system_exists(_particleSystem.ID)))
				{
					if (_number == undefined) {_number = 1;}
					
					switch (instanceof(_shape))
					{	
						case "Rectangle":
							if (_color != undefined)
							{
								repeat (_number)
								{
									var _location_x = irandom_range(_shape.location.x1, 
																	_shape.location.x2);
									
									var _location_y = irandom_range(_shape.location.y1, 
																	_shape.location.y2);
									
									part_particles_create_color(_particleSystem.ID, _location_x,
																_location_y, ID, _color, 1);
								}
							}
							else
							{
								repeat (_number)
								{
									part_particles_create(_particleSystem.ID, 
														  irandom_range(_shape.location.x1, 
																		_shape.location.x2),
														  irandom_range(_shape.location.y1, 
																		_shape.location.y2), 
																		ID, 1);
								}
							}
						break;
						
						case "Triangle":
							if (_color != undefined)
							{
								repeat (_number)
								{
									var _random = random(1);
									var _sqrt = sqrt(random(1));
									
									var _location_x = ((1 - _sqrt) * _shape.location1.x) 
													+ ((_sqrt * (1 - _random)) * _shape.location2.x) 
													+ ((_sqrt * _random) * _shape.location3.x);
									
									var _location_y = ((1 - _sqrt) * _shape.location1.y) 
													+ ((_sqrt * (1 - _random)) * _shape.location2.y) 
													+ ((_sqrt * _random) * _shape.location3.y);
									
									part_particles_create_color(_particleSystem.ID, _location_x,
																_location_y, ID, _color, 1);
								}
							}
							else
							{
								repeat (_number)
								{
									var _random = random(1);
									var _sqrt = sqrt(random(1));
									
									var _location_x = ((1 - _sqrt) * _shape.location1.x) 
													+ ((_sqrt * (1 - _random)) * _shape.location2.x) 
													+ ((_sqrt * _random) * _shape.location3.x);
									
									var _location_y = ((1 - _sqrt) * _shape.location1.y) 
													+ ((_sqrt * (1 - _random)) * _shape.location2.y) 
													+ ((_sqrt * _random) * _shape.location3.y);
									
									part_particles_create(_particleSystem.ID, _location_x,
														  _location_y, ID, 1);
								}
							}
						break;
						
						case "Line":
							if (_color != undefined)
							{
								repeat (_number)
								{													
									var _length_particle = irandom_range(0, 
														   _shape.location.distance());
									
									var _angle = _shape.location.angle_1to2();
									
									var _location_x = (_shape.location.x1 
													+ lengthdir_x(_length_particle, _angle));
									
									var _location_y = (_shape.location.y1 
													+ lengthdir_y(_length_particle, _angle));
	 								
									part_particles_create_color(_particleSystem.ID, _location_x,
																_location_y, ID, _color, 1);
								}
							}
							else
							{
								repeat (_number)
								{													
									var _length_particle = irandom_range(0, 
														   _shape.location.distance());
									
									var _angle = _shape.location.angle_1to2();
									
									var _location_x = (_shape.location.x1 
													+ lengthdir_x(_length_particle, _angle));
									
									var _location_y = (_shape.location.y1 
													+ lengthdir_y(_length_particle, _angle));
	 								
									part_particles_create(_particleSystem.ID, _location_x,
														  _location_y, ID, 1);
								}
							}
						break;
						
						case "Circle":
							if (_color != undefined)
							{
								repeat (_number)
								{
									var _r = (_shape.radius * sqrt(random(1)));
									var _theta = (random(1) * 2 * pi);
									
									var _location_x = ceil((_shape.location.x
													+ (_r * cos(_theta))));
									
									var _location_y = ceil((_shape.location.y
													+ (_r * sin(_theta))));
									
									part_particles_create_color(_particleSystem.ID, _location_x, 
																_location_y, ID, _color, 1);
								}
							}
							else
							{
								repeat (_number)
								{
									var _r = (_shape.radius * sqrt(random(1)));
									var _theta = (random(1) * 2 * pi);
									
									var _location_x = ceil((_shape.location.x
													+ (_r * cos(_theta))));
									
									var _location_y = ceil((_shape.location.y
													+ (_r * sin(_theta))));
									
									part_particles_create(_particleSystem.ID, _location_x, 
														  _location_y, ID, 1);
								}
							}
						break;
						
						case "Ellipse":
							if (_color != undefined)
							{
								repeat (_number)
								{									
									var _width = ((max(_shape.location.x1, _shape.location.x2) 
											   - min(_shape.location.x1, _shape.location.x2)) / 2);
									
									var _height = ((max(_shape.location.y1, _shape.location.y2)
												- min(_shape.location.y1, _shape.location.y2)) / 2);
									
									var _angle = random(2 * pi);			
									var _point = random(1);
									
									var _location_x = mean(_shape.location.x1, _shape.location.x2) 
													+ ((sqrt(_point) * cos(_angle)) * (_width));
									
									var _location_y = mean(_shape.location.y1, _shape.location.y2) 
													+ ((sqrt(_point) * sin(_angle)) * (_height));
									
									part_particles_create_color(_particleSystem.ID, _location_x, 
																_location_y, ID, _color, 1);
								}
							}
							else
							{
								repeat (_number)
								{									
									var _width = ((max(_shape.location.x1, _shape.location.x2) 
											   - min(_shape.location.x1, _shape.location.x2)) / 2);
											   
									var _height = ((max(_shape.location.y1, _shape.location.y2)
												- min(_shape.location.y1, _shape.location.y2)) / 2);
									
									var _angle = random(2 * pi);			
									var _point = random(1);
									
									var _location_x = mean(_shape.location.x1, _shape.location.x2) 
													+ ((sqrt(_point) * cos(_angle)) * (_width));
									
									var _location_y = mean(_shape.location.y1, _shape.location.y2) 
													+ ((sqrt(_point) * sin(_angle)) * (_height));
									
									part_particles_create(_particleSystem.ID, _location_x, 
														  _location_y, ID, 1);
								}
							}
						break;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "createShape";
					var _errorText = ("Attempted to create particles using an invalid Particle " +
									  "Type or Particle System:\n" +
									  "Self: " + "{" + string(self) + "}" + "\n" +
									  "Target: " + "{" + string(_particleSystem) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
		
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the ID by default and can be
			//						configured to show the properties of this Particle Type.
			static toString = function(_full, _multiline)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					var _mark_separator = ((_multiline) ? "\n" : ", ");
					
					var _text_shape;
					switch (shape)
					{
						case pt_shape_pixel: _text_shape = "Pixel"; break;
						case pt_shape_disk: _text_shape = "Disk"; break;
						case pt_shape_square: _text_shape = "Square"; break;
						case pt_shape_line: _text_shape = "Line"; break;
						case pt_shape_star: _text_shape = "Star"; break;
						case pt_shape_circle: _text_shape = "Circle"; break;
						case pt_shape_ring: _text_shape = "Ring"; break;
						case pt_shape_sphere: _text_shape = "Sphere"; break;
						case pt_shape_flare: _text_shape = "Flare"; break;
						case pt_shape_spark: _text_shape = "Spark"; break;
						case pt_shape_explosion: _text_shape = "Explosion"; break;
						case pt_shape_cloud: _text_shape = "Cloud"; break;
						case pt_shape_smoke: _text_shape = "Smoke"; break;
						case pt_shape_snow: _text_shape = "Snow"; break;
						default: _text_shape = string(undefined); break;
					}
					
					if (_full)
					{
						var _string = "";
						
						var _text_color;
						
						if (is_real(color))
						{
							switch (color)
							{
								case c_aqua: _text_color = "Aqua"; break;
								case c_black: _text_color = "Black"; break;
								case c_blue: _text_color = "Blue"; break;
								case c_dkgray: _text_color = "Dark Gray"; break;
								case c_fuchsia: _text_color = "Fuchsia"; break;
								case c_gray: _text_color = "Gray"; break;
								case c_green: _text_color = "Green"; break;
								case c_lime: _text_color = "Lime"; break;
								case c_ltgray: _text_color = "Light Gray"; break;
								case c_maroon: _text_color = "Maroon"; break;
								case c_navy: _text_color = "Navy"; break;
								case c_olive: _text_color = "Olive"; break;
								case c_orange: _text_color = "Orange"; break;
								case c_purple: _text_color = "Purple"; break;
								case c_red: _text_color = "Red"; break;
								case c_teal: _text_color = "Teal"; break;
								case c_white: _text_color = "White"; break;
								case c_yellow: _text_color = "Yellow"; break;
							}
						}
						else
						{
							_text_color = string(color);
						}
						
						_string += ("ID: " + string(ID) + _mark_separator +
									"Shape: " + _text_shape + _mark_separator +
									"Sprite: " + string(sprite) + _mark_separator +
									"Sprite Animate: " + string(sprite_animate) + _mark_separator +
									"Sprite Stretch: " + string(sprite_stretch) + _mark_separator +
									"Sprite Random: " + string(sprite_random) + _mark_separator +
									"Size: " + string(size) + _mark_separator +
									"Size Increase: " + string(size_increase) + _mark_separator +
									"Size Wiggle: " + string(size_wiggle) + _mark_separator +
									"Scale: " + string(scale) + _mark_separator +
									"Speed: " + string(speed) + _mark_separator +
									"Speed Increase: " + string(speed_increase) + _mark_separator +
									"Speed Wiggle: " + string(speed_wiggle) + _mark_separator +
									"Direction: " + string(direction) + _mark_separator +
									"Direction Increase: " + string(direction_increase) 
														   + _mark_separator +
									"Direction Wiggle: " + string(direction_wiggle) 
														 + _mark_separator +
									"Orientation: " + string(orientation) + _mark_separator +
									"Orientation Increase: " + string(orientation_increase) 
															 + _mark_separator +
									"Orientation Wiggle: " + string(orientation_wiggle) 
														   + _mark_separator +
									"Orientation Relative: " + string(orientation_relative) 
															 + _mark_separator +
									"Gravity Amount: " + string(gravity_amount) + _mark_separator +
									"Gravity Direction: " + string(gravity_direction) 
														  + _mark_separator +
									"Life: " + string(life) + _mark_separator +
									"Additive Blending: " + string(blend_additive) 
														  + _mark_separator +
									"Color Type: " + string(color_type) + _mark_separator +
									"Color: " + _text_color + _mark_separator +
									"Alpha: " + string(alpha) + _mark_separator +
									"Step Type: " + string(step_type) + _mark_separator +
									"Step Number: " + string(step_number) + _mark_separator +
									"Death Type: " + string(death_type) + _mark_separator +
									"Death Number: " + string(death_number));
						
						return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
					}
					else
					{
						var _text_visualType = ((sprite != undefined) ? "Sprite: " + string(sprite)
																	  : "Shape: " +
																	    _text_shape);				
						
						if (_multiline)
						{
							return ("ID: " + string(ID) + _mark_separator + _text_visualType);
						}
						else
						{
							return (instanceof(self) + "(" + "ID: " + string(ID) + 
									_mark_separator + _text_visualType + ")");
						}
					}
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
		
		#endregion
	#endregion
	#region [Constructor]
		
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
