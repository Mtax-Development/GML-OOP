/// @function				Font()
/// @description			Constructs a Font resource for use in text rendering.
///
///							Construction methods:
///							Existing Resource: {font} font
///							New Resource: {string} path, {int} size, {bool} bold, 
///										  {bool} italic, {Range} glyphs, 
///										  {bool} antialiasing?
///							Sprite (utf8): {Sprite} sprite, {int} first,
///										   {bool} proportional, {int} separation, 
///										   {bool} antialiasing?
///							Sprite (glyph map): {Sprite} sprite, {string} glyphs,
///												{bool} proportional, {int} separation, 
///												{bool} antialiasing?
function Font() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				type		 = string(undefined);
				assetName	 = string(undefined);
				fontName	 = string(undefined);
				sprite		 = undefined;
				size		 = undefined;
				bold		 = undefined;
				italic		 = undefined;
				first		 = undefined;
				glyphs		 = undefined;
				antialiasing = undefined;
				proportional = undefined;
				separation	 = undefined;
				
				if (argument_count == 1)
				{
					if (font_exists(argument[0]))
					{
						//|Construction method: Existing resource.
						
						type = "asset";
						
						ID = argument[0];
						
						assetName = font_get_name(ID);
						fontName = font_get_fontname(ID);
						size = font_get_size(ID);
						bold = font_get_bold(ID);
						italic = font_get_italic(ID);
					}
				}
				else
				{
					if (is_string(argument[0]))
					{
						//|Construction method: New resource.
						
						type = "file";
						
						assetName = argument[1];
						fontName = argument[0];
						size = argument[1];
						bold = (((argument_count > 2) and (argument[2] != undefined)) ? 
							   argument[2] : false);
						italic = (((argument_count > 3) and (argument[3] != undefined)) ? 
							   argument[3] : false);
						glyphs = (((argument_count > 4) and (argument[4] != undefined)) ? 
								 argument[4] : undefined);
						antialiasing = (((argument_count > 5) and (argument[5] != undefined)) ? 
								 argument[5] : true);
						
						var _glyphs_minimum, _glyphs_maximum;
						
						if (glyphs != undefined)
						{
							_glyphs_minimum = glyphs.minimum;
							_glyphs_maximum = glyphs.maximum;
						}
						else
						{
							_glyphs_minimum = 0;
							_glyphs_maximum = 0;
						}
						
						font_add_enable_aa(antialiasing);
						
						ID = font_add(fontName, size, bold, italic, _glyphs_minimum, _glyphs_maximum);
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
								antialiasing = (((argument_count > 4) 
											   and (argument[4] != undefined)) ? argument[4] : true);
								
								font_add_enable_aa(antialiasing);
								
								ID = font_add_sprite(sprite, first, proportional, separation);
								
								if (font_exists(ID))
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
								glyphMap = argument[1];
								proportional = argument[2];
								separation = argument[3];
								antialiasing = (((argument_count > 4) 
											   and (argument[4] != undefined)) ? argument[4] : true);
								
								font_add_enable_aa(antialiasing);
								
								ID = font_add_sprite_ext(sprite, glyphMap, proportional, separation);
								
								if (font_exists(ID))
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
			
			// @returns				{undefined}
			// @description			Remove the internal Font information from the memory if 
			//						it is not an asset font or asset deletion was forced.
			static destroy = function(_forceAssetDeletion)
			{
				if (_forceAssetDeletion == undefined) {_forceAssetDeletion = false;}
				
				if ((font_exists(ID)) and ((_forceAssetDeletion) or (type != "asset")))
				{
					font_delete(ID);
				}
				
				return undefined;
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{ptr|undefined}
			// @description			Get the pointer to this Font's texture page.
			//						Returns {undefined} if this Font does not exist.
			static getTexture = function()
			{
				return ((font_exists(ID)) ? font_get_texture(ID) : undefined);
			}
			
			// @returns				{Vector4|undefined}
			// @description			Get the UV coordinates for this Font's location 
			//						on its texture page.
			//						Returns {undefined} if this Font does not exist.
			static getUVs = function()
			{
				if (font_exists(ID))
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
			
			// @returns				{string}
			// @description			Overrides the string conversion with a name output.
			static toString = function()
			{
				return ((font_exists(ID)) ? fontName : string(undefined));
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		originalArgumentCount = argument_count;
		
		if (originalArgumentCount == 1)
		{
			//|Construction method: Existing resource.
			
			originalArguments = 
			{
				font: argument[0]
			}
			
			with (originalArguments)
			{
				other.construct(font);
			}
		}
		else if (is_string(argument[0]))
		{
			//|Construction method: New resource.
			
			originalArguments =
			{
				path: argument[0],
				size: argument[1],
				bold: argument[2],
				italic: argument[3]
			}
			
			switch (originalArgumentCount)
			{				
				case 4:
					with (originalArguments)
					{
						other.construct(path, size, bold, italic);
					}
				break;
				
				case 5:
					originalArguments.glyphs = argument[4];
					
					with (originalArguments)
					{
						other.construct(path, size, bold, italic, glyphs);
					}
				break;
				
				case 6:
					originalArguments.glyphs = argument[4];
					originalArguments.antialiasing = argument[5];
					
					with (originalArguments)
					{
						other.construct(path, size, bold, italic, glyphs, antialiasing);
					}
				break;
			}
		}
		else if (instanceof(argument[0]) == "Sprite")
		{
			if (is_real(argument[1]))
			{
				//|Construction method: Sprite (utf8).
				
				originalArguments =
				{
					sprite: argument[0],
					first: argument[1],
					proportional: argument[2],
					separation: argument[3],
				}
				
				switch (originalArgumentCount)
				{
					case 4:
						with (originalArguments)
						{
							other.construct(sprite, first, proportional, separation);
						}
					break;
					
					case 5:
						originalArguments.antialiasing = argument[4];
						
						with (originalArguments)
						{
							other.construct(sprite, first, proportional, separation, antialiasing);
						}
					break;
				}
			}
			else if (is_string(argument[1]))
			{
				//|Construction method: Sprite (glyph map).
				
				originalArguments =
				{
					sprite: argument[0],
					glyphs: argument[1],
					proportional: argument[2],
					separation: argument[3]
				}
				
				switch (originalArgumentCount)
				{
					case 4:
						with (originalArguments)
						{
							other.construct(sprite, glyphs, proportional, separation);
						}
					break;
					
					case 5:
						originalArguments.antialiasing = argument[4];
						
						with (originalArguments)
						{
							other.construct(sprite, glyphs, proportional, separation, antialiasing);
						}
					break;
				}
			}
		}
		
	#endregion
}
