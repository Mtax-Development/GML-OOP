constructorName = string_replace(object_get_name(object_index), "unitTest_", "");
constructorType = asset_get_index(constructorName);

unitTest = new UnitTest(script_get_name(constructorType));

order_display = true;

exception = undefined;

show_debug_message("Executing Unit Tests: " + constructorName);

try
{
	event_user(0);
}
catch (_exception)
{
	exception = _exception;
}

if (exception == undefined)
{
	show_debug_message("Unit Testing of " + constructorName + " complete: " +
					   (string(unitTest.testID - unitTest.getFailedTestCount()) + "/" +
					    string(unitTest.testID)) + " tests passed.");
}
