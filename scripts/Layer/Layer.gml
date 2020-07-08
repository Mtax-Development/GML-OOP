/// @function				Layer()
/// @argument				{int} depth
///
/// @description			Construct a Layer resource, which is used to hold
///							and sort rendering depth of different types of elements.
function Layer(_depth) constructor
{
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
					
					ds_list_destroy(instanceList);
					ds_list_destroy(spriteList);
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
			// @description			Return the array of internal IDs of all elements held by this Layer.
			static getElements = function()
			{
				return (((ID != undefined) and (layer_exists(ID))) ? layer_get_all_elements(ID) : undefined);
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
					ds_list_add(instanceList, _object);
					
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
					ds_list_clear(instanceList);
					
					layer_destroy_instances(ID);
				}
			}
			
			static spriteCreate = function(_sprite)
			{
				if ((ID != undefined) and (layer_exists(ID)) and (_sprite.location != undefined))
				{	
					var _spriteElement = layer_sprite_create(ID, _sprite.location.x, 
															 _sprite.location.y,
															 _sprite.ID);
					
					ds_list_add(spriteList, {spriteElement: _spriteElement, 
											 sprite: _sprite});
					
					layer_sprite_xscale(_spriteElement, _sprite.scale.x);
					layer_sprite_yscale(_spriteElement, _sprite.scale.y);
					layer_sprite_angle(_spriteElement, _sprite.angle);
					layer_sprite_blend(_spriteElement, _sprite.color);
					layer_sprite_alpha(_spriteElement, _sprite.alpha);
					layer_sprite_index(_spriteElement, _sprite.frame);
					layer_sprite_speed(_spriteElement, _sprite.speed);
					
					return _spriteElement;
				}
				else
				{
					return noone;
				}
			}
			
			static spriteUpdate = function(_spriteElement, _sprite)
			{
				if ((ID != undefined) and (layer_exists(ID)) and (is_real(_spriteElement)) 
				and (layer_sprite_exists(ID, _spriteElement)))
				{
					var i = 0;
					
					repeat(ds_list_size(spriteList))
					{
						if (spriteList[| i].spriteElement == _spriteElement)
						{
							spriteList[| i] = {spriteElement: _spriteElement,
											   sprite: _sprite};
											   
							break;
						}
						
						i++;
					}
					
					if (_sprite == -1)
					{
						layer_sprite_change(_spriteElement, _sprite);
					}
					else
					{						
						layer_sprite_change(_spriteElement, _sprite.ID);
						
						if (_sprite.location != undefined)
						{
							layer_sprite_x(_spriteElement, _location_x);
							layer_sprite_y(_spriteElement, _location_y);
						}
						
						layer_sprite_xscale(_spriteElement, _sprite.scale.x);
						layer_sprite_yscale(_spriteElement, _sprite.scale.y);
						layer_sprite_angle(_spriteElement, _sprite.angle);
						layer_sprite_blend(_spriteElement, _sprite.color);
						layer_sprite_alpha(_spriteElement, _sprite.alpha);
						layer_sprite_index(_spriteElement, _sprite.frame);
						layer_sprite_speed(_spriteElement, _sprite.speed);
					}
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
		
		instanceList = ds_list_create();
		spriteList = ds_list_create();
		
		ID = layer_create(depth);
		
	#endregion
}