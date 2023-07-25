//  @function				field_create_constructor_elements()
/// @argument				constructor_element {string[]}
/// @returns				{string}
/// @description			Format an HTML element with the information about specified constructor
///							elements.
function field_create_constructor_elements(_constructor_element)
{
	static _stringParser = new StringParser();
	
	var _result = "";
	var _count = array_length(_constructor_element);
	
	if (_count > 0)
	{
		var _constructor_name = string_copy(_constructor_element[0], 0,
											(string_pos(".", _constructor_element[0]) - 1));
		var _constructor_name_format_bold = ("<b>" + _constructor_name + "</b>");
		var _whitespace = (string_repeat(" ", 32));
		var _i = 0;
		repeat (_count)
		{
			if (_i != 0)
			{
				_result += ("\n" + _whitespace + "<br>" + "\n" + _whitespace);
			}
			
			_stringParser.setParser(_constructor_element[_i]).replace(_constructor_name,
																	  _constructor_name_format_bold);
			
			_result += ("<code>" + _stringParser.ID + "</code>");
			
			++_i;
		}
	}
	else
	{
		_result = "None";
	}
	
	return _result;
}
