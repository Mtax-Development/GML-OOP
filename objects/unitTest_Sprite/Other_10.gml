/// @description Unit Testing
asset = [TestSprite];

#region [Test: Construction: New constructor / Method: isFunctional() / Destruction]
	
	var _element = [[new Surface(new Vector2(2, 2))]];
	_element[1][0] = sprite_create_from_surface(_element[0][0].ID, 0, 0, 1, 1, false, false, 0, 0);
	
	constructor = new Sprite(_element[1][0]);
	
	var _result = [constructor.ID, constructor.isFunctional()];
	var _expectedValue = [_element[1][0], true];
	
	constructor.destroy();
	
	array_push(_result, constructor.isFunctional());
	array_push(_expectedValue, false);
	
	unitTest.assert_equal("Construction: New constructor / Method: isFunctional() / Destruction",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	_element[0][0].destroy();
	
#endregion
#region [Test: Construction: From Surface]
	
	var _element = new Vector2(1, 1);
	var _base = [new Surface(_element), new Vector4(0, 0, _element.x, _element.y)];
	
	constructor = new Sprite(_base[0], _base[1]);
	
	var _result = constructor.isFunctional();
	var _expectedValue = true;
	
	unitTest.assert_equal("Construction: From Surface",
						  _result, _expectedValue);
	
	_base[0].destroy();
	constructor.destroy();
	
#endregion
#region [Test: Construction: File / Method: toFile()]
	
	var _element = [asset[0], "SpriteUnitTest_toFile.png", sprite_get_number(asset[0]),
					new Vector2(1, 1)];
	var _base = [new Surface(_element[3]), new Vector4(0, 0, _element[3].x, _element[3].y)];
	
	if (file_exists(_element[1]))
	{
		file_delete(_element[1]);
	}
	
	constructor = [new Sprite(_base[0], _base[1])];
	constructor[0].toFile(_element[1]);
	constructor[1] = new Sprite(_element[1], _element[2]);
	
	var _result = constructor[1].frameCount;
	var _expectedValue = _element[2];
	
	unitTest.assert_equal("Construction: File / Method: toFile()",
						  _result, _expectedValue);
	
	if (file_exists(_element[1]))
	{
		file_delete(_element[1]);
	}
	
	_base[0].destroy();
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Construction: Empty]
	
	constructor = new Sprite();
	
	var _result = constructor.isFunctional();
	var _expectedValue = false;
	
	unitTest.assert_equal("Construction: Empty",
						  _result, _expectedValue);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _element = [[new Surface(new Vector2(2, 2))], [function(_) {return _;}, "argument"]];
	_element[2][0] = sprite_create_from_surface(_element[0][0].ID, 0, 0, 1, 1, false, false, 0, 0);
	
	constructor = [new Sprite(_element[2][0])];
	constructor[0].event.beforeRender.callback = _element[1][0];
	constructor[0].event.beforeRender.argument = _element[1][1];
	constructor[0].event.afterRender.callback = _element[1][0];
	constructor[0].event.afterRender.argument = _element[1][1];
	constructor[1] = new Sprite(constructor[0]);
	
	var _result = [(constructor[1].ID != _element), constructor[1].isFunctional(),
				   constructor[1].event.beforeRender.callback,
				   constructor[1].event.beforeRender.argument,
				   constructor[1].event.afterRender.callback,
				   constructor[1].event.afterRender.argument];
	var _expectedValue = [true, true, _element[1][0], _element[1][1], _element[1][0], _element[1][1]];
	
	constructor[1].destroy();
	
	array_push(_result, constructor[0].isFunctional());
	array_push(_expectedValue, true);
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6]);
	
	_element[0][0].destroy();
	constructor[0].destroy();
	
