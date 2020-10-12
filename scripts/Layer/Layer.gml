/// @function				Layer()
/// @argument				{int} depth
///
/// @description			Construct a Layer resource, which is used to hold
///							and sort rendering depth of different types of elements.
///
///							Construction methods:
///							- New Layer: {int} depth
///							- Exisiting Layer: {string} name
function Layer(_depth) constructor
{
	#region [Elements]
		
		// @function				Layer.SpriteElement()
		// @argument				{Sprite} sprite
		// @description				Constructs a Sprite Element, which is used to draw a Sprite on
		//							this Layer.
		//
		//							Construction methods:
		//							- New Sprite Element: {Sprite} sprite
		//							- Existing Sprite Element: {int} spriteElement
		function SpriteElement() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					// @description			Initialize the constructor.
					static construct = function()
					{
						parent = other;
						
						if (instanceof(argument[0]) == "Sprite")
						{
							sprite = _sprite;
							ID = layer_sprite_create(parent.ID, sprite.location.x, 
													 sprite.location.y, sprite.ID);
							
							location = new Vector2(sprite.location.x, sprite.location.y);
							scale = new Scale(sprite.scale.x, sprite.scale.y);
							angle = new Angle(sprite.angle.value);
							color = sprite.color;
							alpha = sprite.alpha;
							frame = sprite.frame;
							speed = sprite.speed;
							
							layer_sprite_xscale(ID, sprite.scale.x);
							layer_sprite_yscale(ID, sprite.scale.y);
							layer_sprite_angle(ID, sprite.angle.value);
							layer_sprite_blend(ID, sprite.color);
							layer_sprite_alpha(ID, sprite.alpha);
							layer_sprite_index(ID, sprite.frame);
							layer_sprite_speed(ID, sprite.speed);
						}
						else
						{
							ID = argument[0];
							sprite = new Sprite
							(
								layer_sprite_get_sprite(ID),
								new Vector2(layer_sprite_get_x(ID), layer_sprite_get_y(ID)),
								layer_sprite_get_index(ID),
								layer_sprite_get_speed(ID),
								new Scale(layer_sprite_get_xscale(ID), layer_sprite_get_yscale(ID)),
								new Angle(layer_sprite_get_angle(ID)),
								layer_sprite_get_blend(ID),
								layer_sprite_get_alpha(ID)
							);
							
							location = new Vector2(sprite.location.x, sprite.location.y);
							scale = new Scale(sprite.scale.x, sprite.scale.y);
							angle = new Angle(sprite.angle.value);
							color = sprite.color;
							alpha = sprite.alpha;
							frame = sprite.frame;
							speed = sprite.speed;
						}
					}
					
					// @argument			{Layer|layer} other
					// @description			Move this Element to another Layer.
					static changeParent = function(_other)
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_sprite_exists(parent.ID, ID)))
						{
							if (instanceof(_other) == "Layer")
							{
								if (layer_exists(_other.ID))
								{
									parent.spriteList.remove_value(self);
									
									parent = _other;
									
									parent.spriteList.add(self);
									
									layer_element_move(ID, parent.ID);
								}
							}
							else
							{
								if (layer_exists(_other))
								{
									parent.spriteList.remove_value(self);
									
									parent = undefined;
									
									layer_element_move(ID, _other);
								}
							}
						}
					}
					
					// @returns				{undefined}
					// @description			Remove the internal information from the memory.
					static destroy = function()
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_sprite_exists(parent.ID, ID)))
						{
							parent.spriteList.remove_value(self);
							
							layer_sprite_destroy(ID);
						}
						
						return undefined;
					}
					
				#endregion
				#region <<Execution>>
					
					// @argument			{Sprite} sprite
					// @description			Set the sprite of this Sprite Element to the current
					//						status of the specified Sprite.
					//						A value of -1 can be specified instead of the Sprite,
					//						in which case this element will have no Sprite assigned.
					static update = function(_sprite)
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) 
						and (layer_sprite_exists(parent.ID, ID)))
						{
							sprite = _sprite;
							
							if (sprite == -1)
							{
								layer_sprite_change(ID, sprite);
								
								scale = undefined;
								angle = undefined;
								color = undefined;
								alpha = undefined;
								frame = undefined;
								speed = undefined;
							}
							else
							{
								layer_sprite_change(ID, sprite.ID);
								
								if (sprite.location != undefined)
								{
									location = new Vector2(sprite.location.x, sprite.location.y);
									
									layer_sprite_x(ID, location.x);
									layer_sprite_y(ID, location.y);
								}
								else
								{
									location = undefined;
								}
								
								scale = new Scale(sprite.scale.x, sprite.scale.y);
								angle = new Angle(sprite.angle.value);
								color = sprite.color;
								alpha = sprite.alpha;
								frame = sprite.frame;
								speed = sprite.speed;
								
								layer_sprite_xscale(ID, sprite.scale.x);
								layer_sprite_yscale(ID, sprite.scale.y);
								layer_sprite_angle(ID, sprite.angle.value);
								layer_sprite_blend(ID, sprite.color);
								layer_sprite_alpha(ID, sprite.alpha);
								layer_sprite_index(ID, sprite.frame);
								layer_sprite_speed(ID, sprite.speed);
							}
						}
					}
					
				#endregion
				#region <<Conversion>>
					
					// @returns				{string}
					// @description			Create a string representing the constructor.
					//						Overrides the string() conversion.
					static toString = function()
					{
						var _constructorName = "Layer.SpriteElement";
						
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_sprite_exists(parent.ID, ID)))
						{
							return (_constructorName + "(" + string(ID) + ": " + 
								   string(sprite) + ")");
						}
						else
						{
							return (_constructorName + "<>");
						}
					}
					
				#endregion
			#endregion
			#region [[Constructor]]
				
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
		
		// @function				Layer.BackgroundElement()
		// @argument				{Sprite} sprite
		// @description				Constructs a Background Element, which is used to draw a 
		//							Background on this Layer.
		//
		//							Construction methods:
		//							- New Background Element: {Sprite} sprite
		//							- Existing Background Element: {int} backgroundElement
		function BackgroundElement() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					// @description			Initialize the constructor.
					static construct = function()
					{
						parent = other;
						
						if (instanceof(argument[0]) == "Sprite")
						{
							sprite = _sprite;
							ID = layer_background_create(layer.ID, sprite.ID);
							
							visible = true;
							stretched = false;
							tiled_x = false;
							tiled_y = false;
							
							scale = new Scale(sprite.scale.x, sprite.scale.y);
							color = sprite.color;
							alpha = sprite.alpha;
							frame = sprite.frame;
							speed = sprite.speed;
							
							layer_background_xscale(ID, scale.x);
							layer_background_yscale(ID, scale.y);
							layer_background_blend(ID, color);
							layer_background_alpha(ID, alpha);
							layer_background_index(ID, frame);
							layer_background_speed(ID, speed);
						}
						else
						{
							ID = argument[0];
							
							visible = layer_background_get_visible(ID);
							stretched = layer_background_get_stretch(ID);
							tiled_x = layer_background_get_htiled(ID);
							tiled_y = layer_background_get_vtiled(ID);
							
							sprite = new Sprite
							(
								layer_background_get_sprite(ID),
								undefined,
								layer_background_get_index(ID),
								layer_background_get_speed(ID),
								new Scale(layer_background_get_xscale(ID), 
										  layer_background_get_yscale(ID)),
								undefined,
								layer_background_get_blend(ID),
								layer_background_get_alpha(ID)
							);
							
							scale = new Scale(sprite.scale.x, sprite.scale.y);
							color = sprite.color;
							alpha = sprite.alpha;
							frame = sprite.frame;
							speed = sprite.speed;
						}
					}
					
					// @returns				{undefined}
					// @description			Remove the internal information from the memory.
					static destroy = function()
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_background_exists(parent.ID, ID)))
						{
							parent.backgroundList.remove_value(self);
							
							layer_background_destroy(ID);
						}
						
						return undefined;
					}
					
					// @argument			{Layer|layer} other
					// @description			Move this Element to another Layer.
					static changeParent = function(_other)
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_background_exists(parent.ID, ID)))
						{
							if (instanceof(_other) == "Layer")
							{
								if (layer_exists(_other.ID))
								{
									parent.backgroundList.remove_value(self);
									
									parent = _other;
									
									parent.backgroundList.add(self);
									
									layer_element_move(ID, parent.ID);
								}
							}
							else
							{
								if (layer_exists(_other))
								{
									parent.backgroundList.remove_value(self);
									
									parent = undefined;
									
									layer_element_move(ID, _other);
								}
							}
						}
					}
					
				#endregion
				#region <<Execution>>
					
					// @argument			{Sprite} sprite
					// @description			Set the sprite of this Background Element to the current
					//						status of the specified Sprite.
					//						A value of -1 can be specified instead of the Sprite,
					//						in which case this element will have no Sprite assigned.
					static update = function(_sprite)
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_background_exists(parent.ID, ID)))
						{
							sprite = _sprite;
							
							if (sprite == -1)
							{
								layer_background_sprite(ID, sprite);
								
								scale = undefined;
								color = undefined;
								alpha = undefined;
								frame = undefined;
								speed = undefined;
							}
							else
							{
								scale = new Scale(sprite.scale.x, sprite.scale.y);
								color = sprite.color;
								alpha = sprite.alpha;
								frame = sprite.frame;
								speed = sprite.speed;
								
								layer_background_sprite(ID, sprite.ID);
								layer_background_xscale(ID, scale.x);
								layer_background_yscale(ID, scale.y);
								layer_background_blend(ID, color);
								layer_background_alpha(ID, alpha);
								layer_background_index(ID, frame);
								layer_background_speed(ID, speed);
							}
						}
					}
					
				#endregion
				#region <<Setters>>
					
					// @argument			{bool} stretched
					// @description			Set the scretch property of this Background Element.
					static setStretched = function(_stretched)
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_background_exists(parent.ID, ID)))
						{
							stretched = _stretched;
							
							layer_background_stretch(ID, _stretched);
						}
					}
					
					// @argument			{bool} tiled_x?
					// @argument			{bool} tiled_y?
					// @description			Set the tiling properties of this Background Element for
					//						horizontal and vertical tiling respectively.
					//						A value of {undefined} can be set for each argument,
					//						in case of which, it will be not modified.
					static setTiled = function(_tiled_x, _tiled_y)
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_background_exists(parent.ID, ID)))
						{
							if (_tiled_x != undefined) {tiled_x = _tiled_x;}
							if (_tiled_y != undefined) {tiled_y = _tiled_y;}
							
							layer_background_htiled(ID, tiled_x);
							layer_background_vtiled(ID, tiled_y);
						}
					}
					
					// @argument			{bool} visible
					// @description			Set the visibility property of this Background Element.
					static setVisible = function(_visible)
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_background_exists(parent.ID, ID)))
						{
							visible = _visible;
							
							layer_background_visible(ID, visible);
						}
					}
					
				#endregion
				#region <<Conversion>>
					
					// @returns				{string}
					// @description			Create a string representing the constructor.
					//						Overrides the string() conversion.
					static toString = function()
					{
						var _constructorName = "Layer.BackgroundElement";
						
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_background_exists(parent.ID, ID)))
						{
							return (_constructorName + "(" + string(ID) + ": " + 
								   string(sprite) + ")");
						}
						else
						{
							return (_constructorName + "<>");
						}
					}
					
				#endregion
			#endregion
			#region [[Constructor]]
				
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
		
		// @function				Layer.TilemapElement()
		// @argument				{Sprite} sprite
		// @description				Constructs a Tilemap Element, which is used to draw Tiles from
		//							a Tileset on this Layer.
		//
		//							Construction methods:
		//							- New Tilemap Element: {tileset} tileset, {Vector2} location
		//												   {Vector2} size
		//							- Existing Tilemap Element: {int} tilemapElement
		function TilemapElement() constructor
		{
			#region [[Elements]]
				
				// @function				Layer.TilemapElement.TileData()
				// @argument				{int|hex} id
				// @description				Constructs a TileData Element, which refers to Tile
				//							in this Tilemap.
				function TileData(_id) constructor
				{
					#region [[[Methods]]]
						#region <<<Management>>>
							
							// @argument			{int} id
							// @description			Initialize the constructor.
							static construct = function(_id)
							{
								parent = other;
								
								ID = _id;
							}
							
						#endregion
						#region <<<Getters>>>
							
							// @returns				{int} | On error: -1
							// @description			Return the index of the Tile this Tile Data 
							//						refers to on its tileset.
							static getTilesetIndex = function()
							{
								if (ID != -1)
								{
									return tile_get_index(ID);
								}
								else
								{
									return -1;
								}
							}
							
							// @returns				{bool} | On error: {undefined}
							// @description			Check if this Tile Data refers to an empty Tile.
							static isEmpty = function()
							{
								if (ID != -1)
								{
									return tile_get_empty(ID);
								}
								else
								{
									return undefined;
								}
							}
							
							// @returns				{bool} | On error: {undefined}
							// @description			Check if this Tile Data refers to a Tile that was
							//						mirrored horizontally.
							static isMirrored_x = function()
							{
								if (ID != -1)
								{
									return tile_get_mirror(ID);
								}
								else
								{
									return undefined;
								}
							}
							
							// @returns				{bool} | On error: {undefined}
							// @description			Check if this Tile Data refers to a Tile that was
							//						mirrored vertically.
							static isMirrored_y = function()
							{
								if (ID != -1)
								{
									return tile_get_flip(ID);
								}
								else
								{
									return undefined;
								}
							}
							
							// @returns				{bool} | On error: {undefined}
							// @description			Check if this Tile Data refers to a Tile that was
							//						rotated by 90 degrees.
							static isRotated = function()
							{
								if (ID != -1)
								{
									return tile_get_rotate(ID);
								}
								else
								{
									return undefined;
								}
							}
							
						#endregion
						#region <<<Setters>>>
							
							// @description			Empty the Tile this Tile Data refers to.
							static setEmpty = function()
							{
								if (ID != -1)
								{
									ID = tile_set_empty(ID);
								}
							}
							
							// @argument			{int}
							// @description			Change the Tile this Tile Data refers to, based
							//						on the index of its tileset.
							static setTilesetIndex = function(_index)
							{
								if (ID != -1)
								{
									ID = tile_set_index(ID, _index);
								}
							}
							
							// @argument			{bool}
							// @description			Set the horizontal mirroring property of the Tile
							//						this Tile Data refers to.
							static setMirror_x = function(_mirror)
							{
								if (ID != -1)
								{
									ID = tile_set_mirror(ID, _mirror);
								}
							}
							
							// @argument			{bool}
							// @description			Set the vertical mirroring property of the Tile
							//						this Tile Data refers to.
							static setMirror_y = function(_flip)
							{
								if (ID != -1)
								{
									ID = tile_set_flip(ID, _flip);
								}
							}
							
							// @argument			{bool}
							// @description			Set the 90 degree rotation property of the Tile
							//						this Tile Data refers to.
							static setRotate = function(_rotate)
							{
								if (ID != -1)
								{
									ID = tile_set_rotate(ID, _rotate);
								}
							}
							
						#endregion
						#region <<<Execution>>>
							
							// @argument			{Vector2} location?
							// @argument			{int} frame?
							// @description			Execute the draw of the Tile this Tile Data
							//						refers to, independent of its draw handled
							//						by its Layer.
							static render = function(_location, _frame)
							{
								if (ID != -1)
								{
									if (_location == undefined) {_location = new Vector2(0, 0);}
									if (_frame == undefined) {_frame = 0;}
									
									draw_tile(parent.tileset, ID, _frame, _location.x, _location.y);
								}
							}
							
						#endregion
						#region <<<Conversion>>>
							
							// @returns				{string}
							// @description			Create a string representing the constructor.
							//						Overrides the string() conversion.
							static toString = function()
							{
								var _constructorName = "Layer.TilemapElement.TileData";
								
								return (_constructorName + "(" + string(ID) + ")");
							}
							
						#endregion
					#endregion
					#region [[[Constructor]]]
						
						argument_original = array_create(argument_count, undefined);
						
						var _i = 0;
						
						repeat (argument_count)
						{
							argument_original[_i] = argument[_i];
					
							++_i;
						}
						
						self.construct(argument_original[0]);
						
					#endregion
				}
				
			#endregion
			#region [[Methods]]
				#region <<Management>>
					
					// @description			Initialize the constructor.
					static construct = function()
					{
						parent = other;
						
						if (argument_count > 1)
						{
							tileset = argument[0];
							location = argument[1];
							size = argument[2];
							
							ID = layer_tilemap_create(parent.ID, location.x, location.y, tileset, 
													  size.x, size.y);
						}
						else
						{
							ID = argument[0];
							
							tileset = tilemap_get_tileset(ID);
							location = new Vector2(tilemap_get_x(ID), tilemap_get_y(ID));
							size = new Vector2(tilemap_get_width(ID), tilemap_get_height(ID));
						}
					}
					
					// @returns				{undefined}
					// @description			Remove the internal information from the memory.
					static destroy = function()
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							parent.tilemapList.remove_value(self);
							
							layer_tilemap_destroy(ID);
						}
						
						return undefined;
					}
					
					// @argument			{Layer.TilemapElement.TileData}
					// @description			Set all Tiles in this Tilemap to the Tile that the
					//						specified Tile Data refers to.
					//						0 can be specified instead to set these tiles to empty.
					static clear = function(_tiledata)
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							if (_tiledata == undefined)
							{
								_tiledata = 0;
							}
							else if (instanceof(_tiledata) == "TileData")
							{
								_tiledata = _tiledata.ID
							}
							
							tilemap_clear(ID, _tiledata);
						}
					}
					
					// @argument			{Layer|layer} other
					// @description			Move this Element to another Layer.
					static changeParent = function(_other)
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							if (instanceof(_other) == "Layer")
							{
								if (layer_exists(_other.ID))
								{
									parent.tilemapList.remove_value(self);
									
									parent = _other;
									
									parent.tilemapList.add(self);
									
									layer_element_move(ID, parent.ID);
								}
							}
							else
							{
								if (layer_exists(_other))
								{
									parent.tilemapList.remove_value(self);
									
									parent = undefined;
									
									layer_element_move(ID, _other);
								}
							}
						}
					}
					
				#endregion
				#region <<Getters>>
					
					// @returns				{int} | On error: -1
					// @description			Return the bit mask value for this Tilemap.
					//						Returns 0 if there is no mask.
					static getMask = function()
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							return tilemap_get_mask(ID);
						}
						else
						{
							return -1;
						}
					}
					
					// @returns				{int} | On error: {undefined}
					// @description			Return the current Sprite frame of this Tilemap.
					static getFrame = function()
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							return tilemap_get_frame(ID);
						}
						else
						{
							return undefined;
						}
					}
					
					// @returns				{Vector2} | On error: {undefined}
					// @description			Return the size of Tiles in this Tilemap.
					static getCellSize = function()
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							return new Vector2(tilemap_get_tile_width(ID), 
											   tilemap_get_tile_height(ID));
						}
						else
						{
							return undefined;
						}
					}
					
					// @argument			{Vector2} location
					// @returns				{Layer.TilemapElement.TileData}
					// @description			Return a TileData referring to the Tile in a cell at the
					//						specified location.
					static getTile_inCell = function(_location)
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							return new TileData(tilemap_get(ID, _location.x, _location.y));
						}
						else
						{
							return new TileData(-1);
						}
					}
					
					// @argument			{Vector2} location
					// @returns				{Layer.TilemapElement.TileData}
					// @description			Return a TileData referring to the Tile at specified
					//						point in space.
					static getTile_atPoint = function(_location)
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							return new TileData(tilemap_get_at_pixel(ID, _location.x, _location.y));
						}
						else
						{
							return new TileData(-1);
						}
					}
					
					// @argument			{Vector2} location
					// @returns				{Vector2} | On error: {undefined}
					// @description			Return the cell location for a Tile at specified point
					//						in space.
					static getCellAtPoint = function(_location)
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							return new Vector2
							(
								tilemap_get_cell_x_at_pixel(ID, _location.x, _location.y),
								tilemap_get_cell_y_at_pixel(ID, _location.x, _location.y)
							);
						}
						else
						{
							return undefined;
						}
					}
					
				#endregion
				#region <<Setters>>
					
					// @argument			{Layer.TilemapElement.TileData} tiledata
					// @argument			{Vector2} location
					// @description			Set the Tile at the specified cell to a Tile referred
					//						to by the specified Tile Data.
					static setTile_inCell = function(_tiledata, _location)
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							if (_tiledata == undefined)
							{
								_tiledata = 0;
							}
							else if (_tiledata != 0)
							{
								_tiledata = _tiledata.ID;
							}
							
							if (_tiledata != -1)
							{
								return tilemap_set(ID, _tiledata, _location.x, _location.y);
							}
						}
						
						return false;
					}
					
					// @argument			{Layer.TilemapElement.TileData} tiledata
					// @argument			{Vector2} location
					// @description			Set the Tile at the specified point in space to a Tile
					//						referred to by the specified Tile Data.
					static setTile_inPoint = function(_tiledata, _location)
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							if (_tiledata == undefined)
							{
								_tiledata = 0;
							}
							else if (_tiledata != 0)
							{
								_tiledata = _tiledata.ID;
							}
							
							if (_tiledata != -1)
							{
								return tilemap_set_at_pixel(ID, _tiledata, _location.x, _location.y);
							}
						}
						
						return false;
					}
					
					// @argument			{int|hex} mask
					// @description			Set the tile bit mask for this Tilemap.
					static setMask = function(_mask)
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							tilemap_set_mask(ID, _mask);
						}
					}
					
					// @argument			{tileset} tileset
					// @description			Change the Tileset used by this Tilemap.
					static setTileset = function(_tileset)
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							tileset = _tileset;
							
							tilemap_tileset(ID, tileset);
						}
					}
					
					// @argument			{Vector2} size
					// @description			Set the size of this Tilemap, which is the number of Tile
					//						cells it will use.
					static setSize = function(_size)
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							size = _size;
							
							tilemap_set_width(ID, size.x);
							tilemap_set_height(ID, size.y);
						}
					}
					
				#endregion
				#region <<Execution>>
					
					// @argument			{Vector2} location?
					// @description			Execute the draw of this Tilemap, independent of its 
					//						draw handled by its Layer.
					static render = function(_location)
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							if (_location == undefined) {_location = new Vector2(0, 0);}
							
							draw_tilemap(ID, _location.x, _location.y);
						}
					}
					
				#endregion
				#region <<Conversion>>
					
					// @returns				{string}
					// @description			Create a string representing the constructor.
					//						Overrides the string() conversion.
					static toString = function()
					{
						var _constructorName = "Layer.TilemapElement";
						
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							return (_constructorName + "(" + 
									"Tileset: " + tileset_get_name(tileset) + ", " +
									"Location: " + string(location) + ", " +
									"Size: " + string(size) + ")");
						}
						else
						{
							return (_constructorName + "<>");
						}
					}
					
				#endregion
			#endregion
			#region [[Constructor]]
				
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
		
	#endregion
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				if (is_string(argument[0]))
				{
					//|Construction method: Existing Layer.
					var _name = argument[0];
					
					name = _name;
					ID = layer_get_id(name);
					
					depth = layer_get_depth(ID);
					
					location = new Vector2(layer_get_x(ID), layer_get_y(ID));
					speed = new Vector2(layer_get_hspeed(ID), layer_get_vspeed(ID));
					
					visible = layer_get_visible(ID);
					instancesPaused = undefined;
					
					script_drawBegin = layer_get_script_begin(ID);
					script_drawEnd = layer_get_script_end(ID);
					
					shader = layer_get_shader(ID);
					
					instanceList = new List();
					spriteList = new List();
					backgroundList = new List();
					tilemapList = new List();
					
					var _elements = layer_get_all_elements(ID);
					
					var _i = 0;
					
					repeat (array_length(_elements))
					{
						var _type = layer_get_element_type(_elements[_i]);
						
						switch(_type)
						{
							case layerelementtype_instance:
								instanceList.add(layer_instance_get_instance(_elements[_i]));
							break;
							
							case layerelementtype_sprite:
								spriteList.add(new SpriteElement(_elements[_i]));
							break;
							
							case layerelementtype_background:
								backgroundList.add(new BackgroundElement(_elements[_i]));
							break;
							
							case layerelementtype_tilemap:
								tilemapList.add(new TilemapElement(_elements[_i]));
							break;
						}
						
						++_i;
					}
				}
				else
				{
					//Construction method: New layer.
					depth = argument[0];
					
					location = new Vector2(0, 0);
					speed = new Vector2(0, 0);
					
					visible = true;
					instancesPaused = false;
					
					script_drawBegin = undefined;
					script_drawEnd = undefined;
					
					shader = undefined;
					
					instanceList = new List();
					spriteList = new List();
					backgroundList = new List();
					tilemapList = new List();
					
					ID = layer_create(depth);
					
					name = layer_get_name(ID);
				}
			}
			
			// @returns				{undefined}
			// @description			Remove the internal Layer information from the memory.
			static destroy = function()
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					layer_destroy(ID);
					
					ID = undefined;
					
					instanceList = instanceList.destroy();
					spriteList = spriteList.destroy();
					backgroundList = backgroundList.destroy();
				}
				
				return undefined;
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{Vector2} location
			// @description			Change the rendering offset for Elements of this Layer, other
			//						than instances.
			static setLocation = function(_location)
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					location = _location;
					
					layer_x(ID, location.x);
					layer_y(ID, location.y);
				}
			}
			
			// @argument			{Vector2} speed
			// @description			Set the horizontal and vertical speed of Elements of this Layer,
			//						other than instances.
			static setSpeed = function(_speed)
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					speed = _speed;
					
					layer_hspeed(ID, speed.x);
					layer_vspeed(ID, speed.y);
				}
			}
			
			// @argument			{bool} visible
			// @description			Set the visiblity property for all elements of this Layer.
			//						Instances on a Layer that is not visible will not have their
			//						Draw Events run.
			static setVisible = function(_visible)
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					visible = _visible;
					
					layer_set_visible(ID, visible);
				}
			}
			
			// @argument			{int} depth
			// @description			Set depth of this Layer, which dictates its render sorting.
			static setDepth = function(_depth)
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					depth = _depth;
					
					layer_depth(ID, depth);
				}
			}
			
			// @argument			{script} script
			// @description			Set a function that will be called during the Draw Begin of
			//						this Layer.
			static setScript_drawBegin = function(_script)
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					script_drawBegin = _script;
					
					layer_script_begin(ID, script_drawBegin);
				}
			}
			
			// @argument			{script} script
			// @description			Set a function that will be called during the Draw End of
			//						this Layer.
			static setScript_drawEnd = function(_script)
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					script_drawEnd = _script;
					
					layer_script_end(ID, script_drawEnd);
				}
			}
			
			// @argument			{shader} Shader
			// @description			Set a Shader that will be applied to Layer's every element.
			static setShader = function(_shader)
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					shader = _shader;
					
					layer_shader(ID, shader.ID);
				}
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{int[]}
			// @description			Return the array of all internal element IDs held by this Layer.
			static getElements = function()
			{
				return (((ID != undefined) and (layer_exists(ID))) ? layer_get_all_elements(ID) 
																   : undefined);
			}
			
			// @argument			{instance} instance
			// @returns				{bool|undefined}
			// @description			Check whether the specified instance is bound to this Layer.
			static hasInstance = function(_instance)
			{
				return (((ID != undefined) and (layer_exists(ID))) ? 
					   layer_has_instance(ID, _instance) : undefined);
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{Sprite} sprite
			// @returns				{SpriteElement} | On error: {noone}
			// @description			Create a Sprite Element on this Layer and return it.
			static create_sprite = function(_sprite)
			{
				if ((ID != undefined) and (layer_exists(ID)) and (_sprite.location != undefined))
				{
					var _element = new SpriteElement(_sprite);
					
					spriteList.add(_element);
					
					return _element;
				}
				else
				{
					return noone;
				}
			}
			
			// @argument			{Sprite} sprite
			// @returns				{BackgroundElement} | On error: {noone}
			// @description			Create a Background Element on this Layer and return it.
			static create_background = function(_sprite)
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					var _element = new BackgroundElement(_sprite);
					
					backgroundList.add(_element);
					
					return _element;
				}
				else
				{
					return noone;
				}
			}
			
			// @argument			{tileset} tileset
			// @argument			{Vector2} location
			// @argument			{Vector2} size
			// @returns				{TilemapElement} | On error: {noone}
			// @description			Create a Tilemap Element on this Layer and return it.
			static create_tilemap = function(_tileset, _location, _size)
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					var _element = new TilemapElement(_tileset, _location, _size);
					
					tilemapList.add(_element);
					
					return _element;
				}
				else
				{
					return noone;
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{object} object
			// @returns				{int|noone}
			// @description			Create an instance on this Layer and return its internal ID.
			static create_instance = function(_location, _object)
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					var _instance = instance_create_layer(_location.x, _location.y, ID, _object)
					
					instanceList.add(_instance);
					
					return _instance;
				}
				else
				{
					return noone;
				}
			}
			
			// @argument			{bool} instancesPaused
			// @description			Activate or deactivate all instances bound to this Layer.
			static setInstancePause = function(_instancesPaused)
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					instancesPaused = _instancesPaused;
					
					if (instancesPaused)
					{
						instance_deactivate_layer(ID);
					}
					else
					{
						instance_activate_layer(ID);
					}
				}
			}
			
			// @description			Destroy all instances that are bound to this Layer.
			static destroy_instances = function()
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					instanceList.clear();
					
					layer_destroy_instances(ID);
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Create a string representing the constructor.
			//						Overrides the string() conversion.
			static toString = function()
			{
				if (is_real(ID) and (layer_exists(ID)))
				{
					return (instanceof(self) + "(" + string(depth) + ": " + name + ")");
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
