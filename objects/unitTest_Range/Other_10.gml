/// @description Unit Testing
#region [Test: Construction: New constructor]
	
	var _base = [5, 10];
	
	constructor = new Range(_base[0], _base[1]);
	
	var _result = [constructor.minimum, constructor.maximum];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: New constructor",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Construction: Empty]
	
	constructor = new Range();
	
	var _result = [constructor.minimum, constructor.maximum];
	var _expectedValue = undefined;
	
	unitTest.assert_equal("Construction: Empty",
						  _result[0], _expectedValue,
						  _result[1], _expectedValue);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _base = [15.25, 25.99999991];
	
	constructor = [new Range(_base[0], _base[1])];
	constructor[1] = new Range(constructor[0]);
	
	var _result = [constructor[1].minimum, constructor[1].maximum];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: isFunctional()]
	
	var _base = [26, 34.9];
	
	constructor = [new Range(_base[0], _base[1]), new Range(_base[0], _base[1])];
	constructor[1].minimum = undefined;
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional()];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Method: isBetween()]
	
	var _base = [10, 35.999789991];
	
	constructor = new Range(_base[0], _base[1]);
	
	var _result = [constructor.isBetween(lerp(_base[0], _base[1], 0.5)),
				   constructor.isBetween(lerp(_base[0], _base[1], 1.2)),
				   constructor.isBetween(_base[0]),
				   constructor.isBetween(_base[1])];
	var _expectedValue = [true, false, true, true];
	
	unitTest.assert_equal("Method: isBetween()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Method: isBoundary()]
	
	var _base = [5, 59.67];
	
	constructor = new Range(_base[0], _base[1]);
	
	var _result = [constructor.isBoundary(lerp(_base[0], _base[1], 0.3567)),
				   constructor.isBoundary(lerp(_base[0], _base[1], 1.5)),
				   constructor.isBoundary(_base[0]),
				   constructor.isBoundary(_base[1])];
	var _expectedValue = [false, false, true, true];
	
	unitTest.assert_equal("Method: isBoundary()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Method: getMiddle()]
	
	var _base = [1, 2];
	
	constructor = new Range(_base[0], _base[1]);
	
	var _result = constructor.getMiddle();
	var _expectedValue = ((_base[0] + _base[1]) / array_length(_base));
	
	unitTest.assert_equal("Method: getMiddle()",
						  _result, _expectedValue);
	
#endregion
#region [Method: percent()]
	
	var _base = [254, 754];
	var _value = 0.25;
	
	constructor = new Range(_base[0], _base[1]);
	
	var _result = lerp(constructor.minimum, constructor.maximum, constructor.percent(_value));
	var _expectedValue = _value;
	
	unitTest.assert_equal("Method: percent()",
						  _result, _expectedValue);
	
#endregion
#region [Method: randomReal()]
	
	var _base = [25.25526, 25.76336];
	
	constructor = new Range(_base[0], _base[1]);
	
	var _result = constructor.randomReal();
	var _expectedValue = clamp(_result, _base[0], _base[1]);
	
	unitTest.assert_equal("Method: randomReal()",
						  _result, _expectedValue);
	
#endregion
#region [Method: randomInt()]
	
	var _base = [24, 26];
	
	constructor = new Range(_base[0], _base[1]);
	
	var _result = constructor.randomInt();
	var _expectedValue = [clamp(_result, _base[0], _base[1]), floor(_result)];
	
	unitTest.assert_equal("Method: randomInt()",
						  _result, _expectedValue[0],
						  _result, _expectedValue[1]);
	
#endregion
#region [Method: clampTo()]
	
	var _base = [156, 267.74749];
	
	constructor = new Range(_base[0], _base[1]);
	
	var _result = [constructor.clampTo(_base[0] - 2),
				   constructor.clampTo(_base[0] - 2.59),
				   constructor.clampTo(_base[1] + 3),
				   constructor.clampTo(_base[1] + 3.4567)];
	var _expectedValue = [_base[0], _base[0], _base[1], _base[1]];
	
	unitTest.assert_equal("Method: clampTo()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Method: interpolate()]
	
	var _base = [2, 4];
	var _value = 2;
	
	constructor = new Range(_base[0], _base[1]);
	
	var _result = constructor.interpolate(_value);
	var _expectedValue = (((_base[0] + _base[1]) / array_length(_base)) * _value);
	
	unitTest.assert_equal("Method: interpolate()",
						  _result, _expectedValue); 
	
#endregion
#region [Method: toString()]
	
	var _base = [-2590, -35];
	
	constructor = new Range(_base[0], _base[1]);
	
	var _result = [constructor.toString(false), constructor.toString(true)];
	var _expectedValue = [(constructorName + "(" + string(_base[0]) + " - " + string(_base[1]) + ")"),
						  (string(_base[0]) + "\n" + string(_base[1]))];
	
	unitTest.assert_equal("Method: toString(multiline?)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]); 
	
#endregion
#region [Method: toArray()]
	
	var _base = [24, 42];
	
	constructor = new Range(_base[0], _base[1]);
	
	var _result = constructor.toArray();
	var _expectedValue = _base;
	
	unitTest.assert_equal("Method: toArray()",
						  _result, _expectedValue);
	
#endregion
