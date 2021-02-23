/// @description Unit Testing
#region [Test: Construction: Two values]
	
	var _base = [-5, 15346.63];
	
	constructor = new Vector2(_base[0], _base[1]);
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: Two values",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Construction: One number for all values]
	
	var _base = 5;
	
	constructor = new Vector2(_base);
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: One number for all values",
						  _result[0], _expectedValue,
						  _result[1], _expectedValue);
	
#endregion
#region [Test: Construction: Default for all values]

	constructor = new Vector2();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = 0;
	
	unitTest.assert_equal("Construction: Default for all values",
						  _result[0], _expectedValue,
						  _result[1], _expectedValue);
#endregion
#region [Test: Construction: From array]
	
	var _base = [154536.355535, 25];
	
	constructor = new Vector2(_base);
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: From array",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _base = [15, 51];
	
	constructor = [new Vector2(_base[0], _base[1])];
	constructor[1] = new Vector2(constructor[0]);
	
	var _result = [constructor[1].x, constructor[1].y];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: isFunctional()]
	
	constructor = [new Vector2(), new Vector2()];
	constructor[1].y = undefined;
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional()];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: add(real)]

	var _base = [35, 125.56];
	var _value = 5.76;
	
	constructor = new Vector2(_base[0], _base[1]);
	
	constructor.add(_value);
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [(_base[0] + _value), (_base[1] + _value)];
	
	unitTest.assert_equal("Method: add(real)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: add(Vector2)]

	var _base = [[35, 125.56], [11, 20.59]];
	
	constructor = [new Vector2(_base[0][0], _base[0][1]), 
				   new Vector2(_base[1][0], _base[1][1])];
	
	constructor[0].add(constructor[1]);
	
	var _result = [constructor[0].x, constructor[0].y];
	var _expectedValue = [(_base[0][0] + _base[1][0]), (_base[0][1] + _base[1][1])];
	
	unitTest.assert_equal("Method: add(Vector2)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: substract(real)]

	var _base = [145, 36.58];
	var _value = 5.76;
	
	constructor = new Vector2(_base[0], _base[1]);
	
	constructor.substract(_value);
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [(_base[0] - _value), (_base[1] - _value)];
	
	unitTest.assert_equal("Method: substract(real)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: substract(Vector2)]

	var _base = [[325, 164365.56], [13651, 23.46]];
	
	constructor = [new Vector2(_base[0][0], _base[0][1]), 
				   new Vector2(_base[1][0], _base[1][1])];
	
	constructor[0].substract(constructor[1]);
	
	var _result = [constructor[0].x, constructor[0].y];
	var _expectedValue = [(_base[0][0] - _base[1][0]), (_base[0][1] - _base[1][1])];
	
	unitTest.assert_equal("Method: substract(Vector2)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: multiply(real)]

	var _base = [10, 25.5];
	var _value = 4.2;
	
	constructor = new Vector2(_base[0], _base[1]);
	
	constructor.multiply(_value);
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [(_base[0] * _value), (_base[1] * _value)];
	
	unitTest.assert_equal("Method: multiply(real)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: multiply(Vector2)]

	var _base = [[35, -365.00955], [135, -9]];
	
	constructor = [new Vector2(_base[0][0], _base[0][1]), 
				   new Vector2(_base[1][0], _base[1][1])];
	
	constructor[0].multiply(constructor[1]);
	
	var _result = [constructor[0].x, constructor[0].y];
	var _expectedValue = [(_base[0][0] * _base[1][0]), (_base[0][1] * _base[1][1])];
	
	unitTest.assert_equal("Method: multiply(Vector2)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: divide(real)]

	var _base = [55, 100];
	var _value = 3.5;
	
	constructor = new Vector2(_base[0], _base[1]);
	
	constructor.divide(_value);
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [(_base[0] / _value), (_base[1] / _value)];
	
	unitTest.assert_equal("Method: divide(real)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: divide(Vector2)]

	var _base = [[35, -65.025], [953, 44]];
	
	constructor = [new Vector2(_base[0][0], _base[0][1]), 
				   new Vector2(_base[1][0], _base[1][1])];
	
	constructor[0].divide(constructor[1]);
	
	var _result = [constructor[0].x, constructor[0].y];
	var _expectedValue = [(_base[0][0] / _base[1][0]), (_base[0][1] / _base[1][1])];
	
	unitTest.assert_equal("Method: divide(Vector2)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: flip()]

	var _base = [245, 999.59];
	
	constructor = new Vector2(_base[0], _base[1]);
	
	constructor.flip();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [_base[1], _base[0]];
	
	unitTest.assert_equal("Method: flip()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: equals()]

	var _base = [0.567, 1212.1212];
	
	constructor = [new Vector2(_base[0], _base[1])];
	constructor[1] = new Vector2(constructor[0]);
	constructor[2] = new Vector2(-_base[0], -_base[1]);
	
	var _result = [constructor[0].equals(constructor[1]), constructor[0].equals(constructor[2])];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: equals()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: String conversion]
	
	var _base = [5, 10];
	
	constructor = new Vector2(_base[0], _base[1]);
	
	var _result = string(constructor);
	var _expectedValue = (constructorName + 
						  "(" +
						  "x: " + string(_base[0]) + ", " +
						  "y: " + string(_base[1]) +
						  ")");
	
	unitTest.assert_equal("String conversion",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(multiline)]
	
	var _base = [75, 12];
	
	constructor = new Vector2(_base[0], _base[1]);
	
	var _result = constructor.toString(true)
	var _expectedValue = ("x: " + string(_base[0]) + "\n" +
						  "y: " + string(_base[1]));
	
	unitTest.assert_equal("Method: toString(multiline)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toArray]
	
	var _base = [25.3553, 936];
	
	constructor = new Vector2(_base[0], _base[1]);
	
	var _result = constructor.toArray();
	var _expectedValue = _base;
	
	unitTest.assert_equal("Method: toArray()",
						  _result, _expectedValue);
	
#endregion
