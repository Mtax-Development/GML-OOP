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
		
		//+TODO: Advance frames
	}
}
