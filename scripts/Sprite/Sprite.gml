/// @function				Sprite();
/// @argument				sprite {sprite}
/// @argument				frame {real}
/// @argument				animationSpeed {fps}
/// @argument				location {Vector2}
/// @argument				scale {Scale}
/// @argument				angle {Angle}
/// @argument				color {color}
/// @argument				alpha {real}
///
/// @description			Constructs a container for sprite and its draw information,
///							which can be rendered and animated using the render() method.
function Sprite(_sprite) constructor
{
	#region [Methods]
		
		// @description			Advance the animation and wrap its numbers.
		static advanceFrames = function(_number)
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
				
				draw_sprite_ext(ID, frame, location_x, location_y, scale.x, scale.y, angle.value, color, alpha);
		
				if (animationSpeed != 0)
				{
					self.advanceFrames(animationSpeed);
				}
			}
		}

	#endregion
	#region [Constructor]
	
		ID				= _sprite;
		frame			= (argument_count >= 2 ? argument[1] : 0);
		animationSpeed	= (argument_count >= 3 ? argument[2] : 0);
		location		= (argument_count >= 4 ? argument[3] : undefined);
		scale			= (argument_count >= 5 ? argument[4] : new Scale());
		angle			= (argument_count >= 6 ? argument[5] : new Angle());
		color			= (argument_count >= 7 ? argument[6] : c_white);
		alpha			= (argument_count >= 8 ? argument[7] : 1);
	
	#endregion
}
