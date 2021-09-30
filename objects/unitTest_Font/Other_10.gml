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
#region [Test: Construction: Sprite (UTF-8)]
	
	var _base = [new Sprite(asset[2]), ord("A"), true, 3, true];
	
	constructor = new Font(_base[0], _base[1], _base[2], _base[3], _base[4]);
	
	var _result = constructor.isFunctional();
	var _expectedValue = true;
	
	unitTest.assert_equal("Construction: Sprite (UTF-8)",
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
	
	var _element = ["\n", ", "];
	var _base = [new Sprite(asset[2]), ord("A"), true, 3, true];
	
	constructor = new Font(_base[0], _base[1], _base[2], _base[3], _base[4]);
	
	var _result = [constructor.toString(true, true), constructor.toString(false, true)];
	var _expectedValue = [];
	
	var _i = 0;
	repeat (array_length(_element))
	{
		array_push(_expectedValue,
				   ("Type: " + "sprite (UTF-8)" + _element[_i] +
				    "Asset Name: " + font_get_name(constructor.ID) + _element[_i] +
				    "Font Name: " + font_get_fontname(constructor.ID) + _element[_i] +
				    "Sprite: " + string(_base[0]) + _element[_i] +
				    "First: " + string(_base[1]) + _element[_i] +
				    "Proportional: " + string(_base[2]) + _element[_i] +
				    "Separation: " + string(_base[3]) + _element[_i] +
				    "Antialising: " + string(_base[4])));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "(" + _expectedValue[1] + ")");
	
	unitTest.assert_equal("Method: toString(multiline?, full)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Events: beforeActivation / afterActivation]
	
	var _base = asset[0];
	var _value = [2.6, 999];
	
	constructor = new Font(_base);
	
	var _result = [];
	
	constructor.event.beforeActivation.callback = function(_argument)
	{
		array_push(_argument[0], _argument[1]);
	}
	
	constructor.event.beforeActivation.argument = [_result, _value[0]];
	
	constructor.event.afterActivation.callback = function(_argument)
	{
		array_push(_argument[0], (_argument[0][(array_length(_argument[0]) - 1)] + _argument[1]));
	}
	
	constructor.event.afterActivation.argument = [_result, _value[1]];
	
	constructor.setActive();
	
	var _expectedValue = [_value[0], (_value[0] + _value[1])];
	
	unitTest.assert_equal("Event: beforeActivation / afterActivation",
						  _result, _expectedValue);
	
#endregion
