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
	var _expectedValue = [_base, _base, _base, _base];
	
	unitTest.assert_equal("Construction: One number for all values",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
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
#region [Test: Construction: Empty]
	
	constructor = new Vector4();
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [undefined, undefined, undefined, undefined];
	
	unitTest.assert_equal("Construction: Empty",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Construction: From array]
	
	var _base = [25.67, 35, 56, 78];
	
	constructor = new Vector4(_base);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [_base[0], _base[1], _base[2], _base[3]];
	
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
	var _expectedValue = [_base[0], _base[1], _base[2], _base[3]];
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: isFunctional()]
	
	var _base = [2, 4, 6, 8];
	
	constructor = [new Vector4(_base[0], _base[1], _base[2], _base[3]),
				   new Vector4(_base[0], _base[1], _base[2], _base[3]),
				   new Vector4()];
	constructor[1].y1 = undefined;
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional(),
				   constructor[2].isFunctional()];
	var _expectedValue = [true, false, false];
	
	unitTest.assert_equal("Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
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
#region [Test: Method: sum()]
	
	var _base = [17, 71, 678, 423];
	var _element = new Vector2((_base[0] + _base[2]), (_base[1] + _base[3]));
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.sum();
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: sum()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: sum(Vector4)]
	
	var _base = [11, 22, 33, 44, 55, 66, 77, 88];
	var _element = new Vector4((_base[0] + _base[4]), (_base[1] + _base[5]), (_base[2] + _base[6]), 
							   (_base[3] + _base[7]));
	
	constructor = [new Vector4(_base[0], _base[1], _base[2], _base[3]),
				   new Vector4(_base[4], _base[5], _base[6], _base[7])];
	
	var _result = constructor[0].sum(constructor[1]);
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: sum(Vector4)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: sumX()]
	
	var _base = [24, 42, 67, 89];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.sumX();
	var _expectedValue = (_base[0] + _base[2]);
	
	unitTest.assert_equal("Method: sumX()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: sumX(Vector2)]
	
	var _base = [25, 2, 3, 44, 33.3, 99.9];
	var _element = new Vector2(_base[4], _base[5]);
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.sumX(_element);
	var _expectedValue = [(_base[0] + _base[4]), (_base[2] + _base[4])];
	
	unitTest.assert_equal("Method: sumX(Vector2)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: sumX(Vector4)]
	
	var _base = [25, 52, 673, 45, 9.2, 6.7, 4.31, 9.54];
	
	constructor = [new Vector4(_base[0], _base[1], _base[2], _base[3]),
				   new Vector4(_base[4], _base[5], _base[6], _base[7])];
	
	var _result = constructor[0].sumX(constructor[1]);
	var _expectedValue = [(_base[0] + _base[4]), (_base[2] + _base[6])];
	
	unitTest.assert_equal("Method: sumX(Vector4)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: sumY()]
	
	var _base = [54, 46, 37, 59];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.sumY();
	var _expectedValue = (_base[1] + _base[3]);
	
	unitTest.assert_equal("Method: sumY()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: sumY(Vector2)]
	
	var _base = [25, 50, 75, 100, 11.1, 22.2];
	var _element = new Vector2(_base[4], _base[5]);
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]); 
	
	var _result = constructor.sumY(_element);
	var _expectedValue = [(_base[1] + _base[5]), (_base[3] + _base[5])];
	
	unitTest.assert_equal("Method: sumY(Vector2)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: sumY(Vector4)]
	
	var _base = [15, 30, 40, 80, 14.2, 25.6, 60.23, 53.4];
	
	constructor = [new Vector4(_base[0], _base[1], _base[2], _base[3]),
				   new Vector4(_base[4], _base[5], _base[6], _base[7])];
	
	var _result = constructor[0].sumY(constructor[1]);
	var _expectedValue = [(_base[1] + _base[5]), (_base[3] + _base[7])];
	
	unitTest.assert_equal("Method: sumY(Vector4)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: difference()]
	
	var _base = [52, -29, 25, -5];
	var _element = new Vector2(abs(_base[0] - _base[2]), abs(_base[1] - _base[3]));
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.difference();
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: difference()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: difference(Vector4)]
	
	var _base = [53, -53, 20, 195, 502, 530, 20, 10];
	var _element = new Vector4(abs(_base[0] - _base[4]), abs(_base[1] - _base[5]),
							   abs(_base[2] - _base[6]), abs(_base[3] - _base[7]));
	
	constructor = [new Vector4(_base[0], _base[1], _base[2], _base[3]),
				   new Vector4(_base[4], _base[5], _base[6], _base[7])];
	
	var _result = constructor[0].difference(constructor[1]);
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: difference(Vector4)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: differenceX()]
	
	var _base = [52, -11, 5, 4];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.differenceX();
	var _expectedValue = abs(_base[0] - _base[2]);
	
	unitTest.assert_equal("Method: differenceX()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: differenceX(Vector2)]
	
	var _base = [52, -521, 240, 59, 10.5, 95.6];
	var _element = new Vector2(_base[4], _base[5]);
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.differenceX(_element);
	var _expectedValue = [abs(_base[0] - _base[4]), abs(_base[2] - _base[4])];
	
	unitTest.assert_equal("Method: differenceX(Vector2)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: differenceX(Vector4)]
	
	var _base = [42, -52, 65, 21, -9.99, -52.5, -5, -4.1];
	
	constructor = [new Vector4(_base[0], _base[1], _base[2], _base[3]),
				   new Vector4(_base[4], _base[5], _base[6], _base[7])];
	
	var _result = constructor[0].differenceX(constructor[1]);
	var _expectedValue = [abs(_base[0] - _base[4]), abs(_base[2] - _base[6])];
	
	unitTest.assert_equal("Method: differenceX(Vector4)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: differenceY()]
	
	var _base = [22, -51, 1, 2];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.differenceY();
	var _expectedValue = abs(_base[1] - _base[3]);
	
	unitTest.assert_equal("Method: differenceY()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: differenceX(Vector2)]
	
	var _base = [52, -221, 255, 12, 12.5, 95.6];
	var _element = new Vector2(_base[4], _base[5]);
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.differenceY(_element);
	var _expectedValue = [abs(_base[1] - _base[5]), abs(_base[3] - _base[5])];
	
	unitTest.assert_equal("Method: differenceY(Vector2)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: differenceY(Vector4)]
	
	var _base = [22, -12, 675, 3, -9.3, -12.5, -2, -4.5];
	
	constructor = [new Vector4(_base[0], _base[1], _base[2], _base[3]),
				   new Vector4(_base[4], _base[5], _base[6], _base[7])];
	
	var _result = constructor[0].differenceY(constructor[1]);
	var _expectedValue = [abs(_base[1] - _base[5]), abs(_base[3] - _base[7])];
	
	unitTest.assert_equal("Method: differenceY(Vector4)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: product()]
	
	var _base = [1.411, 50, 10, -2.5];
	var _element = new Vector2((_base[0] * _base[2]), (_base[1] * _base[3]));
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.product();
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: product()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: product(Vector4)]
	
	var _base = [25, 75, 125, 225, 8, 6, 4, 2];
	var _element = new Vector4((_base[0] * _base[4]), (_base[1] * _base[5]), (_base[2] * _base[6]), 
							   (_base[3] * _base[7]));
	
	constructor = [new Vector4(_base[0], _base[1], _base[2], _base[3]),
				   new Vector4(_base[4], _base[5], _base[6], _base[7])];
	
	var _result = constructor[0].product(constructor[1]);
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: product(Vector4)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: productX()]
	
	var _base = [25, 55, 10, 20];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.productX();
	var _expectedValue = (_base[0] * _base[2]);
	
	unitTest.assert_equal("Method: productX()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: productX(Vector2)]
	
	var _base = [52, -52, 1.5, 52, 99, 11];
	var _element = new Vector2(_base[4], _base[5]);
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.productX(_element);
	var _expectedValue = [(_base[0] * _base[4]), (_base[2] * _base[4])];
	
	unitTest.assert_equal("Method: productX(Vector2)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: productX(Vector4)]
	
	var _base = [53, 20, 12, 9.952, 10, 25, 56, 23];
	
	constructor = [new Vector4(_base[0], _base[1], _base[2], _base[3]),
				   new Vector4(_base[4], _base[5], _base[6], _base[7])];
	
	var _result = constructor[0].productX(constructor[1]);
	var _expectedValue = [(_base[0] * _base[4]), (_base[2] * _base[6])];
	
	unitTest.assert_equal("Method: productX(Vector4)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: productY()]
	
	var _base = [25, 115, 20, 40];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.productY();
	var _expectedValue = (_base[1] * _base[3]);
	
	unitTest.assert_equal("Method: productY()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: productY(Vector2)]
	
	var _base = [5.2, -5.2, 5, 1, 59, 21];
	var _element = new Vector2(_base[4], _base[5]);
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.productY(_element);
	var _expectedValue = [(_base[1] * _base[5]), (_base[3] * _base[5])];
	
	unitTest.assert_equal("Method: productY(Vector2)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: productY(Vector4)]
	
	var _base = [53, 20, 12, 9.952, 10, 25, 56, 23];
	
	constructor = [new Vector4(_base[0], _base[1], _base[2], _base[3]),
				   new Vector4(_base[4], _base[5], _base[6], _base[7])];
	
	var _result = constructor[0].productY(constructor[1]);
	var _expectedValue = [(_base[1] * _base[5]), (_base[3] * _base[7])];
	
	unitTest.assert_equal("Method: productY(Vector4)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: quotient(Vector4)]
	
	var _base = [4, 16, 32, 64, 512, 1024, 2, 4];
	var _element = new Vector4((_base[0] / _base[4]), (_base[1] / _base[5]), (_base[2] / _base[6]), 
							   (_base[3] / _base[7]));
	
	constructor = [new Vector4(_base[0], _base[1], _base[2], _base[3]),
				   new Vector4(_base[4], _base[5], _base[6], _base[7])];
	
	var _result = constructor[0].quotient(constructor[1]);
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: quotient(Vector4)",
						  _result, _expectedValue);
						  
#endregion
#region [Test: Method: quotientX(Vector2)]
	
	var _base = [25, 50, 75, 100, 2, 0];
	var _element = new Vector2(_base[4], _base[5]);
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.quotientX(_element);
	var _expectedValue = [(_base[0] / _base[4]), (_base[2] / _base[4])];
	
	unitTest.assert_equal("Method: quotientX(Vector2)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: quotientX(Vector4)]
	
	var _base = [104, 103, 102, 101, 3, 4, 5, 6];
	
	constructor = [new Vector4(_base[0], _base[1], _base[2], _base[3]),
				   new Vector4(_base[4], _base[5], _base[6], _base[7])];
	
	var _result = constructor[0].quotientX(constructor[1]);
	var _expectedValue = [(_base[0] / _base[4]), (_base[2] / _base[6])];
	
	unitTest.assert_equal("Method: quotientX(Vector4)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: quotientY(Vector2)]
	
	var _base = [35, 55, 35, 125, 0, 4];
	var _element = new Vector2(_base[4], _base[5]);
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.quotientY(_element);
	var _expectedValue = [(_base[1] / _base[5]), (_base[3] / _base[5])];
	
	unitTest.assert_equal("Method: quotientY(Vector2)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: quotientY(Vector4)]
	
	var _base = [1024, 1023, 1022, 1021, 2, 3, 4, 5];
	
	constructor = [new Vector4(_base[0], _base[1], _base[2], _base[3]),
				   new Vector4(_base[4], _base[5], _base[6], _base[7])];
	
	var _result = constructor[0].quotientY(constructor[1]);
	var _expectedValue = [(_base[1] / _base[5]), (_base[3] / _base[7])];
	
	unitTest.assert_equal("Method: quotientY(Vector4)",
						  _result, _expectedValue);
	
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
#region [Test: Method: interpolateX()]
	
	var _base = [52, 62, 72, 82];
	var _value = 0.111;
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.interpolateX(_value);
	var _expectedValue = lerp(_base[0], _base[2], _value);
	
	unitTest.assert_equal("Method: interpolateX()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: interpolateY()]
	
	var _base = [902, 1002, 1102, 1202];
	var _value = 0.968;
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.interpolateY(_value);
	var _expectedValue = lerp(_base[1], _base[3], _value);
	
	unitTest.assert_equal("Method: interpolateY()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getAngle1to2()]
	
	var _base = [53, 111, 1100, 2105];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.getAngle1to2();
	var _expectedValue = point_direction(_base[0], _base[1], _base[2], _base[3]);
	
	unitTest.assert_equal("Method: getAngle1to2()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getAngle2to1()]
	
	var _base = [3, 11, 110, 105];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.getAngle2to1();
	var _expectedValue = point_direction(_base[2], _base[3], _base[0], _base[1]);
	
	unitTest.assert_equal("Method: getAngle2to1()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getDistance()]
	
	var _base = [530, 1011, 152100, 204105];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.getDistance();
	var _expectedValue = point_distance(_base[0], _base[1], _base[2], _base[3]);
	
	unitTest.assert_equal("Method: getDistance()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Methods: getMinimum() / getMaximum()]
	
	var _base = [-2, 35, 55, 55];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = [constructor.getMinimum(), constructor.getMaximum()];
	var _expectedValue = [_base[0], _base[2]];
	
	unitTest.assert_equal("Methods: getMinimum() / getMaximum()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
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
#region [Test: Method: getMiddleX()]
	
	var _base = [52, 1000, 150000, 200000];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.getMiddleX();
	var _expectedValue = ((_base[0] + _base[2]) / 2);
	
	unitTest.assert_equal("Method: getMiddleX()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getMiddleX()]
	
	var _base = [53, 1010, 150100, 200100];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.getMiddleY();
	var _expectedValue = ((_base[1] + _base[3]) / 2);
	
	unitTest.assert_equal("Method: getMiddleY()",
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
#region [Test: Method: approach()]
	
	var _base = [3, -52, 52, 93.4];
	var _value = [[new Vector4(3, -49, 50, 96), new Vector4(1, 2, 1, 1)], [[3, -50, 51, 94.4],
				  [3, -49, 50, 95.4], [3, -49, 50, 96], [3, -49, 50, 96]]];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = [];
	var _expectedValue = [];
	
	var _i = 0;
	repeat (array_length(_value[1]))
	{
		constructor.approach(_value[0][0], _value[0][1]);
		
		array_push(_result, [constructor.x1, constructor.y1, constructor.x2, constructor.y2]);
		array_push(_expectedValue, _value[1][_i]);
		
		++_i;
	}
	
	unitTest.assert_equal("Method: approach()",
						  _result, _expectedValue);
	
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
#region [Test: Method: toString()]
	
	var _base = [5, 6, 7, 8];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName +
						  "(" +
						  "x1: " + string(_base[0]) + ", " +
						  "y1: " + string(_base[1]) + ", " +
						  "x2: " + string(_base[2]) + ", " +
						  "y2: " + string(_base[3]) +
						  ")");
	
	unitTest.assert_equal("Method: toString()",
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
