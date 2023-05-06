/// @function				ErrorReport()
///							
/// @description			Contains static variables and methods of the error reporting system.
///							
///							Construction types:
///							- New constructor
function ErrorReport() constructor
{
	#region [Static variables]
		#region [[Configurable variables - General]]
			
			/// @type			{function}
			/// @description	The function called upon a report, called with its description as a
			///					string in only argument.
			static reportFunction = show_debug_message;
			
			/// @type			{int|undefined}
			/// @description	Maximum number of times the raporting function will be called,
			///					compared to the number of saved error data structs.
			static maximumReports = undefined;
			
			/// @type			{struct[]}
			/// @description	An array holding the details of the reports.
			static errorData = [];
			
		#endregion
		#region [[Configurable variables - Specific]]
			
			/// @type			{string[]}
			/// @example		{["Constructor.method()"]}
			/// @description	An array holding strings with names of methods that will not be
			///					reported upon error.
			static ignoredError_constructorMethod = undefined;
			
		#endregion
	#endregion
	#region [Methods]
		#region <Management>
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return (((maximumReports == undefined) or (maximumReports > 0))
						and (is_array(errorData)));
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			error_location? {int:instance|struct|string|[]}
			/// @argument			error_text? {struct:exception|string}
			/// @description		Create an error report, collect its data and log it with the
			///						function that is assigned to appropriate constructor variable.
			static report = function(_error_location = other, _error_detail = "Unexpected Error")
			{
				if (!is_array(_error_location))
				{
					_error_location = [_error_location];
				}
				
				var _text_location = "";
				var _error_location_count = array_length(_error_location);
				var _i = 0;
				repeat (_error_location_count)
				{
					var _location_part = _error_location[_i];
					var _location_object_name;
					
					if (_location_part == noone)
					{
						_location_object_name = "noone";
					}
					else if (is_struct(_location_part))
					{
						_location_object_name = instanceof(_location_part);
					}
					else if (instanceof(_location_part) == "instance")
					{
						//|Instance or room {self} reference. Will exist as pseudo-struct even if
						// destroyed.
						_location_object_name = ((_location_part.id == 0)
												 ? room_get_name(room)
												 : object_get_name(_location_part.object_index));
					}
					else if (typeof(_location_part) == "ref")
					{
						//|Instance or room id reference.
						_location_object_name = ((_location_part == 0)
												 ? room_get_name(room)
												 : ((instance_exists(_location_part))
													? object_get_name(_location_part.object_index)
													: ("<" + "destroyed instance: " +
													   string(_location_part) + ">")));
					}
					else
					{
						_location_object_name = string(_location_part);
					}
					
					if (string_count((_location_object_name + "."), _text_location) <= 0)
					{
						_text_location += (_location_object_name + (((_i + 1) < _error_location_count)
																	? "." : ""));
					}
					
					++_i;
				}
				
				var _text_reportType = "Error";
				var _tabulation = string_repeat(" ", 4);
				var _callstack_raw = debug_get_callstack();
				var _callstack = [];
				array_copy(_callstack, 0, _callstack_raw, 1, (array_length(_callstack_raw) - 2)); 
				var _reportData = {type: _text_reportType, location: _error_location,
								   detail: _error_detail, callstack: _callstack};
				//+TODO: Make this a constructor
				
				var _errorData_isArray, _errorData_count;
				
				if (is_array(errorData))
				{
					array_push(errorData, _reportData);
					
					_errorData_isArray = true;
					_errorData_count = array_length(errorData);
				}
				
				var _text_callstack = "";
				var _i = 0;
				repeat (array_length(_callstack))
				{
					_text_callstack += (_tabulation + string(_callstack[_i]) + "\n");
					
					++_i;
				}
				
				var _text_detail = undefined;
				
				if (is_struct(_error_detail))
				{
					if (is_string(variable_struct_get(_error_detail, "message")))
					{
						var _error_message_length_original = string_length(_error_detail.message);
						
						if (_error_message_length_original > 1)
						{
							_text_detail = _error_detail.message;
							
							var _position_space_first = string_pos(" ", _text_detail);
							var _position_space_second = string_pos_ext(" ", _text_detail,
																		_position_space_first);
							
							if ((_position_space_first > 0)
							and (_position_space_second > _position_space_first))
							{
								var _word_second = string_copy(_text_detail,
															   (_position_space_first + 1),
															   (_position_space_second -
															    _position_space_first - 1));
								
								if (_word_second != "argument")
								{
									//|Capitalize the first letter if it is not in a message which
									// might start with a function name.
									_text_detail = (string_upper(string_char_at(_text_detail, 1)) +
													string_copy(_text_detail, 2,
																(_error_message_length_original - 1)));
								}
							}
							
							if ((_error_message_length_original > 9)
							and (string_copy(string_lower(_text_detail), 1, 9) == "variable "))
							{
								var _position_bracket_open = string_pos("(", _text_detail);
								var _position_bracket_close = string_pos(")", _text_detail);
								
								if ((_position_bracket_open > 0) and (_position_bracket_close > 0)
								and ((_position_bracket_close - _position_bracket_open) > 0))
								{
									var _gibberish = string_copy(_text_detail, _position_bracket_open,
																 (_position_bracket_close -
																  _position_bracket_open + 1));
									_text_detail = string_replace(_text_detail, _gibberish, "");
								}
							}
							
							var _char_last = string_char_at(_text_detail, string_length(_text_detail));
							
							if ((_char_last != "") and (_char_last != "."))
							{
								_text_detail += ".";
							}
						}
					}
				}
				
				_text_detail ??= string(_error_detail);
				_text_detail = string_replace_all(_text_detail, "\n", ("\n" + _tabulation));
				var _text_time = date_time_string(date_current_datetime());
				var _text_separator = string_repeat("#", 92);
				var _report = (_text_separator + "\n" +
							   _text_reportType + " @ " + _text_location + " @ " + "[" +
							   _text_time + "]:" + "\n" +
							   _tabulation + _text_detail + "\n\n" +
							   "Callstack: " + "\n" +
							   _text_callstack +
							   _text_separator);
				
				if ((is_real(reportFunction) or (is_method(reportFunction)))
				and ((maximumReports == undefined) or ((_errorData_isArray)
				and (_errorData_count <= maximumReports))))
				{
					if (!((_errorData_isArray) and (_errorData_count > 1)
					and (errorData[(_errorData_count - 1)].callstack[0] == _callstack[0])))
					{
						//+TODO: Constructor-based instance check once it's a constructor.
						//|Call the report function, unless the last report happened due to an error
						// at the same line of code as this one.
						self.reportFunction(_report);
					}
				}
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @argument			full? {bool}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented with the error and configuration data.
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
	#region [Constructor]
		
		static prototype = {};
		var _property = variable_struct_get_names(prototype);
		var _i = 0;
		repeat (array_length(_property))
		{
			var _name = _property[_i];
			var _value = variable_struct_get(prototype, _property[_i]);
			
			variable_struct_set(self, _name, ((is_method(_value)) ? method(self, _value) : _value));
			
			++_i;
		}
		
	#endregion
}

