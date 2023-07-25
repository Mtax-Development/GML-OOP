//  @function				field_create_code_example()
/// @argument				supplement_example {struct}
/// @argument				constructor_name {string}
/// @argument				constructor_property {string[+]}
/// @argument				method_name {string}
/// @returns				{string}
/// @description			Format an HTML element with the example code for a method of specified
///							name.
function field_create_code_example(_supplement_example, _constructor_name, _constructor_property,
								   _method_name)
{
	var _result = "";
	
	if (is_string(_supplement_example.code))
	{
		_result = ("<hr>" + "\n\n" +
				   "<details><summary><b>Example</b></summary>" + "\n" +
				   "<blockquote>" + "\n" +
				   "<b>Code</b>" + "\n" +
				   "<pre>" + "\n" +
				   format_links(_supplement_example.code, _constructor_name,
								_constructor_property, false, true) +
				   "</pre>" + "\n");
		
		_result = string_replace_all(_result, _method_name, ("<b>" + _method_name + "</b>"));
		
		if (is_string(_supplement_example.result))
		{
			_result += ("\n" + "<b>Result</b>" + "\n" +
						"<pre>" + "\n" +
						format_links(_supplement_example.result, _constructor_name,
									 _constructor_property, true, true) + "\n" +
						"</pre>" + "\n");
		}
		
		if (is_struct(_supplement_example.explanation))
		{
			var _text_explanation = "";
			
			if ((is_string(_supplement_example.explanation.code))
			or (is_array(_supplement_example.explanation.code)))
			{
				var _explanation_code = array(_supplement_example.explanation.code);
				var _newline = ("\n" + "<br>" + "\n");
				
				var _i = 0;
				repeat (array_length(_explanation_code))
				{
					_text_explanation += (_newline + "<b>" + "• Line " + string(_i + 1) + ":" +
										  "</b>" + " " +
										  format_specific_descriptions(
										   format_links(_explanation_code[_i], _constructor_name,
														_constructor_property, true, true, true)));
					
					++_i;
				}
				
				if (is_string(_supplement_example.explanation.result))
				{
					_text_explanation += (_newline + "<b>" + "• Result:" + "</b>" + " " +
										  format_specific_descriptions(
										   format_links(_supplement_example.explanation.result,
														_constructor_name, _constructor_property,
														true, true, true)));
				}
			}
			
			_result += ("\n" + "<hr>" + "\n\n" +
						"<b>Explanation</b>" +
						_text_explanation + "\n");
		}
		
		_result += ("</blockquote>" + "\n" + "</details>");
	}
	
	return _result;
}
