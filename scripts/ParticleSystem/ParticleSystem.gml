/// @function				ParticleSystem()
/// @argument				{layer} layer?
/// @argument				{bool} persistent?
///
/// @description			Constructs a Particle System resource, required to
///							create Particles in a space.
function ParticleSystem(_layer, _persistent) constructor
{
	#region [Methods]
		#region <Management>
			
			// @argument			{layer} layer?
			// @argument			{bool} persistent?
			// @description			Initialize the constructor.
			static construct = function(_layer, _persistent)
			{
				layer = _layer;
				persistent = ((_persistent != undefined) ? _persistent : false);
				
				depth = undefined;
				
				location = new Vector2(0, 0);
				
				automaticUpdate = true;
				automaticRender = true;
				
				drawOrder_oldToNew = true;
				
				emitterList = ds_list_create();
				
				if (layer != undefined)
				{
					ID = part_system_create_layer(layer, persistent);
				}
				else
				{
					ID = part_system_create();
				}
			}
			
			// @returns				{undefined}
			// @description			Remove the internal Particle System information from the memory.
			static destroy = function()
			{
				if (part_system_exists(ID))
				{
					part_system_destroy(ID);
				}
				
				ds_list_destroy(emitterList);
				
				return undefined; 
			}
			
			// @description			Recreate the Particle System with its initial arguments.
			static clear = function()
			{
				if (part_system_exists(ID))
				{
					part_system_destroy(ID);
				}
				
				self.construct(originalArguments.layer, originalArguments.persistent);
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{int} depth
			// @description			Set a render depth that's independent from any layer depth.
			static setDepth = function(_depth)
			{
				if (part_system_exists(ID))
				{
					layer = undefined;
					depth = _depth;
					
					part_system_depth(ID, depth);
				}
			}
			
			// @argument			{layer} layer
			// @description			Set the render depth to layer, ignoring previous depth settings.
			static setLayer = function(_layer)
			{
				if ((part_system_exists(ID)) and (layer_exists(_layer)))
				{
					layer = _layer;
					depth = undefined;
					
					part_system_layer(ID, layer);
				}
			}
			
			// @argument			{Vector2} location
			// @description			Set the origin point of this particle system.
			static setLocation = function(_location)
			{
				if (part_system_exists(ID))
				{
					location = _location;
					
					part_system_position(ID, location.x, location.y);
				}
			}
			
			// @argument			{bool} automaticUpdate
			// @description			Set whether created Particles are executed without update call.
			static setAutomaticUpdate = function(_automaticUpdate)
			{
				if (part_system_exists(ID))
				{
					automaticUpdate = _automaticUpdate;
					
					part_system_automatic_update(ID, automaticUpdate);
				}
			}
			
			// @argument			{bool} automaticRender
			// @description			Set whether created Particles are executed without render call.
			static setAutomaticRender = function(_automaticRender)
			{
				if (part_system_exists(ID))
				{
					automaticRender = _automaticRender;
					
					part_system_automatic_draw(ID, automaticRender);
				}
			}
			
			// @argument			{bool} drawOrder_oldToNew
			// @description			Set whether older Particles are drawn benath newer.
			static setDrawOrder_oldToNew = function(_drawOrder_oldToNew)
			{
				if (part_system_exists(ID))
				{
					drawOrder_oldToNew = _drawOrder_oldToNew;
					
					part_system_draw_order(ID, _drawOrder_oldToNew);
				}
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{int|undefined}
			// @description			Return a number of currently existing Particles of this Particle
			//						System or undefined if it does not exist.
			static getParticlesCount = function()
			{
				return (part_system_exists(ID) ? part_particles_count(ID) : undefined);
			}
			
			// @returns				{layerID|undefined}
			// @description			Return the ID of the layer the system is internally operated in.
			//						Returns undefined if the Particle System does not exist.
			static getLayer = function()
			{
				return (part_system_exists(ID) ? part_system_get_layer(ID) : undefined);
			}
			
		#endregion
		#region <Execution>
			
			// @description			Render the created Particles.
			static render = function()
			{
				if (part_system_exists(ID))
				{
					part_system_drawit(ID);
				}
			}
			
			// @description			Advance all actions of created Particles.
			static update = function()
			{
				if (part_system_exists(ID))
				{
					part_system_update(ID);
				}
			}
			
			// @description			Remove all currently existing Particles of this Particle System.
			static clear_particles = function()
			{
				if (part_system_exists(ID))
				{
					part_particles_clear(ID);
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Overrides the string conversion with an ID output.
			static toString = function()
			{
				return ((part_system_exists(ID)) ? string(ID) : string(undefined));
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		originalArguments =
		{
			layer: _layer,
			persistent: (_persistent != undefined ? _persistent : false)
		}
	
		self.construct(originalArguments.layer, originalArguments.persistent);
		
	#endregion
}
