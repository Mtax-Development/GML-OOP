//  @function				table_create_constructor_properties()
/// @argument				property_data {string[+]}
/// @argument				supplement_properties {struct}
/// @argument				constructor_name {string}
/// @returns				{string}
/// @description			Format an HTML element with information about specified constructor events.
function table_create_constructor_properties(_property_data, _supplement_properties, _constructor_name)
{
	var _skipDefaultValue = ((_supplement_properties.defaultValue == "None")
							 or ((is_array(_supplement_properties.defaultValue))
							 and (array_length(_supplement_properties.defaultValue) == 1)
							 and (_supplement_properties.defaultValue[0] == "None")));
	
	var _result = ("<h3>" + ((_constructor_name == "ErrorReport") ? "Static " : "") +
							 "Properties</h3>" + "\n" +
				   "<table>" + "\n" +
				   "    <tr>" + "\n" +
				   "        <td><div align=\"center\"><b>Name</b></div></td>" + "\n" +
				   "        <td><div align=\"center\"><b>Type</b></div></td>" + "\n" +
				   ((!_skipDefaultValue)
				    ? ("        <td><div align=\"center\"><b>Default</b></div></td>" + "\n") : "") +
				   "        <td><div align=\"center\"><b>Modifiable</b></div></td>" + "\n" +
				   "    </tr>");
	
	var _count = array_length(_property_data);
	var _data_type = get_supplement_array(_supplement_properties.type, _count);
	var _data_defaultValue = get_supplement_array(_supplement_properties.defaultValue, _count);
	var _data_modifiable = get_supplement_array(_supplement_properties.modifiable, _count);
	
	if (_property_data[0][0] == "parent")
	{
		var _parent_name = string_copy(_constructor_name, 1,
									   (string_last_pos(".", _constructor_name) - 1));
		array_insert(_data_type, 0, ("{" + _parent_name + "}"));
		array_insert(_data_defaultValue, 0, "other");
		array_insert(_data_modifiable, 0, false);
	}
	
	var _i = 0;
	repeat (_count)
	{
		var _text_propertyName = _property_data[_i][0];
		var _text_defaultValue = ((_data_defaultValue[_i] != "?") ? string(_data_defaultValue[_i])
																  : _property_data[_i][1]);
		var _text_defaultValue_isValue = true;
		switch (_text_defaultValue)
		{
			case "None":
				_text_defaultValue_isValue = false;
			break;
			
			case "null":
				_text_defaultValue = "undefined";
			break;
			
			case "string(undefined)":
				_text_defaultValue = "\"undefined\"";
			break;
		}
		
		if (_text_defaultValue_isValue)
		{
			_text_defaultValue = code(_text_defaultValue);
		}
		
		var _text_modifiable = _data_modifiable[_i];
		switch (_data_modifiable[_i])
		{
			case false:
				_text_modifiable = "No";
			break;
			
			case true:
				_text_modifiable = "Yes";
			break;
		}
		
		_result += ("\n" +
					"    <tr>" + "\n" +
					"        <td><div align=\"center\">" + _text_propertyName + "</div></td>" + "\n" +
					"        <td><div align=\"center\">" + code(format_links(_data_type[_i],
																			 _constructor_name,
																			 undefined, undefined,
																			 true)) +
								"</div></td>" + "\n" +
					((!_skipDefaultValue)
					 ? ("        <td><div align=\"center\">" + _text_defaultValue +
								 "</div></td>" + "\n") : "") +
					"        <td><div align=\"center\">" + _text_modifiable + "</div></td>" +
							 "\n" +
					"    </tr>");
		
		++_i;
	}
	
	_result += ("\n" + "</table>");
	
	return _result;
}
