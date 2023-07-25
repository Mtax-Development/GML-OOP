//  @function				get_line_position()
/// @argument				value {string}
/// @argument				lineSet {string[]}
/// @argument				position_start? {int}
/// @returns				{int|undefined}
/// @description			Return the position of a specified string in an array of them, starting from
///							its specified position. Returns {undefined} if target string was not found.
function get_line_position(_value, _lineSet, _position_start = 0)
{
	var _i = _position_start;
	repeat (array_length(_lineSet) - _position_start)
	{
		if (_lineSet[_i] == _value)
		{
			return _i;
		}
		
		++_i;
	}
	
	return undefined;
}
