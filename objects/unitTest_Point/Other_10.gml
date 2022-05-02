/// @description Unit Testing
asset = [TestCollisionSprite];

#region [Test: Construction: New constructor]
	
	var _base = [new Vector2(0, 0), c_green, 0.99];
	
	constructor = new Point(_base[0], _base[1], _base[2]);
	
	var _result = [constructor.location, constructor.color, constructor.alpha];
	var _expectedValue = [_base[0], _base[1], _base[2]];
	
	unitTest.assert_equal("Construction: New constructor",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _base = [new Vector2(0, 0), c_yellow, 0.54];
	
	constructor = [new Point(_base[0], _base[1], _base[2])];
	constructor[1] = new Point(constructor[0]);
	
	var _result = [constructor[1].location, constructor[1].color, constructor[1].alpha];
	var _expectedValue = [_base[0], _base[1], _base[2]];
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Construction: Empty / Method: isFunctional()]
	
	var _base = [new Vector2(200, 150), c_aqua, 0.849];
	
	constructor = [new Point(_base[0], _base[1], _base[2]), new Point(_base[0]), new Point()];
	constructor[3] = new Point(constructor[0]);
	constructor[3].location = undefined;
	constructor[4] = new Point(constructor[0]);
	constructor[4].color = undefined;
	constructor[5] = new Point(constructor[0]);
	constructor[5].alpha = undefined;
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional(),
				   constructor[2].isFunctional(), constructor[3].isFunctional(),
				   constructor[4].isFunctional(), constructor[5].isFunctional()];
	var _expectedValue = [true, true, false, false, true, true];
	
	unitTest.assert_equal("Construction: Empty / Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
#endregion
#region [Test: Method: collision()]
	
	var _base = [new Vector2(x, y), new Vector2((x + 1), (y + 1))];
	
	constructor = [new Point(_base[0]), new Point(_base[1])];
	
	sprite_index = asset[0];
	
	var _result = [constructor[0].collision(id), constructor[1].collision(id)];
	var _expectedValue = [id, noone];
	
	unitTest.assert_equal("Method: collision()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: cursorOver()]
	
	unitTest.assert_executable
	("Method: cursorOver()",
	 function()
	 {
		var _base = new Vector2(110, 110);
		
		constructor = new Point(_base);
		constructor.cursorOver();
	 }
	);
	
#endregion
#region [Test: Method: cursorHold()]
	
	unitTest.assert_executable
	("Method: cursorHold()",
	 function()
	 {
		var _element = mb_left;
		var _base = new Vector2(120, 120);
		
		constructor = new Point(_base);
		constructor.cursorHold(_element);
	 }
	);
	
#endregion
#region [Test: Method: cursorPressed()]
	
	unitTest.assert_executable
	("Method: cursorPressed()",
	 function()
	 {
		var _element = mb_right;
		var _base = new Vector2(130, 130);
		
		constructor = new Point(_base);
		constructor.cursorHold(_element);
	 }
	);
	
#endregion
#region [Test: Method: cursorReleased()]
	
	unitTest.assert_executable
	("Method: cursorReleased()",
	 function()
	 {
		var _element = mb_middle;
		var _base = new Vector2(140, 140);
		
		constructor = new Point(_base);
		constructor.cursorReleased(_element);
	 }
	);
	
#endregion
#region [Test: Method: render()]
	
	unitTest.assert_executable
	("Method: render()",
	 function()
	 {
		var _base = [new Vector2(10, 10), c_red, 0.9];
		
		constructor = new Point(_base[0], _base[1], _base[2]);
		constructor.render();
	 }
	);
	
#endregion
#region [Test: Method: toString()]
	
	var _base = new Vector2(20, 30);
	
	constructor = new Point(_base);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName + "(" + "Location: " + string(_base) + ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(multiline?, full)]
	
	var _element = [["Yellow"], ["\n", ", "]];
	var _base = [new Vector2(40, 50), c_yellow, 1];
	
	constructor = new Point(_base[0], _base[1], _base[2]);
	
	var _result = [constructor.toString(true, true), constructor.toString(false, true)];
	var _expectedValue = [];
	
	var _i = 0;
	repeat (array_length(_element[1]))
	{
		array_push(_expectedValue,
				   "Location: " + string(_base[0]) + _element[1][_i] +
				   "Color: " + _element[0][0] + _element[1][_i] +
				   "Alpha: " + string(_base[2]));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "(" + _expectedValue[1] + ")");
	
	unitTest.assert_equal("Method: toString(multiline?, full)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Events: beforeRender / afterRender]
	
	var _base = [new Vector2(70, 70), c_red, 0.95];
	var _value = [25, 29];
	
	constructor = new Point(_base[0], _base[1], _base[2]);
	
	var _result = [];
	
	constructor.event.beforeRender.callback = function()
	{
		array_push(argument[0], argument[1]);
	}
	
	constructor.event.beforeRender.argument = [[_result, _value[0]]];
	
	constructor.event.afterRender.callback = function()
	{
		array_push(argument[0], (argument[0][(array_length(argument[0]) - 1)] + argument[1]));
	}
	
	constructor.event.afterRender.argument = [[_result, _value[1]]];
	
	constructor.render();
	
	var _expectedValue = [_value[0], (_value[0] + _value[1])];
	
	unitTest.assert_equal("Event: beforeRender / afterRender",
						  _result, _expectedValue);
	
#endregion

