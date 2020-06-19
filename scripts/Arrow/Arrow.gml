/// @function				Arrow();
/// @argument				location {Vector4}
/// @argument				alpha? {real}
/// @argument				color? {color}
/// @argument				size? {int}
function Arrow(_location) constructor
{
	#region [Methods]
	
		static render = function()
		{
			if ((color != undefined) and (alpha > 0))
			{
				draw_set_alpha(alpha);
				draw_set_color(color);
				
				draw_arrow(location.x1, location.y1, location.x2, location.y2, size);
			}
		}
	
	#endregion
	#region [Constructor]
		
		location = _location;
		alpha = (argument_count >= 2 ? argument[1] : 1);
		color = (argument_count >= 3 ? argument[2] : undefined);
		size  = (argument_count >= 4 ? argument[3] : 1);
		
	#endregion
}