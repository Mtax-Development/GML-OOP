/// @function				TextAlign()
/// @argument				{constant:fa_[halign]} x?
/// @argument				{constant:fa_[valign]} y?
///							
/// @description			Constructs a container for two Text Align contants, intended for use in
///							text drawing.
///							
///							Construction methods:
///							- New constructor
///							   Unspecified values will be set to the following:
///							   x: fa_left
///							   y: fa_top
///							- Constructor copy: {TextAlign} other
function TextAlign() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				x = fa_left;
				y = fa_top;
				
				if (argument_count > 0)
				{
					if (instanceof(argument[0]) == "TextAlign")
					{
						//|Construction method: Constructor copy.
						var _other = argument[0];
					
						x = _other.x;
						y = _other.y;
					}
					else
					{
						//|Construction method: New constructor.
						x = ((argument[0] != undefined) ? argument[0] : fa_left);
						y = ((argument_count > 1) and (argument[1] != undefined) ? argument[1] : fa_top);
					}
				}
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return (((x == fa_left) or (x == fa_center) or (x == fa_right)) and ((y == fa_top)
						or (y == fa_middle) or (y == fa_bottom)));
			}
			
		#endregion
		#region <Setters>
			
			// @description			Set the origin of horizontal align to the left of the text.
			static setXLeft = function()
			{
				x = fa_left;
			}
			
			// @description			Set the origin of horizontal align to the center of the text.
			static setXCenter = function()
			{
				x = fa_center;
			}
			
			// @description			Set the origin of horizontal align to the right of the text.
			static setXRight = function()
			{
				x = fa_right;
			}
			
			// @description			Set the origin of vertical align to the top of the text.
			static setYTop = function()
			{
				y = fa_top;
			}
			
			// @description			Set the origin of vertical align to the middle of the text.
			static setYMiddle = function()
			{
				y = fa_middle;
			}
			
			// @description			Set the origin of vertical align to the bottom of the text.
			static setYBottom = function()
			{
				y = fa_bottom;
			}
			
			// @description			Mirror the non-centered x and y values of the align.
			static mirror = function()
			{
				switch (x)
				{
					case fa_left: x = fa_right; break;
					case fa_right: x = fa_left; break;
				}
				
				switch (y)
				{
					case fa_top: y = fa_bottom; break;
					case fa_bottom: y = fa_top; break;
				}
			}
			
			// @description			Mirror the non-centered x value of the align.
			static mirrorX = function()
			{
				switch (x)
				{
					case fa_left: x = fa_right; break;
					case fa_right: x = fa_left; break;
				}
			}
			
			// @description			Mirror the non-centered y value of the align.
			static mirrorY = function()
			{
				switch (y)
				{
					case fa_top: y = fa_bottom; break;
					case fa_bottom: y = fa_top; break;
				}
			}
			
		#endregion
		#region <Execution>
			
			// @description			Use this Text Align for further text rendering.
			static setActive = function()
			{
				draw_set_halign(x);
				draw_set_valign(y);
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the text equivalent of 
			//						the align constants.
			static toString = function(_multiline)
			{
				var _string_x, _string_y;
				var _mark_separator = ((_multiline) ? "\n" : ", ");
				
				switch (x)
				{
					case fa_left: _string_x = "Left"; break;
					case fa_center: _string_x = "Center"; break;
					case fa_right: _string_x = "Right"; break;
					default: _string_x = string(x); break;
				}
				
				switch (y)
				{
					case fa_top: _string_y = "Top"; break;
					case fa_middle: _string_y = "Middle"; break;
					case fa_bottom: _string_y = "Bottom"; break;
					default: _string_y = string(y) break;
				}
				
				var _string = ("x: " + _string_x + _mark_separator + "y: " + _string_y);
				
				return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
			}
			
			// @returns				{real[]}
			// @description			Return an array containing all values of this Container.
			static toArray = function()
			{
				return [x, y];
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
		
		script_execute_ext(method_get_index(self.construct), argument_original);
		
	#endregion
}
