/// @description Unit Testing
asset = [TestCollisionSprite];

#region [Test: Construction: New constructor]
	
	var _base = [new Vector2(50, 50), 20, c_purple, 0.98, c_orange, 0.752];
	
	constructor = new Circle(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	var _result = [constructor.location, constructor.radius, constructor.fill_color,
				   constructor.fill_alpha, constructor.outline_color, constructor.outline_alpha];
	var _expectedValue = [_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]];
	
	unitTest.assert_equal("Construction: New constructor",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _base = [new Vector2(70, 70), 15, new Color2(c_orange, c_aqua), 0.98, c_orange, 0.8];
	
	constructor = [new Circle(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5])];
	constructor[1] = new Circle(constructor[0]);
	
	var _result = [constructor[1].location, constructor[1].radius, constructor[1].fill_color,
				   constructor[1].fill_alpha, constructor[1].outline_color,
				   constructor[1].outline_alpha];
	var _expectedValue = [_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]];
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
#endregion
#region [Test: Construction: Empty / Method: isFunctional()]
	
	var _base = [new Vector2(70, 70), 15, c_lime, 0, c_orange, 0.5];
	
	constructor = [new Circle(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]),
				   new Circle(_base[0], _base[1]), new Circle()];
	constructor[3] = new Circle(constructor[0]);
	constructor[4] = new Circle(constructor[0]);
	constructor[4].location = undefined;
	constructor[5] = new Circle(constructor[0]);
	constructor[5].radius = undefined;
	constructor[6] = new Circle(constructor[0]);
	constructor[6].fill_color = undefined;
	constructor[7] = new Circle(constructor[0]);
	constructor[7].fill_alpha = undefined;
	constructor[8] = new Circle(constructor[0]);
	constructor[8].outline_color = undefined;
	constructor[9] = new Circle(constructor[0]);
	constructor[9].outline_alpha = undefined;
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional(),
				   constructor[2].isFunctional(), constructor[3].isFunctional(),
				   constructor[4].isFunctional(), constructor[5].isFunctional(),
				   constructor[6].isFunctional(), constructor[7].isFunctional(),
				   constructor[8].isFunctional(), constructor[9].isFunctional()];
	var _expectedValue = [true, true, false, true, false, false, true, true, true, true];
	
	unitTest.assert_equal("Construction: Empty / Method: isFunctional()",
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
	
#endregion
#region [Test: Method: collision()]
	
	var _element = 6;
	var _base = [[new Vector2((x + _element), y), _element],
				 [new Vector2((x + _element + 1), y), _element]];
	
	constructor = [new Circle(_base[0][0], _base[0][1]), new Circle(_base[1][0], _base[1][1])];
	
	sprite_index = asset[0];
	
	var _result = [constructor[0].collision(id), constructor[1].collision(id)];
	var _expectedValue = [id, noone];
	
	unitTest.assert_equal("Method: collision()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: containsPoint()]
	
	var _element = [[new Vector2(50, 50)], [40]];
	_element[2][0] = new Vector2((_element[0][0].x + _element[1][0]), _element[0][0].y);
	_element[2][1] = new Vector2((_element[0][0].x + _element[1][0] + 1), _element[0][0].y);
	var _base = [_element[0][0], _element[1][0]];
	
	constructor = new Circle(_base[0], _base[1]);
	
	var _result = [constructor.containsPoint(_element[2][0]),
				   constructor.containsPoint(_element[2][1])];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: containsPoint()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: cursorOver()]
	
	unitTest.assert_executable
	("Method: cursorOver()",
	 function()
	 {
		var _base = [new Vector2(100, 100), 10];
		
		constructor = new Circle(_base[0], _base[1]);
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
		var _base = [new Vector2(110, 110), 11];
		
		constructor = new Circle(_base[0], _base[1]);
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
		var _base = [new Vector2(120, 120), 12];
		
		constructor = new Circle(_base[0], _base[1]);
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
		var _base = [new Vector2(130, 140), 13];
		
		constructor = new Circle(_base[0], _base[1]);
		constructor.cursorReleased(_element);
	 }
	);
	
#endregion
#region [Test: Method: render()]
	
	unitTest.assert_executable
	("Method: render()",
	 function()
	 {
		var _base = [new Vector2(140, 100), 14, new Color2(c_yellow, c_orange), 0.98, c_red, 0.95];
		
		constructor = new Circle(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
		constructor.render();
	 }
	);
	
#endregion
#region [Test: Method: toString()]
	
	var _base = [new Vector2(25, 35), 15];
	
	constructor = new Circle(_base[0], _base[1]);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName +
						  "(" +
						  "Location: " + string(_base[0]) + ", " +
						  "Radius: " + string(_base[1]) +
						  ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(multiline?, full)]
	
	var _element = [["Orange"], ["\n", ", "]];
	var _base = [new Vector2(45, 32), 14, new Color2(c_blue, make_color_rgb(137, 73, 37)), 0.98,
				 c_orange, 0.95];
	
	constructor = new Circle(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	var _result = [constructor.toString(true, true), constructor.toString(false, true)];
	var _expectedValue = [];
	
	var _i = 0;
	repeat (array_length(_element[1]))
	{
		array_push(_expectedValue,
				   "Location: " + string(_base[0]) + _element[1][_i] +
				   "Radius: " + string(_base[1]) + _element[1][_i] +
				   "Fill Color: " + string(_base[2]) + _element[1][_i] +
				   "Fill Alpha: " + string(_base[3]) + _element[1][_i] +
				   "Outline Color: " + _element[0][0] + _element[1][_i] +
				   "Outline Alpha: " + string(_base[5]));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "(" + _expectedValue[1] + ")");
	
	unitTest.assert_equal("Method: toString(multiline?, full)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Events: beforeRender / afterRender]
	
	var _base = [new Vector2(120, 100), 12, new Color2(c_white, c_orange), 0.68, c_black, 0.75];
	var _value = [4.13, 3.14];
	
	constructor = new Circle(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
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
