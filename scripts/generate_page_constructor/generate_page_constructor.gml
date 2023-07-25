//  @function				generate_page_constructor()
/// @argument				path {string:path}
/// @argument				element? {string}
/// @description			Write an HTML page for the constructor at the specified path or its
///							specified element constructor.
function generate_page_constructor(_path, _element)
{
	static _stringParser = new StringParser();
	static _arrayParser = new ArrayParser();
	
	var _result = "";
	var _file = new StringParser(file_to_string(_path));
	var _lineSet = _file.split("\n");
	lineset_extract_element(_lineSet, _element);
	var _constructor_name = ((is_string(_element))
							 ? _element
							 : _stringParser
								.setParser(string_replace(get_tag_value(
														   find_lines_containing("//  @function",
																				 _lineSet)), "()", ""))
								.trim().ID);
	var _constructor_argument = get_tag_value(find_lines_containing("// @argument", _lineSet,
																	undefined, "// @description"));
	var _constructor_description = get_tag_value(find_lines_containing("// @description", _lineSet,
																	   undefined, ("Construction " +
																	   "types:"),  true));
	var _constructor_hasDestructor = _file.contains("static destroy = function(");
	var _constructor_element = [];
	var _constructor_element_count = (_file.getSubstringCount(") constructor") - 1);
	var _constructor_property = get_constructor_properties(_lineSet);
	var _supplement = load_supplement(_constructor_name);
	var _text_elements = field_create_constructor_elements(_constructor_element);
	var _text_destruction = "";
	
	if (is_string(_supplement.description.replacement))
	{
		_constructor_description = _supplement.description.replacement;
	}
	
	var _addendum = array(_supplement.description.addendum);
	var _i = 0;
	repeat (array_length(_addendum))
	{
		if (is_string(_addendum[_i]))
		{
			_constructor_description += ("\n" + "<br>" + "\n" + "<br>" + "\n" + _addendum[_i]);
		}
		
		++_i;
	}
	
	_constructor_description = format_specific_descriptions(format_links(_constructor_description,
																		 _constructor_name, undefined,
																		 false, true, noone));
	_constructor_description = string_replace_all(_constructor_description, "{", "<code>{");
	_constructor_description = string_replace_all(_constructor_description, "}", "}</code>");
	
	if (is_string(_supplement.specification.destruction))
	{
		_text_destruction = _supplement.specification.destruction;
	}
	else
	{
		_text_destruction = ((_constructor_hasDestructor)
							 ? ("<code>" + format_links(_constructor_name, _constructor_name) +
								"." + "<a href=\"" + _constructor_name + ".destroy()" +
								"\">destroy()</a></code>")
							 : "Garbage Collection");
	}
	
	var _table_property = table_create_constructor_properties(_constructor_property,
															  _supplement.properties,
															  _constructor_name);
	var _table_event = table_create_constructor_events(get_constructor_events(_lineSet));
	var _table_constructor_types = table_create_constructor_construction_types(
									get_construction_types(find_lines_containing("- ", _lineSet,
																				 "Construction types:",
																				 "() constructor",
																				 true)),
									_constructor_argument, _constructor_name,
									_supplement.constructionTypes);
	
	if (!is_string(_constructor_description))
	{
		show_error(("Constructor description invalid at " + string(_constructor_name) + "."), true);
	}
	
	_result += ("<h3>Description</h3>" + "\n" +
				_constructor_description + "\n\n" +
				"<h3>Specification</h3>" + "\n" +
				"<table style=\"text_align:center;\">" + "\n" +
				"    <tr>" + "\n" +
				"        <td><div align=\"center\"><b>Destruction</b></div></td>" + "\n" +
				"        <td><div align=\"center\"><b>Elements</b></div></td>" + "\n" +
				"    </tr>" + "\n" +
				"    <tr>" + "\n" +
				"        <td><div align=\"center\">" + _text_destruction + "</div></td>" + "\n" +
				"        <td><div align=\"center\">" + _text_elements + "</div></td>" + "\n" +
				"    </tr>" + "\n" +
				"</table>" + "\n\n" +
				_table_property + "\n\n" +
				_table_event + ((string_length(_table_event) > 0) ? "\n\n" : "") +
				_table_constructor_types + "\n");
	
	var _path_constructor = (_constructor_name + @"\");
	var _path_page = (path.output + _path_constructor + _constructor_name + path.extension.page);
	
	string_to_file(_path_page, _result);
	out("---> " + _path_page);
	++output_count.constructor_page;
}
