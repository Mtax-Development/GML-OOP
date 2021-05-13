/// @description Unit Testing
asset = [TestCollisionSprite];

#region [Test: Construction: New constructor]
	
	var _base = [new Vector4(20, 20, 100, 100), new Vector2(10, 10), new Color2(c_red, c_white),
				 0.858, c_aqua, 0.75];
	constructor = new RoundRectangle(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
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
	
	var _base = [new Vector4(100, 100, 200, 200), new Vector2(5, 5), new Color2(c_gray, c_black), 0.9,
				 c_fuchsia, 0.85];
	
	constructor = [new RoundRectangle(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5])];
	constructor[1] = new RoundRectangle(constructor[0]);
	
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
#region [Test: Constructor: Empty / Method: isFunctional()]
	
	var _base = [new Vector4(100, 100, 200, 200), new Vector2(5, 5), new Color2(c_green, c_lime), 0.8,
				 c_fuchsia, 0.84];
	
	constructor = [new RoundRectangle(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]),
				   new RoundRectangle(_base[0]), new RoundRectangle()];
	constructor[3] = new RoundRectangle(constructor[0]);
	constructor[4] = new RoundRectangle(constructor[0]);
	constructor[4].location = undefined;
	constructor[5] = new RoundRectangle(constructor[0]);
	constructor[5].radius = undefined;
	constructor[6] = new RoundRectangle(constructor[0]);
	constructor[6].fill_color = undefined;
	constructor[7] = new RoundRectangle(constructor[0]);
	constructor[7].fill_alpha = undefined;
	constructor[8] = new RoundRectangle(constructor[0]);
	constructor[8].outline_color = undefined;
	constructor[9] = new RoundRectangle(constructor[0]);
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
	
	var _element = 10;
	var _base = [new Vector4(x, (y - (_element / 2)), (x + _element),
							 (y - (_element / 2) + _element)),
				 new Vector4((x + 1), (y - (_element / 2)), (x + 1 + _element),
							 (y - (_element / 2) + _element))];
	constructor = [new RoundRectangle(_base[0]), new RoundRectangle(_base[1])];
	
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
		var _base = new Vector4(11, 11, 110, 110);
		
		constructor = new RoundRectangle(_base);
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
		
		constructor = new RoundRectangle(_base);
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
		
		constructor = new RoundRectangle(_base);
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
		
		constructor = new RoundRectangle(_base);
		constructor.cursorReleased(_element);
	 }
	);
	
#endregion
#region [Test: Method: render()]
	
	unitTest.assert_executable
	("Method: render()",
	 function()
	 {
		var _base = [new Vector4(15, 15, 150, 150), new Vector2(5, 5), c_red,
					 new Color2(c_red, c_blue), 0.8, c_yellow, 0.7];
		
		constructor = [new RoundRectangle(_base[0], _base[1], _base[2], _base[4], _base[5],
										  _base[6]),
					   new RoundRectangle(_base[0], _base[1], _base[3], _base[4], _base[5],
										  _base[6])];
		constructor[0].render();
		constructor[1].render();
	 }
	);
	
#endregion
#region [Test: Method: toString()]
	
	var _base = [new Vector4(15, 35, 25, 40), new Vector2(2, 2)];
	
	constructor = new RoundRectangle(_base[0], _base[1]);
	
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
	
	var _element = [["Blue"], ["\n", ", "]];
	var _base = [new Vector4(25, 12, 155, 162), new Vector2(6, 7),
				 new Color2(c_lime, make_color_rgb(87, 83, 187)), 0.95, c_blue, 0.8];
	
	constructor = new RoundRectangle(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
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
