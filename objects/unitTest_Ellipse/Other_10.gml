/// @description Unit Testing
asset = [TestCollisionSprite];

#region [Test: Construction: New constructor]
	
	var _base = [new Vector4(20, 20, 100, 100), new Color2(c_yellow, c_red), 0.97, c_purple, 0.85];
	
	constructor = new Ellipse(_base[0], _base[1], _base[2], _base[3], _base[4]);
	
	var _result = [constructor.location, constructor.fill_color, constructor.fill_alpha,
				   constructor.outline_color, constructor.outline_alpha];
	var _expectedValue = [_base[0], _base[1], _base[2], _base[3], _base[4]];
	
	unitTest.assert_equal("Construction: New constructor",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4]);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _base = [new Vector4(50, 50, 150, 150), new Color2(c_green, c_orange), 0.9, c_lime, 0.8];
	
	constructor = [new Ellipse(_base[0], _base[1], _base[2], _base[3], _base[4])];
	constructor[1] = new Ellipse(constructor[0]);
	
	var _result = [constructor[1].location, constructor[1].fill_color, constructor[1].fill_alpha,
				   constructor[1].outline_color, constructor[1].outline_alpha];
	var _expectedValue = [_base[0], _base[1], _base[2], _base[3], _base[4]];
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4]);
	
#endregion
#region [Test: Construction: Empty / Method: isFunctional()]
	
	var _base = [new Vector4(200, 50, 50, 150), new Color2(c_aqua, c_white), 0.79, c_navy, 0.63];
	
	constructor = [new Ellipse(_base[0], _base[1], _base[2], _base[3], _base[4]),
				   new Ellipse(_base[0]), new Ellipse()];
	constructor[3] = new Ellipse(constructor[0]);
	constructor[3].location = undefined;
	constructor[4] = new Ellipse(constructor[0]);
	constructor[4].fill_color = undefined;
	constructor[5] = new Ellipse(constructor[0]);
	constructor[5].fill_alpha = undefined;
	constructor[6] = new Ellipse(constructor[0]);
	constructor[6].outline_color = undefined;
	constructor[7] = new Ellipse(constructor[0]);
	constructor[7].outline_alpha = undefined;
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional(),
				   constructor[2].isFunctional(), constructor[3].isFunctional(),
				   constructor[4].isFunctional(), constructor[5].isFunctional(),
				   constructor[6].isFunctional(), constructor[7].isFunctional()];
	var _expectedValue = [true, true, false, false, true, true, true, true];
	
	unitTest.assert_equal("Construction: Empty / Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6],
						  _result[7], _expectedValue[7]);
	
#endregion
#region [Test: Method: collision()]
	
	var _element = 10;
	var _base = [new Vector4((x - _element), (y - _element), (x + _element), (y + _element)),
				 new Vector4(x, y, (x + _element), (y + _element))];
	
	constructor = [new Ellipse(_base[0]), new Ellipse(_base[1])];
	
	sprite_index = asset[0];
	
	var _result = [constructor[0].collision(id), constructor[1].collision(id)];
	var _expectedValue = [id, noone];
	
	unitTest.assert_equal("Method: collision()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: render()]
	
	unitTest.assert_executable
	("Method: render()",
	 function()
	 {
		var _base = [new Vector4(40, 40, 60, 60), new Vector4(50, 50, 60, 60), c_red,
					 new Color2(c_yellow, c_orange), 1, c_fuchsia, 0.5];
		
		constructor = [new Ellipse(_base[0], _base[2], _base[4], _base[5], _base[6]),
					   new Ellipse(_base[1], _base[3], _base[4], _base[5], _base[6])];
		constructor[0].render();
		constructor[1].render();
	 }
	);
	
#endregion
#region [Test: Method: toString()]
	
	var _base = new Vector4(25, 35, 225, 335);
	
	constructor = new Ellipse(_base);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName + "(" + "Location: " + string(_base) + ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(multiline?, full)]
	
	var _element = [["Blue"], ["\n", ", "]];
	var _base = [new Vector4(75, 72, 175, 172), new Color2(c_lime, make_color_rgb(37, 23, 167)), 0.97,
				 c_blue, 0.92];
	
	constructor = new Ellipse(_base[0], _base[1], _base[2], _base[3], _base[4]);
	
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
				   "Outline Alpha: " + string(_base[4]));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "(" + _expectedValue[1] + ")");
	
	unitTest.assert_equal("Method: toString(multiline?, full)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
