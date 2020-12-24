/// @function				Sprite()
/// @argument				{sprite} sprite
/// @argument				{Vector2} location?
/// @argument				{real} frame?
/// @argument				{real} speed?
/// @argument				{Scale} scale?
/// @argument				{Angle} angle?
/// @argument				{color} color?
/// @argument				{real} alpha?
///
/// @description			Constructs a Sprite resource. It can be drawn and animated with its
///							configuration.
///
///							Construction methods:
///							- New constructor
///							- Constructor copy: {Sprite} other
function Sprite() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				if ((argument_count > 0) and (instanceof(argument[0]) == "Sprite"))
				{
					//|Construction method: Constructor copy.
					var _other = argument[0];
					
					ID = _other.ID;
					location = _other.location;
					frame = _other.frame;
					speed = _other.speed;
					scale = _other.scale;
					angle = _other.angle;
					color = _other.color;
					alpha = _other.alpha;
				}
				else
				{
					//|Construction method: New constructor.
					ID = argument[0];
					location = ((argument_count > 1) ? argument[1] : undefined);
					frame = (((argument_count > 2) and (argument[2] != undefined)) ? argument[2] 
																				   : 0);
					speed = (((argument_count > 3) and (argument[3] != undefined)) ? argument[3] 
																				   : 0);
					scale = (((argument_count > 4) and (argument[4] != undefined)) ? argument[4] 
																				   : new Scale(1, 1));
					angle = (((argument_count > 5) and (argument[5] != undefined)) ? argument[5] 
																				   : new Angle(0));
					color = (((argument_count > 6) and (argument[6] != undefined)) ? argument[6] 
																				   : c_white);
					alpha = (((argument_count > 7) and (argument[7] != undefined)) ? argument[7] 
																				   : 1);
				}
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{bool} copyCallerLocation?
			// @description			Execute the draw and advance the animation.
			static render = function(_copyCallerLocation)
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					var _location_x = undefined;
					var _location_y = undefined;
					
					if (_copyCallerLocation)
					{
						_location_x = other.x;
						_location_y = other.y;
					}
					else if (location != undefined)
					{
						_location_x = location.x;
						_location_y = location.y;
					}
					
					if ((is_real(_location_x)) and (is_real(_location_y)))
					{
						draw_sprite_ext(ID, frame, _location_x, _location_y, scale.x, scale.y,
										angle.value, color, alpha);
					}
					if (speed != 0)
					{
						self.advanceFrames(speed);
					}
				}
			}
			
			// @description			Advance the animation and wrap its numbers.
			static advanceFrames = function()
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					frame += speed;
		
					var frame_max = sprite_get_number(sprite);
		
					if (frame >= frame_max)
					{
						frame -= frame_max;
					}
					else if (frame < 0)
					{
						frame += frame_max;
					}
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the name of this Sprite.
			static toString = function()
			{
				if ((is_real(ID)) and (sprite_exists(ID)))
				{
					return (instanceof(self) + "(" + sprite_get_name(ID) + ")");
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
		
		if (argument_count <= 0)
		{
			self.construct();
		}
		else
		{
			script_execute_ext(method_get_index(self.construct), argument_original);
		}
		
	#endregion
}
