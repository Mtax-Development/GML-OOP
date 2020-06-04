/// @function				SpriteDraw();
/// @description			Constructs a sprite draw based on draw_sprite_ext(),
///							execuded using the render() function.
///
///							Construction arguments:
///							- _sprite: {sprite}
///							- _frame: {real} 
///							- _animationSpeed: {fps}
///							- _location: {Vector2}
///							- _scale: {Scale}
///							- _angle: {Angle}
///							- _color: {color}
///							- _alpha: {real} (within range: 0-1)
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
