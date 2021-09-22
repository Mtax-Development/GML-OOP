/// @description Unit Testing
#region [Test: Construction: Two values]
	
	var _base = [0.7, 0.9];
	
	constructor = new Scale(_base[0], _base[1]);
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: Two values",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Construction: One number for all values]
	
	var _base = 0.33;
	
	constructor = new Scale(_base);
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: One number for all values",
						  _result[0], _expectedValue,
						  _result[1], _expectedValue);
	
#endregion
#region [Test: Construction: Default value]
	
	constructor = new Scale();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = 1;
	
	unitTest.assert_equal("Construction: Default value",
						  _result[0], _expectedValue,
						  _result[1], _expectedValue);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _base = [0.5, 0.8745];
	
	constructor = [new Scale(_base[0], _base[1])];
	constructor[1] = new Scale(constructor[0]);
	
	var _result = [constructor[1].x, constructor[1].y];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: isFunctional()]
	
	var _base = [0.444, 1];
	
	constructor = [new Scale(_base[0], _base[1]), new Scale(_base[0], _base[1])];
	constructor[1].y = undefined;
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional()];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Methods: getMinimum() / getMaximum()]
	
	var _base = [-2, 2];
	
	constructor = new Scale(_base[0], _base[1]);
	
	var _result = [constructor.getMinimum(), constructor.getMaximum()];
	var _expectedValue = [_base[0], _base[1]];
	
	unitTest.assert_equal("Methods: getMinimum() / getMaximum()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: approach()]
	
	var _base = [0.5, 0.756];
	var _value = [[new Vector2(0.274, 1), new Vector2(0.1, 0.1)], [[0.4, 0.856], [0.3, 0.956],
				  [0.274, 1], [0.274, 1], [0.274, 1]]];
	
	constructor = new Scale(_base[0], _base[1]);
	
	var _result = [];
	var _expectedValue = [];
	
	var _i = 0;
	repeat (array_length(_value[1]))
	{
		constructor.approach(_value[0][0], _value[0][1]);
		
		array_push(_result, [constructor.x, constructor.y]);
		array_push(_expectedValue, _value[1][_i]);
		
		++_i;
	}
	
	unitTest.assert_equal("Method: approach()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: mirror()]
	
	var _base = [0.2, 0.545];
	
	constructor = new Scale(_base[0], _base[1]);
	constructor.mirror();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [-_base[0], -_base[1]];
	
	unitTest.assert_equal("Method: mirror()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: set()]
	
	var _value = 5;
	
	constructor = new Scale();
	constructor.set(_value);
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [_value, _value];
	
	unitTest.assert_equal("Method: set()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: toString()]
	
	var _base = 2;
	
	constructor = new Scale(_base);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName +
						 "(" +
						 "x: " + string(_base) + ", " +
						 "y: " + string(_base) +
						 ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
#endregion
