/// @description Unit Testing
asset = [TestShader, "testFloat", "testInt", "testMat4", "testSampler2D"];

#region [Test: Construction: New constructor / Activation / Methods: isFunctional() / isActive()]
	
	var _element = [[asset[0]], [true, false]];
	
	constructor = new Shader(_element[0][0]);
	
	var _result = [constructor.isFunctional()];
	var _expectedValue = [true];
	
	constructor.setActive(_element[1][0]);
	
	array_push(_result, constructor.isActive());
	array_push(_expectedValue, _element[1][0]);
	
	constructor.setActive(_element[1][1]);
	
	array_push(_result, constructor.isActive());
	array_push(_expectedValue, _element[1][1]);
	
	unitTest.assert_equal(("Construction: New constructor / Activation / Methods: isFunctional() / " +
						  "isActive()"),
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Construction: Constructor copy / Method: setUniformFloat()]
	
	var _element = [[asset[0], asset[1], "float"], [0.4]];
	
	constructor = [new Shader(_element[0][0])];
	constructor[0].setActive(true);
	constructor[0].setUniformFloat(_element[0][1], _element[1][0]);
	constructor[0].setActive(false);
	constructor[1] = new Shader(constructor[0]);
	
	var _result = [constructor[1].isFunctional(), constructor[1].ID, constructor[1].name,
				   constructor[1].compiled, constructor[1].uniform,
				   constructor[1].uniform.testFloat.value, constructor[1].uniform.testFloat.type,
				   (constructor[1].uniform.testFloat.value >= 0)];
	var _expectedValue = [true, constructor[0].ID, constructor[0].name, constructor[0].compiled,
						  constructor[0].uniform, _element[1][0], _element[0][2], true];
	
	unitTest.assert_equal("Construction: Constructor copy / Method: setUniformFloat()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6],
						  _result[7], _expectedValue[7]);
	
#endregion
#region [Test: Method: setUniformInt()]
	
	var _element = [[asset[0], asset[2], "int"], [8]];
	
	constructor = new Shader(_element[0][0]);
	constructor.setActive(true);
	constructor.setUniformInt(_element[0][1], _element[1][0]);
	constructor.setActive(false);
	
	var _result = [constructor.uniform.testInt.value, constructor.uniform.testInt.type,
				   (constructor.uniform.testInt.value >= 0)];
	var _expectedValue = [_element[1][0], _element[0][2], true];
	
	unitTest.assert_equal("Method: setUniformInt()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: setUniformMatrix()]
	
	var _element = [asset[0], asset[3], "matrix"];
	
	constructor = new Shader(_element[0]);
	constructor.setActive(true);
	constructor.setUniformMatrix(_element[1]);
	constructor.setActive(false);
	
	var _result = constructor.uniform.testMat4.type;
	var _expectedValue = _element[2];
	
	unitTest.assert_equal("Method: setUniformMatrix()",
						  _result, _expectedValue)
	
#endregion
#region [Test: Method: getSampler()]
	
	var _element = [[asset[0], asset[4]]];
	
	constructor = new Shader(_element[0][0]);
	constructor.setActive(true);
	_element[1][0] = constructor.getSampler(_element[0][1]);
	constructor.setActive(false);
	
	var _result = [constructor.sampler.testSampler2D.handle, (_element[1][0] >= 0)];
	var _expectedValue = [_element[1][0], true];
	
	unitTest.assert_equal("Method: getSampler()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: toString()]
	
	var _element = asset[0];
	
	constructor = new Shader(_element);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName + "(" + shader_get_name(_element) +
						  ((shader_is_compiled(_element)) ? "" : " (uncompiled)") + ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(multiline)]
	
	var _element = asset[0];
	
	constructor = new Shader(_element);
	
	var _result = constructor.toString(true);
	var _expectedValue = ("Name: " + shader_get_name(_element) + "\n" +
						  "Compiled: " + string(shader_is_compiled(_element)));
	
	unitTest.assert_equal("Method: toString(multiline)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Events: beforeActivation / afterActivation / beforeDeactivation / afterDeactivation]
	
	var _element = asset[0];
	var _value = [26, 1.5, 23, 186];
	
	constructor = new Shader(_element);
	
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
	
	constructor.event.beforeDeactivation.callback = function(_argument)
	{
		array_push(_argument[0], (_argument[0][(array_length(_argument[0]) - 1)] + _argument[1]));
	}
	
	constructor.event.beforeDeactivation.argument = [_result, _value[2]];
	
	constructor.event.afterDeactivation.callback = function(_argument)
	{
		array_push(_argument[0], (_argument[0][(array_length(_argument[0]) - 1)] + _argument[1]));
	}
	
	constructor.event.afterDeactivation.argument = [_result, _value[3]];
	
	constructor.setActive(true).setActive(false);
	
	var _expectedValue = [_value[0], (_value[0] + _value[1]), (_value[0] + _value[1] + _value[2]),
						  (_value[0] + _value[1] + _value[2] + _value[3])];
	
	unitTest.assert_equal("Event: beforeActivation / afterActivation / beforeDeactivation / " +
						  "afterDeactivation",
						  _result, _expectedValue);
	
#endregion
