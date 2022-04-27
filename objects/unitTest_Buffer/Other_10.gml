/// @description Unit Testing
#region [Test: Construction: New constructor / Destruction]
	
	var _base = [1, buffer_fixed, 1];
	
	constructor = new Buffer(_base[0], _base[1], _base[2]);
	
	var _result = [buffer_exists(constructor.ID)];
	var _expectedValue = [true];
	
	constructor.destroy();
	
	array_push(_result, buffer_exists(constructor.ID));
	array_push(_expectedValue, false);
	
	unitTest.assert_equal("Construction: New constructor / Destruction",
						  _result, _expectedValue);
	
#endregion
#region [Test: Value write/read]
	
	var _value = [16, 32];
	var _base = [(1 * array_length(_value)), buffer_fixed, 1];
	var _element = [buffer_u8, buffer_seek_start];
	
	constructor = new Buffer(_base[0], _base[1], _base[2]);
	constructor.write(_element[0], _value[0],
					  _element[0], _value[1]);
	constructor.setSeekPosition(_element[1]);
	
	var _result = constructor.read(_element[0], _element[0]);
	var _expectedValue = _value;
	
	unitTest.assert_equal("Value write/read",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Construction: Wrapper]
	
	var _value = [4, -6, 12];
	var _base = [(1 * array_length(_value)), buffer_fixed, 1];
	var _element = [[buffer_u8, buffer_s8, buffer_u8],
					[buffer_create(_base[0], _base[1], _base[2])], [buffer_seek_start]];
	
	buffer_write(_element[1][0], _element[0][0], _value[0]);
	buffer_write(_element[1][0], _element[0][1], _value[1]);
	buffer_write(_element[1][0], _element[0][2], _value[2]);
	
	constructor = new Buffer(_element[1][0]);
	constructor.setSeekPosition(_element[2][0]);
	
	var _result = constructor.read(_element[0][0], _element[0][1], _element[0][2]);
	var _expectedValue = _value;
	
	unitTest.assert_equal("Construction: Wrapper",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _value = [1, 22.20];
	var _base = [(1 + 8), buffer_fixed, 1];
	var _element = [buffer_u8, buffer_f64];
	
	constructor = [new Buffer(_base[0], _base[1], _base[2])];
	constructor[0].write(_element[0], _value[0],
						 _element[1], _value[1]);
	constructor[1] = new Buffer(constructor[0]);
	constructor[1].setSeekPosition(buffer_seek_start);
	
	var _result = constructor[1].read(_element[0], _element[1]);
	var _expectedValue = _value;
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result, _expectedValue);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: isFunctional()]
	
	var _base = [1, buffer_fixed, 1];
	
	constructor = new Buffer(_base[0], _base[1], _base[2]);
	
	var _result = [constructor.isFunctional()];
	var _expectedValue = [true];
	
	constructor.destroy();
	
	array_push(_result, constructor.isFunctional());
	array_push(_expectedValue, false);
	
	unitTest.assert_equal("Method: isFuncitonal()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: copy()]
	
	var _value = [23, "ABC"];
	var _base = [1, buffer_grow, 1];
	var _element = [buffer_u8, buffer_string];
	
	constructor = [new Buffer(_base[0], _base[1], _base[2]),
				   new Buffer(_base[0], _base[1], _base[2]),
				   new Buffer(_base[0], _base[1], _base[2]),
				   new Buffer(_base[0], _base[1], _base[2])];
	constructor[0].write(_element[0], _value[0],
						 _element[1], _value[1]);
	constructor[1].copy(constructor[0], all);
	constructor[2].copy(constructor[0], 1);
	constructor[3].copy(constructor[0], all, undefined, 1);
	
	var _result = [constructor[1].read(_element[0], _element[1]),
				   constructor[2].read(_element[0]),
				   constructor[3].read(_element[1])];
	var _expectedValue = [[_value[0], _value[1]], _value[0], _value[1]];
	
	unitTest.assert_equal("Method: copy()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	constructor[2].destroy();
	constructor[3].destroy();
	
#endregion
#region [Test: Methods: getSeekPosition() / setSeekPosition()]
	
	var _value = 2;
	var _base = [[3, buffer_fixed, 1], [buffer_u8]];
	var _element = [[buffer_u8], [buffer_seek_start], [1, 0]];
	
	constructor = new Buffer(_base[0][0], _base[0][1], _base[0][2]);
	
	var _result = [constructor.getSeekPosition()];
	var _expectedValue = [_element[2][1]];
	
	constructor.write(_element[0][0], _value);
	
	array_push(_result, constructor.getSeekPosition());
	array_push(_expectedValue, _element[2][0]);
	
	constructor.setSeekPosition(_element[1][0]);
	
	array_push(_result, constructor.getSeekPosition());
	array_push(_expectedValue, _element[2][1]);
	
	unitTest.assert_equal("Methods: getSeekPosition() / setSeekPosition()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: getType()]
	
	var _base = [[1, buffer_grow, 1], [64, buffer_fixed, 2]];
	
	constructor = [new Buffer(_base[0][0], _base[0][1], _base[0][2]),
				   new Buffer(_base[1][0], _base[1][1], _base[1][2])];
	
	var _result = [constructor[0].getType(), constructor[1].getType()];
	var _expectedValue = [_base[0][1], _base[1][1]];
	
	unitTest.assert_equal("Method: getType()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: getAlignment()]
	
	var _base = [[12, buffer_fixed, 1], [18, buffer_grow, 4]];
	
	constructor = [new Buffer(_base[0][0], _base[0][1], _base[0][2]),
				   new Buffer(_base[1][0], _base[1][1], _base[1][2])];
	
	var _result = [constructor[0].getAlignment(), constructor[1].getAlignment()];
	var _expectedValue = [_base[0][2], _base[1][2]];
	
	unitTest.assert_equal("Method: getAlignment()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: getPointer()]
	
	var _base = [12, buffer_fixed, 1];
	
	constructor = new Buffer(_base[0], _base[1], _base[2]);
	
	var _result = is_ptr(constructor.getPointer());
	var _expectedValue = true;
	
	unitTest.assert_equal("Method: getPointer()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: getSize()]
	
	var _base = [[68, buffer_grow, 2], [128, buffer_fixed, 4]];
	
	constructor = [new Buffer(_base[0][0], _base[0][1], _base[0][2]),
				   new Buffer(_base[1][0], _base[1][1], _base[1][2])];
	
	var _result = [constructor[0].getSize(), constructor[1].getSize()];
	var _expectedValue = [_base[0][0], _base[1][0]];
	
	unitTest.assert_equal("Method: getSize()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: fill()]
	
	var _value = [2, 4];
	var _base = [4, buffer_fixed, 1];
	var _element = [[buffer_u8], [buffer_seek_start]];
	
	constructor = new Buffer(_base[0], _base[1], _base[2]);
	constructor.fill(_element[0][0], _value[0], 1, 0);
	constructor.fill(_element[0][0], _value[1], 3, 1);
	
	constructor.setSeekPosition(_element[1][0]);
	
	var _result = constructor.read(_element[0][0], _element[0][0], _element[0][0], _element[0][0]);
	var _expectedValue = [_value[0], _value[1], _value[1], _value[1]];
	
	unitTest.assert_equal("Method: fill()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: getValue()]
	
	var _value = [3, 6, 9];
	var _base = [array_length(_value), buffer_fixed, 1];
	var _element = [[buffer_u8], [buffer_seek_end, buffer_seek_start]];
	
	constructor = new Buffer(_base[0], _base[1], _base[2]);
	constructor.write(_element[0][0], _value[0],
					  _element[0][0], _value[1],
					  _element[0][0], _value[2]);
	
	var _result = [constructor.getValue(_element[0][0], (_base[0] - 1))];
	var _expectedValue = [_value[(array_length(_value) - 1)]];
	
	repeat (2)
	{
		array_push(_result, constructor.getValue(_element[0][0]));
		array_push(_expectedValue, _value[0]);
	}
	
	unitTest.assert_equal("Method: getValue()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: compress() / decompress()]
	
	var _value = [25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15];
	var _base = [array_length(_value), buffer_fixed, 1];
	var _element = buffer_u8;
	
	constructor = [new Buffer(_base[0], _base[1], _base[2])];
	constructor[0].write(_element, _value[0],
						 _element, _value[1],
						 _element, _value[2],
						 _element, _value[3],
						 _element, _value[4],
						 _element, _value[5],
						 _element, _value[6],
						 _element, _value[7],
						 _element, _value[8],
						 _element, _value[9],
						 _element, _value[10]);
	constructor[1] = constructor[0].compress();
	constructor[2] = constructor[1].decompress();
	
	var _result = [constructor[1].isFunctional(), constructor[2].isFunctional(),
				   constructor[2].getValue(_element)];
	var _expectedValue = [true, true, _value[0]];
	
	unitTest.assert_equal("Methods: compress() / decompress()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	constructor[2].destroy();
	
#endregion
#region [Test: Method: toString()]
	
	var _base = [4, buffer_fast, 1];
	
	constructor = new Buffer(_base[0], _base[1], _base[2]);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName +
						  "(" +
						  "ID: " + string(constructor.ID) + ", " +
						  "Size: " + string(_base[0]) + ", " + 
						  "Type: " + "Fast" + ", " +
						  "Aligment: " + string(_base[2]) +
						  ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: toString(multiline)]
	
	var _base = [24, buffer_wrap, 1];
	
	constructor = new Buffer(_base[0], _base[1], _base[2]);
	
	var _result = constructor.toString(true);
	var _expectedValue = ("ID: " + string(constructor.ID) + "\n" +
						  "Size: " + string(_base[0]) + "\n" + 
						  "Type: " + "Wrap" + "\n" +
						  "Aligment: " + string(_base[2]));
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: toHashMD5()]
	
	var _value = 31;
	var _base = [12, buffer_grow, 3];
	var _element = buffer_u8;
	
	constructor = new Buffer(_base[0], _base[1], _base[2]);
	constructor.write(_element, _value);
	
	var _result = is_string(constructor.toHashMD5());
	var _expectedValue = true;
	
	unitTest.assert_equal("Method: toHashMD5()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: toHashSHA1()]
	
	var _value = 13;
	var _base = [11, buffer_fixed, 2];
	var _element = buffer_u8;
	
	constructor = new Buffer(_base[0], _base[1], _base[2]);
	constructor.write(_element, _value);
	
	var _result = is_string(constructor.toHashSHA1());
	var _expectedValue = true;
	
	unitTest.assert_equal("Method: toHashSHA1()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: toHashCRC32()]
	
	var _value = 12;
	var _base = [10, buffer_wrap, 1];
	var _element = buffer_u8;
	
	constructor = new Buffer(_base[0], _base[1], _base[2]);
	constructor.write(_element, _value);
	
	var _result = is_real(constructor.toHashCRC32());
	var _expectedValue = true;
	
	unitTest.assert_equal("Method: toHashCRC32()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: fromEncodedString() / toEncodedString()]
	
	var _value = 11;
	var _base = [9, buffer_wrap, 2];
	var _element = buffer_u8;
	
	constructor = [new Buffer(_base[0], _base[1], _base[2]),
				   new Buffer(_base[0], _base[1], _base[2])];
	constructor[0].write(_element, _value);
	constructor[1].fromEncodedString(constructor[0].toEncodedString());
	
	var _result = constructor[1].read(_element);
	var _expectedValue = _value;
	
	unitTest.assert_equal("Methods: fromEncodedString() / toEncodedString()",
						  _result, _expectedValue);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: secureFromMap()]
	
	var _base = [1, buffer_grow, 1];
	var _element = [[new Map(), new Map()], ["BufferUnitTest_secureFromMap.dat"]];
	var _value = ["Key1", 0.221];
	
	if (file_exists(_element[1][0]))
	{
		file_delete(_element[1][0]);
	}
	
	constructor = [new Buffer(_base[0], _base[1], _base[2]), new Buffer(_base[0], _base[1], _base[2])];
	_element[0][0].add(_value[0], _value[1]);
	constructor[0].secureFromMap(_element[0][0]);
	constructor[0].toFile(_element[1][0]);
	constructor[1].fromFile(_element[1][0]);
	_element[0][1].secureFromBuffer(constructor[1]);
	
	var _result = _element[0][1].getFirst();
	var _expectedValue = _value[0];
	
	unitTest.assert_equal("Method: secureFromMap()",
						  _result, _expectedValue);
	
	_element[0][0].destroy();
	_element[0][1].destroy();
	constructor[0].destroy();
	constructor[1].destroy();
	
	if (file_exists(_element[1][0]))
	{
		file_delete(_element[1][0]);
	}
	
#endregion
#region [Test: Method: fromSurface()]
	
	var _base = [1, buffer_grow, 1];
	
	constructor = new Buffer(_base[0], _base[1], _base[2]);
	constructor.fromSurface(new Surface(new Vector2(1024, 1024)));
	
	var _result = (constructor.getSize() > _base[0]);
	var _expectedValue = true;
	
	unitTest.assert_equal("Method: fromSurface()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: toFile() / fromFile()]
	
	var _value = 25;
	var _base = [1, buffer_grow, 1];
	var _element = [buffer_u8, "BufferUnitTest_toFile.dat"];
	
	if (file_exists(_element[1]))
	{
		file_delete(_element[1]);
	}
	
	constructor = [new Buffer(_base[0], _base[1], _base[2]),
				   new Buffer(_base[0], _base[1], _base[2])];
	constructor[0].write(_element[0], _value);
	constructor[0].toFile(_element[1]);
	constructor[1].fromFile(_element[1]);
	
	var _result = constructor[1].read(_element[0]);
	var _expectedValue = _value;
	
	unitTest.assert_equal("Methods: toFile() / fromFile()",
						  _result, _expectedValue);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
	if (file_exists(_element[1]))
	{
		file_delete(_element[1]);
	}
	
#endregion
#region [Test: Method: fromFilePart()]
	
	var _value = [11, 22];
	var _base = [array_length(_value), buffer_fixed, 1];
	var _element = [buffer_u8, "BufferUnitTest_fromFilePart.dat"];
	
	if (file_exists(_element[1]))
	{
		file_delete(_element[1]);
	}
	
	constructor = [new Buffer(_base[0], _base[1], _base[2]),
				   new Buffer(_base[0], _base[1], _base[2])];
	constructor[0].write(_element[0], _value[0],
						 _element[0], _value[1]);
	constructor[0].toFile(_element[1]);
	constructor[1].fromFilePart(_element[1], 1, 0, 1);
	
	var _result = constructor[1].read(_element[0]);
	var _expectedValue = _value[1];
	
	unitTest.assert_equal("Methods: fromFilePart()",
						  _result, _expectedValue);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
	if (file_exists(_element[1]))
	{
		file_delete(_element[1]);
	}
	
#endregion
