//  @function				get_constructor_properties
/// @argument				lineSet {string[]}
/// @returns				{string[+]}
/// @description			Return an array containing arrays with property names and their default
///							values in the specified line set.
function get_constructor_properties(_lineSet)
{
	static _stringParser = new StringParser();
	
	var _result = [];
	var _property = [];
	
	var _i = 0;
	var _count = array_length(_lineSet);
	repeat (_count)
	{
		_stringParser.setParser(_lineSet[_i]);
		
		if (_stringParser.contains("static construct = function("))
		{
			_i += 2;
			repeat (_count - _i)
			{
				_stringParser.setParser(_lineSet[_i]).trim();
				
				if ((_stringParser.getLetters() == "")
				or (!_stringParser.contains(" = ", "//", "parent.")))
				{
					break;
				}
				else if ((_stringParser.getFirst() != "/") and (!_stringParser.contains("parent.")))
				{
					array_push(_property, _stringParser.ID);
				}
				
				++_i;
			}
			
			break;
		}
		else if (_stringParser.contains("[Static variables]"))
		{
			_i += 2;
			repeat (_count - _i)
			{
				_stringParser.setParser(_lineSet[_i]).trim();
				
				if (_stringParser.contains("[Methods]"))
				{
					break;
				}
				else if (_stringParser.contains("static"))
				{
					array_push(_property, string_replace(_stringParser.ID, "static ", ""));
				}
				
				++_i;
			}
			
			break;
		}
		
		++_i;
	}
	
	var _i = 0;
	repeat (array_length(_property))
	{
		var _property_data = _stringParser.setParser(_property[_i]).split(" = ");
		_property_data[1] = _stringParser.setParser(_property_data[1]).replace(";").ID;
		
		//|Case-specific formatting.
		_property_data[1] = string_replace(_property_data[1], "show_debug_message",
										   "<a href=\"https://manual.yoyogames.com/" +
										   "GameMaker_Language/GML_Reference/Debugging/" +
										   "show_debug_message.htm\">show_debug_message</a>");
		
		array_push(_result, _property_data);
		
		++_i;
	}
	
	return _result;
}
