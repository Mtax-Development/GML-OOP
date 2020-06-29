/// @function				ParticleEmitter()
/// @argument				particleSystem {ParticleSystem}
/// @argument				particleType {ParticleType}
///
/// @description			Constructs a Particle Emitter resource, actively bound to a 
///							Particle System, used to create a Particles Type in a region.
function ParticleEmitter(_particleSystem, _particleType) constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function(_particleSystem, _particleType)
			{
				particleSystem = _particleSystem;
				particleType = _particleType;
		
				ID = part_emitter_create(particleSystem.ID);
				
				ds_list_add(particleSystem.emitterList, self);
		
				location = undefined;
				shape = undefined;
				distribution = undefined;
				
				streamEnabled = true;
				streamNumber = 0;
			}
			
			// @returns				{undefined}
			// @description			Remove the internal Particle Emitter information from the memory.
			static destroy = function()
			{
				if  (particleSystem != undefined)
				and (part_system_exists(particleSystem.ID)) 
				and (part_emitter_exists(particleSystem.ID, ID))
				{
					part_emitter_destroy(particleSystem.ID, ID);
					
					var i = 0;
					
					repeat(ds_list_size(particleSystem.emitterList))
					{
						if (ds_list_find_value(particleSystem.emitterList, i))
						{
							ds_list_delete(particleSystem.emitterList, i);
							break;
						}
						
						i++;
					}
				}
		
				return undefined;
			}
			
			// @description			Recreate the Particle Emitter with its initial arguments.
			static clear = function()
			{
				if  (particleSystem != undefined)
				and (part_system_exists(particleSystem.ID)) 
				and (part_emitter_exists(particleSystem.ID, ID))
				{
					part_emitter_destroy(particleSystem.ID, ID);
				}
		
				self.construct(originalArguments.particleSystem);
			}
			
		#endregion
		#region <Setters>
			
			// @argument			location {Vector4}
			// @argument			shape {particle emitter shape}
			// @argument			distribution {particle emitter distribution}
			// @description			Set the particle creation information.
			static setRegion = function(_location, _shape, _distribution)
			{
				if  (particleSystem != undefined)
				and (part_system_exists(particleSystem.ID)) 
				and (part_emitter_exists(particleSystem.ID, ID))
				{
					location = _location;
					shape = _shape;
					distribution = _distribution;
		
					part_emitter_region(particleSystem.ID, ID, location.x1, location.x2,
										location.y1, location.y2, shape, distribution);
				}
			}
			
			// @argument			number {int}
			// @description			Set the number of created particles during a stream.
			static setStreamNumber = function(_number)
			{
				if  (particleSystem != undefined)
				and (part_system_exists(particleSystem.ID)) 
				and (part_emitter_exists(particleSystem.ID, ID))
				{
					streamNumber = _number;
				}
			}
			
			// @argument			streamEnabled {bool}
			// @description			Toggle the continous particle streaming.
			static setStreamEnabled = function(_streamEnabled)
			{
				if  (particleSystem != undefined)
				and (part_system_exists(particleSystem.ID)) 
				and (part_emitter_exists(particleSystem.ID, ID))
				{
					streamEnabled = _streamEnabled;
				}
			}
			
		#endregion
		#region <Execution>
			
			// @argument			particleType {ParticleType}
			// @argument			number {int}
			// @description			Create a number of Particles within the region.
			static burst = function(_number)
			{
				if  ((particleSystem != undefined) 
				and (part_system_exists(particleSystem.ID)) 
				and (particleType != undefined) 
				and (part_type_exists(particleType.ID))
				and (part_emitter_exists(particleSystem.ID, ID)))
				{
					part_emitter_burst(particleSystem.ID, ID, particleType.ID, _number);
				}
			}
			
			// @description			Continously create Particles using the stream configuration.
			static stream = function()
			{
				if  ((particleSystem != undefined) 
				and (part_system_exists(particleSystem.ID)) 
				and (particleType != undefined) 
				and (part_type_exists(particleType.ID))
				and (part_emitter_exists(particleSystem.ID, ID)))
				{
					if (streamEnabled)
					{
						part_emitter_stream(particleSystem.ID, ID, particleType.ID, streamNumber);
					}
					else
					{
						part_emitter_stream(particleSystem.ID, ID, particleType.ID, 0);
					}
				}
			}
			
		#endregion
	#endregion
	#region [Constructor]
	
		originalArguments =
		{
			particleSystem: _particleSystem,
			particleType: _particleType
		};
	
		self.construct(originalArguments.particleSystem, originalArguments.particleType);
	
	#endregion
}
