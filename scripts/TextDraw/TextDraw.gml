/// @function				TextDraw()
/// @argument				{string} text
/// @argument				{font} font
/// @argument				{Vector2} location
/// @argument				{TextAlign} align?
/// @argument				{color} color?
/// @argument				{real} alpha?
///
/// @description			Constructs a Text Draw which can be rendered with
///							full configurationor operated in other ways.
function TextDraw(_text, _font, _location, _align, _color, _alpha) constructor
{
	#region [Methods]
		#region <Management>
			
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
		#region <Conversion>
			
			// @returns				{string}
			// @description			Overrides the string conversion with a simple text output.
			static toString = function()
			{
				return _text;
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		text	  = _text;
		font	  = _font;
		location  = _location;
		align	  = ((_align != undefined) ? _align : new TextAlign());
		color	  = ((_color != undefined) ? _color : c_white);
		alpha	  = ((_alpha != undefined) ? _alpha : 1);
		
	#endregion
}
