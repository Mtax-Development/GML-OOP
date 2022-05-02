if (order_display)
{
	if (exception == undefined)
	{
		show_message(unitTest.getResults());
	}
	else
	{
		var _stacktraceText = "";
		
		var _i = 0;
		var _stacktrace_length = array_length(exception.stacktrace);
		repeat (_stacktrace_length)
		{
			_stacktraceText += ("\n" + string(_stacktrace_length - _i) + ": " +
								string(exception.stacktrace[_i]));
			
			++_i;
		}
		
		var _errorText = ("ERROR: " + "Unit Testing of " + constructorName + " failed:" + "\n" +
						  "Line " + string(exception.line) + ": " + string(exception.message) + "\n" +
						  _stacktraceText);
		
		show_debug_message(_errorText);
		show_message(_errorText);
	}
	
	order_display = false;
}

