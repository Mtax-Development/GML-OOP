/// @description Unit Testing
asset = [TestSprite];

#region [Test: Construction: New constructor / Method: isFunctional()]
	
	var _element = [new Sprite(asset[0]), new Vector2(50, 50), new Scale(0.5, 0.2), new Angle(0)];
	var _base = [_element[0], _element[1], 0, _element[2], _element[3], c_red, 0.75];
	
	constructor = new SpriteDraw(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5],
								 _base[6]);
	
	var _result = [constructor.isFunctional()];
	var _expectedValue = [true];
	
	constructor.sprite = undefined;
	
	array_push(_result, constructor.isFunctional());
	array_push(_expectedValue, false);
	
	unitTest.assert_equal("Construction: New constructor / Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Construction: Empty]
	
	constructor = new SpriteDraw();
	
	var _result = constructor.isFunctional();
	var _expectedValue = false;
	
	unitTest.assert_equal("Construction: Empty",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: render()]
	
	unitTest.assert_executable
	("Method: render()",
	 function()
	 {
		var _element = [new Sprite(other.asset[0]), new Vector2(155, 27), new Scale(1, 1),
						new Angle(35)];
		var _base = [_element[0], _element[1], 0, _element[2], _element[3], c_white, 1];
		
		constructor = new SpriteDraw(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5],
									 _base[6]);
		
		constructor.render();
	 }
	);
	
#endregion
#region [Test: Method: toString()]
	
	var _element = [new Sprite(asset[0]), new Vector2(555, 555)];
	
	constructor = new SpriteDraw(_element[0], _element[1]);
	
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
					new Scale(0.5, 0.75), new Angle(90), c_yellow, 0.8]];
	
	constructor = new SpriteDraw(_element[2][0], _element[2][1], _element[2][2], _element[2][3],
								 _element[2][4], _element[2][5], _element[2][6]);
	
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
					"Alpha: " + string(_element[2][6])));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "(" + _expectedValue[1] + ")");
	
	unitTest.assert_equal("Method: toString(multiline?, full)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
