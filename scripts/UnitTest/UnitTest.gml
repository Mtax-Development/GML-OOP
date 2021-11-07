/// @function				UnitTest()
/// @argument				{any} name?
///	@description			Constructs a UnitTest constructor, used for testing invidual pieces of
///							code to ensure they keep their intended behavior and stability.
/// @author					Mtax (github.com/Mtax-Development)
function UnitTest() constructor
{
	#region [Static Properties]
		#region [Configurable variables]
			
			// @type		{function|undefined}
			// @member		A function used for displaying the asserted values.
			static logAssertion = show_debug_message;
			
		#endregion
		#region [Operational variables]
			
			// @type		{bool}
			// @member		A property set and kept true only if any of the test had failures.
			static failuresExist = false;
			
		#endregion
	#endregion
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function(_name)
			{
				name = string(_name);
				
				testID = 0;
				testStatus = [];
				testNames = [];
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{int}
			// @description			Get the number of failures, counting only one per each test ID.
			static getFailedTestCount = function()
			{
				var _failedTestCount = 0;
				
				var _i = 0;
				repeat (array_length(testStatus))
				{
					var _j = 0;
					repeat (array_length(testStatus[_i]))
					{
						if (!testStatus[_i][_j].success)
						{
							++_failedTestCount;
							break;
						}
						
						++_j;
					}
					
					++_i;
				}
				
				return _failedTestCount;
			}
			
			// @returns				{string}
			// @description			Create a formatted string listing the saved results of the tests.
			static getResults = function()
			{
				var _string_results = "";
				var _failures_exist = false;
				var _testStatus_number = array_length(testStatus);
				var _longestTestName = 0;
				
				var _i = 0;
				repeat (_testStatus_number)
				{
					var _string_test = "";
					
					var _failures = [];
					var _failure_last = undefined;
					
					var _j = 0;
					repeat (array_length(testStatus[_i]))
					{
						if (!testStatus[_i][_j].success)
						{
							array_push(_failures, (_j + 1));
							_failure_last = (_j + 1);
						}
						
						++_j;
					}
					
					var _string_testName = ((testNames[_i] != undefined)
											? (" " +string(testNames[_i])) : "");
					
					var _string_testID_primaryZero = (((_i + 1) < 10) ? "0" : "");
					
					_string_test += ("Test #" + _string_testID_primaryZero + string(_i + 1) + ": ");
					
					var _string_testName_length = string_length(_string_testName);
					
					if (_string_testName_length > 0)
					{
						_string_test += (_string_testName + ": ");
					}
					
					var _failures_length = array_length(_failures);
					
					var _mark_notEqual = " ≠ ";
					var _mark_failure_separator_single = ": ";
					var _mark_failure_separator_multi = ", ";
					
					if (_failures_length > 0)
					{
						_failures_exist = true;
						
						var _failure = testStatus[_i][(_failures[0] - 1)];
						
						var _string_failureType;
						switch (_failure.type)
						{
							case "Assert: Executable":
								_string_failureType = "EXCEPTION";
							break;
							
							default:
								_string_failureType = "FAILURE";
							break;
						}
						
						var _string_multipleFailures = ((_failures_length > 1) ? "S" : "");
						
						var _string_detail = "";
						var _string_preDetail = "(";
						var _string_postDetail = ")";
						var _string_singleFailureNumber = "";
						
						if (_failures_length == 1)
						{
							_string_singleFailureNumber = (string(_failure_last) +
														   _mark_failure_separator_single);
							
							switch (_failure.type)
							{
								case "Assert: Equal":
								case "Assert: Not equal":
									_string_detail = (string(_failure.functionReturn) +
													  _mark_notEqual +
													  string(_failure.expectedValue));
								break;
								
								case "Assert: Executable":
									_string_detail = string(_failure.exception.message);
								break;
								
								case "Assert: Untested":
									_string_singleFailureNumber = "";
									_string_preDetail = "";
									_string_postDetail = "";
									_string_detail = "Untested";
								break;
							}
						}
						else
						{
							var _j = 0;
							repeat (_failures_length)
							{
								if (_j != 0)
								{
									 _string_detail += _mark_failure_separator_multi;
								}
								
								 _string_detail += string(_failures[_j]);
							
								++_j;
							}
						}
						
						_string_test += (_string_failureType + _string_multipleFailures + ": " +
										 _string_singleFailureNumber + _string_preDetail +
										 _string_detail + _string_postDetail);
					}
					else
					{
						switch (testStatus[_i][0].type)
						{
							case "Assert: Executable": _string_test += "EXECUTABLE"; break;
							default: _string_test += "SUCCESS"; break;
						}
					}
					
					var _string_test_length = string_length(_string_test);
					
					if (_string_test_length > _longestTestName)
					{
						_longestTestName = _string_test_length;
					}
					
					_string_results += (_string_test + "\n");
					
					++_i;
				}
				
				var _string_title = ((name != undefined) ? string(name) + " - " : "");
				
				_string_title += ("Test Results" + " - ");
				
				if (_testStatus_number > 0)
				{
					_string_title += ((_failures_exist) ? "FAILURES PRESENT" : "ALL CLEAR");
				
					var _string_separator = string_repeat("-", _longestTestName);
				
					return (_string_title + ":\n" + _string_separator + "\n" + _string_results +
							_string_separator);
				}
				else
				{
					_string_title += "NO TESTS DONE";
					
					return _string_title;
				}
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{string} name
			// @argument			{any} functionReturn...
			// @argument			{any} expectedValue...
			// @description			Check if the value returned by the function is the same as the
			//						specified expected one.
			//						A name of this test must be specified in the first argument of
			//						this function, which will be used to in displaying its results.
			//						Then the next arguments will accept any number of the argument
			//						pairs for function return and their expected return values.
			//						Assertion details will be logged used the function set in the
			//						"logAssertion" variable of this constructor if possible.
			static assert_equal = function()
			{
				testNames[testID] = argument[0];
				
				var _i = 1;
				repeat ((argument_count - 1) div 2)
				{
					var _pair = ((_i - 1) div 2);
					
					var _functionReturn = argument[_i];
					var _expectedValue = argument[_i + 1];
					
					var _success;
					
					if ((is_array(_functionReturn)) and (is_array(_expectedValue)))
					{
						_success = array_equals(_functionReturn, _expectedValue);
					}
					else if ((is_struct(_functionReturn)) and (is_struct(_expectedValue)))
					{
						var _functionReturn_instanceof = instanceof(_functionReturn);
						var _expectedValue_instanceof = instanceof(_expectedValue);
						
						if (_functionReturn_instanceof == _expectedValue_instanceof)
						{
							switch (_functionReturn_instanceof)
							{
								case "Vector2":
									_success = ((_functionReturn.x == _expectedValue.x) 
												and (_functionReturn.y == _expectedValue.y));
								break;
								
								case "Vector4":
									_success = ((_functionReturn.x1 == _expectedValue.x1) and
												(_functionReturn.y1 == _expectedValue.y1) and
												(_functionReturn.x2 == _expectedValue.x2) and
												(_functionReturn.y2 == _expectedValue.y2));
								break;
								
								case "Color2":
									_success = ((_functionReturn.color1 == _expectedValue.color1) and
												(_functionReturn.color2 == _expectedValue.color2));
								break;
								
								case "Color3":
									_success = ((_functionReturn.color1 == _expectedValue.color1) and
												(_functionReturn.color2 == _expectedValue.color2) and
												(_functionReturn.color3 == _expectedValue.color3));
								break;
								
								case "Color4":
									_success = ((_functionReturn.color1 == _expectedValue.color1) and
												(_functionReturn.color2 == _expectedValue.color2) and
												(_functionReturn.color3 == _expectedValue.color3) and
												(_functionReturn.color4 == _expectedValue.color4));
								break;
								
								default:
									_success = (_functionReturn == _expectedValue);
								break;
							}
						}
						else
						{
							_success = false;
						}
					}
					else
					{
						_success = (_functionReturn == _expectedValue);
					}
					
					testStatus[testID][_pair] =
					{
						type: "Assert: Equal",
						success: _success,
						functionReturn: _functionReturn,
						expectedValue: _expectedValue
					}
					
					var _status = testStatus[testID][_pair];
					
					if (!_status.success)
					{
						failuresExist = true;
					}
					
					if (logAssertion != undefined)
					{
						var _string_assertionSuccess = ((_status.success) ? " = " : " ≠ ");
						
						var _string_logAssertion = (testNames[testID] + " [" + string((_pair + 1)) +
													"]" + ": {" + string(_status.functionReturn) +
													_string_assertionSuccess +
													string(_status.expectedValue) + "}");
						
						logAssertion(_string_logAssertion);
					}
					
					_i += 2;
				}
				
				++testID;
			}
			
			// @argument			{string} name
			// @argument			{any} functionReturn...
			// @argument			{any} expectedValue...
			// @description			Check if the value returned by the function is the same as the
			//						specified expected one.
			//						A name of this test must be specified in the first argument of
			//						this function, which will be used to in displaying its results.
			//						Then the next arguments will accept any number of the argument
			//						pairs for function return and their expected return values.
			//						Assertion details will be logged used the function set in the
			//						"logAssertion" variable of this constructor if possible.
			static assert_notEqual = function()
			{
				testNames[testID] = argument[0];
				
				var _i = 1;
				repeat ((argument_count - 1) div 2)
				{
					var _pair = ((_i - 1) div 2);
					
					var _functionReturn = argument[_i];
					var _expectedResult = argument[_i + 1];
					
					var _success;
					
					if ((is_array(_functionReturn)) and (is_array(_expectedResult)))
					{
						_success = array_equals(_functionReturn, _expectedResult);
					}
					else if ((is_struct(_functionReturn)) and (is_struct(_expectedResult)))
					{
						var _functionReturn_instanceof = instanceof(_functionReturn);
						var _expectedResult_instanceof = instanceof(_expectedResult);
						
						if (_functionReturn_instanceof == _expectedResult_instanceof)
						{
							switch (_functionReturn_instanceof)
							{
								case "Vector2":
									_success = ((_functionReturn.x == _expectedResult.x) 
												and (_functionReturn.y == _expectedResult.y));
								break;
								
								case "Vector4":
									_success = ((_functionReturn.x1 == _expectedResult.x1)
												and (_functionReturn.y1 == _expectedResult.y1)
												and (_functionReturn.x2 == _expectedResult.x2)
												and (_functionReturn.y2 == _expectedResult.y2));
								break;
								
								case "Color2":
									_success = ((_functionReturn.color1 == _expectedValue.color1) and
												(_functionReturn.color2 == _expectedValue.color2));
								break;
								
								case "Color3":
									_success = ((_functionReturn.color1 == _expectedValue.color1) and
												(_functionReturn.color2 == _expectedValue.color2) and
												(_functionReturn.color3 == _expectedValue.color3));
								break;
								
								case "Color4":
									_success = ((_functionReturn.color1 == _expectedValue.color1) and
												(_functionReturn.color2 == _expectedValue.color2) and
												(_functionReturn.color3 == _expectedValue.color3) and
												(_functionReturn.color4 == _expectedValue.color4));
								break;
								
								default:
									_success = (_functionReturn == _expectedResult);
								break;
							}
						}
						else
						{
							_success = false;
						}
					}
					else
					{
						_success = (_functionReturn == _expectedResult);
					}
					
					testStatus[testID][_pair] =
					{
						type: "Assert: Not equal",
						success: (!_success),
						functionReturn: _functionReturn,
						expectedResult: _expectedResult
					}
					
					var _status = testStatus[testID][_pair];
					
					if (!_status.success)
					{
						failuresExist = true;
					}
					
					if (logAssertion != undefined)
					{
						var _string_assertionSuccess = ((_status.success) ? " = " : " ≠ ");
						
						var _string_logAssertion = (testNames[testID] + " [" + string((_pair + 1)) +
													"]" + ": {" + string(_status.functionReturn) +
													_string_assertionSuccess +
													string(_status.expectedResult) + "}");
						
						logAssertion(_string_logAssertion);
					}
					
					_i += 2;
				}
				
				++testID;
			}
			
			// @argument			{string} name
			// @argument			{function} executedFunction
			// @argument			{any[]} functionArgument?
			// @description			Check if the specified function is executable without throwing any
			//						errors.
			static assert_executable = function(_name)
			{
				testNames[testID] = _name;
				
				var _i = 1;
				repeat (ceil((argument_count - 1) / 2))
				{
					var _pair = ((_i - 1) div 2);
					
					var __executedFunction = argument[_i];
					var _functionArgument = ((argument_count > (_i + 1)) ? argument[_i + 1] : []);
					
					if (!is_array(_functionArgument))
					{
						_functionArgument = ((_functionArgument == undefined) ? []
																			  : [_functionArgument]);
					}
					
					var _error = undefined;
					var __execution = ((is_method(__executedFunction))
									   ? method_get_index(__executedFunction) : __executedFunction);
					
					try
					{
						script_execute_ext(__execution, _functionArgument);
					}
					catch (_exception)
					{
						_error = _exception;
					}
					
					testStatus[testID][_pair] =
					{
						type: "Assert: Executable",
						success: (_error == undefined),
						executedFunction: __executedFunction,
						functionArgument: _functionArgument,
						exception: _error
					}
					
					var _status = testStatus[testID][_pair];
					
					if (!_status.success)
					{
						failuresExist = true;
					}
					
					if (logAssertion != undefined)
					{
						var _string_assertionSuccess = ((_status.success) ? "Executable" :
														"Exception: " + string(_status.exception));
						
						var _string_functionArguments = "";
						var _functionArgumentCount = array_length(_status.functionArgument);
						
						if (_functionArgumentCount > 0)
						{	
							var _i = 0;
							repeat (_functionArgumentCount)
							{
								_string_functionArguments += string(_status.functionArgument[_i]);
								
								++_i;
								
								if (_i < _functionArgumentCount)
								{
									_string_functionArguments += ", ";
								}
							}
						}
						
						var _string_logAssertion = (testNames[testID] + " [" + string((_pair + 1)) +
													"]" + ": {" + string(_status.executedFunction) +
													"(" + _string_functionArguments + ")" + ": " +
													_string_assertionSuccess + "}");
						
						logAssertion(_string_logAssertion);
					}
					
					_i += 2;
				}
				
				++testID;
			}
			
			// @argument			{string} name
			// @description			Note a name of a function that cannot be executed to test it.
			static assert_untestable = function(_name)
			{
				testNames[testID] = _name;
				
				testStatus[testID][0] =
				{
					type: "Assert: Untestable",
					success: true,
					executedFunction: undefined,
					functionArgument: undefined,
					exception: undefined
				}
				
				if (logAssertion != undefined)
				{
					var _string_logAssertion = (testNames[testID] + ": Untestable");
					
					logAssertion(_string_logAssertion);
				}
				
				++testID;
			}
			
			// @argument			{string} name
			// @description			Mark that a test with the specified name is yet to be created.
			static assert_untested = function(_name)
			{
				testNames[testID] = _name;
				
				testStatus[testID][0] =
				{
					type: "Assert: Untested",
					success: false,
					executedFunction: undefined,
					functionArgument: undefined,
					exception: undefined
				}
				
				if (logAssertion != undefined)
				{
					var _string_logAssertion = (testNames[testID] + ": Untested!");
					
					logAssertion(_string_logAssertion);
				}
				
				++testID;
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented by the name of this Unit Test.
			static toString = function()
			{
				return (instanceof(self) + "(" + string(name) + ")");
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		argument_original = array_create(argument_count, undefined);
		
		var _i = 0;
		repeat (argument_count)
		{
			argument_original[_i] = argument[_i];
			
			++_i;
		}
		
		script_execute_ext(method_get_index(self.construct), argument_original);
		
	#endregion
}
