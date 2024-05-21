/// @description Unit Testing
#region [Test: Construction: Two colors]
	
	var _base = [c_red, c_lime];
	
	constructor = new Color2(_base[0], _base[1]);
	
	var _result = [constructor.color1, constructor.color2];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: Two colors",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Construction: Default for all values]
	
	constructor = new Color2();
	
	var _result = [constructor.color1, constructor.color2];
	var _expectedValue = [c_white, c_white];
	
	unitTest.assert_equal("Construction: Default values",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Construction: One color for all values]
	
	var _base = c_navy;
	
	constructor = new Color2(_base);
	
	var _result = [constructor.color1, constructor.color2];
	var _expectedValue = [_base, _base];
	
	unitTest.assert_equal("Construction: One color for all values",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _base = [c_green, c_ltgray];
	
	constructor = [new Color2(_base[0], _base[1])];
	constructor[1] = new Color2(constructor[0]);
	
	var _result = [constructor[1].color1, constructor[1].color2];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: isFunctional()]
	
	constructor = [new Color2(), new Color2()];
	constructor[1].color1 = undefined;
	
	var _result = [constructor[0].isFunctional(), constructor[1].isFunctional()];
	var _expectedValue = [true, false];
	
	unitTest.assert_equal("Method: isFunctional()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: reverse()]
	
	var _base = [c_red, c_green];
	
	constructor = new Color2(_base[0], _base[1]);
	constructor.reverse();
	
	var _result = [constructor.color1, constructor.color2];
	var _expectedValue = [_base[1], _base[0]];
	
	unitTest.assert_equal("Method: reverse()",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1]);
	
#endregion
#region [Test: Method: toString(color constants)]
	
	var _base = [c_blue, c_green];
	
	constructor = new Color2(_base[0], _base[1]);
	
	var _result = constructor.toString();
	var _expectedValue = (constructorName + "(" + "Blue" + ", " + "Green" + ")");
	
	unitTest.assert_equal("Method: toString(Color constants)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(custom RGB colors)]
	
	var _base = [[0, 79, 255], [33, 21, 125]];
	
	constructor = new Color2(make_color_rgb(_base[0][0], _base[0][1], _base[0][2]),
							 make_color_rgb(_base[1][0], _base[1][1], _base[1][2]));
	
	var _result = constructor.toString(false, false);
	var _expectedValue = (constructorName + "(" +
						  "(" + 
						  "Red: " + string(_base[0][0]) + ", " +
						  "Green: " + string(_base[0][1]) + ", " +
						  "Blue: " + string(_base[0][2]) +
						  ")" + ", " +
						  "(" + 
						  "Red: " + string(_base[1][0]) + ", " +
						  "Green: " + string(_base[1][1]) + ", " +
						  "Blue: " + string(_base[1][2]) +
						  ")" + ")");
	
	unitTest.assert_equal("Method: toString(Custom RGB colors)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(custom HSV colors)]
	
	var _base = [make_color_hsv(19, 67, 255), make_color_hsv(255, 172, 14)];
	var _value = [[color_get_hue(_base[0]), color_get_saturation(_base[0]), 
				  color_get_value(_base[0])], [color_get_hue(_base[1]), 
				  color_get_saturation(_base[1]), color_get_value(_base[1])]];
	
	constructor = new Color2(_base[0], _base[1]);
	
	var _result = constructor.toString(false, true);
	var _expectedValue = (constructorName + "(" +
						  "(" + 
						  "Hue: " + string(_value[0][0]) + ", " +
						  "Saturation: " + string(_value[0][1]) + ", " +
						  "Value: " + string(_value[0][2]) +
						  ")" + ", " +
						  "(" + 
						  "Hue: " + string(_value[1][0]) + ", " +
						  "Saturation: " + string(_value[1][1]) + ", " +
						  "Value: " + string(_value[1][2]) +
						  ")" + ")");
	
	unitTest.assert_equal("Method: toString(Custom HSV colors)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(multiline, custom RGB colors)]
	
	var _base = [[0, 79, 255], [33, 21, 125]];
	
	constructor = new Color2(make_color_rgb(_base[0][0], _base[0][1], _base[0][2]),
							 make_color_rgb(_base[1][0], _base[1][1], _base[1][2]));
	
	var _result = constructor.toString(true, false);
	var _expectedValue = ("(" + 
						  "Red: " + string(_base[0][0]) + ", " +
						  "Green: " + string(_base[0][1]) + ", " +
						  "Blue: " + string(_base[0][2]) +
						  ")" + "\n" +
						  "(" + 
						  "Red: " + string(_base[1][0]) + ", " +
						  "Green: " + string(_base[1][1]) + ", " +
						  "Blue: " + string(_base[1][2]) +
						  ")");
	
	unitTest.assert_equal("Method: toString(Multiline, custom RGB colors)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(multiline, custom HSV colors)]
	
	var _base = [make_color_hsv(19, 67, 255), make_color_hsv(255, 172, 14)];
	var _value = [[color_get_hue(_base[0]), color_get_saturation(_base[0]), 
				  color_get_value(_base[0])], [color_get_hue(_base[1]), 
				  color_get_saturation(_base[1]), color_get_value(_base[1])]];
	
	constructor = new Color2(_base[0], _base[1]);
	
	var _result = constructor.toString(true, true);
	var _expectedValue = ("(" + 
						  "Hue: " + string(_value[0][0]) + ", " +
						  "Saturation: " + string(_value[0][1]) + ", " +
						  "Value: " + string(_value[0][2]) +
						  ")" + "\n" +
						  "(" + 
						  "Hue: " + string(_value[1][0]) + ", " +
						  "Saturation: " + string(_value[1][1]) + ", " +
						  "Value: " + string(_value[1][2]) +
						  ")");
	
	unitTest.assert_equal("Method: toString(Multiline, custom HSV colors)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toArray()]
	
	var _base = [make_color_hsv(2, 5, 209), make_color_hsv(155, 125, 99)];
	
	constructor = new Color2(_base[0], _base[1]);
	
	var _result = constructor.toArray();
	var _expectedValue = _base;
	
	unitTest.assert_equal("Method: toArray()",
						  _result, _expectedValue);
	
#endregion
