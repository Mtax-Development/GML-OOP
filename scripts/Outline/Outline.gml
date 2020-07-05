/// @function				Outline
/// @argument				{real} size
/// @argument				{color | Color3 | Color4} color?
/// @argument				{real} alpha?
/// @argument				{real} spacing?
///
/// @description			Construct a container for information about Outline drawing for shapes.
function Outline(_size) constructor
{
	size	 = _size;
	color	 = (argument_count >= 2 ? argument[1] : c_white);
	alpha	 = (argument_count >= 3 ? argument[2] : 1);
	spacing  = (argument_count >= 4 ? argument[3] : 1);
}
