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
	var _expectedValue = [_base, _base]
	
	unitTest.assert_equal("Construction: One number for all values",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Construction: From array]
	
	var _base = [154536.355535, 25];
	
	constructor = new Vector2(_base);
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [_base[0], _base[1]];
	
	unitTest.assert_equal("Construction: From array",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Construction: From Scale]
	
	var _value = [0.7, 0.9];
	var _element = new Scale(_value[0], _value[1]);
	
	constructor = new Vector2(_element);
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [_value[0], _value[1]];
	
	unitTest.assert_equal("Construction: From Scale",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Construction: Empty]

	constructor = new Vector2();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [undefined, undefined];
	
	unitTest.assert_equal("Construction: Empty",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _base = [15, 51];
	
	constructor = [new Vector2(_base[0], _base[1])];
	constructor[1] = new Vector2(constructor[0]);
	
	var _result = [constructor[1].x, constructor[1].y];
	var _expectedValue = [_base[0], _base[1]];
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: isFunctional()]
	
	var _base = [9, 6];
	
	constructor = [new Vector2(_base[0], _base[1]), new Vector2(_base[0], _base[1]), new Vector2()];
	constructor[1].y = undefined;
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional(),
				   constructor[2].isFunctional()];
	var _expectedValue = [true, false, false];
	
	unitTest.assert_equal("Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: contains()]
	
	var _base = [2, 5.545];
	var _value = (_base[0] + _base[1] + 1);
	
	constructor = new Vector2(_base[0], _base[1]);
	
	var _result = [constructor.contains(_base[0]), constructor.contains(_base[1]),
				   constructor.contains(_value), constructor.contains(_value, _base[0])];
	var _expectedValue = [true, true, false, true];
	
	unitTest.assert_equal("Method: contains()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: equals()]
	
	var _base = [0.567, 1212.1212];
	
	constructor = [new Vector2(_base[0], _base[1]), new Vector2(-_base[0], -_base[1]),
				   new Vector2(_base[0])];
	constructor[3] = new Vector2(constructor[0]);
	
	var _result = [constructor[0].equals(constructor[3]), constructor[0].equals(constructor[1]),
				   constructor[0].equals(_base[0]), constructor[2].equals(_base[0])];
	var _expectedValue = [true, false, false, true];
	
	unitTest.assert_equal("Method: equals()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: sum()]
	
	var _base = [42, 61];
	
	constructor = new Vector2(_base[0], _base[1]);
	
	var _result = constructor.sum();
	var _expectedValue = (_base[0] + _base[1]);
	
	unitTest.assert_equal("Method: sum()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: sum(real)]
	
	var _base = [21, 6.8];
	var _value = 0.3;
	var _element = new Vector2((_base[0] + _value), (_base[1] + _value));
	
	constructor = new Vector2(_base[0], _base[1]);
	
	var _result = constructor.sum(_value);
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: sum(real)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: sum(Vector2)]
	
	var _base = [0.41, 6.2, 432, 654];
	var _element = new Vector2((_base[0] + _base[2]), (_base[1] + _base[3]));
	
	constructor = [new Vector2(_base[0], _base[1]), new Vector2(_base[2], _base[3])];
	
	var _result = constructor[0].sum(constructor[1]);
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: sum(Vector2)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: difference()]

	var _base = [0.4684, 2];
	
	constructor = new Vector2(_base[0], _base[1]);
	
	var _result = constructor.difference();
	var _expectedValue = abs(_base[0] - _base[1]);
	
	unitTest.assert_equal("Method: difference()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: difference(real)]
	
	var _base = [15, 1.3];
	var _value = 2.45;
	var _element = new Vector2(abs(_base[0] - _value), abs(_base[1] - _value));
	
	constructor = new Vector2(_base[0], _base[1]);
	
	var _result = constructor.difference(_value);
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: difference(real)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: difference(Vector2)]
	
	var _base = [24.42, 2, -653, -235];
	var _element = new Vector2(abs(_base[0] - _base[2]), abs(_base[1] - _base[3]));
	
	constructor = [new Vector2(_base[0], _base[1]), new Vector2(_base[2], _base[3])];
	
	var _result = constructor[0].difference(constructor[1]);
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: difference(Vector2)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: product()]
	
	var _base = [0.4684, 11];
	
	constructor = new Vector2(_base[0], _base[1]);
	
	var _result = constructor.product();
	var _expectedValue = (_base[0] * _base[1]);
	
	unitTest.assert_equal("Method: product()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: product(real)]
	
	var _base = [50, 75.5];
	var _value = 2.5;
	var _element = new Vector2((_base[0] * _value), (_base[1] * _value));
	
	constructor = new Vector2(_base[0], _base[1]);
	
	var _result = constructor.product(_value);
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: product(real)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: product(Vector2)]
	
	var _base = [24.5746, 38, 56, 5];
	var _element = new Vector2((_base[0] * _base[2]), (_base[1] * _base[3]));
	
	constructor = [new Vector2(_base[0], _base[1]), new Vector2(_base[2], _base[3])];
	
	var _result = constructor[0].product(constructor[1]);
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: product(Vector2)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: quotient(real)]
	
	var _base = [100, 68.8];
	var _value = 10;
	var _element = new Vector2((_base[0] / _value), (_base[1] / _value));
	
	constructor = new Vector2(_base[0], _base[1]);
	
	var _result = constructor.quotient(_value);
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: quotient(real)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: quotient(Vector2)]
	
	var _base = [25, 10, 556, 2];
	var _element = new Vector2((_base[0] / _base[2]), (_base[1] / _base[3]));
	
	constructor = [new Vector2(_base[0], _base[1]), new Vector2(_base[2], _base[3])];
	
	var _result = constructor[0].quotient(constructor[1]);
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: quotient(Vector2)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: dotProduct()]
	
	var _base = [-33.2, 5];
	
	constructor = new Vector2(_base[0], _base[1]);
	
	var _result = [constructor.dotProduct(constructor, false),
				   constructor.dotProduct(constructor, true)];
	var _expectedValue = [((_base[0] * _base[0]) + (_base[1] * _base[1])),
						  (power((_base[0] / sqrt((_base[0] * _base[0]) + (_base[1] * _base[1]))),
						   2) + power((_base[1] / sqrt((_base[0] * _base[0]) +
						   (_base[1] * _base[1]))), 2))];
	
	unitTest.assert_equal("Method: dotProduct()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: getAngle()]
	
	var _base = [2, 2, 5, 7];
	
	constructor = [new Vector2(_base[0], _base[1]), new Vector2(_base[2], _base[3])];
	
	var _result = constructor[0].getAngle(constructor[1]).value;
	var _expectedValue = point_direction(_base[0], _base[1], _base[2], _base[3]);
	
	unitTest.assert_equal("Method: getAngle()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getDistance()]
	
	var _base = [3, 3, 125, -17.7];
	
	constructor = [new Vector2(_base[0], _base[1]), new Vector2(_base[2], _base[3])];
	
	var _result = constructor[0].getDistance(constructor[1]);
	var _expectedValue = sqrt(power(abs(_base[2] - _base[0]), 2) +
							  power(abs(_base[3] - _base[1]), 2));
	
	unitTest.assert_equal("Method: getDistance()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Methods: getMinimum() / getMaximum()]
	
	var _base = [-0.5, 0.5];
	
	constructor = new Vector2(_base[0], _base[1]);
	
	var _result = [constructor.getMinimum(), constructor.getMaximum()];
	var _expectedValue = [_base[0], _base[1]];
	
	unitTest.assert_equal("Methods: getMinimum() / getMaximum()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Methods: getMagnitude() / getNormalized()]
	
	var _base = [999, -5];
	
	constructor = new Vector2(_base[0], _base[1]);
	
	var _result = [constructor.getMagnitude()];
	var _expectedValue = [sqrt(power(_base[0], 2) + power(_base[1], 2))];
	
	array_push(_result, constructor.getNormalized(), constructor.getNormalized(_result[0]));
	array_push(_expectedValue, constructor.quotient(_result[0]), constructor);
	
	unitTest.assert_equal("Methods: getMagnitude() / getNormalized()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: getSign()]
	
	var _base = [3, -3, -1, 0];
	var _element = [new Vector2(1, -1), new Vector2(-1, 0), new Vector2(-1, -1)];
	
	constructor = [new Vector2(_base[0], _base[1]), new Vector2(_base[2], _base[3])];
	
	var _result = [constructor[0].getSign(false), constructor[1].getSign(false),
				   constructor[1].getSign(true)];
	var _expectedValue = [_element[0], _element[1], _element[2]];
	
	unitTest.assert_equal("Method: getSign()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
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
#region [Test: Method: approach()]
	
	var _base = [0.6, 0.87];
	var _value = [[new Vector2(0.322, 1.28), new Vector2(0.1, 0.1)], [[0.5, 0.97], [0.4, 1.07],
				  [0.322, 1.17], [0.322, 1.27], [0.322, 1.28], [0.322, 1.28]]];
	
	constructor = new Vector2(_base[0], _base[1]);
	
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
#region [Test: Methods: grow() / shrink()]
	
	var _base = [-75, 75];
	var _value = [5, -5];
	var _element = new Vector2(_value[0], _value[1]);
	
	constructor = new Vector2(_base[0], _base[1]);
	
	constructor.grow(_element);
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [(_base[0] - _value[0]), (_base[1] - _value[1])];
	
	constructor.grow(_value[0]);
	
	array_push(_result, constructor.x, constructor.y);
	array_push(_expectedValue, (_base[0] - _value[0] - _value[0]),
			   (_base[1] - _value[1] + _value[0]));
	
	constructor.shrink(_value[0]);
	
	array_push(_result, constructor.x, constructor.y);
	array_push(_expectedValue, (_base[0] - _value[0]), (_base[1] - _value[1]));
	
	constructor.shrink(_element);
	
	array_push(_result, constructor.x, constructor.y);
	array_push(_expectedValue, _base[0], _base[1]);
	
	unitTest.assert_equal("Methods: grow() / shrink()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6],
						  _result[7], _expectedValue[7]);
	
#endregion
#region [Test: Method: clampTo()]
	
	var _base = [25, -25];
	var _value = [15, 15, 30, 30];
	var _element = new Vector4(_value[0], _value[1], _value[2], _value[3]);
	
	constructor = new Vector2(_base[0], _base[1]);
	constructor.clampTo(_element);
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [_base[0], _value[1]];
	
	unitTest.assert_equal("Method: clampTo()",
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
#region [Test: Method: mirror()]
	
	var _base = [0.12, 0.63];
	
	constructor = new Vector2(_base[0], _base[1]);
	constructor.mirror();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [(-_base[0]), (-_base[1])];
	
	unitTest.assert_equal("Method: mirror()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: set()]
	
	var _value = [5, 2.5, 1.5, 0.2, 0.8];
	var _element = [new Vector2(_value[1], _value[2]), new Scale(_value[3], _value[4])];
	
	constructor = [new Vector2(), new Vector2(), new Vector2()];
	constructor[0].set(_value[0]);
	constructor[1].set(_element[0]);
	constructor[2].set(_element[1]);
	
	var _result = [constructor[0].x, constructor[0].y, constructor[1].x, constructor[1].y,
				   constructor[2].x, constructor[2].y];
	var _expectedValue = [_value[0], _value[0], _value[1], _value[2], _value[3], _value[4]];
	
	unitTest.assert_equal("Method: set()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
#endregion
#region [Test: Method: setFloor()]
	
	var _value = [4.2, 1.3, 1.8, 0.2, 0.8];
	var _element = [new Vector2(_value[1], _value[2]), new Scale(_value[3], _value[4])];
	
	constructor = [new Vector2(), new Vector2(), new Vector2()];
	constructor[0].setFloor(_value[0]);
	constructor[1].setFloor(_element[0]);
	constructor[2].setFloor(_element[1]);
	
	var _result = [constructor[0].x, constructor[0].y, constructor[1].x, constructor[1].y,
				   constructor[2].x, constructor[2].y];
	var _expectedValue = [floor(_value[0]), floor(_value[0]), floor(_value[1]), floor(_value[2]),
						  floor(_value[3]), floor(_value[4])];
	
	unitTest.assert_equal("Method: setFloor()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
#endregion
#region [Test: Method: setRound()]
	
	var _value = [8.4, 2.7, 6.6, 0.1, 0.9];
	var _element = [new Vector2(_value[1], _value[2]), new Scale(_value[3], _value[4])];
	
	constructor = [new Vector2(), new Vector2(), new Vector2()];
	constructor[0].setRound(_value[0]);
	constructor[1].setRound(_element[0]);
	constructor[2].setRound(_element[1]);
	
	var _result = [constructor[0].x, constructor[0].y, constructor[1].x, constructor[1].y,
				   constructor[2].x, constructor[2].y];
	var _expectedValue = [round(_value[0]), round(_value[0]), round(_value[1]), round(_value[2]),
						  round(_value[3]), round(_value[4])];
	
	unitTest.assert_equal("Method: setRound()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
#endregion
#region [Test: Method: setCeil()]
	
	var _value = [4.2, 1.9, 1.2, 5.7, 0.3];
	var _element = [new Vector2(_value[1], _value[2]), new Scale(_value[3], _value[4])];
	
	constructor = [new Vector2(), new Vector2(), new Vector2()];
	constructor[0].setCeil(_value[0]);
	constructor[1].setCeil(_element[0]);
	constructor[2].setCeil(_element[1]);
	
	var _result = [constructor[0].x, constructor[0].y, constructor[1].x, constructor[1].y,
				   constructor[2].x, constructor[2].y];
	var _expectedValue = [ceil(_value[0]), ceil(_value[0]), ceil(_value[1]), ceil(_value[2]),
						  ceil(_value[3]), ceil(_value[4])];
	
	unitTest.assert_equal("Method: setCeil()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
#endregion
#region [Test: Method: setCursor()]
	
	unitTest.assert_executable
	("Method: setCursor()",
	 function()
	 {
		constructor = new Vector2();
		constructor.setCursor();
	 }
	);
	
#endregion
#region [Test: Method: toString()]
	
	var _base = [5, 10];
	
	constructor = new Vector2(_base[0], _base[1]);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName + 
						  "(" +
						  "x: " + string(_base[0]) + ", " +
						  "y: " + string(_base[1]) +
						  ")");
	
	unitTest.assert_equal("Method: toString()",
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
#region [Test: Method: toArray()]
	
	var _base = [25.3553, 936];
	
	constructor = new Vector2(_base[0], _base[1]);
	
	var _result = constructor.toArray();
	var _expectedValue = _base;
	
	unitTest.assert_equal("Method: toArray()",
						  _result, _expectedValue);
	
#endregion
