/// @description Unit Testing
asset = [TestCollisionSprite];

#region [Test: Construction: New constructor]
	
	var _base = [new Vector2(150, 150), new Vector2(100, 150), new Vector2(200, 150),
				 new Color3(c_yellow, c_blue, c_aqua), 0.9879,
				 new Color3(make_color_rgb(222, 111, 11), c_aqua, c_orange), 0.78];
	
	constructor = new Triangle(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5], _base[6]);
	
	var _result = [constructor.location1, constructor.location2, constructor.location3,
				   constructor.fill_color, constructor.fill_alpha, constructor.outline_color,
				   constructor.outline_alpha];
	var _expectedValue = [_base[0], _base[1], _base[2], _base[3], _base[4], _base[5], _base[6]];
	
	unitTest.assert_equal("Construction: New constructor",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6]);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _base = [new Vector2(150, 150), new Vector2(200, 100), new Vector2(200, 200),
				 new Color3(c_aqua, c_blue, c_aqua), 0.59,
				 new Color3(make_color_rgb(1, 11, 111), c_red, c_orange), 0.85];
	
	constructor = [new Triangle(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5],
								_base[6])];
	constructor[1] = new Triangle(constructor[0]);
	
	var _result = [constructor[1].location1, constructor[1].location2, constructor[1].location3,
				   constructor[1].fill_color, constructor[1].fill_alpha, constructor[1].outline_color,
				   constructor[1].outline_alpha];
	
#endregion
#region [Test: Constructor: Empty / Method: isFunctional()]
	
	var _base = [new Vector2(100, 100), new Vector2(200, 200), new Vector2(70, 200),
				 new Color3(c_orange, c_blue, c_aqua), 0.7, c_red, 0.67];
	
	constructor = [new Triangle(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5], _base[6]),
				   new Triangle(_base[0], _base[1], _base[2]), new Triangle()];
	constructor[3] = new Triangle(constructor[0]);
	constructor[4] = new Triangle(constructor[0]);
	constructor[4].location1 = undefined;
	constructor[5] = new Triangle(constructor[0]);
	constructor[5].location2 = undefined;
	constructor[6] = new Triangle(constructor[0]);
	constructor[6].location3 = undefined;
	constructor[7] = new Triangle(constructor[0]);
	constructor[7].fill_color = undefined;
	constructor[8] = new Triangle(constructor[0]);
	constructor[8].fill_alpha = undefined;
	constructor[9] = new Triangle(constructor[0]);
	constructor[9].outline_color = undefined;
	constructor[10] = new Triangle(constructor[0]);
	constructor[10].outline_alpha = undefined;
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional(),
				   constructor[2].isFunctional(), constructor[3].isFunctional(),
				   constructor[4].isFunctional(), constructor[5].isFunctional(),
				   constructor[6].isFunctional(), constructor[7].isFunctional(),
				   constructor[8].isFunctional(), constructor[9].isFunctional(),
				   constructor[1].isFunctional()];
	var _expectedValue = [true, true, false, true, false, false, false, true, true, true, true];
	
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
						  _result[9], _expectedValue[9],
						  _result[10], _expectedValue[10]);
	
#endregion
#region [Test: Method: containsPoint()]
	
	var _element = [[100]];
	_element[1] = [new Vector2(_element[0][0], _element[0][0]),
				   new Vector2(_element[0][0], (_element[0][0] - 1))];
	var _base = [new Vector2(_element[0][0], _element[0][0]),
				 new Vector2((_element[0][0] * 2), (_element[0][0] * 2)),
				 new Vector2(_element[0][0], (_element[0][0] * 2))];
	
	constructor = new Triangle(_base[0], _base[1], _base[2]);
	
	var _result = [constructor.containsPoint(_element[1][0]),
				   constructor.containsPoint(_element[1][1])];
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
		var _base = [new Vector2(150, 155), new Vector2(100, 155), new Vector2(200, 155)];
		
		constructor = new Triangle(_base[0], _base[1], _base[2]);
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
		var _base = [new Vector2(150, 160), new Vector2(100, 160), new Vector2(200, 160)];
		
		constructor = new Triangle(_base[0], _base[1], _base[2]);
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
		var _base = [new Vector2(150, 165), new Vector2(100, 165), new Vector2(200, 165)];
		
		constructor = new Triangle(_base[0], _base[1], _base[2]);
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
		var _base = [new Vector2(150, 170), new Vector2(100, 170), new Vector2(200, 170)];
		
		constructor = new Triangle(_base[0], _base[1], _base[2]);
		constructor.cursorReleased(_element);
	 }
	);
	