#endregion
#region [Test: Method: replace()]
	
	var _element = [[new Surface(new Vector2(2, 2))]];
	_element[1] = [sprite_create_from_surface(_element[0][0].ID, 0, 0, 10, 10, false, false, 0, 0),
				   sprite_create_from_surface(_element[0][0].ID, 0, 0, 1, 1, false, false, 0, 0),];
	_element[2] = [new Vector2(sprite_get_width(asset[0]), sprite_get_height(asset[0]))];
	
	constructor = [new Sprite(_element[1][0]), new Sprite(_element[1][1])];
	constructor[1].replace(constructor[0]);
	
	var _result = constructor[1].size;
	var _expectedValue = constructor[0].size;
	
	unitTest.assert_equal("Method: replace()",
						  _result, _expectedValue);
	
	_element[0][0].destroy();
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: merge()]
	
	var _element = [[new Surface(new Vector2(2, 2))]];
	_element[1] = [sprite_create_from_surface(_element[0][0].ID, 0, 0, 1, 1, false, false, 0, 0),
				   asset[0]];
	_element[2] = [sprite_get_number(_element[1][0]), sprite_get_number(_element[1][1])];

	constructor = [new Sprite(_element[1][0]), new Sprite(_element[1][1])];
	constructor[1].merge(constructor[0]);
	
	var _result = constructor[1].frameCount;
	var _expectedValue = (_element[2][0] + _element[2][1]);
	
	unitTest.assert_equal("Method: merge()",
						  _result, _expectedValue);
	
	_element[0][0].destroy();
	constructor[0].destroy();
	
