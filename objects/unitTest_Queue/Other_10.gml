/// @description Unit Testing
#region [Test: Construction: New constructor / Destruction]
	
	constructor = new Queue();
	
	var _result = [ds_exists(constructor.ID, ds_type_queue)];
	var _expectedValue = [true];
	
	constructor.destroy();
	
	array_push(_result, constructor.ID);
	array_push(_expectedValue, undefined);
	
	unitTest.assert_equal("Construction: New constructor / Destruction",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Value write/read]
	
	var _value = [1, 2, 3];
	
	constructor = new Queue();
	constructor.add(_value[0], _value[1], _value[2]);
	
	var _result = constructor.remove(3);
	var _expectedValue = [_value[0], _value[1], _value[2]];
	
	unitTest.assert_equal("Value write/read",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: Construction: Wrapper]
	
	var _element = ds_queue_create();
	var _value = [33333, "ABC", -2.095];
	
	ds_queue_enqueue(_element, _value[0], _value[1], _value[2]);
	
	constructor = new Queue(_element);
	
	var _result = constructor.remove(array_length(_value));
	var _expectedValue = [_value[0], _value[1], _value[2]];
	
	unitTest.assert_equal("Construction: Wrapper",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _value = [25.5, ".", -2];
	
	constructor = [new Queue()];
	constructor[0].add(_value[0], _value[1], _value[2]);
	constructor[1] = new Queue(constructor[0]);
	
	var _result = constructor[1].remove(array_length(_value));
	var _expectedValue = [_value[0], _value[1], _value[2]];
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: isFunctional()]
	
	constructor = [new Queue(), new Queue()];
	constructor[1].destroy();
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional()];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	
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
	
	unitTest.assert_equal("Methods: clear() / getSize()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: contains()]
	
	var _value = [4, 10];
	
	constructor = new Queue();
	constructor.add(_value[0]);
	
	var _result = [constructor.contains(_value[0]), constructor.contains(_value[1])];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: contains()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: count()]
	
	var _value = [["GML-OOP", 5, -3, -5], [11, 3, 1]];
	
	constructor = new Queue();
	
	var _i = 0;
	repeat (array_length(_value[1]))
	{
		repeat (_value[1][_i])
		{
			constructor.add(_value[0][_i]);
		}
		
		++_i;
	}
	
	var _result = constructor.count(_value[0][0], _value[0][1], _value[0][2], _value[0][3]);
	var _expectedValue = (_value[1][0] + _value[1][1] + _value[1][2]);
	
	unitTest.assert_equal("Method: count()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: copy()]
	
	var _value = [[2, "A"], [25, "Z"]];
	
	constructor = [new Queue(), new Queue()];
	constructor[0].add(_value[0][0], _value[0][1]);
	constructor[1].add(_value[1][0], _value[1][1]);
	constructor[1].copy(constructor[0]);
	
	var _result = constructor[1].remove(2);
	var _expectedValue = [_value[0][0], _value[0][1]];
	
	unitTest.assert_equal("Method: copy()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Methods: getFirst() / getLast()]
	
	var _value = [1, 2, 3];
	
	constructor = new Queue();
	constructor.add(_value[0], _value[1], _value[2]);
	
	var _result = [constructor.getFirst(), constructor.getLast()];
	var _expectedValue = [_value[0], _value[2]];
	
	unitTest.assert_equal("Methods: getFirst() / getLast()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: isEmpty()]
	
	var _value = 10;
	
	constructor = [new Queue(), new Queue()]
	constructor[0].add(_value);
	
	var _result = [constructor[0].isEmpty(), constructor[1].isEmpty()];
	var _expectedValue = [false, true];
	
	unitTest.assert_equal("Method: isEmpty()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
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
	
	unitTest.assert_equal("Method: forEach()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
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
	
	unitTest.assert_equal("Method: forEach(readOnly)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: toString()]
	
	var _value = [46, 22, -23];
	
	constructor = new Queue();
	constructor.add(_value[0], _value[1], _value[2]);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName + "(" + string(array_length(_value)) + " - " +
						  string(_value[0]) + ", " + string(_value[1]) + ", " + string(_value[2]) +
						  ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: toString(lenght cut)]
	
	var _element = [[30, "..."], [2]];
	var _value = [string_repeat("I", (_element[0][0])), _element[1][0]];
	
	constructor = new Queue();
	constructor.add(_value[0], _value[1]);
	
	var _result = constructor.toString(false, undefined, _element[0][0]);
	var _expectedValue = (constructorName + "(" + string(array_length(_value)) + " - " +
						  _value[0] + _element[0][1] + ")");
	
	unitTest.assert_equal("Method: toString(lenght cut)",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: toString(multiline)]
	
	var _value = [1, "ABC", -33];
	
	constructor = new Queue();
	constructor.add(_value[0], _value[1], _value[2]);
	
	var _result = constructor.toString(true, all, all);
	var _expectedValue = (string(_value[0]) + "\n" + string(_value[1]) + "\n" + string(_value[2]) +
						  "\n");
	
	unitTest.assert_equal("Method: toString(multiline)",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: fromArray() / toArray()]
	
	var _value = [53, -25.99, "ABC"];
	
	constructor = [new Queue(), new Queue()];
	constructor[0].add(_value[0], _value[1], _value[2]);
	constructor[1].fromArray(constructor[0].toArray());
	
	var _result = constructor[1].remove(array_length(_value));
	var _expectedValue = [_value[0], _value[1], _value[2]];
	
	unitTest.assert_equal("Methods: fromArray() / toArray()",
						  _result, _expectedValue);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Methods: fromEncodedString() / toEncodedString()]
	
	var _value = [-52.5, 22, ""];
	
	constructor = [new Queue(), new Queue()];
	constructor[0].add(_value[0], _value[1], _value[2]);
	constructor[1].fromEncodedString(constructor[0].toEncodedString());
	
	var _result = constructor[1].remove(array_length(_value));
	var _expectedValue = [_value[0], _value[1], _value[2]];
	
	unitTest.assert_equal("Methods: fromEncodedString() / toEncodedString()",
						  _result, _expectedValue);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
