/// @description Unit Testing
#region [Test: Construction: New constructor / Method: isFunctional() / Destruction]
	
	var _base = new Vector2(1, 1);
	
	constructor = new Surface(_base);
	
	var _result = [constructor.isFunctional()];
	var _expectedValue = [true];
	
	constructor.destroy();
	
	array_push(_result, constructor.isFunctional());
	array_push(_expectedValue, false);
	
	unitTest.assert_equal("Construction: New constructor / Method: isFunctional() / Destruction",
						  _result, _expectedValue);
	
#endregion
#region [Test: Construction: Empty]
	
	constructor = new Surface();
	
	var _result = constructor.isFunctional();
	var _expectedValue = false;
	
	unitTest.assert_equal("Construction: Empty",
						  _result, _expectedValue);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _base = new Vector2(2, 2);
	
	constructor = [new Surface(_base)];
	constructor[1] = new Surface(constructor[0]);
	
	var _result = [constructor[1].isFunctional(), constructor[1].size,
				   surface_get_width(constructor[1].ID), surface_get_height(constructor[1].ID)];
	var _expectedValue = [true, constructor[0].size, constructor[0].size.x, constructor[0].size.y];
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Methods: create() / clear() / getPixel()]
	
	var _base = new Vector2(3, 3);
	var _element = [function(_surface) {_surface.clear(c_red);}, c_red, new Vector2(0, 0)];
	
	constructor = new Surface(_base);
	constructor.onCreate = _element[0];
	constructor.destroy();
	
	var _result = [constructor.isFunctional()];
	var _expectedValue = [false];
	
	constructor.create();
	
	array_push(_result, constructor.isFunctional(), constructor.getPixel(_element[2]));
	array_push(_expectedValue, true, _element[1]);
	
	unitTest.assert_equal("Method: create()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: copy()]
	
	var _base = new Vector2(4, 4);
	var _element = [c_green, c_black, new Vector2(0, 0),  new Vector2(1, 1), new Vector4(1, 1, 2, 2)];
	
	constructor = [new Surface(_base), new Surface(_base)];
	
	constructor[0].clear(_element[0]);
	constructor[1].clear(_element[1]);
	constructor[1].copy(_element[3], constructor[0], _element[4]);
	
	var _result = [constructor[1].getPixel(_element[2]), constructor[1].getPixel(_element[3])];
	var _expectedValue = [_element[1], _element[0]];
	
	unitTest.assert_equal("Method: copy()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Methods: setTarget() / isTarget()]
	
	var _base = new Vector2(5, 5);
	var _element = [true, false];
	
	constructor = new Surface(_base);
	
	constructor.setTarget(_element[0]);
	
	var _result = [constructor.isTarget()];
	var _expectedValue = [_element[0]];
	
	constructor.setTarget(_element[1]);
	
	array_push(_result, constructor.isTarget());
	array_push(_expectedValue, _element[1]);
	
	unitTest.assert_equal("Methods: setTarget() / isTarget()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: getTexture()]
	
	var _base = new Vector2(6, 6);
	
	constructor = new Surface(_base);
	var _element = constructor.getTexture();
	
	var _result = [is_ptr(_element), (_element != pointer_null), (_element != pointer_invalid),
				   _element];
	var _expectedValue = [true, true, true, surface_get_texture(constructor.ID)];
	
	unitTest.assert_equal("Method: getTexture()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setSize()]
	
	var _base = new Vector2(7, 7);
	var _element = new Vector2(70, 70);
	
	constructor = new Surface(_base);
	constructor.setSize(_element);
	
	var _result = [constructor.size, surface_get_width(constructor.ID),
				   surface_get_height(constructor.ID)];
	var _expectedValue = [_element, _element.x, _element.y];
	
	unitTest.assert_equal("Method: setSize()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: render()]
	
	var _base = new Vector2(9, 9);
	var _element = [c_gray, new Vector2(0, 0)];
	
	constructor = [new Surface(_base), new Surface(_base), new Surface(_base), new Surface(_base)];
	constructor[3].clear(_element[0]);
	constructor[0].setTarget(true);
	constructor[1].setTarget(true);
	constructor[3].render(undefined, undefined, undefined, undefined, undefined, undefined,
						  constructor[2]);
	
	var _result = [constructor[2].getPixel(_element[1]), constructor[3].isTarget(),
				   constructor[2].isTarget(), constructor[1].isTarget()];
	var _expectedValue = [_element[0], false, false, true];
	
	constructor[1].setTarget(false);
	constructor[0].setTarget(false);
	
	unitTest.assert_equal("Method: render()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	constructor[2].destroy();
	constructor[3].destroy();
	
#endregion
#region [Test: Method: renderSize()]
	
	var _base = new Vector2(10, 10);
	var _element = [c_red, c_white, new Vector2(5, 5), new Vector2(4, 4)];
	
	constructor = [new Surface(_base), new Surface(_base)];
	constructor[0].clear(_element[0]);
	constructor[1].setTarget(true);
	constructor[1].clear(_element[1]);
	constructor[0].renderSize(_element[2]);
	constructor[1].setTarget(false);
	
	var _result = [constructor[1].getPixel(_element[3]), constructor[1].getPixel(_element[2])]
	var _expectedValue = [_element[0], _element[1]];
	
	unitTest.assert_equal("Method: renderSize()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: renderTiled()]
	
	var _base = [new Vector2(11, 11), new Vector2(110, 110)];
	var _element = [c_purple, c_white, new Vector2((_base[1].x - 1), (_base[1].y - 1))];
	
	constructor = [new Surface(_base[0]), new Surface(_base[1])];
	constructor[0].clear(_element[0]);
	constructor[1].setTarget(true);
	constructor[1].clear(_element[1]);
	constructor[0].renderTiled();
	constructor[1].setTarget(false);
	
	var _result = constructor[1].getPixel(_element[2]);
	var _expectedValue = _element[0];
	
	unitTest.assert_equal("Method: renderTiled()",
						  _result, _expectedValue);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: toString(multiline?)]
	
	var _base = new Vector2(12, 12);
	var _element = ["\n", ", "];
	
	constructor = new Surface(_base);
	
	var _result = [constructor.toString(true), constructor.toString()];
	var _expectedValue = [];
	
	var _i = 0;
	repeat (array_length(_element))
	{
		array_push(_expectedValue,
				   "ID: " + string(constructor.ID) + _element[_i] +
				   "Size: " + string(constructor.size));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "(" + _expectedValue[1] + ")");
	
	unitTest.assert_equal("Method: toString(multiline?)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: toFile()]
	
	var _base = new Vector2(13, 13);
	var _element = ["SurfaceUnitTest_toFile.png", c_orange, c_white, new Vector2(0, 0)];
	
	if (file_exists(_element[0]))
	{
		file_delete(_element[0]);
	}
	
	constructor = [new Surface(_base), new Surface(_base)];
	
	constructor[0].clear(_element[1]);
	constructor[0].toFile(_element[0]);
	_element[4] = new Sprite();
	_element[4].fromFile(_element[0]);
	constructor[1].setTarget(true);
	constructor[1].clear(_element[2]);
	_element[4].render(_element[3]);
	constructor[1].setTarget(false);
	
	var _result = constructor[1].getPixel(_element[3]);
	var _expectedValue = _element[1];
	
	unitTest.assert_equal("Method: toFile()",
						  _result, _expectedValue);
	
	if (file_exists(_element[0]))
	{
		file_delete(_element[0]);
	}
	
	_element[4].destroy();
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: fromBuffer()

	var _base = new Vector2(14, 14);
	var _element = [c_blue, new Buffer(1, buffer_grow, 1), new Vector2(0, 0)];
	
	constructor = [new Surface(_base), new Surface(_base)];
	constructor[0].clear(_element[0]);
	_element[1].fromSurface(constructor[0]);
	constructor[1].fromBuffer(_element[1]);
	
	var _result = constructor[0].getPixel(_element[2]);
	var _expectedValue = _element[0];
	
	unitTest.assert_equal("Method: fromBuffer()",
						  _result, _expectedValue);
	
	_element[1].destroy();
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion