//  @function				find_lines_containing()
/// @argument				token_target {string}
/// @argument				lineSet {string[]}
/// @argument				token_start? {string}
/// @argument				token_end? {string}
/// @argument				multiline? {bool}
/// @returns				{string|string[]}
/// @description			Find a line with the specified string in the specified line set and either
///							return it by itself or in an array of lines with lines that are after it
///							until the specified end token is reached. A starting token can be specified
///							to ignore lines in the line set until it was reached. The result can be
///							specified to be multiline to return it as a single string with spaces in
///							place of line breaks.
function find_lines_containing(_token_target, _lineSet, _token_start, _token_end, _multiline = false)
{
	static _arrayParser = new ArrayParser();
	static _stringParser = new StringParser();
	
	var _result = [];
	
	if (_token_start != undefined)
	{
		_arrayParser.clear().copy(_lineSet);
		
		if (is_string(_token_start))
		{
			repeat (array_length(_lineSet))
			{
				if (!_stringParser.setParser(_arrayParser.getFirst()).contains(_token_start))
				{
					_arrayParser.removePosition();
				}
				else
				{
					break;
				}
			}
		}
		else if (is_real(_token_start))
		{
			repeat (_token_start)
			{
				_arrayParser.removePosition();
			}
		}
		
		_lineSet = _arrayParser.ID;
	}
	
	if (is_string(_token_end))
	{
		var _i = [0, 0];
		var _count = array_length(_lineSet);
		repeat (_count)
		{
			_stringParser.setParser(_lineSet[_i[0]]);
			
			if (_stringParser.containsAll(_token_end))
			{
				return _result;
			}
			else if (_stringParser.containsAll(_token_target))
			{
				if (_multiline)
				{
					var _string_multiline = _lineSet[_i[0]];
					_i[1] = 1;
					repeat (_count - _i[0] - _i[1])
					{
						_stringParser.setParser(_lineSet[_i[0] + _i[1]]);
						
						if (_stringParser.containsAll(_token_end))
						{
							return _string_multiline;
						}
						else
						{
							_stringParser.replace("/").replace("	");
							
							if (_stringParser.getSize() > 0)
							{
								_string_multiline += (" " + _stringParser.ID);
							}
						}
						
						++_i[1];
					}
				}
				else
				{
					array_push(_result, _stringParser.ID);
				}
			}
			
			++_i[0];
		}
	}
	else
	{
		var _i = 0;
		repeat (array_length(_lineSet))
		{
			_stringParser.setParser(_lineSet[_i]);
			
			if (_stringParser.containsAll(_token_target))
			{
				return _stringParser.ID;
			}
			
			++_i;
		}
	}
	
	return _result;
}
