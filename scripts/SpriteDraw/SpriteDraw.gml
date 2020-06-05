/// @function				SpriteDraw();
/// @argument				sprite {sprite}
/// @argument				frame {real}
/// @argument				animationSpeed {fps}
/// @argument				location {Vector2}
/// @argument				scale {Scale}
/// @argument				color {color}
/// @argument				alpha {real}
///
/// @description			Constructs a sprite draw based on draw_sprite_ext(),
///							execuded using the render() function.
function SpriteDraw(_sprite, _frame, _animationSpeed, _location, _scale, _angle, _color, _alpha) constructor
{
	sprite			= _sprite;
	frame			= _frame;
	animationSpeed	= _animationSpeed;
	location		= _location;
	scale			= _scale;
	angle			= _angle;
	color			= _color;
	alpha			= _alpha;
	
	
	static render = function()
	{		
		draw_sprite_ext(sprite, frame, location.x, location.y, scale.x, scale.y, angle.value, color, alpha);
		
		if (animationSpeed != 0)
		{
			advanceFrames(animationSpeed);
		}
	}
	
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
}
