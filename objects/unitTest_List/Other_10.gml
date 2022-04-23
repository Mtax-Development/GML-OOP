/// @description Unit Testing
#region [Test: Construction: New constructor / Destruction]
	
	constructor = new List();
	
	var _result = [ds_exists(constructor.ID, ds_type_list)];
	var _expectedValue = [true];
	
	constructor.destroy();
	
	array_push(_result, constructor.ID);
	array_push(_expectedValue, undefined);
	
	unitTest.assert_equal("Construction: New constructor / Destruction",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Value write/read]
	
	var _value = [5, 6, "ABC"];
	
	constructor = new List();
	constructor.add(_value[0], _value[1], _value[2]);
	
	var _result = [constructor.getValue(0), constructor.getValue(1), constructor.getValue(2)];
	var _expectedValue = [_value[0], _value[1], _value[2]];
	
	unitTest.assert_equal("Value write/read",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: Construction: Wrapper]
	
	var _element = ds_list_create();
	var _value = [-5, 0.65, 0, 255];
	
	ds_list_add(_element, _value[0], _value[1], _value[2], _value[3]);
	
	constructor = new List(_element);
	
	var _result = [constructor.getValue(0), constructor.getValue(1),
				   constructor.getValue(2), constructor.getValue(3)];
	var _expectedValue = [_value[0], _value[1], _value[2], _value[3]];
	
	unitTest.assert_equal("Construction: Wrapper",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
	constructor.destroy();
	
#endregion
#region [Test: Construction: Empty]
	
	constructor = new List(undefined);
	
	var _result = constructor.ID;
	var _expectedValue = undefined;
	
	unitTest.assert_equal("Construction: Empty",
						  _result, _expectedValue);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _value = [-5, 0.65, "ZYX"];
	
	constructor = [new List()];
	constructor[0].add(_value[0], _value[1], _value[2]);
	constructor[1] = new List(constructor[0]);
	
	var _result = [constructor[1].getValue(0), constructor[1].getValue(1),
				   constructor[1].getValue(2)];
	var _expectedValue = [_value[0], _value[1], _value[2]];
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: isFunctional()]
	
	constructor = [new List(), new List()];
	constructor[1].destroy();
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional()];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	
#endregion
#region [Test: Method: destroy(deep scan)]
	
	var _element = new List();
	var _value = -2.25;
	
	_element.add(_value);
	
	constructor = new List();
	constructor.add(_element);
	constructor.destroy(true);
	
	var _result = _element.isFunctional();
	var _expectedValue = false;
	
	unitTest.assert_equal("Method: destroy(deep scan)",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: clear() / getSize()]
	
	var _value = [-22.15, 555555, 30, string(undefined), undefined];
	
	constructor = new List();
	constructor.add(_value[0], _value[1], _value[2], _value[3], _value[4]);
	
	var _result = [constructor.getSize()];
	var _expectedValue = [array_length(_value)];
	
	constructor.clear();
	
	array_push(_result, constructor.getSize());
	array_push(_expectedValue, 0);
	
	unitTest.assert_equal("Method: clear()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: copy()]
	
	var _value = [5, "GML-OOP", -5];
	
	constructor = [new List(), new List()];
	
	constructor[0].add(_value[0], _value[1], _value[2]);
	constructor[1].copy(constructor[0]);
	constructor[0].clear();
	
	var _result = [constructor[1].getValue(0), constructor[1].getValue(1),
				   constructor[1].getValue(2)];
	var _expectedValue = [_value[0], _value[1], _value[2]];
	
	unitTest.assert_equal("Method: copy()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: contains()]
	
	var _value = ["ABC", 35];
	
	constructor = new List();
	constructor.add(_value[0]);
	
	var _result = [constructor.contains(_value[0]), constructor.contains(_value[1])];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: contains()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: count()]
	
	var _value = [["GML-OOP", 5, -9, -5], [32, 55, 1]];
	
	constructor = new List();
	
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
#region [Test: Methods: getFirst() / getLast()]
	
	var _value = [string(-4), 5, ".", 53.5689];
	
	constructor = new List();
	
	var _result = [constructor.getFirst(), constructor.getLast()];
	var _expectedValue = [undefined, undefined];
	
	constructor.add(_value[0], _value[1], _value[2], _value[3]);
	
	array_push(_result, constructor.getFirst(), constructor.getLast());
	array_push(_expectedValue, _value[0], _value[(array_length(_value) - 1)]);
	
	unitTest.assert_equal("Methods: getFirst() / getLast()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: getFirstPosition() / getPositions()]
	
	var _value = [[1], [0, 0, 1, -2, 1, -3, 1, 2]];
	
	constructor = new List();
	constructor.add(_value[1][0], _value[1][1], _value[1][2], _value[1][3], _value[1][4],
					_value[1][5], _value[1][6], _value[1][7]);
	
	var _result = [constructor.getFirstPosition(_value[0][0]),
				   constructor.getPositions(_value[0][0])];
	var _expectedValue = [2, [2, 4, 6]];
	
	unitTest.assert_equal("Methods: getFirstPosition() / getPositions()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: getValue()]
	
	var _value = [1, -2, 1];
	
	constructor = [new List(), new List()];
	constructor[0].add(_value[0], _value[1], _value[2]);
	
	var _result = [constructor[0].getValue((array_length(_value) - 1)), constructor[1].getValue(0)];
	var _expectedValue = [_value[(array_length(_value) - 1)], undefined];
	
	unitTest.assert_equal("Method: getValue()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: isEmpty()]
	
	var _value = -3;
	
	constructor = [new List(), new List()];
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
	
	var _value = [11, 355, -99];
	
	constructor = new List()
	constructor.add(_value[0], _value[1], _value[2]);
	
	constructor.forEach
	(
		function(_i, _value)
		{
			if (_value < 0)
			{
				constructor.add(_value);
			}
		}
	);
	
	var _result = constructor.getPositions(_value[2]);
	var _expectedValue = [2, 3];
	
	unitTest.assert_equal("Method: forEach()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: set()]
	
	var _element = 0;
	var _value = -23.25;
	
	constructor = new List();
	constructor.add(_value);
	
	var _result = [constructor.getValue(_element)];
	var _expectedValue = [_value];
	
	constructor.set(_element, (-_value));
	
	array_push(_result, constructor.getValue(_element));
	array_push(_expectedValue, -_value);
	
	unitTest.assert_equal("Method: set()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: replace()]
	
	var _element = 1;
	var _value = 2.5;
	
	constructor = new List();
	
	constructor.replace(_element, (-_value));
	
	var _result = [constructor.getSize()];
	var _expectedValue = [0];
	
	constructor.set(_element, _value);
	constructor.replace(_element, (-_value));
	
	array_push(_result, constructor.getValue(_element));
	array_push(_expectedValue, (-_value));
	
	unitTest.assert_equal("Method: replace()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: removePosition()]
	
	var _element = 1;
	var _value = [1, 2, 3];
	
	constructor = new List();
	constructor.add(_value[0], _value[1], _value[2]);
	constructor.removePosition(_element);
	
	var _result = constructor.getValue(_element);
	var _expectedValue = _value[(_element + 1)];
	
	unitTest.assert_equal("Method: removePosition()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: removeValue()]
	
	var _element = 1;
	var _value = [4, 5, 5, 6];
	
	constructor = new List();
	
	constructor.add(_value[0], _value[1], _value[2], _value[3]);
	constructor.removeValue(_element);
	
	var _result = [constructor.getValue((_element - 1)), constructor.getValue((_element + 1))];
	var _expectedValue = [_value[(_element - 1)], _value[(_element + 1)]];
	
	unitTest.assert_equal("Method: removeValue()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: insert()]
	
	var _element = 1;
	var _value = [[2, 3, 4], ["Q"]];
	
	constructor = new List();
	
	constructor.add(_value[0][0], _value[0][1], _value[0][2]);
	constructor.insert(_element, _value[1][0]);
	
	var _result = [constructor.getValue(0), constructor.getValue(1), constructor.getValue(2),
				   constructor.getValue(3)];
	var _expectedValue = [_value[0][0], _value[1][0], _value[0][1], _value[0][2]];
	
	unitTest.assert_equal("Method: insert()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: sort()]
	
	//|The built-in ds_list_sort() function is currently broken.
	// Ascending sorting will not affect the value order.
	var _value = ["XYZ", 1, "ABC", 5, "ABD"];
	
	constructor = [new List()];
	
	constructor[0].add(_value[0], _value[1], _value[2], _value[3], _value[4]);
	constructor[1] = new List(constructor[0]);
	constructor[0].sort(true);
	constructor[1].sort(false);
	
	var _result = [constructor[0].getValue(0), constructor[0].getValue(1), constructor[0].getValue(2),
				   constructor[0].getValue(3), constructor[0].getValue(4), constructor[1].getValue(0),
				   constructor[1].getValue(1), constructor[1].getValue(2), constructor[1].getValue(3),
				   constructor[1].getValue(4)];
	var _expectedValue = [_value[1], _value[3], _value[2], _value[4], _value[0],
						  _value[3], _value[1], _value[0], _value[4], _value[2]];
	
	unitTest.assert_equal("Method: sort(BROKEN IN ENGINE)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6],
						  _result[7], _expectedValue[7],
						  _result[8], _expectedValue[8],
						  _result[9], _expectedValue[9]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: shuffle()]
	
	//|This test checks results of a method with random results, based on a pre-determined seed.
	// It was not tested on every target platform. Due to difference in how seeds work between them,
	// there is a miniscule non-zero chance that assertion will declare a failure on some of them.
	var _element = 2000;
	var _value = 5355.5;
	
	constructor = [new List()];
	constructor[0].set(_element, _value);
	constructor[1] = new List(constructor[0]);
	random_set_seed(0);
	constructor[0].shuffle();
	random_set_seed(1);
	constructor[1].shuffle();
	
	var _result = [constructor[0].getFirstPosition(_value), constructor[1].getFirstPosition(_value)];
	var _expectedValue = [_element, _element];
	
	unitTest.assert_notEqual("Method: shuffle()",
							 _result[0], _expectedValue[0],
							 _result[1], _expectedValue[1],
							 _result[0], _result[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: toString()]
	
	var _value = [0.22, 1, 5, 99];
	
	constructor = new List();
	constructor.add(_value[0], _value[1], _value[2], _value[3]);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName + "(" + string(array_length(_value)) + " - " +
						  string(_value[0]) + ", " + string(_value[1]) + ", " + string(_value[2]) +
						  ", " + string(_value[3]) + ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: toString(lenght cut)]
	
	var _element = [30, "..."];
	var _value = [[string_repeat("I", (_element[0] + string_length(_element[1]) + 1)),
				   string_repeat("I", (_element[0] + string_length(_element[1])))],
				  [string_repeat("I", _element[0])]];
	
	constructor = [new List(), new List()];
	constructor[0].add(_value[0][0]);
	constructor[1].add(_value[0][1]);
	
	var _result = [constructor[0].toString(false, undefined, _element[0], undefined, _element[1]),
				   constructor[1].toString(false, undefined, _element[0], undefined, _element[1])];
	var _expectedValue = [(constructorName + "(" + string(1) + " - " + _value[1][0] + _element[1] +
						   ")"),
						  (constructorName + "(" + string(1) + " - " + _value[0][1] + ")")];
	
	unitTest.assert_equal("Method: toString(lenght cut)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: toString(multiline)]
	
	var _value = ["ABC", 356, "P", 55.9];
	
	constructor = new List();
	constructor.add(_value[0], _value[1], _value[2], _value[3]);
	
	var _result = constructor.toString(true);
	var _expectedValue = (string(_value[0]) + "\n" + string(_value[1]) + "\n" + string(_value[2]) +
						 "\n" + string(_value[3]) + "\n");
	
	unitTest.assert_equal("Method: toString(multiline)",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: toArray() / fromArray()]
	
	var _value = [33.3333355, "ZZZ", -99];
	
	constructor = [new List(), new List()];
	constructor[0].add(_value[0], _value[1], _value[2]);
	constructor[1].fromArray(constructor[0].toArray());
	
	var _result = [constructor[1].getValue(0), constructor[1].getValue(1),
				   constructor[1].getValue(2)];
	var _expectedValue = [_value[0], _value[1], _value[2]];
	
	unitTest.assert_equal("Methods: toArray() / fromArray()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Methods: toEncodedString() / fromEncodedString()]
	
	var _value = [22.3, "AA.A", 22];
	
	constructor = [new List(), new List()];
	constructor[0].add(_value[0], _value[1], _value[2]);
	constructor[1].fromEncodedString(constructor[0].toEncodedString());
	
	var _result = [constructor[1].getValue(0), constructor[1].getValue(1),
				   constructor[1].getValue(2)];
	var _expectedValue = [_value[0], _value[1], _value[2]];
	
	unitTest.assert_equal("Method: toEncodedString() / fromEncodedString()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
