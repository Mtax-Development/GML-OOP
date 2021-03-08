/// @description Unit Testing
#region [Test: Construction: New constructor / Method: destroy()]
	
	constructor = new Queue();
	
	var _result = [ds_exists(constructor.ID, ds_type_queue)];
	var _expectedValue = [true];
	
	constructor.destroy();
	
	array_push(_result, constructor.ID);
	array_push(_expectedValue, undefined);
	
	unitTest.assert_equal("Construction: New constructor / Method: destroy()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Value write/read]
	
	var _value = [1, 2, 3];
	
	constructor = new Queue();
	constructor.add(_value[0], _value[1], _value[2]);
	
	var _result = constructor.remove(3);
	var _expectedValue = [_value[0], _value[1], _value[2]];
	
	constructor.destroy();
	
	unitTest.assert_equal("Construction: Value write/read",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Construction: Wrapper]
	
	var _element = ds_queue_create();
	var _value = [33333, "ABC", -2.095];
	
	ds_queue_enqueue(_element, _value[0], _value[1], _value[2]);
	
	constructor = new Queue(_element);
	
	var _result = constructor.remove(array_length(_value));
	var _expectedValue = [_value[0], _value[1], _value[2]];
	
	constructor.destroy();
	
	unitTest.assert_equal("Construction: Wrapper",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _value = [25.5, ".", -2];
	
	constructor = [new Queue()];
	constructor[0].add(_value[0], _value[1], _value[2]);
	constructor[1] = new Queue(constructor[0]);
	
	var _result = constructor[1].remove(array_length(_value));
	var _expectedValue = [_value[0], _value[1], _value[2]];
	
	constructor[0].destroy();
	constructor[1].destroy();
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: isFunctional()]
	
	constructor = [new Queue(), new Queue()];
	constructor[1].destroy();
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional()];
	var _expectedValue = [true, false];
	
	constructor[0].destroy();
	
	unitTest.assert_equal("Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Methods: clear() / getSize()]
	
	var _value = [1, 2];
	
	constructor = new Queue();
	constructor.add(_value[0], _value[1]);
	
	var _result = [constructor.getSize()];
	var _expectedValue = [array_length(_value)];
	
	constructor.clear();
	
	array_push(_result, constructor.getSize());
	array_push(_expectedValue, 0);
	
	constructor.destroy();
	
	unitTest.assert_equal("Methods: clear() / getSize()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: copy()]
	
	var _value = [[2, "A"], [25, "Z"]];
	
	constructor = [new Queue(), new Queue()];
	constructor[0].add(_value[0][0], _value[0][1]);
	constructor[1].add(_value[1][0], _value[1][1]);
	constructor[1].copy(constructor[0]);
	
	var _result = constructor[1].remove(2);
	var _expectedValue = [_value[0][0], _value[0][1]];
	
	constructor[0].destroy();
	constructor[1].destroy();
	
	unitTest.assert_equal("Method: copy()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Methods: getFirst() / getLast()]
	
	var _value = [1, 2, 3];
	
	constructor = new Queue();
	constructor.add(_value[0], _value[1], _value[2]);
	
	var _result = [constructor.getFirst(), constructor.getLast()];
	var _expectedValue = [_value[0], _value[2]];
	
	constructor.destroy();
	
	unitTest.assert_equal("Methods: getFirst() / getLast()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: isEmpty()]
	
	var _value = 10;
	
	constructor = [new Queue(), new Queue()]
	constructor[0].add(_value);
	
	var _result = [constructor[0].isEmpty(), constructor[1].isEmpty()];
	var _expectedValue = [false, true];
	
	constructor[0].destroy();
	constructor[1].destroy();
	
	unitTest.assert_equal("Method: isEmpty()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: forEach()]
	
	var _value = [1, 4, 2, -5, 3, -9];
	
	constructor = new Queue();
	constructor.add(_value[0], _value[1], _value[2], _value[3], _value[4], _value[5]);
	
	var _result = [[]];
	
	constructor.forEach
	(
		function(_i, _value, _result)
		{
			if (_value < 0)
			{
				array_push(_result, _value);
			}
		},
		_result[0],
	);
	
	var _expectedValue = [[_value[3], _value[5]]];
	
	_result[1] = constructor.getSize();
	_expectedValue[1] = 0;
	
	constructor.destroy();
	
	unitTest.assert_equal("Method: forEach()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: forEach(readOnly)]
	
	var _value = [3, 2, 7, -2, 1, -39];
	
	constructor = new Queue();
	constructor.add(_value[0], _value[1], _value[2], _value[3], _value[4], _value[5]);
	
	var _result = [[]];
	
	constructor.forEach
	(
		function(_i, _value, _result)
		{
			if (_value < 0)
			{
				array_push(_result, _value);
			}
		},
		_result[0],
		true
	);
	
	var _expectedValue = [[_value[3], _value[5]]];
	
	_result[1] = constructor.getSize();
	_expectedValue[1] = array_length(_value);
	
	constructor.destroy();
	
	unitTest.assert_equal("Method: forEach(readOnly)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: String conversion]
	
	var _value = [46, 22, -23];
	
	constructor = new Queue();
	constructor.add(_value[0], _value[1], _value[2]);
	
	var _result = string(constructor);
	var _expectedValue = (constructorName + "(" + string(_value[0]) + ", " + string(_value[1]) +
						  ", " + string(_value[2]) + ")");
	
	constructor.destroy();
	
	unitTest.assert_equal("Method: String conversion",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(lenght cut)]
	
	var _element = [[30, "..."], [2]];
	var _value = [string_repeat("I", (_element[0][0])), _element[1][0]];
	
	constructor = new Queue();
	constructor.add(_value[0], _value[1]);
	
	var _result = constructor.toString(false, undefined, _element[0][0]);
	var _expectedValue = (constructorName + "(" + _value[0] + _element[0][1] + ")");
	
	constructor.destroy();
	
	unitTest.assert_equal("Method: toString(lenght cut)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(multiline)]
	
	var _value = [1, "ABC", -33];
	
	constructor = new Queue();
	constructor.add(_value[0], _value[1], _value[2]);
	
	var _result = constructor.toString(true, all, all);
	var _expectedValue = (string(_value[0]) + "\n" + string(_value[1]) + "\n" + string(_value[2]) +
						  "\n");
	
	constructor.destroy();
	
	unitTest.assert_equal("Method: toString(multiline)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Methods: fromArray() / toArray()]
	
	var _value = [53, -25.99, "ABC"];
	
	constructor = [new Queue(), new Queue()];
	constructor[0].add(_value[0], _value[1], _value[2]);
	constructor[1].fromArray(constructor[0].toArray());
	
	var _result = constructor[1].remove(array_length(_value));
	var _expectedValue = [_value[0], _value[1], _value[2]];
	
	constructor[0].destroy();
	constructor[1].destroy();
	
	unitTest.assert_equal("Methods: fromArray() / toArray()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Methods: fromEncodedString() / toEncodedString()]
	
	var _value = [-52.5, 22, ""];
	
	constructor = [new Queue(), new Queue()];
	constructor[0].add(_value[0], _value[1], _value[2]);
	constructor[1].fromEncodedString(constructor[0].toEncodedString());
	
	var _result = constructor[1].remove(array_length(_value));
	var _expectedValue = [_value[0], _value[1], _value[2]];
	
	constructor[0].destroy();
	constructor[1].destroy();
	
	unitTest.assert_equal("Methods: fromEncodedString() / toEncodedString()",
						  _result, _expectedValue);
	
#endregion