#endregion
#region [Test: Method: getNineslice()]
	
	var _element = [[asset[0]]];
	
	constructor = new Sprite(_element[0][0]);
	_element[1][0] = constructor.getNineslice();
	
	var _result = ((_element[1][0].enabled == true) or (_element[1][0].enabled == false));
	var _expectedValue = true;
	
	unitTest.assert_equal("Method: getNineslice()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getTexture()]
	
	var _element = [[asset[0]]];
	
	constructor = new Sprite(_element[0][0]);
	
	_element[1][0] = constructor.getTexture();
	
	var _result = [(is_ptr(_element[1][0])), (_element[1][0] != pointer_null),
				   (_element[1][0] != pointer_invalid)];
	var _expectedValue = [true, true, true];
	
	unitTest.assert_equal("Method: getTexture()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: getTexel()]
	
	var _base = asset[0];
	var _element = [0];
	_element[1] = sprite_get_texture(_base, _element[0]);
	_element[2] = new Vector2(texture_get_texel_width(_element[1]),
							  texture_get_texel_height(_element[1]));
	
	constructor = new Sprite(_base);
	
	var _result = constructor.getTexel(_element[0]);
	var _expectedValue = _element[2];
	
	unitTest.assert_equal("Method: getTexel()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: getUV()]
	
	var _element = [[asset[0]], ["Vector4"]];
	
	constructor = new Sprite(_element[0][0]);
	
	_element[2][0] = constructor.getUV(0, false);
	_element[2][1] = constructor.getUV(0, true);
	
	var _result = [(instanceof(_element[2][0]) == _element[1][0]), is_array(_element[2][1])];
	var _expectedValue = [true, true];
	
	unitTest.assert_equal("Method: getUV()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: setNineslice()]
	
	var _element = [[new Surface(new Vector2(2, 2))]];
	_element[1] = [sprite_create_from_surface(_element[0][0].ID, 0, 0, 1, 1, false, false, 0, 0)];
	_element[2] = [sprite_nineslice_create()];
	_element[3] = [2, 3, 4, 5];
	_element[2][0].left = _element[3][0];
	_element[2][0].right = _element[3][1];
	_element[2][0].top = _element[3][2];
	_element[2][0].bottom = _element[3][3];
	
	constructor = new Sprite(_element[1][0]);
	constructor.setNineslice(_element[2][0]);
	
	_element[2][1] = constructor.getNineslice();
	
	var _result = [_element[2][1].left, _element[2][1].right, _element[2][1].top,
				   _element[2][1].bottom];
	var _expectedValue = [_element[3][0], _element[3][1], _element[3][2], _element[3][3]];
	
	unitTest.assert_equal("Method: setNineslice()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
	_element[0][0].destroy();
	constructor.destroy();
	
#endregion
#region [Test: Method: setOrigin()]
	
	var _base = asset[0];
	var _element = [new Vector2(sprite_get_xoffset(_base), sprite_get_yoffset(_base)),
					new Vector2((sprite_get_xoffset(_base) + 1), (sprite_get_yoffset(_base) + 2))];
	
	constructor = new Sprite(_base);
	constructor.setOrigin(_element[1]);
	
	var _result = [constructor.origin.x, constructor.origin.y, sprite_get_xoffset(_base),
				   sprite_get_yoffset(_base)];
	var _expectedValue = [_element[1].x, _element[1].y, _element[1].x, _element[1].y];
	
	unitTest.assert_equal("Method: setOrigin()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
	constructor.setOrigin(_element[0]);
	
#endregion
#region [Test: Method: setSpeed()]
	
	var _element = [[new Surface(new Vector2(2, 2))]];
	_element[1] = [sprite_create_from_surface(_element[0][0].ID, 0, 0, 1, 1, false, false, 0, 0)];
	_element[2] = [14, spritespeed_framespersecond];
	
	constructor = new Sprite(_element[1][0]);
	constructor.setSpeed(_element[2][0], _element[2][1]);
	
	var _result = [constructor.speed, constructor.speed_type,
				   (constructor.speed == sprite_get_speed(_element[1][0])),
				   (constructor.speed_type == sprite_get_speed_type(_element[1][0]))];
	var _expectedValue = [_element[2][0], _element[2][1], true, true];
	
	unitTest.assert_equal("Method: setSpeed()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
	_element[0][0].destroy();
	constructor.destroy();
	
#endregion
#region [Test: Method: setCollisionMask()]
	
	var _element = [[new Surface(new Vector2(40, 40))]];
	_element[1] = [sprite_create_from_surface(_element[0][0].ID, 0, 0, 30, 30, false, false, 0, 0)];
	_element[2] = [bboxmode_manual, bboxkind_diamond, new Vector4(2, 2, 20, 20), 0, false];
	
	constructor = new Sprite(_element[1][0]);
	constructor.setCollisionMask(_element[2][0], _element[2][1], _element[2][2], _element[2][3],
								 _element[2][4]);
	
	var _result = [sprite_get_bbox_mode(constructor.ID), sprite_get_bbox_left(constructor.ID),
				   sprite_get_bbox_top(constructor.ID), sprite_get_bbox_right(constructor.ID),
				   sprite_get_bbox_bottom(constructor.ID)];
	var _expectedValue = [_element[2][0], _element[2][2].x1, _element[2][2].y1, _element[2][2].x2,
						  _element[2][2].y2];
	
	unitTest.assert_equal("Method: setCollisionMask()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4]);
	
#endregion
#region [Test: Method: render()]
	
	unitTest.assert_executable
	("Method: render()",
	 function()
	 {
		var _element = [other.asset[0], new Vector2(2, 2), 0, new Scale(0.9, 0.95), new Angle(45),
						new Color4(c_red, c_green, c_blue, c_black), c_yellow, 0.9,
						new Vector4(0, 0, (sprite_get_width(other.asset[0]) - 1),
									(sprite_get_height(other.asset[0]) - 1)), new Vector2(1, 1),
						new Surface(new Vector2(sprite_get_width(other.asset[0]),
												sprite_get_height(other.asset[0])))];
	
		constructor = new Sprite(_element[0]);
		constructor.render(_element[1]);
		constructor.render(_element[1], undefined, undefined, undefined, _element[6]);
		constructor.render(_element[1], _element[2], _element[3], _element[4], _element[5],
						   _element[7], _element[8], _element[9], _element[10]);
		
		_element[10].destroy();
	 }
	);
	
#endregion
#region [Test: Method: renderTiled()]
	
	unitTest.assert_executable
	("Method: renderTiled()",
	 function()
	 {
		var _element = [other.asset[0], new Vector2(350, 350), 0, new Scale(0.5, 0.75), c_dkgray,
						0.5];
	
		constructor = new Sprite(_element[0]);
		constructor.renderTiled(_element[1]);
		constructor.renderTiled(_element[1], _element[2], _element[3], _element[4], _element[5]);
	 }
	);
	
#endregion
#region [Test: Method: renderPerspective()]
	
	unitTest.assert_executable
	("Method: renderPerspective()",
	 function()
	 {
		var _element = [other.asset[0], new Vector2(10, 10), new Vector2(20, 10), new Vector2(20, 25),
						new Vector2(15, 18), 0, 0.9];
	
		constructor = new Sprite(_element[0]);
		constructor.renderPerspective(_element[1], _element[2], _element[3], _element[4]);
		constructor.renderPerspective(_element[1], _element[2], _element[3], _element[4], _element[5],
									  _element[6]);
	 }
	);
	
#endregion
#region [Test: Method: load()]
	
	var _element = asset[0];
	
	constructor = new Sprite(_element);
	
	var _result = [constructor.load(false), constructor.load(true), constructor.load(false)];
	var _expectedValue = [0, 0, 0];
	
	unitTest.assert_equal("Method: load()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: generateAlphaMap()]
	
	var _element = [[new Surface(new Vector2(2, 2))]];
	_element[1] = [sprite_create_from_surface(_element[0][0].ID, 0, 0, 1, 1, false, false, 0, 0),
				   sprite_create_from_surface(_element[0][0].ID, 0, 0, 1, 1, false, false, 0, 0)];
	
	constructor = [new Sprite(_element[1][0]), new Sprite(_element[1][1])];
	
	_element[2] = [constructor[0].generateAlphaMap(constructor[1])];
	
	var _result = _element[2][0].isFunctional();
	var _expectedValue = true;
	
	unitTest.assert_equal("Method: generateAlphaMap()",
						  _result, _expectedValue);
	
	_element[2][0].destroy();
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: toString()]
	
	var _element = asset[0];
	
	constructor = new Sprite(_element);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName + "(" + sprite_get_name(_element) + ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(multiline?, full)]
	
	var _element = [["\n", ", "], [new Surface(new Vector2(10, 10))],
					[new Vector2(5, 5), new Vector2(0, 0)]];
	_element[3] = [sprite_create_from_surface(_element[1][0].ID, 0, 0, _element[2][0].x,
											  _element[2][0].y, false, false, 0, 0)];
	_element[4] = [4, spritespeed_framespergameframe, " Frames Per Application Frame"];
	
	constructor = new Sprite(_element[3][0]);
	constructor.setSpeed(_element[4][0], _element[4][1]);
	
	var _result = [constructor.toString(true, true), constructor.toString(false, true)];
	var _expectedValue = [];
	
	var _i = 0;
	repeat (array_length(_element[0]))
	{
		array_push(_expectedValue,
				   ("Name: " + sprite_get_name(constructor.ID) + _element[0][_i] +
				    "Size: " + string(_element[2][0]) + _element[0][_i] +
					"Frame Count: " + string(1) + _element[0][_i] +
					"Origin: " + string(_element[2][1]) + _element[0][_i] +
					"Speed: " + string(_element[4][0]) + _element[4][2]));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "(" + _expectedValue[1] + ")");
	
	unitTest.assert_equal("Method: toString(multiline?, full)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	_element[1][0].destroy();
	constructor.destroy();
	
#endregion
#region [Test: Events: beforeRender / afterRender]
	
	var _element = [asset[0], new Vector2(0)];
	var _value = [133, 575];
	
	constructor = new Sprite(_element[0]);
	
	var _result = [];
	
	constructor.event.beforeRender.callback = function()
	{
		array_push(argument[0], argument[1]);
	}
	
	constructor.event.beforeRender.argument = [[_result, _value[0]]];
	
	constructor.event.afterRender.callback = function()
	{
		array_push(argument[0], (argument[0][(array_length(argument[0]) - 1)] + argument[1]));
	}
	
	constructor.event.afterRender.argument = [[_result, _value[1]]];
	
	constructor.render(_element[1]);
	
	var _expectedValue = [_value[0], (_value[0] + _value[1])];
	
	unitTest.assert_equal("Event: beforeRender / afterRender",
						  _result, _expectedValue);
	
#endregion
