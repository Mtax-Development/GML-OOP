//  @function				TextAlign()
/// @argument				x? {constant:fa_[halign]}
/// @argument				y? {constant:fa_[valign]}
/// @description			Constructs a container for two text alignment constants, used in text
///							rendering.
//							
//							Construction types:
//							- New constructor
//							   Unspecified values will be set to the following:
//							   x: fa_left
//							   y: fa_top
//							- From array: array {constant:textalign[]}
//							   The first array position will be set to the x property and the second
//							   array position will be set to y property.
//							- Constructor copy: other {TextAlign}
function TextAlign() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				x = fa_left;
				y = fa_top;
				
				if (argument_count > 0)
				{
					if (is_instanceof(argument[0], TextAlign))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						x = _other.x;
						y = _other.y;
					}
					else if (is_array(argument[0]))
					{
						//|Construction type: From array.
						var _array = argument[0];
						
						x = _array[0];
						y = _array[1];
					}
					else
					{
						//|Construction type: New constructor.
						x = ((argument[0] != undefined) ? argument[0] : fa_left);
						y = (((argument_count > 1) and (argument[1] != undefined)) ? argument[1]
																				   : fa_top);
					}
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return (((x == fa_left) or (x == fa_center) or (x == fa_right)) and ((y == fa_top)
						or (y == fa_middle) or (y == fa_bottom)));
			}
			
		#endregion
		#region <Getter>
			
			/// @argument			other {TextAlign}
			/// @returns			{bool}
			/// @description		Check if specified constructor has equivalent properties.
			static equals = function(_other)
			{
				return ((is_instanceof(_other, TextAlign)) and (x == _other.x) and (y == _other.y));
			}
			
			/// @returns			{Vector2} | On error: {undefined}
			/// @description		Return the multiplications of locations this alignment occupies
			///						within its possible area.
			static getMultiplier = function()
			{
				var _multiplier_x = undefined;
				var _multiplier_y = undefined;
				
				switch (x)
				{
					case fa_left: _multiplier_x = 0; break;
					case fa_center: _multiplier_x = 0.5; break;
					case fa_right: _multiplier_x = 1; break;
					default: return undefined; break;
				}
				
				switch (y)
				{
					case fa_top: _multiplier_y = 0; break;
					case fa_middle: _multiplier_y = 0.5; break;
					case fa_bottom: _multiplier_y = 1; break;
					default: return undefined; break;
				}
				
				return new Vector2(_multiplier_x, _multiplier_y);
			}
			
		#endregion
		#region <Setters>
			
			/// @description		Mirror the non-centered x and y values of the alignment.
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
				
				return self;
			}
			
			/// @description		Mirror the non-centered x value of the alignment.
			static mirrorX = function()
			{
				switch (x)
				{
					case fa_left: x = fa_right; break;
					case fa_right: x = fa_left; break;
				}
				
				return self;
			}
			
			/// @description		Mirror the non-centered y value of the alignment.
			static mirrorY = function()
			{
				switch (y)
				{
					case fa_top: y = fa_bottom; break;
					case fa_bottom: y = fa_top; break;
				}
				
				return self;
			}
			
			/// @description		Set the origin of horizontal alignment to the left of the text.
			static setXLeft = function()
			{
				x = fa_left;
				
				return self;
			}
			
			/// @description		Set the origin of horizontal alignment to the center of the text.
			static setXCenter = function()
			{
				x = fa_center;
				
				return self;
			}
			
			/// @description		Set the origin of horizontal alignment to the right of the text.
			static setXRight = function()
			{
				x = fa_right;
				
				return self;
			}
			
			/// @description		Set the origin of vertical alignment to the top of the text.
			static setYTop = function()
			{
				y = fa_top;
				
				return self;
			}
			
			/// @description		Set the origin of vertical alignment to the middle of the text.
			static setYMiddle = function()
			{
				y = fa_middle;
				
				return self;
			}
			
			/// @description		Set the origin of vertical alignment to the bottom of the text.
			static setYBottom = function()
			{
				y = fa_bottom;
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			/// @description		Use this Text Alignment for further text rendering.
			static setActive = function()
			{
				if (self.isFunctional())
				{
					draw_set_halign(x);
					draw_set_valign(y);
				}
				else
				{
					new ErrorReport().report([other, self, "setActive"],
											 ("Attempted to use invalid text alignment for " +
											  "rendering: " +
											  "{" + string(self) + "}"));
				}
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented with both of the text alignments.
			static toString = function(_multiline = false)
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
			
			/// @returns			{real[]}
			/// @description		Return an array containing all values of this Container.
			static toArray = function()
			{
				return [x, y];
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static constructor = TextAlign;
		
		static prototype = {};
		var _property = variable_struct_get_names(prototype);
		var _i = 0;
		repeat (array_length(_property))
		{
			var _name = _property[_i];
			var _value = variable_struct_get(prototype, _name);
			
			variable_struct_set(self, _name, ((is_method(_value)) ? method(self, _value) : _value));
			
			++_i;
		}
		
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
