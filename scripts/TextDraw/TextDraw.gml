/// @function				TextDraw()
/// @argument				{any} text
/// @argument				{Font|font} font
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
			
			static construct = function(_text, _font, _location, _align, _color, _alpha)
			{
				text = string(_text);
				font = ((instanceof(_font) == "Font") ? _font : new Font(_font));
				location = _location;
				align = ((_align != undefined) ? _align : new TextAlign());
				color = ((_color != undefined) ? _color : c_white);
				alpha = ((_alpha != undefined) ? _alpha : 1);
			}
			
		#endregion
		#region <Execution>
		
			// @description			Execute the draw.
			static render = function()
			{
				if (alpha > 0)
				{
					draw_set_font(font.ID);
					draw_set_halign(align.x);
					draw_set_valign(align.y);
					draw_set_color(color);
					draw_set_alpha(alpha);

					draw_text(location.x, location.y, string(text));
				}
			}
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Overrides the string conversion with the constructor name and
			//						main content preview.
			static toString = function()
			{
				var _string = (instanceof(self) + "(");
				
				var _cutMark = "...";
				
				var _cutMark_length = string_length(_cutMark);
				
				var _contentLength = 30;
				var _maximumLength = (_contentLength + string_length(_string));
				
				_string += string(text);
				_string = string_replace_all(_string, "\n", " ");
				_string = string_replace_all(_string, "\r", " ");
				
				return ((string_length(_string) <= (_maximumLength + _cutMark_length))) ?
					   (_string + ")") :
					   (string_copy(_string, 1, _maximumLength) + _cutMark + ")");
			}
			
			// @returns				{string}
			// @description			Return a string with constructor name and its main content.
			static toString_full = function()
			{
				var _string = string(text);
				_string = string_replace_all(_string, "\n", " ");
				_string = string_replace_all(_string, "\r", " ");
				
				return (instanceof(self) + "(" + _string + ")");
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		argument_original = array_create(argument_count, undefined);
		
		var _i = 0;
		repeat (argument_count)
		{
			argument_original[_i] = argument[_i];
			
			++_i;
		}
		
		if (argument_count <= 0)
		{
			self.construct();
		}
		else
		{
			script_execute_ext(method_get_index(self.construct), argument_original);
		}
		
	#endregion
}
