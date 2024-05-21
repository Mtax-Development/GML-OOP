/// @description Unit Testing
#region [Test: Construction: New constructor]
	
	var _base = [new Vector4(10, 20, 30.3, 400), 3, c_blue, 0.7];
	
	constructor = new Arrow(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = [constructor.location, constructor.size, constructor.color, constructor.alpha];
	var _expectedValue = [_base[0], _base[1], _base[2], _base[3]];
	
	unitTest.assert_equal("Construction: New constructor",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _base = [new Vector4(50, 50, 20, 10), 1, c_red, 1];
	
	constructor = [new Arrow(_base[0], _base[1], _base[2], _base[3])];
	constructor[1] = new Arrow(constructor[0]);
	
	var _result = [constructor[1].location, constructor[1].size, constructor[1].color,
				   constructor[1].alpha];
	var _expectedValue = [_base[0], _base[1], _base[2], _base[3]];
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Construction: Empty / Method: isFunctional()]
	
	var _base = [new Vector4(5, 5, 10, 5), 2, c_yellow, 1];
	
	constructor = [new Arrow(_base[0], _base[1], _base[2], _base[3]), new Arrow(_base[0]),
				   new Arrow()];
	constructor[3] = new Arrow(constructor[0]);
	constructor[4] = new Arrow(constructor[0]);
	constructor[4].location = undefined;
	constructor[5] = new Arrow(constructor[0]);
	constructor[5].size = undefined;
	constructor[6] = new Arrow(constructor[0]);
	constructor[6].color = undefined;
	constructor[7] = new Arrow(constructor[0]);
	constructor[7].alpha = undefined;
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional(),
				   constructor[2].isFunctional(), constructor[3].isFunctional(),
				   constructor[4].isFunctional(), constructor[5].isFunctional(),
				   constructor[6].isFunctional(), constructor[7].isFunctional()];
	var _expectedValue = [true, true, false, true, false, false, false, false];
	
	unitTest.assert_equal("Construction: Empty / Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5],
						  _result[6], _expectedValue[6],
						  _result[7], _expectedValue[7]);
	
#endregion
#region [Test: Method: render()]
	
	unitTest.assert_executable
	("Method: render()",
	 function()
	 {
		var _base = [new Vector4(1, 1, 10, 10), 3, c_green, 0.7897];
		
		constructor = new Arrow(_base[0], _base[1], _base[2], _base[3]);
		constructor.render();
	 }
	);
	
#endregion
#region [Test: Method: toString()]
	
	var _base = [new Vector4(5, 5, 10, 10), 2];
	
	constructor = new Arrow(_base[0], _base[1]);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName +
						  "(" +
						  "Location: " + string(_base[0]) + ", " +
						  "Size: " + string(_base[1]) +
						  ")");
	
	unitTest.assert_equal("Method: toString()",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(multiline?, full)]
	
	var _element = [[155, 222, 175], ["\n", ", "]];
	_element[2] = ["Purple", ("(" + "Red: " + string(_element[0][0]) + ", " + "Green: " +
				   string(_element[0][1]) + ", " + "Blue: " + string(_element[0][2]) + ")")];
	var _base = [new Vector4(5, 5, 100, 50), 2, c_purple,
				 make_color_rgb(_element[0][0], _element[0][1], _element[0][2]), 1];
	constructor = [new Arrow(_base[0], _base[1], _base[2], _base[4]),
				   new Arrow(_base[0], _base[1], _base[3], _base[4])];
	
	var _result = [constructor[0].toString(true, true), constructor[1].toString(false, true)];
	var _expectedValue = [];
	
	var _i = 0;
	repeat (array_length(_element[1]))
	{
		array_push(_expectedValue,
				   "Location: " + string(_base[0]) + _element[1][_i] +
				   "Size: " + string(_base[1]) + _element[1][_i] +
				   "Color: " + _element[2][_i] + _element[1][_i] +
				   "Alpha: " + string(_base[4]));
		
		++_i;
	}
	
	_expectedValue[1] = (constructorName + "(" + _expectedValue[1] + ")");
	
	unitTest.assert_equal("Method: toString(multiline?, full)",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
#endregion
#region [Test: Events: beforeRender / afterRender]
	
	var _base = [new Vector4(20, 20, 4, 400), 2, c_navy, 0.8];
	var _value = [1.55, 2.22];
	
	constructor = new Arrow(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = [];
	
	constructor.event.beforeRender.callback = function()
	{
		array_push(argument[0], argument[1]);
	}
	
	constructor.event.beforeRender.argument = [_result, _value[0]];
	
	constructor.event.afterRender.callback = function()
	{
		array_push(argument[0], (argument[0][(array_length(argument[0]) - 1)] + argument[1]));
	}
	
	constructor.event.afterRender.argument = [_result, _value[1]];
	
	constructor.render();
	
	var _expectedValue = [_value[0], (_value[0] + _value[1])];
	
	unitTest.assert_equal("Event: beforeRender / afterRender",
						  _result, _expectedValue);
	
#endregion
