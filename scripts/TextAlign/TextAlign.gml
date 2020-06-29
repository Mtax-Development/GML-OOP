/// @function				TextAlign()
/// @argument				x? {halign}
/// @argument				y? {valign}
///
/// @description			Constructs a two-value Text Align container, ready
///							to be used with text draw-related code, as well as
///							manipulated using its own functions.
function TextAlign() constructor
{
	#region [Methods]
		
		// @description			Set the properites using x/y-separated functions.
		static x_setLeft   = function() {x = fa_left;}
		static x_setCenter = function() {x = fa_center;}
		static x_setRight  = function() {x = fa_right;}
		
		static y_setTop    = function() {y = fa_top;}
		static y_setMiddle = function() {y = fa_middle;}
		static y_setBottom = function() {y = fa_bottom;}
		
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
	#region [Constructor]
	
		x = (argument_count >= 1 ? argument[0] : fa_left);
		y = (argument_count >= 2 ? argument[1] : fa_top);
	
	#endregion
}
