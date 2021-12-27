/// @argument			{Sprite} sprite?
/// @argument			{Vector2} location?
/// @argument			{int} frame?
/// @argument			{Scale} scale?
/// @argument			{Angle} angle?
/// @argument			{int:color} color?
/// @argument			{real} alpha?
///						
/// @description		Construct a handler storing information for Sprite rendering.
///						
///						Construction types:
///						- New constructor
///						- Empty: {void}
///						- Constructor copy: {SpriteDraw} other
function SpriteDraw() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				sprite = undefined;
				location = undefined;
				frame = undefined;
				scale = undefined;
				angle = undefined;
				color = undefined;
				alpha = undefined;
				
				event =
				{
					beforeRender:
					{
						callback: undefined,
						argument: undefined
					},
					
					afterRender:
					{
						callback: undefined,
						argument: undefined
					}
				};
				
				if (argument_count > 0)
				{
					if (instanceof(argument[0]) == "SpriteDraw")
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						sprite = ((instanceof(_other.sprite) == "Sprite")
								  ? new Sprite(_other.sprite.ID) : _other.sprite);
						location = ((instanceof(_other.location) == "Vector2")
									? new Vector2(_other.location) : _other.location);
						frame = _other.frame;
						scale = ((instanceof(_other.scale) == "Scale") ? new Scale(_other.scale)
																	   : _other.scale);
						angle = ((instanceof(_other.angle) == "Angle") ? new Angle(_other.angle)
																	   : _other.angle);
						color = _other.color;
						alpha = _other.alpha;
						
						if (is_struct(_other.event))
						{
							event.beforeRender.callback = _other.event.beforeRender.callback;
							event.beforeRender.argument = _other.event.beforeRender.argument;
							event.afterRender.callback = _other.event.afterRender.callback;
							event.afterRender.argument = _other.event.afterRender.argument;
						}
						else
						{
							event = _other.event;
						}
					}
					else
					{
						//|Construction type: New constructor.
						sprite = argument[0];
						location = ((argument_count > 1) ? argument[1] : undefined);
						frame = (((argument_count > 2) and (argument[2] != undefined)) ? argument[2]
																					   : 0);
						scale = (((argument_count > 3) and (argument[3] != undefined))
								 ? argument[3] : new Scale(1, 1));
						angle = (((argument_count > 4) and (argument[4] != undefined))
								 ? argument[4] : new Angle(0));
						color = (((argument_count > 5) and (argument[5] != undefined)) ? argument[5]
																					   : c_white);
						alpha = (((argument_count > 6) and (argument[6] != undefined)) ? argument[6]
																					   : 1);
					}
				}
				
				return self;
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((instanceof(sprite) == "Sprite") and (sprite.isFunctional())
						and (instanceof(location) == "Vector2") and (location.isFunctional())
						and (is_real(frame)) and (instanceof(scale) == "Scale")
						and (scale.isFunctional()) and (instanceof(angle) == "Angle")
						and (angle.isFunctional()) and (is_real(color)) and (is_real(alpha)));
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{Sprite} sprite?
			// @argument			{Vector2} location?
			// @argument			{int} frame?
			// @argument			{Scale} scale?
			// @argument			{Angle} angle?
			// @argument			{int:color} color?
			// @argument			{real} alpha?
			// @description			Execute the draw, using data of this constructor or specified
			//						replaced parts of it for this call only.
			static render = function(_sprite, _location, _frame, _scale, _angle, _color, _alpha)
			{
				var _sprite_original = sprite;
				var _location_original = location;
				var _frame_original = frame;
				var _scale_original = scale;
				var _angle_original = angle;
				var _color_original = color;	
				var _alpha_original = alpha;
				
				sprite = (_sprite ?? sprite);
				location = (_location ?? location);
				frame = (_frame ?? frame);
				scale = (_scale ?? scale);
				angle = (_angle ?? angle);
				color = (_color ?? color);
				alpha = (_alpha ?? alpha);
				
				if (self.isFunctional())
				{
					if ((is_struct(event))) and (is_method(event.beforeRender.callback))
					{
						script_execute_ext(method_get_index(event.beforeRender.callback),
										   ((is_array(event.beforeRender.argument)
											? event.beforeRender.argument
											: [event.beforeRender.argument])));
					}
					
					sprite.render(location, frame, scale, angle, color, alpha);
					
					if ((is_struct(event))) and (is_method(event.afterRender.callback))
					{
						script_execute_ext(method_get_index(event.afterRender.callback),
										   ((is_array(event.afterRender.argument)
											? event.afterRender.argument
											: [event.afterRender.argument])));
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "render";
					var _errorText = ("Attempted to render through an invalid Sprite renderer: " +
									  "{" + string(self) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				sprite = _sprite_original;
				location = _location_original;
				frame = _frame_original;
				scale = _scale_original;
				angle = _angle_original;
				color = _color_original;
				alpha = _alpha_original;
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @argument			{bool} full?
			// @argument			{bool} color_HSV?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the properties of this
			//						constructor.
			static toString = function(_multiline = false, _full = false, _color_HSV = false)
			{
				var _string = "";
				var _mark_separator = ((_multiline) ? "\n" : ", ");
				
				if (_full)
				{
					var _mark_separator_inline = ", ";
						
					var _string_color;
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
							if (_color_HSV)
							{
								_string_color = 
								("(" +
								 "Hue: " + string(color_get_hue(color))
								 		 + _mark_separator_inline +
								 "Saturation: " + string(color_get_saturation(color))
								 	 			+ _mark_separator_inline +
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
					
					_string = ("Sprite: " + string(sprite) + _mark_separator +
								"Location: " + string(location) + _mark_separator +
								"Frame: " + string(frame) + _mark_separator +
								"Scale: " + string(scale) + _mark_separator +
								"Angle: " + string(angle) + _mark_separator +
								"Color: " + _string_color + _mark_separator +
								"Alpha: " + string(alpha));
				}
				else
				{
					_string = ("Sprite: " + string(sprite) + _mark_separator +
							   "Location: " + string(location));
				}
				
				return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
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
