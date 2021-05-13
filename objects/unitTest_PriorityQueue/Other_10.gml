/// @description Unit Testing
#region [Test: Construction: New constructor / Destruction]
	
	constructor = new PriorityQueue();
	
	var _result = [ds_exists(constructor.ID, ds_type_priority)];
	var _expectedValue = [true];
	
	constructor.destroy();
	
	array_push(_result, constructor.ID);
	array_push(_expectedValue, undefined);
	
	unitTest.assert_equal("Construction: New constructor / Destruction",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Value write/read]
	
	var _value = [[1, "ABC"], [2, "QCX"], [3, 355]];
	
	constructor = [new PriorityQueue(), new PriorityQueue()];
	constructor[0].add(_value[0][0], _value[0][1],
					   _value[1][0], _value[1][1],
					   _value[2][0], _value[2][1]);
	constructor[1].add(_value[0][0], _value[0][1],
					   _value[1][0], _value[1][1],
					   _value[2][0], _value[2][1]);
	
	var _result = [constructor[0].removeLast(array_length(_value)),
				   constructor[1].removeFirst(array_length(_value))];
	var _expectedValue = [[_value[0][1], _value[1][1], _value[2][1]],
						  [_value[2][1], _value[1][1], _value[0][1]]];
	
	unitTest.assert_equal("Value write/read",
						  _result[0][0], _expectedValue[0][0],
						  _result[0][1], _expectedValue[0][1],
						  _result[0][2], _expectedValue[0][2],
						  _result[1][0], _expectedValue[1][0],
						  _result[1][1], _expectedValue[1][1],
						  _result[1][2], _expectedValue[1][2]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Construction: Wrapper]
	
	var _element = ds_priority_create();
	var _value = [[1, 55], [5, 67], [10, 1090]];
	
	ds_priority_add(_element, _value[0][1], _value[0][0]);
	ds_priority_add(_element, _value[1][1], _value[1][0]);
	ds_priority_add(_element, _value[2][1], _value[2][0]);
	
	constructor = new PriorityQueue(_element);
	
	var _result = constructor.removeFirst(array_length(_value));
	var _expectedValue = [_value[2][1], _value[1][1], _value[0][1]];
	
	unitTest.assert_equal("Construction: Wrapper",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _value = [[10, "ABC"], [20, "BC"], [100, "CB"]];
	
	constructor = [new PriorityQueue()];
	constructor[0].add(_value[0][0], _value[0][1],
					   _value[1][0], _value[1][1],
					   _value[2][0], _value[2][1]);
	constructor[1] = new PriorityQueue(constructor[0]);
	
	var _result = constructor[1].removeLast(array_length(_value));
	var _expectedValue = [_value[0][1], _value[1][1], _value[2][1]];
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: isFunctional()]
	
	constructor = [new PriorityQueue(), new PriorityQueue()];
	constructor[1].destroy();
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional()];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	
#endregion
#region [Test: Methods: clear() / getSize()]
	
	var _value = [1, "X"];
	
	constructor = new PriorityQueue();
	constructor.add(_value[0], _value[1]);
	
	var _result = [constructor.getSize()];
	var _expectedValue = [(array_length(_value) / 2)];
	
	constructor.clear();
	
	array_push(_result, constructor.getSize());
	array_push(_expectedValue, 0);
	
	unitTest.assert_equal("Methods: clear() / getSize()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: copy()]
	
	var _value = [[1, "A"], [24, "Z"]];
	
	constructor = [new PriorityQueue(), new PriorityQueue()];
	constructor[0].add(_value[0][0], _value[0][1]);
	constructor[1].add(_value[1][0], _value[1][1]);
	constructor[1].copy(constructor[0]);
	
	var _result = constructor[1].removeLast();
	var _expectedValue = _value[0][1];
	
	unitTest.assert_equal("Method: copy()",
						  _result, _expectedValue);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: contains()]
	
	var _value = [2, 5];
	
	constructor = new PriorityQueue();
	constructor.add(_value[0], _value[1]);
	
	var _result = [constructor.contains(_value[1]), constructor.contains(_value[0])];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: contains()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: getFirst() / getLast()]
	
	var _value = [[10, "Highest"], [5, "Middle"], [2, "Lowest"]];
	
	constructor = new PriorityQueue();
	constructor.add(_value[0][0], _value[0][1],
					_value[1][0], _value[1][1],
					_value[2][0], _value[2][1]);
	
	var _result = [constructor.getFirst(), constructor.getLast()];
	var _expectedValue = [_value[0][1], _value[2][1]];
	
	unitTest.assert_equal("Methods: getFirst() / getLast()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: getPriority()]
	
	var _value = [5, 10];
	
	constructor = new PriorityQueue();
	constructor.add(_value[0], _value[1]);
	
	var _result = constructor.getPriority(_value[1]);
	var _expectedValue = _value[0];
	
	unitTest.assert_equal("Methods: getPriority()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: isEmpty()]
	
	var _value = [10, 5];
	
	constructor = [new PriorityQueue(), new PriorityQueue()]
	constructor[0].add(_value[0], _value[1]);
	
	var _result = [constructor[0].isEmpty(), constructor[1].isEmpty()];
	var _expectedValue = [false, true];
	
	unitTest.assert_equal("Method: isEmpty()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: forEach()]
	
	var _value = [[1, 3], [2, -3], [3, -6]];
	
	constructor = new PriorityQueue();
	constructor.add(_value[0][0], _value[0][1],
					_value[1][0], _value[1][1],
					_value[2][0], _value[2][1]);
	
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
	
	var _expectedValue = [[_value[2][1], _value[1][1]]];
	
	_result[1] = constructor.getSize();
	_expectedValue[1] = 0;
	
	unitTest.assert_equal("Method: forEach()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: forEach(readOnly)]
	
	var _value = [[1, 4], [2, -6], [3, -9]];
	
	constructor = new PriorityQueue();
	constructor.add(_value[0][0], _value[0][1],
					_value[1][0], _value[1][1],
					_value[2][0], _value[2][1]);
	
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
	
	var _expectedValue = [[_value[2][1], _value[1][1]]];
	
	_result[1] = constructor.getSize();
	_expectedValue[1] = array_length(_value);
	
	unitTest.assert_equal("Method: forEach(readOnly)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setPriority()]
	
	var _value = [[[2, "A"], [3, "B"]], [4, 7]];
	
	constructor = new PriorityQueue();
	constructor.add(_value[0][0][0], _value[0][0][1],
					_value[0][1][0], _value[0][1][1]);
	constructor.setPriority(_value[1][0], _value[0][0][1],
							_value[1][1], _value[0][1][1]);
	
	var _result = [constructor.getPriority(_value[0][0][1]),
				   constructor.getPriority(_value[0][1][1])];
	var _expectedValue = [_value[1][0], _value[1][1]];
	
	unitTest.assert_equal("Method: setPriority()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: remove()]
	
	var _value = [[1, "A"], [2, "B"], [3, "C"]];
	
	constructor = new PriorityQueue();
	constructor.add(_value[0][0], _value[0][1],
					_value[1][0], _value[1][1],
					_value[2][0], _value[2][1]);
	constructor.remove(_value[0][1], _value[1][1]);
	
	var _result = [constructor.getSize(), constructor.getLast()];
	var _expectedValue = [1, _value[2][1]];
	
	unitTest.assert_equal("Method: remove()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: toString()]
	
	var _value = [[1, 555], [2, 55], [3, 5]];
	
	constructor = new PriorityQueue();
	constructor.add(_value[0][0], _value[0][1],
					_value[1][0], _value[1][1],
					_value[2][0], _value[2][1]);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName + "(" + string(array_length(_value)) + " - " +
						  string(_value[2][0]) + ": " + string(_value[2][1]) + ", " +
						  string(_value[1][0]) + ": " + string(_value[1][1]) + ", " +
						  string(_value[0][0]) + ": " + string(_value[0][1]) + ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: toString(lenght cut)]
	
	var _element = [[30, "...", ": "], [2, 1]];
	var _value = [[_element[1][0], string_repeat("I", (_element[0][0] -
				   string_length(_element[0][2]) - string_length(string(_element[1][0]))))],
				   [_element[1][1], _element[1][1]]];
	
	constructor = new PriorityQueue();
	constructor.add(_value[0][0], _value[0][1],
					_value[1][0], _value[1][1]);
	
	var _result = constructor.toString(false, undefined, _element[0][0], undefined, _element[0][1]);
	var _expectedValue = (constructorName + "(" + string(array_length(_element[1])) + " - " +
						  string(_value[0][0]) + _element[0][2] + _value[0][1] + _element[0][1] +
						  ")");
	
	unitTest.assert_equal("Method: toString(lenght cut)",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: toString(multiline)]
	
	var _element = ": ";
	var _value = [[3, "ABC"], [2, -333], [1, "I"]];
	
	constructor = new PriorityQueue();
	constructor.add(_value[0][0], _value[0][1],
					_value[1][0], _value[1][1],
					_value[2][0], _value[2][1]);
	
	var _result = constructor.toString(true, all, all, undefined, undefined, undefined, undefined,
									   _element);
	var _expectedValue = (string(_value[0][0]) + _element + string(_value[0][1]) + "\n" +
						  string(_value[1][0]) + _element + string(_value[1][1]) + "\n" +
						  string(_value[2][0]) + _element + string(_value[2][1]) + "\n");
	
	unitTest.assert_equal("Method: toString(multiline)",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: fromArray() / toArray()]
	
	var _value = [[55, "5"], [33, -33], [11, "II"]];
	
	constructor = [new PriorityQueue(), new PriorityQueue()];
	constructor[0].add(_value[0][0], _value[0][1],
					   _value[1][0], _value[1][1],
					   _value[2][0], _value[2][1]);
	constructor[1].fromArray(constructor[0].toArray());
	
	var _result = constructor[1].removeFirst(array_length(_value));
	var _expectedValue = [_value[0][1], _value[1][1], _value[2][1]];
	
	unitTest.assert_equal("Methods: fromArray() / toArray()",
						  _result, _expectedValue);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Methods: fromEncodedString() / toEncodedString()]
	
	var _value = [[100, "10"], [55, 5.5], [1, "O"]];
	
	constructor = [new PriorityQueue(), new PriorityQueue()];
	constructor[0].add(_value[0][0], _value[0][1],
					   _value[1][0], _value[1][1],
					   _value[2][0], _value[2][1]);
	constructor[1].fromEncodedString(constructor[0].toEncodedString());
	
	var _result = constructor[1].removeFirst(array_length(_value));
	var _expectedValue = [_value[0][1], _value[1][1], _value[2][1]];
	
	unitTest.assert_equal("Methods: fromEncodedString() / toEncodedString()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
