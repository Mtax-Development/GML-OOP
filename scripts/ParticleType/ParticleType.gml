/// @function				ParticleType()
///							
/// @description			Construct a Particle Type resource, a particle configuration for creation
///							within Particle Systems.
///							
///							Construction types:
///							- New constructor
///							- Constructor copy: {ParticleType} other
function ParticleType() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				ID = undefined;
				
				shape = undefined;
				
				sprite = undefined;
				sprite_animate = undefined;
				sprite_matchAnimation = undefined;
				sprite_randomize = undefined;
				
				scale = undefined;
				
				size = undefined;
				size_increase = undefined;
				size_wiggle = undefined;
				
				speed = undefined;
				speed_increase = undefined;
				speed_wiggle = undefined;
				
				direction = undefined;
				direction_increase = undefined;
				direction_wiggle = undefined;
				
				angle = undefined;
				angle_increase = undefined;
				angle_wiggle = undefined;
				angle_relative = undefined;
				
				gravity = undefined;
				gravity_direction = undefined;
				
				color = undefined;
				color_type = undefined;
				
				blend_additive = undefined;
				
				alpha = [];
				
				life = undefined;
				
				step_type = undefined;
				step_number = undefined;
				
				death_type = undefined;
				death_number = undefined;
				
				event =
				{
					beforeCreation:
					{
						callback: undefined,
						argument: undefined
					},
					
					afterCreation:
					{
						callback: undefined,
						argument: undefined
					}
				};
				
				if ((argument_count > 0) and (instanceof(argument[0]) == "ParticleType"))
				{
					//|Construction type: Constructor copy.
					var _other = argument[0];
					
					ID = part_type_create();
					
					shape = _other.shape;
					
					sprite = ((instanceof(_other.sprite) == "Sprite") ? new Sprite(_other.sprite.ID)
																	  : _other.sprite);
					sprite_animate = _other.sprite_animate;
					sprite_matchAnimation = _other.sprite_matchAnimation;
					
					scale = new Scale(_other.scale);
					
					size = ((instanceof(_other.sprite) == "Range") ? new Range(_other.size)
																   : _other.size);
					
					speed = ((instanceof(_other.speed) == "Range") ? new Range(_other.speed)
																   : _other.speed);
					switch (instanceof(_other.direction))
					{
						case "Range":
							direction = new Range(_other.direction);
						break;
						
						case "Angle":
							direction = new Angle(_other.direction);
						break;
						
						default:
							direction = _other.direction;
						break;
					}
					
					direction_increase = _other.direction_increase;
					direction_wiggle = _other.direction_wiggle;
					
					switch (instanceof(_other.angle))
					{
						case "Range":
							angle = new Range(_other.angle);
						break;
						
						case "Angle":
							angle = new Angle(_other.angle);
						break;
						
						default:
							angle = _other.angle;
						break;
					}
					
					angle_increase = _other.angle_increase;
					angle_wiggle = _other.angle_wiggle;
					angle_relative = _other.angle_relative;
					
					switch (instanceof(_other.gravity))
					{
						case "Range":
							gravity = new Range(_other.gravity);
						break;
						
						case "Angle":
							gravity = new Angle(_other.gravity);
						break;
						
						default:
							gravity = _other.gravity;
						break;
					}
					
					gravity_direction = _other.gravity_direction;
					
					switch (instanceof(_other.color))
					{
						case "Color2":
							color = new Color2(_other.color);
						break;
						
						case "Color3":
							color = new Color3(_other.color);
						break;
						
						default:
							color = _other.color;
						break
					}
					
					color_type = _other.color_type;
					
					blend_additive = _other.blend_additive;
					
					if (is_array(_other.alpha))
					{
						array_copy(alpha, 0, _other.alpha, 0, array_length(_other.alpha));
					}
					else
					{
						alpha = _other.alpha;
					}
					
					life = _other.life;
					
					step_type = _other.step_type;
					step_number = _other.step_number;
					
					death_type = _other.death_type;
					death_number = _other.death_number
					
					if (sprite != undefined)
					{
						self.setSprite(sprite, sprite_animate, sprite_matchAnimation,
									   sprite_randomize);
					}
					else if (shape != undefined)
					{
						self.setShape(shape);
					}
					
					self.setScale(scale);
					self.setSize(size, size_increase, size_wiggle);
					self.setSpeed(speed, speed_increase, speed_wiggle);
					self.setDirection(direction, direction_increase, direction_wiggle);
					self.setAngle(angle, angle_increase, angle_wiggle, angle_relative);
					self.setGravity(gravity, gravity_direction);
					
					switch (color_type)
					{
						case "color":
						case "Color2":
						case "Color3":
							self.setColor(color);
						break;
						
						case "mix":
							self.setColorMix(color);
						break;
						
						case "RGB":
							self.setColorRGB(color[0], color[1], color[2]);
						break;
						
						case "HSV":
							self.setColorHSV(color[0], color[1], color[2]);
						break;
					}
					
					self.setBlend(blend_additive);
					
					if (alpha[2] != undefined)
					{
						self.setAlpha(_other.alpha[0], _other.alpha[1], _other.alpha[2]);
					}
					else if (alpha[1] != undefined)
					{
						self.setAlpha(_other.alpha[0], _other.alpha[1]);
					}
					else
					{
						self.setAlpha(_other.alpha[0]);
					}
					
					self.setLife(life);
					
					if (step_type != undefined)
					{
						self.setStep(step_type, step_number);
					}
					
					if (death_type != undefined)
					{
						self.setDeath(death_type, death_number);
					}
					
					if (is_struct(_other.event))
					{
						event = {};
						
						var _eventList = variable_struct_get_names(_other.event);
						
						var _i = [0, 0];
						repeat (array_length(_eventList))
						{
							var _event = {};
							var _other_event = variable_struct_get(_other.event, _eventList[_i[0]]);
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
					ID = part_type_create();
					
					shape = pt_shape_pixel;
					
					sprite = undefined;
					sprite_animate = false;
					sprite_matchAnimation = false;
					sprite_randomize = false;
					
					scale = new Scale(1, 1);
					
					size = 1;
					size_increase = 0;
					size_wiggle = 0;
					
					speed = 1;
					speed_increase = 0;
					speed_wiggle = 0;
					
					direction = new Angle(0);
					direction_increase = 0;
					direction_wiggle = 0;
					
					angle = new Angle(0);
					angle_increase = 0;
					angle_wiggle = 0;
					angle_relative = false;
					
					gravity = 0;
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
				
				return self;
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (part_type_exists(ID)));
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
				sprite_matchAnimation = false;
				sprite_randomize = false;
				
				scale = new Scale(1, 1);
				
				size = 1;
				size_increase = 0;
				size_wiggle = 0;
				
				speed = 1;
				speed_increase = 0;
				speed_wiggle = 0;
				
				direction = 0;
				direction_increase = 0;
				direction_wiggle = 0;
				
				angle = 0;
				angle_increase = 0;
				angle_wiggle = 0;
				angle_relative = false;
				
				gravity = 0;
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
				
				return self;
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{constant:pt_shape_*} shape
			// @description			Set the shape property of this Particle Type, which replaces its
			//						Sprite if it is set.
			static setShape = function(_shape)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					shape = _shape;
					
					sprite = undefined;
					sprite_animate = false;
					sprite_matchAnimation = false;
					sprite_randomize = false;
					
					part_type_shape(ID, shape);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setShape";
					var _errorText = ("Attempted to set a property of an invalid Particle Type: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{Sprite} sprite
			// @argument			{bool} animate?
			// @argument			{bool} matchAnimation?
			// @argument			{bool} random?
			// @description			Set the Sprite properties of particles of this Particle Type,
			//						which replaces its shape is it is set.
			//						The Sprite can be animated using its own animation speed, unless
			//						it is set to match the life time of this Particle Type. The
			//						animation will play from either the start to finish or randomized
			//						frames if specified.
			static setSprite = function(_sprite, _animate = false, _matchAnimation = false,
										_randomize = false)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					sprite = _sprite;
					sprite_animate = _animate;
					sprite_matchAnimation = _matchAnimation;
					sprite_randomize = _randomize;
					
					shape = undefined;
					
					part_type_sprite(ID, sprite.ID, sprite_animate, sprite_matchAnimation,
									 sprite_randomize);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setSprite";
					var _errorText = ("Attempted to set a property of an invalid Particle Type: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{Scale} scale
			// @description			Set the Scale of particles of this Particle Type, which stretches
			//						them on the x and y axes.
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
					var _errorText = ("Attempted to set a property of an invalid Particle Type: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{real|Range} size
			// @argument			{real} increase?
			// @argument			{real} wiggle?
			// @description			Set the size properties of this Particle Type, which multiplies
			//						the Scale of the particles.
			static setSize = function(_size, _increase = 0, _wiggle = 0)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					size = _size;
					size_increase = _increase;
					size_wiggle = _wiggle;
					
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
					
					part_type_size(ID, _size_minimum, _size_maximum, size_increase, size_wiggle);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setSize";
					var _errorText = ("Attempted to set a property of an invalid Particle Type: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{real|Range} speed
			// @argument			{real} speed_increase?
			// @argument			{real} speed_wiggle?
			// @description			Set the movement speed properties of particles of this Particle
			//						Type, indicating how fast each will move towards its direction.
			static setSpeed = function(_speed, _increase = 0, _wiggle = 0)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					speed = _speed;
					speed_increase = _increase;
					speed_wiggle = _wiggle;
					
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
					
					part_type_speed(ID, _speed_minimum, _speed_maximum, speed_increase,
									speed_wiggle);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setSpeed";
					var _errorText = ("Attempted to set a property of an invalid Particle Type: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{Angle|Range} direction
			// @argument			{real} increase?
			// @argument			{real} wiggle?
			// @description			Set the movemement direction properties of particle of this
			//						Particle Type, which is applied only while the partices have
			//						any speed, otherwise equaling 0.
			static setDirection = function(_direction, _increase = 0, _wiggle = 0)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{					
					direction = _direction;
					direction_increase = _increase;
					direction_wiggle = _wiggle;
					
					var _direction_minimum, _direction_maximum;
					
					switch (instanceof(direction))
					{
						case "Range":
							_direction_minimum = direction.minimum;
							_direction_maximum = direction.maximum;
						break;
						
						case "Angle":
							_direction_minimum = direction.value;
							_direction_maximum = direction.value;
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
					var _errorText = ("Attempted to set a property of an invalid Particle Type: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{Angle|Range} angle
			// @argument			{real} increase?
			// @argument			{real} wiggle?
			// @argument			{bool} relative?
			// @description			Set the Angle propierties of the particle of this Particle Type,
			//						which rotates their visual representation.
			//						The Angle can be specified to be relative to the direction that
			//						is applied only if the particle currently has any speed.
			static setAngle = function(_angle, _increase = 0, _wiggle = 0, _relative = false)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					angle = _angle;
					angle_increase = _increase;
					angle_wiggle = _wiggle;
					angle_relative = _relative;
					
					var _angle_minimum, _angle_maximum;
					
					switch (instanceof(angle))
					{
						case "Range":
							_angle_minimum = angle.minimum;
							_angle_maximum = angle.maximum;
						break;
						
						case "Angle":
							_angle_minimum = angle.value;
							_angle_maximum = angle.value;
						break;
					}
					
					part_type_orientation(ID, _angle_minimum, _angle_maximum, angle_increase,
										  angle_wiggle, angle_relative);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setAngle";
					var _errorText = ("Attempted to set a property of an invalid Particle Type: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{real} value
			// @argument			{Angle} direction?
			// @description			Set the gravity properties of the particles of this Particle
			//						Type, which will move particles towards the specified direction,
			//						in addition to its own speed.
			static setGravity = function(_value, _direction)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					gravity = _value;
					
					if (instanceof(_direction) == "Angle")
					{
						gravity_direction = _direction
					}
					else if (instanceof(gravity_direction) != "Angle")
					{
						gravity_direction = new Angle(270);
					}
					
					part_type_gravity(ID, gravity, gravity_direction.value);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setGravity";
					var _errorText = ("Attempted to set a property of an invalid Particle Type: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{int|Range} life
			// @description			Set the life length property of particles of this Particle Type,
			//						which is the amount of steps after which they are destroyed.
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
					var _errorText = ("Attempted to set a property of an invalid Particle Type: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{int:color|Color2|Color3} color
			// @description			Set the color property of this particles of this Particle Type to
			//						either one static color or a gradual gradient color change over
			//						the life time of each particle.
			static setColor = function(_color)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					color = _color;
					
					switch (instanceof(color))
					{
						case "Color3":
							color_type = "Color3";
						
							part_type_color3(ID, color.color1, color.color2, color.color3);
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
					var _errorText = ("Attempted to set a property of an invalid Particle Type: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{Color2} colors
			// @description			Set the color property of this Particle Type to a random static
			//						value between two colors.
			static setColorMix = function(_colors)
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
					var _methodName = "setColorMix";
					var _errorText = ("Attempted to set a property of an invalid Particle Type: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{real|Range} red
			// @argument			{real|Range} green
			// @argument			{real|Range} blue
			// @description			Set the color property of the particles of this Particle Type to
			//						a static value made from a set of three RGB values, each being
			//						either a static value or randomized from a 0-255 Range.
			static setColorRGB = function(_red, _green, _blue)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					color = [_red, _green, _blue];
					color_type = "RGB";
					
					var _red_minimum, _red_maximum, _green_minimum, _green_maximum, _blue_minimum,
						_blue_maximum;
					
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
					
					part_type_color_rgb(ID, _red_minimum, _red_maximum, _green_minimum,
										_green_maximum, _blue_minimum, _blue_maximum);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setColorRGB";
					var _errorText = ("Attempted to set a property of an invalid Particle Type: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{real|Range} hue
			// @argument			{real|Range} saturation
			// @argument			{real|Range} value
			// @description			Set the color property of the particles of this Particle Type to
			//						a static value made from a set of three HSV values, each being
			//						either a static value or randomized from a 0-255 Range.
			static setColorHSV = function(_hue, _saturation, _value)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					color = [_hue, _saturation, _value];
					color_type = "HSV";
					
					var _hue_minimum, _hue_maximum, _saturation_minimum, _saturation_maximum,
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
					
					part_type_color_hsv(ID, _hue_minimum, _hue_maximum, _saturation_minimum,
										_saturation_maximum, _value_minimum, _value_maximum);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setColorHSV";
					var _errorText = ("Attempted to set a property of an invalid Particle Type: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{bool} blend_additive
			// @description			Set the additive blending property of particles of this Particle
			//						Type, which alters their rendering when their locations overlap.
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
					var _errorText = ("Attempted to set a property of an invalid Particle Type: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{real} value1
			// @argument			{real} value2?
			// @argument			{real} value3?
			// @description			Set the alpha property of particle of this Particle Type to
			//						either one static value or a gradual change over the life time
			//						of each particle.
			static setAlpha = function()
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					switch (argument_count)
					{
						case 1:
							alpha = [argument[0], undefined, undefined];
							
							part_type_alpha1(ID, alpha[0]);
						break;
						
						case 2:
							alpha = [argument[0], argument[1], undefined];
							
							part_type_alpha2(ID, alpha[0], alpha[1]);
						break;
						
						case 3:
							alpha = [argument[0], argument[1], argument[2]];
							
							part_type_alpha3(ID, alpha[0], alpha[1], alpha[2]);
						break;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setAlpha";
					var _errorText = ("Attempted to set a property of an invalid Particle Type: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{ParticleType} type
			// @argument			{int} number
			// @description			Set the step stream properties of particles of this Particle
			//						Type, which will cause them to stream the particles of other
			//						Particle Type each step.
			static setStep = function(_step_type, _step_number)
			{
				if ((is_real(ID)) and (part_type_exists(ID))
				and (instanceof(_step_type) == "ParticleType") and (is_real(_step_type.ID))
				and (ID != _step_type.ID) and (part_type_exists(_step_type.ID)))
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
					var _errorText = ("Attempted to set a property of an invalid Particle Type: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{ParticleType} type
			// @argument			{int} number
			// @description			Set the death stream properties of particles of this Particle
			//						Type, which will cause them to stream the particles of other
			//						Particle Type once when their life time ends.
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
					var _errorText = ("Attempted to set a property of an invalid Particle Type: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{ParticleSystem} particleSystem
			// @argument			{Vector2} location
			// @argument			{int} number?
			// @argument			{int:color} color?
			// @description			Directly create any number of Particles of this type in the
			//						specified location.
			static create = function(_particleSystem, _location, _number = 1, _color)
			{
				if ((is_real(ID)) and (part_type_exists(ID)) and (_particleSystem != undefined)
				and (is_real(_particleSystem.ID)) and (part_system_exists(_particleSystem.ID)))
				{
					if ((is_struct(event)) and (event.beforeCreation.callback != undefined))
					{
						var _callback = ((is_array(event.beforeCreation.callback))
										 ? event.beforeCreation.callback
										 : [event.beforeCreation.callback]);
						var _callback_count = array_length(_callback);
						var _argument = ((is_array(event.beforeCreation.argument))
										 ? event.beforeCreation.argument
										 : array_create(_callback_count,
														event.beforeCreation.argument));
						
						var _i = 0;
						repeat (_callback_count)
						{
							if (is_method(_callback[_i]))
							{
								script_execute_ext(method_get_index(_callback[_i]),
												   ((is_array(_argument[_i]) ? _argument[_i]
																			 : [_argument[_i]])));
							}
							
							++_i;
						}
					}
					
					if (_color != undefined)
					{
						part_particles_create_color(_particleSystem.ID, _location.x, _location.y, ID,
													_color, _number);
					}
					else
					{
						part_particles_create(_particleSystem.ID, _location.x, _location.y, ID,
											  _number);
					}
					
					if ((is_struct(event)) and (event.afterCreation.callback != undefined))
					{
						var _callback = ((is_array(event.afterCreation.callback))
										 ? event.afterCreation.callback
										 : [event.afterCreation.callback]);
						var _callback_count = array_length(_callback);
						var _argument = ((is_array(event.afterCreation.argument))
										 ? event.afterCreation.argument
										 : array_create(_callback_count,
														event.afterCreation.argument));
						
						var _i = 0;
						repeat (_callback_count)
						{
							if (is_method(_callback[_i]))
							{
								script_execute_ext(method_get_index(_callback[_i]),
												   ((is_array(_argument[_i]) ? _argument[_i]
																			 : [_argument[_i]])));
							}
							
							++_i;
						}
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
				
				return self;
			}
			
			// @argument			{ParticleSystem} particleSystem
			// @argument			{Circle|Ellipse|Line|Rectangle|Triangle} shape
			// @argument			{int} number?
			// @argument			{int:color} color?
			// @description			Directly create any number of Particles of this type in random
			//						locations within the specified Shape.
			static createShape = function(_particleSystem, _shape, _number = 1, _color)
			{
				if ((is_real(ID)) and (part_type_exists(ID)) and (_particleSystem != undefined)
				and (is_real(_particleSystem.ID)) and (part_system_exists(_particleSystem.ID)))
				{
					if ((is_struct(event)) and (event.beforeCreation.callback != undefined))
					{
						var _callback = ((is_array(event.beforeCreation.callback))
										 ? event.beforeCreation.callback
										 : [event.beforeCreation.callback]);
						var _callback_count = array_length(_callback);
						var _argument = ((is_array(event.beforeCreation.argument))
										 ? event.beforeCreation.argument
										 : array_create(_callback_count,
														event.beforeCreation.argument));
						
						var _i = 0;
						repeat (_callback_count)
						{
							if (is_method(_callback[_i]))
							{
								script_execute_ext(method_get_index(_callback[_i]),
												   ((is_array(_argument[_i]) ? _argument[_i]
																			 : [_argument[_i]])));
							}
							
							++_i;
						}
					}
					
					switch (instanceof(_shape))
					{	
						case "Rectangle":
							if (is_real(_color))
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
							if (is_real(_color))
							{
								repeat (_number)
								{
									var _random = random(1);
									var _sqrt = sqrt(random(1));
									
									var _location_x = ((1 - _sqrt) * _shape.location1.x) 
													   + ((_sqrt * (1 - _random))
													   * _shape.location2.x) + ((_sqrt * _random)
													   * _shape.location3.x);
									
									var _location_y = ((1 - _sqrt) * _shape.location1.y) 
													   + ((_sqrt * (1 - _random))
													   * _shape.location2.y) + ((_sqrt * _random)
													   * _shape.location3.y);
									
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
													   + ((_sqrt * (1 - _random))
													   * _shape.location2.x) + ((_sqrt * _random)
													   * _shape.location3.x);
									
									var _location_y = ((1 - _sqrt) * _shape.location1.y) 
													   + ((_sqrt * (1 - _random))
													   * _shape.location2.y) 
													   + ((_sqrt * _random) * _shape.location3.y);
									
									part_particles_create(_particleSystem.ID, _location_x,
														  _location_y, ID, 1);
								}
							}
						break;
						
						case "Line":
							if (is_real(_color))
							{
								var _distance = point_distance(_shape.location.x1,
															   _shape.location.y1,
															   _shape.location.x2,
															   _shape.location.y2);
								var _angle = point_direction(_shape.location.x1, _shape.location.y1,
															 _shape.location.x2, _shape.location.y2);
								var _side_angle = (_angle + 90);
								var _side_length = (_shape.size * 0.5);
								
								repeat (_number)
								{
									var _length = irandom_range(0, _distance);
									
									var _location_x = (_shape.location.x1 
													   + lengthdir_x(_length, _angle));
									
									var _location_y = (_shape.location.y1 
													   + lengthdir_y(_length, _angle));
									
									var _side_position = irandom_range(-_side_length, _side_length);
									
									_location_x += lengthdir_x(_side_position, _side_angle);
									_location_y += lengthdir_y(_side_position, _side_angle);
	 								
									part_particles_create_color(_particleSystem.ID, _location_x,
																_location_y, ID, _color, 1);
								}
							}
							else
							{
								var _distance = point_distance(_shape.location.x1,
															   _shape.location.y1,
															   _shape.location.x2,
															   _shape.location.y2);
								var _angle = point_direction(_shape.location.x1, _shape.location.y1,
															 _shape.location.x2, _shape.location.y2);
								var _side_angle = (_angle + 90);
								var _side_length = (_shape.size * 0.5);
								
								repeat (_number)
								{
									var _length = irandom_range(0, _distance);
									
									var _location_x = (_shape.location.x1 
													   + lengthdir_x(_length, _angle));
									
									var _location_y = (_shape.location.y1 
													   + lengthdir_y(_length, _angle));
									
									var _side_position = irandom_range(-_side_length, _side_length);
									
									_location_x += lengthdir_x(_side_position, _side_angle);
									_location_y += lengthdir_y(_side_position, _side_angle);
	 								
									part_particles_create(_particleSystem.ID, _location_x,
														  _location_y, ID, 1);
								}
							}
						break;
						
						case "Circle":
							if (is_real(_color))
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
							if (is_real(_color))
							{
								var _size_x = ((max(_shape.location.x1, _shape.location.x2)
												- min(_shape.location.x1, _shape.location.x2))
											   * 0.5);
								
								var _size_y = ((max(_shape.location.y1, _shape.location.y2)
												- min(_shape.location.y1, _shape.location.y2))
											   * 0.5);
								
								repeat (_number)
								{
									var _angle = random((2 * pi));
									var _point = random(1);
									
									var _location_x = (mean(_shape.location.x1, _shape.location.x2)
													   + ((sqrt(_point) * cos(_angle)) * _size_x));
									
									var _location_y = (mean(_shape.location.y1, _shape.location.y2)
													   + ((sqrt(_point) * sin(_angle)) * _size_y));
									
									part_particles_create_color(_particleSystem.ID, _location_x,
																_location_y, ID, _color, 1);
								}
							}
							else
							{
								var _size_x = ((max(_shape.location.x1, _shape.location.x2)
												- min(_shape.location.x1, _shape.location.x2))
											   * 0.5);
								
								var _size_y = ((max(_shape.location.y1, _shape.location.y2)
												- min(_shape.location.y1, _shape.location.y2))
											   * 0.5);
								
								repeat (_number)
								{
									var _angle = random((2 * pi));
									var _point = random(1);
									
									var _location_x = (mean(_shape.location.x1, _shape.location.x2)
													   + ((sqrt(_point) * cos(_angle)) * _size_x));
									
									var _location_y = (mean(_shape.location.y1, _shape.location.y2)
													   + ((sqrt(_point) * sin(_angle)) * _size_y));
									
									part_particles_create(_particleSystem.ID, _location_x,
														  _location_y, ID, 1);
								}
							}
						break;
					}
					
					if ((is_struct(event)) and (event.afterCreation.callback != undefined))
					{
						var _callback = ((is_array(event.afterCreation.callback))
										 ? event.afterCreation.callback
										 : [event.afterCreation.callback]);
						var _callback_count = array_length(_callback);
						var _argument = ((is_array(event.afterCreation.argument))
										 ? event.afterCreation.argument
										 : array_create(_callback_count,
														event.afterCreation.argument));
						
						var _i = 0;
						repeat (_callback_count)
						{
							if (is_method(_callback[_i]))
							{
								script_execute_ext(method_get_index(_callback[_i]),
												   ((is_array(_argument[_i]) ? _argument[_i]
																			 : [_argument[_i]])));
							}
							
							++_i;
						}
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
				
				return self;
			}
		
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @argument			{bool} full?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the properties of this Particle
			//						Type.
			static toString = function(_multiline = false, _full = false)
			{
				if ((is_real(ID)) and (part_type_exists(ID)))
				{
					var _string = "";
					var _mark_separator = ((_multiline) ? "\n" : ", ");
					
					var _string_shape;
					switch (shape)
					{
						case pt_shape_pixel: _string_shape = "Pixel"; break;
						case pt_shape_disk: _string_shape = "Disk"; break;
						case pt_shape_square: _string_shape = "Square"; break;
						case pt_shape_line: _string_shape = "Line"; break;
						case pt_shape_star: _string_shape = "Star"; break;
						case pt_shape_circle: _string_shape = "Circle"; break;
						case pt_shape_ring: _string_shape = "Ring"; break;
						case pt_shape_sphere: _string_shape = "Sphere"; break;
						case pt_shape_flare: _string_shape = "Flare"; break;
						case pt_shape_spark: _string_shape = "Spark"; break;
						case pt_shape_explosion: _string_shape = "Explosion"; break;
						case pt_shape_cloud: _string_shape = "Cloud"; break;
						case pt_shape_smoke: _string_shape = "Smoke"; break;
						case pt_shape_snow: _string_shape = "Snow"; break;
						default: _string_shape = string(undefined); break;
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
							default: _string_color = string(color); break;
						}
						
						var _string_blend = "None";
						
						if (blend_additive)
						{
							_string_blend = "Additive";
						}
						
						_string = ("ID: " + string(ID) + _mark_separator +
								   "Shape: " + _string_shape + _mark_separator +
								   "Sprite: " + string(sprite) + _mark_separator +
								   "Sprite Animate: " + string(sprite_animate) + _mark_separator +
								   "Sprite Match Animation: " + string(sprite_matchAnimation)
								   							  + _mark_separator +
								   "Sprite Randomize: " + string(sprite_randomize)
														+ _mark_separator +
								   "Scale: " + string(scale) + _mark_separator +
								   "Size: " + string(size) + _mark_separator +
								   "Size Increase: " + string(size_increase) + _mark_separator +
								   "Size Wiggle: " + string(size_wiggle) + _mark_separator +
								   "Speed: " + string(speed) + _mark_separator +
								   "Speed Increase: " + string(speed_increase) + _mark_separator +
								   "Speed Wiggle: " + string(speed_wiggle) + _mark_separator +
								   "Direction: " + string(direction) + _mark_separator +
								   "Direction Increase: " + string(direction_increase) 
								   						  + _mark_separator +
								   "Direction Wiggle: " + string(direction_wiggle) 
								   						+ _mark_separator +
								   "Angle: " + string(angle) + _mark_separator +
								   "Angle Increase: " + string(angle_increase) + _mark_separator +
								   "Angle Wiggle: " + string(angle_wiggle) + _mark_separator +
								   "Angle Relative: " + string(angle_relative) + _mark_separator +
								   "Gravity Value: " + string(gravity) + _mark_separator +
								   "Gravity Direction: " + string(gravity_direction) 
								   						 + _mark_separator +
								   "Color Type: " + string(color_type) + _mark_separator +
								   "Color: " + _string_color + _mark_separator +
								   "Blending: " + _string_blend + _mark_separator +
								   "Alpha: " + string(alpha) + _mark_separator +
								   "Life: " + string(life) + _mark_separator +
								   "Step Type: " + string(step_type) + _mark_separator +
								   "Step Number: " + string(step_number) + _mark_separator +
								   "Death Type: " + string(death_type) + _mark_separator +
								   "Death Number: " + string(death_number));
					}
					else
					{
						var _string_visualType = "";
						
						if (instanceof(sprite) == "Sprite")
						{
							_string_visualType = (_mark_separator + "Sprite: " + string(sprite));
						}
						else if (is_real(shape))
						{
							_string_visualType = (_mark_separator + "Shape: " + _string_shape);
						}
						
						_string = ("ID: " + string(ID) + _string_visualType);
					}
					
					return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
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

