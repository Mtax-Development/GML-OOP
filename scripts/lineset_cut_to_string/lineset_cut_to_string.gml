//  @function				lineset_cut_to_string()
/// @argument				lineSet {string[]}
/// @argument				string {string}
/// @argument				keepToken {bool}
/// @description			Remove entries from the specified line set until the specified token is
///							found, which can be specified to be either kept or removed as well.
function lineset_cut_to_string(_lineSet, _token, _keepToken = false)
{
	repeat (array_length(_lineSet))
	{
		if (_lineSet[0] != _token)
		{
			array_delete(_lineSet, 0, 1);
		}
		else
		{
			if (!_keepToken)
			{
				array_delete(_lineSet, 0, 1);
			}
			
			break;
		}
	}
}
