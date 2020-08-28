/// @function				Layer()
/// @argument				{int} depth
///
/// @description			Construct a Layer resource, which is used to hold
///							and sort rendering depth of different types of elements.
function Layer(_depth) constructor
{
	#region [Elements]
		
		function SpriteElement(_sprite) constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					destroy = function()
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
					
					update = function(_sprite)
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
					
					toString = function()
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
				
				parent = other;
				sprite = _sprite;
				ID = layer_sprite_create(parent.ID, sprite.location.x, sprite.location.y, sprite.ID);
				
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
				
			#endregion
		}
		
		function BackgroundElement(_sprite) constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					destroy = function()
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_background_exists(parent.ID, ID)))
						{
							parent.backgroundList.remove_value(self);
							
							layer_background_destroy(ID);
						}
						
						return undefined;
					}
					
				#endregion
				#region <<Execution>>
					
					update = function(_sprite)
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
					
					setStretched = function(_stretched)
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_background_exists(parent.ID, ID)))
						{
							stretched = _stretched;
							
							layer_background_stretch(ID, _stretched);
						}
					}
					
					setTiled = function(_tiled_x, _tiled_y)
					{
						if ((parent != undefined) and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_background_exists(parent.ID, ID)))
						{	
							tiled_x = ((_tiled_x != undefined) ? _tiled_x : false);
							tiled_y = ((_tiled_y != undefined) ? _tiled_y : false);
							
							layer_background_htiled(ID, tiled_x);
							layer_background_vtiled(ID, tiled_y);
						}
					}
					
					setVisible = function(_visible)
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
					
					toString = function()
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
				
				parent = other;
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
				
			#endregion
		}
		
	#endregion
	#region [Methods]
		#region <Management>
			
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
			// @description			Change the rendering offset of this Layer's non-instance elements.
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
			// @description			Set the x/y scrolling speed of the Layer's non-instance elements.
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
			// @description			Set whether all elements of this Layer are visible.
			static setVisible = function(_visible)
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					visible = _visible;
					
					layer_set_visible(ID, visible);
				}
			}
			
			// @argument			{int} depth
			// @description			Set depth of this Layer, affecting its render sorting.
			static setDepth = function(_depth)
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					depth = _depth;
					
					layer_depth(ID, depth);
				}
			}
			
			// @argument			{script} script
			// @description			Set a script to be called during this Layer's Draw Begin.
			static setScript_drawBegin = function(_script)
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					script_drawBegin = _script;
					
					layer_script_begin(ID, script_drawBegin);
				}
			}
			
			// @argument			{script} script
			// @description			Set a script to be called during this Layer's Draw End.
			static setScript_drawEnd = function(_script)
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					script_drawEnd = _script;
					
					layer_script_end(ID, script_drawEnd);
				}
			}
			
			// @argument			{shader} shader
			// @description			Set a shader that will be applied to Layer's every element.
			static setShader = function(_shader)
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					shader = _shader;
					
					layer_shader(ID, shader);
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
		
			// @argument			{layerElementID} element
			// @argument			{Layer|layer} other
			// @description			Move a specified Layer element from this Layer to other one.
			static moveElement = function(_element, _other)
			{
				if ((ID != undefined) and (layer_exists(ID)) and (_other != undefined))
				{			
					if (instanceof(_other) == "Layer")
					{
						if (layer_exists(_other.ID))
						{
							layer_element_move(_element, _other.ID);
						}
					}
					else
					{
						if (layer_exists(_other))
						{
							layer_element_move(_element, _other);
						}
					}
					
					//+TODO: Data Structure handling.
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{object} object
			// @returns				{int|noone}
			// @description			Create an instance on this layer and return its internal ID.
			static createInstance = function(_location, _object)
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					instanceList.add(_object);
					
					return instance_create_layer(_location.x, _location.y, ID, _object);
				}
				else
				{
					return noone;
				}
			}
			
			// @argument			{bool} instancesActive
			// @description			Activate or deactivate all instances bound to this Layer.
			static activateInstances = function(_instancesActive)
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					instancesActive = _instancesActive;
			
					if (instancesActive)
					{
						instance_activate_layer(ID);
					}
					else
					{
						instance_deactivate_layer(ID);
					}
				}
			}
			
			// @description			Destroy all instances that are bound to this Layer.
			static destroyInstances = function()
			{
				if ((ID != undefined) and (layer_exists(ID)))
				{
					instanceList.clear();
					
					layer_destroy_instances(ID);
				}
			}
			
			//+TODO: Instance method names: Put "instance" at the beginning.
			
			// @argument			{Sprite} sprite
			// @returns				{int|noone}
			// @description			Create a Sprite Element on this Layer and return its ID.
			//						Returns {noone} if this Layer does not exist.
			static spriteCreate = function(_sprite)
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
			// @returns				{int|noone}
			// @description			Create a Background Element on this Layer and return its ID.
			//						Returns {noone} if this Layer does not exists.
			static backgroundCreate = function(_sprite)
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
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Create a string representing the constructor.
			//						Overrides the string() conversion.
			static toString = function()
			{
				if (is_real(ID) and (layer_exists(ID)))
				{
					return (instanceof(self) + string(depth) + ": " + name);
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		depth = _depth;
		
		location = new Vector2(0, 0);
		speed = new Vector2(0, 0);
		
		visible = true;
		instancesActive = true;
		
		script_drawBegin = undefined;
		script_drawEnd = undefined;
		
		shader = undefined;
		
		instanceList = new List();
		spriteList = new List();
		backgroundList = new List();
		
		ID = layer_create(depth);
		
		name = layer_get_name(ID);
		
	#endregion
}
