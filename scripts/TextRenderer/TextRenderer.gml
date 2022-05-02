/// @function				TextRenderer()
/// @argument				{any:string} string
/// @argument				{Font} font
/// @argument				{Vector2} location
/// @argument				{TextAlign} align?
/// @argument				{int:color} color?
/// @argument				{real} alpha?
///							
/// @description			Constructs a handler information for string rendering.
///							
///							Construction types:
///							- New constructor
///							- Empty: {void|undefined}
///							- Constructor copy: {TextRenderer} other
function TextRenderer() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				ID = "";
				font = undefined;
				location = undefined;
				align = undefined;
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
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (instanceof(argument[0]) == "TextRenderer")
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						ID = _other.ID;
						font = ((instanceof(_other.font) == "Font") ? new Font(_other.font.ID)
																	: _other.font);
						location = ((instanceof(_other.location) == "Vector2")
									? new Vector2(_other.location) : _other.location);
						align = ((instanceof(_other.align) == "TextAlign")
								 ? new TextAlign(_other.align) : _other.align);
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
						//Construction type: New constructor.
						ID = string(argument[0]);
						font = ((argument_count > 1) ? argument[1] : undefined);
						location = ((argument_count > 2) ? argument[2] : undefined);
						align = (((argument_count > 3) and (argument[3] != undefined))
								 ? argument[3] : new TextAlign());
						color = (((argument_count > 4) and (argument[4] != undefined))
								 ? argument[4] : c_white);
						alpha = (((argument_count > 5) and (argument[5] != undefined))
								 ? argument[5] : 1);
					}
				}
				
				return self;
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(alpha)) and (instanceof(font) == "Font") and (font.isFunctional())
						and (instanceof(location) == "Vector2") and (location.isFunctional())
						and (instanceof(align) == "TextAlign") and (align.isFunctional()));
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{Vector4} | On error: {undefined}
			// @description			Return a boundry for the space the text occupies in pixels, offset
			//						from its origin.
			static getBoundaryOffset = function()
			{
				if ((instanceof(font) == "Font") and (font.isFunctional()))
				{
					var _string = string(ID);
					
					var _x1 = undefined;
					var _y1 = undefined;
					var _x2 = undefined;
					var _y2 = undefined;
					
					var _font_previous = draw_get_font();
					
					draw_set_font(font.ID);
					{
						var _size_x = string_width(_string);
						var _size_y = string_height(_string);
					}
					draw_set_font(_font_previous);
					
					switch (align.x)
					{
						case fa_left:
							_x1 = 0;
							_x2 = _size_x;
						break;
						
						case fa_center:
							var _size_x_half = (_size_x * 0.5);
						
							_x1 = (-_size_x_half);
							_x2 = _size_x_half;
						break;
						
						case fa_right:
							_x1 = (-_size_x);
							_x2 = 0;
						break;
					}
					
					switch (align.y)
					{
						case fa_top:
							_y1 = 0;
							_y2 = _size_y;
						break;
						
						case fa_middle:
							var _size_y_half = (_size_y * 0.5);
						
							_y1 = (-_size_y_half);
							_y2 = _size_y_half;
						break;
						
						case fa_bottom:
							_y1 = (-_size_y);
							_y2 = 0;
						break;
					}
					
					return new Vector4(_x1, _y1, _x2, _y2);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getBoundaryOffset";
					var _errorText = ("Attempted to get text size of a text renderer with an " +
									  "invalid font: " +
									  "{" + string(self) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{any:string} string?
			// @argument			{Font} font?
			// @argument			{Vector2} location?
			// @argument			{TextAlign} align?
			// @argument			{int:color} color?
			// @argument			{real} alpha?
			// @description			Execute the draw of the text, using data of this constructor or
			//						specified replaced parts of it for this call only.
			static render = function(_string, _font, _location, _align, _color, _alpha)
			{
				var _string_original = ID;
				var _font_original = font;
				var _location_original = location;
				var _align_original = align;
				var _color_original = color;
				var _alpha_original = alpha;
				
				ID = (_string ?? ID);
				font = (_font ?? font);
				location = (_location ?? location);
				align = (_align ?? align);
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
						draw_set_font(font.ID);
						draw_set_halign(align.x);
						draw_set_valign(align.y);
						draw_set_color(color);
						draw_set_alpha(alpha);
						
						draw_text(round(location.x), round(location.y), string(ID));
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
					var _errorText = ("Attempted to render through an invalid text renderer: " +
									  "{" + string(self) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				ID = _string_original;
				font = _font_original;
				location = _location_original;
				align = _align_original;
				color = _color_original;
				alpha = _alpha_original;
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @argument			{bool} full?
			// @argument			{bool} colorHSV?
			// @argument			{int|all} elementLength?
			// @argument			{string} mark_separator?
			// @argument			{string} mark_cut?
			// @argument			{string} mark_linebreak?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the text preview.
			static toString = function(_multiline = false, _full = false, _colorHSV = false,
									   _elementLength = 30, _mark_cut = "...", _mark_linebreak = ", ")
			{
				var _string = "";
				var _string_text = string(ID);
				
				var _mark_separator = ((_multiline) ? "\n" : ", ");
				var _mark_separator_inline = ", ";
				
				var _cutMark = "...";
				
				var _lengthLimit = 30;
				var _lengthLimit_cut = (_lengthLimit + string_length(_cutMark));
				
				if ((!_multiline) or (is_string(_mark_linebreak)))
				{
					if (!is_string(_mark_linebreak)) {_mark_linebreak = " "};
					
					_string_text = string_replace_all(_string_text, "\n", _mark_linebreak);
					_string_text = string_replace_all(_string_text, "\r", _mark_linebreak);
				}
				
				if ((_elementLength != all) and (string_length(_string_text) > _lengthLimit_cut))
				{
					_string_text = (string_copy(_string_text, 1, _lengthLimit) + _cutMark);
				}
				
				if (_full)
				{
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
							if (_colorHSV)
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
					
					_string = ("Text: " + _string_text + _mark_separator +
							   "Font: " + string(font) + _mark_separator +
							   "Location: " + string(location) + _mark_separator +
							   "Align: " + string(align) + _mark_separator +
							   "Color: " + string(_string_color) + _mark_separator +
							   "Alpha: " + string(alpha));
				}
				else
				{
					_string = _string_text;
				}
				
				return ((_multiline) ? _string : instanceof(self) + "(" + _string + ")");
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

