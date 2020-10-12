/// @function				TextAlign()
/// @function				TextAlign()
/// @argument				{constant:fa_[halign]} x?
/// @argument				{constant:fa_[valign]} y?
///
/// @description			Constructs a container for two Text Align contants, intended for use along
///							text drawing functions.
///
///							Construction methods:
///							- New constructor
///							   The unspecified values will be set to default, which are: 
///							   Left for horizontal align.
///							   Top for vertical align.
///							- Constructor copy: {TextAlign} other
function TextAlign() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				if ((argument_count > 0) and (instanceof(argument[0]) == "TextAlign"))
				{
					//|Construction method: Constructor copy.
					var _other = argument[0];
					
					x = _other.x;
					y = _other.y;
				}
				else
				{
					//|Construction method: New constructor.
					x = ((argument_count > 0) and (argument[0] != undefined) ? argument[0] : fa_left);
					y = ((argument_count > 1) and (argument[1] != undefined) ? argument[1] : fa_top);
				}
			}
			
		#endregion
		#region <Setters>
			
			// @description			Set the origin of horizontal align to the left of the text.
			static setX_left = function()
			{
				x = fa_left;
			}
			
			// @description			Set the origin of horizontal align to the center of the text.
			static setX_center = function()
			{
				x = fa_center;
			}
			
			// @description			Set the origin of horizontal align to the right of the text.
			static setX_right = function()
			{
				x = fa_right;
			}
			
			// @description			Set the origin of vertical align to the top of the text.
			static setY_top = function()
			{
				x = fa_top;
			}
			
			// @description			Set the origin of vertical align to the middle of the text.
			static setY_middle = function()
			{
				x = fa_middle;
			}
			
			// @description			Set the origin of vertical align to the bottom of the text.
			static setY_bottom = function()
			{
				x = fa_bottom;
			}
			
			// @description			Mirror the non-centered x value of the align.
			static mirror_x = function()
			{
				switch (x)
				{
					case fa_left:  self.x_setRight(); break;
					case fa_right: self.x_setLeft();  break;
				}
			}
			
			// @description			Mirror the non-centered y value of the align.
			static mirror_y = function()
			{
				switch (y)
				{
					case fa_top:	self.y_setBottom(); break;
					case fa_bottom: self.y_setTop();	break;
				}
			}
			
			// @description			Mirror the non-centered x/y values of the align.
			static mirror = function()
			{
				self.mirror_x();
				self.mirror_y();
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Create a string representing the constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the text equivalent of 
			//						the align constants.
			static toString = function()
			{
				var _string_x, _string_y;
				var _mark_separator = ", ";
				
				switch (x)
				{
					case fa_left:	_string_x = "Left";   break;
					case fa_center: _string_x = "Center"; break;
					case fa_right:	_string_x = "Right";  break;
					default:		_string_x = "ERROR!"; break;
				}
				
				switch (y)
				{
					case fa_top:	_string_y = "Top";	  break;
					case fa_middle: _string_y = "Middle"; break;
					case fa_bottom: _string_y = "Bottom"; break;
					default:		_string_y = "ERROR!"; break;
				}
				
				return (instanceof(self) + 
						"(" +
						"x: " + _string_x + _mark_separator +
						"y: " + _string_y +
						")");
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		argument_original = array_create(argument_count, undefined);
		
		var _i = 0;
		repeat (argument_count)
		{
			argument_original[_i] = argument[_i];
			
			++_i;
		}
		
		if (argument_count <= 0)
		{
			self.construct();
		}
		else
		{
			script_execute_ext(method_get_index(self.construct), argument_original);
		}
		
	#endregion
}
