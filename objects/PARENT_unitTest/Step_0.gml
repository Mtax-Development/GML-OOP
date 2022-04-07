if (order_display)
{
	if (errorMessage == undefined)
	{
		show_message(unitTest.getResults());
	}
	else
	{
		var _errorText = ("ERROR: " + "Unit Testing of " + constructorName + " failed:" + "\n"
						  + string(errorMessage));
		
		show_debug_message(_errorText);
		show_message(_errorText);
	}
	
	order_display = false;
}
