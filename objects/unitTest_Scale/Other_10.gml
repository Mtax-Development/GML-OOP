/// @description Unit Test

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
#region [Test: Method: mirror_x()]
	
	var _base = [0.25, 1];
	
	constructor = new Scale(_base[0], _base[1]);
	
	constructor.mirror_x();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [-_base[0], _base[1]];
	
	unitTest.assert_equal("Method: mirror_x()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: mirror_y()]
	
	var _base = [2, 0.25];
	
	constructor = new Scale(_base[0], _base[1]);
	
	constructor.mirror_y();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [_base[0], -_base[1]];
	
	unitTest.assert_equal("Method: mirror_y()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: String conversion]
	
	var _base = 2;
	
	constructor = new Scale(_base);
	
	var _result = string(constructor);
	var _expectedValue = (constructorName +
						 "(" +
						 "x: " + string(_base) + ", " +
						 "y: " + string(_base) +
						 ")");
	
	unitTest.assert_equal("String conversion",
						  _result, _expectedValue);
	
#endregion
