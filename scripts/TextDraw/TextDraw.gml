/// @function				TextDraw();
/// @argument				text {string}
/// @argument				font {font}
/// @argument				location {Vector2}
/// @argument				align {TextAlign}
/// @argument				color {color}
/// @argument				alpha {real}
///
/// @description			Constructs a text draw based on draw_text(),
///							executed using the render() function.
function TextDraw(_text, _font, _location, _align, _color, _alpha) constructor
{
#region [Methods]
	
	static render = function()
	{
		draw_set_font(font);
		draw_set_halign(align.x);
		draw_set_valign(align.y);
		draw_set_color(color);
		draw_set_alpha(alpha);

		draw_text(location.x, location.y, text);
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
