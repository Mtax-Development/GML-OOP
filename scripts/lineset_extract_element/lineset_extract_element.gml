//  @function				lineset_extract_element()
/// @argument				lineSet {string[]}
/// @argument				element? {string}
/// @description			Remove all entries from the specified line set that are not a part of the
///							specified element.
function lineset_extract_element(_lineSet, _element)
{
	if (is_string(_element))
	{
		lineset_cut_to_string(_lineSet, find_lines_containing((_element + "()"), _lineSet,
																"#region [Elements]"), true);
		lineset_cut_from_string(_lineSet, find_lines_containing(["#region", "Constructor"], _lineSet));
	}
}
