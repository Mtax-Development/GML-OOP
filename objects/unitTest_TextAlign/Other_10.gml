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
#region [Test: Method: setXLeft()]
	
	var _base = [fa_center, fa_middle];
	
	constructor = new TextAlign(_base[0], _base[1]);
	constructor.setXLeft();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [fa_left, _base[1]];
	
	unitTest.assert_equal("Method: setXLeft()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: setXCenter()]
	
	var _base = [fa_right, fa_bottom];
	
	constructor = new TextAlign(_base[0], _base[1]);
	constructor.setXCenter();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [fa_center, _base[1]];
	
	unitTest.assert_equal("Method: setXCenter()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: setXRight()]
	
	var _base = [fa_left, fa_top];
	
	constructor = new TextAlign(_base[0], _base[1]);
	constructor.setXRight();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [fa_right, _base[1]];
	
	unitTest.assert_equal("Method: setXRight()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: setYTop()]
	
	var _base = [fa_center, fa_middle];
	
	constructor = new TextAlign(_base[0], _base[1]);
	constructor.setYTop();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [_base[0], fa_top];
	
	unitTest.assert_equal("Method: setYTop()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: setYMiddle()]
	
	var _base = [fa_right, fa_bottom];
	
	constructor = new TextAlign(_base[0], _base[1]);
	constructor.setYMiddle();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [_base[0], fa_middle];
	
	unitTest.assert_equal("Method: setYMiddle()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: setYBottom()]
	
	var _base = [fa_left, fa_top];
	
	constructor = new TextAlign(_base[0], _base[1]);
	constructor.setYBottom();
	
	var _result = [constructor.x, constructor.y];
	var _expectedValue = [_base[0], fa_bottom];
	
	unitTest.assert_equal("Method: setYBottom()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: mirrorX()]
	
	var _base = [[fa_right, fa_bottom], [fa_left, fa_top]];
	
	constructor = [new TextAlign(_base[0][0], _base[0][1]),
				   new TextAlign(_base[1][0], _base[1][1])];
	
	constructor[0].mirrorX();
	constructor[1].mirrorX();
	
	var _result = [constructor[0].x, constructor[0].y, constructor[1].x, constructor[1].y];
	var _expectedValue = [fa_left, _base[0][1], fa_right, _base[1][1]];
	
	unitTest.assert_equal("Method: mirrorX()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Method: mirrorY()]
	
	var _base = [[fa_left, fa_top], [fa_right, fa_bottom]];
	
	constructor = [new TextAlign(_base[0][0], _base[0][1]),
				   new TextAlign(_base[1][0], _base[1][1])];
	constructor[0].mirrorY();
	constructor[1].mirrorY();
	
	var _result = [constructor[0].x, constructor[0].y, constructor[1].x, constructor[1].y];
	var _expectedValue = [_base[0][0], fa_bottom, _base[1][1], fa_top];
	
	unitTest.assert_equal("Method: mirrorY()",
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
#region [Test: Method: toString()]
	
	var _base = [fa_left, fa_top];
	
	constructor = new TextAlign(_base[0], _base[1]);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName + 
						  "(" +
						  "x: " + "Left" + ", " +
						  "y: " + "Top" +
						  ")");
	
	unitTest.assert_equal("Method: toString()",
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
