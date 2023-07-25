//  @function				table_create_constructor_events()
/// @argument				event_data {string[]}
/// @returns				{string}
/// @description			Format an HTML element with information about specified constructor events.
function table_create_constructor_events(_event_data)
{
	var _count = array_length(_event_data);
	
	if (_count > 0)
	{
		var _result = ("<h3>Events</h3>" + "\n" +
					   "<table>" + "\n" +
					   "    <tr>" + "\n" +
					   "        <td><div align=\"center\"><b>Pre-execution</b></div></td>" + "\n" +
					   "        <td><div align=\"center\"><b>Post-execution</b></div></td>" + "\n" +
					   "    </tr>");
	
		var _i = -1;
		repeat (_count div 2)
		{
			_result += ("\n" +
						"    <tr>" + "\n" +
						"        <td><div align=\"center\">" + _event_data[++_i] + "</div></td>" +
								 "\n" +
						"        <td><div align=\"center\">" + _event_data[++_i] + "</div></td>" +
								 "\n" +
						"    </tr>");
		}
	
		_result += ("\n" + "</table>");
	
		return _result;
	}
	else
	{
		return "";
	}
}
