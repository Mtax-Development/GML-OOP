/// @description Unit Testing
#region [Test: Construction: New constructor]
	
	var _value = "A3B";
	
	constructor = new StringParser(_value);
	
	var _result = constructor.ID;
	var _expectedValue = _value;
	
	unitTest.assert_equal("Construction: New constructor",
						  _result, _expectedValue);
	
#endregion
#region [Test: Construction: Empty]
	
	constructor = new StringParser();
	
	var _result = constructor.ID;
	var _expectedValue = "";
	
	unitTest.assert_equal("Construction: Empty",
						  _result, _expectedValue);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _value = string(3.56);
	
	constructor = [new StringParser(_value)];
	constructor[1] = new StringParser(constructor[0]);
	
	var _result = constructor[1].ID;
	var _expectedValue = _value
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: isFunctional()]
	
	constructor = new StringParser();
	
	var _result = [constructor.isFunctional()];
	var _expectedValue = [true];
	
	constructor.ID = undefined;
	
	array_push(_result, constructor.isFunctional());
	array_push(_expectedValue, false);
	
	unitTest.assert_equal("Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Methods: setByte() / getByte()]
	
	var _value = "###";
	var _element = [2, 97];
	
	constructor = new StringParser(_value);
	constructor.setByte(_element[0], _element[1]);
	
	var _result = constructor.getByte(_element[0]);
	var _expectedValue = _element[1];
	
	unitTest.assert_equal("Methods: setByte() / getByte()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Methods: getByteLength()]
	
	var _value = "0";
	
	constructor = new StringParser(_value);
	
	var _result = constructor.getByteLength();
	var _expectedValue = 1;
	
	unitTest.assert_equal("Method: getByteLength()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getChar()]
	
	var _value = ["A", "B", "C"];
	var _element = 1;
	
	constructor = new StringParser((_value[0] + _value[1] + _value[2]));
	
	var _result = constructor.getChar(_element);
	var _expectedValue = _value[(_element - 1)];
	
	unitTest.assert_equal("Method: getChar()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getOrd()]
	
	var _value = ["Z", "X", "Y"];
	var _element = 2;
	
	constructor = new StringParser((_value[0] + _value[1] + _value[2]));
	
	var _result = constructor.getOrd(_element);
	var _expectedValue = ord(_value[(_element - 1)]);
	
	unitTest.assert_equal("Method: getOrd()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getPart()]
	
	var _value = ["A", "b", "c", "d"];
	var _element = [2, 3];
	
	constructor = new StringParser((_value[0] + _value[1] + _value[2] + _value[3]));
	
	var _result = constructor.getPart(_element[0], _element[1]);
	var _expectedValue = (_value[_element[0] - 1] + _value[_element[0]] + _value[_element[0] + 1]);
	
	unitTest.assert_equal("Method: getPart()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getSubstringCount()]
	
	var _value = "ABCABC";
	var _element = "A";
	
	constructor = new StringParser(_value);
	
	var _result = constructor.getSubstringCount(_element);
	var _expectedValue = 2;
	
	unitTest.assert_equal("Method: getSubstringCount",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getDigits()]
	
	var _value = ["A", "111", "BC"];
	
	constructor = new StringParser((_value[0] + _value[1] + _value[2]));
	
	var _result = constructor.getDigits(_element);
	var _expectedValue = _value[1];
	
	unitTest.assert_equal("Method: getDigits",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getSize()]
	
	var _value = ["1", "2", "3", "4"];
	
	constructor = new StringParser((_value[0] + _value[1] + _value[2] + _value[3]));
	
	var _result = constructor.getSize();
	var _expectedValue = array_length(_value);
	
	unitTest.assert_equal("Method: getSize",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getLetters()]
	
	var _value = ["V", "111", "B", "C"];
	
	constructor = new StringParser((_value[0] + _value[1] + _value[2] + _value[3]));
	
	var _result = constructor.getLetters(_element);
	var _expectedValue = (_value[0] + _value[2] + _value[3]);
	
	unitTest.assert_equal("Method: getDigits",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getLettersAndDigits()]
	
	var _value = ["123A", " ", "A321"];
	
	constructor = new StringParser((_value[0] + _value[1] + _value[2]));
	
	var _result = constructor.getLettersAndDigits(_element);
	var _expectedValue = (_value[0] + _value[2]);
	
	unitTest.assert_equal("Method: getLettersAndDigits",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getSubstringPosition()]
	
	var _value = ["A", "~ ", "!A~", "~ ", "1.1"];
	var _element = _value[1];
	
	constructor = new StringParser((_value[0] + _value[1] + _value[2] + _value[3] + _value[4]));
	
	var _result = [constructor.getSubstringPosition(_element, false),
				   constructor.getSubstringPosition(_element, true),
				   constructor.getSubstringPosition(_element, false, string_length(_element))];
	var _expectedValue = [2, 7, 7];
	
	unitTest.assert_equal("Method: getSubstringPosition()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: getPixelSize()]
	
	var _value = "ABC";
	
	constructor = new StringParser(_value);
	
	var _result = constructor.getPixelSize();
	var _expectedValue = new Vector2(string_width(_value), string_height(_value));
	
	unitTest.assert_equal("Method: getPixelSize()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: charIsWhitespace()]
	
	var _value = " A";
	
	constructor = new StringParser(_value);
	
	var _result = [constructor.charIsWhitespace(1),
				   constructor.charIsWhitespace(string_length(_value))];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: charIsWhitespace()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: charEquals()]
	
	var _value = ["A", "3", "B"];
	var _element = 1;
	
	constructor = new StringParser((_value[0] + _value[1] + _value[2]));
	
	var _result = [constructor.charEquals(_element, _value[(_element - 1)]),
				   constructor.charEquals(_element, _value[(_element)])];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: charEquals()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: split()]
	
	var _value = ["ABC", "-", "CBA", "-", "XYZ", "-"];
	
	constructor = new StringParser((_value[0] + _value[1] + _value[2] + _value[3] + _value[4] +
									_value[5]));
	
	var _result = constructor.split(_value[1]);
	var _expectedValue = [_value[0], _value[2], _value[4]];
	
	unitTest.assert_equal("Method: split()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: setByte()]
	
	var _value = ["A", "B"];
	
	constructor = new StringParser((_value[0] + _value[1]));
	
	var _result = constructor.setByte((array_length(_value)), constructor.getByte(1));
	var _expectedValue = (_value[0] + _value[0]);
	
	unitTest.assert_equal("Method: setByte()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: remove()]
	
	var _value = ["1", "ABC", "1234"];
	var _element = 2;
	
	constructor = new StringParser((_value[0] + _value[1] + _value[2]));
	
	var _result = constructor.remove(_element, string_length(_value[1]));
	var _expectedValue = (_value[0] + _value[2]);
	
	unitTest.assert_equal("Method: remove()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: insert()]
	
	var _value = [12.0009, "12.0009"];
	var _element = [2, 4];
	
	constructor = new StringParser();
	constructor.formatNumber(_value[0], _element[0], _element[1], true);
	
	var _result = constructor.ID;
	var _expectedValue = _value[1];
	
	unitTest.assert_equal("Method: insert()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: duplicate()]
	
	var _value = "AB";
	var _element = [3, "-"];
	
	constructor = new StringParser(_value);
	
	var _result = constructor.duplicate(_element[0], _element[1]);
	var _expectedValue = _value;
	
	repeat (_element[0])
	{
		_expectedValue += (_element[1] + _value);
	}
	
	unitTest.assert_equal("Method: duplicate()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: replace()]
	
	var _value = ["A", "X", "A-BC", "X", "$$$", "X"];
	var _element = [_value[1], "O", 2];
	
	constructor = new StringParser(_value[0] + _value[1] + _value[2] + _value[3] + _value[4] +
								   _value[5]);
	
	var _result = constructor.replace(_element[0], _element[1], _element[2]);
	var _expectedValue = (_value[0] + _element[1] + _value[2] + _element[1] + _value[4] + _value[5]);
	
	unitTest.assert_equal("Method: replace()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: reverse()]
	
	var _value = ["A", "B", "C", "D", "E"];
	
	constructor = new StringParser((_value[0] + _value[1] + _value[2] + _value[3] + _value[4]));
	var _result = constructor.reverse();
	var _expectedValue = (_value[4] + _value[3] + _value[2] + _value[1] + _value[0]);
	
	unitTest.assert_equal("Method: reverse()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: trim()]
	
	var _value = [["  ", "$", "AB", "$$ "], [" ", "~!", "  "], ["  ", "XX", " "], [" "], ["A"]];
	var _element = _value[0][1];
	
	constructor = [new StringParser((_value[0][0] + _value[0][1] + _value[0][2] +
									_value[0][3])),
				   new StringParser((_value[1][0] + _value[1][1] + _value[1][2])),
				   new StringParser((_value[2][0] + _value[2][1] + _value[2][2])),
				   new StringParser(_value[3][0]),
				   new StringParser(_value[4][0])];
	
	constructor[0].trim();
	constructor[0].trim(_element);
	constructor[1].trim();
	constructor[2].trim();
	constructor[3].trim();
	constructor[4].trim();
	
	var _result = [constructor[0].ID, constructor[1].ID, constructor[2].ID, constructor[3].ID,
				   constructor[4].ID];
	var _expectedValue = [_value[0][2], _value[1][1], _value[2][1], "", _value[4][0]];
	
	unitTest.assert_equal("Method: trim()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4]);
	
#endregion
#region [Test: Method: setLowercase()]
	
	var _value = ["ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz"];
	
	constructor = new StringParser(_value[0]);
	
	var _result = constructor.setLowercase();
	var _expectedValue = _value[1];
	
	unitTest.assert_equal("Method: setLowercase()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: setUppercase()]
	
	var _value = ["abcdefghijklmnopqrstuvwxyz", "ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
	
	constructor = new StringParser(_value[0]);
	
	var _result = constructor.setUppercase();
	var _expectedValue = _value[1];
	
	unitTest.assert_equal("Method: setUppercase()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: forEach()]
	
	var _value = ["A", "b", "c"];
	var _element = [];
	
	constructor = new StringParser((_value[0] + _value[1] + _value[2]));
	constructor.forEach
	(
		function(_i, _value, _element)
		{
			_element[@ (_i - 1)] = string_byte_at(_value, 1);
		},
		_element
	);
	
	var _result = _element;
	var _expectedValue = [string_byte_at(_value[0], 1), string_byte_at(_value[1], 1),
						  string_byte_at(_value[2], 1)];
	
	unitTest.assert_equal("Method: forEach()",
						  _result, _expectedValue);
	
#endregion
#region [Untestable: Method: displayOutput()]
	
	unitTest.assert_untestable("Method: displayOutput()");
	
#endregion
#region [Untestable: Method: displayMessageBox()]
	
	unitTest.assert_untestable("Method: displayMessageBox()");
	
#endregion
#region [Test: Method: toString()]
	
	var _value = "ABCa.02";
	
	constructor = new StringParser(_value);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName + "(" + _value + ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(lenght cut)]
	
	var _element = [30, "..."];
	var _value = [[string_repeat("I", (_element[0] + string_length(_element[1]))),
				   string_repeat("I", (_element[0] + string_length(_element[1]) - 1))],
				  [string_repeat("I", _element[0])]];
	
	constructor = [new StringParser(_value[0][0]), new StringParser(_value[0][1])];
	
	var _result = [constructor[0].toString(false, _element[0], _element[1]),
				   constructor[1].toString(false, _element[0], _element[1])];
	var _expectedValue = [(constructorName + "(" + _value[1][0] + _element[1] + ")"),
						  (constructorName + "(" + _value[0][1] + ")")];
	
	unitTest.assert_equal("Method: toString(lenght cut)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: toString(multiline)]
	
	var _value = "abcdefghijklm\nopqrstuvwxyz";
	
	constructor = new StringParser(_value);
	
	var _result = constructor.toString(true, all);
	var _expectedValue = _value;
	
	unitTest.assert_equal("Method: toString(multiline)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toNumber()]
	
	var _value = ["33.02", 33.02];
	
	constructor = new StringParser(_value[0]);
	
	var _result = constructor.toNumber();
	var _expectedValue = _value[1];
	
	unitTest.assert_equal("Method: toNumber()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Methods: toArray() / fromArray()]
	
	var _value = "A3.509BC-~!";
	
	constructor = [new StringParser(_value), new StringParser()];
	constructor[1].fromArray(constructor[0].toArray());
	
	var _result = constructor[1].ID;
	var _expectedValue = _value;
	
	unitTest.assert_equal("Methods: toArray() / fromArray()",
						  _result, _expectedValue);
	
#endregion
