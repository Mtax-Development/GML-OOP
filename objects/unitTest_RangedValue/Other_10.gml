/// @description Unit Testing
#region [Test: Construction: Specified value]
	
	var _base = [5, 10];
	var _value = lerp(_base[0], _base[1], 0.5);
	
	constructor = new RangedValue(new Range(_base[0], _base[1]), _value);
	
	var _result = [constructor.value, constructor.range.minimum, constructor.range.maximum,];
	var _expectedValue = [_value, _base[0], _base[1]];
	
	unitTest.assert_equal("Construction: Specified value",
						   _result[0], _expectedValue[0],
						   _result[1], _expectedValue[1],
						   _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Construction: Default value]
	
	var _base = [2.72, 10.72];
	
	constructor = new RangedValue(new Range(_base[0], _base[1]));
	
	var _result = [constructor.value, constructor.range.minimum, constructor.range.maximum,];
	var _expectedValue = [_base[0], _base[0], _base[1]];
	
	unitTest.assert_equal("Construction: Default value",
						   _result[0], _expectedValue[0],
						   _result[1], _expectedValue[1],
						   _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _base = [2.72, 10.72];
	
	constructor = [new RangedValue(new Range(_base[0], _base[1]))];
	constructor[1] = new RangedValue(constructor[0]);
	
	var _result = [constructor[1].value, constructor[1].range.minimum, constructor[1].range.maximum];
	var _expectedValue = [_base[0], _base[0], _base[1]];
	
	unitTest.assert_equal("Construction: Constructor copy",
						   _result[0], _expectedValue[0],
						   _result[1], _expectedValue[1],
						   _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: isFunctional()]
	
	var _base = [24.25, 35];
	
	constructor = [new RangedValue(new Range(_base[0], _base[1])),
				   new RangedValue(new Range(_base[0], _base[1])),
				   new RangedValue(new Range(_base[0], _base[1]))];
	constructor[1].value = undefined;
	constructor[2].range.minimum = undefined;
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional(),
				   constructor[2].isFunctional()];
	var _expectedValue = [true, false, false];
	
	unitTest.assert_equal("Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Method: isBoundary()]
	
	var _base = [73, 126.52];
	
	constructor = [new RangedValue(new Range(_base[0], _base[1])),
				   new RangedValue(new Range(_base[0], _base[1]), lerp(_base[0], _base[1], 0.5))];
	
	var _result = [constructor[0].isBoundary(), constructor[1].isBoundary()];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: isBoundary()",
						   _result[0], _expectedValue[0],
						   _result[1], _expectedValue[1]);
	
#endregion
#region [Method: set()]
	
	var _base = [15, 25];
	var _value = (_base[1] + 2);
	
	constructor = new RangedValue(new Range(_base[0], _base[1]));
	
	constructor.set(_value);
	
	var _result = constructor.value;
	var _expectedValue = _base[1];
	
	unitTest.assert_equal("Method: set()",
						  _result, _expectedValue);
	
