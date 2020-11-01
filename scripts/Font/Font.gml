/// @function				Font()
///
/// @description			Constructs a Font resource defining visual style of text rendering.
///
///							Construction methods:
///							- Wrapper: {font} font
///							- New Resource: {string} path, {int} size, {bool} bold, 
///											{bool} italic, {Range} glyphs, {bool} antialiasing
///							- Sprite (utf8): {Sprite} sprite, {int} first, {bool} proportional, 
///											 {int} separation, {bool} antialiasing
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
				
				if ((argument_count > 0) and (instanceof(argument[0]) == "Font"))
				{
					//|Construction method: Constructor copy.
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
						
						case "sprite (utf8)":
							self.construct(_other.sprite, _other.first, _other.proportional,
										   _other.separation, _other.antialiasing);
						break;
						
						case "sprite (glyph map)":
							self.construct(_other.sprite, _other.glyphs, _other.proportional,
										   _other.separation, _other.antialiasing);
						break;
					}
				}
				else
				{
					if ((is_real(argument[0])) and (font_exists(argument[0])))
					{
						//|Construction method: Wrapper.					
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
							//|Construction method: New resource.
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
						
							if (sprite_exists(_sprite.ID))
							{
								if (is_real(argument[1]))
								{
									//|Construction method: Sprite (utf8).
									type = "sprite (utf8)";
									
									sprite = _sprite.ID;
									first = argument[1];
									proportional = argument[2];
									separation = argument[3];
									antialiasing = argument[4];
									
									font_add_enable_aa(antialiasing);
									
									ID = font_add_sprite(sprite, first, proportional, separation);
									
									if ((is_real(ID)) and (font_exists(ID)))
									{
										assetName = font_get_name(ID);
										fontName = font_get_fontname(ID);
										size = font_get_size(ID);
									}
								}
								else if (is_string(argument[1]))
								{
									//|Construction method: Sprite (glyph map).
									type = "sprite (glyph map)";
									
									sprite = _sprite.ID;
									glyphs = argument[1];
									proportional = argument[2];
									separation = argument[3];
									antialiasing = argument[4];
									
									font_add_enable_aa(antialiasing);
									
									ID = font_add_sprite_ext(sprite, glyphs, proportional, 
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
			}
			
			// @argument			{bool} forceAssetDeletion
			// @returns				{undefined}
			// @description			Remove the internal information from the memory if this Font is
			//						not an asset Font or if is and the asset deletion was forced.
			//						A destroyed asset Font will be not accessible until the
			//						application is shut down and then restarted.
			static destroy = function(_forceAssetDeletion)
			{
				if ((is_real(ID)) and (font_exists(ID)) 
				and ((_forceAssetDeletion) or (type != "asset")))
				{
					font_delete(ID);
					
					ID = undefined;
				}
				
				return undefined;
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{ptr} | On error: {undefined}
			// @description			Get the pointer to this Font's texture page.
			//						Returns {undefined} if this Font does not exist.
			static getTexture = function()
			{
				return (((is_real(ID)) and (font_exists(ID))) ? font_get_texture(ID) : undefined);
			}
			
			// @returns				{Vector4} | On error: {undefined}
			// @description			Get the UV coordinates for this Font's location 
			//						on its texture page.
			//						Returns {undefined} if this Font does not exists.
			static getUVs = function()
			{
				if ((is_real(ID)) and (font_exists(ID)))
				{
					var _array = font_get_uvs(ID);
					
					return new Vector4(_array[0], _array[2], _array[1], _array[3]);
				}
				else
				{
					return undefined;
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} full?
			// @argument			{bool} multiline?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the Font name by default
			//						and can be configured to show the properties of this Font.
			static toString = function(_full, _multiline)
			{
				if ((is_real(ID)) and (font_exists(ID)))
				{
					if (!_full)
					{
						if (_multiline)
						{
							return ("Type: " + string(type) + "\n" +
									"Asset Name: " + font_get_name(ID) + "\n" +
									"Font Name: " + font_get_fontname(ID));
						}
						else
						{
							return (instanceof(self) + "(" + font_get_name(ID) + ")");
						}
					}
					else
					{
						var _mark_separator = ((_multiline) ? "\n" : ", ");
						
						var _string = instanceof(self);
						
						switch (type)
						{
							case "asset":
								_string += ("Type: " + type + _mark_separator +
											"Asset Name: " + font_get_name(ID) + _mark_separator +
											"Font Name: " + font_get_fontname(ID) + _mark_separator +
											"Size: " + string(font_get_size(ID)) + _mark_separator +
											"Bold: " + string(font_get_bold(ID)) + _mark_separator +
											"Italic: " + string(font_get_italic(ID)));
							break;
							
							case "file":
								_string += ("Type: " + type + _mark_separator +
											"Asset Name: " + font_get_name(ID) + _mark_separator +
											"Font Name: " + font_get_fontname(ID) + _mark_separator +
											"Size: " + string(font_get_size(ID)) + _mark_separator +
											"Bold: " + string(font_get_bold(ID)) + _mark_separator +
											"Italic: " + string(font_get_italic(ID))
													   + _mark_separator +
											"Glyphs: " + string(glyphs) + _mark_separator +
											"Antialiasing: " + string(antialiasing));
							break;
							
							case "sprite (utf8)":
								_string += ("Type: " + type + _mark_separator +
											"Asset Name: " + font_get_name(ID) + _mark_separator +
											"Font Name: " + font_get_fontname(ID) + _mark_separator +
											"Sprite: " + string(sprite) + _mark_separator +
											"First: " + string(first) + _mark_separator +
											"Proportional: " + string(proportional)
															 + _mark_separator +
											"Sepearation: " + string(separation) + _mark_separator +
											"Antialising: " + string(antialiasing));
							break;
							
							case "sprite (glyph map)":
								_string += ("Type: " + type + _mark_separator +
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
								return (_string + "<>");
							break;
						}
						
						return ((_multiline) ? _string : ("(" + _string + ")"));
					}
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
