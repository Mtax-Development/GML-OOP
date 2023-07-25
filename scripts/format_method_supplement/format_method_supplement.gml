//  @function				format_method_supplement()
/// @argument				supplement? {struct}
/// @returns				{struct}
/// @description			Apply specific formatting to the specified method supplement and connect
///							strings in array into a single string by connecting them with a line break.
function format_method_supplement(_supplement)
{
	static __arrayToNewline = function(_value)
	{
		if (is_array(_value))
		{
			var _string = "";
			var _newline = ("<br>" + "\n");;
			var _value_count = array_length(_value);
			var _i = 0;
			repeat (_value_count)
			{
				var _prefix = "";
				var _postfix = "";
				var _value_char_first = string_char_at(_value[_i], 1);
				var _value_char_last = string_char_at(_value[_i], string_length(_value[_i]));
				
				if (_i > 0)
				{
					var _value_previous_char_first = string_char_at(_value[(_i - 1)], 1);
					var _value_previous_char_last = string_char_at(_value[(_i - 1)],
																   string_length(_value[(_i - 1)]));
					
					if ((_value_previous_char_first == "•") or (_value_previous_char_last == ":"))
					{
						_prefix += _newline;
					}
					
					if ((_value_previous_char_first == "•") and (_value_char_first != "•"))
					{
						_prefix += _newline;
					}
				}
				
				_string += (_prefix + _value[_i] + _postfix + "\n");
				
				++_i;
			}
			
			return _string;
		}
		
		return _value;
	}
	
	_supplement.description.replacement = __arrayToNewline(_supplement.description.replacement);
	_supplement.description.addendum = __arrayToNewline(_supplement.description.addendum);
	_supplement.example.code = __arrayToNewline(_supplement.example.code);
	
	return _supplement;
}
