/// @description Unit Testing
asset = [TestSprite];

#region [Test: Construction: New constructor / Destruction / Method: isFunctional()]
	
	constructor = new ParticleType();
	
	var _result = [constructor.isFunctional()];
	var _expectedValue = [true];
	
	constructor.destroy();
	
	array_push(_result, constructor.isFunctional());
	array_push(_expectedValue, false);
	
	unitTest.assert_equal("Construction: New constructor / Destruction / Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Construction: Constructor copy / Method: setShape()]
	
	var _element = [pt_shape_line, function(_) {return _;}, "argument"];
	
	constructor = [new ParticleType()];
	constructor[0].event.beforeCreation.callback = _element[1];
	constructor[0].event.beforeCreation.argument = _element[2];
	constructor[0].event.afterCreation.callback = _element[1];
	constructor[0].event.afterCreation.argument = _element[2];
	constructor[0].setShape(_element[0]);
	constructor[1] = new ParticleType(constructor[0]);
	
	var _result = [constructor[1].shape, constructor[1].event.beforeCreation.callback,
				   constructor[1].event.beforeCreation.argument,
				   constructor[1].event.afterCreation.callback,
				   constructor[1].event.afterCreation.argument];
	var _expectedValue = [_element[0], _element[1], _element[2], _element[1], _element[2]];
	
	unitTest.assert_equal("Construction: Constructor copy / Method: setShape()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: clear()]
	
	var _element = pt_shape_circle;
	
	constructor = new ParticleType();
	constructor.setShape(_element);
	
	var _result = [constructor.shape];
	var _expectedValue = [_element];
	
	constructor.clear();
	
	array_push(_result, constructor.shape);
	array_push(_expectedValue, pt_shape_pixel);
	
	unitTest.assert_equal("Method: clear()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setSprite()]
	
	var _element = [new Sprite(asset[0]), true, true, true];
	
	constructor = new ParticleType();
	constructor.setSprite(_element[0], _element[1], _element[2], _element[3]);
	
	var _result = [constructor.sprite, constructor.sprite_animate, constructor.sprite_matchAnimation,
				   constructor.sprite_randomize];
	var _expectedValue = [_element[0], _element[1], _element[2], _element[3]];
	
	unitTest.assert_equal("Method: setSprite()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setScale()]
	
	var _element = new Scale(0.35, 0.678);
	
	constructor = new ParticleType();
	constructor.setScale(_element);
	
	var _result = constructor.scale;
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: setScale()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setSize()]
	
	var _element = [new Range(0.25, 0.998), true, true];
	
	constructor = new ParticleType();
	constructor.setSize(_element[0], _element[1], _element[2]);
	
	var _result = [constructor.size, constructor.size_increase, constructor.size_wiggle];
	var _expectedValue = [_element[0], _element[1], _element[2]];
	
	unitTest.assert_equal("Method: setSize()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setSpeed()]
	
	var _element = [new Range(1, 3), true, true];
	
	constructor = new ParticleType();
	constructor.setSpeed(_element[0], _element[1], _element[2]);
	
	var _result = [constructor.speed, constructor.speed_increase, constructor.speed_wiggle];
	var _expectedValue = [_element[0], _element[1], _element[2]];
	
	unitTest.assert_equal("Method: setSpeed()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setDirection()]
	
	var _element = [new Range(1, 3), true, true];
	
	constructor = new ParticleType();
	constructor.setDirection(_element[0], _element[1], _element[2]);
	
	var _result = [constructor.direction, constructor.direction_increase,
				   constructor.direction_wiggle];
	var _expectedValue = [_element[0], _element[1], _element[2]];
	
	unitTest.assert_equal("Method: setDirection()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setAngle()]
	
	var _element = [new Range(1, 3), true, true, true];
	
	constructor = new ParticleType();
	constructor.setAngle(_element[0], _element[1], _element[2], _element[3]);
	
	var _result = [constructor.angle, constructor.angle_increase,
				   constructor.angle_wiggle, constructor.angle_relative];
	var _expectedValue = [_element[0], _element[1], _element[2], _element[3]];
	
	unitTest.assert_equal("Method: setAngle()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setGravity()]
	
	var _element = [0.075, new Angle(35)];
	
	constructor = new ParticleType();
	constructor.setGravity(_element[0], _element[1]);
	
	var _result = [constructor.gravity, constructor.gravity_direction];
	var _expectedValue = [_element[0], _element[1]];
	
	unitTest.assert_equal("Method: setGravity()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setLife()]
	
	var _element = new Range(925, 1785);
	
	constructor = new ParticleType();
	constructor.setLife(_element);
	
	var _result = constructor.life;
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: setLife()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setColor(color)]
	
	var _element;
	_element[0][0] = $000000;
	_element[1] = [c_black, "color"];
	
	constructor = new ParticleType();
	constructor.setColor(_element[0][0]);
	
	var _result = [constructor.color, constructor.color_type];
	var _expectedValue = [_element[1][0], _element[1][1]];
	
	unitTest.assert_equal("Method: setColor(color)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setColor(Color2)]
	
	var _element = [[c_white, c_aqua]];
	_element[1] = [new Color2(_element[0][0], _element[0][1])];
	_element[2] = ["Color2"];
	
	constructor = new ParticleType();
	constructor.setColor(_element[1][0]);
	
	var _result = [constructor.color, constructor.color_type];
	var _expectedValue = [_element[1][0], _element[2][0]];
	
	unitTest.assert_equal("Method: setColor(Color2)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setColor(Color3)]
	
	var _element = [[c_white, c_aqua, c_navy]];
	_element[1] = [new Color3(_element[0][0], _element[0][1], _element[0][2])];
	_element[2] = ["Color3"];
	
	constructor = new ParticleType();
	constructor.setColor(_element[1][0]);
	
	var _result = [constructor.color, constructor.color_type];
	var _expectedValue = [_element[1][0], _element[2][0]];
	
	unitTest.assert_equal("Method: setColor(Color3)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setColorMix()]
	
	var _element = [[c_red, c_yellow]];
	_element[1] = [new Color2(_element[0][0], _element[0][1])];
	_element[2] = ["mix"];
	
	constructor = new ParticleType();
	constructor.setColorMix(_element[1][0]);
	
	var _result = [constructor.color, constructor.color_type];
	var _expectedValue = [_element[1][0], _element[2][0]];
	
	unitTest.assert_equal("Method: setColorMix()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setColorRGB()]
	
	var _element = [[3, 242, 175]];
	_element[1] = [new Range(_element[0][0], _element[0][1])];
	_element[2] = ["RGB"];
	
	constructor = new ParticleType();
	constructor.setColorRGB(_element[1][0], _element[0][2], _element[1][0]);
	
	var _result = [constructor.color[0].minimum, constructor.color[0].maximum, constructor.color[1],
				   constructor.color[2].minimum, constructor.color[2].maximum, constructor.color_type];
	var _expectedValue = [_element[0][0], _element[0][1], _element[0][2], _element[0][0],
						  _element[0][1], _element[2][0]];
	
	unitTest.assert_equal("Method: setColorRGB()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setColorHSV()]
	
	var _element = [[1, 234, 125]];
	_element[1] = [new Range(_element[0][0], _element[0][1])];
	_element[2] = ["HSV"];
	
	constructor = new ParticleType();
	constructor.setColorHSV(_element[1][0], _element[0][2], _element[1][0]);
	
	var _result = [constructor.color[0].minimum, constructor.color[0].maximum, constructor.color[1],
				   constructor.color[2].minimum, constructor.color[2].maximum, constructor.color_type];
	var _expectedValue = [_element[0][0], _element[0][1], _element[0][2], _element[0][0],
						  _element[0][1], _element[2][0]];
	
	unitTest.assert_equal("Method: setColorHSV()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setBlend()]
	
	var _element = true;
	
	constructor = new ParticleType();
	constructor.setBlend(_element);
	
	var _result = constructor.blend_additive;
	var _expectedValue = _element;
	
	unitTest.assert_equal("Method: setBlend()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setAlpha()]
	
	var _element = [0.75, 0.25, 1];
	
	constructor = new ParticleType();
	constructor.setAlpha(_element[0]);
	
	var _result = [constructor.alpha];
	var _expectedValue = [[_element[0], undefined, undefined]];
	
	constructor.setAlpha(_element[0], _element[1]);
	
	array_push(_result, constructor.alpha);
	array_push(_expectedValue, [_element[0], _element[1], undefined]);
	
	constructor.setAlpha(_element[0], _element[1], _element[2]);
	
	array_push(_result, constructor.alpha);
	array_push(_expectedValue, [_element[0], _element[1], _element[2]]);
	
	unitTest.assert_equal("Method: setAlpha()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: setStep()]
	
	var _element = 5;
	
	constructor = [new ParticleType(), new ParticleType()];
	
	constructor[0].setStep(constructor[1], _element);
	
	var _result = [constructor[0].step_type, constructor[0].step_number];
	var _expectedValue = [constructor[1], _element];
	
	unitTest.assert_equal("Method: setStep()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: setDeath()]
	
	var _element = 5;
	
	constructor = [new ParticleType(), new ParticleType()];
	constructor[0].setDeath(constructor[1], _element);
	
	var _result = [constructor[0].death_type, constructor[0].death_number];
	var _expectedValue = [constructor[1], _element];
	
	unitTest.assert_equal("Method: setDeath()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor[0].destroy();
	constructor[1].destroy();
	
#endregion
#region [Test: Method: create()]
	
	var _element = [[new Vector2(150, 125), 2, c_lime], [new Layer(1)]];
	_element[1][1] = _element[1][0].createParticleSystem();
	
	constructor = new ParticleType();
	constructor.create(_element[1][1], _element[0][0], _element[0][1]);
	constructor.create(_element[1][1], _element[0][0], _element[0][1], _element[0][2]);
	
	var _result = _element[1][1].getParticleCount();
	var _expectedValue = (_element[0][1] * 2);
	
	unitTest.assert_equal("Method: create()",
						  _result, _expectedValue);
	
	_element[1][1].clear();
	_element[1][0].destroy();
	constructor.destroy();
	
#endregion
#region [Test: Method: createShape(Circle)]
	
	var _element = [[new Circle(new Vector2(200, 200), 10), new Layer(2)], [25, c_fuchsia]];
	_element[0][2] = _element[0][1].createParticleSystem();
	
	constructor = new ParticleType();
	constructor.createShape(_element[0][2], _element[0][0], _element[1][0]);
	constructor.createShape(_element[0][2], _element[0][0], _element[1][0], _element[1][1]);
	
	var _result = _element[0][2].getParticleCount();
	var _expectedValue = (_element[1][0] * 2);
	
	unitTest.assert_equal("Method: createShape(Circle)",
						  _result, _expectedValue);
	
	_element[0][2].clear();
	_element[0][1].destroy();
	constructor.destroy();
	
#endregion
#region [Test: Method: createShape(Ellipse)]
	
	var _element = [[new Ellipse(new Vector4(300, 300, 500, 350)), new Layer(3)],
					[6, c_blue]];
	_element[0][2] = _element[0][1].createParticleSystem();
	
	constructor = new ParticleType();
	constructor.createShape(_element[0][2], _element[0][0], _element[1][0]);
	constructor.createShape(_element[0][2], _element[0][0], _element[1][0], _element[1][1]);
	
	var _result = _element[0][2].getParticleCount();
	var _expectedValue = (_element[1][0] * 2);
	
	unitTest.assert_equal("Method: createShape(Ellipse)",
						  _result, _expectedValue);
	
	_element[0][2].clear();
	_element[0][1].destroy();
	constructor.destroy();
	
#endregion
#region [Test: Method: createShape(Line)]
	
	var _element = [[new Line(new Vector4(200, 225, 10, 25)), new Layer(4)],
					[10, c_red]];
	_element[0][2] = _element[0][1].createParticleSystem();
	
	constructor = new ParticleType();
	constructor.createShape(_element[0][2], _element[0][0], _element[1][0]);
	constructor.createShape(_element[0][2], _element[0][0], _element[1][0], _element[1][1]);
	
	var _result = _element[0][2].getParticleCount();
	var _expectedValue = (_element[1][0] * 2);
	
	unitTest.assert_equal("Method: createShape(Line)",
						  _result, _expectedValue);
	
	_element[0][2].clear();
	_element[0][1].destroy();
	constructor.destroy();
	
#endregion
#region [Test: Method: createShape(Rectangle)]
	
	var _element = [[new Rectangle(new Vector4(600, 700, 400, 450)), new Layer(5)],
					[29, c_yellow]];
	_element[0][2] = _element[0][1].createParticleSystem();
	
	constructor = new ParticleType();
	constructor.createShape(_element[0][2], _element[0][0], _element[1][0]);
	constructor.createShape(_element[0][2], _element[0][0], _element[1][0], _element[1][1]);
	
	var _result = _element[0][2].getParticleCount();
	var _expectedValue = (_element[1][0] * 2);
	
	unitTest.assert_equal("Method: createShape(Rectangle)",
						  _result, _expectedValue);
	
	_element[0][2].clear();
	_element[0][1].destroy();
	constructor.destroy();
	
#endregion
#region [Test: Method: createShape(Triangle)]
	
	var _element = [[new Triangle(new Vector2(700, 700), new Vector2(650, 800),
					 new Vector2(750, 800)), new Layer(6)],
					[23, c_yellow]];
	_element[0][2] = _element[0][1].createParticleSystem();
	
	constructor = new ParticleType();
	constructor.createShape(_element[0][2], _element[0][0], _element[1][0]);
	constructor.createShape(_element[0][2], _element[0][0], _element[1][0], _element[1][1]);
	
	var _result = _element[0][2].getParticleCount();
	var _expectedValue = (_element[1][0] * 2);
	
	unitTest.assert_equal("Method: createShape(Triangle)",
						  _result, _expectedValue);
	
	_element[0][2].clear();
	_element[0][1].destroy();
	constructor.destroy();
	
#endregion
#region [Test: Method: toString()]
	
	constructor = new ParticleType();
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName + "(" + "ID: " + string(constructor.ID) + ", " + "Shape: " +
						  "Pixel" + ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
	constructor.destroy();
	
#endregion
#region [Test: Method: toString(multiline?, full)]
	
	var _element = [["\n", ", "], ["color", "White", "None"]];
	
	constructor = new ParticleType();
	
	var _result = [constructor.toString(true, true), constructor.toString(false, true)];
	var _expectedValue = [];
	
	var _i = 0;
	repeat (array_length(_element[0]))
	{
		array_push(_expectedValue,
				   ("ID: " + string(constructor.ID) + _element[0][_i] +
					"Shape: " + "Pixel" + _element[0][_i] +
					"Sprite: " + string(undefined) + _element[0][_i] +
					"Sprite Animate: " + string(false) + _element[0][_i] +
					"Sprite Match Animation: " + string(false) + _element[0][_i] +
					"Sprite Randomize: " + string(false) + _element[0][_i] +
					"Scale: " + string(new Scale(1, 1)) + _element[0][_i] +
					"Size: " + string(1) + _element[0][_i] +
					"Size Increase: " + string(0) + _element[0][_i] +
					"Size Wiggle: " + string(0) + _element[0][_i] +
					"Speed: " + string(1) + _element[0][_i] +
					"Speed Increase: " + string(0) + _element[0][_i] +
					"Speed Wiggle: " + string(0) + _element[0][_i] +
					"Direction: " + string(new Angle(0)) + _element[0][_i] +
					"Direction Increase: " + string(0) + _element[0][_i] +
					"Direction Wiggle: " + string(0) + _element[0][_i] +
					"Angle: " + string(new Angle(0)) + _element[0][_i] +
					"Angle Increase: " + string(0) + _element[0][_i] +
					"Angle Wiggle: " + string(0) + _element[0][_i] +
					"Angle Relative: " + string(false) + _element[0][_i] +
					"Gravity Value: " + string(0) + _element[0][_i] +
					"Gravity Direction: " + string(undefined) + _element[0][_i] +
					"Color Type: " + _element[1][0] + _element[0][_i] +
					"Color: " + _element[1][1] + _element[0][_i] +
					"Blending: " + _element[1][2] + _element[0][_i] +
					"Alpha: " + string([1, undefined, undefined]) + _element[0][_i] +
					"Life: " + string(100) + _element[0][_i] +
					"Step Type: " + string(undefined) + _element[0][_i] +
					"Step Number: " + string(0) + _element[0][_i] +
					"Death Type: " + string(undefined) + _element[0][_i] +
					"Death Number: " + string(0)));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "(" + _expectedValue[1] + ")");
	
	unitTest.assert_equal("Method: toString(multiline?, full)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
	constructor.destroy();
	
#endregion
#region [Test: Events: beforeCreation / afterCreation]
	
	var _element = [[new Vector2(70, 55)], [new Layer(1)]];
	_element[1][1] = _element[1][0].createParticleSystem();
	
	constructor = new ParticleType();
	
	var _value = [256, 64];
	
	constructor = new ParticleType();
	
	var _result = [];
	
	constructor.event.beforeCreation.callback = function()
	{
		array_push(argument[0], argument[1]);
	}
	
	constructor.event.beforeCreation.argument = [_result, _value[0]];
	
	constructor.event.afterCreation.callback = function()
	{
		array_push(argument[0], (argument[0][(array_length(argument[0]) - 1)] + argument[1]));
	}
	
	constructor.event.afterCreation.argument = [_result, _value[1]];
	
	constructor.create(_element[1][1], _element[0][0]);
	
	var _expectedValue = [_value[0], (_value[0] + _value[1])];
	
	unitTest.assert_equal("Event: beforeCreation / afterCreation",
						  _result, _expectedValue);
	
	_element[1][1].destroy();
	constructor.destroy();
	
#endregion
