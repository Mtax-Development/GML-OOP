//  @function				table_create_method_arguments()
/// @argument				method_argument {string[+]}
/// @argument				supplement_argument {struct}
/// @returns				{string}
/// @description			Format an HTML element with information about specified method arguments.
function table_create_method_arguments(_method_argument, _supplement_argument)
{
	var _count = array_length(_method_argument);
	var _data_description = get_supplement_array(_supplement_argument.description, _count);
	var _data_description_hasContent = supplement_array_has_content(_data_description);
	var _result = ("<table style=\"text_align:center;\">" + "\n" +
				   "    <tr>" + "\n" +
				   "        <td><div align=\"center\"><b>Name<b></div></td>" + "\n" +
				   "        <td><div align=\"center\"><b>Type<b></div></td>" + "\n" +
				   "        <td><div align=\"center\"><b>Optional<b></div></td>" + "\n" +
				   ((_data_description_hasContent)
					? "        <td><b><div align=\"center\">Description</div></b></td>" + "\n"
					: "") +
				   "    </tr>" + "\n");
	var _i = 0;
	repeat (_count)
	{
		_result += ("    <tr>" + "\n" +
					"        <td><div align=\"center\"><code>" + _method_argument[_i][0] +
							"</code></div></td>" + "\n" +
					"        <td><div align=\"center\"><code>" + _method_argument[_i][1] +
							"</code></div></td>" + "\n" +
					"        <td><div align=\"center\">" +
							 ((string_count("?", _method_argument[_i][0]) > 0) ? "Yes" : "No") +
							 "</div></td>" + "\n" +
					((_data_description_hasContent)
					 ? ("        <td><div align=\"center\">" + _data_description[_i] + "</div></td>"
						+ "\n")
					 : "") +
					"    </tr>" + "\n");
		
		++_i;
	}
	
	_result += "</table>";
	
	return _result;
}
