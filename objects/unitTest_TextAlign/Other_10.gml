/// @description Unit Testing
#region [Test: Construction: Two values]
	
	var _base = [fa_right, fa_bottom];
	
	constructor = new TextAlign(_base[0], _base[1]);
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: Two values",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Construction: Default values]
	
	constructor = new TextAlign();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [fa_left, fa_top];
	
	unitTest.assert_equal("Construction: Default values",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: isFunctional()]
	
	constructor = [new TextAlign(), new TextAlign()];
	constructor[1].y = undefined;
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional()];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: setX_left()]
	
	var _base = [fa_center, fa_middle];
	
	constructor = new TextAlign(_base[0], _base[1]);
	
	constructor.setX_left();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [fa_left, _base[1]];
	
	unitTest.assert_equal("Method: setX_left()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: setX_center()]
	
	var _base = [fa_right, fa_bottom];
	
	constructor = new TextAlign(_base[0], _base[1]);
	
	constructor.setX_center();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [fa_center, _base[1]];
	
	unitTest.assert_equal("Method: setX_center()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: setX_right()]
	
	var _base = [fa_left, fa_top];
	
	constructor = new TextAlign(_base[0], _base[1]);
	
	constructor.setX_right();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [fa_right, _base[1]];
	
	unitTest.assert_equal("Method: setX_right()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: setY_top()]
	
	var _base = [fa_center, fa_middle];
	
	constructor = new TextAlign(_base[0], _base[1]);
	
	constructor.setY_top();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [_base[0], fa_top];
	
	unitTest.assert_equal("Method: setY_top()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: setY_middle()]
	
	var _base = [fa_right, fa_bottom];
	
	constructor = new TextAlign(_base[0], _base[1]);
	
	constructor.setY_middle();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [_base[0], fa_middle];
	
	unitTest.assert_equal("Method: setY_middle()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: setY_bottom()]
	
	var _base = [fa_left, fa_top];
	
	constructor = new TextAlign(_base[0], _base[1]);
	
	constructor.setY_bottom();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [_base[0], fa_bottom];
	
	unitTest.assert_equal("Method: setY_bottom()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: mirror_x()]
	
	var _base = [[fa_right, fa_bottom], [fa_left, fa_top]];
	
	constructor = [new TextAlign(_base[0][0], _base[0][1]),
				   new TextAlign(_base[1][0], _base[1][1])];
	
	constructor[0].mirror_x();
	constructor[1].mirror_x();
	
	var _result = [constructor[0].x, constructor[0].y, constructor[1].x, constructor[1].y];
	var _expectedValue = [fa_left, _base[0][1], fa_right, _base[1][1]];
	
	unitTest.assert_equal("Method: mirror_x()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: mirror_y()]
	
	var _base = [[fa_left, fa_top], [fa_right, fa_bottom]];
	
	constructor = [new TextAlign(_base[0][0], _base[0][1]),
				   new TextAlign(_base[1][0], _base[1][1])];
	
	constructor[0].mirror_y();
	constructor[1].mirror_y();
	
	var _result = [constructor[0].x, constructor[0].y, constructor[1].x, constructor[1].y];
	var _expectedValue = [_base[0][0], fa_bottom, _base[1][1], fa_top];
	
	unitTest.assert_equal("Method: mirror_y()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: mirror()]
	
	var _base = [[fa_right, fa_bottom], [fa_left, fa_top]];
	
	constructor = [new TextAlign(_base[0][0], _base[0][1]),
				   new TextAlign(_base[1][0], _base[1][1])];
	
	constructor[0].mirror();
	constructor[1].mirror();
	
	var _result = [constructor[0].x, constructor[0].y, constructor[1].x, constructor[1].y];
	var _expectedValue = [fa_left, fa_top, fa_right, fa_bottom];
	
	unitTest.assert_equal("Method: mirror()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: String conversion]
	
	var _base = [fa_left, fa_top];
	
	constructor = new TextAlign(_base[0], _base[1]);
	
	var _result = string(constructor);
	var _expectedValue = (constructorName + 
						  "(" +
						  "x: " + "Left" + ", " +
						  "y: " + "Top" +
						  ")");
	
	unitTest.assert_equal("String conversion",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(multiline)]
	
	var _base = [fa_center, fa_middle];
	
	constructor = new TextAlign(_base[0], _base[1]);
	
	var _result = constructor.toString(true);
	var _expectedValue = ("x: " + "Center" + "\n" +
						  "y: " + "Middle");
	
	unitTest.assert_equal("Method: toString(multiline)",
						  _result, _expectedValue);
	
#endregion
