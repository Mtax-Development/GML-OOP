//  @function				ErrorReport()
/// @description			Contains static variables and methods of the error reporting system.
//							
//							Construction types:
//							- New constructor
function ErrorReport() constructor
//  @feather	ignore all
{
	#region [Static variables]
		#region [[Configurable variables - General]]
			
			/// @type			{function}?
			/// @description	The function called upon a report, called with {string} description
			///					of the error as the only argument.
			static reportFunction = show_debug_message;
			
			/// @type			{ErrorReport.ReportData[]}?
			/// @description	Details of all previously created reports.
			static errorData = [];
			
			/// @type			{int}?
			/// @description	Maximum number of times the reporting function will be called, compared
			///					to the number of saved report data.
			static reportFunctionLimit = undefined;
			
			/// @type			{int}?
			/// @description	Number of collected error entries after which error data will not be
			///					automatically saved or reported to prevent memory leaks.
			static errorDataLimit = 250;
			
			/// @type			{bool}?
			/// @description	Whether unique report function calls are enforced by first checking if
			///					a report with the same description and callstack was already created.
			static allowDuplicateReporting = false;
			
		#endregion
		#region [[Configurable variables - Specific]]
			
			/// @type			{string[]}?
			/// @example		["ConstructorName.methodName()"]
			/// @description	Contains strings of locations after formatting, for which the report
			///					function will not be called upon an error.
			static ignoredErrorLocation = undefined;
			
		#endregion
	#endregion
	#region [Methods]
		#region <Management>
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return (((reportFunctionLimit == undefined) or (reportFunctionLimit > 0))
						and (is_array(errorData)));
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			error_location? {int:instance|struct|string|[]}
			/// @argument			error_detail? {struct:exception|string}
			/// @returns			{ErrorReport.ReportData}
			/// @description		Create an error report, log its data with the function assigned to
			///						the appropriate static constructor variable and return that data.
			static report = function(_error_location = other, _error_detail = "Unexpected Error")
			{
				var _callstack_raw = debug_get_callstack();
				var _callstack = [];
				array_copy(_callstack, 0, _callstack_raw, 1, (array_length(_callstack_raw) - 2)); 
				var _reportData = new ReportData(_error_location, _error_detail, _callstack,
												 date_datetime_string(date_current_datetime()));
				var _errorData_isArray = is_array(errorData);
				var _errorData_count = 0;
				
				if (_errorData_isArray)
				{
					var _errorData_count = array_length(errorData);
					
					if ((is_real(errorDataLimit)) and (_errorData_count >= errorDataLimit))
					{
						return _reportData;
					}
					else
					{
						array_push(errorData, _reportData);
						++_errorData_count;
					}
				}
				
				var _location_formatted = _reportData.formatLocation();
				
				if (is_array(ignoredErrorLocation))
				{
					var _i = 0;
					repeat (array_length(ignoredErrorLocation))
					{
						if (ignoredErrorLocation[_i] == _location_formatted)
						{
							return _reportData;
						}
						
						++_i;
					}
				}
				
				var _tabulation = string_repeat(" ", 4);
				var _text_location = string_replace_all(_location_formatted, "\n", " ");
				var _text_detail = string_replace_all(_reportData.formatDetail(), "\n",
													  ("\n" + _tabulation));
				var _text_callstack = (_tabulation + string_replace_all(_reportData.formatCallstack(),
																		"\n", ("\n" + _tabulation)));
				var _text_time = _reportData.formatTime();
				var _text_separator = string_repeat("#", 92);
				var _report = (_text_separator + "\n" +
							   "Error" + " @ " + _text_location + " @ " +  _text_time + ":" + "\n" +
							   _tabulation + _text_detail + "\n\n" +
							   "Callstack: " + "\n" +
							   _text_callstack + "\n" +
							   _text_separator);
				
				if ((is_real(reportFunction) or (is_method(reportFunction)))
				and ((reportFunctionLimit == undefined) or ((_errorData_isArray)
				and (_errorData_count <= reportFunctionLimit))))
				{
					if ((!allowDuplicateReporting) and (_errorData_isArray) and (_errorData_count > 1))
					{
						var _i = (_errorData_count - 2);
						repeat (_i)
						{
							if (_reportData.equals(errorData[_i]))
							{
								return _reportData;
							}
							
							--_i;
						}
					}
					
					self.reportFunction(_report);
				}
				
				return _reportData;
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
					var _text_reportFunction = ((reportFunction != undefined)
												? (script_get_name(reportFunction) + "()")
												: string(reportFunction));
					var _text_errorData_length = ((is_array(errorData))
												  ? string(array_length(errorData))
												  : string(undefined));
					var _text_ignoredErrorLocationCount = ((is_array(ignoredErrorLocation))
														   ? string(array_length(ignoredErrorLocation))
														   : string(ignoredErrorLocation));
					var _text_errorDataLimit = ((is_real(errorDataLimit)) ?
												(" / " + string(errorDataLimit)) : "");
					var _string = ("Report Function: " + _text_reportFunction + _mark_separator +
								   "Error Data Saved: " + _text_errorData_length +
														  _text_errorDataLimit + _mark_separator +
								   "Report Function Limit: " + string(reportFunctionLimit) +
															   _mark_separator +
								   "Allow Duplicate Reporting: " + string(allowDuplicateReporting) +
																   _mark_separator +
								   "Ignored Error Location Count: " + _text_ignoredErrorLocationCount);
					
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
	#region [Elements]
		
		//  @function			ErrorReport.ReportData()
		/// @argument			location {int:instance|struct|string|[]}
		/// @argument			detail {struct:exception|string}
		/// @argument			callstack {string[]}
		/// @argument			time? {DateTime|string}
		/// @description		A container constructor storing information about a reported error.
		//						
		//						Construction types:
		//						- New element
		function ReportData() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					/// @description		Initialize the constructor.
					static construct = function()
					{
						//|Construction type: New element.
						location = argument[0];
						detail = argument[1];
						callstack = argument[2];
						time = ((argument_count > 3) ? argument[3] : undefined);
						
						return self;
					}
					
					/// @returns			{bool}
					/// @description		Check if this constructor is functional.
					static isFunctional = function()
					{
						return ((location != undefined) and (((is_struct(detail))
								and (is_string(detail[$ "message"]))
								and (is_string(detail[$ "longMessage"]))
								and (is_string(detail[$ "script"]))
								and (is_array(detail[$ "stacktrace"]))
								and (array_length(detail.stacktrace) > 0)) or (is_string(detail)))
								and (is_array(callstack)) and (array_length(callstack) > 0));
					}
					
				#endregion
				#region <<Getters>>
					
					/// @argument			{ErrorReport.ReportData} other
					/// @returns			{bool}
					/// @description		Check if description and callstack of this error are the
					///						same as of the specified one.
					static equals = function(_other)
					{
						if ((string_copy(instanceof(_other), 1, 10) == "ReportData")
						and (detail == _other.detail))
						{
							if ((is_array(callstack)) and (is_array(_other.callstack)))
							{
								var _callstack_size = array_length(callstack);
								
								if (_callstack_size == array_length(_other.callstack))
								{
									var _i = 0;
									repeat (_callstack_size)
									{
										if (callstack[_i] != _other.callstack[_i])
										{
											return false;
										}
										
										++_i;
									}
								}
							}
							
							return true;
						}
						
						return false;
					}
					
					/// @returns			{string}
					/// @description		Create a string representing readable location in code
					///						where the error occurred.
					static formatLocation = function()
					{
						var _text_location = "";
						var _error_location = ((is_array(location)) ? location : [location]);
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
								//|Instance or room {self} reference. Will exist as a pseudo-struct
								// even if destroyed.
								_location_object_name = ((_location_part.id == 0)
														 ? room_get_name(room)
														 : object_get_name(_location_part
																			.object_index));
							}
							else if (typeof(_location_part) == "ref")
							{
								//|Instance or room id reference.
								_location_object_name = ((_location_part == 0)
														 ? room_get_name(room)
														 : ((instance_exists(_location_part))
															? object_get_name(_location_part
																			   .object_index)
															: ("<" + "destroyed instance: " +
															   string(_location_part) + ">")));
							}
							else if (is_string(_location_part))
							{
								_location_object_name = _location_part;
							}
							else
							{
								_location_object_name = string(_location_part);
							}
							
							if (string_count((_location_object_name + "."), _text_location) <= 0)
							{
								_text_location += (_location_object_name +
												   (((_i + 1) < _error_location_count) ? "." : ""));
							}
							
							++_i;
						}
						
						return (((location != undefined) and (string_length(_text_location) > 0))
								? _text_location : "Unknown location");
					}
					
					/// @returns			{string}
					/// @description		Return the string describing the detail of the error or
					///						parsed error message if it is an exception struct.
					static formatDetail = function()
					{
						var _text_detail = undefined;
						
						if ((is_struct(detail))
						and (is_string(variable_struct_get(detail, "message"))))
						{
							var _error_message_length_original = string_length(detail.message);
							
							if (_error_message_length_original > 1)
							{
								_text_detail = detail.message;
								
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
																	(_error_message_length_original -
																	 1)));
									}
								}
							
								if ((_error_message_length_original > 9)
								and (string_copy(string_lower(_text_detail), 1, 9) == "variable "))
								{
									var _position_bracket_open = string_pos("(", _text_detail);
									var _position_bracket_close = string_pos(")", _text_detail);
									
									if ((_position_bracket_open > 0)and (_position_bracket_close > 0)
									and ((_position_bracket_close - _position_bracket_open) > 0))
									{
										var _gibberish = string_copy(_text_detail,
																	  _position_bracket_open,
																	 (_position_bracket_close -
																	  _position_bracket_open + 1));
										_text_detail = string_replace(_text_detail, _gibberish, "");
									}
								}
								
								var _char_last = string_char_at(_text_detail,
																string_length(_text_detail));
								
								if ((_char_last != "") and (_char_last != "."))
								{
									_text_detail += ".";
								}
							}
						}
						
						return (_text_detail ?? ((detail != undefined)
												 ? string(detail) : "Unexpected Error"));
					}
					
					/// @argument			lengthLimit? {int|all}
					/// @returns			{string}
					/// @description		Return the string representing entire or part of the error
					///						callstack, containing each call in a separate line.
					static formatCallstack = function(_lengthLimit = all)
					{
						var _text_callstack = "";
						var _callstack_size = ((is_array(callstack)) ? array_length(callstack) : 0);
						var _count = ((_lengthLimit == all) ? _callstack_size : min(_lengthLimit,
																					_callstack_size));
						var _i = 0;
						repeat (_count)
						{
							_text_callstack += (((_i != 0) ? "\n" : "") + string(callstack[_i]));
							
							++_i;
						}
						
						if (string_length(_text_callstack) > 0)
						{
							if (_callstack_size > _count)
							{
								_text_callstack += ("\n" + "...");
							}
							
							return _text_callstack;
						}
						else
						{
							return "Unknown callstack";
						}
					}
					
					/// @returns			{string}
					/// @description		Return the string representing the time at which the error
					///						occurred, separated for readability.
					static formatTime = function()
					{
						return ("[" + (((instanceof(time) == "DateTime") and (time.isFunctional()))
									   ? time.toStringTime()
									   : ((is_string(time)) ? time : "Unknown time")) +
								"]");
					}
					
				#endregion
				#region <<Conversion>>
					
					/// @argument			multiline? {bool}
					/// @argument			detailLength? {int|all}
					/// @argument			callstackLength? {int|all}
					/// @argument			mark_separator? {string}
					/// @argument			mark_cut? {string}
					/// @argument			mark_timeSeparator? {string}
					/// @returns			{string}
					/// @description		Create a string representing this constructor.
					///						Overrides the string() conversion.
					///						Content will be represented with error information.
					static toString = function(_multiline = false, _detailLength = 30,
											   _callstackLength = 10, _mark_separator = " @ ",
											   _mark_cut = "...", _mark_timeSeparator = ": ")
					{
						var _constructorName = "ErrorReport.ReportData";
						
						if (self.isFunctional())
						{
							var _text_location = self.formatLocation();
							var _text_detail = self.formatDetail();
							var _text_time = ((time != undefined) ? self.formatTime()
																  : "Unknown time");
							
							if (_detailLength != all)
							{
								var _mark_cut_length = string_length(_mark_cut);
								var _detail_lengthLimit_cut = (_detailLength + _mark_cut_length);
								
								if (string_length(_text_detail) > _detail_lengthLimit_cut)
								{
									_text_detail = (string_copy(_text_detail, 1, _detailLength) +
													_mark_cut);
								}
							}
							
							if (_multiline)
							{
								var _mark_linebreak = "\n";
								
								return  ("Location: " + _text_location + _mark_linebreak +
										 "Detail: " + _text_detail + _mark_linebreak +
										 "Time: " + ((time != undefined) ? self.formatTime()
																		 : "Unknown time") +
													_mark_linebreak +
										 "Callstack: " + self.formatCallstack(_callstackLength));
							}
							else
							{
								return (_constructorName + "(" +
										string_replace_all(_text_location, "\n", " ") +
										_mark_separator +
										((time != undefined) ? (self.formatTime() +
																_mark_timeSeparator)
															 : "") +
										+ _text_detail + ")");
							}
						}
						else
						{
							return (_constructorName + "<>");
						}
					}
					
				#endregion
			#endregion
			#region [[Constructor]]
				
				static prototype = {};
				var _property = variable_struct_get_names(prototype);
				var _i = 0;
				repeat (array_length(_property))
				{
					var _name = _property[_i];
					var _value = variable_struct_get(prototype, _name);
					
					variable_struct_set(self, _name, ((is_method(_value)) ? method(self, _value)
																		  : _value));
					
					++_i;
				}
				
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
		
	#endregion
	#region [Constructor]
		
		static prototype = {};
		var _property = variable_struct_get_names(prototype);
		var _i = 0;
		repeat (array_length(_property))
		{
			var _name = _property[_i];
			var _value = variable_struct_get(prototype, _name);
			
			variable_struct_set(self, _name, ((is_method(_value)) ? method(self, _value) : _value));
			
			++_i;
		}
		
	#endregion
}
