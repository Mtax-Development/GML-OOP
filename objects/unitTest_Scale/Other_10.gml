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
#region [Test: Construction: From array]
	
	var _base = [-2.5, 5];
	
	constructor = [new Scale(_base), new Scale([_base[0]])];
	
	var _result = [constructor[0].x, constructor[0].y, constructor[1].x, constructor[1].y];
	var _expectedValue = [_base[0], _base[1], _base[0], _base[0]];
	
	unitTest.assert_equal("Construction: From array",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Construction: From Vector2]
	
	var _base = [-1.5, 15];
	var _element = new Vector2(_base[0], _base[1]);
	
	constructor = new Scale(_element);
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [_base[0], _base[1]];
	
	unitTest.assert_equal("Construction: From Vector2",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
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
#region [Test: Method: contains()]
	
	var _base = [0.1, 0.25];
	var _value = (_base[0] + _base[1] + 1);
	
	constructor = new Scale(_base[0], _base[1]);
	
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
	
	var _base = [0.53, 0.9];
	
	constructor = [new Scale(_base[0], _base[1])];
	constructor[1] = new Scale(constructor[0]);
	constructor[2] = new Scale(-_base[0], -_base[1]);
	
	var _result = [constructor[0].equals(constructor[1]), constructor[0].equals(constructor[2])];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: equals()",
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
#region [Test: Methods: grow() / shrink()]
	
	var _base = [-105, 105];
	var _value = [5, -5];
	var _element = new Scale(_value[0], _value[1]);
	
	constructor = new Scale(_base[0], _base[1]);
	
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
#region [Test: Method: mirror()]
	
	var _base = [0.2, 0.545];
	
	constructor = new Scale(_base[0], _base[1]);
	constructor.mirror();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [(-_base[0]), (-_base[1])];
	
	unitTest.assert_equal("Method: mirror()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: mirrorX()]
	
	var _base = [0.25, 1];
	
	constructor = new Scale(_base[0], _base[1]);
	constructor.mirrorX();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [(-_base[0]), _base[1]];
	
	unitTest.assert_equal("Method: mirrorX()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: mirrorY()]
	
	var _base = [1, 0.25];
	
	constructor = new Scale(_base[0], _base[1]);
	constructor.mirrorY();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [_base[0], (-_base[1])];
	
	unitTest.assert_equal("Method: mirrorY()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: set()]
	
	var _base = [2, 3];
	var _value = [1, -0.5];
	
	constructor = new Scale(_base[0], _base[1]);
	constructor.set(_value[0], _value[1]);
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [_value[0], _value[1]];
	
	unitTest.assert_equal("Method: set()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: setAll()]
	
	var _value = [5, 7];
	var _element = new Vector2(_value[0], _value[1]);
	
	constructor = [new Scale(), new Scale(), new Scale()];
	constructor[0].setAll(_value[0]);
	constructor[1].setAll(_element);
	constructor[2].setAll(constructor[1]);
	
	var _result = [constructor[0].x, constructor[0].y, constructor[1].x, constructor[1].y,
				   constructor[2].x, constructor[2].y];
	var _expectedValue = [_value[0], _value[0], _value[0], _value[1], _value[0], _value[1]];
	
	unitTest.assert_equal("Method: setAll()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
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
#region [Test: Method: toArray()]
	
	var _base = [25.5, -55.75];
	
	constructor = new Scale(_base[0], _base[1]);
	
	var _result = constructor.toArray();
	var _expectedValue = _base;
	
	unitTest.assert_equal("Method: toArray()",
						  _result, _expectedValue);
	
#endregion
