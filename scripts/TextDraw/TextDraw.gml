/// @function				TextDraw();
/// @description			Constructs a text draw based on draw_text(),
///							executed using the render() function.
///
///							Construction arguments:
///							- _text: {string}
///							- _font: {font}
///							- _location: {Vector2}
///							- _align: {TextAlign}
///							- _color: {color}
///							- _alpha: {real} (within range: 0-1)
function TextDraw(_text, _font, _location, _align, _color, _alpha) constructor
{
	text	  = _text;
	font	  = _font;
	location  = _location;
	align	  = _align;
	color	  = _color;
	alpha	  = _alpha;
	
	
	static render = function()
	{
		draw_set_font(font);
		draw_set_halign(align.x);
		draw_set_valign(align.y);
		draw_set_color(color);
		draw_set_alpha(alpha);

		draw_text(location.x, location.y, text);
	}
}
