/// @function				DateTime()
/// @argument				{int} year?
/// @argument				{int} month?
/// @argument				{int} day?
/// @argument				{int} hour?
/// @argument				{int} minute?
/// @argument				{int} second?
///
/// @description			Constructs a container for a DateTime.
///
///							Construction methods:
///							- New constructor
///							- Wrapper: {real:datetime} datetime
///							- Constructor copy: {DateTime} other
function DateTime() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				ID = undefined;
				
				year = undefined;
				month = undefined;
				week = undefined;
				day = undefined;
				hour = undefined;
				minute = undefined;
				second = undefined;
				
				if (argument_count > 0)
				{
					if (instanceof(argument[0]) == "DateTime")
					{
						//|Construction method: Constructor copy.
						var _other = argument[0];
						
						ID = _other.ID;
						
						year = _other.year;
						month = _other.month;
						week = _other.week;
						day = _other.day;
						hour = _other.hour;
						minute = _other.minute;
						second = _other.second;
					}
					else
					{
						if (argument_count == 1)
						{
							//|Construction method: Wrapper.
							ID = argument[0];
							
							year = date_get_year(ID);
							month = date_get_month(ID);
							week = date_get_week(ID);
							day = date_get_day(ID);
							hour = date_get_hour(ID);
							minute = date_get_minute(ID);
							second = date_get_second(ID);
						}
						else
						{
							//|Construction method: New datetime.
							var _year = (((argument_count > 0) and (argument[0] != undefined)) ? 
										argument[0] : 1970);
							var _month = (((argument_count > 1) and (argument[1] != undefined)) ? 
										argument[1] : 1);
							var _day = (((argument_count > 2) and (argument[2] != undefined)) ? 
										argument[2] : 1);
							var _hour = (((argument_count > 3) and (argument[3] != undefined)) ? 
										argument[3] : 0);
							var _minute = (((argument_count > 4) and (argument[4] != undefined)) ? 
										argument[4] : 0);
							var _second = (((argument_count > 5) and (argument[5] != undefined)) ? 
										argument[5] : 0);
							
							ID = date_create_datetime(_year, _month, _day, _hour, _minute, _second);
							
							year = date_get_year(ID);
							month = date_get_month(ID);
							week = date_get_week(ID);
							day = date_get_day(ID);
							hour = date_get_hour(ID);
							minute = date_get_minute(ID);
							second = date_get_second(ID);
						}
					}
				}
			}
			
		#endregion
		#region <Setters>
			
			// @description			Set this DateTime to the current of the system using the
			//						set timezone.
			static setCurrent = function()
			{
				self.construct(date_current_datetime());
			}
			
			// @argument			{int} year
			// @argument			{int} month
			// @argument			{int} day
			// @argument			{int} hour
			// @argument			{int} minute
			// @argument			{int} second
			// @description			Set this DateTime to a newly created one.
			static setDateTime = function(_year, _month, _day, _hour, _minute, _second)
			{
				self.construct(date_create_datetime(_year, _month, _day, _hour, _minute, _second));
			}
			
			// @argument			{int} years
			// @argument			{int} months
			// @argument			{int} days
			// @argument			{int} hours
			// @argument			{int} minutes
			// @argument			{int} seconds
			// @description			Modify any component of this DateTime by a specified number.
			static modify = function(_years, _months, _days, _hours, _minutes, _seconds)
			{
				if (is_real(ID))
				{
					ID = date_inc_year(ID, _years);
					ID = date_inc_month(ID, _months);
					ID = date_inc_day(ID, _days);
					ID = date_inc_hour(ID, _hours);
					ID = date_inc_minute(ID, _minutes);
					ID = date_inc_second(ID, _seconds);
					
					self.construct(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "modify";
					var _errorText = ("Attempted to modify an invalid date: {" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{int} number
			// @description			Modify the years in this DateTime by a specified number.
			static modify_years = function(_number)
			{
				if (is_real(ID))
				{
					self.construct(date_inc_year(ID, _number));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "modify_years";
					var _errorText = ("Attempted to modify an invalid date: {" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{int} number
			// @description			Modify the months in this DateTime by a specified number.
			static modify_months = function(_number)
			{
				if (is_real(ID))
				{
					self.construct(date_inc_month(ID, _number));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "modify_months";
					var _errorText = ("Attempted to modify an invalid date: {" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{int} number
			// @description			Modify the weeks in this DateTime by a specified number.
			static modify_weeks = function(_number)
			{
				if (is_real(ID))
				{
					self.construct(date_inc_week(ID, _number));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "modify_weeks";
					var _errorText = ("Attempted to modify an invalid date: {" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{int} number
			// @description			Modify the days in this DateTime by a specified number.
			static modify_days = function(_number)
			{
				if (is_real(ID))
				{
					self.construct(date_inc_day(ID, _number));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "modify_days";
					var _errorText = ("Attempted to modify an invalid date: {" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{int} number
			// @description			Modify the hours in this DateTime by a specified number.
			static modify_hours = function(_number)
			{
				if (is_real(ID))
				{
					self.construct(date_inc_hour(ID, _number));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "modify_hours";
					var _errorText = ("Attempted to modify an invalid date: {" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{int} number
			// @description			Modify the minutes in this DateTime by a specified number.
			static modify_minutes = function(_number)
			{
				if (is_real(ID))
				{
					self.construct(date_inc_minute(ID, _number));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "modify_minutes";
					var _errorText = ("Attempted to modify an invalid date: {" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{int} number
			// @description			Modify the seconds in this DateTime by a specified number.
			static modify_seconds = function(_number)
			{
				if (is_real(ID))
				{
					self.construct(date_inc_second(ID, _number));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "modify_seconds";
					var _errorText = ("Attempted to modify an invalid date: {" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{int} | On error: {undefined}
			// @description			Get the date component of this DateTime.
			static getDate = function()
			{		
				if (is_real(ID))
				{
					return date_date_of(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getDate";
					var _errorText = ("Attempted to read an invalid date: " + "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{int} | On error: {undefined}
			// @description			Get the time component of this DateTime.
			static getTime = function()
			{				
				if (is_real(ID))
				{
					return date_time_of(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getTime";
					var _errorText = ("Attempted to read an invalid date: " + "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{int} | On error: {undefined}
			// @description			Get the number of days in the year of the date component.
			static getDaysInYear = function()
			{
				if (is_real(ID))
				{
					return date_days_in_year(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getDaysInYear";
					var _errorText = ("Attempted to read an invalid date: " + "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{int} | On error: {undefined}
			// @description			Get the number of days in the month of the date component.
			static getDaysInMonth = function()
			{				
				if (is_real(ID))
				{
					return date_days_in_month(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getDaysInMonth";
					var _errorText = ("Attempted to read an invalid date: " + "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{int} | On error: {undefined}
			// @description			Get the number of which week in the year the date component is.
			//						This number starts at 0.
			static getWeekOfYear = function()
			{				
				if (is_real(ID))
				{
					return date_get_week(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getWeekOfYear";
					var _errorText = ("Attempted to read an invalid date: " + "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{int} | On error: {undefined}
			// @description			Get the number of which day in the year the date component is.
			static getDayOfYear = function()
			{				
				if (is_real(ID))
				{
					return date_get_day_of_year(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getDayOfYear";
					var _errorText = ("Attempted to read an invalid date: " + "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{int} | On error: {undefined}
			// @description			Get the number of which hour in the year the date component is.
			static getHourOfYear = function()
			{				
				if (is_real(ID))
				{
					return date_get_hour_of_year(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getHourOfYear";
					var _errorText = ("Attempted to read an invalid date: " + "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{int} | On error: {undefined}
			// @description			Get the number of which minute in the year the date component is.
			static getMinuteOfYear = function()
			{				
				if (is_real(ID))
				{
					return date_get_minute_of_year(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getMinuteOfYear";
					var _errorText = ("Attempted to read an invalid date: " + "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{int} | On error: {undefined}
			// @description			Get the number of which second in the year the date component is.
			static getSecondOfYear = function()
			{				
				if (is_real(ID))
				{
					return date_get_second_of_year(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getSecondOfYear";
					var _errorText = ("Attempted to read an invalid date: " + "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{int} | On error: {undefined}
			// @description			Get the day count in the week of the date component.
			//						This number starts at 0 and treats Sunday as the first day of the
			//						week.
			static getWeekday = function()
			{				
				if (is_real(ID))
				{
					return date_get_weekday(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getWeekday";
					var _errorText = ("Attempted to read an invalid date: " + "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{bool} | On error: {undefined}
			// @description			Check if the date component is the same as local date of this
			//						device using the set timezone.
			static isToday = function()
			{
				if (is_real(ID))
				{
					return date_is_today(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "isToday";
					var _errorText = ("Attempted to read an invalid date: " + "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{bool} | On error: {undefined}
			// @description			Check if the date component is a leap year - a calendar year 
			//						that contains an additional day			
			static isLeapYear = function()
			{
				if (is_real(ID))
				{
					return date_leap_year(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "isLeapYear";
					var _errorText = ("Attempted to read an invalid date: " + "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{DateTime} other
			// @returns				{int} | On error: {undefined}
			// @description			Compare two DateTimes and check which is first.
			//						Returns -1 if this date is earlier, 0 if even, 1 if later.
			static compareDateTime = function(_other)
			{
				if ((is_real(ID)) and (instanceof(_other) == "DateTime") and (is_real(_other.ID)))
				{
					return date_compare_datetime(ID, _other.ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "compareDateTime";
					var _errorText = ("Attempted to compare invalid dates:\n" +
									  "Self: " + "{" + string(self) + "}" + "\n" +
									  "Other: " + "{" + string(_other) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
		
			// @argument			{DateTime} other
			// @returns				{int} | On error: {undefined}
			// @description			Compare two dates (without time) and check which is first.
			//						Returns -1 if this date is earlier, 0 if even, 1 if later.
			static compareDate = function(_other)
			{
				if ((is_real(ID)) and (instanceof(_other) == "DateTime") and (is_real(_other.ID)))
				{
					return date_compare_date(ID, _other.ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "compareDate";
					var _errorText = ("Attempted to compare invalid dates:\n" +
									  "Self: " + "{" + string(self) + "}" + "\n" +
									  "Other: " + "{" + string(_other) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{DateTime} other
			// @returns				{int} | On error: {undefined}
			// @description			Compare time values of two DateTimes and check which is first.
			//						Returns -1 if this date is earlier, 0 if even, 1 if later.
			static compareTime = function(_other)
			{
				if ((is_real(ID)) and (instanceof(_other) == "DateTime") and (is_real(_other.ID)))
				{
					return date_compare_time(ID, _other.ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "compareTime";
					var _errorText = ("Attempted to compare invalid dates:\n" +
									  "Self: " + "{" + string(self) + "}" + "\n" +
									  "Other: " + "{" + string(_other) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{DateTime} other
			// @returns				{real} | On error: {undefined}
			// @description			Return number of years between date components of two DateTimes.
			//						Incomplete years are returned as a fraction.
			static spanOfYears = function(_other)
			{
				if ((is_real(ID)) and (instanceof(_other) == "DateTime") and (is_real(_other.ID)))
				{
					return date_year_span(ID, _other.ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "spanOfYears";
					var _errorText = ("Attempted to compare invalid dates:\n" +
									  "Self: " + "{" + string(self) + "}" + "\n" +
									  "Other: " + "{" + string(_other) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{DateTime} other
			// @returns				{real} | On error: {undefined}
			// @description			Return number of months between date components of two DateTimes.
			//						Incomplete months are returned as a fraction.
			static spanOfMonths = function(_other)
			{
				if ((is_real(ID)) and (instanceof(_other) == "DateTime") and (is_real(_other.ID)))
				{
					return date_month_span(ID, _other.ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "spanOfMonths";
					var _errorText = ("Attempted to compare invalid dates:\n" +
									  "Self: " + "{" + string(self) + "}" + "\n" +
									  "Other: " + "{" + string(_other) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{DateTime} other
			// @returns				{real} | On error: {undefined}
			// @description			Return number of weeks between date components of two DateTimes.
			//						Incomplete weeks are returned as a fraction.
			static spanOfWeeks = function(_other)
			{
				if ((is_real(ID)) and (instanceof(_other) == "DateTime") and (is_real(_other.ID)))
				{
					return date_week_span(ID, _other.ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "spanOfWeeks";
					var _errorText = ("Attempted to compare invalid dates:\n" +
									  "Self: " + "{" + string(self) + "}" + "\n" +
									  "Other: " + "{" + string(_other) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{DateTime} other
			// @returns				{real} | On error: {undefined}
			// @description			Return number of days between date components of two DateTimes.
			//						Incomplete days are returned as a fraction.
			static spanOfDays = function(_other)
			{
				if ((is_real(ID)) and (instanceof(_other) == "DateTime") and (is_real(_other.ID)))
				{
					return date_day_span(ID, _other.ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "spanOfDays";
					var _errorText = ("Attempted to compare invalid dates:\n" +
									  "Self: " + "{" + string(self) + "}" + "\n" +
									  "Other: " + "{" + string(_other) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{DateTime} other
			// @returns				{real} | On error: {undefined}
			// @description			Return number of hours between time components of two DateTimes.
			//						Incomplete hours are returned as a fraction.
			static spanOfHours = function(_other)
			{
				if ((is_real(ID)) and (instanceof(_other) == "DateTime") and (is_real(_other.ID)))
				{
					return date_hour_span(ID, _other.ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "spanOfHours";
					var _errorText = ("Attempted to compare invalid dates:\n" +
									  "Self: " + "{" + string(self) + "}" + "\n" +
									  "Other: " + "{" + string(_other) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{DateTime} other
			// @returns				{real} | On error: {undefined}
			// @description			Return number of minutes between time components of two DateTimes.
			//						Incomplete minutes are returned as a fraction.
			static spanOfMinutes = function(_other)
			{
				if ((is_real(ID)) and (instanceof(_other) == "DateTime") and (is_real(_other.ID)))
				{
					return date_minute_span(ID, _other.ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "spanOfMinutes";
					var _errorText = ("Attempted to compare invalid dates:\n" +
									  "Self: " + "{" + string(self) + "}" + "\n" +
									  "Other: " + "{" + string(_other) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{DateTime} other
			// @returns				{int} | On error: {undefined}
			// @description			Return number of seconds between time components of two DateTimes.
			static spanOfSeconds = function(_other)
			{
				if ((is_real(ID)) and (instanceof(_other) == "DateTime") and (is_real(_other.ID)))
				{
					return date_second_span(ID, _other.ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "spanOfSeconds";
					var _errorText = ("Attempted to compare invalid dates:\n" +
									  "Self: " + "{" + string(self) + "}" + "\n" +
									  "Other: " + "{" + string(_other) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} full
			// @argument			{bool} multiline
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented as the full date and time output.
			static toString = function(_full, _multiline)
			{
				if (ID != undefined)
				{
					if (_full)
					{
						var _mark_separator = ((_multiline) ? "\n" : ", ");
						
						var _string = ("Date: " + self.toString_date() + _mark_separator +
									   "Time: " + self.toString_time() + _mark_separator +
									   "Is Today: " + string(self.isToday()) + _mark_separator +
									   "Is Leap Year: " + string(self.isLeapYear()) 
														+ _mark_separator +
									   "Weekday: " + string(self.getWeekday()) + _mark_separator +
									   "Days in year: " + string(self.getDaysInYear()) 
														+ _mark_separator +
									   "Days in month: " + string(self.getDaysInMonth()) 
														 + _mark_separator +
									   "Week of year: " + string(self.getWeekOfYear()) 
														+ _mark_separator + 
									   "Day of year: " + string(self.getDayOfYear()) 
													   + _mark_separator +
									   "Hour of year: " + string(self.getHourOfYear()) 
														+ _mark_separator +
									   "Minute of year: " + string(self.getMinuteOfYear())
													   + _mark_separator +
									   "Second of year: " + string(self.getSecondOfYear()));
						
						return ((_multiline) ? _string 
											 : (instanceof(self) + "(" + _string + ")"));
					}
					else
					{
						return ((_multiline) ? date_datetime_string(ID)
											 : (instanceof(self) + "(" + date_datetime_string(ID) + 
											    ")"));
					}
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			// @returns				{string}
			// @description			Return the date component as string.
			static toString_date = function()
			{
				if (is_real(ID))
				{
					return date_date_string(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "toString_date";
					var _errorText = ("Attempted to read an invalid date: " + "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return string(undefined);
				}
			}
			
			// @returns				{string}
			// @description			Return the time component as string.
			static toString_time = function()
			{
				if (is_real(ID))
				{
					return date_time_string(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "toString_time";
					var _errorText = ("Attempted to read an invalid date: " + "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return string(undefined);
				}
			}
			
			// @returns				{int[]|undefined[]}
			// @description			Return all elements of this DateTime as an array, ordered from
			//						the longest units of time to the shortest.
			static toArray = function()
			{
				return [year, month, day, hour, minute, second];
			}
			
			// @returns				{int[]|undefined[]}
			// @description			Return all elements of the date component as an array, ordered
			//						from the longest units of time to the shortest.
			static toArray_date = function()
			{
				return [year, month, day];
			}
			
			// @returns				{int[]|undefined[]}
			// @description			Return all elements of the time component as an array, ordered
			//						from the longest units of time to the shortest.
			static toArray_time = function()
			{
				return [hour, minute, second];
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
