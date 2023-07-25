//  @function				get_supplement_array()
/// @argument				supplement_value {any|any[]}
/// @argument				count {int}
/// @returns				{any[]}
/// @description			Return the specified supplement by ensuring it is an array with the
///							specified number of positions. If the supplement array does not have that
///							many entries in it, they will be filled with question marks.
function get_supplement_array(_supplement_value, _count)
{
	var _data = [];
	
	if ((_supplement_value != undefined) and (_supplement_value != pointer_null))
	{
		_data = ((is_array(_supplement_value)) ? _supplement_value
											   : array_create(_count, _supplement_value));
	}
	
	repeat (_count - array_length(_data))
	{
		array_push(_data, "?");
	}
	
	return _data;
}
