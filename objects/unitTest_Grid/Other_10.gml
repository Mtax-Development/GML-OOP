/// @description Unit Testing
#region [Test: Construction: New constructor / Destruction]
	
	var _base = new Vector2(5);
	
	constructor = new Grid(_base);
	
	var _result = [ds_exists(constructor.ID, ds_type_grid)];
	var _expectedValue = [true];
	
	constructor.destroy();
	
	array_push(_result, constructor.ID);
	array_push(_expectedValue, undefined);
	
	unitTest.assert_equal("Construction: New constructor / Destruction",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Value write/read]
	
	var _base = new Vector2(3);
	var _value = 59;
	var _element = [new Vector2(1), new Vector2(2)];
	
	constructor = new Grid(_base);
	constructor.set(_value, _element[0], _value, _element[1]);
	
	var _result = [constructor.getValue(_element[0]), constructor.getValue(_element[1])];
	var _expectedValue = [_value, _value];
	
	unitTest.assert_equal("Value write/read",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Construction: Wrapper]
	
	var _base = new Vector2(5);
	var _element = [ds_grid_create(_base.x, _base.y), new Vector2(3)];
	var _value = 99;
	
	ds_grid_set(_element[0], _element[1].x, _element[1].y, _value);
	
	constructor = new Grid(_element[0]);
	
	var _result = constructor.getValue(_element[1]);
	var _expectedValue = _value;
	
	unitTest.assert_equal("Construction: Wrapper",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Construction: Empty]
	
	constructor = new Grid();
	
	var _result = [constructor.ID, constructor.size];
	var _expectedValue = [undefined, undefined];
	
	unitTest.assert_equal("Construction: Empty",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _base = new Vector2(3);
	var _value = 1.49;
	var _element = [new Vector2(1), new Vector2(2)];
	
	constructor = [new Grid(_base)];
	constructor[0].set(_value, _element[0], _value, _element[1]);
	
	constructor[1] = new Grid(constructor[0]);
	
	var _result = [constructor[1].getValue(_element[0]), constructor[1].getValue(_element[1])];
	var _expectedValue = [_value, _value];
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: isFunctional()]
	
	var _base = new Vector2(99);
	
	constructor = [new Grid(_base), new Grid(_base)];
	constructor[1].destroy();
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional()];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	
#endregion
#region [Test: Method: destroy(deep scan)]
	
	var _base = new Vector2(3);
	var _element = [new List(), new Vector2(2)];
	var _value = 55;
	
	_element[0].add(_value);
	
	constructor = new Grid(_base);
	constructor.set(_element[0], _element[1]);
	constructor.destroy(true);
	
	var _result = _element[0].isFunctional();
	var _expectedValue = false;
	
	unitTest.assert_equal("Method: destroy(deep scan)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: clear()]
	
	var _base = new Vector2(6);
	var _element = new Vector2(2);
	var _value = 99.9999999999999999999101;
	
	constructor = new Grid(_base);
	constructor.clear(_value);
	
	var _result = constructor.getValue(_element);
	var _expectedValue = _value;
	
	unitTest.assert_equal("Method: clear()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: copy()]
	
	var _base = [new Vector2(9), new Vector2(2)];
	var _element = new Vector2((_base[1].x + 1), (_base[1].y + 1));
	var _value = 59.5;
	
	constructor = [new Grid(_base[0]), new Grid(_base[1])];
	constructor[0].set(_value, _element);
	constructor[1].copy(constructor[0]);
	
	var _result = [constructor[1].size, constructor[1].getValue(_element)];
	var _expectedValue = [_base[0], _value];
	
	unitTest.assert_equal("Methods: copy()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Methods: contains() / containsRegion() / getValueLocation()]
	
	var _base = new Vector2(4);
	var _element = [new Vector2(0),  new Vector4(new Vector2(0), _base), new Vector4(1, 2)];
	var _value = [99, 88];
	
	constructor = new Grid(_base);
	constructor.set(_value[0], _element[0]);
	
	var _result = [constructor.contains(_value[0]),
				   constructor.contains(_value[1]),
				   constructor.containsRegion(_element[1], _value[0]),
				   constructor.containsRegion(_element[2], _value[0]),
				   constructor.getValueLocation(_value[0]),
				   constructor.getValueLocation(_value[0], _element[2])];
	var _expectedValue = [true, false, true, false, _element[0], undefined];
	
	unitTest.assert_equal("Methods: contains() / containsRegion() / getValueLocation()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: containsDisk() / getValueLocationDisk()]
	
	var _base = new Vector2(3);
	var _element = [[new Vector2(1), new Vector2(2)], [1]];
	var _value = [11.11, 11];
	
	constructor = new Grid(_base);
	constructor.set(_value[0], _element[0][0]);
	
	var _result = [constructor.containsDisk(_element[0][0], _element[1][0], _value[0]),
				   constructor.containsDisk(_element[0][1], _element[1][0], _value[1]),
				   constructor.getValueLocationDisk(_value[0], _element[0][0], _element[1][0]),
				   constructor.getValueLocationDisk(_value[1], _element[0][1], _element[1][0])];
	var _expectedValue = [true, false, _element[0][0], undefined];
	
	unitTest.assert_equal("Methods: containsDisk() / getValueLocationDisk()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: count()]
	
	var _value = ["GML-OOP", 35, 5, -956];
	var _element = [new Vector2(2, 1), new Vector2(2, 2), new Vector2(3, 1), new Vector2(4, 1)];
	var _base = new Vector2(5, 5);
	
	constructor = new Grid(_base);
	constructor.set(_value[0], _element[0],
					_value[0], _element[1],
					_value[1], _element[2],
					_value[2], _element[3]);
	
	var _result = constructor.count(_value[0], _value[1], _value[2], _value[3]);
	var _expectedValue = array_length(_element);
	
	unitTest.assert_equal("Method: count()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getCellCount()]
	
	var _base = new Vector2(59, 95);
	
	constructor = new Grid(_base);
	
	var _result = constructor.getCellCount();
	var _expectedValue = (_base.x * _base.y);
	
	unitTest.assert_equal("Method: getCellCount()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: getRow() / getColumn()]
	
	var _base = new Vector2(3);
	var _element = [[new Vector2(0, 0), new Vector2(1, 0), new Vector2(2, 0), new Vector2(0, 1),
					 new Vector2(1, 1), new Vector2(2, 1), new Vector2(0, 2), new Vector2(1, 2),
					 new Vector2(2, 2)], 1];
	var _value = [[1, 2, 3],
				  [4, 5, 6],
				  [7, 8, 9]];
	
	constructor = new Grid(_base);
	constructor.set(_value[0][0], _element[0][0],
					_value[0][1], _element[0][1],
					_value[0][2], _element[0][2],
					_value[1][0], _element[0][3],
					_value[1][1], _element[0][4],
					_value[1][2], _element[0][5],
					_value[2][0], _element[0][6],
					_value[2][1], _element[0][7],
					_value[2][2], _element[0][8]);
	
	var _result = [constructor.getRow(_element[1]), constructor.getColumn(_element[1])];
	var _expectedValue = [_value[_element[1]], [_value[0][_element[1]], _value[1][_element[1]],
						  _value[2][_element[1]]]];
	
	unitTest.assert_equal("Methods: getRow() / getColumn()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: getMinimum() / getMaximum()]
	
	var _base = new Vector2(3);
	var _element = [new Vector2(0), new Vector2(1), new Vector2(2), new Vector2(2, 1)];
	var _value = [3, -3, 5, -5];
	
	constructor = new Grid(_base);
	constructor.set(_value[0], _element[0],
					_value[1], _element[1],
					_value[2], _element[2],
					_value[3], _element[3]);
	
	var _result = [constructor.getMinimum(new Vector4(0, 1)),
				   constructor.getMaximum(new Vector4(0, 1)), constructor.getMinimum(),
				   constructor.getMaximum()];
	var _expectedValue = [_value[1], _value[0], _value[3], _value[2]];
	
	unitTest.assert_equal("Methods: getMinimum() / getMaximum()]",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: getMinimumDisk() / getMaximumDisk()]
	
	var _base = new Vector2(5);
	var _element = [[new Vector2(0), new Vector2(4), new Vector2(2), new Vector2(3)],
					[new Vector2(2), 2]];
	var _value = [10, -10, 6, -6];
	
	constructor = new Grid(_base);
	constructor.set(_value[0], _element[0][0],
					_value[1], _element[0][1],
					_value[2], _element[0][2],
					_value[3], _element[0][3]);
	
	var _result = [constructor.getMinimumDisk(_element[1][0], _element[1][1]),
				   constructor.getMaximumDisk(_element[1][0], _element[1][1])];
	var _expectedValue = [_value[3], _value[2]];
	
	unitTest.assert_equal("Methods: getMinimumDisk() / getMaximumDisk()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: getMean() / getSum()]
	
	var _base = new Vector2(3);
	var _element = [[new Vector2(0, 0), new Vector2(0, 1), new Vector2(0, 2), new Vector2(1, 0),
					 new Vector2(1, 1), new Vector2(1, 2), new Vector2(2, 0), new Vector2(2, 1),
					 new Vector2(2, 2)], [new Vector4(0, 1)]];
	var _value = [1, 2, 3, 4, 5, 6, 7, 8, 9];
	
	constructor = new Grid(_base);
	constructor.set(_value[0], _element[0][0],
					_value[1], _element[0][1],
					_value[2], _element[0][2],
					_value[3], _element[0][3],
					_value[4], _element[0][4],
					_value[5], _element[0][5],
					_value[6], _element[0][6],
					_value[7], _element[0][7],
					_value[8], _element[0][8]);
	
	var _result = [constructor.getMean(_element[1][0]), constructor.getSum(_element[1][0]),
				   constructor.getMean(), constructor.getSum()];
	
	var _expectedValue = [((_value[0] + _value[1] + _value[3] + _value[4]) / 4),
						  (_value[0] + _value[1] + _value[3] + _value[4]),
						  ((_value[0] + _value[1] + _value[2] + _value[3] + _value[4] + _value[5] +
						  _value[6] + _value[7] + _value[8]) / array_length(_value)),
						  (_value[0] + _value[1] + _value[2] + _value[3] + _value[4] + _value[5] +
						  _value[6] + _value[7] + _value[8])];
	
	unitTest.assert_equal("Methods: getMean() / getSum()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: getMeanDisk() / getSumDisk()]
	
	var _base = new Vector2(3);
	var _element = [[new Vector2(0, 0), new Vector2(0, 1), new Vector2(0, 2), new Vector2(1, 0),
					new Vector2(1, 1), new Vector2(1, 2), new Vector2(2, 0), new Vector2(2, 1),
					new Vector2(2, 2)],
					[new Vector2(1), 1]];
	var _value = [11, 22, 33, 44, 55, 66, 77, 88, 99];
	
	constructor = new Grid(_base);
	constructor.set(_value[0], _element[0][0],
					_value[1], _element[0][1],
					_value[2], _element[0][2],
					_value[3], _element[0][3],
					_value[4], _element[0][4],
					_value[5], _element[0][5],
					_value[6], _element[0][6],
					_value[7], _element[0][7],
					_value[8], _element[0][8]);
	
	var _result = [constructor.getMeanDisk(_element[1][0], _element[1][1]),
				   constructor.getSumDisk(_element[1][0], _element[1][1])];
	var _expectedValue = [((_value[1] + _value[3] + _value[4] + _value[5] + _value[7]) / 5),
						  (_value[1] + _value[3] + _value[4] + _value[5] + _value[7])];
	
	unitTest.assert_equal("Methods: getMeanDisk() / getSumDisk()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setSize(size reduction)]
	
	var _base = new Vector2(30, 25);
	var _element = [new Vector2(15), new Vector2(14), new Vector2(20)];
	var _value = [-255.68, 77];
	
	constructor = new Grid(_base);
	constructor.set(_value[0], _element[1]);
	constructor.set(_value[1], _element[2]);
	
	var _result = [constructor.contains(_value[1])];
	var _expectedValue = [true];
	
	constructor.setSize(_element[0]);
	
	array_push(_result, constructor.size, constructor.contains(_value[0]),
			   constructor.contains(_value[1]));
	array_push(_expectedValue, _element[0], true, false);
	
	unitTest.assert_equal("Method: setSize(size reduction)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setSize(size increase)]
	
	var _base = new Vector2(2);
	var _element = new Vector2(4, 5);
	var _value = -25.8;
	
	constructor = new Grid(_base);
	constructor.clear(_value);
	constructor.setSize(_element);
	
	var _result = [constructor.size, constructor.contains(_value),
				   constructor.contains(0)];
	
	var _expectedValue = [_element, true, true];
	
	unitTest.assert_equal("Method: setSize(size increase)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setSize(same size)]
	
	var _base = new Vector2(2);
	var _value = -2.81;
	
	constructor = new Grid(_base);
	constructor.clear(_value);
	constructor.setSize(_base);
	
	var _result = [constructor.size, constructor.contains(_value)];
	
	var _expectedValue = [_base, true];
	
	unitTest.assert_equal("Method: setSize(same size)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: forEach()]
	
	var _base = new Vector2(3);
	var _element = new Vector2(1);
	var _value = 11;
	
	constructor = new Grid(_base);
	constructor.set(_value, _element);
	
	constructor.forEach
	(
		function(_x, _y, _value)
		{
			if (_value != 0)
			{
				constructor.set(-_value, new Vector2(_x, _y));
			}
		}
	);
	
	var _result = [constructor.contains(-_value), constructor.contains(_value)];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: forEach()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setRegion()]
	
	var _base = new Vector2(3);
	var _element = [[new Vector4(0, 1)], [new Vector2(0, 0), new Vector2(1, 0), new Vector2(2, 0),
					new Vector2(0, 1), new Vector2(1, 1), new Vector2(2, 1), new Vector2(0, 2),
					new Vector2(1, 2), new Vector2(2, 2)]];
	var _value = 5;
	
	constructor = new Grid(_base);
	
	constructor.setRegion(_value, _element[0][0]);
	
	var _result = [constructor.getValue(_element[1][0]), constructor.getValue(_element[1][1]),
				   constructor.getValue(_element[1][2]), constructor.getValue(_element[1][3]),
				   constructor.getValue(_element[1][4]), constructor.getValue(_element[1][5]),
				   constructor.getValue(_element[1][6]), constructor.getValue(_element[1][7]),
				   constructor.getValue(_element[1][8])]
	var _expectedValue = [_value, _value, 0, _value, _value, 0, 0, 0, 0];
	
	unitTest.assert_equal("Method: setRegion()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6],
						  _result[7], _expectedValue[7],
						  _result[8], _expectedValue[8]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setDisk()]
	
	var _base = new Vector2(3);
	var _element = [[new Vector2(1), 1], [new Vector2(0, 0), new Vector2(1, 0), new Vector2(2, 0),
					new Vector2(0, 1), new Vector2(1, 1), new Vector2(2, 1), new Vector2(0, 2),
					new Vector2(1, 2), new Vector2(2, 2)]];
	var _value = 17.5;
	
	constructor = new Grid(_base);
	
	constructor.setDisk(_value, _element[0][0], _element[0][1]);
	
	var _result = [constructor.getValue(_element[1][0]), constructor.getValue(_element[1][1]),
				   constructor.getValue(_element[1][2]), constructor.getValue(_element[1][3]),
				   constructor.getValue(_element[1][4]), constructor.getValue(_element[1][5]),
				   constructor.getValue(_element[1][6]), constructor.getValue(_element[1][7]),
				   constructor.getValue(_element[1][8])]
	var _expectedValue = [0, _value, 0, _value, _value, _value, 0, _value, 0];
	
	unitTest.assert_equal("Method: setDisk()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6],
						  _result[7], _expectedValue[7],
						  _result[8], _expectedValue[8]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setRegionCopied(self)]
	
	var _base = new Vector2(9);
	var _element = [[new Vector2(1), new Vector4(5, 7)], [new Vector2(0, 0), new Vector2(0, 4),
					new Vector2(4, 0), new Vector2(4, 4), new Vector2(1, 1), new Vector2(3, 3)]];
	var _value = [2, -99.86];
	
	constructor = new Grid(_base);
	constructor.set(_value[0], _element[1][0],
					_value[0], _element[1][1],
					_value[0], _element[1][2],
					_value[0], _element[1][3]);
	constructor.setRegion(_value[1], _element[0][1]);
	constructor.setRegionCopied(_element[0][0], _element[0][1]);
	
	var _result = [constructor.getValue(_element[1][0]), constructor.getValue(_element[1][1]),
				   constructor.getValue(_element[1][2]), constructor.getValue(_element[1][3]),
				   constructor.getValue(_element[1][4]), constructor.getValue(_element[1][5])];
	var _expectedValue = [_value[0], _value[0], _value[0], _value[0], _value[1], _value[1]];
	
	unitTest.assert_equal("Method: setRegionCopied(self)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setRegionCopied(other)]
	
	var _base = new Vector2(9);
	var _element = [[new Vector2(1), new Vector4(5, 7)], [new Vector2(0, 0), new Vector2(0, 4),
					new Vector2(4, 0), new Vector2(4, 4), new Vector2(1, 1), new Vector2(3, 3)]];
	var _value = [-33, 509.11];
	
	constructor = [new Grid(_base), new Grid(_base)];
	constructor[0].set(_value[0], _element[1][0],
					   _value[0], _element[1][1],
					   _value[0], _element[1][2],
					   _value[0], _element[1][3]);
	constructor[1].setRegion(_value[1], _element[0][1]);
	constructor[0].setRegionCopied(_element[0][0], _element[0][1], constructor[1]);
	
	var _result = [constructor[0].getValue(_element[1][0]), constructor[0].getValue(_element[1][1]),
				   constructor[0].getValue(_element[1][2]), constructor[0].getValue(_element[1][3]),
				   constructor[0].getValue(_element[1][4]), constructor[0].getValue(_element[1][5])];
	var _expectedValue = [_value[0], _value[0], _value[0], _value[0], _value[1], _value[1]];
	
	unitTest.assert_equal("Method: setRegionCopied(other)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: add()]
	
	var _base = new Vector2(3);
	var _element = [new Vector2(0), new Vector2(1), new Vector2(2)];
	var _value = [[2, 3], [50, 100, 200]];
	
	constructor = new Grid(_base);
	constructor.set(_value[0][0], _element[0],
					_value[0][1], _element[1]);
	constructor.add(_value[1][0], _element[0],
					_value[1][1], _element[1],
					_value[1][2], _element[2]);
	
	var _result = [constructor.getValue(_element[0]), constructor.getValue(_element[1]),
				   constructor.getValue(_element[2])];
	var _expectedValue = [(_value[0][0] + _value[1][0]), (_value[0][1] + _value[1][1]),
						  _value[1][2]];
	
	unitTest.assert_equal("Method: add()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: addRegion()]
	
	var _base = new Vector2(3);
	var _element = [[new Vector4(0, 1)], [new Vector2(0), new Vector2(1), new Vector2(2)]];
	var _value = [2, 155];
	
	constructor = new Grid(_base);
	constructor.clear(_value[0]);
	constructor.addRegion(_value[1], _element[0][0]);
	
	var _result = [constructor.getValue(_element[1][0]), constructor.getValue(_element[1][1]),
				   constructor.getValue(_element[1][2])];
	var _expectedValue = [(_value[0] + _value[1]), (_value[0] + _value[1]), _value[0]];
	
	unitTest.assert_equal("Method: addRegion()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: addDisk()]
	
	var _base = new Vector2(3);
	var _element = [[new Vector2(1), 1], [new Vector2(0, 0), new Vector2(1, 0), new Vector2(2, 0),
					new Vector2(0, 1), new Vector2(1, 1), new Vector2(2, 1), new Vector2(0, 2),
					new Vector2(1, 2), new Vector2(2, 2)]];
	var _value = [2, 90];
	
	constructor = new Grid(_base);
	
	constructor.setDisk(_value[0], _element[0][0], _element[0][1]);
	constructor.addDisk(_value[1], _element[0][0], _element[0][1]);
	
	var _result = [constructor.getValue(_element[1][0]), constructor.getValue(_element[1][1]),
				   constructor.getValue(_element[1][2]), constructor.getValue(_element[1][3]),
				   constructor.getValue(_element[1][4]), constructor.getValue(_element[1][5]),
				   constructor.getValue(_element[1][6]), constructor.getValue(_element[1][7]),
				   constructor.getValue(_element[1][8])]
	var _expectedValue = [0, (_value[0] + _value[1]), 0, (_value[0] + _value[1]),
						  (_value[0] + _value[1]), (_value[0] + _value[1]), 0,
						  (_value[0] + _value[1]), 0];
	
	unitTest.assert_equal("Method: addDisk()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6],
						  _result[7], _expectedValue[7],
						  _result[8], _expectedValue[8]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: addRegionCopied(self)]
	
	var _base = new Vector2(9);
	var _element = [[new Vector2(1), new Vector4(5, 7)], [new Vector2(0, 0), new Vector2(0, 4),
					new Vector2(4, 0), new Vector2(4, 4), new Vector2(1, 1), new Vector2(3, 3)]];
	var _value = [10, 3, 49.689];
	
	constructor = new Grid(_base);
	constructor.clear(_value[0]);
	constructor.set(_value[1], _element[1][0],
					_value[1], _element[1][1],
					_value[1], _element[1][2],
					_value[1], _element[1][3]);
	constructor.setRegion(_value[2], _element[0][1]);
	constructor.addRegionCopied(_element[0][0], _element[0][1]);
	
	var _result = [constructor.getValue(_element[1][0]), constructor.getValue(_element[1][1]),
				   constructor.getValue(_element[1][2]), constructor.getValue(_element[1][3]),
				   constructor.getValue(_element[1][4]), constructor.getValue(_element[1][5])];
	var _expectedValue = [_value[1], _value[1], _value[1], _value[1], (_value[0] + _value[2]),
						  (_value[0] + _value[2])];
	
	unitTest.assert_equal("Method: addRegionCopied(self)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: addRegionCopied(other)]
	
	var _base = new Vector2(9);
	var _element = [[new Vector2(1), new Vector4(5, 7)], [new Vector2(0, 0), new Vector2(0, 4),
					new Vector2(4, 0), new Vector2(4, 4), new Vector2(1, 1), new Vector2(3, 3)]];
	var _value = [20, 2, 29.222];
	
	constructor = [new Grid(_base), new Grid(_base)];
	constructor[0].clear(_value[0]);
	constructor[0].set(_value[1], _element[1][0],
					   _value[1], _element[1][1],
					   _value[1], _element[1][2],
					   _value[1], _element[1][3]);
	constructor[1].setRegion(_value[2], _element[0][1]);
	constructor[0].addRegionCopied(_element[0][0], _element[0][1], constructor[1]);
	
	var _result = [constructor[0].getValue(_element[1][0]), constructor[0].getValue(_element[1][1]),
				   constructor[0].getValue(_element[1][2]), constructor[0].getValue(_element[1][3]),
				   constructor[0].getValue(_element[1][4]), constructor[0].getValue(_element[1][5])];
	var _expectedValue = [_value[1], _value[1], _value[1], _value[1], (_value[0] + _value[2]),
						  (_value[0] + _value[2])];
	
	unitTest.assert_equal("Method: addRegionCopied(other)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: multiply()]
	
	var _base = new Vector2(3);
	var _element = [new Vector2(0), new Vector2(1), new Vector2(2)];
	var _value = [[2, 3], [15, 25, 35]];
	
	constructor = new Grid(_base);
	constructor.set(_value[0][0], _element[0],
					_value[0][1], _element[1]);
	constructor.multiply(_value[1][0], _element[0],
						 _value[1][1], _element[1],
						 _value[1][2], _element[2]);
	
	var _result = [constructor.getValue(_element[0]), constructor.getValue(_element[1]),
				   constructor.getValue(_element[2])];
	var _expectedValue = [(_value[0][0] * _value[1][0]), (_value[0][1] * _value[1][1]), 0];
	
	unitTest.assert_equal("Method: multiply()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: multiplyRegion()]
	
	var _base = new Vector2(3);
	var _element = [[new Vector4(0, 1)], [new Vector2(0), new Vector2(1), new Vector2(2)]];
	var _value = [2, 125];
	
	constructor = new Grid(_base);
	constructor.clear(_value[0]);
	constructor.multiplyRegion(_value[1], _element[0][0]);
	
	var _result = [constructor.getValue(_element[1][0]), constructor.getValue(_element[1][1]),
				   constructor.getValue(_element[1][2])];
	var _expectedValue = [(_value[0] * _value[1]), (_value[0] * _value[1]), _value[0]];
	
	unitTest.assert_equal("Method: multiplyRegion()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: multiplyDisk()]
	
	var _base = new Vector2(3);
	var _element = [[new Vector2(1), 1], [new Vector2(0, 0), new Vector2(1, 0), new Vector2(2, 0),
					new Vector2(0, 1), new Vector2(1, 1), new Vector2(2, 1), new Vector2(0, 2),
					new Vector2(1, 2), new Vector2(2, 2)]];
	var _value = [3, 45];
	
	constructor = new Grid(_base);
	constructor.setDisk(_value[0], _element[0][0], _element[0][1]);
	constructor.multiplyDisk(_value[1], _element[0][0], _element[0][1]);
	
	var _result = [constructor.getValue(_element[1][0]), constructor.getValue(_element[1][1]),
				   constructor.getValue(_element[1][2]), constructor.getValue(_element[1][3]),
				   constructor.getValue(_element[1][4]), constructor.getValue(_element[1][5]),
				   constructor.getValue(_element[1][6]), constructor.getValue(_element[1][7]),
				   constructor.getValue(_element[1][8])]
	var _expectedValue = [0, (_value[0] * _value[1]), 0, (_value[0] * _value[1]),
						  (_value[0] * _value[1]), (_value[0] * _value[1]), 0,
						  (_value[0] * _value[1]), 0];
	
	unitTest.assert_equal("Method: multiplyDisk()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6],
						  _result[7], _expectedValue[7],
						  _result[8], _expectedValue[8]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: multiplyRegionCopied(self)]
	
	var _base = new Vector2(9);
	var _element = [[new Vector2(1), new Vector4(5, 7)], [new Vector2(0, 0), new Vector2(0, 4),
					new Vector2(4, 0), new Vector2(4, 4), new Vector2(1, 1), new Vector2(3, 3)]];
	var _value = [20, 2.5, 26.4];
	
	constructor = new Grid(_base);
	constructor.clear(_value[0]);
	constructor.set(_value[1], _element[1][0],
					_value[1], _element[1][1],
					_value[1], _element[1][2],
					_value[1], _element[1][3]);
	constructor.setRegion(_value[2], _element[0][1]);
	constructor.multiplyRegionCopied(_element[0][0], _element[0][1]);
	
	var _result = [constructor.getValue(_element[1][0]), constructor.getValue(_element[1][1]),
				   constructor.getValue(_element[1][2]), constructor.getValue(_element[1][3]),
				   constructor.getValue(_element[1][4]), constructor.getValue(_element[1][5])];
	var _expectedValue = [_value[1], _value[1], _value[1], _value[1], (_value[0] * _value[2]),
						  (_value[0] * _value[2])];
	
	unitTest.assert_equal("Method: multiplyRegionCopied(self)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: multiplyRegionCopied(other)]
	
	var _base = new Vector2(9);
	var _element = [[new Vector2(1), new Vector4(5, 7)], [new Vector2(0, 0), new Vector2(0, 4),
					new Vector2(4, 0), new Vector2(4, 4), new Vector2(1, 1), new Vector2(3, 3)]];
	var _value = [13, 5, 22.22];
	
	constructor = [new Grid(_base), new Grid(_base)];
	constructor[0].clear(_value[0]);
	constructor[0].set(_value[1], _element[1][0],
					   _value[1], _element[1][1],
					   _value[1], _element[1][2],
					   _value[1], _element[1][3]);
	constructor[1].setRegion(_value[2], _element[0][1]);
	constructor[0].multiplyRegionCopied(_element[0][0], _element[0][1], constructor[1]);
	
	var _result = [constructor[0].getValue(_element[1][0]), constructor[0].getValue(_element[1][1]),
				   constructor[0].getValue(_element[1][2]), constructor[0].getValue(_element[1][3]),
				   constructor[0].getValue(_element[1][4]), constructor[0].getValue(_element[1][5])];
	var _expectedValue = [_value[1], _value[1], _value[1], _value[1], (_value[0] * _value[2]),
						  (_value[0] * _value[2])];
	
	unitTest.assert_equal("Method: multiplyRegionCopied(other)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: mirrorX()]
	
	var _base = new Vector2(3);
	var _element = [[new Vector2(0, 0), new Vector2(1, 0), new Vector2(2, 0)],
					[new Vector2(0, 1), new Vector2(1, 1), new Vector2(2, 1)],
					[new Vector2(0, 2), new Vector2(1, 2), new Vector2(2, 2)]];
	var _value = [[1, 2, 3], [4, 5, 6], [7, 8, 9]];
	
	constructor = new Grid(_base);
	constructor.set(_value[0][0], _element[0][0],
					_value[0][1], _element[0][1],
					_value[0][2], _element[0][2],
					_value[1][0], _element[1][0],
					_value[1][1], _element[1][1],
					_value[1][2], _element[1][2],
					_value[2][0], _element[2][0],
					_value[2][1], _element[2][1],
					_value[2][2], _element[2][2]);
	constructor.mirrorX();
	
	var _result = [constructor.getValue(_element[0][0]), constructor.getValue(_element[0][1]),
				   constructor.getValue(_element[0][2]), constructor.getValue(_element[1][0]),
				   constructor.getValue(_element[1][1]), constructor.getValue(_element[1][2]),
				   constructor.getValue(_element[2][0]), constructor.getValue(_element[2][1]),
				   constructor.getValue(_element[2][2])];
	var _expectedValue = [_value[0][2], _value[0][1], _value[0][0], _value[1][2], _value[1][1],
						  _value[1][0], _value[2][2], _value[2][1], _value[2][0]];
	
	unitTest.assert_equal("Method: mirrorX()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6],
						  _result[7], _expectedValue[7],
						  _result[8], _expectedValue[8]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: mirrorY()]
	
	var _base = new Vector2(3);
	var _element = [[new Vector2(0, 0), new Vector2(1, 0), new Vector2(2, 0)],
					[new Vector2(0, 1), new Vector2(1, 1), new Vector2(2, 1)],
					[new Vector2(0, 2), new Vector2(1, 2), new Vector2(2, 2)]];
	var _value = [[1, 2, 3], [4, 5, 6], [7, 8, 9]];
	
	constructor = new Grid(_base);
	constructor.set(_value[0][0], _element[0][0],
					_value[0][1], _element[0][1],
					_value[0][2], _element[0][2],
					_value[1][0], _element[1][0],
					_value[1][1], _element[1][1],
					_value[1][2], _element[1][2],
					_value[2][0], _element[2][0],
					_value[2][1], _element[2][1],
					_value[2][2], _element[2][2]);
	constructor.mirrorY();
	
	var _result = [constructor.getValue(_element[0][0]), constructor.getValue(_element[0][1]),
				   constructor.getValue(_element[0][2]), constructor.getValue(_element[1][0]),
				   constructor.getValue(_element[1][1]), constructor.getValue(_element[1][2]),
				   constructor.getValue(_element[2][0]), constructor.getValue(_element[2][1]),
				   constructor.getValue(_element[2][2])];
	var _expectedValue = [_value[2][0], _value[2][1], _value[2][2], _value[1][0], _value[1][1],
						  _value[1][2], _value[0][0], _value[0][1], _value[0][2]];
	
	unitTest.assert_equal("Method: mirrorY()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6],
						  _result[7], _expectedValue[7],
						  _result[8], _expectedValue[8]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: transpose()]
	
	var _base = new Vector2(3, 2);
	var _element = [[new Vector2(0, 0), new Vector2(1, 0), new Vector2(2, 0)],
					[new Vector2(0, 1), new Vector2(1, 1), new Vector2(2, 1)],
					[new Vector2(_base.y, _base.x)]];
	_element[3] = [new Vector2(0, 0), new Vector2(0, 1), new Vector2(0, 2)];
	_element[4] = [new Vector2(1, 0), new Vector2(1, 1), new Vector2(1, 2)];
	var _value = [[1, 2, 3], [4, 5, 6]];
	
	constructor = new Grid(_base);
	constructor.set(_value[0][0], _element[0][0],
					_value[0][1], _element[0][1],
					_value[0][2], _element[0][2],
					_value[1][0], _element[1][0],
					_value[1][1], _element[1][1],
					_value[1][2], _element[1][2]);
	constructor.transpose();
	
	var _result = [constructor.size, constructor.getValue(_element[3][0]),
				   constructor.getValue(_element[3][1]), constructor.getValue(_element[3][2]),
				   constructor.getValue(_element[4][0]), constructor.getValue(_element[4][1]),
				   constructor.getValue(_element[4][2])];
	var _expectedValue = [_element[2][0], _value[0][0], _value[0][1], _value[0][2], _value[1][0],
						  _value[1][1], _value[1][2]];
	
	unitTest.assert_equal("Method: transpose()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: sort()]
	
	var _base = new Vector2(3);
	var _element = [[new Vector2(0, 0), new Vector2(0, 1), new Vector2(0, 2)],
					[new Vector2(1, 0), new Vector2(1, 1), new Vector2(1, 2)],
					[new Vector2(2, 0), new Vector2(2, 1), new Vector2(2, 2)]];
	var _value = [[2, 3, 1], [99, 14, -25], [0.25, 0.67, 2.57]];
	
	constructor = new Grid(_base);
	constructor.set(_value[0][0], _element[0][0],
					_value[0][1], _element[0][1],
					_value[0][2], _element[0][2],
					_value[1][2], _element[1][0],
					_value[1][1], _element[1][1],
					_value[1][0], _element[1][2],
					_value[2][1], _element[2][0],
					_value[2][2], _element[2][1],
					_value[2][0], _element[2][2]);
	constructor.sort(0, true);
	
	var _result = [constructor.getValue(_element[0][0]), constructor.getValue(_element[0][1]),
				   constructor.getValue(_element[0][2]), constructor.getValue(_element[1][0]),
				   constructor.getValue(_element[1][1]), constructor.getValue(_element[1][2]),
				   constructor.getValue(_element[2][0]), constructor.getValue(_element[2][1]),
				   constructor.getValue(_element[2][2])];
	var _expectedValue = [_value[0][2], _value[0][0], _value[0][1], _value[1][0], _value[1][2],
						  _value[1][1], _value[2][0], _value[2][1], _value[2][2]];
	
	unitTest.assert_equal("Method: sort()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6],
						  _result[7], _expectedValue[7],
						  _result[8], _expectedValue[8]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: shuffle()]
	
	//|This test checks results of a method with random results, based on a pre-determined seed.
	// It was not tested on every target platform. Due to difference in how seeds work between them,
	// there is a miniscule non-zero chance that assertion will declare a failure on some of them.
	var _base = new Vector2(200);
	var _element = [new Vector2(0, 0), new Vector2(0, 2), new Vector2(1, 1)];
	var _value = [0.0000167, -5, 20000];
	
	constructor = [new Grid(_base)];
	constructor[0].set(_value[0], _element[0],
					   _value[1], _element[1],
					   _value[2], _element[2]);
	constructor[1] = new Grid(constructor[0]);
	random_set_seed(0);
	constructor[0].shuffle();
	random_set_seed(1);
	constructor[1].shuffle();
	
	var _result = [constructor[0].getValueLocation(_value[0]),
				   constructor[0].getValueLocation(_value[1]),
				   constructor[0].getValueLocation(_value[2]),
				   constructor[1].getValueLocation(_value[0]),
				   constructor[1].getValueLocation(_value[1]),
				   constructor[1].getValueLocation(_value[2])];
	
	var _expectedValue = [_element[0], _element[1], _element[2], _element[0], _element[1],
						  _element[2], true];
	
	unitTest.assert_notEqual("Method: shuffle()",
							 _result[0], _expectedValue[0],
							 _result[1], _expectedValue[1],
							 _result[2], _expectedValue[2],
							 _result[3], _expectedValue[3],
							 _result[4], _expectedValue[4],
							 _result[5], _expectedValue[5],
							 _result[0], _result[3],
							 _result[1], _result[4],
							 _result[2], _result[5]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: toString()]
	
	var _base = new Vector2(2);
	var _element = [new Vector2(0, 0), new Vector2(1, 0), new Vector2(0, 1), new Vector2(1, 1)];
	var _value = [35, 55, -0.0125];
	
	constructor = new Grid(_base);
	constructor.set(_value[0], _element[0],
					_value[1], _element[1],
					_value[2], _element[2]);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName + "(" + string(_base.x) + "x" + string(_base.y) + " - " +
						  "[" + string(_value[0]) + "]" + 
						  "[" + string(_value[1]) + "]" + ", " +
						  "[" + string(_value[2]) + "]" +
						  "[" + string(0) + "]" + + ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: toString(lenght cut)]
	
	var _base = new Vector2(2, 1);
	var _element = [30, "...", "[", "]"];
	var _value = string_repeat("I", (_element[0]));
	
	constructor = new Grid(_base);
	constructor.clear(_value);
	
	var _result = constructor.toString(false, undefined, _element[0], undefined, _element[1],
									   _element[2], _element[3]);
	var _expectedValue = (constructorName + "(" + string(_base.x) + "x" + string(_base.y) + " - " +
						  _element[2] + _value + _element[3] + _element[1] + ")");
	
	unitTest.assert_equal("Method: toString(lenght cut)",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: toString(multiline)]
	
	var _base = new Vector2(3);
	var _element = [["...", "[", "]"], [new Vector2(0, 0), new Vector2(1, 1), new Vector2(2, 2)]];
	var _value = [1, 33, 7];
	
	constructor = new Grid(_base);
	constructor.set(_value[0], _element[1][0],
					_value[1], _element[1][1],
					_value[2], _element[1][2]);
	
	var _result = constructor.toString(true, all, all, undefined, _element[0][0], _element[0][1],
									   _element[0][2]);
	var _expectedValue = (_element[0][1] + string(_value[0]) + _element[0][2] +
						  _element[0][1] + string(0) + _element[0][2] +
						  _element[0][1] + string(0) + _element[0][2] + "\n" +
						  _element[0][1] + string(0) + _element[0][2] +
						  _element[0][1] + string(_value[1]) + _element[0][2] +
						  _element[0][1] + string(0) + _element[0][2] + "\n" +
						  _element[0][1] + string(0) + _element[0][2] +
						  _element[0][1] + string(0) + _element[0][2] +
						  _element[0][1] + string(_value[2]) + _element[0][2] + "\n");
	
	unitTest.assert_equal("Method: toString(multiline)",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Methods: toArray() / fromArray()]
	
	var _base = new Vector2(2);
	var _element = [new Vector2(0, 0), new Vector2(1, 1)];
	var _value = [-2, 5.52];
	
	constructor = [new Grid(_base)];
	constructor[0].set(_value[0], _element[0],
					   _value[1], _element[1]);
	constructor[1] = new Grid(_base);
	constructor[1].fromArray(constructor[0].toArray());
	
	var _result = [constructor[1].getValue(_element[0]), constructor[1].getValue(_element[1])];
	var _expectedValue = [_value[0], _value[1]];
	
	unitTest.assert_equal("Methods: toArray() / fromArray()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Methods: toEncodedString() / fromEncodedString()]
	
	var _base = new Vector2(3);
	var _element = [new Vector2(1, 0), new Vector2(0, 1)];
	var _value = [3535634, -999.99999999999];
	
	constructor = [new Grid(_base)];
	constructor[0].set(_value[0], _element[0],
					   _value[1], _element[1]);
	constructor[1] = new Grid(_base);
	constructor[1].fromEncodedString(constructor[0].toEncodedString());
	
	var _result = [constructor[1].getValue(_element[0]), constructor[1].getValue(_element[1])];
	var _expectedValue = [_value[0], _value[1]];
	
	unitTest.assert_equal("Method: toEncodedString() / fromEncodedString()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
