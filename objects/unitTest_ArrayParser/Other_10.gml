/// @description Unit Testing
#region [Test: Construction: New constructor]
	
	var _value = [1, 3, 5];
	
	constructor = new ArrayParser([_value[0], _value[1], _value[2]]);
	
	var _result = constructor.ID;
	var _expectedValue = _value;
	
	unitTest.assert_equal("Construction: New constructor",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Construction: Empty]
	
	constructor = new ArrayParser();
	
	var _result = constructor.ID;
	var _expectedValue = [];
	
	unitTest.assert_equal("Construction: Empty",
						  _result, _expectedValue);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _value = [1, 3, 5];
	
	constructor = [new ArrayParser(_value)];
	constructor[1] = new ArrayParser(constructor[0]);
	
	var _result = constructor[1].ID;
	var _expectedValue = _value;
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: isFunctional()]
	
	constructor = new ArrayParser();
	
	var _result = constructor.isFunctional();
	var _expectedValue = true;
	
	unitTest.assert_equal("Method: isFunctional()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: create()]
	
	var _value = 5;
	
	constructor = new ArrayParser();
	constructor.create(_value, _value);
	
	var _result = [array_length(constructor.ID), constructor.ID[0],
				   constructor.ID[1], constructor.ID[2], constructor.ID[3], constructor.ID[4]];
	var _expectedValue = [_value, _value, _value, _value, _value, _value];
	
	unitTest.assert_equal("Method: create()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4]);
	
#endregion
#region [Test: Method: clear()]
	
	var _value = [2, 5];
	
	constructor = new ArrayParser([_value[0], _value[1]]);
	
	var _result = [array_length(constructor.ID)];
	var _expectedValue = [2];
	
	constructor.clear();
	
	array_push(_result, array_length(constructor.ID));
	array_push(_expectedValue, 0);
	
	unitTest.assert_equal("Method: clear()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: copy(full, from array)]
	
	var _value = [2, 5, 6, "ABC", 255555, [2567.0943]];
	
	constructor = new ArrayParser();
	constructor.copy(_value);
	
	var _result = constructor.ID;
	var _expectedValue = [_value[0], _value[1], _value[2], _value[3], _value[4], _value[5]];
	
	unitTest.assert_equal("Method: copy(full, from array)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
#endregion
#region [Test: Method: copy(part, from self)]
	
	var _value = [-5.56, "A", [25, -26]];
	
	constructor = new ArrayParser([_value[0], _value[1], _value[2]]);
	constructor.copy(constructor, 0, 1, 1);
	
	var _result = constructor.ID;
	var _expectedValue = [_value[1], _value[1], _value[2]];
	
	unitTest.assert_equal("Method: copy(part, from self)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: getSize()]
	
	var _value = 20;
	
	constructor = new ArrayParser();
	constructor.create(_value, _value);
	
	var _result = constructor.getSize();
	var _expectedValue = _value;
	
	unitTest.assert_equal("Method: getSize()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: equals()]
	
	var _value = [[2, 5], [5, 2]];
	
	constructor = [new ArrayParser([_value[0][0], _value[0][1]]),
				   new ArrayParser([_value[1][0], _value[1][0]])];
	
	var _result = [constructor[0].equals(constructor[0]), constructor[0].equals(constructor[1])];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: equals",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: getValue()]
	
	var _value = [2, 3];
	var _element = 1;
	
	constructor = new ArrayParser([_value[0], _value[1]]);
	
	var _result = constructor.getValue(_element);
	var _expectedValue = _value[_element];
	
	unitTest.assert_equal("Method: getValue()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: setSize()]
	
	var _element = [5, 2];
	
	constructor = new ArrayParser();
	constructor.setSize(_element[0]);
	
	var _result = [constructor.getSize()];
	var _expectedValue = [_element[0]];
	
	constructor.setSize(_element[1]);
	
	array_push(_result, constructor.getSize());
	array_push(_expectedValue, _element[1]);
	
	unitTest.assert_equal("Method: setSize()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: add()]
	
	var _value = [5, 3, 1];
	
	constructor = new ArrayParser();
	constructor.add(_value[0], _value[1], _value[2]);
	
	var _result = [constructor.getValue(0), constructor.getValue(1), constructor.getValue(2)];
	var _expectedValue = [_value[0], _value[1], _value[2]];
	
	unitTest.assert_equal("Method: add()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: set()]
	
	var _value = [[5, 2.2, 1], ["X"]];
	var _element = [1, 5];
	
	constructor = new ArrayParser([_value[0][0], _value[0][1], _value[0][1]]);
	constructor.set(_value[1][0], _element[0]);
	constructor.set(_value[1][0], _element[1]);
	
	var _result = [constructor.getValue(_element[0]), constructor.getValue(_element[1]),
				   constructor.getValue((_element[1] - 1))];
	var _expectedValue = [_value[1][0], _value[1][0], 0];
	
	unitTest.assert_equal("Method: set()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: insert()]
	
	var _value = [[1, 2, 3, 4, 5], ["A", "B", "C"]];
	var _element = 1;
	
	constructor = new ArrayParser([_value[0][0], _value[0][1], _value[0][2], _value[0][3],
								   _value[0][4]]);
	constructor.insert(_element, _value[1][0], _value[1][1], _value[1][2]);
	
	var _result = [constructor.getValue((_element - 1)), constructor.getValue(_element),
				   constructor.getValue((_element + 1)), constructor.getValue((_element + 2)),
				   constructor.getValue((_element + 3)), constructor.getValue((_element + 4))];
	
	var _expectedValue = [_value[0][(_element - 1)], _value[1][0], _value[1][1], _value[1][2],
						  _value[0][_element], _value[0][(_element + 1)]];
	
	unitTest.assert_equal("Method: insert()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
#endregion
#region [Test: Method: remove(multiple)]
	
	var _value = [1, 2, 3, 4, 5];
	
	constructor = new ArrayParser([_value[0], _value[1], _value[2], _value[3], _value[4]]);
	
	var _result = constructor.remove(1, 3);
	var _expectedValue = [_value[1], _value[2], _value[3]];
	
	unitTest.assert_equal("Method: remove(multiple)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: remove(single)]
	
	var _value = ["A", "B.190", "FC"];
	
	constructor = new ArrayParser([_value[0], _value[1], _value[2]]);
	
	var _result = constructor.remove();
	var _expectedValue = _value[0];
	
	unitTest.assert_equal("Method: remove(single)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: sort(numbers)]
	
	var _value = [10377, 0, 2.6, -0.9];
	
	constructor = new ArrayParser([_value[0], _value[1], _value[2], _value[3]]);
	constructor.sort(true);
	
	var _result = constructor.ID;
	var _expectedValue = [_value[3], _value[1], _value[2], _value[0]];
	
	unitTest.assert_equal("Method: sort(numbers)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: sort(strings)]
	
	var _value = ["Z", "AAAAAA", "CCC", "B"];
	
	constructor = new ArrayParser([_value[0], _value[1], _value[2], _value[3]]);
	constructor.sort(false);
	
	var _result = constructor.ID;
	var _expectedValue = [_value[0], _value[2], _value[3], _value[1]];
	
	unitTest.assert_equal("Method: sort(strings)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: sort(function)]
	
	var _value = [1, 5, 6, -2];
	
	constructor = new ArrayParser([_value[0], _value[1], _value[2], _value[3]]);
	constructor.sort(function() {return (argument[0] - argument[1]);});
	
	var _result = constructor.ID;
	var _expectedValue = [_value[3], _value[0], _value[1], _value[2]];
	
	unitTest.assert_equal("Method: sort(function)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: String conversion]
	
	var _value = [0.33, 2, 1, 49];
	
	constructor = new ArrayParser([_value[0], _value[1], _value[2], _value[3]]);
	
	var _result = string(constructor);
	var _expectedValue = (constructorName + "(" + string(_value[0]) + ", " + string(_value[1]) +
						  ", " + string(_value[2]) + ", " + + string(_value[3]) + ")");
	
	unitTest.assert_equal("String conversion",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(lenght cut)]
	
	var _element = [30, "..."];
	var _value = [[string_repeat("I", (_element[0] + string_length(_element[1]))),
				   string_repeat("I", (_element[0] + string_length(_element[1]) - 1))],
				  [string_repeat("I", _element[0])]];
	
	constructor = [new ArrayParser([_value[0][0]]), new ArrayParser([_value[0][1]])];
	
	var _result = [constructor[0].toString(false, undefined, _element[0], undefined, _element[1]),
				   constructor[1].toString(false, undefined, _element[0], undefined, _element[1])];
	var _expectedValue = [(constructorName + "(" + _value[1][0] + _element[1] + ")"),
						  (constructorName + "(" + _value[0][1] + ")")];
	
	unitTest.assert_equal("Method: toString(lenght cut)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: toString(multiline)]
	
	var _value = ["ABC", 26, "HH", 25.9];
	
	constructor = new ArrayParser([_value[0], _value[1], _value[2], _value[3]]);
	
	var _result = constructor.toString(true);
	var _expectedValue = (string(_value[0]) + "\n" + string(_value[1]) + "\n" + string(_value[2]) +
						 "\n" + string(_value[3]) + "\n");
	
	unitTest.assert_equal("Method: toString(multiline)",
						  _result, _expectedValue);
	
#endregion
