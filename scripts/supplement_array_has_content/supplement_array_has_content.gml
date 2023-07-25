//  @function				supplement_array_has_content()
/// @argument				data {any[]}
/// @returns				{bool}
/// @description			Check if the specified supplement array contains any strings and none contain
///							only a question mark.
function supplement_array_has_content(_data)
{
	var _i = 0;
	repeat (array_length(_data))
	{
		var _entry = _data[_i];
		
		if ((is_string(_entry)) and (_entry != "?"))
		{
			return true;
		}
		
		++_i;
	}
	
	return false;
}
