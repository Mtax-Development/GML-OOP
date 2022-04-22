/// @description Unit Testing
#region [Test: Construction: Four numbers]
	
	var _base = [25, 26, 115.5, 535];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: Four numbers",
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
#region [Test: Construction: From Scale or Vector2]
	
	var _value = [0.8, -0.25];
	var _element = [new Vector2(_value[0], _value[1]), new Scale(_value[0], _value[1])];
	
	constructor = [new Vector4(_element[0]), new Vector4(_element[1])];
	
	var _result = [constructor[0].x1, constructor[0].y1, constructor[0].x2, constructor[0].y2,
				   constructor[1].x1, constructor[1].y1, constructor[1].x2, constructor[1].y2];
	var _expectedValue = [_value[0], _value[1], _value[0], _value[1], _value[0], _value[1],
						  _value[0], _value[1]];
	
	unitTest.assert_equal("Construction: From Scale or Vector2",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6],
						  _result[7], _expectedValue[7]);
	
#endregion
#region [Test: Construction: Vector2 pair]
	
	var _base = [new Vector2(15, 50), new Vector2(1, 2)];
	
	constructor = new Vector4(_base[0], _base[1]);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [_base[0].x, _base[0].y, _base[1].x, _base[1].y];
	
	unitTest.assert_equal("Construction: Vector2 pair",
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
#region [Test: Method: contains()]
	
	var _base = [53, 4, -9, 13.368];
	var _value = (_base[0] + _base[1] + _base[2] + _base[3] + 1);
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = [constructor.contains(_base[0]), constructor.contains(_base[1]),
				   constructor.contains(_base[2]), constructor.contains(_base[3]),
				   constructor.contains(_value), constructor.contains(_value, _base[0])];
	var _expectedValue = [true, true, true, true, false, true];
	
	unitTest.assert_equal("Method: contains()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
#endregion
#region [Test: Method: equals()]
	
	var _base = [5, 16, 1220, 24];
	var _element = new Vector2(_base[0], _base[1]);
	
	constructor = [new Vector4(_base[0], _base[1], _base[2], _base[3])];
	constructor[1] = new Vector4(constructor[0]);
	constructor[2] = new Vector4(-_base[0], -_base[1], -_base[2], -_base[3])
	constructor[3] = new Vector4(_element);
	
	var _result = [constructor[0].equals(constructor[1]), constructor[0].equals(constructor[2]),
				   constructor[0].equals(_element), constructor[3].equals(_element)];
	var _expectedValue = [true, false, false, true];
	
	unitTest.assert_equal("Method: equals()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
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
#region [Test: Method: sum(real)]
	
	var _base = [10, 20, 30, 40];
	var _value = 5;
	var _element = new Vector4((_base[0] + _value), (_base[1] + _value), (_base[2] + _value),
							   (_base[3] + _value));
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.sum(_value);
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: sum(real)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: sum(Vector2)]
	
	var _base = [[15, 51, 6.5, 5.6], [1, 10]];
	var _element = [new Vector2(_base[1][0], _base[1][1]), new Vector4((_base[0][0] + _base[1][0]),
					(_base[0][1] + _base[1][1]), (_base[0][2] + _base[1][0]),
					(_base[0][3] + _base[1][1]))];
	
	constructor = new Vector4(_base[0][0], _base[0][1], _base[0][2], _base[0][3]);
	
	var _result = constructor.sum(_element[0]);
	var _expectedValue = _element[1];
	
	unitTest.assert_equal("Method: sum(Vector2)",
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
#region [Test: Method: difference()]
	
	var _base = [52, -29, 25, -5];
	var _element = new Vector2(abs(_base[0] - _base[2]), abs(_base[1] - _base[3]));
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.difference();
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: difference()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: difference(real)]
	
	var _base = [2, 0, 27, -5];
	var _value = 5;
	var _element = new Vector4(abs(_base[0] - _value), abs(_base[1] - _value),
							   abs(_base[2] - _value), abs(_base[3] - _value));
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.difference(_value);
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: difference(real)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: difference(Vector2)]
	
	var _base = [[-7.5, 44, 0, 55], [-1.5, 2]];
	var _element = [new Vector2(_base[1][0], _base[1][1]), new Vector4(abs(_base[0][0] - _base[1][0]),
					abs(_base[0][1] - _base[1][1]), abs(_base[0][2] - _base[1][0]),
					abs(_base[0][3] - _base[1][1]))];
	
	constructor = new Vector4(_base[0][0], _base[0][1], _base[0][2], _base[0][3]);
	
	var _result = constructor.difference(_element[0]);
	var _expectedValue = _element[1];
	
	unitTest.assert_equal("Method: difference(Vector2)",
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
#region [Test: Method: product()]
	
	var _base = [1.411, 50, 10, -2.5];
	var _element = new Vector2((_base[0] * _base[2]), (_base[1] * _base[3]));
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.product();
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: product()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: product(real)]
	
	var _base = [75, 0, 4.5, 1];
	var _value = 5.5;
	var _element = new Vector4((_base[0] * _value), (_base[1] * _value), (_base[2] * _value),
							   (_base[3] * _value));
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.product(_value);
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: product(real)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: product(Vector2)]
	
	var _base = [[100, 25, 7.3, 0], [5.5, 0]];
	var _element = [new Vector2(_base[1][0], _base[1][1]), new Vector4((_base[0][0] * _base[1][0]),
					(_base[0][1] * _base[1][1]), (_base[0][2] * _base[1][0]),
					(_base[0][3] * _base[1][1]))];
	
	constructor = new Vector4(_base[0][0], _base[0][1], _base[0][2], _base[0][3]);
	
	var _result = constructor.product(_element[0]);
	var _expectedValue = _element[1];
	
	unitTest.assert_equal("Method: product(Vector2)",
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
#region [Test: Method: quotient(real)]
	
	var _base = [5, 0, -3.5, 1];
	var _value = 5;
	var _element = new Vector4((_base[0] / _value), (_base[1] / _value), (_base[2] / _value),
							   (_base[3] / _value));
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.quotient(_value);
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: quotient(real)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: quotient(Vector2)]
	
	var _base = [[63, 0, 2.5, 1], [2.5, -2.5]];
	var _element = [new Vector2(_base[1][0], _base[1][1]), new Vector4((_base[0][0] / _base[1][0]),
					(_base[0][1] / _base[1][1]), (_base[0][2] / _base[1][0]),
					(_base[0][3] / _base[1][1]))];
	
	constructor = new Vector4(_base[0][0], _base[0][1], _base[0][2], _base[0][3]);
	
	var _result = constructor.quotient(_element[0]);
	var _expectedValue = _element[1];
	
	unitTest.assert_equal("Method: quotient(Vector2)",
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
#region [Test: Method: dotProduct()]
	
	var _base = [-33.2, 5, 1.2, -7];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = [constructor.dotProduct(false), constructor.dotProduct(true)];
	var _expectedValue = [((_base[0] * _base[2]) + (_base[1] * _base[3])),
						  (((_base[0] / sqrt((_base[0] * _base[0]) + (_base[1] * _base[1]))) *
						   (_base[2] / sqrt((_base[2] * _base[2]) + (_base[3] * _base[3])))) +
						  ((_base[1] / sqrt((_base[0] * _base[0]) + (_base[1] * _base[1]))) *
						   (_base[3] / sqrt((_base[2] * _base[2]) + (_base[3] * _base[3])))))];
	
	unitTest.assert_equal("Method: dotProduct()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: interpolate(real)]
	
	var _base = [3, -0.2, 21, 5];
	var _value = 0.65;
	var _element = new Vector2(lerp(_base[0], _base[2], _value), 
							   lerp(_base[1], _base[3], _value));
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.interpolate(_value);
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: interpolate(real)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: interpolate(Vector2)]
	
	var _base = [1, 11, 22, 333];
	var _value = 0.3;
	var _element = [new Vector2(_value)];
	_element[1] = new Vector2(lerp(_base[0], _base[2], _element[0].x), 
							  lerp(_base[1], _base[3], _element[0].y))
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.interpolate(_element[0]);
	var _expectedValue = _element[1];
	
	unitTest.assert_equal("Method: interpolate(Vector2)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: interpolate(Vector4)]
	
	var _base = [520, -22, 1040, 22];
	var _value = [0.25, 0, 0.5, 1];
	var _element = [new Vector4(_value[0], _value[1], _value[2], _value[3])];
	_element[1] = new Vector4(lerp(_base[0], _base[2], _element[0].x1), 
							  lerp(_base[1], _base[3], _element[0].y1),
							  lerp(_base[0], _base[2], _element[0].x2), 
							  lerp(_base[1], _base[3], _element[0].y2));
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.interpolate(_element[0]);
	var _expectedValue = _element[1];
	
	unitTest.assert_equal("Method: interpolate(Vector4)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: percent(real)]
	
	var _base = [0, 0, 100, 50];
	var _value = [[50], [0.5, 1]]
	var _element = new Vector2(_value[1][0], _value[1][1]);
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.percent(_value[0][0]);
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: percent(real)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: percent(Vector2)]
	
	var _base = [10, 10, 20, 20];
	var _value = [[17.5, 20], [0.75, 1]]
	var _element = [new Vector2(_value[0][0], _value[0][1]), new Vector2(_value[1][0], _value[1][1])];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.percent(_element[0]);
	var _expectedValue = _element[1];
	
	unitTest.assert_equal("Method: percent(Vector2)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: split()]
	
	var _base = [2, 3, 4, 5];
	var _element = [new Vector2(_base[0], _base[1]), new Vector2(_base[2], _base[3])];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = [constructor.split()[0].x, constructor.split()[0].y, constructor.split()[1].x,
				   constructor.split()[1].y]
	var _expectedValue = [_element[0].x, _element[0].y, _element[1].x, _element[1].y];
	
	unitTest.assert_equal("Method: split()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getAngle()]
	
	var _base = [3, 11, 110, 105];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = [constructor.getAngle(false).value, constructor.getAngle(true).value];
	var _expectedValue = [point_direction(_base[0], _base[1], _base[2], _base[3]),
						  point_direction(_base[2], _base[3], _base[0], _base[1])];
	
	unitTest.assert_equal("Method: getAngle()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: getDistance()]
	
	var _base = [530, 1011, 152100, 204105];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.getDistance();
	var _expectedValue = point_distance(_base[0], _base[1], _base[2], _base[3]);
	
	unitTest.assert_equal("Method: getDistance()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getClosest()]
	
	var _base = [2, 1, 5, 7];
	var _value = 1.5;
	var _element = new Vector2((max(_base[0], _base[2]) + _value),
							   (max(_base[1], _base[3]) + _value));
	
	constructor = new Vector4(min(_base[0], _base[2]), min(_base[1], _base[3]),
							  max(_base[0], _base[2]), max(_base[1], _base[3]));
	
	var _result = constructor.getClosest(_element);
	var _expectedValue = _element.difference(_value);
	
	unitTest.assert_equal("Methods: getClosest()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Methods: getMinimum() / getMaximum()]
	
	var _base = [-2, 35, 55, 55];
	var _element = [new Vector2(_base[0], _base[1]), new Vector2(_base[2], _base[3])];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = [constructor.getMinimum(false), constructor.getMaximum(false),
				   constructor.getMinimum(true), constructor.getMaximum(true)];
	var _expectedValue = [_base[0], _base[2], _element[0], _element[1]];
	
	unitTest.assert_equal("Methods: getMinimum() / getMaximum()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Methods: getMiddle()]
	
	var _base = [3, -5, 6, 5];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = [constructor.getMiddle().x, constructor.getMiddle().y];
	var _expectedValue = [((_base[0] + _base[2]) / 2), ((_base[1] + _base[3]) / 2)];
	
	unitTest.assert_equal("Methods: getMiddle",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Methods: getMagnitude() / getNormalized()]
	
	var _base = [979, -4.2, 5211, 1];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = [constructor.getMagnitude()];
	var _expectedValue = [sqrt(power(_base[0], 2) + power(_base[1], 2) + power(_base[2], 2) +
							   power(_base[3], 2))];
	
	array_push(_result, constructor.getNormalized(), constructor.getNormalized(_result[0]));
	array_push(_expectedValue, constructor.quotient(_result[0]), constructor);
	
	unitTest.assert_equal("Methods: getMagnitude() / getNormalized()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
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
#region [Test: Method: getSign()]
	
	var _base = [2, -3.536, 0, 0.3];
	var _element = [new Vector4(1, -1, 0, 1), new Vector4(1, -1, -1, 1)];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = [constructor.getSign(false), constructor.getSign(true)];
	var _expectedValue = [_element[0], _element[1]];
	
	unitTest.assert_equal("Method: getSign()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
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
#region [Test: Method: clampTo()]
	
	var _base = [25, -25, 35, 30];
	var _value = [15, 15, 30, 30];
	var _element = new Vector4(_value[0], _value[1], _value[2], _value[3]);
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	constructor.clampTo(_element);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [_base[0], _value[1], _value[2], _base[3]];
	
	unitTest.assert_equal("Method: clampTo()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Methods: grow() / shrink()]
	
	var _base = [-75, 75, 55, -55.5];
	var _value = [5, -5, 2.5, -3];
	var _element = [new Vector4(_value[0], _value[1], _value[2], _value[3]),
					new Vector2(_value[0], _value[1])];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	constructor.grow(_element[0]);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [(_base[0] - _value[0]), (_base[1] - _value[1]), (_base[2] + _value[2]),
						  (_base[3] + _value[3])];
	
	constructor.grow(_element[1]);
	
	array_push(_result, constructor.x1, constructor.y1, constructor.x2, constructor.y2);
	array_push(_expectedValue, (_base[0] - _value[0] - _value[0]),
							   (_base[1] - _value[1] - _value[1]),
							   (_base[2] + _value[2] + _value[0]),
							   (_base[3] + _value[3] + _value[1]));
	
	constructor.grow(_value[0]);
	
	array_push(_result, constructor.x1, constructor.y1, constructor.x2, constructor.y2);
	array_push(_expectedValue, (_base[0] - _value[0] - _value[0] - _value[0]),
							   (_base[1] - _value[1] - _value[1] - _value[0]),
							   (_base[2] + _value[2] + _value[0] + _value[0]),
							   (_base[3] + _value[3] + _value[1] + _value[0]));
	
	constructor.shrink(_value[0]);
	
	array_push(_result, constructor.x1, constructor.y1, constructor.x2, constructor.y2);
	array_push(_expectedValue, (_base[0] - _value[0] - _value[0]),
							   (_base[1] - _value[1] - _value[1]),
							   (_base[2] + _value[2] + _value[0]),
							   (_base[3] + _value[3] + _value[1]));
	
	constructor.shrink(_element[1]);
	
	array_push(_result, constructor.x1, constructor.y1, constructor.x2, constructor.y2);
	array_push(_expectedValue, (_base[0] - _value[0]),
							   (_base[1] - _value[1]),
							   (_base[2] + _value[2]),
							   (_base[3] + _value[3]));
	
	constructor.shrink(_element[0]);
	
	array_push(_result, constructor.x1, constructor.y1, constructor.x2, constructor.y2);
	array_push(_expectedValue, _base[0], _base[1], _base[2], _base[3]);
	
	unitTest.assert_equal("Methods: grow() / shrink()",
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
#region [Test: Methods: mirror(), mirrorX(), mirrorY()]
	
	var _base = [2, -3, -5.6, 5];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	constructor.mirror();
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [(-_base[0]), (-_base[1]), (-_base[2]), (-_base[3])];
	
	constructor.mirrorX();
	
	array_push(_result, constructor.x1, constructor.y1, constructor.x2, constructor.y2);
	array_push(_expectedValue, _base[0], (-_base[1]), _base[2], (-_base[3]));
	
	constructor.mirrorY();
	
	array_push(_result, constructor.x1, constructor.y1, constructor.x2, constructor.y2);
	array_push(_expectedValue, _base[0], _base[1], _base[2], _base[3]);
	
	unitTest.assert_equal("Methods: mirror(), mirrorX(), mirrorY()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: sort()]
	
	var _base = [5, 2, -5, -2];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	constructor.sort(true);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [_base[2], _base[3], _base[0], _base[1]];
	
	constructor.sort(false);
	
	array_push(_result, constructor.x1, constructor.y1, constructor.x2, constructor.y2);
	array_push(_expectedValue, _base[0], _base[1], _base[2], _base[3]);
	
	unitTest.assert_equal("Methods: sort()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: set()]
	
	var _base = [5, 15, 0.2, 0.7];
	var _value = -4;
	var _element = [new Vector4(_base[0], _base[1], _base[2], _base[3]),
					new Vector2(_base[0], _base[1]), new Scale(_base[2], _base[3])];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	constructor.set(_value);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [_value, _value, _value, _value];
	
	constructor.set(_element[0]);
	
	array_push(_result, constructor.x1, constructor.y1, constructor.x2, constructor.y2);
	array_push(_expectedValue, _base[0], _base[1], _base[2], _base[3]);
	
	constructor.set(_element[1]);
	
	array_push(_result, constructor.x1, constructor.y1, constructor.x2, constructor.y2);
	array_push(_expectedValue, _base[0], _base[1], _base[0], _base[1]);
	
	constructor.set(_element[2]);
	
	array_push(_result, constructor.x1, constructor.y1, constructor.x2, constructor.y2);
	array_push(_expectedValue, _base[2], _base[3], _base[2], _base[3]);
	
	unitTest.assert_equal("Method: set()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: setFloor()]
	
	var _base = [5.5, 15.7, 0.2, 0.7];
	var _value = -1.2;
	var _element = [new Vector4(_base[0], _base[1], _base[2], _base[3]),
					new Vector2(_base[0], _base[1]), new Scale(_base[2], _base[3])];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	constructor.setFloor(_value);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [floor(_value), floor(_value), floor(_value), floor(_value)];
	
	constructor.setFloor(_element[0]);
	
	array_push(_result, constructor.x1, constructor.y1, constructor.x2, constructor.y2);
	array_push(_expectedValue, floor(_base[0]), floor(_base[1]), floor(_base[2]), floor(_base[3]));
	
	constructor.setFloor(_element[1]);
	
	array_push(_result, constructor.x1, constructor.y1, constructor.x2, constructor.y2);
	array_push(_expectedValue, floor(_base[0]), floor(_base[1]), floor(_base[0]), floor(_base[1]));
	
	constructor.setFloor(_element[2]);
	
	array_push(_result, constructor.x1, constructor.y1, constructor.x2, constructor.y2);
	array_push(_expectedValue, floor(_base[2]), floor(_base[3]), floor(_base[2]), floor(_base[3]));
	
	unitTest.assert_equal("Method: setFloor()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: setRound()]
	
	var _base = [5.4, 12.65, 0.25, 0.99];
	var _value = -2.2;
	var _element = [new Vector4(_base[0], _base[1], _base[2], _base[3]),
					new Vector2(_base[0], _base[1]), new Scale(_base[2], _base[3])];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	constructor.setRound(_value);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [round(_value), round(_value), round(_value), round(_value)];
	
	constructor.setRound(_element[0]);
	
	array_push(_result, constructor.x1, constructor.y1, constructor.x2, constructor.y2);
	array_push(_expectedValue, round(_base[0]), round(_base[1]), round(_base[2]), round(_base[3]));
	
	constructor.setRound(_element[1]);
	
	array_push(_result, constructor.x1, constructor.y1, constructor.x2, constructor.y2);
	array_push(_expectedValue, round(_base[0]), round(_base[1]), round(_base[0]), round(_base[1]));
	
	constructor.setRound(_element[2]);
	
	array_push(_result, constructor.x1, constructor.y1, constructor.x2, constructor.y2);
	array_push(_expectedValue, round(_base[2]), round(_base[3]), round(_base[2]), round(_base[3]));
	
	unitTest.assert_equal("Method: setRound()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: setCeil()]
	
	var _base = [2.5, 18.7, 0.1, 0.8];
	var _value = -3.2;
	var _element = [new Vector4(_base[0], _base[1], _base[2], _base[3]),
					new Vector2(_base[0], _base[1]), new Scale(_base[2], _base[3])];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	constructor.setCeil(_value);
	
	var _result = [constructor.x1, constructor.y1, constructor.x2, constructor.y2];
	var _expectedValue = [ceil(_value), ceil(_value), ceil(_value), ceil(_value)];
	
	constructor.setCeil(_element[0]);
	
	array_push(_result, constructor.x1, constructor.y1, constructor.x2, constructor.y2);
	array_push(_expectedValue, ceil(_base[0]), ceil(_base[1]), ceil(_base[2]), ceil(_base[3]));
	
	constructor.setCeil(_element[1]);
	
	array_push(_result, constructor.x1, constructor.y1, constructor.x2, constructor.y2);
	array_push(_expectedValue, ceil(_base[0]), ceil(_base[1]), ceil(_base[0]), ceil(_base[1]));
	
	constructor.setCeil(_element[2]);
	
	array_push(_result, constructor.x1, constructor.y1, constructor.x2, constructor.y2);
	array_push(_expectedValue, ceil(_base[2]), ceil(_base[3]), ceil(_base[2]), ceil(_base[3]));
	
	unitTest.assert_equal("Method: setCeil()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: setCursor()]
	
	unitTest.assert_executable
	("Method: setCursor()",
	 function()
	 {
		constructor = new Vector4();
		constructor.setCursor();
	 }
	);
	
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
#region [Test: Method: split()]
	
	var _base = [30, -25, 6219.02, 0];
	
	constructor = new Vector4(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.split();
	_result = [_result[0].x, _result[0].y, _result[1].x, _result[1].y];
	
	var _expectedValue = _base;
	
	unitTest.assert_equal("Method: split()",
						  _result, _expectedValue);
	
#endregion
