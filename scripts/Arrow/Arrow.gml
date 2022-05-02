/// @function				Arrow()
/// @argument				{Vector4} location
/// @argument				{real} size?
/// @argument				{int:color} color?
/// @argument				{real} alpha?
///							
/// @description			Constructs an Arrow Shape, which is a Line starting at x1y1 with a
///							Triangle of the specified size at x2y2 pointing towards that location.
///							
///							Construction types:
///							- New constructor.
///							- Empty: {void}
///							- Constructor copy: {Arrow} other
function Arrow() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				location = undefined;
				size = undefined;
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
					if (instanceof(argument[0]) == "Arrow")
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						location = ((instanceof(_other.location) == "Vector4")
									? new Vector4(_other.location) : _other.location);
						size = _other.size;
						color = _other.color;
						alpha = _other.alpha;
						
						if (is_struct(_other.event))
						{
							event = {};
							
							var _eventList = variable_struct_get_names(_other.event);
							
							var _i = [0, 0];
							repeat (array_length(_eventList))
							{
								var _event = {};
								var _other_event = variable_struct_get(_other.event,
																	   _eventList[_i[0]]);
								var _eventPropertyList = variable_struct_get_names(_other_event);
								
								_i[1] = 0;
								repeat (array_length(_eventPropertyList))
								{
									var _property = variable_struct_get(_other_event,
																		_eventPropertyList[_i[1]]);
									
									var _value = _property;
									
									if (is_array(_property))
									{
										_value = [];
										
										array_copy(_value, 0, _property, 0, array_length(_property));
									}
									
									variable_struct_set(_event, _eventPropertyList[_i[1]], _value);
									
									++_i[1];
								}
								
								variable_struct_set(event, _eventList[_i[0]], _event);
								
								++_i[0];
							}
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
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(size)) and (is_real(color)) and (is_real(alpha)) and
						((instanceof(location) == "Vector4") and (location.isFunctional())));
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{Vector4} location?
			// @argument			{real} size?
			// @argument			{int:color} color?
			// @argument			{real} alpha?
			// @description			Execute the draw of this Shape as a form, using data of this
			//						constructor or specified replaced parts of it for this call only.
			//						NOTE: Form drawing produces inconsistent results across devices
			//						and export targets due to their technical differences.
			//						Sprite drawing should be used instead for accurate results.
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
				
				if (self.isFunctional())
				{
					if ((is_struct(event)) and (event.beforeRender.callback != undefined))
					{
						var _callback = ((is_array(event.beforeRender.callback))
										 ? event.beforeRender.callback
										 : [event.beforeRender.callback]);
						var _callback_count = array_length(_callback);
						var _argument = ((is_array(event.beforeRender.argument))
										 ? event.beforeRender.argument
										 : array_create(_callback_count,
														event.beforeRender.argument));
						
						var _i = 0;
						repeat (_callback_count)
						{
							if (is_method(_callback[_i]))
							{
								script_execute_ext(method_get_index(_callback[_i]),
												   ((is_array(_argument[_i]) ? _argument[_i]
																			 : [_argument[_i]])));
							}
							
							++_i;
						}
					}
					
					if (alpha > 0)
					{
						draw_set_alpha(alpha);
						draw_set_color(color);
						
						draw_arrow(round(location.x1), round(location.y1), round(location.x2),
								   round(location.y2), size);
					}
					
					if ((is_struct(event)) and (event.afterRender.callback != undefined))
					{
						var _callback = ((is_array(event.afterRender.callback))
										 ? event.afterRender.callback : [event.afterRender.callback]);
						var _callback_count = array_length(_callback);
						var _argument = ((is_array(event.afterRender.argument))
										 ? event.afterRender.argument
										 : array_create(_callback_count, event.afterRender.argument));
						
						var _i = 0;
						repeat (_callback_count)
						{
							if (is_method(_callback[_i]))
							{
								script_execute_ext(method_get_index(_callback[_i]),
												   ((is_array(_argument[_i]) ? _argument[_i]
																			 : [_argument[_i]])));
							}
							
							++_i;
						}
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "render";
					var _errorText = ("Attempted to render an invalid Shape: " +
									  "{" + string(self) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				location = _location_original;
				size = _size_original;
				color = _color_original;
				alpha = _alpha_original;
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @argument			{bool} full?
			// @argument			{bool} colorHSV?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the properties of this Shape.
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

