/// @function				Sprite()
/// @argument				{sprite} sprite
/// @argument				{Scale} scale?
/// @argument				{Angle} angle?
/// @argument				{color} color?
/// @argument				{real} alpha?
/// @argument				{Vector2} location?
/// @argument				{real} animationSpeed?
/// @argument				{real} frame?
///
/// @description			Constructs a Sprite resource with its draw information, which
///							can be rendered with its full configuration and then animated.
function Sprite(_sprite) constructor
{
	#region [Methods]
		
		// @description			Advance the animation and wrap its numbers.
		static advanceFrames = function()
		{
			if (sprite_exists(ID))
			{
				frame += animationSpeed;
		
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
		
				if (animationSpeed != 0)
				{
					self.advanceFrames(animationSpeed);
				}
			}
		}
		
	#endregion
	#region [Constructor]
	
		ID				= _sprite;
		scale			= (argument_count >= 2 ? argument[1] : new Scale());
		angle			= (argument_count >= 3 ? argument[2] : new Angle());
		color			= (argument_count >= 4 ? argument[3] : c_white);
		alpha			= (argument_count >= 5 ? argument[4] : 1);
		location		= (argument_count >= 6 ? argument[5] : undefined);
		frame			= (argument_count >= 7 ? argument[6] : 0);
		animationSpeed	= (argument_count >= 8 ? argument[7] : 0);
	
	#endregion
}
