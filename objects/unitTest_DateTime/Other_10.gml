/// @description Unit Testing
#region [Test: Construction: New constructor]
	
	var _base = [1998, 10, 30, 0, 0, 0];
	
	constructor = new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	var _result = [constructor.year, constructor.month, constructor.day, constructor.hour,
				   constructor.minute, constructor.second];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: New constructor",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
#endregion
#region [Test: Construction: Wrapper]
	
	var _base = [2002, 2, 25, 5, 5, 5];
	var _element = date_create_datetime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	constructor = new DateTime(_element);
	
	var _result = [constructor.year, constructor.month, constructor.day, constructor.hour,
				   constructor.minute, constructor.second];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: Wrapper",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
#endregion
#region [Test: Construction: Empty]
	
	constructor = new DateTime();
	
	var _result = [constructor.year, constructor.month, constructor.day, constructor.hour,
				   constructor.minute, constructor.second];
	var _expectedValue = undefined;
	
	unitTest.assert_equal("Construction: Empty",
						  _result[0], _expectedValue,
						  _result[1], _expectedValue,
						  _result[2], _expectedValue,
						  _result[3], _expectedValue,
						  _result[4], _expectedValue,
						  _result[5], _expectedValue);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _base = [2000, 1, 1, 0, 0, 0];
	
	constructor = [new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5])];
	constructor[1] = new DateTime(constructor[0]);
	
	var _result = [constructor[1].year, constructor[1].month, constructor[1].day, constructor[1].hour,
				   constructor[1].minute, constructor[1].second];
	var _expectedValue = [constructor[0].year, constructor[0].month, constructor[0].day, 
						  constructor[0].hour, constructor[0].minute, constructor[0].second];
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
#endregion
#region [Test: Method: isFunctional()]
	
	var _base = [1999, 11];
	
	constructor = [new DateTime(_base[0], _base[1]), new DateTime()];
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional()];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: setCurrent()]
	
	var _base = date_current_datetime();
	
	constructor = new DateTime();
	
	constructor.setCurrent();
	
	var _result = [constructor.ID, constructor.year, constructor.month, constructor.day, 
				   constructor.hour, constructor.minute, constructor.second];
	var _expectedValue = [_base, date_get_year(_base), date_get_month(_base), date_get_day(_base),
						  date_get_hour(_base), date_get_minute(_base), date_get_second(_base)];
	
	unitTest.assert_equal("Method: setCurrent()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6]);
	
#endregion
#region [Test: Method: setDateTime()]
	
	var _base = [2010, 2, 2, 1, 2, 3];
	var _element = date_create_datetime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	constructor = new DateTime();
	
	constructor.setDateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	var _result = [constructor.ID, constructor.year, constructor.month, constructor.day, 
				   constructor.hour, constructor.minute, constructor.second];
	var _expectedValue = [_element, date_get_year(_element), date_get_month(_element), 
						  date_get_day(_element), date_get_hour(_element), 
						  date_get_minute(_element), date_get_second(_element)];
	
	unitTest.assert_equal("Method: setCurrent()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6]);
	
#endregion
#region [Test: Method: modify()]
	
	var _base = [2001, 3, 3, 0, 3, 4];
	var _value = [2, 3, -1, 5, -1, 9];
	
	constructor = new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	constructor.modify(_value[0], _value[1], _value[2], _value[3], _value[4], _value[5]);
	
	var _result = [constructor.year, constructor.month, constructor.day, constructor.hour,
				   constructor.minute, constructor.second];
	var _expectedValue = [(_base[0] + _value[0]), (_base[1] + _value[1]), (_base[2] + _value[2]),
						  ((_base[3] + _value[3]) + 1), (_base[4] + _value[4]),
						  (_base[5] + _value[5])];
	
	unitTest.assert_equal("Method: modify()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
#endregion
#region [Test: Method: modify_years()]

	var _base = [2002, 2, 2, 2, 2, 2];
	var _value = 1;
	
	constructor = [new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5])];
	constructor[1] = new DateTime(constructor[0]);
	
	constructor[0].modify_years(_value);
	constructor[1].modify_years(-_value);
	
	var _result = [constructor[0].year, constructor[1].year];
	var _expectedValue = [(_base[0] + _value), (_base[0] - _value)];
	
	unitTest.assert_equal("Method: modify_years()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: modify_months()]

	var _base = [2003, 3, 3, 3, 3, 3];
	var _value = 2;
	
	constructor = [new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5])];
	constructor[1] = new DateTime(constructor[0]);
	
	constructor[0].modify_months(_value);
	constructor[1].modify_months(-_value);
	
	var _result = [constructor[0].month, constructor[1].month];
	var _expectedValue = [(_base[1] + _value), (_base[1] - _value)];
	
	unitTest.assert_equal("Method: modify_months()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: modify_weeks()]
	
	var _base = [2004, 4, 4, 4, 4, 4];
	var _value = 3;
	var _element = [date_create_datetime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5])];
	_element[1] = date_get_week(_element[0]);
	
	constructor = [new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5])];
	constructor[1] = new DateTime(constructor[0]);
	
	constructor[0].modify_weeks(_value);
	constructor[1].modify_weeks(-_value);
	
	var _result = [constructor[0].week, constructor[1].week];
	var _expectedValue = [(_element[1] + _value), (_element[1] - _value)];
	
	unitTest.assert_equal("Method: modify_weeks()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: modify_days()]

	var _base = [2005, 5, 5, 5, 5, 5];
	var _value = 2;
	
	constructor = [new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5])];
	constructor[1] = new DateTime(constructor[0]);
	
	constructor[0].modify_days(_value);
	constructor[1].modify_days(-_value);
	
	var _result = [constructor[0].day, constructor[1].day];
	var _expectedValue = [(_base[2] + _value), (_base[2] - _value)];
	
	unitTest.assert_equal("Method: modify_days()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: modify_hours()]

	var _base = [2006, 6, 6, 6, 6, 6];
	var _value = 1;
	
	constructor = [new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5])];
	constructor[1] = new DateTime(constructor[0]);
	
	constructor[0].modify_hours(_value);
	constructor[1].modify_hours(-_value);
	
	var _result = [constructor[0].hour, constructor[1].hour];
	var _expectedValue = [(_base[3] + _value), (_base[3] - _value)];
	
	unitTest.assert_equal("Method: modify_hours()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: modify_minutes()]

	var _base = [2007, 7, 7, 7, 7, 7];
	var _value = 2;
	
	constructor = [new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5])];
	constructor[1] = new DateTime(constructor[0]);
	
	constructor[0].modify_minutes(_value);
	constructor[1].modify_minutes(-_value);
	
	var _result = [constructor[0].minute, constructor[1].minute];
	var _expectedValue = [(_base[4] + _value), (_base[4] - _value)];
	
	unitTest.assert_equal("Method: modify_minutes()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: modify_seconds()]

	var _base = [2008, 8, 8, 8, 8, 8];
	var _value = 3;
	
	constructor = [new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5])];
	constructor[1] = new DateTime(constructor[0]);
	
	constructor[0].modify_seconds(_value);
	constructor[1].modify_seconds(-_value);
	
	var _result = [constructor[0].second, constructor[1].second];
	var _expectedValue = [(_base[5] + _value), (_base[5] - _value)];
	
	unitTest.assert_equal("Method: modify_seconds()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: getDate()]
	
	var _base = [1988, 2, 2, 2, 2, 2];
	var _element = date_create_datetime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	constructor = new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	var _result = constructor.getDate();
	var _expectedValue = date_date_of(_element);
	
	unitTest.assert_equal("Method: getDate()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getTime()]
	
	var _base = [1989, 3, 3, 3, 3, 3];
	var _element = date_create_datetime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	constructor = new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	var _result = constructor.getTime();
	var _expectedValue = date_time_of(_element);
	
	unitTest.assert_equal("Method: getTime()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getDaysInYear()]
	
	var _base = [2000, 3, 3, 3, 3, 3];
	var _element = date_create_datetime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	constructor = new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	var _result = constructor.getDaysInYear();
	var _expectedValue = ((date_leap_year(_element)) ? 366 : 365);
	
	unitTest.assert_equal("Method: getDaysInYear()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getDaysInMonth()]
	
	var _base = [2000, 2, 2, 2, 2, 2];
	var _element = date_create_datetime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	constructor = new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	var _result = constructor.getDaysInMonth();
	var _expectedValue = ((date_leap_year(_element)) ? 29 : 28);
	
	unitTest.assert_equal("Method: getDaysInMonth()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getWeekOfYear()]
	
	var _base = [2020, 11, 14, 21, 37, 45];
	var _element = date_create_datetime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	constructor = new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	var _result = constructor.getWeekOfYear()
	var _expectedValue = (46 - 1);
	
	unitTest.assert_equal("Method: getWeekOfYear()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getDayOfYear()]
	
	var _base = [2020, 11, 13, 21, 37, 45];
	var _element = date_create_datetime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	constructor = new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	var _result = constructor.getDayOfYear();
	var _expectedValue = 318;
	
	unitTest.assert_equal("Method: getDayOfYear()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getHourOfYear()]
	
	var _base = [2020, 10, 12, 20, 15, 35];
	var _element = date_create_datetime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	constructor = new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	var _result = constructor.getHourOfYear();
	var _expectedValue = (((date_get_day_of_year(_element) - 1) * 24) + _base[3]);
	
	unitTest.assert_equal("Method: getHourOfYear()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getMinuteOfYear()]
	
	var _base = [2008, 2, 3, 10, 10, 20];
	var _element = date_create_datetime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	constructor = new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	var _result = constructor.getMinuteOfYear();
	var _expectedValue = (((date_get_day_of_year(_element) - 1) * 1440) + (_base[3] * 60) + _base[4]);
	
	unitTest.assert_equal("Method: getMinuteOfYear()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getSecondOfYear()]
	
	var _base = [2008, 2, 3, 10, 10, 20];
	var _element = date_create_datetime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	constructor = new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	var _result = constructor.getSecondOfYear();
	var _expectedValue = (((date_get_day_of_year(_element) - 1) * 86400) + (_base[3] * 3600) + 
						 (_base[4] * 60) + _base[5]);
	
	unitTest.assert_equal("Method: getSecondOfYear()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getWeekday()]
	
	var _base = [2020, 11, 14, 21, 56, 50];
	var _element = date_create_datetime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	constructor = new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	var _result = constructor.getWeekday();
	var _expectedValue = 6;
	
	unitTest.assert_equal("Method: getWeekday()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: isToday()]
	
	var _base = [1999, 10, 10, 20, 50, 50];
	var _element = date_create_datetime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	constructor = [new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]),
				   new DateTime(date_current_datetime())];
	
	var _result = [constructor[0].isToday(), constructor[1].isToday()];
	var _expectedValue = [false, true];
	
	unitTest.assert_equal("Method: isToday()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: isLeapYear()]
	
	var _base = [2000, 2, 2, 2, 2, 2];
	var _element = date_create_datetime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	constructor = [new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]),
				   new DateTime((_base[0] + 1), _base[1], _base[2], _base[3], _base[4], _base[5])];
	
	var _result = [constructor[0].isLeapYear(),
				   constructor[1].isLeapYear()];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: isLeapYear()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: compareDateTime()]
	
	var _base = [2010, 3, 3, 3, 3, 3];
	var _value = 1;
	
	constructor = [new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]),
				   new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], 
							    (_base[5] + _value)),
				   new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], 
								(_base[5] - _value))];
	
	var _result = [constructor[0].compareDateTime(new DateTime(constructor[0])),
				   constructor[0].compareDateTime(constructor[1]),
				   constructor[0].compareDateTime(constructor[2])];
	var _expectedValue = [0, -1, 1];
	
	unitTest.assert_equal("Method: compareDateTime()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: compareDate()]
	
	var _base = [2011, 4, 4, 4, 4, 4];
	var _value = 1;
	
	constructor = [new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]),
				   new DateTime(_base[0], _base[1], (_base[2] + 1), _base[3], _base[4], 
							    (_base[5] + _value)),
				   new DateTime(_base[0], _base[1], (_base[2] - 1), _base[3], _base[4], 
							    (_base[5] - _value))];
	
	var _result = [constructor[0].compareDate(new DateTime(constructor[0])),
				   constructor[0].compareDate(constructor[1]),
				   constructor[0].compareDate(constructor[2])];
	var _expectedValue = [0, -1, 1];
	
	unitTest.assert_equal("Method: compareDate()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: compareTime()]
	
	var _base = [2012, 5, 5, 5, 5, 5];
	var _value = 1;
	
	constructor = [new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]),
				   new DateTime(_base[0], _base[1], (_base[2] + 1), _base[3], _base[4], 
							    (_base[5] + _value)),
				   new DateTime(_base[0], _base[1], (_base[2] - 1), _base[3], _base[4], 
							    (_base[5] - _value))];
	
	var _result = [constructor[0].compareTime(new DateTime(constructor[0])),
				   constructor[0].compareTime(constructor[1]),
				   constructor[0].compareTime(constructor[2])];
	var _expectedValue = [0, -1, 1];
	
	unitTest.assert_equal("Method: compareTime()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: spanOfYears()]
	
	var _base = [2012, 4, 4, 4, 4, 4];
	var _value = 1;
	
	constructor = [new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]),
				   new DateTime((_base[0]), _base[1], (_base[2] + _value), _base[3], _base[4],
								_base[5]),
				   new DateTime((_base[0]), _base[1], (_base[2] - _value), _base[3], _base[4],
								_base[5])];
	
	var _result = [constructor[0].spanOfYears(new DateTime(constructor[0])), 
				   constructor[0].spanOfYears(constructor[1]),
				   constructor[0].spanOfYears(constructor[2])];
	var _expectedValue = [0, (_value / 365)];
	_expectedValue[2] = _expectedValue[1];
	
	unitTest.assert_equal("Method: spanOfYears()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: spanOfMonths()]
	
	var _base = [2012, 3, 5, 5, 5, 5];
	var _value = 1;
	
	constructor = [new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]),
				   new DateTime(_base[0], _base[1], _base[2], _base[3], (_base[4] + _value), 
								_base[5]),
				   new DateTime(_base[0], _base[1], _base[2], _base[3], (_base[4] - _value), 
								_base[5])];
	
	var _result = [constructor[0].spanOfMonths(new DateTime(constructor[0])),
				   constructor[0].spanOfMonths(constructor[1]),
				   constructor[0].spanOfMonths(constructor[2])];
	var _expectedValue = [0, (1 / (29 * 24 * 60))];
	_expectedValue[2] = _expectedValue[1];
	
	unitTest.assert_equal("Method: spanOfMonths()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: spanOfWeeks()]
	
	var _base = [2012, 2, 3, 3, 3, 3];
	var _value = 14;
	
	constructor = [new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]),
				   new DateTime(_base[0], _base[1], (_base[2] + _value), _base[3], _base[4], 
								_base[5]),
				   new DateTime(_base[0], _base[1], (_base[2] - _value), _base[3], _base[4], 
								_base[5])];
	
	var _result = [constructor[0].spanOfWeeks(new DateTime(constructor[0])),
				   constructor[0].spanOfWeeks(constructor[1]),
				   constructor[0].spanOfWeeks(constructor[2])];
	var _expectedValue = [0, 2];
	_expectedValue[2] = _expectedValue[1];
	
	unitTest.assert_equal("Method: spanOfWeeks()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: spanOfDays()]
	
	var _base = [2012, 1, 7, 7, 7, 7];
	var _value = 5;
	
	constructor = [new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]),
				   new DateTime(_base[0], _base[1], (_base[2] + _value), _base[3], _base[4], 
								_base[5]),
				   new DateTime(_base[0], _base[1], (_base[2] - _value), _base[3], _base[4], 
								_base[5])];
	
	var _result = [constructor[0].spanOfDays(new DateTime(constructor[0])),
				   constructor[0].spanOfDays(constructor[1]),
				   constructor[0].spanOfDays(constructor[2])];
	var _expectedValue = [0, _value];
	_expectedValue[2] = _expectedValue[1];
	
	unitTest.assert_equal("Method: spanOfDays()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: spanOfHours()]
	
	var _base = [2012, 1, 7, 7, 7, 7];
	var _value = 3;
	
	constructor = [new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]),
				   new DateTime(_base[0], _base[1], _base[2], (_base[3] + _value), _base[4], 
								_base[5]),
				   new DateTime(_base[0], _base[1], _base[2], (_base[3] - _value), _base[4], 
								_base[5])];
	
	var _result = [constructor[0].spanOfHours(new DateTime(constructor[0])),
				   constructor[0].spanOfHours(constructor[1]),
				   constructor[0].spanOfHours(constructor[2])];
	var _expectedValue = [0, _value];
	_expectedValue[2] = _expectedValue[1];
	
	unitTest.assert_equal("Method: spanOfHours()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: spanOfMinutes()]
	
	var _base = [2012, 2, 6, 6, 7, 7];
	var _value = 1;
	
	constructor = [new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]),
				   new DateTime(_base[0], _base[1], _base[2], (_base[3] + _value), _base[4], 
								_base[5]),
				   new DateTime(_base[0], _base[1], _base[2], (_base[3] - _value), _base[4], 
								_base[5])];
	
	var _result = [constructor[0].spanOfMinutes(new DateTime(constructor[0])),
				   constructor[0].spanOfMinutes(constructor[1]),
				   constructor[0].spanOfMinutes(constructor[2])];
	var _expectedValue = [0, 60];
	_expectedValue[2] = _expectedValue[1];
	
	unitTest.assert_equal("Method: spanOfMinutes()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: spanOfSeconds()]
	
	var _base = [2012, 2, 5, 2, 5, 7];
	var _value = 10;
	
	constructor = [new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]),
				   new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], 
								(_base[5] + _value)),
				   new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], 
								(_base[5] - _value))];
	
	var _result = [constructor[0].spanOfSeconds(new DateTime(constructor[0])),
				   constructor[0].spanOfSeconds(constructor[1]),
				   constructor[0].spanOfSeconds(constructor[2])];
	var _expectedValue = [0, _value];
	_expectedValue[2] = _expectedValue[1];
	
	unitTest.assert_equal("Method: spanOfSeconds()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: String Conversion]
	
	var _element = date_current_datetime();
	
	constructor = new DateTime(_element);
	
	var _result = string(constructor);
	var _expectedValue = (constructorName + "(" + date_datetime_string(_element) + ")");
	
	unitTest.assert_equal("String Conversion",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(full, multiline)]
	
	var _element = date_current_datetime();
	
	constructor = new DateTime(_element);
	
	var _result = [constructor.toString(true, true), constructor.toString(true, false)];
	
	var _argumentVariation = ["\n", ", "];
	var _expectedValue;
	
	var _i = 0;
	repeat (array_length(_argumentVariation))
	{
		_expectedValue[_i] = ("Date: " + date_date_string(_element) + _argumentVariation[_i] +
							  "Time: " + date_time_string(_element) + _argumentVariation[_i] +
							  "Is Today: " + string(date_is_today(_element)) + 
											 _argumentVariation[_i] +
							  "Is Leap Year: " + string(date_leap_year(_element)) 
											   + _argumentVariation[_i] +
							  "Weekday: " + string(date_get_weekday(_element)) 
										  + _argumentVariation[_i] +
							  "Days in year: " + string(date_days_in_year(_element)) 
											   + _argumentVariation[_i] +
							  "Days in month: " + string(date_days_in_month(_element))
												+ _argumentVariation[_i] +
							  "Week of year: " + string(date_get_week(_element)) 
											   + _argumentVariation[_i] + 
							  "Day of year: " + string(date_get_day_of_year(_element)) 
											  + _argumentVariation[_i] +
							  "Hour of year: " + string(date_get_hour_of_year(_element)) 
											   + _argumentVariation[_i] +
							  "Minute of year: " + string(date_get_minute_of_year(_element)) 
												 + _argumentVariation[_i] +
							  "Second of year: " + string(date_get_second_of_year(_element)));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "(" + _expectedValue[1] + ")");
	
	unitTest.assert_equal("Method: toString(full, multiline?)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
						  
	
#endregion
#region [Test: Method: toString_date()]
	
	var _element = date_current_datetime();
	
	constructor = new DateTime(_element);
	
	var _result = constructor.toString_date();
	var _expectedValue = date_date_string(_element);
	
	unitTest.assert_equal("Method: toString_date()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString_time()]
	
	var _element = date_current_datetime();
	
	constructor = new DateTime(_element);
	
	var _result = constructor.toString_time();
	var _expectedValue = date_time_string(_element);
	
	unitTest.assert_equal("Method: toString_time()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toArray()]
	
	var _base = [2019, 11, 28, 23, 59, 59];
	
	constructor = new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	var _result = constructor.toArray();
	var _expectedValue = _base;
	
	unitTest.assert_equal("Method: toArray()",
						  _result, _base);
	
#endregion
#region [Test: Method: toArray_date()]
	
	var _base = [2018, 10, 27, 15, 15, 15];
	
	constructor = new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	var _result = constructor.toArray_date();
	var _expectedValue = [_base[0], _base[1], _base[2]];
	
	unitTest.assert_equal("Method: toArray_date()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toArray_time()]
	
	var _base = [2017, 9, 26, 14, 17, 38];
	
	constructor = new DateTime(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	var _result = constructor.toArray_time()
	var _expectedValue = [_base[3], _base[4], _base[5]];
	
	unitTest.assert_equal("Method: toArray_time()",
						  _result, _expectedValue);
	
#endregion
