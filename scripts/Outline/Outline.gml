/// @function				Outline
/// @argument				{real} size
/// @argument				{color|Color3|Color4} color?
/// @argument				{real} alpha?
/// @argument				{real} spacing?
///
/// @description			Construct a container for information about Outline drawing for shapes.
function Outline(_size, _color, _alpha, _spacing) constructor
{
	size	 = _size;
	color	 = ((_color != undefined) ? _color : c_white);
	alpha	 = ((_alpha != undefined) ? _alpha : 1);
	spacing  = ((_spacing != undefined) ? _spacing : 1);
}
