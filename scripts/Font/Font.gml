/// @function				Font()
///							
/// @description			Constructs a Font resource defining glyphs used in text rendering.
///							
///							Construction types:
///							- Wrapper: {int:font} font
///							- File: {string:path} path, {int} size, {bool} bold, {bool} italic,
///									{Range} glyphs, {bool} antialiasing
///							- Sprite (UTF-8): {Sprite} sprite, {int} first, {bool} proportional, 
///											  {int} separation, {bool} antialiasing
///							- Sprite (glyph map): {Sprite} sprite, {string} glyphs, 
///												  {bool} proportional, {int} separation, 
///												  {bool} antialiasing
///							- Constructor copy: {Font} other
function Font() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				ID = undefined;
				type = string(undefined);
				assetName = string(undefined);
				fontName = string(undefined);
				sprite = undefined;
				size = undefined;
				bold = undefined;
				italic = undefined;
				first = undefined;
				glyphs = undefined;
				antialiasing = undefined;
				proportional = undefined;
				separation = undefined;
				
				event =
				{
					beforeActivation:
					{
						callback: undefined,
						argument: undefined
					},
					
					afterActivation:
					{
						callback: undefined,
						argument: undefined
					}
				};
				
				if ((argument_count > 0) and (instanceof(argument[0]) == "Font"))
				{
					//|Construction type: Constructor copy.
					var _other = argument[0];
					
					switch (_other.type)
					{
						case "asset":
							self.construct(_other.ID);
						break;
						
						case "file":
							self.construct(_other.fontName, _other.size, _other.bold,
										   _other.italic, _other.glyphs, _other.antialiasing);
						break;
						
						case "sprite (UTF-8)":
							sprite = ((instanceof(_other.sprite) == "Sprite") ? new Sprite(_other.ID)
																			  : _other.sprite);
							
							self.construct(sprite, _other.first, _other.proportional,
										   _other.separation, _other.antialiasing);
						break;
						
						case "sprite (glyph map)":
							sprite = ((instanceof(_other.sprite) == "Sprite") ? new Sprite(_other.ID)
																			  : _other.sprite);
							
							self.construct(sprite, _other.glyphs, _other.proportional,
										   _other.separation, _other.antialiasing);
						break;
						
						if (is_struct(_other.event))
						{
							event.beforeActivation.callback = _other.event.beforeActivation
																		  .callback;
							event.beforeActivation.argument = _other.event.beforeActivation
																		  .argument;
							event.afterActivation.callback = _other.event.afterActivation.callback;
							event.afterActivation.argument = _other.event.afterActivation.argument;
						}
						else
						{
							event = _other.event;
						}
					}
				}
				else
				{
					if ((is_real(argument[0])) and (font_exists(argument[0])))
					{
						//|Construction type: Wrapper.
						type = "asset";
						
						ID = argument[0];
						
						assetName = font_get_name(ID);
						fontName = font_get_fontname(ID);
						size = font_get_size(ID);
						bold = font_get_bold(ID);
						italic = font_get_italic(ID);
					}
					else
					{
						if (is_string(argument[0]))
						{
							//|Construction type: File.
							type = "file";
							
							fontName = argument[0];
							size = argument[1];
							bold = argument[2];
							italic = argument[3];
							glyphs = argument[4];
							antialiasing = argument[5];
							
							font_add_enable_aa(antialiasing);
							
							ID = font_add(fontName, size, bold, italic, glyphs.minimum, 
										  glyphs.maximum);
							
							if ((is_real(ID)) and (font_exists(ID)))
							{
								assetName = font_get_name(ID);
							}
						}
						else
						{
							var _sprite = argument[0];
							
							if (_sprite.isFunctional())
							{
								if (is_real(argument[1]))
								{
									//|Construction type: Sprite (UTF-8).
									type = "sprite (UTF-8)";
									
									sprite = _sprite;
									first = argument[1];
									proportional = argument[2];
									separation = argument[3];
									antialiasing = argument[4];
									
									font_add_enable_aa(antialiasing);
									
									ID = font_add_sprite(sprite.ID, first, proportional, separation);
									
									if ((is_real(ID)) and (font_exists(ID)))
									{
										assetName = font_get_name(ID);
										fontName = font_get_fontname(ID);
										size = font_get_size(ID);
									}
								}
								else if (is_string(argument[1]))
								{
									//|Construction type: Sprite (glyph map).
									type = "sprite (glyph map)";
									
									sprite = _sprite;
									glyphs = argument[1];
									proportional = argument[2];
									separation = argument[3];
									antialiasing = argument[4];
									
									font_add_enable_aa(antialiasing);
									
									ID = font_add_sprite_ext(sprite.ID, glyphs, proportional,
															 separation);
									
									if ((is_real(ID)) and (font_exists(ID)))
									{
										assetName = font_get_name(ID);
										fontName = font_get_fontname(ID);
										size = font_get_size(ID);
									}
								}
							}
						}
					}
				}
				
				return self;
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (font_exists(ID)));
			}
			
			// @argument			{bool} forceAssetDeletion
			// @returns				{undefined}
			// @description			Remove the internal information from the memory if this Font is
			//						not an asset Font or if is and the asset deletion was forced.
			//						A destroyed asset Font will be remain unusable until the
			//						application is completely shut down and then restarted.
			static destroy = function(_forceAssetDeletion = false)
			{
				if ((is_real(ID)) and (font_exists(ID)) and ((_forceAssetDeletion)
				or (type != "asset")))
				{
					font_delete(ID);
					
					ID = undefined;
				}
				
				return undefined;
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{pointer}
			// @description			Get the pointer to texture page of this Font.
			static getTexture = function()
			{
				if ((is_real(ID)) and (font_exists(ID)))
				{
					return font_get_texture(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getTexture";
					var _errorText = ("Attempted to get a property of an invalid Font: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return pointer_invalid;
				}
			}
			
			// @returns				{Vector2} | On error: {undefined}
			// @description			Get the texel size of the texture page of this Font.
			static getTexelSize = function()
			{
				if ((is_real(ID)) and (font_exists(ID)))
				{
					var _texture = font_get_texture(ID);
					
					return new Vector2(texture_get_texel_width(_texture),
									   texture_get_texel_height(_texture));
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getTexelSize";
					var _errorText = ("Attempted to get a property of an invalid Font: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{Vector4} | On error: {undefined}
			// @description			Get the UV coordinates for this location of this Font on its
			//						texture page.
			static getUV = function()
			{
				if ((is_real(ID)) and (font_exists(ID)))
				{
					var _array = font_get_uvs(ID);
					
					return new Vector4(_array[0], _array[1], _array[2], _array[3]);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getUV";
					var _errorText = ("Attempted to get a property of an invalid Font: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{bool}
			// @description			Check if this Font is currently used for drawing.
			static isActive = function()
			{
				if ((is_real(ID)) and (font_exists(ID)))
				{
					return (draw_get_font() == ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "isActive";
					var _errorText = ("Attempted to get a property of an invalid Font: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return false;
				}
			}
			
		#endregion
		#region <Execution>
			
			// @description			Use this Font for further text rendering.
			static setActive = function()
			{
				if ((is_real(ID)) and (font_exists(ID)))
				{
					if ((is_struct(event))) and (is_method(event.beforeActivation.callback))
					{
						script_execute_ext(method_get_index(event.beforeActivation.callback),
										   ((is_array(event.beforeActivation.argument)
											? event.beforeActivation.argument
											: [event.beforeActivation.argument])));
					}
					
					draw_set_font(ID);
					
					if ((is_struct(event))) and (is_method(event.afterActivation.callback))
					{
						script_execute_ext(method_get_index(event.afterActivation.callback),
										   ((is_array(event.afterActivation.argument)
											? event.afterActivation.argument
											: [event.afterActivation.argument])));
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setActive";
					var _errorText = ("Attempted to use an invalid Font: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @argument			{bool} full?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the properties of this Font.
			static toString = function(_multiline = false, _full = false)
			{
				if ((is_real(ID)) and (font_exists(ID)))
				{
					var _string = "";
					var _mark_separator = ((_multiline) ? "\n" : ", ");
					
					if (!_full)
					{
						_string = font_get_name(ID);
					}
					else
					{
						switch (type)
						{
							case "asset":
								_string = ("Type: " + string(type) + _mark_separator +
										   "Asset Name: " + font_get_name(ID) + _mark_separator +
										   "Font Name: " + font_get_fontname(ID) + _mark_separator +
										   "Size: " + string(font_get_size(ID)) + _mark_separator +
										   "Bold: " + string(font_get_bold(ID)) + _mark_separator +
										   "Italic: " + string(font_get_italic(ID)));
							break;
							
							case "file":
								_string = ("Type: " + string(type) + _mark_separator +
										   "Asset Name: " + font_get_name(ID) + _mark_separator +
										   "Font Name: " + font_get_fontname(ID) + _mark_separator +
										   "Size: " + string(font_get_size(ID)) + _mark_separator +
										   "Bold: " + string(font_get_bold(ID)) + _mark_separator +
										   "Italic: " + string(font_get_italic(ID))
													  + _mark_separator +
										   "Glyphs: " + string(glyphs) + _mark_separator +
										   "Antialiasing: " + string(antialiasing));
							break;
							
							case "sprite (UTF-8)":
								_string = ("Type: " + string(type) + _mark_separator +
										   "Asset Name: " + font_get_name(ID) + _mark_separator +
										   "Font Name: " + font_get_fontname(ID) + _mark_separator +
										   "Sprite: " + string(sprite) + _mark_separator +
										   "First: " + string(first) + _mark_separator +
										   "Proportional: " + string(proportional)
															+ _mark_separator +
										   "Separation: " + string(separation) + _mark_separator +
										   "Antialising: " + string(antialiasing));
							break;
							
							case "sprite (glyph map)":
								_string = ("Type: " + string(type) + _mark_separator +
										   "Asset Name: " + font_get_name(ID) + _mark_separator +
										   "Font Name: " + font_get_fontname(ID) + _mark_separator +
										   "Sprite: " + string(sprite) + _mark_separator +
										   "Glyphs: " + string(glyphs) + _mark_separator +
										   "Proportional: " + string(proportional) 
										   					+ _mark_separator +
										   "Sepearation: " + string(separation) + _mark_separator +
										   "Antialising: " + string(antialiasing));
							break;
							
							default:
								_string = font_get_name(ID);
							break;
						}
					}
					
					return ((_multiline) ? _string : instanceof(self) + "(" + _string + ")");
				}
				else
				{
					return (instanceof(self) + "<>");
				}
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
