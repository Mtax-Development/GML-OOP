/// @function				ErrorReport()
///
/// @description			Contains static variables and methods of the error reporting system.
function ErrorReport() constructor
{
	#region [Static variables]
		
		//|Configurable variables.
		static reportFunction = show_debug_message;
		static maxReports = undefined;
		static errorData = [];
		
	#endregion
	#region [Methods]
		#region <Management>
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_array(errorData)) and ((maxReports == undefined) or (maxReports > 0)));
			}
			
		#endregion
		#region <Execution>
			
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
				
				if (is_array(errorData))
				{
					_methodName = (_methodName + "()");
					
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
				
				if ((reportFunction != undefined) and ((maxReports == undefined) 
				or (is_array(errorData)) and (array_length(errorData) < maxReports)))
				{
					reportFunction(_string);
				}
			}
			
		#endregion
		#region <Conversion>
			
			static toString = function(_full, _multiline)
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
								   "Max Reports: " + string(maxReports));
					
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
											  : instanceof(self) + "(" + _string_errorData_length
												+ ")");
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
