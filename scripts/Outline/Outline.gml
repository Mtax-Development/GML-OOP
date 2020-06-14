/// @function				Outline
/// @argument				size {int}
/// @argument				color? {color}
/// @argument				alpha? {real}
///
/// @description			Construct a container for information
///							about outline drawing for shapes.
function Outline(_size) constructor
{
	size	 = _size;
	color	 = (argument_count >= 2 ? argument[1] : c_white);
	alpha	 = (argument_count >= 3 ? argument[2] : 1);
}
