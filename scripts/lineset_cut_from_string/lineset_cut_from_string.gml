//  @function				lineset_cut_from_string()
/// @argument				lineSet {string[]}
/// @argument				string {string}
/// @description			Remove all entries from the specified line set after the specified string
///							is found.
function lineset_cut_from_string(_lineSet, _string)
{
	var _i = 0;
	var _lineSet_length = array_length(_lineSet);
	repeat (_lineSet_length)
	{
		if (_lineSet[_i] == _string)
		{
			array_delete(_lineSet, _i, (_lineSet_length - _i - 1));
			
			break;
		}
		
		++_i;
	}
}
