/// @function				SpriteDraw();
/// @argument				sprite {sprite}
/// @argument				frame {real}
/// @argument				animationSpeed {fps}
/// @argument				location {Vector2}
/// @argument				scale {Scale}
/// @argument				angle {Angle}
/// @argument				color {color}
/// @argument				alpha {real}
///
/// @description			Constructs a sprite draw based on draw_sprite_ext(),
///							execuded using the render() function.
function SpriteDraw(_sprite, _frame, _animationSpeed, _location, _scale, _angle, _color, _alpha) constructor
{
	#region [Methods]
		
		// @description			Advance the animation and wrap it numbers.
		static advanceFrames = function(_number)
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
		
		// @description			Execute the draw and advance the animation.
		static render = function()
		{		
			draw_sprite_ext(sprite, frame, location.x, location.y, scale.x, scale.y, angle.value, color, alpha);
		
			if (animationSpeed != 0)
			{
				self.advanceFrames(animationSpeed);
			}
		}

	#endregion
	#region [Constructor]

		sprite			= _sprite;
		frame			= _frame;
		animationSpeed	= _animationSpeed;
		location		= _location;
		scale			= _scale;
		angle			= _angle;
		color			= _color;
		alpha			= _alpha;
	
	#endregion
}
