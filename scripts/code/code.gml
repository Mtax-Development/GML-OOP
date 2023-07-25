//  @function				code()
/// @argument				{string} string
/// @returns				{string}
/// @description			Remove all HTML code blocks from the specified string and wrap it with a
///							single one.
function code(_string)
{
	return ("<code>" + string_replace_all(string_replace_all(_string, "</code>", ""), "<code>", "") +
			"</code>");
}
