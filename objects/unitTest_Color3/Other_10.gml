/// @description Unit Test

#region [Test: Construction: Three colors]
	
	var _base = [c_red, c_lime, c_black];
	
	constructor = new Color3(_base[0], _base[1], _base[2]);
	
	var _result = [constructor.color1, constructor.color2, constructor.color3];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: Three colors",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: Construction: Default values]
	
	constructor = new Color3();
	
	var _result = [constructor.color1, constructor.color2, constructor.color3];
	var _expectedValue = c_white;
	
	unitTest.assert_equal("Construction: Default values",
						  _result[0], _expectedValue,
						  _result[1], _expectedValue,
						  _result[2], _expectedValue);
	
#endregion
#region [Test: Construction: One color for all values]
	
	var _base = c_navy;
	
	constructor = new Color3(_base);
	
	var _result = [constructor.color1, constructor.color2, constructor.color3];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: One color for all values",
						  _result[0], _expectedValue,
						  _result[1], _expectedValue,
						  _result[2], _expectedValue);
	
#endregion
#region [Test: Construction: Color2 + color]
	
	var _base = [[c_red, c_green], c_blue];
	
	constructor_other = new Color2(_base[0][0], _base[0][1]);
	
	constructor = [new Color2(_base[0][0], _base[0][1])];
	constructor[1] = [new Color3(constructor[0], _base[1]),
					  new Color3(_base[1], constructor[0])];
	
	var _result = [constructor[1][0].color1, constructor[1][0].color2, constructor[1][0].color3,
				   constructor[1][1].color1, constructor[1][1].color2, constructor[1][1].color3];
	var _expectedValue = [_base[0][0], _base[0][1], _base[1], _base[1], _base[0][0], _base[0][1]];
	
	unitTest.assert_equal("Construction: Color2 + color",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3],
						  _result[4], _expectedValue[4],
						  _result[5], _expectedValue[5]);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _base = [c_green, c_ltgray, c_dkgray];
	
	constructor = [new Color3(_base[0], _base[1], _base[2])];
	constructor[1] = new Color3(constructor[0]);
	
	var _result = [constructor[1].color1, constructor[1].color2, constructor[1].color3];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2]);
	
#endregion
#region [Test: String Conversion: Built-in colors]
	
	var _base = [c_blue, c_green, c_red];
	
	constructor = new Color3(_base[0], _base[1], _base[2]);
	
	var _result = string(constructor);
	var _expectedValue = (constructorName + "(" + "Blue" + ", " + "Green" + ", " + "Red" + ")");
	
	unitTest.assert_equal("String Conversion: Built-in colors",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(Custom RGB colors)]
	
	var _base = [[0, 79, 255], [33, 21, 125], [68, 1, 0]];
	
	constructor = new Color3(make_color_rgb(_base[0][0], _base[0][1], _base[0][2]),
							 make_color_rgb(_base[1][0], _base[1][1], _base[1][2]),
							 make_color_rgb(_base[2][0], _base[2][1], _base[2][2]));
	
	var _result = constructor.toString(false);
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
						  ")" + ", " +
						  "(" +
						  "Red: " + string(_base[2][0]) + ", " +
						  "Green: " + string(_base[2][1]) + ", " +
						  "Blue: " + string(_base[2][2]) +
						  ")" + ")");
	
	unitTest.assert_equal("Method: toString(Custom RGB colors)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(Custom HSV colors)]
	
	var _base = [make_color_hsv(19, 67, 255), make_color_hsv(255, 172, 14), 
				 make_color_hsv(25, 255, 2)];
	var _element = [[color_get_hue(_base[0]), color_get_saturation(_base[0]), 
					color_get_value(_base[0])], [color_get_hue(_base[1]), 
					color_get_saturation(_base[1]), color_get_value(_base[1])],
					[color_get_hue(_base[2]), color_get_saturation(_base[2]), 
					color_get_value(_base[2])]];
	
	constructor = new Color3(_base[0], _base[1], _base[2]);
	
	var _result = constructor.toString(true);
	var _expectedValue = (constructorName + "(" +
						"(" + 
						"Hue: " + string(_element[0][0]) + ", " +
						"Saturation: " + string(_element[0][1]) + ", " +
						"Value: " + string(_element[0][2]) +
						")" + ", " +
						"(" + 
						"Hue: " + string(_element[1][0]) + ", " +
						"Saturation: " + string(_element[1][1]) + ", " +
						"Value: " + string(_element[1][2]) +
						")" + ", " +
						"(" +
						"Hue: " + string(_element[2][0]) + ", " +
						"Saturation: " + string(_element[2][1]) + ", " +
						"Value: " + string(_element[2][2]) +
						")" + ")");
	
	unitTest.assert_equal("String Conversion: Custom HSV colors",
						  _result, _expectedValue);
	
#endregion
