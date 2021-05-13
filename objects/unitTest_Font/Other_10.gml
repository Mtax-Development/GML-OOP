/// @description Unit Testing
asset = [TestFont, "TestIncludedFont.ttf", TestFontImage];

#region [Test: Construction: Wrapper / Method: isFunctional()]
	
	var _base = asset[0];
	
	constructor = new Font(_base);
	
	var _result = constructor.isFunctional();
	var _expectedValue = true;
	
	constructor.destroy();
	
	unitTest.assert_equal("Construction: Wrapper / Method: isFunctional()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Construction: Resource / Destruction]
	
	var _base = [asset[1], 24, false, false, new Range(32, 128), true];
	
	constructor = new Font(_base[0], _base[1], _base[2], _base[3], _base[4], _base[5]);
	
	var _result = [constructor.isFunctional()];
	var _expectedValue = [true];
	
	constructor.destroy();
	
	array_push(_result, constructor.isFunctional());
	array_push(_expectedValue, false);
	
	unitTest.assert_equal("Construction: Resource / Destruction",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Construction: Sprite (utf8)]
	
	var _base = [new Sprite(asset[2]), ord("A"), true, 3, true];
	
	constructor = new Font(_base[0], _base[1], _base[2], _base[3], _base[4]);
	
	var _result = constructor.isFunctional();
	var _expectedValue = true;
	
	unitTest.assert_equal("Construction: Sprite (utf8)",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Construction: Sprite (glyph map)]
	
	var _base = [new Sprite(asset[2]), "ABC", true, 3, true];
	
	constructor = new Font(_base[0], _base[1], _base[2], _base[3], _base[4]);
	
	var _result = constructor.isFunctional();
	var _expectedValue = true;
	
	unitTest.assert_equal("Construction: Sprite (glyph map)",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _base = asset[0];
	
	constructor = [new Font(_base)];
	constructor[1] = new Font(constructor[0]);
	
	var _result = constructor[1].isFunctional();
	var _expectedValue = true;
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result, _expectedValue);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: getTexture()]
	
	var _base = asset[0];
	
	constructor = new Font(_base);
	var _element = constructor.getTexture();
	
	var _result = ((is_ptr(_element)) and (_element != pointer_invalid)
				   and (_element != pointer_invalid));
	var _expectedValue = true;
	
	unitTest.assert_equal("Method: getTexture()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getUV()]
	
	var _base = asset[0];
	
	constructor = new Font(_base);
	var _element = constructor.getUV();
	
	var _result = ((instanceof(_element) == "Vector4") and ((_element.x1 > 0) or (_element.y1 > 0)
				   or (_element.x2 > 0) or (_element.y2 > 0)));
	var _expectedValue = true;
	
	unitTest.assert_equal("Method: getUV",
						  _result, _expectedValue);
	
#endregion
#region [Test: Methods: setActive() / isActive()]
	
	var _base = asset[0];
	
	constructor = new Font(_base);
	
	var _result = [constructor.isActive()];
	var _expectedValue = [false];
	
	constructor.setActive();
	
	array_push(_result, constructor.isActive());
	array_push(_expectedValue, true);
	
	unitTest.assert_equal("Methods: setActive() / isActive()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: toString()]
	
	var _base = asset[0];
	
	constructor = new Font(_base);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName + "(" + font_get_name(constructor.ID) + ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(multiline, full)]
	
	var _base = [new Sprite(asset[2]), ord("A"), true, 3, true];
	
	constructor = new Font(_base[0], _base[1], _base[2], _base[3], _base[4]);
	
	var _result = constructor.toString(true, true);
	var _expectedValue = ("Type: " + "sprite (utf8)" + "\n" +
						  "Asset Name: " + font_get_name(constructor.ID) + "\n" +
						  "Font Name: " + font_get_fontname(constructor.ID) + "\n" +
						  "Sprite: " + string(_base[0]) + "\n" +
						  "First: " + string(_base[1]) + "\n" +
						  "Proportional: " + string(_base[2]) + "\n" +
						  "Sepearation: " + string(_base[3]) + "\n" +
						  "Antialising: " + string(_base[4]));
	
	unitTest.assert_equal("Method: toString(multiline, full)",
						  _result, _expectedValue);
	
#endregion
