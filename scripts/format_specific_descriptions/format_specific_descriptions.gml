/// @function				format_specific_descriptions()
/// @argument				{string} text
/// @description			Apply case-specific description formatting to the specified string.
function format_specific_descriptions(_text)
{
	static _stringParser = new StringParser();
	_stringParser.setParser(_text);
	
	//|Format notes.
	_stringParser.replace("NOTE:", "\n<br>\n<br>\n<b>NOTE:</b>")
	
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
