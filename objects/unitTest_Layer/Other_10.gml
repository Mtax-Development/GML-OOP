/// @description Unit Testing
asset = [TestBackgroundSprite, TestObject, TestTileset1, TestTileset2, TestSprite];

#region [Test: Construction: New constructor / Destruction / Method: isFunctional()]
	
	var _base = [1, "New Layer"];
	
	constructor = new Layer(_base[0], _base[1]);
	
	var _result = [constructor.isFunctional(), constructor.name];
	var _expectedValue = [true, _base[1]];
	
	constructor.destroy();
	
	array_push(_result, constructor.isFunctional());
	array_push(_expectedValue, false);
	
	unitTest.assert_equal("Construction: New constructor / Destruction / Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Construction: Wrapper]
	
	var _base = [2, "Wrapped Layer"];
	var _element = layer_create(_base[0], _base[1]);
	
	constructor = new Layer(_base[1]);
	
	var _result = [constructor.isFunctional(), constructor.depth, constructor.name];
	var _expectedValue = [true, _base[0], _base[1]];
	
	unitTest.assert_equal("Construction: Wrapper",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: Construction: Empty]
	
	constructor = new Layer();
	
	var _result = constructor.ID;
	var _expectedValue = undefined;
	
	unitTest.assert_equal("Construction: Empty",
						  _result, _expectedValue);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _base = [3, "LayerToCopy", "CopiedLayer"];
	
	constructor = [new Layer(_base[0], _base[1])];
	constructor[1] = new Layer(constructor[0], _base[2]);
	
	var _result = [constructor[1].isFunctional(), constructor[1].name];
	var _expectedValue = [true, _base[2]];
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: createBackground()]
	
	var _element = [new Sprite(asset[0])];
	var _base = 4;
	
	constructor = new Layer(_base);
	_element[1] = constructor.createBackground(_element[0]);
	
	var _result = [_element[1].isFunctional(), constructor.backgroundList.getValue(0)];
	var _expectedValue = [true, _element[1]];
	
	unitTest.assert_equal("Method: createBackground()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: createInstance()]
	
	var _element = [asset[1], new Vector2(0, 0)];
	var _base = 5;
	
	constructor = new Layer(_base);
	_element[2] = constructor.createInstance(_element[0], _element[1]);
	
	var _result = [instance_exists(_element[2]), constructor.instanceList.getValue(0)];
	var _expectedValue = [true, _element[2]];
	
	unitTest.assert_equal("Method: createInstance()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: createTilemap()]
	
	var _element = [asset[2], new Vector2(0, 0), new Vector2(16, 16)];
	var _base = 6;
	
	constructor = new Layer(_base);
	_element[3] = constructor.createTilemap(_element[0], _element[1], _element[2]);
	
	var _result = [_element[3].isFunctional(), constructor.tilemapList.getValue(0)];
	var _expectedValue = [true, _element[3]];
	
	unitTest.assert_equal("Method: createTilemap()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: createSprite()]

	var _element = [new Sprite(asset[4]), new Vector2(0, 0)];
	var _base = 7;
	
	constructor = new Layer(_base);
	_element[2] = constructor.createSprite(_element[0], _element[1]);
	
	var _result = [_element[2].isFunctional(), constructor.spriteList.getValue(0)];
	var _expectedValue = [true, _element[2]];
	
	unitTest.assert_equal("Method: createSprite()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: createParticleSystem()]
	
	var _base = 7;
	
	constructor = new Layer(_base);
	var _element = constructor.createParticleSystem();
	
	var _result = [_element.isFunctional(), constructor.particleSystemList.getValue(0)];
	var _expectedValue = [true, _element];
	
	unitTest.assert_equal("Method: createParticleSystem()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: hasInstance()]
	
	//|The built-in layer_has_instance() function is currently broken.
	// It returns -1 instead of false if the instance does not exist.
	var _element = [[asset[1], new Vector2(0, 0)]];
	var _base = 8;
	
	constructor = new Layer(_base);
	_element[1][0] = constructor.createInstance(_element[0][0], _element[0][1]);
	_element[1][1] = instance_create_depth(_element[0][1].x, _element[0][1].y, _base,
										   _element[0][0]);
	
	var _result = [constructor.hasInstance(_element[1][0]), constructor.hasInstance(_element[1][1])];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: hasInstance(BROKEN IN ENGINE)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: getElements()]
	
	var _element = [[new Vector2(1, 1), new Vector2(16, 16), new Vector2(25, 25)]];
	_element[1] = [[new Sprite(asset[0])], [asset[2], _element[0][0], _element[0][1]],
				   [new Sprite(asset[4])]];
	var _base = 9;
	
	constructor = new Layer(_base);
	_element[2] = [constructor.createBackground(_element[1][0][0]),
				   constructor.createTilemap(_element[1][1][0], _element[1][1][1],
											 _element[1][1][2]),
				   constructor.createSprite(_element[1][2][0], _element[0][1])];
	
	_element[3] = [new ArrayParser(constructor.getElements())];
	
	var _result = [_element[3][0].contains(_element[2][0].ID),
				   _element[3][0].contains(_element[2][1].ID),
				   _element[3][0].contains(_element[2][2].ID)];
	var _expectedValue = [true, true, true];
	
	unitTest.assert_equal("Method: getElements()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setLocation()]
	
	var _element = new Vector2(15, 15);
	var _base = 10;
	
	constructor = new Layer(_base);
	constructor.setLocation(_element);
	
	var _result = constructor.location;
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: setLocation()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setSpeed()]
	
	var _element = new Vector2(1, 0.725);
	var _base = 11;
	
	constructor = new Layer(_base);
	constructor.setSpeed(_element);
	
	var _result = constructor.speed;
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: setSpeed()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setVisible()]
	
	var _element = false;
	var _base = 12;
	
	constructor = new Layer(_base);
	constructor.setVisible(_element);
	
	var _result = constructor.visible;
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: setVisible()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setDepth()]
	
	var _element = 11;
	var _base = 13;
	
	constructor = new Layer(_base);
	constructor.setDepth(_element);
	
	var _result = constructor.depth;
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: setDepth()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setShader()]
	
	var _element = new Shader(TestShader);
	var _base = 16;
	
	constructor = new Layer(_base);
	constructor.setShader(_element);
	
	var _result = constructor.shader;
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: setShader()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setFunctionDrawBegin()]
	
	var _element = (function() {var _function_drawBegin = false; _function_drawBegin = true;});
	var _base = 14;
	
	constructor = new Layer(_base);
	constructor.setFunctionDrawBegin(_element);
	
	var _result = constructor.function_drawBegin;
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: setFunctionDrawBegin()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setFunctionDrawEnd()]
	
	var _element = (function() {var _function_drawEnd = false; _function_drawEnd = true;});
	var _base = 15;
	
	constructor = new Layer(_base);
	constructor.setFunctionDrawEnd(_element);
	
	var _result = constructor.function_drawEnd;
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: setFunctionDrawEnd()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: destroyInstance()]
	
	var _element = [[asset[1], new Vector2(0, 0), 5], []];
	var _base = 17;
	
	constructor = new Layer(_base);
	
	repeat (_element[0][2])
	{
		array_push(_element[1], constructor.createInstance(_element[0][0], _element[0][1]));
	}
	
	var _result = [array_length(constructor.getElements()), constructor.instanceList.getSize()];
	var _expectedValue = [_element[0][2], _element[0][2]];
	
	constructor.destroyInstance(_element[1][(array_length(_element[1]) - 1)]);
	
	array_push(_result, constructor.instanceList.getSize());
	array_push(_expectedValue, (_element[0][2] - 1));
	
	constructor.destroyInstance(all);
	
	array_push(_result, array_length(constructor.getElements()), constructor.instanceList.getSize());
	array_push(_expectedValue, 0, 0);
	
	unitTest.assert_equal("Method: destroyInstance()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setInstancePause()]
	
	var _element = [true, false];
	var _base = 18;
	
	constructor = new Layer(_base);
	constructor.setInstancePause(_element[0]);
	
	var _result = [constructor.instancesPaused];
	var _expectedValue = [_element[0]];
	
	constructor.setInstancePause(_element[1]);
	
	array_push(_result, constructor.instancesPaused);
	array_push(_expectedValue, _element[1]);
	
	unitTest.assert_equal("Method: setInstancePause()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: toString()]
	
	var _base = [19, "Layer: toString()"];
	
	constructor = new Layer(_base[0], _base[1]);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName +
						  "(" +
						  "Name: " + _base[1] + ", " +
						  "Depth: " + string(_base[0]) +
						  ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: toString(multiline?, full)]
	
	var _element = ["\n", ", "];
	var _base = [20, "Layer: toString(multiline?, full)"];
	
	constructor = new Layer(_base[0], _base[1]);
	
	var _result = [constructor.toString(true, true), constructor.toString(false, true)];
	var _expectedValue = [];
	
	var _i = 0;
	repeat (array_length(_element))
	{
		array_push(_expectedValue,
				   ("Name: " + _base[1] + _element[_i] +
					"Depth: " + string(_base[0]) + _element[_i] +
					"Location: " + string(new Vector2(0, 0)) + _element[_i] +
					"Speed: " + string(new Vector2(0, 0)) + _element[_i] +
					"Visible: " + string(true) + _element[_i] +
					"Instances Paused: " + string(false) + _element[_i] +
					"Function (Draw Begin): " + string(undefined) + _element[_i] +
					"Function (Draw End): " + string(undefined)+ _element[_i] +
					"Shader: " + string(undefined) + _element[_i] +
					"Instance List: " + string(constructor.instanceList) + _element[_i] +
					"Sprite List: " + string(constructor.spriteList) + _element[_i] +
					"Background List: " + string(constructor.backgroundList) + _element[_i] +
					"Tilemap List: " + string(constructor.tilemapList)) + _element[_i] +
					"Particle System List: " + string(constructor.particleSystemList));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "(" + _expectedValue[1] + ")");
	
	unitTest.assert_equal("Method: toString(multiline?, full)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: SpriteElement - Construction: New constructor / Destruction / Method: isFuncitonal()]
	
	var _base = 21;
	
	constructor = new Layer(_base);
	
	with (constructor)
	{
		var _element = [new Vector2(0, 0), other.asset[4]];
		_element[2] = new Sprite(_element[1]);
		
		constructor = new SpriteElement(_element[2], _element[0]);
		
		var _result = [constructor.parent, constructor.isFunctional()];
		var _expectedValue = [self, true];
		
		constructor.destroy();
		
		array_push(_result, constructor.isFunctional());
		array_push(_expectedValue, false);
		
		other.unitTest.assert_equal(("SpriteElement - Construction: New constructor / " +
									"Destruction / Method: isFunctional()"),
									_result[0], _expectedValue[0],
									_result[1], _expectedValue[1],
									_result[2], _expectedValue[2]);
	}
	
	constructor.destroy();
	
#endregion
#region [Test: SpriteElement - Construction: Wrapper]
	
	var _base = 22;
	
	constructor = new Layer(_base);
	
	with (constructor)
	{
		var _element = [other.asset[4]];
		_element[1] = layer_sprite_create(ID, 0, 0, _element[0]);
		
		constructor = new SpriteElement(_element[1]);
		
		var _result = constructor.isFunctional();
		var _expectedValue = true;
		
		other.unitTest.assert_equal("SpriteElement - Construction: Wrapper",
									_result, _expectedValue);
		
		constructor.destroy();
	}
	
	constructor.destroy();
	
#endregion
#region [Test: SpriteElement - Construction: Constructor copy]
	
	var _base = 23;
	
	constructor = new Layer(_base);
	
	with (constructor)
	{
		var _element = [new Vector2(0, 0), other.asset[4]];
		_element[2] = new Sprite(_element[1]);
		
		constructor = [new SpriteElement(_element[2], _element[0])];
		constructor[1] = new SpriteElement(constructor[0]);
		
		var _result = constructor[1].isFunctional();
		var _expectedValue = true;
		
		other.unitTest.assert_equal("SpriteElement - Construction: Constructor copy",
									_result, _expectedValue);
		
		constructor[0].destroy();
		constructor[1].destroy();
	}
	
	constructor.destroy();
	
#endregion
#region [Test: SpriteElement - Method: changeParent()]
	
	var _base = 24;
	
	constructor = [new Layer(_base), new Layer(_base)];
	
	with (constructor[0])
	{
		var _element = [new Vector2(0, 0), other.asset[4]];
		_element[2] = new Sprite(_element[1]);
		
		constructor = new SpriteElement(_element[2], _element[0]);
		constructor.changeParent(other.constructor[1]);
		
		var _result = [other.constructor[0].spriteList.getSize(),
					   other.constructor[1].spriteList.getValue(0),
					   constructor.parent];
		var _expectedValue = [0, constructor, other.constructor[1]];
		
		other.unitTest.assert_equal("SpriteElement - Method: changeParent()",
									_result, _expectedValue);
		constructor.destroy();
	}
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: SpriteElement - Methods: setSprite() / setScale() / setColor() / setAlpha() / ...]
	
	var _element = [[new Vector2(57, 56), asset[4]], [-1, new Scale(0.5, 0.75), c_red, 0.7, 1, 14]];
	_element[2][1] = new Sprite(_element[0][1]);
	var _base = 25;
	
	constructor = new Layer(_base);
	_element[3][0] = constructor.createSprite(_element[2][1], _element[0][0]);
	_element[3][0].setSprite();
	
	var _result = [layer_sprite_get_sprite(_element[3][0].ID)];
	var _expectedValue = [_element[1][0]];
	
	_element[3][0].setSprite(_element[2][1]);
	_element[3][0].setScale(_element[1][1]);
	_element[3][0].setColor(_element[1][2]);
	_element[3][0].setAlpha(_element[1][3]);
	_element[3][0].setFrame(_element[1][4]);
	_element[3][0].setSpeed(_element[1][5]);
	
	array_push(_result, _element[3][0].sprite, _element[3][0].scale, _element[3][0].color,
						_element[3][0].alpha, _element[3][0].frame, _element[3][0].speed,
						layer_sprite_get_sprite(_element[3][0].ID),
						layer_sprite_get_xscale(_element[3][0].ID),
						layer_sprite_get_yscale(_element[3][0].ID),
						layer_sprite_get_blend(_element[3][0].ID),
						layer_sprite_get_alpha(_element[3][0].ID),
						layer_sprite_get_index(_element[3][0].ID),
						layer_sprite_get_speed(_element[3][0].ID));
	array_push(_expectedValue, _element[2][1], _element[1][1], _element[1][2], _element[1][3],
							   _element[1][4], _element[1][5], _element[2][1].ID, _element[1][1].x,
							   _element[1][1].y, _element[1][2], _element[1][3], _element[1][4],
							   _element[1][5]);
	
	unitTest.assert_equal("SpriteElement - Methods: setSprite() / setScale() / setColor() / " +
						  "setAlpha() / setFrame() / setSpeed()",
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
						  _result[12], _expectedValue[12]);
	
	_element[3][0].destroy();
	constructor.destroy();
	
#endregion
#region [Test: SpriteElement - Method: toString()]
	
	var _element = [[new Vector2(57, 56), asset[4]], ["SpriteElement"]];
	_element[0][2] = new Sprite(_element[0][1]);
	var _base = 26;
	
	constructor = new Layer(_base);
	_element[2][0] = constructor.createSprite(_element[0][2], _element[0][0]);
	
	var _result = _element[2][0].toString();
	var _expectedValue = (constructorName + "." + _element[1][0] +
						  "(" +
						  "ID: " + string(_element[2][0].ID) + + ", " +
						  "Sprite: " + string(_element[0][2]) +
						  ")");
	
	unitTest.assert_equal("SpriteElement - Method: toString()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: SpriteElement - Method: toString(multiline?, full)]
	
	var _element = [[new Vector2(27, 36), asset[4]], ["\n", ", ", "SpriteElement"]];
	_element[0][2] = new Sprite(_element[0][1]);
	var _base = 27;
	
	constructor = new Layer(_base);
	_element[2][0] = constructor.createSprite(_element[0][2], _element[0][0]);
	
	var _result = [_element[2][0].toString(true, true), _element[2][0].toString(false, true)];
	var _expectedValue = [];
	
	var _i = 0;
	repeat ((array_length(_element[1]) - 1))
	{
		array_push(_expectedValue,
				   ("ID: " + string(_element[2][0].ID) + _element[1][_i] +
					"Sprite: " + string(_element[0][2]) + _element[1][_i] +
					"Location: " + string(_element[0][0]) + _element[1][_i] +
					"Scale: " + string(new Scale(1, 1)) + _element[1][_i] +
					"Angle: " + string(new Angle(0)) + _element[1][_i] +
					"Color: " + string(c_white) + _element[1][_i] +
					"Alpha: " + string(1) + _element[1][_i] +
					"Frame: " + string(0) + _element[1][_i] +
					"Speed: " + string(0)));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "." + _element[1][2] + "(" + _expectedValue[1] + ")");
	
	unitTest.assert_equal("SpriteElement - Method: toString(multiline?, full)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: BackgroundElement - Construction: New constructor / Destruction / ...]
	
	var _base = 28;
	
	constructor = new Layer(_base);
	
	with (constructor)
	{
		var _element = [new Vector2(0, 0), other.asset[0]];
		_element[2] = new Sprite(_element[1], _element[0]);
		
		constructor = new BackgroundElement(_element[2]);
		
		var _result = [constructor.parent, constructor.isFunctional()];
		var _expectedValue = [self, true];
		
		constructor.destroy();
		
		array_push(_result, constructor.isFunctional());
		array_push(_expectedValue, false);
		
		other.unitTest.assert_equal("BackgroundElement - Construction: New constructor / " +
									"Destruction / Method: isFunctional()",
									_result[0], _expectedValue[0],
									_result[1], _expectedValue[1],
									_result[2], _expectedValue[2]);
	}
	
	constructor.destroy();
	
#endregion
#region [Test: BackgroundElement - Construction: Wrapper]
	
	var _base = 29;
	
	constructor = new Layer(_base);
	
	with (constructor)
	{
		var _element = [other.asset[0]];
		_element[1] = layer_background_create(ID, _element[0]);
		
		constructor = new BackgroundElement(_element[1]);
		
		var _result = constructor.isFunctional();
		var _expectedValue = true;
		
		other.unitTest.assert_equal("BackgroundElement - Construction: Wrapper",
									_result, _expectedValue);
		
		constructor.destroy();
	}
	
	constructor.destroy();
	
#endregion
#region [Test: BackgroundElement - Construction: Constructor copy]
	
	var _base = 30;
	
	constructor = new Layer(_base);
	
	with (constructor)
	{
		var _element = [new Vector2(0, 0), other.asset[0]];
		_element[2] = new Sprite(_element[1], _element[0]);
		
		constructor = [new BackgroundElement(_element[2])];
		constructor[1] = new BackgroundElement(constructor[0]);
		
		var _result = constructor[1].isFunctional();
		var _expectedValue = true;
		
		other.unitTest.assert_equal("BackgroundElement - Construction: Constructor copy",
									_result, _expectedValue);
		
		constructor[0].destroy();
		constructor[1].destroy();
	}
	
	constructor.destroy();
	
#endregion
#region [Test: BackgroundElement - Method: changeParent()]
	
	var _base = 31;
	
	constructor = [new Layer(_base), new Layer(_base)];
	
	with (constructor[0])
	{
		var _element = [new Vector2(0, 0), other.asset[0]];
		_element[2] = new Sprite(_element[1], _element[0]);
		
		constructor = new BackgroundElement(_element[2]);
		constructor.changeParent(other.constructor[1]);
		
		var _result = [other.constructor[0].backgroundList.getSize(),
					   other.constructor[1].backgroundList.getValue(0),
					   constructor.parent];
		var _expectedValue = [0, constructor, other.constructor[1]];
		
		other.unitTest.assert_equal("BackgroundElement - Method: changeParent()",
									_result, _expectedValue);
		
		constructor.destroy();
	}
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: BackgroundElement - Methods: setSprite() / setScale() / setColor() / setAlpha() / ...]
	
	var _element = [[asset[0]], [-1, new Scale(0.5, 0.75), c_red, 0.7, 1, 14]];
	_element[0][1] = new Sprite(_element[0][0]);
	var _base = 35;
	
	constructor = new Layer(_base);
	_element[2][0] = constructor.createBackground(_element[0][1]);
	_element[2][0].setSprite();
	layer_background_sprite(_element[2][0].ID, -1);
	
	var _result = [layer_background_get_sprite(_element[2][0].ID)];
	var _expectedValue = [_element[1][0]];
	
	_element[2][0].setSprite(_element[0][1]);
	_element[2][0].setScale(_element[1][1]);
	_element[2][0].setColor(_element[1][2]);
	_element[2][0].setAlpha(_element[1][3]);
	_element[2][0].setFrame(_element[1][4]);
	_element[2][0].setSpeed(_element[1][5]);
	
	array_push(_result, _element[2][0].sprite, _element[2][0].scale, _element[2][0].color,
						_element[2][0].alpha, _element[2][0].frame, _element[2][0].speed,
						layer_background_get_sprite(_element[2][0].ID),
						layer_background_get_xscale(_element[2][0].ID),
						layer_background_get_yscale(_element[2][0].ID),
						layer_background_get_blend(_element[2][0].ID),
						layer_background_get_alpha(_element[2][0].ID),
						layer_background_get_index(_element[2][0].ID),
						layer_background_get_speed(_element[2][0].ID));
	
	array_push(_expectedValue, _element[0][1], _element[1][1], _element[1][2], _element[1][3],
							   _element[1][4], _element[1][5], _element[0][1].ID, _element[1][1].x,
							   _element[1][1].y, _element[1][2], _element[1][3], _element[1][4],
							   _element[1][5]);
	
	unitTest.assert_equal("BackgroundElement - Methods: setSprite() / setScale() / setColor() / " +
						  "setAlpha() / setFrame() / setSpeed()",
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
						  _result[12], _expectedValue[12]);
	
	_element[2][0].destroy();
	constructor.destroy();
	
#endregion
#region [Test: BackgroundElement - Method: setStretch()]
	
	var _element = [[asset[0]]];
	_element[0][1] = new Sprite(_element[0][0]);
	var _base = 32;
	
	constructor = new Layer(_base);
	_element[1][0] = constructor.createBackground(_element[0][1]);
	_element[1][0].setStretch(true);
	
	var _result = [layer_background_get_stretch(_element[1][0].ID), _element[1][0].stretch];
	var _expectedValue = [true, true];
	
	_element[1][0].setStretch(false);
	
	array_push(_result, layer_background_get_stretch(_element[1][0].ID), _element[1][0].stretch);
	array_push(_expectedValue, false, false);
	
	unitTest.assert_equal("BackgroundElement - Method: setStretch()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
	constructor.destroy();
	
#endregion
#region [Test: BackgroundElement - Method: setTiled()]
	
	var _element = [[asset[0]]];
	_element[0][1] = new Sprite(_element[0][0]);
	var _base = 33;
	
	constructor = new Layer(_base);
	_element[1][0] = constructor.createBackground(_element[0][1]);
	_element[1][0].setTiled(true, false);
	
	var _result = [layer_background_get_htiled(_element[1][0].ID),
				   layer_background_get_vtiled(_element[1][0].ID),
				   _element[1][0].tiled_x,
				   _element[1][0].tiled_y];
	var _expectedValue = [true, false, true, false];
	
	_element[1][0].setTiled(false, true);
	
	array_push(_result, layer_background_get_htiled(_element[1][0].ID),
						layer_background_get_vtiled(_element[1][0].ID),
						_element[1][0].tiled_x,
						_element[1][0].tiled_y);
	array_push(_expectedValue, false, true, false, true);
	
	unitTest.assert_equal("BackgroundElement - Method: setTiled()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6],
						  _result[7], _expectedValue[7]);
	
	constructor.destroy();
	
#endregion
#region [Test: BackgroundElement - Method: setVisible()]
	
	var _element = [[asset[0]]];
	_element[0][1] = new Sprite(_element[0][0]);
	var _base = 34;
	
	constructor = new Layer(_base);
	_element[1][0] = constructor.createBackground(_element[0][1]);
	_element[1][0].setVisible(false);
	
	var _result = [layer_background_get_visible(_element[1][0].ID), _element[1][0].visible];
	var _expectedValue = [false, false];
	
	_element[1][0].setVisible(true);
	
	array_push(_result, layer_background_get_visible(_element[1][0].ID), _element[1][0].visible);
	array_push(_expectedValue, true, true);
	
	unitTest.assert_equal("BackgroundElement - Method: setVisible()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
	constructor.destroy();
	
#endregion
#region [Test: BackgroundElement - Method: toString()]
	
	var _element = [[new Vector2(57, 56), asset[0]], ["BackgroundElement"]];
	_element[0][1] = new Sprite(_element[0][1], _element[0][0]);
	var _base = 36;
	
	constructor = new Layer(_base);
	_element[2][0] = constructor.createBackground(_element[0][1]);
	
	var _result = _element[2][0].toString();
	var _expectedValue = (constructorName + "." + _element[1][0] +
						  "(" +
						  "ID: " + string(_element[2][0].ID) + ", " +
						  "Sprite: " + string(_element[0][1]) +
						  ")");
	
	unitTest.assert_equal("BackgroundElement - Method: toString()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: BackgroundElement - Method: toString(multiline?, full)]
	
	var _element = [[asset[4]], ["\n", ", ", "BackgroundElement"]];
	_element[0][1] = new Sprite(_element[0][0]);
	var _base = 37;
	
	constructor = new Layer(_base);
	_element[2][0] = constructor.createBackground(_element[0][1]);
	
	var _result = [_element[2][0].toString(true, true), _element[2][0].toString(false, true)];
	var _expectedValue = [];
	
	var _i = 0;
	repeat ((array_length(_element[1]) - 1))
	{
		array_push(_expectedValue,
				   ("ID: " + string(_element[2][0].ID) + _element[1][_i] +
					"Sprite: " + string(_element[0][1]) + _element[1][_i] +
					"Visible: " + string(true) + _element[1][_i] +
					"Stretch: " + string(false) + _element[1][_i] +
					"Tiled X: " + string(false) + _element[1][_i] +
					"Tiled Y: " + string(false) + _element[1][_i] +
					"Scale: " + string(new Scale(1, 1)) + _element[1][_i] +
					"Color: " + string(c_white) + _element[1][_i] +
					"Alpha: " + string(1) + _element[1][_i] +
					"Frame: " + string(0) + _element[1][_i] +
					"Speed: " + string(0)));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "." + _element[1][2] + "(" + _expectedValue[1] + ")");
	
	unitTest.assert_equal("BackgroundElement - Method: toString(multiline?, full)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: TilemapElement - Construction: New constructor / Destruction / Method: isFuncitonal()]
	
	var _base = 38;
	
	constructor = new Layer(_base);
	
	with (constructor)
	{
		var _element = [other.asset[2], new Vector2(0, 0), new Vector2(16, 16)];
		
		constructor = new TilemapElement(_element[0], _element[1], _element[2]);
		
		var _result = [constructor.parent, constructor.isFunctional()];
		var _expectedValue = [self, true];
		
		constructor.destroy();
		
		array_push(_result, constructor.isFunctional());
		array_push(_expectedValue, false);
		
		other.unitTest.assert_equal("TilemapElement - Construction: New constructor / " +
									"Destruction / Method: isFunctional()",
									_result[0], _expectedValue[0],
									_result[1], _expectedValue[1],
									_result[2], _expectedValue[2]);
	}
	
	constructor.destroy();
	
#endregion
#region [Test: TilemapElement - Construction: Wrapper]
	
	var _base = 39;
	
	constructor = new Layer(_base);
	
	with (constructor)
	{
		var _element = [[other.asset[2], new Vector2(0, 0), new Vector2(16, 16)]];
		_element[1][0] = layer_tilemap_create(ID, _element[0][1].x, _element[0][1].y, _element[0][0],
											  _element[0][2].x, _element[0][2].y);
		
		constructor = new TilemapElement(_element[1][0]);
		
		var _result = constructor.isFunctional();
		var _expectedValue = true;
		
		other.unitTest.assert_equal("TilemapElement - Construction: Wrapper",
									_result, _expectedValue);
		
		constructor.destroy();
	}
	
	constructor.destroy();
	
#endregion
#region [Test: TilemapElement - Construction: Constructor copy]
	
	var _base = 40;
	
	constructor = new Layer(_base);
	
	with (constructor)
	{
		var _element = [other.asset[2], new Vector2(0, 0), new Vector2(16, 16)];
		
		constructor = [new TilemapElement(_element[0], _element[1], _element[2])];
		constructor[1] = new TilemapElement(constructor[0]);
		
		var _result = constructor[1].isFunctional();
		var _expectedValue = true;
		
		other.unitTest.assert_equal("TilemapElement - Construction: Constructor copy",
									_result, _expectedValue);
		
		constructor[0].destroy();
		constructor[1].destroy();
	}
	
	constructor.destroy();
	
#endregion
#region [Test: TilemapElement - Method: changeParent()]
	
	var _base = 41;
	
	constructor = [new Layer(_base), new Layer(_base)];
	
	with (constructor[0])
	{
		var _element = [other.asset[2], new Vector2(0, 0), new Vector2(16, 16)];
		
		constructor = new TilemapElement(_element[0], _element[1], _element[2]);
		constructor.changeParent(other.constructor[1]);
		
		var _result = [other.constructor[0].tilemapList.getSize(),
					   other.constructor[1].tilemapList.getValue(0),
					   constructor.parent];
		var _expectedValue = [0, constructor, other.constructor[1]];
		
		other.unitTest.assert_equal("TilemapElement - Method: changeParent()",
									_result, _expectedValue);
		
		constructor.destroy();
	}
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: TilemapElement - Methods: setTileInCell() / getTileInCell()]
	
	var _base = 42;
	var _element = [[asset[2], new Vector2(0, 0), new Vector2(16, 16)], [new Vector2(1, 0), 1]];
	
	constructor = new Layer(_base);
	_element[2][0] = constructor.createTilemap(_element[0][0], _element[0][1], _element[0][2]);
	_element[2][1] = _element[2][0].getTileInCell(_element[1][0]);
	
	var _result = [_element[2][1].ID];
	var _expectedValue = [0];
	
	_element[2][0].setTileInCell(_element[1][0], _element[1][1]);
	_element[2][1] = _element[2][0].getTileInCell(_element[1][0]);
	
	array_push(_result, _element[2][1].ID);
	array_push(_expectedValue, _element[1][1]);
	
	unitTest.assert_equal("TilemapElement - Methods: setTileInCell() / getTileInCell()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: TilemapElement - Method: clear()]
	
	var _base = 43;
	var _element = [[asset[2], new Vector2(0, 0), new Vector2(16, 16)], [new Vector2(1, 1), 2,
					 new Vector2(2, 2)]];
	
	constructor = new Layer(_base);
	_element[2][0] = constructor.createTilemap(_element[0][0], _element[0][1], _element[0][2]);
	_element[2][0].setTileInCell(_element[1][0], _element[1][1]);
	_element[2][1] = _element[2][0].getTileInCell(_element[1][0]);
	_element[2][0].clear(_element[2][1]);
	_element[2][2] = _element[2][0].getTileInCell(_element[1][2]);
	
	var _result = _element[2][2].ID;
	var _expectedValue = _element[2][1].ID;
	
	unitTest.assert_equal("TilemapElement - Method: clear()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: TilemapElement - Methods: getMask() / setMask()]
	
	var _base = 44;
	var _element = [[asset[2], new Vector2(0, 0), new Vector2(16, 16)], [0]];
	
	constructor = new Layer(_base);
	_element[2][0] = constructor.createTilemap(_element[0][0], _element[0][1], _element[0][2]);
	_element[3][0] = _element[2][0].getMask();
	
	var _result = [is_real(_element[3][0]), (_element[3][0] > 0)];
	var _expectedValue = [true, true];
	
	_element[2][0].setMask(_element[1][0]);
	
	array_push(_result, _element[2][0].getMask());
	array_push(_expectedValue, _element[1][0]);
	
	unitTest.assert_equal("TilemapElement - Methods: getMask() / setMask()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: TilemapElement - Method: getFrame()]
	
	var _base = 45;
	var _element = [[asset[2], new Vector2(0, 0), new Vector2(16, 16)]];
	
	constructor = new Layer(_base);
	_element[1][0] = constructor.createTilemap(_element[0][0], _element[0][1], _element[0][2]);
	
	var _result = _element[1][0].getFrame();
	var _expectedValue = 0;
	
	unitTest.assert_equal("TilemapElement - Method: getFrame()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: TilemapElement - Methods: getTileAtPoint() / setTileAtPoint()]
	
	var _base = 46;
	var _element = [[asset[2], new Vector2(0, 0), new Vector2(16, 16)], [new Vector2(1, 0), 1]];
	_element[2][0] = new Vector2(((_element[0][2].x * _element[1][0].x) + 1),
								 ((_element[0][2].y * _element[1][0].y) + 1));
	
	constructor = new Layer(_base);
	_element[3][0] = constructor.createTilemap(_element[0][0], _element[0][1], _element[0][2]);
	_element[3][1] = _element[3][0].getTileAtPoint(_element[2][0]);
	
	var _result = [_element[3][1].ID];
	var _expectedValue = [0];
	
	_element[3][0].setTileAtPoint(_element[2][0], _element[1][1]);
	_element[3][1] = _element[3][0].getTileInCell(_element[1][0]);
	
	array_push(_result, _element[3][1].ID);
	array_push(_expectedValue, _element[1][1]);
	
	unitTest.assert_equal("TilemapElement - Methods: getTileAtPoint() / setTileAtPoint()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: TilemapElement - Method: getCellAtPoint()]
	
	var _base = 47;
	var _element = [[asset[2], new Vector2(0, 0), new Vector2(16, 16)], [new Vector2(0, 0),
					new Vector2(1, 1)]];
	
	constructor = new Layer(_base);
	_element[2][0] = constructor.createTilemap(_element[0][0], _element[0][1], _element[0][2]);
	
	var _result = [_element[2][0].getCellAtPoint(_element[0][1]),
				   _element[2][0].getCellAtPoint(_element[0][2])];
	var _expectedValue = [_element[1][0], _element[1][1]];
	
	unitTest.assert_equal("TilemapElement - Method: getCellAtPoint()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: TilemapElement - Method: setTileset()]
	
	var _base = 48;
	var _element = [[asset[2], new Vector2(0, 0), new Vector2(16, 16), asset[4]]];
	
	constructor = new Layer(_base);
	_element[1][0] = constructor.createTilemap(_element[0][0], _element[0][1], _element[0][2]);
	_element[1][0].setTileset(_element[0][3]);
	
	var _result = [tilemap_get_tileset(_element[1][0].ID), _element[1][0].tileset];
	var _expectedValue = [asset[4], asset[4]];
	
	unitTest.assert_equal("TilemapElement - Method: setTileset()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: TilemapElement - Method: setSize()]
	
	var _base = 49;
	var _element = [[asset[2], new Vector2(0, 0), new Vector2(16, 16)]];
	_element[0][3] = new Vector2((_element[0][2].x + 1), (_element[0][2].y + 2));
	
	constructor = new Layer(_base);
	_element[1][0] = constructor.createTilemap(_element[0][0], _element[0][1], _element[0][2]);
	_element[1][0].setSize(_element[0][3]);
	
	var _result = [tilemap_get_width(_element[1][0].ID),
				   tilemap_get_height(_element[1][0].ID),
				   _element[1][0].size];
	var _expectedValue = [_element[0][3].x, _element[0][3].y, _element[0][3]];
	
	unitTest.assert_equal("TilemapElement - Method: setSize()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: TilemapElement - Method: render()]
	
	unitTest.assert_executable
	(
	 "TilemapElement - Method: render()",
	 function()
	 {
		 with (unitTest_Layer)
		 {
			 var _base = 50;
			 var _element = [[asset[2], new Vector2(0, 0), new Vector2(16, 16)]];
			 
			 constructor = new Layer(_base);
			 _element[1][0] = constructor.createTilemap(_element[0][0], _element[0][1],
														_element[0][2]);
			 _element[1][0].render();
			 
			 constructor.destroy();
		 }
	 }
	);
	
#endregion
#region [Test: TilemapElement - Method: toString()]
	
	var _base = 51;
	var _element = [[asset[2], new Vector2(0, 0), new Vector2(16, 16)], ["TilemapElement"],
					["\n", ", "]];
	_element[0][3] = new Vector2((_element[0][2].x + 1), (_element[0][2].y + 2));
	
	constructor = new Layer(_base);
	_element[3][0] = constructor.createTilemap(_element[0][0], _element[0][1], _element[0][2]);
	
	var _result = [_element[3][0].toString(true), _element[3][0].toString(false)];
	var _expectedValue = [];
	
	var _i = 0;
	
	repeat (array_length(_element[2]))
	{
		array_push(_expectedValue,
				   ("ID: " + string(_element[3][0].ID) + _element[2][_i] +
				    "Tileset: " + tileset_get_name(_element[0][0]) + _element[2][_i] +
					"Location: " + string(_element[0][1]) + _element[2][_i] +
					"Size: " + string(_element[0][2])));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "." + _element[1][0] + "(" + _expectedValue[1] + ")");
	
	unitTest.assert_equal("TilemapElement - Method: toString(multiline?)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: TilemapElement.TileData - Construction: New constructor / Method: isFunctional()]
	
	var _base = 52;
	var _element = [[asset[2], new Vector2(0, 0), new Vector2(16, 16)]];
	_element[0][3] = new Vector2((_element[0][2].x + 1), (_element[0][2].y + 2));
	
	constructor = new Layer(_base);
	_element[1][0] = constructor.createTilemap(_element[0][0], _element[0][1], _element[0][2]);
	
	with (_element[1][0])
	{
		var _base = 0;
		
		var _element = new TileData(_base);
		
		var _result = [_element.parent, _element.isFunctional()];
		var _expectedValue = [self, true];
		
		_element.ID = undefined;
		
		array_push(_result, _element.isFunctional());
		array_push(_expectedValue, false);
		
		other.unitTest.assert_equal("TilemapElement.TileData - Construction: New constructor / " +
									"Method: isFunctional()",
									_result[0], _expectedValue[0],
									_result[1], _expectedValue[1],
									_result[2], _expectedValue[2]);
	}
	
	constructor.destroy();
	
#endregion
#region [Test: TilemapElement.TileData - Construction: Constructor copy]
	
	var _base = 53;
	var _element = [[asset[2], new Vector2(0, 0), new Vector2(16, 16)]];
	
	constructor = new Layer(_base);
	_element[1][0] = constructor.createTilemap(_element[0][0], _element[0][1], _element[0][2]);
	
	with (_element[1][0])
	{
		var _base = 1;
		
		var _element = [new TileData(_base)];
		_element[1] = new TileData(_element[0]);
		
		var _result = _element[1].ID;
		var _expectedValue = _base;
		
		other.unitTest.assert_equal("TilemapElement.TileData - Construction: Constructor copy",
									_result, _expectedValue);
	}
	
	constructor.destroy();
	
#endregion
#region [Test: TilemapElement.TileData - Methods: clear() / isEmpty()]
	
	var _base = 54;
	var _element = [[asset[2], new Vector2(0, 0), new Vector2(16, 16)], [new Vector2(1, 0), 2]];
	
	constructor = new Layer(_base);
	_element[2][0] = constructor.createTilemap(_element[0][0], _element[0][1], _element[0][2]);
	_element[2][0].setTileInCell(_element[1][0], _element[1][1]);
	_element[2][1] = _element[2][0].getTileInCell(_element[1][0]);
	
	var _result = [_element[2][1].isEmpty()];
	var _expectedValue = [false];
	
	_element[2][1].clear();
	
	array_push(_result, _element[2][1].isEmpty());
	array_push(_expectedValue, true);
	
	unitTest.assert_equal("TilemapElement.TileData - Methods: clear() / isEmpty()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: TilemapElement.TileData - Methods: getTilesetIndex() / setTilesetIndex()]
	
	var _base = 55;
	var _element = [[asset[2], new Vector2(0, 0), new Vector2(16, 16)], [new Vector2(1, 0), 2, 3]];
	
	constructor = new Layer(_base);
	_element[2][0] = constructor.createTilemap(_element[0][0], _element[0][1], _element[0][2]);
	_element[2][0].setTileInCell(_element[1][0], _element[1][1]);
	_element[2][1] = _element[2][0].getTileInCell(_element[1][0]);
	
	var _result = [_element[2][1].getTilesetIndex()];
	var _expectedValue = [_element[1][1]];
	
	_element[2][1].setTilesetIndex(_element[1][2]);
	
	array_push(_result, _element[2][1].getTilesetIndex());
	array_push(_expectedValue, _element[1][2]);
	
	unitTest.assert_equal("TilemapElement.TileData - Methods: getTilesetIndex() / setTilesetIndex()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: TilemapElement.TileData - Methods: isMirroredX() / setMirrorX()]
	
	var _base = 56;
	var _element = [[asset[2], new Vector2(0, 0), new Vector2(16, 16)], [new Vector2(1, 0), 2]];
	
	constructor = new Layer(_base);
	_element[2][0] = constructor.createTilemap(_element[0][0], _element[0][1], _element[0][2]);
	_element[2][0].setTileInCell(_element[1][0], _element[1][1]);
	_element[2][1] = _element[2][0].getTileInCell(_element[1][0]);
	
	var _result = [_element[2][1].isMirroredX()];
	var _expectedValue = [false];
	
	_element[2][1].setMirrorX(true);
	
	array_push(_result, _element[2][1].isMirroredX());
	array_push(_expectedValue, true);
	
	_element[2][1].setMirrorX(false);
	
	array_push(_result, _element[2][1].isMirroredX());
	array_push(_expectedValue, false);
	
	unitTest.assert_equal("TilemapElement.TileData - Methods: isMirroredX() / setMirrorX()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: TilemapElement.TileData - Methods: isMirroredY() / setMirrorY()]
	
	var _base = 57;
	var _element = [[asset[2], new Vector2(0, 0), new Vector2(16, 16)], [new Vector2(1, 1), 2]];
	
	constructor = new Layer(_base);
	_element[2][0] = constructor.createTilemap(_element[0][0], _element[0][1], _element[0][2]);
	_element[2][0].setTileInCell(_element[1][0], _element[1][1]);
	_element[2][1] = _element[2][0].getTileInCell(_element[1][0]);
	
	var _result = [_element[2][1].isMirroredY()];
	var _expectedValue = [false];
	
	_element[2][1].setMirrorY(true);
	
	array_push(_result, _element[2][1].isMirroredY());
	array_push(_expectedValue, true);
	
	_element[2][1].setMirrorY(false);
	
	array_push(_result, _element[2][1].isMirroredY());
	array_push(_expectedValue, false);
	
	unitTest.assert_equal("TilemapElement.TileData - Methods: isMirroredY() / setMirrorY()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: TilemapElement.TileData - Methods: isRotated() / setRotate()]
	
	var _base = 58;
	var _element = [[asset[2], new Vector2(0, 0), new Vector2(16, 16)], [new Vector2(2, 0), 3]];
	
	constructor = new Layer(_base);
	_element[2][0] = constructor.createTilemap(_element[0][0], _element[0][1], _element[0][2]);
	_element[2][0].setTileInCell(_element[1][0], _element[1][1]);
	_element[2][1] = _element[2][0].getTileInCell(_element[1][0]);
	
	var _result = [_element[2][1].isRotated()];
	var _expectedValue = [false];
	
	_element[2][1].setRotate(true);
	
	array_push(_result, _element[2][1].isRotated());
	array_push(_expectedValue, true);
	
	_element[2][1].setRotate(false);
	
	array_push(_result, _element[2][1].isRotated());
	array_push(_expectedValue, false);
	
	unitTest.assert_equal("TilemapElement.TileData - Methods: isRotated() / setRotate()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: TilemapElement.TileData - Method: render()]
	
	unitTest.assert_executable
	(
	 "TilemapElement.TileData - Method: render()",
	 function()
	 {
		with (unitTest_Layer)
		{
			var _base = 59;
			var _element = [[asset[2], new Vector2(0, 0), new Vector2(16, 16)],
							[new Vector2(1, 1), 2]];
	
			constructor = new Layer(_base);
			_element[2][0] = constructor.createTilemap(_element[0][0], _element[0][1],
													   _element[0][2]);
			_element[2][0].setTileInCell(_element[1][0], _element[1][1]);
			_element[2][1] = _element[2][0].getTileInCell(_element[1][0]);
		
			_element[2][1].render();
		
			constructor.destroy();
		}
	 }
	);
	
#endregion
#region [Test: TilemapElement.TileData - Method: toString()]
	
	var _base = 60;
	var _element = [[asset[2], new Vector2(0, 0), new Vector2(16, 16)], [new Vector2(2, 1), 1],
					["TilemapElement", "TileData"]];
	
	constructor = new Layer(_base);
	_element[3][0] = constructor.createTilemap(_element[0][0], _element[0][1], _element[0][2]);
	_element[3][0].setTileInCell(_element[1][0], _element[1][1]);
	_element[3][1] = _element[3][0].getTileInCell(_element[1][0]);
	
	var _result = _element[3][1].toString();
	var _expectedValue = (constructorName + "." + _element[2][0] + "." + _element[2][1] + "(" +
						  string(_element[1][1]) + ")");
	
	unitTest.assert_equal("TilemapElement.TileData - Method: toString()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: ParticleSystem - Construction: New element / Destruction / Method: isFunctional()]
	
	var _base = 61;
	var _element = [[false, true]];
	
	constructor = new Layer(_base);
	_element[1] = [constructor.createParticleSystem(_element[0][0]),
				   constructor.createParticleSystem(_element[0][1])];
	
	var _result = [_element[1][0].isFunctional(), _element[1][1].isFunctional()];
	var _expectedValue = [true, true];
	
	_element[1][0].destroy();
	constructor.destroy();
	
	array_push(_result, _element[1][0].isFunctional(), _element[1][1].isFunctional());
	array_push(_expectedValue, _element[0][0], _element[0][1]);
	
	_element[1][1].destroy();
	
	array_push(_result, _element[1][1].isFunctional());
	array_push(_expectedValue, false);
	
	unitTest.assert_equal("ParticleSystem - Construction: New element / Destruction / " +
						  "Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4]);
	
#endregion
#region [Test: ParticleSystem - Construction: Constructor copy / Methods: setLocation() / ...]
	
	var _base = 62;
	var _element = [[false, true]];
	
	constructor = new Layer(_base);
	
	with (constructor)
	{
		var _element = [[false, true], [new Vector2(50, 50), false, false, false,
						new Vector2(0, 0)]];
		
		_element[2] = [self.createParticleSystem(_element[0][0]),
					   self.createParticleSystem(_element[0][1])];
		
		_element[2][0].setLocation(_element[1][0]);
		_element[2][0].setAutomaticUpdate(_element[1][1]);
		_element[2][0].setAutomaticRender(_element[1][2]);
		_element[2][0].setDrawOrder(_element[1][3]);
		
		_element[3] = [new ParticleSystem(_element[2][0]), new ParticleSystem(_element[2][1])];
		
		var _result = [_element[3][0].persistent,
					   _element[3][0].location,
					   _element[3][0].automaticUpdate,
					   _element[3][0].automaticRender,
					   _element[3][0].drawOrder_newerOnTop,
					   
					   _element[3][1].persistent,
					   _element[3][1].location,
					   _element[3][1].automaticUpdate,
					   _element[3][1].automaticRender,
					   _element[3][1].drawOrder_newerOnTop];
		var _expectedValue = [_element[0][0], _element[1][0], _element[1][1], _element[1][2],
							  _element[1][3], _element[0][1], _element[1][4], true, true, true];
		
		other.unitTest.assert_equal("ParticleSystem - Construction: Constructor copy / Methods: " +
									"setLocation() / setAutomaticUpdate() / " +
									"setAutomaticRender() / setDrawOrder()",
									_result[0], _expectedValue[0],
									_result[1], _expectedValue[1],
									_result[2], _expectedValue[2],
									_result[3], _expectedValue[3],
									_result[4], _expectedValue[4],
									_result[5], _expectedValue[5],
									_result[6], _expectedValue[6],
									_result[7], _expectedValue[7],
									_result[8], _expectedValue[8],
									_result[9], _expectedValue[9]);
		
		_element[2][0].destroy();
		_element[2][1].destroy();
	}
	
	constructor.destroy(true);
	
#endregion
#region [Test: ParticleSystem - Method: changeParent()]
	
	/*
	var _base = 31;
	
	constructor = [new Layer(_base), new Layer(_base)];
	
	with (constructor[0])
	{
		var _element = false;
		
		constructor = new ParticleSystem(_element);
		constructor.changeParent(other.constructor[1]);
		
		var _result = [other.constructor[0].particleSystemList.getSize(),
					   other.constructor[1].particleSystemList.getValue(0),
					   constructor.parent];
		var _expectedValue = [0, constructor, other.constructor[1]];
		
		other.unitTest.assert_equal(("ParticleSystem - Method: changeParent()"),
									_result, _expectedValue);
		
		constructor.destroy();
	}
	
	constructor[0].destroy();
	constructor[1].destroy();
	*/
	
	unitTest.assert_untestable("ParticleSystem - Method: changeParent(BROKEN IN ENGINE, " +
							   "UNTESTABLE)");
	
#endregion
#region [Test: ParticleSystem - Methods: clear() / getParticleCount()]
	
	var _base = 63;
	var _element = [[false], [new ParticleType(), new Vector2(75, 75)], [3]];
	
	constructor = new Layer(_base);
	_element[3][0] = constructor.createParticleSystem(_element[0][0]);
	_element[1][0].create(_element[3][0], _element[1][1], _element[2][0]);
	
	var _result = [_element[3][0].getParticleCount()];
	var _expectedValue = [_element[2][0]];
	
	_element[3][0].clear();
	
	array_push(_result, _element[3][0].getParticleCount());
	array_push(_expectedValue, 0);
	
	unitTest.assert_equal("ParticleSystem - Methods: clear() / getParticleCount()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	_element[1][0].destroy();
	constructor.destroy();
	
#endregion
#region [Test: ParticleSystem - Method: render()]
	
	unitTest.assert_executable
	(
	 "ParticleSystem - Method: render()",
	 function()
	 {
		 with (unitTest_Layer)
		 {
			 var _base = 64;
			 var _element = [[false], [false]];
			 
			 constructor = new Layer(_base);
			 _element[2][0] = constructor.createParticleSystem(_element[0][0]);
			 _element[2][0].setAutomaticRender(_element[1][0]);
			 _element[2][0].render();
			 
			 constructor.destroy();
		 }
	 }
	);
	
#endregion
#region [Test: ParticleSystem - Method: update()]
	
	unitTest.assert_executable
	(
	 "ParticleSystem - Method: update()",
	 function()
	 {
		 with (unitTest_Layer)
		 {
			 var _base = 65;
			 var _element = [[false], [false]];
			 
			 constructor = new Layer(_base);
			 _element[2][0] = constructor.createParticleSystem(_element[0][0]);
			 _element[2][0].setAutomaticUpdate(_element[1][0]);
			 _element[2][0].update();
			 
			 constructor.destroy();
		 }
	 }
	);
	
#endregion
#region [Test: ParticleSystem - Method: createEmitter()]
	
	var _base = 66;
	var _element = [[false], [new ParticleType()]];
	
	constructor = new Layer(_base);
	_element[2][0] = constructor.createParticleSystem(_element[0][0]);
	_element[3][0] = _element[2][0].createEmitter(_element[1]);
	
	var _result = [_element[3][0].isFunctional(), _element[2][0].emitterList.getValue(0)];
	var _expectedValue = [true, _element[3][0]];
	
	_element[2][0].destroy();
	
	array_push(_result, _element[3][0].isFunctional());
	array_push(_expectedValue, false);
	
	unitTest.assert_equal("ParticleSystem - Method: createEmitter()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	_element[1][0].destroy();
	constructor.destroy();
	
#endregion
#region [Test: ParticleSystem - Method: toString()]
	
	var _base = 67;
	var _element = [["ParticleSystem"]];
	
	constructor = new Layer(_base);
	_element[1][0] = constructor.createParticleSystem();
	
	var _result = _element[1][0].toString();
	var _expectedValue = (constructorName + "." + _element[0][0] + "(" + "ID: " +
						  string(_element[1][0].ID) + ", " + "Emitter Number: " + string(0) + ")");
	
	unitTest.assert_equal("ParticleSystem - Method: toString()",
						  _result, _expectedValue);
	
	_element[1][0].destroy();
	constructor.destroy();
	
#endregion
#region [Test: ParticleSystem - Method: toString(multiline?, full)]
	
	var _base = 68;
	var _element = [["ParticleSystem"], ["\n", ", "], [new Vector2(0, 0)]];
	
	constructor = new Layer(_base);
	_element[3][0] = constructor.createParticleSystem();
	
	var _result = [_element[3][0].toString(true, true), _element[3][0].toString(false, true)];
	var _expectedValue = [];
	
	var _i = 0;
	repeat (array_length(_element[1]))
	{
		array_push(_expectedValue,
				   ("ID: " + string(_element[3][0].ID) + _element[1][_i] +
				    "Persistent: " + string(false) + _element[1][_i] +
					"Location: " + string(_element[2][0]) + _element[1][_i] +
					"Automatic Update: " + string(true) + _element[1][_i] +
					"Automatic Render: " + string(true) + _element[1][_i] +
					"Draw Order: " + "Newer on Top" + _element[1][_i] +
					"Emitter Number: " + string(0)));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "." + _element[0][0] + "(" + _expectedValue[1] + ")");
	
	unitTest.assert_equal("ParticleSystem - Method: toString(multiline?, full)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	_element[3][0].destroy();
	constructor.destroy();
	
#endregion
#region [Test: ParticleSystem.ParticleEmitter - Construction: New constructor / Destruction / ...]
	
	var _base = 69;
	
	constructor = new Layer(_base);
	var _element = constructor.createParticleSystem();
	
	with (_element)
	{
		var _element = [[new ParticleType()]];
		
		_element[1][0] = new ParticleEmitter();
		
		var _result = [_element[1][0].isFunctional(), self.emitterList.getValue(0)];
		var _expectedValue = [true, _element[1][0]];
		
		_element[1][0].destroy();
		
		array_push(_result, _element[1][0].isFunctional());
		array_push(_expectedValue, false);
		
		other.unitTest.assert_equal("ParticleSystem.ParticleEmitter - Construction: " +
									"New constructor / Destruction / Method: isFunctional()",
									_result[0], _expectedValue[0],
									_result[1], _expectedValue[1],
									_result[2], _expectedValue[2]);
		
		_element[0][0].destroy();
	}
	
	constructor.destroy();
	
#endregion
#region [Test: ParticleSystem.ParticleEmitter - Construction: Constructor copy]
	
	var _base = 70;
	
	constructor = new Layer(_base);
	var _element = [[constructor.createParticleSystem()]];
	
	with (_element[0][0])
	{
		_element[1][0] = new ParticleType();
		_element[2][0] = new ParticleEmitter(_element[1][0]);
		_element[2][1] = new ParticleEmitter(_element[2][0]);
		
		var _result = [_element[2][1].isFunctional(), _element[2][1].particleType];
		var _expectedValue = [true, _element[1][0]];
		
		other.unitTest.assert_equal("ParticleSystem.ParticleEmitter - Construction: " +
									"Constructor copy",
									_result[0], _expectedValue[0],
									_result[1], _expectedValue[1]);
		
		_element[1][0].destroy();
	}
	
	constructor.destroy();
	
#endregion
#region [Test: ParticleSystem.ParticleEmitter - Methods: clear() / setRegion() / ...]
	
	var _base = 71;
	
	constructor = new Layer(_base);
	var _element = [[constructor.createParticleSystem(), new ParticleType()],
					[new Vector4(25, 25, 75, 75), ps_shape_rectangle, ps_distr_linear], [65],
					[false]];
	_element[0][2] = _element[0][0].createEmitter();
	
	_element[0][2].setRegion(_element[1][0], _element[1][1], _element[1][2]);
	_element[0][2].setStreamCount(_element[2][0]);
	_element[0][2].setStreamEnabled(_element[3][0]);
	
	var _result = [_element[0][2].location, _element[0][2].shape, _element[0][2].distribution,
				   _element[0][2].streamCount, _element[0][2].streamEnabled];
	var _expectedValue = [_element[1][0], _element[1][1], _element[1][2], _element[2][0],
						  _element[3][0]];
	
	_element[0][2].clear();
	
	array_push(_result, _element[0][2].location, _element[0][2].shape, _element[0][2].distribution,
						_element[0][2].streamEnabled, _element[0][2].streamCount);
	array_push(_expectedValue, undefined, undefined, undefined, true, 0);
	
	unitTest.assert_equal("ParticleSystem.ParticleEmitter - Methods: clear() / setRegion() / " +
						  "setStreamCount() / setStreamEnabled()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6],
						  _result[7], _expectedValue[7],
						  _result[8], _expectedValue[8],
						  _result[9], _expectedValue[9]);
	
	_element[0][1].destroy();
	constructor.destroy();
	
#endregion
#region [Test: ParticleSystem.ParticleEmitter - Method: burst()]
	
	var _base = 72;
	
	constructor = new Layer(_base);
	var _element = [[new ParticleType()], [3]];
	_element[2][0] = constructor.createParticleSystem();
	_element[2][1] = _element[2][0].createEmitter(_element[0][0]);
	_element[2][1].burst(_element[1][0]);
	_element[2][0].update();
	
	var _result = _element[2][0].getParticleCount();
	var _expectedValue = _element[1][0];
	
	unitTest.assert_equal("ParticleSystem.ParticleEmitter - Method: burst()",
						  _result, _expectedValue);
	
	_element[2][0].clear();
	_element[0][0].destroy();
	constructor.destroy();
	
#endregion
#region [Test: ParticleSystem.ParticleEmitter - Method: stream()]
	
	var _base = 73;
	var _element = [[new ParticleType()], [5]];
	
	constructor = new Layer(_base);
	_element[2][0] = constructor.createParticleSystem();
	_element[2][1] = _element[2][0].createEmitter(_element[0][0]);
	_element[2][1].setStreamCount(_element[1][0]);
	_element[2][1].stream();
	_element[2][0].update();
	
	var _result = _element[2][0].getParticleCount();
	var _expectedValue = _element[1][0];
	
	unitTest.assert_equal("ParticleSystem.ParticleEmitter - Method: stream()",
						  _result, _expectedValue);
	
	_element[2][0].clear();
	_element[0][0].destroy();
	constructor.destroy();
	
#endregion
#region [Test: ParticleSystem.ParticleEmitter - Method: toString()]
	
	var _base = 74;
	var _element = [[new ParticleType()], ["ParticleSystem", "ParticleEmitter"]];
	
	constructor = new Layer(_base);
	_element[2][0] = constructor.createParticleSystem();
	_element[2][1] = _element[2][0].createEmitter(_element[0][0]);
	
	var _result = _element[2][1].toString();
	var _expectedValue = (constructorName + "." + _element[1][0] + "." + _element[1][1] + "(" +
						  "ID: " + string(_element[2][1].ID) + ", " + "Particle Type: " +
						  string(_element[0][0]) + ")");
	
	unitTest.assert_equal("ParticleSystem.ParticleEmitter - Method: toString()",
						  _result, _expectedValue);
	
	_element[0][0].destroy();
	constructor.destroy();
	
#endregion
#region [Test: ParticleSystem.ParticleEmitter - Method: toString(multiline?, full)]
	
	var _base = 75;
	var _element = [["ParticleSystem", "ParticleEmitter"], ["\n", ", "],
					[new Vector4(25, 25, 30, 30), ps_shape_ellipse, ps_distr_gaussian],
					["Ellipse", "Gaussian"]];
	
	constructor = new Layer(_base);
	_element[4][0] = constructor.createParticleSystem();
	_element[4][1] = _element[4][0].createEmitter();
	_element[4][1].setRegion(_element[2][0], _element[2][1], _element[2][2]);
	
	var _result = [_element[4][1].toString(true, true), _element[4][1].toString(false, true)];
	var _expectedValue = [];
	
	var _i = 0;
	repeat (array_length(_element[1]))
	{
		array_push(_expectedValue,
				   ("ID: " + string(_element[4][1].ID) + _element[1][_i] +
					"Particle Type: " + string(undefined) + _element[1][_i] +
					"Location: " + string(_element[2][0]) + _element[1][_i] +
					"Shape: " + _element[3][0] + _element[1][_i] +
					"Distribution: " + _element[3][1] + _element[1][_i] +
					"Stream Enabled: " + string(true) + _element[1][_i] +
					"Stream Count: " + string(0)));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "." + _element[0][0] + "." + _element[0][1] + "(" +
						 _expectedValue[1] + ")");
	
	unitTest.assert_equal("ParticleSystem.ParticleEmitter - Method: toString(multiline?, full)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
