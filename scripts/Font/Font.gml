//  @function				Font()
/// @description			Constructs a Font resource defining glyphs used in text rendering.
//							
//							Construction types:
//							- Wrapper: font {int:font}
//							- From file: path {string:path}, size {int}, bold {bool}, italic {bool},
//										 glyphs {Range}, antialiasing? {bool},
//										 signedDistanceFieldSpread? {int}
//							- Sprite (UTF-8): sprite {Sprite}, first {int}, proportional {bool},
//											  separation {int}, antialiasing? {bool}
//							- Sprite (glyph map): sprite {Sprite}, glyphs {string},
//												  proportional {bool}, separation {int},
//												  antialiasing? {bool}
//							- Empty: {void|undefined}
//							- Constructor copy: other {Font}
function Font() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
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
				signedDistanceField = undefined;
				signedDistanceFieldSpread = undefined;
				
				event =
				{
					beforeActivation: new Callback(undefined, [], other),
					afterActivation: new Callback(undefined, [], other),
				};
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (is_instanceof(argument[0], Font))
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
								sprite = ((is_instanceof(_other.sprite, Sprite))
										  ? new Sprite(_other.sprite) : _other.sprite);
								
								self.construct(sprite, _other.first, _other.proportional,
											   _other.separation, _other.antialiasing);
							break;
							case "sprite (glyph map)":
								sprite = ((is_instanceof(_other.sprite, Sprite))
										  ? new Sprite(_other.sprite) : _other.sprite);
								
								self.construct(sprite, _other.glyphs, _other.proportional,
											   _other.separation, _other.antialiasing);
							break;
						}
						
						if (is_struct(_other.event))
						{
							event.beforeActivation.setAll(_other.event.beforeActivation);
							event.afterActivation.setAll(_other.event.afterActivation);
						}
						else
						{
							event = _other.event;
						}
					}
					else if ((is_handle(argument[0])) and (font_exists(argument[0])))
					{
						//|Construction type: Wrapper.
						type = "asset";
						ID = argument[0];
						assetName = font_get_name(ID);
						fontName = font_get_fontname(ID);
						size = font_get_size(ID);
						bold = font_get_bold(ID);
						italic = font_get_italic(ID);
						signedDistanceField = font_get_sdf_enabled(ID);
						
						if (signedDistanceField)
						{
							signedDistanceFieldSpread = font_get_sdf_spread(ID);
						}
					}
					else if (is_string(argument[0]))
					{
						//|Construction type: From file.
						type = "file";
						fontName = argument[0];
						size = argument[1];
						bold = argument[2];
						italic = argument[3];
						glyphs = argument[4];
						antialiasing = (((argument_count > 5) and (argument[5] != undefined))
										? argument[5] : false);
						signedDistanceFieldSpread = (((argument_count > 6) and
													 (argument[6] != 0)) ? argument[6] : undefined);
						signedDistanceField = false;
						
						font_add_enable_aa(antialiasing);
						ID = font_add(fontName, size, bold, italic, glyphs.minimum, glyphs.maximum);
						
						if (self.isFunctional())
						{
							assetName = font_get_name(ID);
							
							if (signedDistanceFieldSpread != undefined)
							{
								signedDistanceFieldSpread = clamp(signedDistanceFieldSpread, 2, 32);
								font_enable_sdf(ID, true);
								font_sdf_spread(ID, signedDistanceFieldSpread);
								signedDistanceField = true;
							}
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
								antialiasing = (((argument_count > 4) and (argument[4] != undefined))
												? argument[4] : false);
								
								font_add_enable_aa(antialiasing);
								ID = font_add_sprite(sprite.ID, first, proportional, separation);
								
								if (self.isFunctional())
								{
									assetName = font_get_name(ID);
									fontName = font_get_fontname(ID);
									size = font_get_size(ID);
									signedDistanceField = false;
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
								antialiasing = (((argument_count > 4) and (argument[4] != undefined))
												? argument[4] : false);
								signedDistanceField = false;
								
								font_add_enable_aa(antialiasing);
								ID = font_add_sprite_ext(sprite.ID, glyphs, proportional, separation);
								
								if (self.isFunctional())
								{
									assetName = font_get_name(ID);
									fontName = font_get_fontname(ID);
									size = font_get_size(ID);
									signedDistanceField = false;
								}
							}
						}
					}
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_handle(ID)) and (font_exists(ID)));
			}
			
			/// @argument			forceAssetDeletion {bool}
			/// @returns			{undefined}
			/// @description		Remove the internal information from the memory if this Font is
			///						not an asset Font or if is and the asset deletion was forced.
			///						A destroyed asset Font will be remain unusable until the
			///						application is completely shut down and then restarted.
			static destroy = function(_forceAssetDeletion = false)
			{
				if ((self.isFunctional()) and ((_forceAssetDeletion) or (type != "asset")))
				{
					font_delete(ID);
					
					ID = undefined;
				}
				
				return undefined;
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			other {Font}
			/// @returns			{bool}
			/// @description		Check if the specified constructor uses the same resource.
			static equals = function(_other)
			{
				return ((is_instanceof(_other, Font)) and (ID == _other.ID));
			}
			
			/// @returns			{pointer}
			/// @description		Get the pointer to texture page of this Font.
			static getTexture = function()
			{
				try
				{
					return font_get_texture(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getTexture()"], _exception);
				}
				
				return pointer_invalid;
			}
			
			/// @returns			{Vector2} | On error: {undefined}
			/// @description		Get the texel size of the texture page of this Font.
			static getTexel = function()
			{
				try
				{
					var _texture = font_get_texture(ID);
					
					return new Vector2(texture_get_texel_width(_texture),
									   texture_get_texel_height(_texture));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getTexel()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{Vector4} | On error: {undefined}
			/// @description		Get the UV coordinates for this location of this Font on its
			///						texture page.
			static getUV = function()
			{
				try
				{
					var _array = font_get_uvs(ID);
					
					return new Vector4(_array[0], _array[1], _array[2], _array[3]);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getUV()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{bool}
			/// @description		Check if this Font is currently used for drawing.
			static isActive = function()
			{
				try
				{
					return (draw_get_font() == ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "isActive()"], _exception);
				}
				
				return false;
			}
			
		#endregion
		#region <Execution>
			
			/// @description		Use this Font for further text rendering.
			static setActive = function()
			{
				if (self.isFunctional())
				{
					event.beforeActivation.execute();
					draw_set_font(ID);
					event.afterActivation.execute();
				}
				else
				{
					new ErrorReport().report([other, self, "setActive()"], _exception);
				}
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @argument			full? {bool}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented with the properties of this Font.
			static toString = function(_multiline = false, _full = false)
			{
				if (self.isFunctional())
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
										   "Italic: " + string(font_get_italic(ID))
													  + _mark_separator +
										   "Signed Distance Field Spread: " +
										   string(signedDistanceFieldSpread));
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
										   "Antialiasing: " + string(antialiasing)
															+ _mark_separator +
										   "Signed Distance Field Spread: " +
										   string(signedDistanceFieldSpread));
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
		
		static constructor = Font;
		
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
