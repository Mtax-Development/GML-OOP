//  @function				generate_page_constructor()
/// @argument				path {string:path}
/// @argument				element? {string}
/// @description			Write HTML pages for methods of a constructor at the specified path or its
///							specified element constructor.
function generate_pages_methods(_path, _element)
{	
	static _stringParser = new StringParser();
	static _arrayParser = new ArrayParser();
	static _arrayParser_propertyName = new ArrayParser();
	
	var _result = "";
	var _file = new StringParser(file_to_string(_path));
	var _lineSet = _file.split("\n");
	var _lineSet_cut = [];
	lineset_extract_element(_lineSet, _element);
	array_copy(_lineSet_cut, 0, _lineSet, 0, array_length(_lineSet));
	var _constructor_name = _stringParser
							 .setParser(string_replace(
										 get_tag_value(find_lines_containing("//  @function",
																			 _lineSet)),
													   "()", ""))
							 .trim().ID;
	var _constructor_property = get_constructor_properties(_lineSet);
	var _filter_method = ["static ", " = function("];
	var _element_start_line = get_line_position(
							   find_lines_containing([(_constructor_name + "."), "//  @function"],
													  _lineSet), _lineSet);
	var _region = "";
	
	repeat (string_count(_filter_method[1], _file.ID))
	{
		var _method = find_lines_containing(_filter_method, _lineSet_cut);
		var _method_line = get_line_position(_method, _lineSet);
		
		if (_method_line >= _element_start_line)
		{
			exit;
		}
		
		var _i = 0;
		repeat (_method_line)
		{
			_stringParser.setParser(_lineSet[(_method_line - _i)]);
			
			if (_stringParser.contains("#region "))
			{
				_region = _stringParser.setParser(_stringParser.trim().split(" ")[1])
									   .getLettersAndDigits();
				
				break;
			}
			
			++_i;
		}
		
		lineset_cut_to_string(_lineSet_cut, _method);
		
		var _method_description = undefined;
		var _method_returns = undefined;
		var _method_argument = [];
		var _i = [1, 0];
		repeat (_method_line)
		{
			var _line_position = (_method_line - _i[0]);
			var _line = _lineSet[_line_position];
			
			if (string_lettersdigits(_line) == "")
			{
				var _method_name = _stringParser.setParser(_method).trim().split(" ")[1];
				
				if ((_method_name != "construct") and (string_count("__", _method_name) <= 0))
				{
					array_push(method_listing.getValue(_constructor_name, _region), _method_name);
					var _supplement = format_method_supplement(load_supplement(_constructor_name,
																			   _method_name));
				}
				
				break;
			}
			
			_stringParser.setParser(_lineSet[_line_position]);
			
			if ((!is_string(_method_description)) and (_stringParser.contains("// @description")))
			{
				_method_description = get_tag_value(find_lines_containing("// @description", _lineSet,
																		  _line_position, _method,
																		  true));
			}
			
			if (!is_string(_method_returns)) and (_stringParser.contains("// @returns"))
			{
				_method_returns = get_tag_value(
				 find_lines_containing("// @returns", _lineSet, _line_position,
									   ["// @description", _method], true));
			}
			
			if (_stringParser.contains("// @argument"))
			{
				var _method_argument_split = _stringParser.setParser(get_tag_value(
											  find_lines_containing("// @argument",_lineSet,
																	_line_position,
																	["// @returns", "// @description",
																	_method])))
														  .split(" ");
				
				if (!is_array(_method_argument_split))
				{
					show_error(("Invalid method documentation formatting in " +
								string(_constructor_name) + "()" + ": " +
								string(_method_argument_split)), true);
				}
				
				_method_argument_split[1] = format_links(_method_argument_split[1], _constructor_name,
														 undefined, true);
				array_insert(_method_argument, 0, _method_argument_split);
			}
			
			++_i[0];
		}
		
		if (_method_name != "construct") and (!_stringParser.setParser(_method_name).contains("__"))
		{
			var _method_argument_count = array_length(_method_argument);
			var _text_returns = ((is_string(_supplement.returns))
								 ? _supplement.returns
								 : ((is_string(_method_returns))
									? ("<code>" + format_links(_method_returns, _constructor_name,
															   undefined, true) + "</code>")
									: undefined));
			var _text_example = field_create_code_example(_supplement.example, _constructor_name,
														  _constructor_property, _method_name);
			
			if (!is_string(_method_description))
			{
				show_error(("Method description invalid at " + string(_constructor_name) + "." +
							string(_method_name) + "()."), true);
			}
			
			if (is_string(_supplement.description.replacement))
			{
				_method_description = _supplement.description.replacement;
			}
			
			var _addendum = array(_supplement.description.addendum);
			var _i = 0;
			repeat (array_length(_addendum))
			{
				if (is_string(_addendum[_i]))
				{
					_method_description += ("\n" + "<br>" + "\n" + "<br>" + "\n" + _addendum[_i]);
				}
				
				++_i;
			}
			
			var _ignoredLinks = _arrayParser.setParser(_arrayParser.setParser(_method_argument)
																   .getColumn(0));
			var _i = 0;
			repeat (array_length(_ignoredLinks.ID))
			{
				_ignoredLinks.ID[_i] = string_replace_all(_ignoredLinks.ID[_i], "?", "");
				_ignoredLinks.ID[_i] = string_replace_all(_ignoredLinks.ID[_i], "...", "");
				
				++_i;
			}
			
			_ignoredLinks.removeValue(_arrayParser_propertyName);
			
			_method_description = format_type_brackets(
								   format_links(format_specific_descriptions(_method_description),
												_constructor_name, _constructor_property, true,
												true, true, undefined, _ignoredLinks.ID));
			
			_result = ("<h3>Argument" + ((_method_argument_count == 1) ? "" : "s") + "</h3>" + "\n" +
					   ((_method_argument_count <= 0)
					    ? "\nNone." : table_create_method_arguments(_method_argument,
																	_supplement.argument)) +
					   "\n\n" + "<h3>Returns</h3>" + "\n" +
					   ((is_string(_text_returns)) ? _text_returns : "\nNot applicable.") + "\n\n" +
					   "<h3>Description</h3>" + "\n\n" +
					   _method_description + "\n" +
					   ((string_length(_text_example) > 0) ? (_text_example + "\n") : ""));
			
			var _path_constructor = (_constructor_name + @"\");
			var _path_page = (path.output + _path_constructor + _constructor_name + "." +
							  _method_name + "()" + path.extension.page);
			string_to_file(_path_page, _result);
			++output_count.method_page;
		}
	}
}
