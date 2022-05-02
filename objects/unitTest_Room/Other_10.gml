/// @description Unit Testing
asset = [TestObject];

#region [Test: Construction: New constructor / Method: isFunctional()]
	
	constructor = new Room();
	
	var _result = constructor.isFunctional();
	var _expectedValue = true;
	
	unitTest.assert_equal("Construction: New constructor / Method: isFunctional()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Construction: Wrapper]
	
	constructor = new Room(room);
	
	var _result = [constructor.ID, constructor.isFunctional()];
	var _expectedValue = [room, true];
	
	unitTest.assert_equal("Construction: Wrapper",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Construction: Constructor copy / Method: setSize()]
	
	var _element = new Vector2(25, 25);
	
	constructor = [new Room()];
	constructor[0].setSize(_element);
	constructor[1] = new Room(constructor[0]);
	
	var _result = [constructor[1].size, constructor[1].isFunctional()];
	var _expectedValue = [_element, true];
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: copy()]
	
	var _element = new Vector2(38, 38);
	
	constructor = [new Room(), new Room()];
	constructor[0].setSize(_element);
	constructor[1].copy(constructor[0]);
	
	var _result = constructor[1].size;
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: copy()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: isActive()]
	
	constructor = [new Room(room), new Room()];
	
	var _result = [constructor[0].isActive(), constructor[1].isActive()];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: isActive()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: setPersistent()]
	
	var _element = true;
	
	constructor = new Room();
	constructor.setPersistent(_element);
	
	var _result = constructor.persistent;
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: setPersistent()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: createInstance()]
	
	var _element = asset[0];
	
	constructor = new Room();
	_element[1] = constructor.createInstance(_element);
	
	var _result = [_element[1].isFunctional(), constructor.addedInstances[0]];
	var _expectedValue = [true, _element[1]];
	
	unitTest.assert_equal("Method: createInstance()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: setActive()]
	
	unitTest.assert_untestable("Method: setActive()");
	
#endregion
#region [Test: Method: toString()]
	
	var _element = room_get_name(room);
	
	constructor = new Room(room);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName + "(" + "ID: " + string(room) + ", " + "Name: " +
						  _element + ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(multiline?, full)]
	
	var _element = [["\n", ", "], [true, new Vector2(64, 32), asset[0]]];
	
	constructor = new Room();
	constructor.setPersistent(_element[1][0]);
	constructor.setSize(_element[1][1]);
	constructor.createInstance(_element[1][2], _element[1][1]);
	
	var _result = [constructor.toString(true, true), constructor.toString(false, true)];
	var _expectedValue = [];
	
	var _i = 0;
	repeat (array_length(_element))
	{
		array_push(_expectedValue,
				   ("ID: " + string(constructor.ID) + _element[0][_i] +
					"Name: " + string(constructor.name) + _element[0][_i] +
					"Persistent: " + string(_element[1][0]) + _element[0][_i] +
					"Size: " + string(_element[1][1]) + _element[0][_i] +
					"Added Instance Count:" + string(1) + _element[0][_i] +
					"Visited: " + string(false) + _element[0][_i] +
					"Persistence on Visit: " + string(undefined) + _element[0][_i] +
					"Previous Room: " + string(undefined)));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "(" + _expectedValue[1] + ")");
	
	unitTest.assert_equal("Method: toString(multiline?, full)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: AddedInstance - Construction: New constructor / Method: isFunctional()]
	
	constructor = new Room();
	
	with (constructor)
	{
		var _element = [other.asset[0], new Vector2(18, 18)];
		
		constructor = new AddedInstance(_element[0], _element[1]);
		
		var _result = [constructor.isFunctional(), constructor.object, constructor.location,
					   other.constructor.addedInstances[0]];
		var _expectedValue = [true, _element[0], _element[1], constructor];
		
		other.unitTest.assert_equal("AddedInstance - Construction: New constructor / " +
									"Method: isFunctional()",
									_result[0], _expectedValue[0],
									_result[1], _expectedValue[1],
									_result[2], _expectedValue[2],
									_result[3], _expectedValue[3]);
	}
	
#endregion
#region [Test: AddedInstance - Construction: Constructor copy]
	
	constructor = new Room();
	
	with (constructor)
	{
		var _element = [other.asset[0], new Vector2(12, 15)];
		
		constructor = [new AddedInstance(_element[0], _element[1])];
		constructor[1] = new AddedInstance(constructor[0]);
		
		var _result = [constructor[1].isFunctional(), constructor[1].object, constructor[1].location,
					   other.constructor.addedInstances[1]];
		var _expectedValue = [true, _element[0], _element[1], constructor[1]];
		
		other.unitTest.assert_equal("AddedInstance - Construction: Constructor copy",
									_result[0], _expectedValue[0],
									_result[1], _expectedValue[1],
									_result[2], _expectedValue[2],
									_result[3], _expectedValue[3]);
	}
	
#endregion
#region [Test: AddedInstance - Method: toString()]
	
	var _element = [[asset[0], new Vector2(31, 21)], ["AddedInstance"]];
	constructor = new Room();
	_element[2] = [constructor.createInstance(_element[0][0], _element[0][1])];
	
	var _result = _element[2][0].toString();
	var _expectedValue = (constructorName + "." + _element[1][0] + "(" + "Object: " +
						  object_get_name(_element[0][0]) + ", " + "Location: " +
						  string(_element[0][1]) + ")");
	
	unitTest.assert_equal("AddedInstance - Method: toString()",
						  _result, _expectedValue);
	
#endregion
#region [Test: AddedInstance - Method: toString(multiline)]
	
	var _element = [[asset[0], new Vector2(151, 22)], ["AddedInstance"]];
	constructor = new Room();
	_element[2] = [constructor.createInstance(_element[0][0], _element[0][1])];
	
	var _result = _element[2][0].toString(true);
	var _expectedValue = ("Object: " + object_get_name(_element[0][0]) + "\n" +
						  "Location: " + string(_element[0][1]));
	
	unitTest.assert_equal("AddedInstance - Method: toString(multiline)",
						  _result, _expectedValue);
	
#endregion

