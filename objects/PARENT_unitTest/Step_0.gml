if (order_display)
{
	if (exception == undefined)
	{
		show_message(unitTest.getResults());
	}
	else
	{
		var _errorText = ("ERROR: " + "Unit Testing of " + constructorName + " failed:" + "\n" +
						  "Line " + string(exception.line) + ": " + string(exception.message));
		
		show_debug_message(_errorText);
		show_message(_errorText);
	}
	
	order_display = false;
}
