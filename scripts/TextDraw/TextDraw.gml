/// @function				TextDraw()
/// @argument				{string} text
/// @argument				{font} font
/// @argument				{Vector2} location
/// @argument				{TextAlign} align
/// @argument				{color} color
/// @argument				{real} alpha
///
/// @description			Constructs a Text Draw which can be rendered with
///							full configurationor operated in other ways.
function TextDraw(_text, _font, _location, _align, _color, _alpha) constructor
{
	#region [Methods]
		
		// @description			Execute the draw.
		static render = function()
		{
			if (alpha > 0)
			{
				draw_set_font(font);
				draw_set_halign(align.x);
				draw_set_valign(align.y);
				draw_set_color(color);
				draw_set_alpha(alpha);

				draw_text(location.x, location.y, text);
			}
		}
		
	#endregion
	#region [Constructor]
	
		text	  = _text;
		font	  = _font;
		location  = _location;
		align	  = _align;
		color	  = _color;
		alpha	  = _alpha;
	
	#endregion
}
