/// @description Unit Test

#region [Test: Construction: New constructor]
	
	var _base = [3, c_navy, 0.789, 2];
	
	constructor = new Outline(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = [constructor.size, constructor.color, constructor.alpha, constructor.spacing];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: New constructor",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Construction: Default values]
	
	constructor = new Outline();
	
	var _result = [constructor.size, constructor.color, constructor.alpha, constructor.spacing];
	var _expectedValue = [1, c_white, 1, 0];
	
	unitTest.assert_equal("Construction: Default values",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: Construction: Constructor copy]
	
	var _base = [3, make_color_rgb(127, 22, 17), 0.90255667, 1];
	
	constructor = [new Outline(_base[0], _base[1], _base[2], _base[3])];
	constructor[1] = new Outline(constructor[0]);
	
	var _result = [constructor[1].size, constructor[1].color, constructor[1].alpha,
				   constructor[1].spacing];
	var _expectedValue = _base;
	
	unitTest.assert_equal("Construction: Constructor copy",
						  _result[0], _expectedValue[0],
						  _result[1], _expectedValue[1],
						  _result[2], _expectedValue[2],
						  _result[3], _expectedValue[3]);
	
#endregion
#region [Test: String conversion: Built-in color]
	
	var _base = [4, c_green, 1, 0];
	
	constructor = new Outline(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = string(constructor);
	var _expectedValue = (constructorName +
						  "(" + 
						  "Size: " + string(_base[0]) + ", " +
						  "Color: " + "Green" + ", " +
						  "Alpha: " + string(_base[2]) + ", " +
						  "Spacing: " + string(_base[3]) +
						  ")");
	
	unitTest.assert_equal("String conversion: Built-in color",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(Custom RGB color)]
	
	var _base = [5, make_color_rgb(2, 5, 7), 0.8, 2];
	var _element = [color_get_red(_base[1]), color_get_green(_base[1]), color_get_blue(_base[1])];
	
	constructor = new Outline(_base[0], _base[1], _base[2], _base[3]);
	
	var _result = constructor.toString(false);
	var _expectedValue = (constructorName +
						  "(" + 
						  "Size: " + string(_base[0]) + ", " +
						  "Color: " +
							("(" +
							"Red: " + string(_element[0]) + ", " +
							"Green: " + string(_element[1]) + ", " +
							"Blue: " + string(_element[2]) +
							")") + ", " +
						  "Alpha: " + string(_base[2]) + ", " +
						  "Spacing: " + string(_base[3]) +
						  ")");
	
	unitTest.assert_equal("Method: toString(Custom RGB color)",
						  _result, _expectedValue);
	
#endregion
#region [Test: Method: toString(Custom HSV color)]
	
	var _base = [4, make_color_hsv(12, 35, 99), 0.75, 2];
	var _element = [color_get_hue(_base[1]), color_get_saturation(_base[1]),
					color_get_value(_base[1])];
	
	var _expectedValue = (constructorName +
						  "(" + 
						  "Size: " + string(_base[0]) + ", " +
						  "Color: " +
							("(" +
							 "Hue: " + string(_element[0]) + ", " +
							 "Saturation: " + string(_element[1]) + ", " +
							 "Value: " + string(_element[2]) +
							 ")") + ", " +
						  "Alpha: " + string(_base[2]) + ", " +
						  "Spacing: " + string(_base[3]) +
						  ")");
	
	constructor = new Outline(_base[0], _base[1], _base[2], _base[3]);
	
	unitTest.assert_equal("Method: toString(Custom HSV color)",
						  constructor.toString(true), _expectedValue);
	
#endregion
