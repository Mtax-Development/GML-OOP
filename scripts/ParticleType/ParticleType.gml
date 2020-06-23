/// @function				ParticleType();
/// @description			Constructs a particle type resource, which can 
///							have its properties changed and then be executed.
function Particle() constructor
{
	#region [Methods]
		#region <Execution>
		
			// @argument			particleSystem {particle system}
			// @argument			location {Vector2}
			// @argument			number {int}
			// @argument			color? {color}
			// @description			Directly create the particle(s) of this type in a space.
			static create = function(_particleSystem, _location, _number)
			{
				if (part_type_exists(ID))
				{
					var _color = (argument_count >= 4 ? argument[3] : undefined);
				
					if (_color != undefined)
					{
						part_particles_create_color(_particleSystem, _location.x, _location.y,
													ID, _color, _number);
					}
					else
					{
						part_particles_create(_particleSystem, _location.x, _location.y, 
											  ID, _number);
					}
				}
			}
		
		#endregion
		#region <Property Setters>
		
			// @argument			shape {particle shape}
			// @description			Set the shape property of this Particle Type.
			static setShape = function(_shape)
			{
				if (part_type_exists(ID))
				{
					shape = _shape;
				
					part_type_shape(ID, shape);
				}
			}
		
			// @argument			sprite {sprite}
			// @argument			sprite_animate {bool}
			// @argument			sprite_stretch {bool}
			// @argument			sprite_random {bool}
			// @description			Set the sprite properties of this Particle Type.
			static setSprite = function(_sprite)
			{
				if (part_type_exists(ID))
				{
					sprite = _sprite;
					sprite_animate = (argument_count >= 2 ? argument[1] : false);
					sprite_stretch = (argument_count >= 3 ? argument[2] : false);
					sprite_random = (argument_count >= 4 ? argument[3] : false);
				
					part_type_sprite(ID, sprite, sprite_animate, sprite_stretch,
									 sprite_random);
				}
			}
		
			// @argument			size {real | Range}
			// @argument			size_increase? {real}
			// @argument			size_wiggle? {real}
			// @description			Set the size properties of this Particle Type.
			static setSize = function(_size)
			{
				if (part_type_exists(ID))
				{
					size = _size;
					size_increase = (argument_count >= 2 ? argument[1] : 0);
					size_wiggle = (argument_count >= 3 ? argument[2] : 0);
				
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
			}
		
			// @argument			scale {Scale}
			// @description			Set the scale property of this Particle Type.
			static setScale = function(_scale)
			{
				if (part_type_exists(ID))
				{
					scale = _scale;
				
					part_type_scale(ID, scale.x, scale.y);
				}
			}
		
			// @argument			speed {real | Range}
			// @argument			speed_increase? {real}
			// @argument			speed_wiggle? {real}
			// @description			Set the speed properties of this Particle Type.
			static setSpeed = function(_speed)
			{
				if (part_type_exists(ID))
				{
					speed = _speed;
					speed_increase = (argument_count >= 2 ? argument[1] : 0);
					speed_wiggle = (argument_count >= 3 ? argument[2] : 0);
				
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
			}
		
			// @argument			gravity_amount {real}
			// @argument			gravity_direction {Angle}
			// @description			Set the gravity properties of this Particle Type.
			static setGravity = function(_gravity_amount, _gravity_direction)
			{
				if (part_type_exists(ID))
				{
					gravity_amount = _gravity_amount;
					gravity_direction = _gravity_direction;
				
					part_type_gravity(ID, gravity_amount, gravity_direction.value);
				}
			}
		
			// @argument			direction {real | Range}
			// @argument			direction_increase? {real}
			// @argument			direction_wiggle? {real}
			// @description			Set the direction properties of this Particle Type.
			static setDirection = function(_direction)
			{
				if (part_type_exists(ID))
				{
					direction = _direction
					direction_increase = (argument_count >= 2 ? argument[1] : 0);
					direction_wiggle = (argument_count >= 3 ? argument[2] : 0);
				
					var _direction_minimum, _direction_maximum;
				
					if (instanceof(direction) == "Range")
					{
						_direction_minimum = direction.minimum;
						_direction_maximum = direction.maximum;
					}
					else
					{
						_direction_minimum = direction;
						_direction_maximum = direction;
					}
				
					part_type_direction(ID, _direction_minimum, _direction_maximum, 
										direction_increase, direction_wiggle);
				}
			}
		
			// @argument			orientation {real | Range}
			// @argument			orientation_increase? {real}
			// @argument			orientation_wiggle? {real}
			// @argument			orientation_relative? {bool}
			// @description			Set the orientation propierties of this Particle Type.
			static setOrientation = function(_orientation)
			{
				if (part_type_exists(ID))
				{
					orientation = _orientation;
					orientation_increase = (argument_count >= 2 ? argument[1] : 0);
					orientation_wiggle = (argument_count >= 3 ? argument[2] : 0);
					orientation_relative = (argument_count >= 4 ? argument[3] : false);
				
					var _orientation_minimum, _orientation_maximum;
				
					if (instanceof(orientation) == "Range")
					{
						_orientation_minimum = orientation.minimum;
						_orientation_maximum = orientation.maximum;
					}
					else
					{
						_orientation_minimum = orientation;
						_orientation_maximum = orientation;
					}
				
					part_type_orientation(ID, _orientation_minimum, _orientation_maximum, 
										  orientation_increase, orientation_wiggle, orientation_relative);
				}
			}
		
			// @argument			color {color | Color2 | Color3}
			// @description			Set the color property of this Particle Type to gradient change.
			static setColor = function(_color)
			{
				if (part_type_exists(ID))
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
			}
		
			// @argument			colors {Color2}
			// @description			Set the color property of this Particle Type to static random mix.
			static setColor_mix = function(_colors)
			{
				if (part_type_exists(ID))
				{
					color = _colors;
					color_type = "mix";
				
					part_type_color_mix(ID, color.color1, color.color2);
				}
			}
		
			// @argument			red {real | Range}
			// @argument			green {real | Range}
			// @argument			blue {real | Range}
			// @description			Set the color property of this Particle Type to static random rgb.
			static setColor_rgb = function(_red, _green, _blue)
			{
				if (part_type_exists(ID))
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
			}
		
			// @argument			hue {Range}
			// @argument			saturation {Range}
			// @argument			value {Range}
			// @description			Set the color property of this Particle Type to static random hsv.
			static setColor_hsv = function(_hue, _saturation, _value)
			{
				if (part_type_exists(ID))
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
			}
		
			// @function			alpha1  {real}
			// @function			alpha2? {real}
			// @function			alpha3? {real}
			// @description			Set the alpha property of this Particle Type.
			static setAlpha = function(_alpha1)
			{
				if (part_type_exists(ID))
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
			}
		
			// @argument			blend_additive {bool}
			// @description			Set the blending property of this Particle Type.
			static setBlend = function(_blend_additive)
			{
				if (part_type_exists(ID))
				{
					blend_additive = _blend_additive;
				
					part_type_blend(ID, blend_additive);
				}
			}
		
			// @argument			life {int | Range}
			// @description			Set the life lenght property of this Particle Type.
			static setLife = function(_life)
			{
				if (part_type_exists(ID))
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
			}
		
			// @argument			step_type {Particle}
			// @argument			step_number {int}
			// @description			Set the step stream properties of this Particle Type.
			static setStep = function(_step_type, _step_number)
			{
				if ((ID != _step_type.ID) and (part_type_exists(ID))
				and (part_type_exists(_step_type.ID)))
				{
					step_type = _step_type;
					step_number = _step_number;
				
					part_type_step(ID, step_number, step_type.ID);
				}
			}
		
			// @argument			death_type {Particle}
			// @argument			death_number {int}
			// @description			Set the death stream properties of this Particle Type.
			static setDeath = function(_death_type, _death_number)
			{
				if ((ID != _death_type.ID) and (part_type_exists(ID))
				and (part_type_exists(_death_type.ID)))
				{
					death_type = _death_type;
					death_number = _death_number;
				
					part_type_death(ID, death_number, death_type.ID);
				}
			}
		
		#endregion
	#endregion
	#region [Constructor]
	
		ID = part_type_create();
		
		sprite = undefined;
		sprite_animate = false;
		sprite_stretch = false;
		sprite_random = false;

		size = 1;
		size_increase = 0;
		size_wiggle = 0;

		scale = new Scale();

		speed = 1;
		speed_increase = 0;
		speed_wiggle = 0;

		direction_minimum = new Angle();
		direction_maximum = new Angle();
		direction_increase = 0;
		direction_wiggle = 0;

		gravity_amount = 0;
		gravity_direction = undefined;

		orientation_minimum = new Angle();
		orientation_maximum = new Angle();
		orientation_increase = 0;
		orientation_wiggle = 0;
		orientation_relative = false;

		color = c_white;
		color_type = "color";
		
		alpha = [1, undefined, undefined];

		blend_additive = false;

		life = 100;

		shape = pt_shape_pixel;

		step_type = undefined;
		step_number = 0;

		death_type = undefined;
		death_number = 0;
	
	#endregion
}
