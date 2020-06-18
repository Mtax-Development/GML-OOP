/// @function				Point();
/// @argument				location {Vector2}
/// @argument				alpha? {real}
/// @argument				color? {color | undefined}
///
///  @description			Constructs a single pixel in space,
///							which can be rendered or operated in
///							other ways.
function Point(_location) constructor
{
	#region [Methods]
	
		static render = function()
		{
			if ((color != undefined) and (alpha > 0))
			{
				draw_set_alpha(alpha);
				draw_set_color(color);
				
				draw_point(location.x, location.y);
			}
		}
	
	#endregion
	#region [Constructor]
	
		location = _location;
		alpha = (argument_count >= 2 ? argument[1] : 1);
		color = (argument_count >= 3 ? argument[2] : undefined);
	
	#endregion
}