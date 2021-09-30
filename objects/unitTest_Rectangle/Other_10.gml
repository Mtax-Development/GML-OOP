/// @description Unit Testing
asset = [TestCollisionSprite];

#region [Test: Construction: New constructor]
	
	var _base = [new Vector4(20, 20, 200, 200), new Color4(c_red, c_green, c_blue, c_black), 0.87,
				 new Color4(c_yellow, c_blue, c_green, c_red), 2, 0.67]; 
	
	constructor = new Rectangle(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	var _result = [constructor.location, constructor.fill_color, constructor.fill_alpha,
				   constructor.outline_color, constructor.outline_size, constructor.outline_alpha];
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
	
	var _base = [new Vector4(20, 20, 200, 200), new Color4(c_navy, c_green, c_green, c_red),
				 0.37, new Color4(c_yellow, c_green, c_green, c_red), 1, 0.27]; 
	
	constructor = [new Rectangle(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5])];
	constructor[1] = new Rectangle(constructor[0]);
	
	var _result = [constructor[1].location, constructor[1].fill_color, constructor[1].fill_alpha,
				   constructor[1].outline_color, constructor[1].outline_size,
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
#region [Test: Constructor: Empty / Method: isFunctional()]
	
	var _base = [new Vector4(20, 20, 200, 200), c_navy, 0.37,
				 new Color4(c_yellow, c_green, c_green, c_red), 1, 0.27]; 
	
	constructor = [new Rectangle(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]),
				   new Rectangle(_base[0]), new Rectangle()];
	constructor[3] = new Rectangle(constructor[0]);
	constructor[4] = new Rectangle(constructor[0]);
	constructor[4].location = undefined;
	constructor[5] = new Rectangle(constructor[0]);
	constructor[5].fill_color = undefined;
	constructor[6] = new Rectangle(constructor[0]);
	constructor[6].fill_alpha = undefined;
	constructor[7] = new Rectangle(constructor[0]);
	constructor[7].outline_color = undefined;
	constructor[8] = new Rectangle(constructor[0]);
	constructor[8].outline_size = undefined;
	constructor[9] = new Rectangle(constructor[0]);
	constructor[9].outline_alpha = undefined;
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional(),
				   constructor[2].isFunctional(), constructor[3].isFunctional(),
				   constructor[4].isFunctional(), constructor[5].isFunctional(),
				   constructor[6].isFunctional(), constructor[7].isFunctional(),
				   constructor[8].isFunctional(), constructor[9].isFunctional()];
	var _expectedValue = [true, true, false, true, false, true, true, true, true, true];
	
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
	
	var _element = 10;
	var _base = [new Vector4(x, y, (x + _element), (y + _element)),
				 new Vector4((x + 1), y, (x + 1 + _element), (y + _element))];
	constructor = [new Rectangle(_base[0]), new Rectangle(_base[1])];
	
	sprite_index = asset[0];
	
	var _result = [constructor[0].collision(id), constructor[1].collision(id)];
	var _expectedValue = [id, noone];
	
	unitTest.assert_equal("Method: collision()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: containsPoint()]
	
	var _base = new Vector4(0, 0, 50, 50);
	var _element = [new Vector2(_base.x2, _base.y2), new Vector2((_base.x2 + 1), (_base.y2 + 1))];
	
	constructor = new Rectangle(_base);
	
	var _result = [constructor.containsPoint(_element[0]), constructor.containsPoint(_element[1])];
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
		var _base = new Vector4(11, 11, 110, 110);
		
		constructor = new Rectangle(_base);
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
		var _base = new Vector4(12, 12, 120, 120);
		
		constructor = new Rectangle(_base);
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
		var _base = new Vector4(13, 13, 130, 130);
		
		constructor = new Rectangle(_base);
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
		var _base = new Vector4(14, 14, 140, 140);
		
		constructor = new Rectangle(_base);
		constructor.cursorReleased(_element);
	 }
	);
	
#endregion
#region [Test: Method: render()]
	
	unitTest.assert_executable
	("Method: render()",
	 function()
	 {
		var _base = [new Vector4(15, 15, 150, 150), c_red, new Color4(c_navy, c_red, c_blue, c_green),
					 0.8, c_yellow, new Color4(c_orange, c_yellow, c_green, c_blue), 2, 0.7];
		
		constructor = [new Rectangle(_base[0], _base[1], _base[3], _base[4], _base[6], _base[7]),
					   new Rectangle(_base[0], _base[2], _base[3], _base[5], _base[6], _base[7])];
		constructor[0].render();
		constructor[1].render();
	 }
	);
	
#endregion
#region [Test: Method: toString()]
	
	var _base = new Vector4(15, 35, 25, 40);
	
	constructor = new Rectangle(_base);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName + "(" + "Location: " + string(_base) + ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(multiline?, full)]
	
	var _element = [["White"], ["\n", ", "]];
	var _base = [new Vector4(25, 12, 155, 162),
				 new Color4(c_lime, make_color_rgb(37, 23, 167), c_navy, c_yellow), 0.95, c_white, 3,
				 1];
	
	constructor = new Rectangle(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	var _result = [constructor.toString(true, true), constructor.toString(false, true)];
	var _expectedValue = [];
	
	var _i = 0;
	repeat (array_length(_element[1]))
	{
		array_push(_expectedValue,
				   "Location: " + string(_base[0]) + _element[1][_i] +
				   "Fill Color: " + string(_base[1]) + _element[1][_i] +
				   "Fill Alpha: " + string(_base[2]) + _element[1][_i] +
				   "Outline Color: " + _element[0][0] + _element[1][_i] +
				   "Outline Size: " + string(_base[4]) + _element[1][_i] +
				   "Outline Alpha: " + string(_base[5]));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "(" + _expectedValue[1] + ")");
	
	unitTest.assert_equal("Method: toString(multiline?, full)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Events: beforeRender / afterRender]
	
	var _base = [new Vector4(10, 10, 155, 200), new Color4(c_red, c_white, c_blue, c_black), 0.97,
				 new Color4(c_yellow, c_blue, c_green, c_red), 2, 0.77]; 
	var _value = [75, 37];
	
	constructor = new Rectangle(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
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
