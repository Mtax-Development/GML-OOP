//  @function				table_of_contents_list_constructor()
/// @argument				constructor_name {string}
/// @argument				element_listing {string[+]}
/// @argument				tabulation? {string}
/// @returns				{string}
/// @description			Format an HTML element for table of contents with entry for the specified
///							constructor and its elements.
function table_of_contents_list_constructor(_constructor_name, _element_listing, _tabulation = "")
{
	var _result = (_tabulation + "        <details>" + "\n" +
				   _tabulation + "            <summary>" + "<a href=\"" + _constructor_name + "\">"
							   + _constructor_name + "</a>" + "</summary>" + "\n" +
				   _tabulation + "            <blockquote>" + "\n");
	
	var _sign_bullet = "&#x25cf;"
	var _i = [0, 0];
	repeat (array_length(method_type))
	{
		var _method_type_current = method_type[_i[0]];
		var _method_listing_current_type = method_listing.getValue(_constructor_name,
																   _method_type_current);
		var _method_listing_current_type_count = array_length(_method_listing_current_type);
		
		if (_method_listing_current_type_count > 0)
		{
			_result += (_tabulation + "                <details open>" + "\n" +
						_tabulation + "                    <summary>" + _method_type_current +
									  "</summary>" + "\n" +
						_tabulation + "                    <blockquote>" + "\n");
			
			_i[1] = 0;
			repeat (_method_listing_current_type_count)
			{
				var _method_name_current = (_method_listing_current_type[_i[1]] + "()");
				
				_result += (_tabulation + "                        " + _sign_bullet + " " +
							"<a href=\"" + _constructor_name + "." + _method_name_current + "\">" +
							_method_name_current + "</a>" + "\n" +
							(((_i[1] + 1) < _method_listing_current_type_count)
							 ? (_tabulation + "                        <br>" + "\n") : ""));
				
				++_i[1];
			}
			
			_result += (_tabulation + "                    </blockquote>" + "\n" +
						_tabulation + "                </details>" + "\n");
		}
				
		++_i[0];
	}
	
	if (array_length(_element_listing) > 0)
	{
		_result += (_tabulation + "            <hr>" + "\n");
		
		var _i = 0;
		repeat (array_length(_element_listing))
		{
			var _element_name = undefined;
			var _nested_element_listing = undefined;
			
			if (array_length(_element_listing[_i]) > 0)
			{
				_element_name = _element_listing[_i][0];
				_nested_element_listing = [];
				array_copy(_nested_element_listing, 0, _element_listing[_i], 1,
						   (array_length(_element_listing[_i]) - 1));
			}
			else
			{
				_element_name = _element_listing[_i];
			}
			
			_result += table_of_contents_list_constructor(_element_name, _nested_element_listing,
														  (_tabulation + "    "));
			
			++_i;
		}
	}
	
	_result += (_tabulation + "            </blockquote>" + "\n" +
				_tabulation + "        </details>" + "\n");
	
	return _result;
}
