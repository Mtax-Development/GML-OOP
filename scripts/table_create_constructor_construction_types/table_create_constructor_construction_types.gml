//  @function				table_create_constructor_construction_types()
/// @argument				constructionType {string[]}
/// @argument				defaultArgument {string[]}
/// @argument				constructor_name {string}
/// @argument				supplement_constructionTypes {struct}
/// @returns				{string}
/// @description			Format an HTML element with information about specified constructor types.
function table_create_constructor_construction_types(_constructionType, _defaultArgument,
													 _constructor_name, _supplement_constructionTypes)
{
	static _stringParser = new StringParser();
	
	var _count = array_length(_constructionType);
	var _type_description = get_supplement_array(_supplement_constructionTypes.description, _count);
	var _type_description_hasContent = supplement_array_has_content(_type_description);
	var _table_entry = "";
	var _table_entry_content = [];
	var _note_exists = false;
	var _type_note = array_create(_count, "");
	
	var _i = [0, 0, 0];
	repeat (_count)
	{
		var _note = _stringParser.setParser(_constructionType[_i[0]]).split("\n");
		
		if (is_array(_note))
		{
			_note_exists = true;
			_constructionType[_i[0]] = _note[0];
			
			var _note_count = (array_length(_note) - 1);
			_i[1] = 1;
			repeat (_note_count)
			{
				_type_note[_i[0]] += _stringParser.setParser(_note[_i[1]]).trim().ID;
				
				if (_i[1] < _note_count)
				{
					if (string_count(":", _note[_i[1]]) > 0)
					{
						if (string_count(":", _note[_i[1] + 1]) > 0)
						{
							_type_note[_i[0]] += ("\n" + "                                <br>" +
													"\n" + "                                ");
						}
					}
					
					var _char_last = string_char_at(_type_note[_i[0]],
													string_length(_type_note[_i[0]]));
					
					if (_char_last == string_lettersdigits(_char_last))
					{
						_type_note[_i[0]] += " ";
					}
				}
				
				++_i[1];
			}
		}
		
		var _type = _stringParser.setParser(_constructionType[_i[0]]).split(": ");
		
		if (!is_array(_type))
		{
			var _string_defaultArgument = "";
			_i[1] = 0;
			repeat (array_length(_defaultArgument))
			{
				if (_i[1] != 0)
				{
					_string_defaultArgument += ", ";
				}
				
				_string_defaultArgument += _defaultArgument[_i[1]];
				
				++_i[1];
			}
			
			_type = [_type, _string_defaultArgument];
		}
		
		_type[0] = string_replace_all(_type[0], "New constructor.", "New constructor");
		_type[1] = _stringParser.setParser(_type[1]).split(", ");
		
		if (!is_array(_type[1]))
		{
			_type[1] = [_type[1]];
		}
		
		var _whitespace = (string_repeat(" ", 32));
		var _type_arguments = "";
		_i[2] = 0;
		repeat (array_length(_type[1]))
		{
			if (_i[2] != 0)
			{
				_type_arguments += ("\n" + _whitespace + "<br>" + "\n" + _whitespace);
			}
			
			var _text_argument = _type[1][_i[2]];
			
			if (_stringParser.setParser(_type[1][_i[2]]).getSubstringCount(" ") > 1)
			{
				var _text_argument_split = _stringParser.split(" ");
				_text_argument = "";
				_i[1] = 0;
				repeat (array_length(_text_argument_split))
				{
					_text_argument += (((_i[1] == 1) ? " " : "") + _text_argument_split[_i[1]]);
					
					++_i[1];
				}
			}
			
			if (_text_argument == "")
			{
				_text_argument = "{void}";
			}
			
			_text_argument = format_links(_stringParser.setParser(_text_argument).trim().ID,
										  _constructor_name, undefined, undefined, true);
			_text_argument = code(_text_argument);
			_type_arguments += _text_argument;
			
			++_i[2];
		}
		
		array_push(_table_entry_content, [_type[0], _type_arguments, _type_description[_i[0]]]);
		
		++_i[0];
	}
	
	var _i = 0;
	repeat (array_length(_type_note))
	{
		if (string_length(_type_note[_i]) > 0)
		{
			_type_note[_i] = (format_links(format_specific_descriptions(_type_note[_i]),
							  _constructor_name, undefined, undefined, true, noone));
		}
		
		++_i;
	}
	
	var _table_header = ("<h3>Construction types</h3>" + "\n" +
						 "<table>" + "\n" +
						 "    <tr>" + "\n" +
						 "        <td><div align=\"center\"><b>Name</b></div></td>" + "\n" +
						 "        <td><div align=\"center\"><b>Arguments</b></div></td>" + "\n" +
						 ((_note_exists)
						  ? "        <td><div align=\"center\"><b>Argument note</b></div></td>" + "\n"
						  : "") +
						 ((_type_description_hasContent)
						  ? "        <td><div align=\"center\"><b>Description</b></div></td>" + "\n"
						  : "") +
						 "    </tr>");
	
	var _i = 0;
	repeat (_count)
	{
		_table_entry += ("\n" +
						 "    <tr>" + "\n" +
						 "        <td><div align=\"center\">" + _table_entry_content[_i][0] +
								  "</div></td>" + "\n" +
						 "        <td><div align=\"center\">" + _table_entry_content[_i][1] +
								  "</div></td>" + "\n" +
						 ((_note_exists)
						  ? ("        <td><div align=\"center\">" + _type_note[_i] + "</div></td>" +
									  "\n")
						  : "") +
						 ((_type_description_hasContent)
						  ? ("        <td><div align=\"center\">" + _table_entry_content[_i][2] +
									  "</div></td>" + "\n")
						  : "") +
						 "    </tr>");
		
		++_i;
	}
	
	return (_table_header + _table_entry + "\n" + "</table>");
}
