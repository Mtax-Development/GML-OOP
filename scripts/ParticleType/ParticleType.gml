//  @function				ParticleType()
/// @description			Constructs a Particle Type resource storing particle configuration for
///							creation within Particle Systems.
//							
//							Construction types:
//							- New constructor
//							- Empty: {undefined}
//							- Constructor copy: other {ParticleType}
function ParticleType() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
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
				
				if (argument_count > 0)
				{
					if (is_instanceof(argument[0], ParticleType))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						ID = part_type_create();
						shape = _other.shape;
						sprite = ((is_instanceof(_other.sprite, Sprite))
								  ? new Sprite(_other.sprite.ID) : _other.sprite);
						sprite_animate = _other.sprite_animate;
						sprite_matchAnimation = _other.sprite_matchAnimation;
						scale = new Scale(_other.scale);
						size = ((is_instanceof(_other.size, Range)) ? new Range(_other.size)
																	: _other.size);
						speed = ((is_instanceof(_other.speed, Range)) ? new Range(_other.speed)
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
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_handle(ID)) and (part_type_exists(ID)));
			}
			
			/// @returns			{undefined}
			/// @description		Remove the internal information from the memory.
			static destroy = function()
			{
				if (self.isFunctional())
				{
					part_type_destroy(ID);
					
					ID = undefined;
				}
				
				return undefined;
			}
			
			/// @description		Reset all properties to default.
			static clear = function()
			{
				if (self.isFunctional())
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
			
			/// @argument			shape {constant:pt_shape_*}
			/// @description		Set the shape property of this Particle Type, which replaces its
			///						Sprite if it is set.
			static setShape = function(_shape)
			{
				try
				{
					part_type_shape(ID, _shape);
					
					shape = _shape;
					sprite = undefined;
					sprite_animate = false;
					sprite_matchAnimation = false;
					sprite_randomize = false;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setShape()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			sprite {Sprite}
			/// @argument			animate? {bool}
			/// @argument			matchAnimation? {bool}
			/// @argument			random? {bool}
			/// @description		Set the Sprite properties of particles of this Particle Type,
			///						which replaces its shape is it is set.
			///						The Sprite can be animated using its own animation speed, unless
			///						it is set to match the life time of this Particle Type. The
			///						animation will play from either the start to finish or randomized
			///						frames if specified.
			static setSprite = function(_sprite, _animate = false, _matchAnimation = false,
										_randomize = false)
			{
				try
				{
					part_type_sprite(ID, _sprite.ID, _animate, _matchAnimation, _randomize);
					
					sprite = _sprite;
					sprite_animate = _animate;
					sprite_matchAnimation = _matchAnimation;
					sprite_randomize = _randomize;
					shape = undefined;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setSprite()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			scale {Scale}
			/// @description		Set the Scale of particles of this Particle Type, which stretches
			///						them on the x and y axes.
			static setScale = function(_scale)
			{
				try
				{
					part_type_scale(ID, _scale.x, _scale.y);
					
					if (is_instanceof(_scale, Scale))
					{
						scale.x = _scale.x;
						scale.y = _scale.y;
					}
					else
					{
						scale = new Scale(_scale);
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setScale()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			size {real|Range}
			/// @argument			increase? {real}
			/// @argument			wiggle? {real}
			/// @description		Set the size properties of this Particle Type, which multiplies
			///						the Scale of the particles.
			static setSize = function(_size, _increase = 0, _wiggle = 0)
			{
				try
				{
					var _size_minimum, _size_maximum;
					
					if (is_real(_size))
					{
						_size_minimum = _size;
						_size_maximum = _size;
					}
					else
					{
						_size_minimum = _size.minimum;
						_size_maximum = _size.maximum;
					}
					
					part_type_size(ID, _size_minimum, _size_maximum, _increase, _wiggle);
					
					if (is_instanceof(_size, Range))
					{
						if (is_instanceof(size, Range))
						{
							size.minimum = _size.minimum;
							size.maximum = _size.maximum;
						}
						else
						{
							size = new Range(_size);
						}
					}
					else
					{
						size = _size;
					}
					
					size_increase = _increase;
					size_wiggle = _wiggle;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setSize()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			speed {real|Range}
			/// @argument			speed_increase? {real}
			/// @argument			speed_wiggle? {real}
			/// @description		Set the movement speed properties of particles of this Particle
			///						Type, indicating how fast each will move towards its direction.
			static setSpeed = function(_speed, _increase = 0, _wiggle = 0)
			{
				try
				{
					var _speed_minimum, _speed_maximum;
					
					if (is_real(_speed))
					{
						_speed_minimum = _speed;
						_speed_maximum = _speed;
					}
					else
					{
						_speed_minimum = _speed.minimum;
						_speed_maximum = _speed.maximum;
					}
					
					part_type_speed(ID, _speed_minimum, _speed_maximum, _increase, _wiggle);
					
					if (is_instanceof(_speed, Range))
					{
						if (is_instanceof(speed, Range))
						{
							speed.minimum = _speed.minimum;
							speed.maximum = _speed.maximum;
						}
						else
						{
							speed = new Range(_speed);
						}
					}
					else
					{
						speed = _speed;
					}
					
					speed_increase = _increase;
					speed_wiggle = _wiggle;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setSpeed()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			direction {Angle|Range}
			/// @argument			increase? {real}
			/// @argument			wiggle? {real}
			/// @description		Set the movemement direction properties of particle of this
			///						Particle Type, which is applied only while the partices have
			///						any speed, otherwise equaling 0.
			static setDirection = function(_direction, _increase = 0, _wiggle = 0)
			{
				try
				{
					var _direction_minimum, _direction_maximum;
					switch (instanceof(_direction))
					{
						case "Range":
							_direction_minimum = _direction.minimum;
							_direction_maximum = _direction.maximum;
						break;
						
						case "Angle":
							_direction_minimum = _direction.value;
							_direction_maximum = _direction.value;
						break;
					}
					
					part_type_direction(ID, _direction_minimum, _direction_maximum, _increase,
										_wiggle);
					
					switch (instanceof(_direction))
					{
						case "Range":
							if (is_instanceof(direction, Range))
							{
								direction.minimum = _direction.minimum;
								direction.maximum = _direction.maximum;
							}
							else
							{
								direction = new Range(_direction);
							}
						break;
						
						case "Angle":
							if (is_instanceof(direction, Angle))
							{
								direction.value = _direction.value;
							}
							else
							{
								direction = new Angle(_direction);
							}
						break;
					}
					
					direction_increase = _increase;
					direction_wiggle = _wiggle;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setDirection()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			angle {Angle|Range}
			/// @argument			increase? {real}
			/// @argument			wiggle? {real}
			/// @argument			relative? {bool}
			/// @description		Set the Angle propierties of the particle of this Particle Type,
			///						which rotates their visual representation.
			///						The Angle can be specified to be relative to the direction that
			///						is applied only if the particle currently has any speed.
			static setAngle = function(_angle, _increase = 0, _wiggle = 0, _relative = false)
			{
				try
				{
					var _angle_minimum, _angle_maximum;
					
					switch (instanceof(_angle))
					{
						case "Range":
							_angle_minimum = _angle.minimum;
							_angle_maximum = _angle.maximum;
						break;
						
						case "Angle":
							_angle_minimum = _angle.value;
							_angle_maximum = _angle.value;
						break;
					}
					
					part_type_orientation(ID, _angle_minimum, _angle_maximum, _increase, _wiggle,
										  _relative);
					
					switch (instanceof(_angle))
					{
						case "Range":
							if (is_instanceof(angle, Range))
							{
								angle.minimum = _angle.minimum;
								angle.maximum = _angle.maximum;
							}
							else
							{
								angle = new Range(_angle);
							}
						break;
						
						case "Angle":
							if (is_instanceof(angle, Angle))
							{
								angle.value = _angle.value;
							}
							else
							{
								angle = new Angle(_angle);
							}
						break;
					}
					
					angle_increase = _increase;
					angle_wiggle = _wiggle;
					angle_relative = _relative;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setAngle()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value {real}
			/// @argument			direction? {Angle}
			/// @description		Set the gravity properties of the particles of this Particle
			///						Type, which will move particles towards the specified direction,
			///						in addition to its own speed.
			static setGravity = function(_value, _direction)
			{
				try
				{
					var _gravity_direction = gravity_direction;
					
					if (is_instanceof(_direction, Angle))
					{
						_gravity_direction = _direction;
					}
					else if (!is_instanceof(gravity_direction, Angle))
					{
						_gravity_direction = new Angle(270);
					}
					
					part_type_gravity(ID, _value, _gravity_direction.value);
					
					gravity = _value;
					
					if (is_instanceof(gravity_direction, Angle))
					{
						gravity_direction.value = _gravity_direction.value;
					}
					else
					{
						gravity_direction = new Angle(_gravity_direction);
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setGravity()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			life {int|Range}
			/// @description		Set the life length property of particles of this Particle Type,
			///						which is the amount of steps after which they are destroyed.
			static setLife = function(_life)
			{
				try
				{
					var _life_minimum, _life_maximum;
					
					if (is_instanceof(_life, Range))
					{
						_life_minimum = _life.minimum;
						_life_maximum = _life.maximum;
					}
					else
					{
						_life_minimum = _life;
						_life_maximum = _life;
					}
					
					part_type_life(ID, _life_minimum, _life_maximum);
					
					if (is_instanceof(_life, Range))
					{
						if (is_instanceof(life, Range))
						{
							life.minimum = _life.minimum;
							life.maximum = _life.maximum;
						}
						else
						{
							life = new Range(_life);
						}
					}
					else
					{
						life = _life;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setLife()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			color {int:color|Color2|Color3}
			/// @description		Set the color property of this particles of this Particle Type to
			///						either one static color or a gradual gradient color change over
			///						the life time of each particle.
			static setColor = function(_color)
			{
				try
				{
					switch (instanceof(_color))
					{
						case "Color3":
							part_type_color3(ID, _color.color1, _color.color2, _color.color3);
							
							if (is_instanceof(color, Color3))
							{
								color.color1 = _color.color1;
								color.color2 = _color.color2;
								color.color3 = _color.color3;
							}
							else
							{
								color = new Color3(_color);
							}
							
							color_type = "Color3";
						break;
						
						case "Color2":
							part_type_color2(ID, _color.color1, _color.color2);
							
							if (is_instanceof(color, Color2))
							{
								color.color1 = _color.color1;
								color.color2 = _color.color2;
							}
							else
							{
								color = new Color2(_color);
							}
							
							color_type = "Color2";
						break;
						
						default:
							part_type_color1(ID, _color);
							
							color = _color;
							color_type = "color";
						break;
					}
					
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setColor()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			color {Color2}
			/// @description		Set the color property of this Particle Type to a random static
			///						value between two colors.
			static setColorMix = function(_color)
			{
				try
				{
					part_type_color_mix(ID, _color.color1, _color.color2);
					
					if (is_instanceof(color, Color2))
					{
						color.color1 = _color.color1;
						color.color2 = _color.color2;
					}
					else
					{
						color = new Color2(_color);
					}
					
					color_type = "mix";
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setColorMix()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			red {real|Range}
			/// @argument			green {real|Range}
			/// @argument			blue {real|Range}
			/// @description		Set the color property of the particles of this Particle Type to
			///						a static value made from a set of three RGB values, each being
			///						either a static value or randomized from a 0-255 Range.
			static setColorRGB = function(_red, _green, _blue)
			{
				try
				{
					var _red_minimum, _red_maximum, _green_minimum, _green_maximum, _blue_minimum,
						_blue_maximum;
					
					if (is_real(_red))
					{
						_red_minimum = _red;
						_red_maximum = _red;
					}
					else
					{
						_red_minimum = _red.minimum;
						_red_maximum = _red.maximum;
					}
					
					if (is_real(_green))
					{
						_green_minimum = _green;
						_green_maximum = _green;
					}
					else
					{
						_green_minimum = _green.minimum;
						_green_maximum = _green.maximum;
					}
					
					if (is_real(_blue))
					{
						_blue_minimum = _blue;
						_blue_maximum = _blue;
					}
					else
					{
						_blue_minimum = _blue.minimum;
						_blue_maximum = _blue.maximum;
					}
					
					part_type_color_rgb(ID, _red_minimum, _red_maximum, _green_minimum,
										_green_maximum, _blue_minimum, _blue_maximum);
					
					if (array_length(color) == 3)
					{
						var _i = 0;
						var _array_content = [_red, _green, _blue];
						repeat (3)
						{
							var _color_current = _array_content[_i]
							
							if (is_instanceof(_color_current, Range))
							{
								if (is_instanceof(color[_i], Range))
								{
									color[_i].minimum = _color_current.minimum;
									color[_i].maximum = _color_current.maximum;
								}
								else
								{
									color[_i] = new Range(_color_current);
								}
							}
							else
							{
								color[_i] = _color_current;
							}
							
							++_i;
						}
					}
					else
					{
						color = [((is_instanceof(_red, Range)) ? new Range(_red) : _red),
								 ((is_instanceof(_green, Range)) ? new Range(_green) : _green),
								 ((is_instanceof(_blue, Range)) ? new Range(_blue) : _blue)];
					}
					
					color_type = "RGB";
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setColorRGB()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			hue {real|Range}
			/// @argument			saturation {real|Range}
			/// @argument			value {real|Range}
			/// @description		Set the color property of the particles of this Particle Type to
			///						a static value made from a set of three HSV values, each being
			///						either a static value or randomized from a 0-255 Range.
			static setColorHSV = function(_hue, _saturation, _value)
			{
				try
				{
					var _hue_minimum, _hue_maximum, _saturation_minimum, _saturation_maximum,
						_value_minimum, _value_maximum;
					
					if (is_real(_hue))
					{
						_hue_minimum = _hue;
						_hue_maximum = _hue;
					}
					else
					{
						_hue_minimum = _hue.minimum;
						_hue_maximum = _hue.maximum;
					}
					
					if (is_real(_saturation))
					{
						_saturation_minimum = _saturation;
						_saturation_maximum = _saturation;
					}
					else
					{
						_saturation_minimum = _saturation.minimum;
						_saturation_maximum = _saturation.maximum;
					}
					
					if (is_real(_value))
					{
						_value_minimum = _value;
						_value_maximum = _value;
					}
					else
					{
						_value_minimum = _value.minimum;
						_value_maximum = _value.maximum;
					}
					
					part_type_color_hsv(ID, _hue_minimum, _hue_maximum, _saturation_minimum,
										_saturation_maximum, _value_minimum, _value_maximum);
					
					if (array_length(color) == 3)
					{
						var _i = 0;
						var _array_content = [_hue, _saturation, _value];
						repeat (3)
						{
							var _color_current = _array_content[_i]
							
							if (is_instanceof(_color_current, Range))
							{
								if (is_instanceof(color[_i], Range))
								{
									color[_i].minimum = _color_current.minimum;
									color[_i].maximum = _color_current.maximum;
								}
								else
								{
									color[_i] = new Range(_color_current);
								}
							}
							else
							{
								color[_i] = _color_current;
							}
							
							++_i;
						}
					}
					else
					{
						color = [((is_instanceof(_hue, Range)) ? new Range(_hue) : _hue),
								 ((is_instanceof(_saturation, Range)) ? new Range(_saturation)
																	  : _saturation),
								 ((is_instanceof(_value, Range)) ? new Range(_value) : _value)];
					}
					
					color_type = "HSV";
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setColorHSV()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			blend_additive {bool}
			/// @description		Set the additive blending property of particles of this Particle
			///						Type, which alters their rendering when their locations overlap.
			static setBlend = function(_blend_additive)
			{
				try
				{
					part_type_blend(ID, _blend_additive);
					
					blend_additive = _blend_additive;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setBlend()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			value1 {real}
			/// @argument			value2? {real}
			/// @argument			value3? {real}
			/// @description		Set the alpha property of particle of this Particle Type to
			///						either one static value or a gradual change over the life time
			///						of each particle.
			static setAlpha = function(_value1, _value2, _value3)
			{
				try
				{
					if (is_real(_value3))
					{
						part_type_alpha3(ID, _value1, _value2, _value3);
						
						alpha = [argument[0], argument[1], argument[2]];
					}
					else if (is_real(_value2))
					{
						part_type_alpha2(ID, _value1, _value2);
							
						alpha = [argument[0], argument[1], undefined];
					}
					else
					{
						part_type_alpha1(ID, _value1);
							
						alpha = [argument[0], undefined, undefined];
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setAlpha()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			type {ParticleType}
			/// @argument			number {int}
			/// @description		Set the step stream properties of particles of this Particle
			///						Type, which will cause them to stream the particles of other
			///						Particle Type each step.
			static setStep = function(_type, _number)
			{
				try
				{
					if (_type.ID != ID)
					{
						part_type_step(ID, _number, _type.ID);
						
						step_type = _type;
						step_number = _number;
					}
					else
					{
						new ErrorReport().report([other, self, "setStep()"],
												 ("Attempted to set a property causing a Particle " +
												  "Type to spawn particles of it own type, causing " +
												  "an infinite loop: " +
												  "{" + string(ID) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setDeath()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			type {ParticleType}
			/// @argument			number {int}
			/// @description		Set the death stream properties of particles of this Particle
			///						Type, which will cause them to stream the particles of other
			///						Particle Type once when their life time ends.
			static setDeath = function(_type, _number)
			{
				try
				{
					if (_type.ID != ID)
					{
						part_type_death(ID, _number, _type.ID);
						
						death_type = _type;
						death_number = _number;
					}
					else
					{
						new ErrorReport().report([other, self, "setDeath()"],
												 ("Attempted to set a property causing a Particle " +
												  "Type to spawn particles of it own type, causing " +
												  "an infinite loop: " +
												  "{" + string(ID) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setDeath()"], _exception);
				}
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			particleSystem {ParticleSystem}
			/// @argument			location {Vector2}
			/// @argument			number? {int}
			/// @argument			color? {int:color}
			/// @description		Directly create any number of Particles of this type in the
			///						specified location.
			static create = function(_particleSystem, _location, _number = 1, _color)
			{
				try
				{
					if ((self.isFunctional()) and (is_struct(_particleSystem))
					and (_particleSystem.isFunctional()))
					{
						if ((is_struct(event)) and (event.beforeCreation.callback != undefined))
						{
							var _callback_isArray = is_array(event.beforeCreation.callback);
							var _argument_isArray = is_array(event.beforeCreation.argument);
							var _callback = ((_callback_isArray)
											 ? event.beforeCreation.callback
											 : [event.beforeCreation.callback]);
							var _callback_count = array_length(_callback);
							var _argument = ((_argument_isArray)
											 ? event.beforeCreation.argument
											 : array_create(_callback_count,
															event.beforeCreation.argument));
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
									new ErrorReport().report([other, self, "create()", "event",
															  "beforeCreation"], _exception);
								}
								
								++_i;
							}
						}
						
						if (_color != undefined)
						{
							part_particles_create_color(_particleSystem.ID, _location.x, _location.y,
														ID, _color, _number);
						}
						else
						{
							part_particles_create(_particleSystem.ID, _location.x, _location.y, ID,
												  _number);
						}
						
						if ((is_struct(event)) and (event.afterCreation.callback != undefined))
						{
							var _callback_isArray = is_array(event.afterCreation.callback);
							var _argument_isArray = is_array(event.afterCreation.argument);
							var _callback = ((_callback_isArray)
											 ? event.afterCreation.callback
											 : [event.afterCreation.callback]);
							var _callback_count = array_length(_callback);
							var _argument = ((_argument_isArray)
											 ? event.afterCreation.argument
											 : array_create(_callback_count,
															event.afterCreation.argument));
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
									new ErrorReport().report([other, self, "create()", "event",
															  "beforeCreation"], _exception);
								}
								
								++_i;
							}
						}
					}
					else
					{
						new ErrorReport().report([other, self, "create()"],
												 ("Attempted to create particles using an " +
												  "invalid Particle Type or Particle System:" + "\n" +
												  "Self: " + "{" + string(self) + "}" + "\n" +
												  "Target: " + "{" + string(_particleSystem) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "create()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			particleSystem {Layer.ParticleSystem}
			/// @argument			shape {Circle|Ellipse|Line|Rectangle|Triangle}
			/// @argument			number? {int}
			/// @argument			color? {int:color}
			/// @description		Directly create any number of Particles of this type in random
			///						locations within the specified Shape.
			static createShape = function(_particleSystem, _shape, _number = 1, _color)
			{
				try
				{
					if ((self.isFunctional()) and (is_struct(_particleSystem))
					and (_particleSystem.isFunctional()))
					{
						if ((is_struct(event)) and (event.beforeCreation.callback != undefined))
						{
							var _callback_isArray = is_array(event.beforeCreation.callback);
							var _argument_isArray = is_array(event.beforeCreation.argument);
							var _callback = ((_callback_isArray)
											 ? event.beforeCreation.callback
											 : [event.beforeCreation.callback]);
							var _callback_count = array_length(_callback);
							var _argument = ((_argument_isArray)
											 ? event.beforeCreation.argument
											 : array_create(_callback_count,
															event.beforeCreation.argument));
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
									new ErrorReport().report([other, self, "createShape()", "event",
															  "beforeCreation"], _exception);
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
									var _angle = point_direction(_shape.location.x1,
																 _shape.location.y1,
																 _shape.location.x2,
																 _shape.location.y2);
									var _side_angle = (_angle + 90);
									var _side_length = (_shape.size * 0.5);
									
									repeat (_number)
									{
										var _length = irandom_range(0, _distance);
										var _location_x = (_shape.location.x1 
														   + lengthdir_x(_length, _angle));
										var _location_y = (_shape.location.y1 
														   + lengthdir_y(_length, _angle));
										var _side_position = irandom_range((-_side_length),
																		   _side_length);
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
									var _angle = point_direction(_shape.location.x1,
																 _shape.location.y1,
																 _shape.location.x2,
																 _shape.location.y2);
									var _side_angle = (_angle + 90);
									var _side_length = (_shape.size * 0.5);
									
									repeat (_number)
									{
										var _length = irandom_range(0, _distance);
										var _location_x = (_shape.location.x1 
														   + lengthdir_x(_length, _angle));
										var _location_y = (_shape.location.y1 
														   + lengthdir_y(_length, _angle));
										var _side_position = irandom_range((-_side_length),
																		   _side_length);
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
										var _location_x = (mean(_shape.location.x1,
																_shape.location.x2)
														   + ((sqrt(_point) * cos(_angle))
															  * _size_x));
										var _location_y = (mean(_shape.location.y1,
																_shape.location.y2)
														   + ((sqrt(_point) * sin(_angle))
															  * _size_y));
										
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
										var _location_x = (mean(_shape.location.x1,
																_shape.location.x2)
														   + ((sqrt(_point) * cos(_angle))
															  * _size_x));
										var _location_y = (mean(_shape.location.y1,
																_shape.location.y2)
														   + ((sqrt(_point) * sin(_angle))
															  * _size_y));
										
										part_particles_create(_particleSystem.ID, _location_x,
															  _location_y, ID, 1);
									}
								}
							break;
						}
						
						if ((is_struct(event)) and (event.afterCreation.callback != undefined))
						{
							var _callback_isArray = is_array(event.afterCreation.callback);
							var _argument_isArray = is_array(event.afterCreation.argument);
							var _callback = ((_callback_isArray)
											 ? event.afterCreation.callback
											 : [event.afterCreation.callback]);
							var _callback_count = array_length(_callback);
							var _argument = ((_argument_isArray)
											 ? event.afterCreation.argument
											 : array_create(_callback_count,
															event.afterCreation.argument));
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
									new ErrorReport().report([other, self, "createShape()", "event",
															  "beforeCreation"], _exception);
								}
								
								++_i;
							}
						}
					}
					else
					{
						new ErrorReport().report([other, self, "createShape()"],
												 ("Attempted to create particles using an " +
												  "invalid Particle Type or Particle System:" + "\n" +
												  "Self: " + "{" + string(self) + "}" + "\n" +
												  "Target: " + "{" + string(_particleSystem) + "}"));
					}
				}
				
				return self;
			}
		
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @argument			full? {bool}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented with the properties of this Particle
			///						Type.
			static toString = function(_multiline = false, _full = false)
			{
				if (self.isFunctional())
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
						
						if (is_instanceof(sprite, Sprite))
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
		
		static constructor = ParticleType;
		
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