#endregion
#region [Test: Method: render()]
	
	unitTest.assert_executable
	("Method: render()",
	 function()
	 {
		var _base = [new Vector2(150, 170), new Vector2(100, 170), new Vector2(200, 170), c_red,
					 new Color3(c_aqua, c_maroon, c_lime), 0.85, c_yellow,
					 new Color3(c_aqua, c_yellow, c_green), 0.75];
		
		constructor = [new Triangle(_base[0], _base[1], _base[2], _base[3], _base[5], _base[6],
									_base[8]),
					   new Triangle(_base[0], _base[1], _base[2], _base[4], _base[5], _base[7],
									_base[8])];
		constructor[0].render();
		constructor[1].render();
	 }
	);
	
#endregion
#region [Test: Method: toString()]
	
	var _base = [new Vector2(150, 180), new Vector2(100, 180), new Vector2(200, 180)];
	
	constructor = new Triangle(_base[0], _base[1], _base[2]);
	
	_result = constructor.toString();
	_expectedValue = (constructorName + "(" + "Location: " + "(" + string(_base[0]) + ", " +
					  string(_base[1]) + ", " + string(_base[2]) + ")" + ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(multiline?, full)]
	
	var _element = [["Lime", "(", ")", ", "], ["\n", ", "]];
	var _base = [new Vector2(24, 12), new Vector2(155, 162), new Vector2(11, 162),
				 new Color3(c_yellow, make_color_rgb(234, 254, 1), c_navy), 0.94, c_lime, 1];
	
	constructor = new Triangle(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5], _base[6]);
	
	var _result = [constructor.toString(true, true), constructor.toString(false, true)];
	var _expectedValue = [];
	
	var _i = 0;
	repeat (array_length(_element[1]))
	{
		array_push(_expectedValue,
				   "Location: " + string(_element[0][1]) + string(_base[0]) + string(_element[0][3])
								+ string(_base[1]) + string(_element[0][3]) + string(_base[2])
								+ _element[0][2] + _element[1][_i] +
				   "Fill Color: " + string(_base[3]) + _element[1][_i] +
				   "Fill Alpha: " + string(_base[4]) + _element[1][_i] +
				   "Outline Color: " + _element[0][0] + _element[1][_i] +
				   "Outline Alpha: " + string(_base[6]));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "(" + _expectedValue[1] + ")");
	
	unitTest.assert_equal("Method: toString(multiline?, full)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Events: beforeRender / afterRender]
	
	var _base = [new Vector2(20, 40), new Vector2(0, 60), new Vector2(70, 60),
				 new Color3(c_gray, c_yellow, c_aqua), 0.35,
				 new Color3(c_white, c_aqua, c_red), 0.58];
	var _value = [95, 29];
	
	constructor = new Triangle(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5], _base[6]);
	
	var _result = [];
	
	constructor.event.beforeRender.callback = function(_argument)
	{
		array_push(_argument[0], _argument[1]);
	}
	
	constructor.event.beforeRender.argument = [_result, _value[0]];
	
	constructor.event.afterRender.callback = function(_argument)
	{
		array_push(_argument[0], (_argument[0][(array_length(_argument[0]) - 1)] + _argument[1]));
	}
	
	constructor.event.afterRender.argument = [_result, _value[1]];
	
	constructor.render();
	
	var _expectedValue = [_value[0], (_value[0] + _value[1])];
	
	unitTest.assert_equal("Event: beforeRender / afterRender",
						  _result, _expectedValue);
	
#endregion