#endregion
#region [Methods: setMinimum() / isMinimum()]
	
	var _base = [12, 22];
	var _value = mean(_base[0], _base[1]);
	
	constructor = new RangedValue(new Range(_base[0], _base[1]), _value);
	
	var _result = [constructor.value, constructor.isMinimum()];
	var _expectedValue = [_value, false];
	
	constructor.setMinimum();
	
	array_push(_result, constructor.value, constructor.isMinimum());
	array_push(_expectedValue, _base[0], true);
	
	unitTest.assert_equal("Methods: setMinimum() / isMinimum()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Methods: setMaximum() / isMaximum()]
	
	var _base = [30, 35];
	var _value = mean(_base[0], _base[1]);
	
	constructor = new RangedValue(new Range(_base[0], _base[1]), _value);
	
	var _result = [constructor.value, constructor.isMaximum()];
	var _expectedValue = [_value, false];
	
	constructor.setMaximum();
	
	array_push(_result, constructor.value, constructor.isMaximum());
	array_push(_expectedValue, _base[1], true);
	
	unitTest.assert_equal("Methods: setMaximum() / isMaximum()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Method: setOriginal()]
	
	var _base = [10, 15];
	
	
	constructor = new RangedValue(new Range(_base[0], _base[1]));
	constructor.set(lerp(_base[0], _base[1], 0.5));
	constructor.setOriginal();
	
	var _result = constructor.value;
	var _expectedValue = _base[0];
	
	unitTest.assert_equal("Method: setOriginal()",
						  _result, _expectedValue);
	
#endregion
#region [Method: setMiddle()]
	
	var _base = [40, 45];
	
	constructor = new RangedValue(new Range(_base[0], _base[1]));
	constructor.setMiddle();
	
	var _result = constructor.value;
	var _expectedValue = lerp(_base[0], _base[1], 0.5);
	
	unitTest.assert_equal("Method: setMiddle()",
						  _result, _expectedValue);
	
#endregion
#region [Method: modify()]
	
	var _base = [10, 23];
	var _value = 3.567;
	
	constructor = new RangedValue(new Range(_base[0], _base[1]));
	constructor.modify(_value);
	
	var _result = constructor.value;
	var _expectedValue = (_base[0] + _value);
	
	unitTest.assert_equal("Method: modify()",
						  _result, _expectedValue);
	
#endregion
#region [Method: modifyWrap(positive value)]
	
	var _base = [12, 13];
	var _value = 2.5;
	
	constructor = new RangedValue(new Range(_base[0], _base[1]));
	constructor.modifyWrap(_value);
	
	var _result = constructor.value;
	var _expectedValue = 12.5;
	
	unitTest.assert_equal("Method: modifyWrap(positive value)",
						  _result, _expectedValue);
	
#endregion
#region [Method: modifyWrap(negative value)]
	
	var _base = [12, 15];
	var _value = -2.19;
	
	constructor = new RangedValue(new Range(_base[0], _base[1]));
	constructor.modifyWrap(_value);
	
	var _result = constructor.value;
	var _expectedValue = (_base[1] - abs(_value));
	
	unitTest.assert_equal("Method: modifyWrap(negative value)",
						  _result, _expectedValue);
	
#endregion
#region [Method: modifyWrap(0)]
	
	var _base = [14.56, 14.57];
	var _value = 0;
	
	constructor = new RangedValue(new Range(_base[0], _base[1]));
	constructor.modifyWrap(_value);
	
	var _result = constructor.value;
	var _expectedValue = _base[0];
	
	unitTest.assert_equal("Method: modifyWrap(0)",
						  _result, _expectedValue);
	
#endregion
#region [Method: modifyWrap(inclusive)]
	
	var _base = [[1, 10]];
	_base[1] = lerp(_base[0][0], _base[0][1], 0.5);
	var _value = [(-(_base[1] - _base[0][0])), (_base[0][1] - _base[1])];
	
	constructor = [new RangedValue(new Range(_base[0][0], _base[0][1]), _base[1])];
	constructor[1] = new RangedValue(constructor[0]);
	constructor[0].modifyWrap(_value[0], true);
	constructor[1].modifyWrap(_value[1], true);
	
	var _result = [constructor[0].value, constructor[1].value];
	var _expectedValue = _base[0];
	
	unitTest.assert_equal("Method: modifyWrap(inclusive)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Method: modifyBounce()]
	
	var _base = [[-5.5, 5], [0]];
	var _value = [[3, 4, -6, 8.5, -11, 19, 38, 64, 0.5, 0, 1, -20],
				  [3, 3, -3, 4.5, -4.5, -4.5, -2.5, -1.5, -1, -1, 0, 1]];
	
	constructor = new RangedValue(new Range(_base[0][0], _base[0][1]), _base[1][0]);
	
	var _result = [];
	var _expectedValue = [];
	
	var _i = 0;
	repeat (array_length(_value[0]))
	{
		constructor.modifyBounce(_value[0][_i]);
		
		array_push(_result, constructor.value);
		array_push(_expectedValue, _value[1][_i]);
		
		++_i;
	}
	
	unitTest.assert_equal("Method: modifyBounce()",
						  _result, _expectedValue);
	
#endregion
#region [Method: interpolate()]
	
	var _base = [10, 11];
	var _value = 0.2355;
	
	constructor = new RangedValue(new Range(_base[0], _base[1]));
	constructor.interpolate(_value);
	
	var _result = constructor.value;
	var _expectedValue = lerp(_base[0], _base[1], _value);
	
	unitTest.assert_equal("Method: interpolate()",
						  _result, _expectedValue);
	
#endregion
#region [Method: equals()]
	
	var _base = [1, 5];
	
	constructor = [new RangedValue(new Range(_base[0], _base[1]))];
	constructor[1] = new RangedValue(constructor[0]);
	
	var _result = [constructor[0].equals(constructor[1])];
	var _expectedValue = [true];
	
	constructor[1].modify(mean(_base[0], _base[1]));
	
	array_push(_result, constructor[0].equals(constructor[1]));
	array_push(_expectedValue, false);
	
	unitTest.assert_equal("Method: equals()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Method: percent()]
	
	var _base = [0, 10];
	
	constructor = new RangedValue(new Range(_base[0], _base[1]));
	
	var _result = [];
	var _expectedValue = [];
	
	var _i = 0;
	repeat (10)
	{
		array_push(_result, constructor.percent());
		array_push(_expectedValue, (_i / 10));
		
		constructor.modify(1);
		
		++_i;
	}
	
	unitTest.assert_equal("Method: percent()",
						  _result, _expectedValue);
	
#endregion
#region [Method: toString(multiline?)]
	
	var _base = [-10, -5];
	
	constructor = new RangedValue(new Range(_base[0], _base[1]));
	
	var _result = [constructor.toString(false), constructor.toString(true)];
	var _expectedValue = [(constructorName + "(" +  string(_base[0]) + ", " + string(_base[0]) +
						   " - " + string(_base[1]) + ")"), string(_base[0]) + "\n" +
						   string(_base[0]) + " - " + string(_base[1])];
	
	unitTest.assert_equal("Method: toString(multiline?)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
