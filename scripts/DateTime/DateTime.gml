//  @function				DateTime()
/// @argument				year {int}
/// @argument				month {int}
/// @argument				day {int}
/// @argument				hour? {int}
/// @argument				minute? {int}
/// @argument				second? {int}
///							
/// @description			Constructs a container for a DateTime.
//							
//							Construction types:
//							- New constructor
//							- From one array: array {int[]}
//							   Array elements will be applied in the following order:
//							   [year, month?, day?, hour?, minute?, second?]
//							- From two arrays: date {int[]}, time {int[]}
//								Array elements will be applied in the following order:
//								[year, month, day], [hour, minute, second?]
//							- Wrapper: datetime {real:datetime}
//							- Empty: {void|undefined}
//							- Constructor copy: other {DateTime}
function DateTime() constructor
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				ID = undefined;
				year = undefined;
				month = undefined;
				week = undefined;
				day = undefined;
				hour = undefined;
				minute = undefined;
				second = undefined;
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (instanceof(argument[0]) == "DateTime")
					{
						//|Construction type: Constructor copy.
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
						if ((argument_count == 1) and (is_real(argument[0])))
						{
							//|Construction type: Wrapper.
							ID = argument[0];
							year = date_get_year(ID);
							month = date_get_month(ID);
							week = date_get_week(ID);
							day = date_get_day(ID);
							hour = date_get_hour(ID);
							minute = date_get_minute(ID);
							second = date_get_second(ID);
						}
						else if (is_array(argument[0]))
						{
							if ((argument_count > 1) and (is_array(argument[1])))
							{
								//|Construction type: From two arrays.
								var _array_date = argument[0];
								var _array_time = argument[1];
								var _second = (((array_length(_array_time) > 2)
											   and (_array_time[2] != undefined))
											   ? _array_time[2] : 0);
								
								ID = date_create_datetime(_array_date[0], _array_date[1],
														  _array_date[2], _array_time[0],
														  _array_time[1], _second);
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
								//|Construction type: From one array.
								var _array = argument[0];
								var _array_length = array_length(argument[0]);
								var _year = _array[0];
								var _month = (((_array_length > 1) and (_array[1] != undefined))
											  ? _array[1] : 1);
								var _day = (((_array_length > 2) and (_array[2] != undefined))
											? _array[2] : 1);
								var _hour = (((_array_length > 3) and (_array[3] != undefined))
											 ? _array[3] : 0);
								var _minute = (((_array_length > 4) and (_array[4] != undefined))
											   ? _array[4] : 0);
								var _second = (((_array_length > 5) and (_array[5] != undefined))
											   ? _array[5] : 0);
								
								ID = date_create_datetime(_year, _month, _day, _hour, _minute,
														  _second);
								year = date_get_year(ID);
								month = date_get_month(ID);
								week = date_get_week(ID);
								day = date_get_day(ID);
								hour = date_get_hour(ID);
								minute = date_get_minute(ID);
								second = date_get_second(ID);
							}
						}
						else
						{
							//|Construction type: New datetime.
							var _year = argument[0];
							var _month = argument[1];
							var _day = argument[2];
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
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return (is_real(ID));
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			other {DateTime}
			/// @returns			{int} | On error: {undefined}
			/// @description		Compare this DateTime with an other one and check which is first.
			///						Returns -1 if this date and time is earlier, 0 if even, 1 if
			///						later.
			static compareDateTime = function(_other)
			{
				try
				{
					return date_compare_datetime(ID, _other.ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "compareDateTime()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			other {DateTime}
			/// @returns			{int} | On error: {undefined}
			/// @description		Compare the date components of this DateTime and an other one and
			///						check which is first. Returns -1 if this date is earlier, 0 if
			///						even, 1 if later.
			static compareDate = function(_other)
			{
				try
				{
					return date_compare_date(ID, _other.ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "compareDate()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			other {DateTime}
			/// @returns			{int} | On error: {undefined}
			/// @description		Compare the time components of this DateTimes and an other one
			///						and check which is first. Returns -1 if this time is earlier, 0
			///						if even, 1 if later.
			static compareTime = function(_other)
			{
				try
				{
					return date_compare_time(ID, _other.ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "compareTime()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			other {DateTime}
			/// @returns			{real} | On error: {undefined}
			/// @description		Return number of years between date components of this DateTime
			///						and an other one. Incomplete years are returned as a fraction.
			static spanOfYears = function(_other)
			{
				try
				{
					return date_year_span(ID, _other.ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "spanOfYears()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			other {DateTime}
			/// @returns			{real} | On error: {undefined}
			/// @description		Return number of months between date components of this DateTime
			///						and an other one. Incomplete months are returned as a fraction.
			static spanOfMonths = function(_other)
			{
				try
				{
					return date_month_span(ID, _other.ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "spanOfMonths()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			other {DateTime}
			/// @returns			{real} | On error: {undefined}
			/// @description		Return number of weeks between date components of this DateTime
			///						and an other one. Incomplete weeks are returned as a fraction.
			static spanOfWeeks = function(_other)
			{
				try
				{
					return date_week_span(ID, _other.ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "spanOfWeeks()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			other {DateTime}
			/// @returns			{real} | On error: {undefined}
			/// @description		Return number of days between date components of this DateTime
			///						and an other one. Incomplete days are returned as a fraction.
			static spanOfDays = function(_other)
			{
				try
				{
					return date_day_span(ID, _other.ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "spanOfDays()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			other {DateTime}
			/// @returns			{real} | On error: {undefined}
			/// @description		Return number of hours between time components of this DateTime
			///						and an other one. Incomplete hours are returned as a fraction.
			static spanOfHours = function(_other)
			{
				try
				{
					return date_hour_span(ID, _other.ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "spanOfHours()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			other {DateTime}
			/// @returns			{real} | On error: {undefined}
			/// @description		Return number of minutes between time components of this DateTime
			///						and an other one. Incomplete minutes are returned as a fraction.
			static spanOfMinutes = function(_other)
			{
				try
				{
					return date_minute_span(ID, _other.ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "spanOfMinutes()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			other {DateTime}
			/// @returns			{int} | On error: {undefined}
			/// @description		Return number of seconds between time components of this DateTime
			///						and an other one.
			static spanOfSeconds = function(_other)
			{
				try
				{
					return date_second_span(ID, _other.ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "spanOfSeconds()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{int} | On error: {undefined}
			/// @description		Get the date component of this DateTime.
			static getDate = function()
			{		
				try
				{
					return date_date_of(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getDate()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{int} | On error: {undefined}
			/// @description		Get the time component of this DateTime.
			static getTime = function()
			{				
				try
				{
					return date_time_of(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getTime()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{int} | On error: {undefined}
			/// @description		Get the number of days in the year of the date component.
			static getDaysInYear = function()
			{
				try
				{
					return date_days_in_year(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getDaysInYear()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{int} | On error: {undefined}
			/// @description		Get the number of days in the month of the date component.
			static getDaysInMonth = function()
			{				
				try
				{
					return date_days_in_month(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getDaysInMonth()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{int} | On error: {undefined}
			/// @description		Get the number of which week in the year the date component is.
			///						This number starts at 0.
			static getWeekOfYear = function()
			{				
				try
				{
					return date_get_week(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getWeekOfYear()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{int} | On error: {undefined}
			/// @description		Get the number of which day in the year the date component is.
			static getDayOfYear = function()
			{				
				try
				{
					return date_get_day_of_year(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getDayOfYear()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{int} | On error: {undefined}
			/// @description		Get the number of which hour in the year the date component is.
			static getHourOfYear = function()
			{				
				try
				{
					return date_get_hour_of_year(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getHourOfYear()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{int} | On error: {undefined}
			/// @description		Get the number of which minute in the year the date component is.
			static getMinuteOfYear = function()
			{				
				try
				{
					return date_get_minute_of_year(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getMinuteOfYear()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{int} | On error: {undefined}
			/// @description		Get the number of which second in the year the date component is.
			static getSecondOfYear = function()
			{				
				try
				{
					return date_get_second_of_year(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getSecondOfYear()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{int} | On error: {undefined}
			/// @description		Get the day count in the week of the date component.
			///						This number starts at 0 and treats Sunday as the first day of the
			///						week.
			static getWeekday = function()
			{				
				try
				{
					return date_get_weekday(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getWeekday()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{bool} | On error: {undefined}
			/// @description		Check if the date component is the same as local date of this
			///						device using the set timezone.
			static isToday = function()
			{
				try
				{
					return date_is_today(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "isToday()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{bool} | On error: {undefined}
			/// @description		Check if the date component is a leap year, a calendar containing
			///						an additional day.
			static isLeapYear = function()
			{
				try
				{
					return date_leap_year(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "isLeapYear()"], _exception);
				}
				
				return undefined;
			}
			
		#endregion
		#region <Setters>
			
			/// @argument			years {int} 
			/// @argument			months {int} 
			/// @argument			days {int} 
			/// @argument			hours {int} 
			/// @argument			minutes {int} 
			/// @argument			seconds {int} 
			/// @description		Modify any component of this DateTime by a specified number.
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
					new ErrorReport().report([other, self, "modify()"],
											 ("Attempted to modify an invalid date: " +
											  "{" + string(ID) + "}"));
				}
				
				return self;
			}
			
			/// @argument			number {int}
			/// @description		Modify the years in this DateTime by a specified number.
			static modifyYears = function(_value)
			{
				if (is_real(ID))
				{
					ID = date_inc_year(ID, _value);
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
					new ErrorReport().report([other, self, "modifyYears()"],
											 ("Attempted to modify an invalid date: " +
											  "{" + string(ID) + "}"));
				}
				
				return self;
			}
			
			/// @argument			value {int}
			/// @description		Modify the months in this DateTime by a specified number.
			static modifyMonths = function(_value)
			{
				if (is_real(ID))
				{
					ID = date_inc_month(ID, _value);
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
					new ErrorReport().report([other, self, "modifyMonths()"],
											 ("Attempted to modify an invalid date: " +
											  "{" + string(ID) + "}"));
				}
				
				return self;
			}
			
			/// @argument			value {int}
			/// @description		Modify the weeks in this DateTime by a specified number.
			static modifyWeeks = function(_value)
			{
				if (is_real(ID))
				{
					ID = date_inc_week(ID, _value);
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
					new ErrorReport().report([other, self, "modifyWeeks()"],
											 ("Attempted to modify an invalid date: " +
											  "{" + string(ID) + "}"));
				}
				
				return self;
			}
			
			/// @argument			value {int}
			/// @description		Modify the days in this DateTime by a specified number.
			static modifyDays = function(_value)
			{
				if (is_real(ID))
				{
					ID = date_inc_day(ID, _value);
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
					new ErrorReport().report([other, self, "modifyDays()"],
											 ("Attempted to modify an invalid date: " +
											  "{" + string(ID) + "}"));
				}
				
				return self;
			}
			
			/// @argument			value {int}
			/// @description		Modify the hours in this DateTime by a specified number.
			static modifyHours = function(_value)
			{
				if (is_real(ID))
				{
					ID = date_inc_hour(ID, _value);
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
					new ErrorReport().report([other, self, "modifyHours()"],
											 ("Attempted to modify an invalid date: " +
											  "{" + string(ID) + "}"));
				}
				
				return self;
			}
			
			/// @argument			value {int}
			/// @description		Modify the minutes in this DateTime by a specified number.
			static modifyMinutes = function(_value)
			{
				if (is_real(ID))
				{
					ID = date_inc_minute(ID, _value);
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
					new ErrorReport().report([other, self, "modifyMinutes()"],
											 ("Attempted to modify an invalid date: " +
											  "{" + string(ID) + "}"));
				}
				
				return self;
			}
			
			/// @argument			value {int}
			/// @description		Modify the seconds in this DateTime by a specified number.
			static modifySeconds = function(_value)
			{
				if (is_real(ID))
				{
					ID = date_inc_second(ID, _value)
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
					new ErrorReport().report([other, self, "modifySeconds()"],
											 ("Attempted to modify an invalid date: " +
											  "{" + string(ID) + "}"));
				}
				
				return self;
			}
			
			/// @description		Set this DateTime to the current of the system using the set
			///						timezone.
			static setCurrent = function()
			{
				ID = date_current_datetime();
				year = date_get_year(ID);
				month = date_get_month(ID);
				week = date_get_week(ID);
				day = date_get_day(ID);
				hour = date_get_hour(ID);
				minute = date_get_minute(ID);
				second = date_get_second(ID);
				
				return self;
			}
			
			/// @argument			year {int}
			/// @argument			month {int}
			/// @argument			day	{int}
			/// @argument			hour {int}
			/// @argument			minute {int}
			/// @argument			second {int}
			/// @description		Set this DateTime to a newly created one.
			static setDateTime = function(_year, _month, _day, _hour, _minute, _second)
			{
				ID = date_create_datetime(_year, _month, _day, _hour, _minute, _second);
				year = date_get_year(ID);
				month = date_get_month(ID);
				week = date_get_week(ID);
				day = date_get_day(ID);
				hour = date_get_hour(ID);
				minute = date_get_minute(ID);
				second = date_get_second(ID);
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @argument			full? {bool}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented as the full date and time output.
			static toString = function(_multiline = false, _full = false)
			{
				if (ID != undefined)
				{
					if (_full)
					{
						var _mark_separator = ((_multiline) ? "\n" : ", ");
						var _string = ("Date: " + self.toStringDate() + _mark_separator +
									   "Time: " + self.toStringTime() + _mark_separator +
									   "Is today: " + string(self.isToday()) + _mark_separator +
									   "Is leap year: " + string(self.isLeapYear()) 
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
			
			/// @returns			{string}
			/// @description		Return the date component as string.
			static toStringDate = function()
			{
				try
				{
					return date_date_string(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "toStringDate()"], _exception);
				}
				
				return string(undefined);
			}
			
			/// @returns			{string}
			/// @description		Return the time component as string.
			static toStringTime = function()
			{
				try
				{
					return date_time_string(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "toStringTime()"], _exception);
				}
				
				return string(undefined);
			}
			
			/// @returns			{int[]|undefined[]}
			/// @description		Return all elements of this DateTime as an array, ordered from
			///						the longest units of time to the shortest.
			static toArray = function()
			{
				return [year, month, day, hour, minute, second];
			}
			
			/// @returns			{int[]|undefined[]}
			/// @description		Return all elements of the date component as an array, ordered
			///						from the longest units of time to the shortest.
			static toArrayDate = function()
			{
				return [year, month, day];
			}
			
			/// @returns			{int[]|undefined[]}
			/// @description		Return all elements of the time component as an array, ordered
			///						from the longest units of time to the shortest.
			static toArrayTime = function()
			{
				return [hour, minute, second];
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

