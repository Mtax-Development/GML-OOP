//  @function				get_constructor_events()
/// @argument				lineSet {string[]}
/// @returns				{string[]}
/// @description			Return event names in the specified line set.
function get_constructor_events(_lineSet)
{
	static _stringParser = new StringParser();
	
	var _result = [];
	var _count = array_length(_lineSet);
	var _i = 0;
	repeat (_count)
	{
		_stringParser.setParser(_lineSet[_i]);
		
		if (_stringParser.contains("event ="))
		{
			_i += 2;
			repeat (_count - _i)
			{
				_stringParser.setParser(_lineSet[_i]).trim();
				
				if (_stringParser.contains("}") and (!_stringParser.contains("},")))
				{
					break;
				}
				else if ((_stringParser.contains(":")) and (string_count("{", _lineSet[(_i + 1)]) > 0))
				{
					array_push(_result, _stringParser.replace(":").ID);
				}
				
				++_i;
			}
			
			break;
		}
		else if (_stringParser.contains("static") and (!_stringParser.contains("construct")))
		{
			break;
		}
		
		++_i;
	}
	
	return _result;
}
