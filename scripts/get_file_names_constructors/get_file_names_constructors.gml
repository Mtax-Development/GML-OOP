//  @function				get_file_names_constructors()
/// @returns				{string[]}
/// @description			Scan the script directory and contained scripts to obtain a list of
///							constructor names.
function get_file_names_constructors()
{
	static _stringParser = new StringParser();
	
	var _result = [];
	var _folder = file_find_first((path.scripts + "*"), fa_directory);
	
	while (_folder != "")
	{
	    array_push(_result, _folder);
		
		var _file = file_to_string(path.scripts + (_folder + @"\" + _folder + path.extension.script));
		
		if (string_count("//  @function", _file) > 1)
		{
			var _lineSet = _stringParser.setParser(_file).split("\n");
			var _element_declaration = find_lines_containing("//  @function", _lineSet, 1,
															  "#region [Constructor]");
			var _i = 0;
			repeat (array_length(_element_declaration))
			{
				array_push(_result, string_replace(get_tag_value(_element_declaration[_i]), "()", ""));
				
				++_i;
			}
		}
		
	    _folder = file_find_next();
	}
	
	return _result;
}
