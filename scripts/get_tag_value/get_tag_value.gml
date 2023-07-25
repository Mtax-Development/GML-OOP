//  @function				get_tag_value()
/// @argument				tag {string}
/// @returns				{string}
/// @description			Return the value of the specified JSDoc tag.
function get_tag_value(_tag)
{
	static __format = function(_tag)
	{
		static _stringParser = new StringParser();
		
		var _result = "";
		var _split = _stringParser.setParser(_tag).replace("	", " ").split(" ");
		var _i = 2;
		repeat (array_length(_split) - _i)
		{
			if (_i != 2)
			{
				_result += " ";
			}
			
			_result += _split[_i];
			
			++_i;
		}
		
		return _stringParser.setParser(_result).trim().ID;
	}
	
	if (is_array(_tag))
	{
		var _count = array_length(_tag);
		var _result = array_create(_count, undefined);
		var _i = 0;
		repeat (_count)
		{
			_result[_i] = __format(_tag[_i]);
			
			++_i;
		}
		
		return _result;
	}
	else
	{
		return __format(_tag);
	}
}
