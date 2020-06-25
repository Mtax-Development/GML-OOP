/// @function				ParticleSystem();
/// @argument				layer?
/// @argument				persistent?
function ParticleSystem() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				layer = ((argument[0] != undefined) ? argument[0] : undefined);
				persistent = ((argument[1] != undefined) ? argument[1] : false);
				
				depth = undefined;
				
				location = new Vector2(0, 0);
				
				automaticUpdate = true;
				automaticRender = true;
				
				drawOrder_oldToNew = true;
				
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
			
			// @argument			depth {int}
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
		
			// @argument			layer {layer}
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
		
			// @argument			location {Vector2}
			// @description			Set the origin point of this particle system.
			static setLocation = function(_location)
			{
				if (part_system_exists(ID))
				{
					location = _location;
				
					part_system_position(ID, location.x, location.y);
				}
			}
		
			// @description			Set whether created Particles are executed without update call.
			static setAutomaticUpdate = function(_automaticUpdate)
			{
				if (part_system_exists(ID))
				{
					automaticUpdate = _automaticUpdate;
				
					part_system_automatic_update(ID, automaticUpdate);
				}
			}
		
			// @description			Set whether created Particles are executed without render call.
			static setAutomaticRender = function(_automaticRender)
			{
				if (part_system_exists(ID))
				{
					automaticRender = _automaticRender;
				
					part_system_automatic_draw(ID, automaticRender);
				}
			}
		
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
		
			// @returns				{int | undefined}
			// @description			Return a number of currently existing Particles of this Particle
			//						System or undefined if it does not exist.
			static getParticlesCount = function()
			{
				return (part_system_exists(ID) ? part_particles_count(ID) : undefined);
			}
			
			// @returns				{layerID | undefined}
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
	#endregion
	#region [Constructor]
	
	originalArguments =
	{
		layer: (argument_count >= 1 ? argument[0] : undefined),
		persistent: (argument_count >= 2 ? argument[1] : undefined)
	}
	
	self.construct(originalArguments.layer, originalArguments.persistent);
	
	#endregion
}
