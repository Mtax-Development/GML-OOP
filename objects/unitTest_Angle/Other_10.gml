/// @description Unit Testing
#region [Test: Construction: Default value]
	
	constructor = new Angle();
	
	var _result = constructor.value;
	var _expectedValue = 0;
	
	unitTest.assert_equal("Construction: Default Value", 
						  _result, _expectedValue);
	
#endregion
#region [Test: Construction: Specified value]
	
	var _base = 105;
	
	constructor = new Angle(_base);
	
	var _result = constructor.value;
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: Specified Value", 
						  _result, _expectedValue);
	
#endregion
#region [Test: Construction: Positive value wrapping]
	
	var _base = 370;
	
	constructor = new Angle(_base);
	
	var _result = constructor.value;
	var _expectedValue = (_base - 360);
	
	unitTest.assert_equal("Construction: Positive value wrapping", 
						  _result, _expectedValue);
	
#endregion
#region [Test: Construction: Negative value wrapping]
	
	var _base = -10;
	
	constructor = new Angle(_base);
	
	var _result = constructor.value;
	var _expectedValue = (360 + _base);
	
	unitTest.assert_equal("Construction: Negative value wrapping", 
						  _result, _expectedValue);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _value = 55;
	
	constructor = [new Angle()];
	constructor[0].modify(_value);
	constructor[1] = new Angle(constructor[0])
	
	var _result = constructor[0].value;
	var _expectedValue = constructor[1].value;
	
	unitTest.assert_equal("Construction: Constructor Copy", 
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: isFunctional()]
	
	constructor = [new Angle(), new Angle()];
	constructor[1].value = undefined;
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional()];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: modify()]
	
	var _value = 105;
	
	constructor = new Angle(0);
	
	constructor.modify(_value);
	
	var _result = constructor.value;
	var _expectedValue = _value;
	
	unitTest.assert_equal("Method: modify()", 
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: difference(positive value)]
	
	var _base = [20, 270];
	
	constructor = [new Angle(_base[0]), new Angle(_base[1])];
	
	var _result = constructor[0].difference(constructor[1]);
	var _expectedValue = (360 - _base[1] + _base[0]);
	
	unitTest.assert_equal("Method: difference(positive value)", 
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: difference(negative value)]
	
	var _base = [-15, 70];
	
	constructor = [new Angle(_base[0]), new Angle(_base[1])];
	
	var _result = [constructor[0].difference(constructor[1]),
				   constructor[1].difference(constructor[0])];
	var _expectedValue = (max(_base[0], _base[1]) - min(_base[0], _base[1]));
	
	unitTest.assert_equal("Method: difference(negative value)", 
						  _result[0], _expectedValue,
						  _result[1], _expectedValue);
	
#endregion
#region [Test: String conversion]
	
	var _base = 99;
	
	constructor = new Angle(_base);
	
	var _result = string(constructor);
	var _expectedValue = (constructorName + "(" + string(_base) + ")");
	
	unitTest.assert_equal("String conversion", 
						  _result, _expectedValue);
	
#endregion
