/// @description Unit Testing
#region [Test: Construction: New constructor / Destruction]
	
	constructor = new Map();
	
	var _result = [ds_exists(constructor.ID, ds_type_map)];
	var _expectedValue = [true];
	
	constructor.destroy();
	
	array_push(_result, constructor.ID);
	array_push(_expectedValue, undefined);
	
	unitTest.assert_equal("Construction: New constructor / Destruction",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Value write/read]
	
	var _value = [["Key1", 123], ["Key2", "ZYXABC"]];
	
	constructor = new Map();
	
	var _result = [constructor.add(_value[0][0], _value[0][1],
								   _value[1][0], _value[1][1],
								   _value[1][0], _value[0][1])];
	var _expectedValue = [[true, true, false]];
	
	array_push(_result, [constructor.getValue(_value[0][0]), constructor.getValue(_value[1][0])]);
	array_push(_expectedValue, [_value[0][1], _value[1][1]]);
	
	unitTest.assert_equal("Value write/read",
						  _result[0][0], _expectedValue[0][0],
						  _result[0][1], _expectedValue[0][1],
						  _result[0][2], _expectedValue[0][2],
						  _result[1][0], _expectedValue[1][0],
						  _result[1][1], _expectedValue[1][1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Construction: Wrapper]
	
	var _element = ds_map_create();
	var _value = [["KeyA", -999], ["KeyB", 0.00000000000000000000000001]];
	
	ds_map_add(_element, _value[0][0], _value[0][1]);
	ds_map_add(_element, _value[1][0], _value[1][1]);
	
	constructor = new Map(_element);
	
	var _result = [constructor.getValue(_value[0][0]), constructor.getValue(_value[1][0])];
	var _expectedValue = [_value[0][1], _value[1][1]];
	
	unitTest.assert_equal("Construction: Wrapper",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _value = [["Key1", "A"], ["Key2", -0.25]];
	
	constructor = [new Map()];
	constructor[0].add(_value[0][0], _value[0][1],
					   _value[1][0], _value[1][1]);
	constructor[1] = new Map(constructor[0]);
	
	var _result = [constructor[1].getValue(_value[0][0]), constructor[1].getValue(_value[1][0])];
	var _expectedValue = [_value[0][1], _value[1][1]];
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: isFunctional()]
	
	constructor = [new Map(), new Map()];
	constructor[1].destroy();
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional()];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	
#endregion
#region [Test: Method: destroy(Deep scan)]
	
	var _element = new List();
	var _value = [["List"], [-2.25]];
	
	_element.add(_value[1][0]);
	
	constructor = new Map();
	constructor.add(_value[0][0], _element);
	constructor.destroy(true);
	
	var _result = _element.isFunctional();
	var _expectedValue = false;
	
	unitTest.assert_equal("Method: destroy(Deep scan)",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: clear() / getSize()]
	
	var _value = [["Clear"], [true]];
	
	constructor = new Map();
	constructor.add(_value[0][0], _value[1][0]);
	
	var _result = [constructor.getSize()];
	var _expectedValue = [array_length(_value[0])];
	
	constructor.clear();
	
	array_push(_result, constructor.getSize());
	array_push(_expectedValue, 0);
	
	unitTest.assert_equal("Methods: clear() / getSize()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: contains()]
	
	var _value = [["Key", 1], [2]];
	
	constructor = new Map();
	constructor.add(_value[0][0], _value[0][1]);
	
	var _result = [constructor.contains(_value[0][1]), constructor.contains(_value[1][0])];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: contains()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: count()]
	
	var _value = [["Key1", "Key2", "Key3", "Key4", "Key5"], [3, 3, 3, 4, 5, 6]];
	
	constructor = new Map();
	
	var _i = 0;
	repeat (array_length(_value[0]))
	{
		constructor.add(_value[0][_i], _value[1][_i]);
		
		++_i;
	}
	
	var _result = constructor.count(_value[1][0], _value[1][3], _value[1][4], _value[1][5]);
	var _expectedValue = array_length(_value[0])
	
	unitTest.assert_equal("Method: count()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: getFirst() / getLast()]
	
	var _value = ["AA", "ZZ"];
	
	constructor = new Map();
	
	var _result = [constructor.getFirst(), constructor.getLast()];
	var _expectedValue = [undefined, undefined];
	
	constructor.add(_value[0], _value[0],
					_value[1], _value[1]);
	
	array_push(_result, constructor.getFirst(), constructor.getLast());
	array_push(_expectedValue, _value[0], _value[(array_length(_value) - 1)]);
	
	array_sort(_result, true);
	
	unitTest.assert_equal("Methods: getFirst() / getLast()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: getPrevious() / getNext()]
	
	var _value = ["AA", "QQ", "ZZ"];
	
	constructor = new Map();
	constructor.add(_value[0], _value[0],
					_value[1], _value[1],
					_value[2], _value[2]);
	
	var _key = [constructor.getFirst(), constructor.getLast()];
	var _result = [[_key[0]], [_key[1]]];
	
	repeat (constructor.getSize() - 1)
	{
		_key = [constructor.getNext(_key[0]), constructor.getPrevious(_key[1])];
		
		array_push(_result[0], _key[0]);
		array_push(_result[1], _key[1]);
	}
	
	array_sort(_result[0], true);
	array_sort(_result[1], false);
	
	var _expectedValue = [[_value[0], _value[1], _value[2]], [_value[2], _value[1], _value[0]]];
	
	unitTest.assert_equal("Methods: getPrevious / getLast()",
						  _result[0][0], _expectedValue[0][0],
						  _result[0][1], _expectedValue[0][1],
						  _result[0][2], _expectedValue[0][2],
						  _result[1][0], _expectedValue[1][0],
						  _result[1][1], _expectedValue[1][1],
						  _result[1][2], _expectedValue[1][2]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: getAllKeys()]
	
	var _value = [["Key1", 0.001], ["Key2", 0.002], ["Key3", 0.003]]
	
	constructor = new Map();
	constructor.add(_value[0][0], _value[0][1],
					_value[1][0], _value[1][1],
					_value[2][0], _value[2][1]);
	
	var _result = constructor.getAllKeys();
	
	array_sort(_result, true);
	
	var _expectedValue = [_value[0][0], _value[1][0], _value[2][0]];
	
	unitTest.assert_equal("Methods: getAllKeys()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: getAllValues()]
	
	var _value = [["Key1", 1], ["Key2", 2], ["Key3", 3]]
	
	constructor = new Map();
	constructor.add(_value[0][0], _value[0][1],
					_value[1][0], _value[1][1],
					_value[2][0], _value[2][1]);
	
	var _result = constructor.getAllValues();
	
	array_sort(_result, true);
	
	var _expectedValue = [_value[0][1], _value[1][1], _value[2][1]];
	
	unitTest.assert_equal("Methods: getAllValues()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: keyExists()]
	
	var _value = [["ExistingKey", 1], ["IrrelevantKey", 2], ["NonExistantKey"]];
	
	constructor = new Map();
	constructor.add(_value[0][0], _value[0][1],
					_value[1][1], _value[1][1]);
	
	var _result = [constructor.keyExists(_value[0][0]), constructor.keyExists(_value[2][0])];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: keyExists()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: addBoundList() / valueIsBoundList()]
	
	var _element = new List();
	var _value = [["List", _element], [1, 5, 7]];
	
	_element.add(_value[1][0], _value[1][1], _value[1][2]);
	
	constructor = new Map();
	constructor.addBoundList(_value[0][0], _value[0][1]);
	
	var _result = [constructor.valueIsBoundList(_value[0][00]), _element.isFunctional()];
	var _expectedValue = [true, true];
	
	constructor.destroy();
	
	_result[2] = _element.isFunctional();
	_expectedValue[2] = false;
	
	unitTest.assert_equal("Methods: addBoundList() / valueIsBoundList()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Methods: addBoundMap() / valueIsBoundMap()]
	
	var _element = new Map();
	var _value = [["Map", _element], ["SecondaryMapKey", 33]];
	
	_element.add(_value[1][0], _value[1][1]);
	
	constructor = new Map();
	constructor.addBoundMap(_value[0][0], _value[0][1]);
	
	var _result = [constructor.valueIsBoundMap(_value[0][00]), _element.isFunctional()];
	var _expectedValue = [true, true];
	
	constructor.destroy();
	
	_result[2] = _element.isFunctional();
	_expectedValue[2] = false;
	
	unitTest.assert_equal("Methods: addBoundMap() / valueIsBoundMap()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: isEmpty()]
	
	var _value = ["Key1", 0];
	
	constructor = [new Map(), new Map()];
	constructor[0].add(_value[0], _value[1]);
	
	var _result = [constructor[0].isEmpty(), constructor[1].isEmpty()];
	var _expectedValue = [false, true];
	
	unitTest.assert_equal("Methods: isEmpty()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: forEach() / Method: set()]
	
	var _value = [["Key1", 33], ["Key2", -33]];
	
	constructor = new Map();
	constructor.add(_value[0][0], _value[0][1],
					_value[1][0], _value[1][1]);
	
	constructor.forEach
	(
		function(_i, _key, _value)
		{
			if (_value > 0)
			{
				constructor.set(_key, (-_value));
			}
		}
	);
	
	var _result = constructor.getAllValues();
	
	array_sort(_result, true);
	
	var _expectedValue = [(-abs(_value[0][1])), (-abs(_value[1][1]))];
	
	unitTest.assert_equal("Methods: forEach()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: replace()]
	
	var _element = [[new List(), new Map()], [new List(), new Map()]];
	var _value = [["NumberKey", 12, 25], ["ListKey", _element[0][0], _element[1][0]],
				  ["MapKey", _element[0][1], _element[1][1]], ["NonExistantKey"]];
	
	constructor = new Map();
	constructor.add(_value[0][0], _value[0][1]);
	constructor.addBoundList(_value[1][0], _value[1][1]);
	constructor.addBoundMap(_value[2][0], _value[2][1]);
	
	constructor.replace(_value[0][0], _value[0][2],
						_value[1][0], _value[1][2],
						_value[2][0], _value[2][2]);
	
	var _result = [constructor.getValue(_value[0][0]), constructor.getValue(_value[1][0]),
				   constructor.getValue(_value[2][0]), constructor.keyExists(_value[3])];
				   
	var _expectedValue = [_value[0][2], _value[1][2].ID, _value[2][2].ID, false];
	
	constructor.destroy();
	
	array_push(_result, _element[1][0].isFunctional(), _element[1][1].isFunctional());
	array_push(_expectedValue, false, false);
	
	unitTest.assert_equal("Method: replace()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
	_element[0][0].destroy();
	_element[0][1].destroy();
	
#endregion
#region [Test: Method: remove()]
	
	var _value = [["KeptKey", 3], ["RemovedKey1", 33], ["RemovedKey2", 333]];
	
	constructor = new Map();
	constructor.add(_value[0][0], _value[0][1],
					_value[1][0], _value[1][1],
					_value[2][0], _value[2][1]);
	
	var _result = [constructor.keyExists(_value[1][0]), constructor.keyExists(_value[2][0])];
	var _expectedValue = [true, true];
	
	constructor.remove(_value[1][0], _value[2][0]);
	
	array_push(_result, constructor.keyExists(_value[0][0]), constructor.keyExists(_value[1][0]),
			   constructor.keyExists(_value[2][0]));
	array_push(_expectedValue, true, false, false);
	
	unitTest.assert_equal("Method: remove()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: toString()]
	
	var _value = 1;
	
	constructor = new Map();
	constructor.add(_value, _value);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName + "(" + string(1) + " - " + string(_value) + ": " +
						  string(_value) + ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: toString(lenght cut)]
	
	var _element = [[30, "...", ": "], ["LengthyKey"]];
	var _value = [[_element[1][0]],
				  [string_repeat("I", (_element[0][0] + string_length(_element[0][1]) -
				   string_length(_element[0][2]) - string_length(_element[1][0])) + 1),
				   string_repeat("I", (_element[0][0] + string_length(_element[0][1]) -
				   string_length(_element[0][2]) - string_length(_element[1][0])))],
				  [string_repeat("I", (_element[0][0] - string_length(_element[0][2]) -
				   string_length(_element[1][0])))]];
	
	constructor = [new Map(), new Map()];
	constructor[0].add(_value[0][0], _value[1][0]);
	constructor[1].add(_value[0][0], _value[1][1]);
	
	var _result = [constructor[0].toString(false, undefined, _element[0][0], undefined,
										   _element[0][1], undefined, undefined, _element[0][2]),
				   constructor[1].toString(false, undefined, _element[0][0], undefined,
										   _element[0][1], undefined, undefined, _element[0][2])];
	var _expectedValue = [(constructorName + "(" + string(1) + " - " + string(_value[0][0]) + ": " +
						   _value[2][0] + _element[0][1] + ")"),
						  (constructorName + "(" + string(1) + " - " + string(_value[0][0]) + ": " +
						   _value[1][1] + ")")];
	
	unitTest.assert_equal("Method: toString(lenght cut)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: toString(multiline)]
	
	var _element = ": ";
	var _value = ["Key1", 250];
	
	constructor = new Map();
	constructor.add(_value[0], _value[1]);
	
	var _result = constructor.toString(true, all, all, undefined, undefined, undefined, undefined,
									   _element);
	var _expectedValue = (string(_value[0]) + _element + string(_value[1]) + "\n");
	
	unitTest.assert_equal("Method: toString(multiline)",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: fromArray() / toArray()]
	
	var _value = [["Key1", -99], ["Key2", 0.9999999999], ["Key3", "A"]];
	
	constructor = [new Map(), new Map()];
	constructor[0].add(_value[0][0], _value[0][1],
					   _value[1][0], _value[1][1],
					   _value[2][0], _value[2][1]);
	
	constructor[1].fromArray(constructor[0].toArray());
	
	var _result = [constructor[1].getValue(_value[0][0]), constructor[1].getValue(_value[1][0]),
				   constructor[1].getValue(_value[2][0])];
	var _expectedValue = [_value[0][1], _value[1][1], _value[2][1]];
	
	unitTest.assert_equal("Methods: toArray() / fromArray()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Methods: fromEncodedString() / toEncodedString()]
	
	var _value = [["Key1", -2], ["Key2", 0.2], ["Key3", "X"]];
	
	constructor = [new Map(), new Map()];
	constructor[0].add(_value[0][0], _value[0][1],
					   _value[1][0], _value[1][1],
					   _value[2][0], _value[2][1]);
	
	constructor[1].fromEncodedString(constructor[0].toEncodedString());
	
	var _result = [constructor[1].getValue(_value[0][0]), constructor[1].getValue(_value[1][0]),
				   constructor[1].getValue(_value[2][0])];
	var _expectedValue = [_value[0][1], _value[1][1], _value[2][1]];
	
	unitTest.assert_equal("Methods: toEncodedString() / fromEncodedString()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Methods: secureToFile() / secureFromFile()]
	
	var _element = "MapUnitTest_secureToFile.dat";
	var _value = [["Key1", -0.111111], ["Key2", 0.00002]];
	
	if (file_exists(_element))
	{
		file_delete(_element);
	}
	
	constructor = [new Map(), new Map()];
	constructor[0].add(_value[0][0], _value[0][1],
					   _value[1][0], _value[1][1]);
	constructor[0].secureToFile(_element);
	constructor[1].secureFromFile(_element);
	
	var _result = [constructor[1].getValue(_value[0][0]), constructor[1].getValue(_value[1][0]),
				   file_exists(_element)];
	var _expectedValue = [_value[0][1], _value[1][1], true];
	
	unitTest.assert_equal("Methods: secureToFile() / secureFromFile()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
	if (file_exists(_element))
	{
		file_delete(_element);
	}
	
#endregion
#region [Test: Methods: secureFromBuffer()]
	
	var _element = [new Buffer(1, buffer_grow, 1), new Buffer(1, buffer_grow, 1),
					"MapUnitTest_secureToBuffer.dat"];
	var _value = ["Key1", "A"];
	
	if (file_exists(_element[2]))
	{
		file_delete(_element[2]);
	}
	
	constructor = [new Map(), new Map()];
	constructor[0].add(_value[0], _value[1]);
	_element[0].secureFromMap(constructor[0]);
	_element[0].toFile(_element[2]);
	_element[1].fromFile(_element[2]);
	constructor[1].secureFromBuffer(_element[1]);
	
	var _result = constructor[1].getValue(_value[0]);
	var _expectedValue = _value[1];
	
	unitTest.assert_equal("Methods: secureToBuffer() / secureFromBuffer()",
						  _result, _expectedValue);
	
	constructor[0].destroy();
	constructor[1].destroy();
	_element[0].destroy();
	_element[1].destroy();
	
	if (file_exists(_element[2]))
	{
		file_delete(_element[2]);
	}
	
#endregion
