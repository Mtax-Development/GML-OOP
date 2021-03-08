/// @description Unit Testing
#region [Test: Construction: Four values]
	
	var _base = [25, 26, 115.5, 535];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: Four values",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Construction: One number for all values]
	
	var _base = 74.44;
	
	constructor = new Vector4(_base);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: One number for all values",
						  _result[0], _expectedValue,
						  _result[1], _expectedValue,
						  _result[2], _expectedValue,
						  _result[3], _expectedValue);
	
#endregion
#region [Test: Construction: One number pair]
	
	var _base = [24, 15];
	
	constructor = new Vector4(_base[0], _base[1]);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [_base[0], _base[0], _base[1], _base[1]];
	
	unitTest.assert_equal("Construction: One number pair",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Construction: Default for all values]
	
	constructor = new Vector4();
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = 0;
	
	unitTest.assert_equal("Construction: Default for all values",
						  _result[0], _expectedValue,
						  _result[1], _expectedValue,
						  _result[2], _expectedValue,
						  _result[3], _expectedValue);
	
#endregion
#region [Test: Construction: From array]
	
	var _base = [25.67, 35, 56, 78];
	
	constructor = new Vector4(_base);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: From array",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Construction: From two Vector2]
	
	var _base = [new Vector2(15, 50), new Vector2(1, 2)];
	
	constructor = new Vector4(_base[0], _base[1]);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [_base[0].x, _base[0].y, _base[1].x, _base[1].y];
	
	unitTest.assert_equal("Construction: From two Vector2",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _base = [2, 3, 4, 5];
	
	constructor = [new Vector4(_base[0], _base[1], _base[2], _base[3])];
	constructor[1] = new Vector4(constructor[0]);
	
	var _result = [constructor[1].x1, constructor[1].y1, constructor[1].x2, constructor[1].y2];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: isFunctional()]
	
	constructor = [new Vector4(), new Vector4()];
	constructor[1].y1 = undefined;
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional()];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: add(real)]
	
	var _base = [25, 63, 53.6, 634.674];
	var _value = 49;
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	constructor.add(_value);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [(_base[0] + _value), (_base[1] + _value), (_base[2] + _value),
						  (_base[3] + _value)];
	
	unitTest.assert_equal("Method: add(real)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: add(Vector2)]
	
	var _base = [253, 6265, 57474, 11];
	var _value = new Vector2(5, 7);
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	constructor.add(_value);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [(_base[0] + _value.x), (_base[1] + _value.y), (_base[2] + _value.x),
						  (_base[3] + _value.y)];
	
	unitTest.assert_equal("Method: add(Vector2)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: add(Vector4)]
	
	var _base = [25, 63, 53.6, 634.674];
	var _value = new Vector4(56, 36.50, 520, 63);
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	constructor.add(_value);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [(_base[0] + _value.x1), (_base[1] + _value.y1), (_base[2] + _value.x2),
						  (_base[3] + _value.y2)];
	
	unitTest.assert_equal("Method: add(Vector4)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: substract(real)]
	
	var _base = [25, 143, 2556, 2567.29];
	var _value = 24;
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	constructor.substract(_value);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [(_base[0] - _value), (_base[1] - _value), (_base[2] - _value),
						  (_base[3] - _value)];
	
	unitTest.assert_equal("Method: substract(real)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: substract(Vector2)]
	
	var _base = [1, 625365, -4523, -2509];
	var _value = new Vector2(15, 75);
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	constructor.substract(_value);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [(_base[0] - _value.x), (_base[1] - _value.y), (_base[2] - _value.x),
						  (_base[3] - _value.y)];
	
	unitTest.assert_equal("Method: substract(Vector2)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: substract(Vector4)]
	
	var _base = [0, 63, 53.6, 634.674];
	var _value = new Vector4(5625, 336.50, 14, 155);
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	constructor.substract(_value);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [(_base[0] - _value.x1), (_base[1] - _value.y1), (_base[2] - _value.x2),
						  (_base[3] - _value.y2)];
	
	unitTest.assert_equal("Method: substract(Vector4)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: multiply(real)]
	
	var _base = [144, 24, 25.54, 1.29];
	var _value = 100;
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	constructor.multiply(_value);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [(_base[0] * _value), (_base[1] * _value), (_base[2] * _value),
						  (_base[3] * _value)];
	
	unitTest.assert_equal("Method: multiply(real)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: multiply(Vector2)]
	
	var _base = [1, 6, 443, -499];
	var _value = new Vector2(12, 5);
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	constructor.multiply(_value);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [(_base[0] * _value.x), (_base[1] * _value.y), (_base[2] * _value.x),
						  (_base[3] * _value.y)];
	
	unitTest.assert_equal("Method: multiply(Vector2)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: multiply(Vector4)]
	
	var _base = [1, 24, 3.6, 4.674];
	var _value = new Vector4(55, 6, 4, 5);
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	constructor.multiply(_value);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [(_base[0] * _value.x1), (_base[1] * _value.y1), (_base[2] * _value.x2),
						  (_base[3] * _value.y2)];
	
	unitTest.assert_equal("Method: multiply(Vector4)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: divide(real)]
	
	var _base = [25, 21, 9, 2.29];
	var _value = 10;
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	constructor.divide(_value);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [(_base[0] / _value), (_base[1] / _value), (_base[2] / _value),
						  (_base[3] / _value)];
	
	unitTest.assert_equal("Method: divide(real)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: divide(Vector2)]
	
	var _base = [6, -3, -4.43, 22];
	var _value = new Vector2(120, 4);
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	constructor.divide(_value);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [(_base[0] / _value.x), (_base[1] / _value.y), (_base[2] / _value.x),
						  (_base[3] / _value.y)];
	
	unitTest.assert_equal("Method: divide(Vector2)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: divide(Vector4)]
	
	var _base = [10, 240, -35, 67.4];
	var _value = new Vector4(25, 1.5, 2, 4);
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	constructor.divide(_value);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [(_base[0] / _value.x1), (_base[1] / _value.y1), (_base[2] / _value.x2),
						  (_base[3] / _value.y2)];
	
	unitTest.assert_equal("Method: divide(Vector4)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: flip()]
	
	var _base = [120, 240, 360, 480];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	constructor.flip();
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [_base[1], _base[0], _base[3], _base[2]];
	
	unitTest.assert_equal("Method: flip()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: getMiddle()]
	
	var _base = [5, 10, 15, 20];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.getMiddle();
	var _expectedValue = new Vector2(((_base[0] + _base[2]) / 2), ((_base[1] + _base[3]) / 2));
	
	unitTest.assert_equal("Method: getMiddle()",
						  _result.x, _expectedValue.x,
						  _result.y, _expectedValue.y);
	
#endregion
#region [Test: Method: getMiddle_x()]
	
	var _base = [52, 1000, 150000, 200000];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.getMiddle_x();
	var _expectedValue = ((_base[0] + _base[2]) / 2);
	
	unitTest.assert_equal("Method: getMiddle_x()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getMiddle_x()]
	
	var _base = [53, 1010, 150100, 200100];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.getMiddle_y();
	var _expectedValue = ((_base[1] + _base[3]) / 2);
	
	unitTest.assert_equal("Method: getMiddle_y()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getDistance()]
	
	var _base = [530, 1011, 152100, 204105];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.getDistance();
	var _expectedValue = point_distance(_base[0], _base[1], _base[2], _base[3]);
	
	unitTest.assert_equal("Method: getMiddle_y()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getAngle_1to2()]
	
	var _base = [53, 111, 1100, 2105];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.getAngle_1to2();
	var _expectedValue = point_direction(_base[0], _base[1], _base[2], _base[3]);
	
	unitTest.assert_equal("Method: getAngle_1to2()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getAngle_2to1()]
	
	var _base = [3, 11, 110, 105];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.getAngle_2to1();
	var _expectedValue = point_direction(_base[2], _base[3], _base[0], _base[1]);
	
	unitTest.assert_equal("Method: getAngle_2to1()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: equals()]
	
	var _base = [5, 16, 1220, 24];
	
	constructor = [new Vector4(_base[0], _base[1], _base[2], _base[3])];
	constructor[1] = new Vector4(constructor[0]);
	constructor[2] = new Vector4(-_base[0], -_base[1], -_base[2], -_base[3])
	
	var _result = [constructor[0].equals(constructor[1]), constructor[0].equals(constructor[2])];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: equals()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: interpolate()]
	
	var _base = [1, 11, 22, 333];
	var _value = 0.3;
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.interpolate(_value, _value);
	var _expectedValue = new Vector2(lerp(_base[0], _base[2], _value), 
									 lerp(_base[1], _base[3], _value));
	
	unitTest.assert_equal("Method: interpolate()",
						  _result.x, _expectedValue.x,
						  _result.y, _expectedValue.y);
	
#endregion
#region [Test: Method: interpolate_x()]
	
	var _base = [52, 62, 72, 82];
	var _value = 0.111;
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.interpolate_x(_value);
	var _expectedValue = lerp(_base[0], _base[2], _value);
	
	unitTest.assert_equal("Method: interpolate_x()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: interpolate_y()]
	
	var _base = [902, 1002, 1102, 1202];
	var _value = 0.968;
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.interpolate_y(_value);
	var _expectedValue = lerp(_base[1], _base[3], _value);
	
	unitTest.assert_equal("Method: interpolate_y()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: isBetween()]
	
	var _base = [502, 602, 702, 802];
	var _value = [new Vector2(lerp(_base[0], _base[2], 0.3), lerp(_base[1], _base[3], 0.11)),
				  new Vector2((_base[0] + 1), (_base[1] - 1))];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = [constructor.isBetween(_value[0]), constructor.isBetween(_value[1])];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: isBetween()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: String conversion]
	
	var _base = [5, 6, 7, 8];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = string(constructor);
	var _expectedValue = (constructorName +
						  "(" +
						  "x1: " + string(_base[0]) + ", " +
						  "y1: " + string(_base[1]) + ", " +
						  "x2: " + string(_base[2]) + ", " +
						  "y2: " + string(_base[3]) +
						  ")");
	
	unitTest.assert_equal("String conversion",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(multiline)]
	
	var _base = [50, 60, 70, 80];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.toString(true);
	var _expectedValue = ("x1: " + string(_base[0]) + "\n" +
						  "y1: " + string(_base[1]) + "\n" +
						  "x2: " + string(_base[2]) + "\n" +
						  "y2: " + string(_base[3]));
	
	unitTest.assert_equal("Method: toString(multiline)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toArray()]
	
	var _base = [502, 622, -70, 44];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.toArray();
	var _expectedValue = _base;
	
	unitTest.assert_equal("Method: toArray()",
						  _result, _expectedValue);
	
#endregion
