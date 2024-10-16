//  @function				Arrow()
/// @argument				location {Vector4}
/// @argument				size? {real}
/// @argument				color? {int:color}
/// @argument				alpha? {real}
/// @description			Constructs an Arrow Shape, which is a line starting at x1y1 with a triangle
///							of the specified size at x2y2 pointing towards that location.
//							
//							Construction types:
//							- New constructor
//							- Empty: {void}
//							- Constructor copy: other {Arrow}
function Arrow() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				location = undefined;
				size = undefined;
				color = undefined;
				alpha = undefined;
				
				event =
				{
					beforeRender: new Callback(undefined, [], other),
					afterRender: new Callback(undefined, [], other)
				};
				
				if (argument_count > 0)
				{
					if (is_instanceof(argument[0], Arrow))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						location = ((is_instanceof(_other.location, Vector4))
									? new Vector4(_other.location) : _other.location);
						size = _other.size;
						color = _other.color;
						alpha = _other.alpha;
						
						if (is_struct(_other.event))
						{
							event.beforeRender.setAll(_other.event.beforeRender);
							event.afterRender.setAll(_other.event.afterRender);
						}
						else
						{
							event = _other.event;
						}
					}
					else
					{
						//|Construction type: New constructor.
						location = argument[0];
						size  = (((argument_count > 1) and (argument[1] != undefined)) ? argument[1]
																					   : 1);
						color = (((argument_count > 2) and (argument[2] != undefined)) ? argument[2] 
																					   : c_white);
						alpha = (((argument_count > 3) and (argument[3] != undefined)) ? argument[3]
																					   : 1);
					}
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(size)) and (is_real(color)) and (is_real(alpha)) and
						((is_instanceof(location, Vector4)) and (location.isFunctional())));
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			location? {Vector4}
			/// @argument			size? {real}
			/// @argument			color? {int:color}
			/// @argument			alpha? {real}
			/// @description		Execute the draw of this Shape as a form, using data of this
			///						constructor or its specified temporarily replaced parts.
			///						NOTE: Form drawing produces inconsistent results across devices
			///						and export targets due to their technical differences.
			///						Sprite drawing should be used instead for accurate results.
			static render = function(_location, _size, _color, _alpha)
			{
				var _location_original = location;
				var _size_original = size;
				var _color_original = color;
				var _alpha_original = alpha;
				
				location = (_location ?? location);
				size = (_size ?? size);
				color = (_color ?? color);
				alpha = (_alpha ?? alpha);
				
				try
				{
					if (self.isFunctional())
					{
						event.beforeRender.execute();
						
						if (alpha > 0)
						{
							draw_set_alpha(alpha);
							draw_set_color(color);
							draw_arrow(location.x1, location.y1, location.x2, location.y2, size);
						}
						
						event.afterRender.execute();
					}
					else
					{
						new ErrorReport().report([other, self, "render()"],
												 ("Attempted to render an invalid Shape: " +
												  "{" + string(self) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "render()"], _exception);
				}
				finally
				{
					location = _location_original;
					size = _size_original;
					color = _color_original;
					alpha = _alpha_original;
				}
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @argument			full? {bool}
			/// @argument			colorHSV? {bool}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented with the properties of this Shape.
			static toString = function(_multiline = false, _full = false, _colorHSV = false)
			{
				var _string = "";
				var _mark_separator = ((_multiline) ? "\n" : ", ");
				
				if (!_full)
				{
					_string = ("Location: " + string(location) + _mark_separator +
							   "Size: " + string(size));
				}
				else
				{
					var _string_color;
					var _mark_separator_inline = ", ";
					
					if (is_real(color))
					{
						switch (color)
						{
							case c_aqua: _string_color = "Aqua"; break;
							case c_black: _string_color = "Black"; break;
							case c_blue: _string_color = "Blue"; break;
							case c_dkgray: _string_color = "Dark Gray"; break;
							case c_fuchsia: _string_color = "Fuchsia"; break;
							case c_gray: _string_color = "Gray"; break;
							case c_green: _string_color = "Green"; break;
							case c_lime: _string_color = "Lime"; break;
							case c_ltgray: _string_color = "Light Gray"; break;
							case c_maroon: _string_color = "Maroon"; break;
							case c_navy: _string_color = "Navy"; break;
							case c_olive: _string_color = "Olive"; break;
							case c_orange: _string_color = "Orange"; break;
							case c_purple: _string_color = "Purple"; break;
							case c_red: _string_color = "Red"; break;
							case c_teal: _string_color = "Teal"; break;
							case c_white: _string_color = "White"; break;
							case c_yellow: _string_color = "Yellow"; break;
							default:
								if (_colorHSV)
								{
									_string_color =
									("(" +
									 "Hue: " + string(color_get_hue(color))
											 + _mark_separator_inline +
									 "Saturation: " + string(color_get_saturation(color)) + 
													_mark_separator_inline +
									 "Value: " + string(color_get_value(color)) +
									 ")");
								}
								else
								{
									_string_color =
									("(" +
									 "Red: " + string(color_get_red(color))
											 + _mark_separator_inline +
									 "Green: " + string(color_get_green(color))
											   + _mark_separator_inline +
									 "Blue: " + string(color_get_blue(color)) +
									 ")");
								}
							break;
						}
					}
					else
					{
						_string_color = string(color);
					}
					
					_string = ("Location: " + string(location) + _mark_separator +
							   "Size: " + string(size) + _mark_separator +
							   "Color: " + _string_color + _mark_separator +
							   "Alpha: " + string(alpha));
				}
				
				return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static constructor = Arrow;
		
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
