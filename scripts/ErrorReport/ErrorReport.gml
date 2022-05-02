/// @function				ErrorReport()
///							
/// @description			Contains static variables and methods of the error reporting system.
function ErrorReport() constructor
{
	#region [Static variables]
		#region [[Configurable variables - General]]
			
			// @type			{function}
			// @description		The function called upon a report, called with its description as a
			//					string in an argument.
			static reportFunction = show_debug_message;
			
			// @type			{int|undefined}
			// @description		Maximum number of times the reporting function will be called.
			static maximumReports = undefined;
			
			// @type			{void[]}
			// @description		An array holding the details of the reports.
			static errorData = [];
			
		#endregion
		#region [[Configurable variables - Specific]]
			
			// @type			{string[]}
			// @example			{["Constructor.method()"]}
			// @description		An array holding strings with names of methods that will not be
			//					reported upon error.
			static ignoredError_constructorMethod = undefined;
			
		#endregion
	#endregion
	#region [Methods]
		#region <Management>
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return (((maximumReports == undefined) or (maximumReports > 0))
						and (is_array(errorData)));
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{any[]} callstack
			// @argument			{string} errorLocation
			// @argument			{string} errorText
			// @description			Create an error report, collect its data and log it with the
			//						function that is assigned to the appropriate constructor variable.
			static reportError = function(_callstack, _errorLocation, _errorText)
			{
				var _string_reportType = "Error";
				
				if (is_array(errorData))
				{
					var _reportData = [_string_reportType, _errorLocation, _errorText, _callstack];
					
					array_push(errorData, _reportData);
					
					var _string_callstack = "";
					
					var _i = 0;
					repeat (array_length(_callstack))
					{
						_string_callstack += (string(_callstack[_i]) + "\n");
						
						++_i;
					}
					
					var _string_separator = string_repeat("#", 92);
					
					var _string = (_string_separator + "\n" +
								   _string_reportType + " @ " + string(_errorLocation) + ": " + "\n" +
								   string(_errorText) + "\n\n" +
								   "Callstack: " + "\n" +
								   _string_callstack +
								   _string_separator);
					
					if ((reportFunction != undefined) and ((maximumReports == undefined) 
					or (is_array(errorData)) and (array_length(errorData) < maximumReports)))
					{
						reportFunction(_string);
					}
				}
			}
			
			// @argument			{struct|struct[]} constructor
			// @argument			{any[]} callstack
			// @argument			{string} methodName
			// @argument			{string} errorText
			// @description			Create a report of a constructor method error, collect its data
			//						and log it with the function that is assigned to in the
			//						appropriate constructor variable.
			static reportConstructorMethod = function(_constructor, _callstack, _methodName,
													  _errorText)
			{
				var _string_reportType = "Constructor Method Error";
				var _string_constructorName = "";
				
				if (is_array(_constructor))
				{
					var _constructor_length = array_length(_constructor);
					
					var _i = 0;
					repeat (_constructor_length)
					{
						_string_constructorName += instanceof(_constructor[_i]);
						
						++_i;
						
						if (_i < _constructor_length)
						{
							_string_constructorName += ".";
						}
					}
				}
				else
				{
					_string_constructorName = instanceof(_constructor);
				}
				
				_methodName += "()";
				
				if (is_array(ignoredError_constructorMethod))
				{
					var _methodPath = (_string_constructorName + "." + _methodName);
					
					var _i = 0;
					repeat (array_length(ignoredError_constructorMethod))
					{
						if (_methodPath == ignoredError_constructorMethod[_i])
						{
							exit;
						}
						
						++_i;
					}
				}
				
				if (is_array(errorData))
				{
					var _reportData = [_string_reportType, _string_constructorName, _methodName, 
									   _errorText, _callstack];
					
					array_push(errorData, _reportData);
				}
				
				var _string_callstack = "";
				
				var _i = 0;
				repeat (array_length(_callstack))
				{
					_string_callstack += (string(_callstack[_i]) + "\n");
					
					++_i;
				}
				
				var _string_separator = string_repeat("#", 92);
				
				var _string = (_string_separator + "\n" +
							   _string_reportType + " @ " + _string_constructorName + "." +
							  string(_methodName) + ": " + "\n" +
							  string(_errorText) + "\n\n" +
							  "Callstack: " + "\n" +
							  _string_callstack +
							  _string_separator);
				
				if ((reportFunction != undefined) and ((maximumReports == undefined) 
				or (is_array(errorData)) and (array_length(errorData) < maximumReports)))
				{
					reportFunction(_string);
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @argument			{bool} full?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the error and configuration data.
			static toString = function(_multiline = false, _full = false)
			{
				if (_full)
				{
					var _mark_separator = ((_multiline) ? "\n" : ", ");
					
					var _string_reportFunction = ((reportFunction != undefined)
												  ? (script_get_name(reportFunction) + "()")
												  : string(reportFunction));
					
					var _string_errorData_length = ((is_array(errorData))
													? string(array_length(errorData))
													: string(undefined));
					
					var _string = ("Report Function: " + _string_reportFunction + _mark_separator +
								   "Error Count: " + _string_errorData_length + _mark_separator +
								   "Maximum Reports: " + string(maximumReports));
					
					return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
				}
				else
				{
					if (is_array(errorData))
					{
						var _errorData_length = array_length(errorData);
						var _string_errorData_length = ((_errorData_length > 0) ?
														("Reports: " + string(_errorData_length))
														: "Empty");
						
						return  ((_multiline) ? _string_errorData_length 
											  : (instanceof(self) + "(" + _string_errorData_length +
												 ")"));
					}
					else
					{
						return (instanceof(self) + "()");
					}
				}
			}
			
		#endregion
	#endregion
}

