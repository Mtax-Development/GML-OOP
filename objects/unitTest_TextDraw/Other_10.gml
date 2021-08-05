/// @description Unit Testing
asset = [TestFont];

#region [Test: Construction: New constructor / Method: isFunctional()]
	
	var _base = ["GML-OOP", new Font(asset[0]), new TextAlign(fa_left, fa_middle), c_green, 0.98];
	
	constructor = new TextDraw(_base[0], _base[1], _base[2], _base[3], _base[4]);
	
	var _result = constructor.isFunctional()
	var _expectedValue = true;
	
	unitTest.assert_equal("Construction: New constructor / Method: isFunctional()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Construction: Empty]
	
	constructor = new TextDraw();
	
	var _result = constructor.isFunctional();
	var _expectedValue = false;
	
	unitTest.assert_equal("Construction: Empty",
						  _result, _expectedValue);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _base = ["GML-OOP", new Font(asset[0]), new TextAlign(fa_right, fa_bottom), c_orange, 0.98];
	
	constructor = [new TextDraw(_base[0], _base[1], _base[2], _base[3], _base[4])];
	constructor[1] = new TextDraw(constructor[0]);
	
	var _result = [constructor[1].ID, constructor[1].font.ID, constructor[1].align.x,
				   constructor[1].align.y, constructor[1].color, constructor[1].alpha];
	var _expectedValue = [_base[0], _base[1].ID, _base[2].x, _base[2].y, _base[3], _base[4]];
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4]);
	
#endregion
#region [Test: Method: getBoundaryOffset()]
	
	var _base = ["GML-OOP", new Font(asset[0]), new TextAlign(fa_left, fa_top)];
	var _element = [new TextAlign(fa_center, fa_middle),
					new Vector4(0, 0, string_width(_base[0]), string_height(_base[0])),
					new Vector4((-(string_width(_base[0]) * 0.5)), (-(string_height(_base[0]) * 0.5)),
								((string_width(_base[0]) * 0.5)), ((string_height(_base[0]) * 0.5)))];
	
	constructor = new TextDraw(_base[0], _base[1], _base[2]);
	
	var _result = [constructor.getBoundaryOffset()];
	var _expectedValue = [_element[1]];
	
	constructor.align = _element[0];
	
	array_push(_result, constructor.getBoundaryOffset());
	array_push(_expectedValue, _element[2]);
	
	unitTest.assert_equal("Method: getBoundaryOffset()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: render()]
	
	unitTest.assert_executable
	("Method: render()",
	 function()
	 {
		var _base = ["GML-OOP", new Font(other.asset[0])];
		var _element = new Vector2(200, 200);
		
		constructor = new TextDraw(_base[0], _base[1]);
		constructor.render(_element);
	 }
	);
	
#endregion
#region [Test: Method: toString()]
	
	var _base = ["GML-OOP", new Font(asset[0]), new TextAlign(fa_right, fa_top), c_blue, 0.77];
	
	constructor = new TextDraw(_base[0], _base[1], _base[2], _base[3], _base[4]);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName + "(" + _base[0] + ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(lenght cut)]
	
	var _element = [30, "..."];
	var _value = [[string_repeat("I", (_element[0] + string_length(_element[1]) + 1)),
				   string_repeat("I", (_element[0] + string_length(_element[1])))],
				  [string_repeat("I", _element[0])]];
	var _base = [_value[0][0], _value[0][1], asset[0]];
	
	constructor = [new TextDraw(_base[0], _base[2]), new TextDraw(_base[1], _base[2])];
	
	var _result = [constructor[0].toString(false, false, undefined, undefined, _element[0]),
				   constructor[1].toString(false, false, undefined, undefined, _element[0])];
	var _expectedValue = [(constructorName + "(" + _value[1][0] + _element[1] + ")"),
						  (constructorName + "(" + _base[1] + ")")];
	
	unitTest.assert_equal("Method: toString(lenght cut)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: toString(multiline?, full)]
	
	var _base = ["GML-OOP", new Font(asset[0]), new TextAlign(fa_left, fa_top), c_red, 0.77];
	var _element = [["Red"], ["\n", ", "]];
	
	constructor = new TextDraw(_base[0], _base[1], _base[2], _base[3], _base[4]);
	
	var _result = [constructor.toString(true, true), constructor.toString(false, true)];
	var _expectedValue = [];
	
	var _i = 0;
	repeat (array_length(_element[1]))
	{
		array_push(_expectedValue,
				   "Text: " + string(_base[0]) + _element[1][_i] +
				   "Font: " + string(_base[1]) + _element[1][_i] +
				   "Align: " + string(_base[2]) + _element[1][_i] +
				   "Color: " + _element[0][0] + _element[1][_i] +
				   "Alpha: " + string(_base[4]));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "(" + _expectedValue[1] + ")");
	
	unitTest.assert_equal("Method: toString(multiline)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
