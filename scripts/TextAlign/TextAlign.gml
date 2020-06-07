/// @function				TextAlign();
/// @argument				x {halign}
/// @argument				y {valign}
///
/// @description			Construct a Vector2-like text align container, ready
///							to be used with text draw-related code, as well as
///							manipulated using its own functions.
function TextAlign(_x, _y) constructor
{
	#region [Methods]
	
		static mirror = function()
		{
			mirror_x();
			mirror_y();
		}
	
		static mirror_x = function()
		{
			switch (x)
			{
				case fa_left:  x = fa_right; break;
				case fa_right: x = fa_left;  break;
			}
		}
	
		static mirror_y = function()
		{
			switch (y)
			{
				case fa_top:	y = fa_bottom; break;
				case fa_bottom: y = fa_top;	   break;
			}
		}
	
	#endregion
	#region [Constructor]
	
		x = _x;
		y = _y;
	
	#endregion
}
