/// @description Unit Testing
asset = [TestSprite];

#region [Test: Construction: New constructor / Method: isFunctional()]
	
	var _element = [new Sprite(asset[0]), new Vector2(50, 50), new Scale(0.5, 0.2), new Angle(0),
					new Vector4(0, 0, 1, 1), new Vector2(0, 0), new Surface(new Vector2(1, 1))];
	var _base = [_element[0], _element[1], 0, _element[2], _element[3], c_red, 0.75, _element[4],
				 _element[5], _element[6]];
	
	constructor = new SpriteRenderer(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5],
									 _base[6], _base[7], _base[8], _base[9]);
	
	var _result = [constructor.isFunctional()];
	var _expectedValue = [true];
	
	constructor.sprite = undefined;
	
	array_push(_result, constructor.isFunctional());
	array_push(_expectedValue, false);
	
	unitTest.assert_equal("Construction: New constructor / Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	_element[6].destroy();
	
#endregion
#region [Test: Construction: Empty]
	
	constructor = new SpriteRenderer();
	
	var _result = constructor.isFunctional();
	var _expectedValue = false;
	
	unitTest.assert_equal("Construction: Empty",
						  _result, _expectedValue);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _element = [new Sprite(asset[0]), new Vector4(10, 10, 50, 50), new Scale(0.25, -3),
					new Angle(20), new Vector4(0, 0, 1, 1), new Vector2(5, 5),
					new Surface(new Vector2(1, 1)), function(_) {return _;}, "argument"];
	var _base = [_element[0], _element[1], 0, _element[2], _element[3], c_yellow, 0.75, _element[4],
				 _element[5], _element[6]];
	
	constructor = [new SpriteRenderer(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5],
									 _base[6], _base[7], _base[8], _base[9])];
	constructor[0].event.beforeRender.callback = _element[7];
	constructor[0].event.beforeRender.argument = _element[8];
	constructor[0].event.afterRender.callback = _element[7];
	constructor[0].event.afterRender.argument = _element[8];
	
	constructor[1] = new SpriteRenderer(constructor[0]);
	
	var _result = [constructor[1].sprite.ID, constructor[1].location.x1, constructor[1].location.y1,
				   constructor[1].location.x2, constructor[1].location.y2, constructor[1].frame,
				   constructor[1].scale.x, constructor[1].scale.y, constructor[1].angle.value,
				   constructor[1].color, constructor[1].alpha, constructor[1].part.x1,
				   constructor[1].part.y1, constructor[1].part.x2, constructor[1].part.y2,
				   constructor[1].origin.x, constructor[1].origin.y, constructor[1].target.ID,
				   constructor[1].event.beforeRender.callback,
				   constructor[1].event.beforeRender.argument,
				   constructor[1].event.afterRender.callback,
				   constructor[1].event.afterRender.argument];
	var _expectedValue = [_element[0].ID, _element[1].x1, _element[1].y1, _element[1].x2,
						  _element[1].y2, _base[2], _element[2].x, _element[2].y, _element[3].value,
						  _base[5], _base[6], _element[4].x1, _element[4].y1, _element[4].x2,
						  _element[4].y2, _element[5].x, _element[5].y, _element[6].ID, _element[7],
						  _element[8], _element[7], _element[8]];
	
	unitTest.assert_equal("Construction: Constructor copy",
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
						  _result[10], _expectedValue[10],
						  _result[11], _expectedValue[11],
						  _result[12], _expectedValue[12],
						  _result[13], _expectedValue[13],
						  _result[14], _expectedValue[14],
						  _result[15], _expectedValue[15],
						  _result[16], _expectedValue[16],
						  _result[17], _expectedValue[17],
						  _result[18], _expectedValue[18],
						  _result[19], _expectedValue[19],
						  _result[20], _expectedValue[20],
						  _result[21], _expectedValue[21]);
	
	_element[6].destroy();
	
#endregion
#region [Test: Method: render()]
	
	unitTest.assert_executable
	("Method: render()",
	 function()
	 {
		var _element = [new Sprite(other.asset[0]), new Vector4(10, 10, 50, 50), new Scale(0.25, -3),
						new Angle(20), new Vector4(0, 0, 1, 1), new Vector2(2, 5),
						new Surface(new Vector2(1, 1))];
		var _base = [_element[0], _element[1], 0, _element[2], _element[3], c_yellow, 0.75,
					 _element[4], _element[5], _element[6]];
		
		constructor = new SpriteRenderer(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5],
										 _base[6], _base[7], _base[8], _base[9]);
		
		constructor.render();
		
		_element[6].destroy();
	 }
	);
	
#endregion
#region [Test: Method: toString()]
	
	var _element = [new Sprite(asset[0]), new Vector2(555, 555)];
	
	constructor = new SpriteRenderer(_element[0], _element[1]);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName +
						  "(" +
						  "Sprite: " + string(_element[0]) + ", " +
						  "Location: " + string(_element[1]) +
						  ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(multiline?, full)]
	
	var _element = [["\n", ", "], ["Yellow"], [new Sprite(asset[0]), new Vector2(75, 75), 0,
					new Scale(0.5, 0.75), new Angle(90), c_yellow, 0.8,  new Vector4(0, 0, 1, 1),
					new Vector2(15, -2), new Surface(new Vector2(1, 1))]];
	
	constructor = new SpriteRenderer(_element[2][0], _element[2][1], _element[2][2], _element[2][3],
									 _element[2][4], _element[2][5], _element[2][6], _element[2][7],
									 _element[2][8], _element[2][9]);
	
	var _result = [constructor.toString(true, true), constructor.toString(false, true)];
	var _expectedValue = [];
	
	var _i = 0;
	repeat (array_length(_element[0]))
	{
		array_push(_expectedValue,
				   ("Sprite: " + string(_element[2][0]) + _element[0][_i] +
					"Location: " + string(_element[2][1]) + _element[0][_i] +
					"Frame: " + string(_element[2][2]) + _element[0][_i] +
					"Scale: " + string(_element[2][3]) + _element[0][_i] +
					"Angle: " + string(_element[2][4]) + _element[0][_i] +
					"Color: " + _element[1][0] + _element[0][_i] +
					"Alpha: " + string(_element[2][6])) + _element[0][_i] +
					"Part: " + string(_element[2][7]) + _element[0][_i] +
					"Origin: " + string(_element[2][8]) + _element[0][_i] +
					"Target: " + string(_element[2][9]));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "(" + _expectedValue[1] + ")");
	
	unitTest.assert_equal("Method: toString(multiline?, full)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	_element[2][9].destroy();
	
#endregion
#region [Test: Events: beforeRender / afterRender]
	
	var _element = [new Sprite(asset[0]), new Vector2(125, 27), new Scale(0.7, 1), new Angle(0)];
	var _base = [_element[0], _element[1], 0, _element[2], _element[3], c_white, 1];
	var _value = [35, 26];
	
	constructor = new SpriteRenderer(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5],
									 _base[6]);
	
	var _result = [];
	
	constructor.event.beforeRender.callback = function()
	{
		array_push(argument[0], argument[1]);
	}
	
	constructor.event.beforeRender.argument = [_result, _value[0]];
	
	constructor.event.afterRender.callback = function()
	{
		array_push(argument[0], (argument[0][(array_length(argument[0]) - 1)] + argument[1]));
	}
	
	constructor.event.afterRender.argument = [_result, _value[1]];
	
	constructor.render();
	
	var _expectedValue = [_value[0], (_value[0] + _value[1])];
	
	unitTest.assert_equal("Event: beforeRender / afterRender",
						  _result, _expectedValue);
	
#endregion

