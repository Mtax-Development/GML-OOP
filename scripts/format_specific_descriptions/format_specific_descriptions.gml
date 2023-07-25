/// @function				format_specific_descriptions()
/// @argument				{string} text
/// @description			Apply case-specific description formatting to the specified string.
function format_specific_descriptions(_text)
{
	static _stringParser = new StringParser();
	_stringParser.setParser(_text);
	
	//|Format notes.
	_stringParser.replace("NOTE:", "\n<br>\n<br>\n<b>NOTE:</b>")
	
	//|Format calculations.
	var _i = [0, 0];
	repeat (10)
	{
		var _number = string(_i[0]);
		var _calculation = array(_stringParser.getBetween((": " + _number), ","),
								 _stringParser.getBetween((", " + _number), "."));
		var _calculation_size = array_length(_calculation);
		
		if ((_calculation_size > 0) and (_calculation[0] != ""))
		{
			_i[1] = 0;
			repeat (_calculation_size)
			{
				_stringParser.replace((_number +_calculation[_i[1]]),
									  ("<code>" + _number + _calculation[_i[1]] + "</code>"));
				
				++_i[1];
			}
		}
		
		++_i[0];
	}
	
	//|Format accessors.
	var _i = 0;
	repeat (10)
	{
		var _number = string(_i);
		
		_stringParser.replace(("array[" + _number + "]"),
							  ("<code>" + "array[" + _number + "]" + "</code>"));
		
		++_i;
	}
	
	//|Format listing.
	_stringParser.replace(("- "), ("\n" + "<br>" + "\n" + "&emsp;" + " " + "•" + " "));
	
	return _stringParser.ID;
}
