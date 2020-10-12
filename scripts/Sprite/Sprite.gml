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
/// @description			Constructs a Sprite resource with its draw information, which
///							can be rendered with its full configuration and then animated.
function Sprite(_sprite, _location, _frame, _speed, _scale, _angle, _color, _alpha) constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function(_sprite, _location, _frame, _speed, _scale, _angle, _color, 
										_alpha)
			{
				ID				= _sprite;
				location		= ((_location != undefined) ? _location : undefined);
				frame			= ((_frame != undefined) ? _frame : 0);
				speed			= ((_speed != undefined) ? _speed : 0);
				scale			= ((_scale != undefined) ? _scale : new Scale());
				angle			= ((_angle != undefined) ? _angle : new Angle());
				color			= ((_color != undefined) ? _color : c_white);
				alpha			= ((_alpha != undefined) ? _alpha : 1);
			}
			
		#endregion
		#region <Execution>
		
			// @description			Advance the animation and wrap its numbers.
			static advanceFrames = function()
			{
				if (sprite_exists(ID))
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
		
			// @description			Execute the draw and advance the animation.
			static render = function()
			{
				if (sprite_exists(ID))
				{
					var location_x, location_y;
				
					if (location == undefined)
					{
						location_x = other.x;
						location_y = other.y;
					}
					else
					{
						location_x = location.x;
						location_y = location.y;
					}
				
					draw_sprite_ext(ID, frame, location_x, location_y, scale.x, 
									scale.y, angle.value, color, alpha);
		
					if (speed != 0)
					{
						self.advanceFrames(speed);
					}
				}
			}
		
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Overrides the string conversion with a Sprite name output.
			static toString = function()
			{
				return ((sprite_exists(ID)) ? sprite_get_name(ID) : string(undefined));
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
