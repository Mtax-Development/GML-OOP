/// @description Unit Testing
asset = [TestShader, "testFloat", "testInt", "testMat4", "testSampler2D"];

#region [Test: Construction: New constructor / Activation / Methods: isFunctional() / isActive()]
	
	var _element = [[asset[0]], [true, false]];
	
	constructor = new Shader(_element[0][0]);
	
	var _result = [constructor.isFunctional(), constructor.isActive()];
	var _expectedValue = [true, false];
	
	constructor.setActive(_element[1][0]);
	
	array_push(_result, constructor.isActive());
	array_push(_expectedValue, _element[1][0]);
	
	constructor.setActive(_element[1][1]);
	
	array_push(_result, constructor.isActive());
	array_push(_expectedValue, _element[1][1]);
	
	constructor.setActive();
	
	array_push(_result, constructor.isActive());
	array_push(_expectedValue, _element[1][0]);
	
	constructor.setActive();
	
	array_push(_result, constructor.isActive());
	array_push(_expectedValue, _element[1][1]);
	
	unitTest.assert_equal(("Construction: New constructor / Activation / Methods: isFunctional() / " +
						  "isActive()"),
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
#endregion
#region [Test: Construction: Constructor copy / Method: setUniform_float()]
	
	var _element = [[asset[0], asset[1], "float"], [0.4]];
	
	constructor = [new Shader(_element[0][0])];
	constructor[0].setActive();
	constructor[0].setUniform_float(_element[0][1], _element[1][0]);
	constructor[0].setActive();
	constructor[1] = new Shader(constructor[0]);
	
	var _result = [constructor[1].isFunctional(), constructor[1].ID, constructor[1].name,
				   constructor[1].compiled, constructor[1].uniform,
				   constructor[1].uniform.testFloat.value, constructor[1].uniform.testFloat.type,
				   (constructor[1].uniform.testFloat.value >= 0)];
	var _expectedValue = [true, constructor[0].ID, constructor[0].name, constructor[0].compiled,
						  constructor[0].uniform, _element[1][0], _element[0][2], true];
	
	unitTest.assert_equal("Construction: Constructor copy / Method: setUniform_float()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6],
						  _result[7], _expectedValue[7]);
	
#endregion
#region [Test: Method: setUniform_int()]
	
	var _element = [[asset[0], asset[2], "int"], [8]];
	
	constructor = new Shader(_element[0][0]);
	constructor.setActive();
	constructor.setUniform_int(_element[0][1], _element[1][0]);
	constructor.setActive();
	
	var _result = [constructor.uniform.testInt.value, constructor.uniform.testInt.type,
				   (constructor.uniform.testInt.value >= 0)];
	var _expectedValue = [_element[1][0], _element[0][2], true];
	
	unitTest.assert_equal("Method: setUniform_int()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Method: setUniform_matrix()] NOT TESTED
	
	var _element = [asset[0], asset[3], "matrix"];
	
	constructor = new Shader(_element[0]);
	constructor.setActive();
	constructor.setUniform_matrix(_element[1]);
	constructor.setActive();
	
	var _result = constructor.uniform.testMat4.type;
	var _expectedValue = _element[2];
	
	unitTest.assert_equal("Method: setUniform_matrix()",
						  _result, _expectedValue)
	
#endregion
#region [Test: Method: getSampler()]
	
	var _element = [[asset[0], asset[4]]];
	
	constructor = new Shader(_element[0][0]);
	constructor.setActive();
	_element[1][0] = constructor.getSampler(_element[0][1]);
	constructor.setActive();
	
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
