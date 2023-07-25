//  @function				format_type_brackets()
/// @argument				string {string}
/// @returns				{string}
/// @description			Place code blocks around curly brackets in the specified string.
function format_type_brackets(_string)
{
	_string = string_replace_all(_string, "{", ("<code>" + "{"));
	_string = string_replace_all(_string, "}", ("}" + "</code>"));
	
	if ((string_count("<code><code>", _string) > 0) or (string_count("</code></code>", _string) > 0))
	{
		show_error(("Double <code> block found in string: " + _string), true);
	}
	
	return _string;
}
