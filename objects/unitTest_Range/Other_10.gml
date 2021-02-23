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
#region [Method: middle()]
	
	var _base = [1, 2];
	
	constructor = new Range(_base[0], _base[1]);
	
	var _result = constructor.middle();
	var _expectedValue = ((_base[0] + _base[1]) / array_length(_base));
	
	unitTest.assert_equal("Method: middle()",
						  _result, _expectedValue);
	
#endregion
#region [Method: random_real()]
	
	var _base = [25.25526, 25.76336];
	
	constructor = new Range(_base[0], _base[1]);
	
	var _result = constructor.random_real();
	var _expectedValue = clamp(_result, _base[0], _base[1]);
	
	unitTest.assert_equal("Method: random_real()",
						  _result, _expectedValue);
	
#endregion
#region [Method: random_int()]
	
	var _base = [24, 26];
	
	constructor = new Range(_base[0], _base[1]);
	
	var _result = constructor.random_int();
	var _expectedValue = [clamp(_result, _base[0], _base[1]), floor(_result)];
	
	unitTest.assert_equal("Method: random_int()",
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
#region [String conversion]
	
	var _base = [35, 2590];
	
	constructor = new Range(_base[0], _base[1]);
	
	var _result = string(constructor);
	var _expectedValue = (constructorName + "(" + string(_base[0]) + "-" + string(_base[1]) + ")");
	
	unitTest.assert_equal("String conversion",
						  _result, _expectedValue); 
	
#endregion
