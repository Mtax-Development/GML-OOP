/// @function				DateTime()
/// @argument				 {datetime} value?
///
/// @description			Constructs a container for a DateTime.
function DateTime() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				if (ID != undefined)
				{
					year = date_get_year(ID);
					month = date_get_month(ID);
					day = date_get_day(ID);
					hour = date_get_hour(ID);
					minute = date_get_minute(ID);
					second = date_get_second(ID);
				}
				else
				{
					year = undefined;
					month = undefined;
					week = undefined;
					day = undefined;
					hour = undefined;
					minute = undefined;
					second = undefined;
				}
			}
			
		#endregion
		#region <Setters>
			
			// @description			Set this DateTime to the system's current, following set timezone.
			static setCurrent = function()
			{
				ID = date_current_datetime();
				self.construct();
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
				ID = date_create_datetime(_year, _month, _day, _hour, _minute, _second);
				self.construct();
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
				if (ID != undefined)
				{
					ID = date_inc_year(ID, _years);
					ID = date_inc_month(ID, _months);
					ID = date_inc_day(ID, _days);
					ID = date_inc_hour(ID, _hours);
					ID = date_inc_minute(ID, _minutes);
					ID = date_inc_second(ID, _seconds);
					
					self.construct();
				}
			}
			
			// @argument			{int} number
			// @description			Modify the years in this DateTime by a specified number.
			static modifyYears = function(_number)
			{
				if (ID != undefined)
				{
					ID = date_inc_year(ID, _number);
					
					self.construct();
				}
			}
			
			// @argument			{int} number
			// @description			Modify the months in this DateTime by a specified number.
			static modifyMonths = function(_number)
			{
				if (ID != undefined)
				{
					ID = date_inc_month(ID, _number);
					
					self.construct();
				}
			}
			
			// @argument			{int} number
			// @description			Modify the weeks in this DateTime by a specified number.
			static modifyeWeeks = function(_number)
			{
				if (ID != undefined)
				{
					ID = date_inc_week(ID, _number);
					
					self.construct();
				}
			}
			
			// @argument			{int} number
			// @description			Modify the days in this DateTime by a specified number.
			static modifyDays = function(_number)
			{
				if (ID != undefined)
				{
					ID = date_inc_day(ID, _number);
					
					self.construct();
				}
			}
			
			// @argument			{int} number
			// @description			Modify the hours in this DateTime by a specified number.
			static modifyHours = function(_number)
			{
				if (ID != undefined)
				{
					ID = date_inc_hour(ID, _number);
					
					self.construct();
				}
			}
			
			// @argument			{int} number
			// @description			Modify the minutes in this DateTime by a specified number.
			static modifyMinutes = function(_number)
			{
				if (ID != undefined)
				{
					ID = date_inc_minute(ID, _number);
					
					self.construct();
				}
			}
			
			// @argument			{int} number
			// @description			Modify the seconds in this DateTime by a specified number.
			static modifySeconds = function(_number)
			{
				if (ID != undefined)
				{
					ID = date_inc_second(ID, _number);
					
					self.construct();
				}
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{int | undefined}
			// @description			Get the date component of this DateTime.
			static getDate = function()
			{				
				return (ID != undefined ? date_date_of(ID) : undefined);
			}
			
			// @returns				{int | undefined}
			// @description			Get the time component of this DateTime.
			static getTime = function()
			{				
				return (ID != undefined ? date_time_of(ID) : undefined);
			}
			
			// @returns				{int | undefined}
			// @description			Get the number of days in the year of the date component.
			static getDaysInYear = function()
			{
				return (ID != undefined ? date_days_in_year(ID) : undefined);
			}
			
			// @returns				{int | undefined}
			// @description			Get the number of days in the month of the date component.
			static getDaysInMonth = function()
			{				
				return (ID != undefined ? date_days_in_month(ID) : undefined);
			}
			
			// @returns				{int | undefined}
			// @description			Get the number of which week in the year the date component is.
			static getWeekOfYear = function()
			{				
				return (ID != undefined ? date_get_week(ID) : undefined);
			}
			
			// @returns				{int | undefined}
			// @description			Get the number of which day in the year the date component is.
			static getDayOfYear = function()
			{				
				return (ID != undefined ? date_get_day_of_year(ID) : undefined);
			}
			
			// @returns				{int | undefined}
			// @description			Get the number of which hour in the year the date component is.
			static getHourOfYear = function()
			{				
				return (ID != undefined ? date_get_hour_of_year(ID) : undefined);
			}
			
			// @returns				{int | undefined}
			// @description			Get the number of which minute in the year the date component is.
			static getMinuteOfYear = function()
			{				
				return (ID != undefined ? date_get_minute_of_year(ID) : undefined);
			}
			
			// @returns				{int | undefined}
			// @description			Get the number of which second in the year the date component is.
			static getSecondOfYear = function()
			{				
				return (ID != undefined ? date_get_second_of_year(ID) : undefined);
			}
			
			// @returns				{int | undefined}
			// @description			Get the day count in the week of the date component.
			static getWeekday = function()
			{				
				return (ID != undefined ? date_get_weekday(ID) : undefined);
			}
			
		#endregion
		#region <Calculations>
			
			// @argument			{DateTime} other
			// @returns				{int | undefined}
			// @description			Compare two DateTimes and check which is first.
			//						Returns -1 if this date is earlier, 0 if even, 1 if later.
			static compareDateTime = function(_other)
			{
				return ((ID != undefined) and (_other != undefined) and (_other.ID != undefined) ?
					   date_compare_datetime(ID, _other.ID) : undefined);
			}
		
			// @argument			{DateTime} other
			// @returns				{int | undefined}
			// @description			Compare two dates (without time) and check which is first.
			//						Returns -1 if this date is earlier, 0 if even, 1 if later.
			static compareDate = function(_other)
			{
				return ((ID != undefined) and (_other != undefined) and (_other.ID != undefined) ?
					   date_compare_date(ID, _other.ID) : undefined);
			}
			
			// @argument			{DateTime} other
			// @returns				{int | undefined}
			// @description			Compare time values of two DateTimes and check which is first.
			//						Returns -1 if this date is earlier, 0 if even, 1 if later.
			static compareTime = function(_other)
			{
				return ((ID != undefined) and (_other != undefined) and (_other.ID != undefined) ?
					   date_compare_time(ID, _other.ID) : undefined);
			}
			
			// @argument			{DateTime} other
			// @returns				{real | undefined}
			// @description			Return number of years between date components of two DateTimes.
			//						Incomplete years are returned as a fraction.
			static spanOfYears = function(_other)
			{
				return ((ID != undefined) and (_other != undefined) and (_other.ID != undefined) ?
					   date_year_span(ID, _other.ID) : undefined);
			}
			
			// @argument			{DateTime} other
			// @returns				{real | undefined}
			// @description			Return number of months between date components of two DateTimes.
			//						Incomplete months are returned as a fraction.
			static spanOfMonths = function(_other)
			{
				return ((ID != undefined) and (_other != undefined) and (_other.ID != undefined) ?
					   date_month_span(ID, _other.ID) : undefined);
			}
			
			// @argument			{DateTime} other
			// @returns				{real | undefined}
			// @description			Return number of weeks between date components of two DateTimes.
			//						Incomplete weeks are returned as a fraction.
			static spanOfWeeks = function(_other)
			{
				return ((ID != undefined) and (_other != undefined) and (_other.ID != undefined) ?
					   date_week_span(ID, _other.ID) : undefined);
			}
			
			// @argument			{DateTime} other
			// @returns				{real | undefined}
			// @description			Return number of days between date components of two DateTimes.
			//						Incomplete days are returned as a fraction.
			static spanOfDays = function(_other)
			{
				return ((ID != undefined) and (_other != undefined) and (_other.ID != undefined) ?
					   date_day_span(ID, _other.ID) : undefined);
			}
			
			// @argument			{DateTime} other
			// @returns				{real | undefined}
			// @description			Return number of hours between time components of two DateTimes.
			//						Incomplete hours are returned as a fraction.
			static spanOfHours = function(_other)
			{
				return ((ID != undefined) and (_other != undefined) and (_other.ID != undefined) ?
					   date_hour_span(ID, _other.ID) : undefined);
			}
			
			// @argument			{DateTime} other
			// @returns				{real | undefined}
			// @description			Return number of minutes between time components of two DateTimes.
			//						Incomplete minutes are returned as a fraction.
			static spanOfMinutes = function(_other)
			{
				return ((ID != undefined) and (_other != undefined) and (_other.ID != undefined) ?
					   date_minute_span(ID, _other.ID) : undefined);
			}
			
			// @argument			{DateTime} other
			// @returns				{real | undefined}
			// @description			Return number of seconds between time components of two DateTimes.
			//						This is always a whole number.
			static spanOfSeconds = function(_other)
			{
				return ((ID != undefined) and (_other != undefined) and (_other.ID != undefined) ?
					   date_second_span(ID, _other.ID) : undefined);
			}
			
		#endregion
		#region <Asserts>
		
			// @returns				{bool | undefined}
			// @description			Check if the date component is the same as device's local date, 
			//						following set timezone.
			static isToday = function()
			{
				return (ID != undefined ? date_is_today(ID) : undefined);
			}
			
			// @returns				{bool | undefined}
			// @description			Check if the date component is a leap year - a calendar year 
			//						that contains an additional day			
			static isLeapYear = function()
			{
				return (ID != undefined ? date_leap_year(ID) : undefined);
			}
		
		#endregion
		#region <Typing>
			
			// @returns				{string}
			// @description			Override the string conversion with full datetime output.
			static toString = function()
			{
				return (ID != undefined ? date_datetime_string(ID) : string(undefined));
			}
			
			// @returns				{string}
			// @description			Return the date component as string.
			static toString_date = function()
			{
				return (ID != undefined ? date_date_string(ID) : string(undefined));
			}
			
			// @returns				{string}
			// @description			Return the time component as string.
			static toString_time = function()
			{
				return (ID != undefined ? date_time_string(ID) : string(undefined));
			}
			
			// @returns				{string}
			// @description			Return information of all readable getters about this DateTime.
			static toString_info = function()
			{
				return ("Date: " + self.toString_date() + "\n" +
						"Time: " + self.toString_time() + "\n" +
						"Is Today: " + string(self.isToday()) + "\n" +
						"Is Leap Year: " + string(self.isLeapYear()) + "\n" +
						"Weekday: " + string(self.getWeekday()) + "\n" +
						"Days in year: " + string(self.getDaysInYear()) + "\n" +
						"Days in month: " + string(self.getDaysInMonth()) + "\n" +
						"Week of year: " + string(self.getWeekOfYear()) + "\n" + 
						"Day of year: " + string(self.getDayOfYear()) + "\n" +
						"Hour of year: " + string(self.getHourOfYear()) + "\n" +
						"Minute of year: " + string(self.getMinuteOfYear()) + "\n" +
						"Second of year: " + string(self.getSecondOfYear()) + "\n");
			}
			
			// @returns				{int[] | undefined[]}
			// @description			Return all elements of the DateTime as an array, ordered from
			//						the longest elements to the shortest.
			static toArray = function()
			{
				return [year, month, day, hour, minute, second];
			}
			
			// @returns				{int[] | undefined[]}
			// @description			Return all elements of the date component as an array, ordered
			//						from the longest elements to the shortest.
			static toArray_date = function()
			{
				return [year, month, day];
			}
			
			// @returns				{int[] | undefined[]}
			// @description			Return all elements of the time component as an array, ordered
			//						from the longest elements to the shortest.
			static toArray_time = function()
			{
				return [hour, minute, second];
			}
			
		#endregion
	#endregion
	#region [Constructor]
	
		ID = (argument_count >= 1 ? argument[0] : undefined);
		
		self.construct();
	
	#endregion
}