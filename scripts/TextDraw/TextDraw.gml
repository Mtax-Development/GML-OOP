/// @function				TextDraw()
/// @argument				{any} text
/// @argument				{Font} font
/// @argument				{Vector2} location
/// @argument				{TextAlign} align?
/// @argument				{int:color} color?
/// @argument				{real} alpha?
///
/// @description			Constructs a Text Draw, used to hold a string of text to display and its
///							drawing configuration.
///
///							Construction methods:
///							- New constructor
///							- Constructor copy: {TextDraw} other
function TextDraw() constructor
{
	#region [Methods]
		#region <Management>
			
			static construct = function()
			{
				if ((argument_count > 0) and (instanceof(argument[0]) == "TextDraw"))
				{
					//|Construction method: Constructor copy.
					var _other = argument[0];
					
					text = _other.text;
					font = _other.font;
					location = _other.location;
					align = _other.align;
					color = _other.color;
					alpha = _other.alpha;
				}
				else
				{
					//Construction method: New constructor.
					text = string(argument[0]);
					font = argument[1];
					location = argument[2];
					align = (((argument_count > 3) and (argument[3] != undefined)) ? argument[3]
																				   : new TextAlign());
					color = (((argument_count > 4) and (argument[4] != undefined)) ? argument[4]
																				   : c_white);
					alpha = (((argument_count > 5) and (argument[5] != undefined)) ? argument[5]
																				   : 1);
				}
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
			// @argument			{bool} full?
			// @argument			{bool} multiline?
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the text preview, in which by 
			//						default line breaks will be replaced with a single space and 
			//						text will be cut if it is too long.
			static toString = function(_full, _multiline)
			{
				var _string = "";
				
				var _cutMark = "...";
				var _cutMark_length = string_length(_cutMark);
				
				var _lengthLimit = 30;
				
				_string += string(text);
				
				if (!_multiline)
				{
					_string = string_replace_all(_string, "\n", " ");
					_string = string_replace_all(_string, "\r", " ");
				}
				
				if (!_full)
				{
					if (string_length(_string) > (_lengthLimit + _cutMark_length))
					{
						_string = (string_copy(_string, 1, _lengthLimit) + _cutMark);
					}
				}
				
				return ((_multiline) ? _string : instanceof(self) + "(" + _string + ")");
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
		
		script_execute_ext(method_get_index(self.construct), argument_original);
		
	#endregion
}
