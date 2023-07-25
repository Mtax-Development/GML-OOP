function generate_page_table_of_contents()
{
	var _sign_space = "&nbsp;";
	var _sign_bullet = "&#x25cf;"
	var _separator_inline = (_sign_space + _sign_bullet + _sign_space);
	var _constructor_type_array = constructor_type.toArray();
	var _constructor_type_name = new ArrayParser(_constructor_type_array[0]).sort(true);
	var _header = ("<div align=\"center\"><b>Contents</b></div>" + "\n" +
				   "<div align=\"center\"><a href=\"Home\"><b>Home</b></a>" + _separator_inline +
				   "<a href=\"Preface\"><b>Preface</b></a>" + _separator_inline +
				   "<a href=\"Overview\"><b>Overview</b></a>" + "\n" +
				   "<br>" + "\n" +
				   "<a href=\"Examples\"><b>Examples</b></a>" + _separator_inline +
				   "<a href=\"Contributing\"><b>Contributing</b></a>" + "\n" +
				   "<br>" + "\n" +
				   "<a href=\"Ignored Directories List\"><b>Ignored Directories List</b></a>" + "\n" +
				   "</div>");
	
	var _constructors = ("<div align=\"center\"><b>Constructors</b></div>" + "\n\n");
	var _i = [0, 0, 0];
	repeat (_constructor_type_name.getSize())
	{
		_constructors += ("<details>" + "\n" +
						  "    <summary>" + _constructor_type_name.ID[_i[0]] + "</summary>" + "\n" +
						  "    <blockquote>" + "\n");
		
		var _constructor_type_current = constructor_type.getValue(_constructor_type_name.ID[_i[0]]);
		var _constructor_type_current_count = array_length(_constructor_type_current);
		_i[1] = 0;
		repeat (_constructor_type_current_count)
		{
			if (_i[1] >= _constructor_type_current_count)
			{
				break;
			}
			
			var _constructor_name_current = _constructor_type_current[_i[1]];
			var _constructor_element_listing = undefined;
			_i[2] = (_i[1] + 1);
			
			if (_i[2] < _constructor_type_current_count)
			{
				var _constructor_name_next = _constructor_type_current[_i[2]];
				
				if (string_count(".", _constructor_name_next) >
					string_count(".", _constructor_name_current))
				{
					_constructor_element_listing = [];
					
					repeat (_constructor_type_current_count - _i[2])
					{
						var _element_name = _constructor_type_current[_i[2]];
						var _element_separator_count = string_count(".", _element_name)
						
						if (!(_element_separator_count > 0))
						{
							break;
						}
						
						switch (_element_separator_count)
						{
							case 1:
								array_push(_constructor_element_listing, [_element_name]);
							break;
							case 2:
								array_push(_constructor_element_listing[(array_length(
																		_constructor_element_listing) -
																		1)], _element_name);
							break;
						}
						
						++_i[2];
					}
				}
			}
			
			_constructors += table_of_contents_list_constructor(_constructor_name_current,
																_constructor_element_listing);
			
			_i[1] = _i[2];
		}
		
		_constructors += ("    </blockquote>" + "\n" +
						  "</details>" + "\n");
		
		++_i[0];
	}
	
	var _result = (_header + "\n\n" + "<hr>" + "\n\n" + _constructors);
	var _path_page = (path.output + path.file.page.table_of_contents);
	string_to_file(_path_page, _result);
	out("---> " + _path_page);
	++output_count.table_of_contents_page;
}
