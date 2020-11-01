/// @function				ParticleSystem()
/// @argument				{Layer|layer} layer?
/// @argument				{bool} persistent?
///
/// @description			Construct a Particle System resource, required to create particles of
///							each Particle Type.
///
///							Construction methods:
///							- New constructor.
///							- Constructor copy: {ParticleSystem} other
function ParticleSystem() constructor
{
	#region [Elements]
		
		// @function				ParticleSystem.ParticleEmitter()
		// @argument				{ParticleType} particleType
		//
		// @description				Construct a Particle Emitter resource in this Particle System, 
		//							used to create particles of a Particles Type in a region.
		//
		//							Construction methods:
		//							- New constructor.
		//							- Constructor copy: {ParticleSystem.ParticleEmitter} other
		function ParticleEmitter() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					// @description			Initialize the constructor.
					static construct = function()
					{
						parent = other;
						
						location = undefined;
						shape = undefined;
						distribution = undefined;
						
						streamEnabled = true;
						streamNumber = 0;
						
						ID = part_emitter_create(parent.ID);
						
						parent.emitterList.add(self);
						
						if (instanceof(argument[0]) == "ParticleEmitter")
						{
							//|Construction method: Constructor copy.
							var _other = argument[0];
							
							particleType = _other.particleType;
							
							if ((_other.location != undefined) and (_other.shape != undefined)
							and (_other.distribution != undefined))
							{
								self.setRegion(_other.location, _other.shape, _other.distribution);
							}
						}
						else
						{
							//|Construction method: New constructor.
							particleType = argument[0];
						}
					}
					
					// @returns				{undefined}
					// @description			Remove the internal information from the memory.
					static destroy = function()
					{
						if ((parent != undefined) and (parent.ID != undefined) 
						and (part_system_exists(parent.ID)) and (part_emitter_exists(parent.ID, ID)))
						{
							parent.emitterList.remove_value(self);
							
							part_emitter_destroy(parent.ID, ID);
						}
						
						return undefined;
					}
					
					// @description			Recreate the constructor.
					static clear = function()
					{
						self.destroy();
						
						self.construct(particleType);
					}
					
				#endregion
				#region <<Setters>>
					
					// @argument			{Vector4} location
					// @argument			{constant:ps_shape_*} shape
					// @argument			{constant:ps_distr_*} distribution
					// @description			Set the region in which the particles will be replaced.
					static setRegion = function(_location, _shape, _distribution)
					{
						if ((parent != undefined) and (parent.ID != undefined) 
						and (part_system_exists(parent.ID)) and (part_emitter_exists(parent.ID, ID)))
						{
							location = _location;
							shape = _shape;
							distribution = _distribution;
							
							part_emitter_region(parent.ID, ID, location.x1, location.x2,
												location.y1, location.y2, shape, distribution);
						}
					}
					
					// @argument			{int} number
					// @description			Set the number of created particles during a stream.
					static setStreamNumber = function(_number)
					{
						if ((parent != undefined) and (parent.ID != undefined) 
						and (part_system_exists(parent.ID)) and (part_emitter_exists(parent.ID, ID)))
						{
							streamNumber = _number;
						}
					}
					
					// @argument			{bool} streamEnabled
					// @description			Toggle continous particle streaming.
					static setStreamEnabled = function(_streamEnabled)
					{
						if ((parent != undefined) and (parent.ID != undefined) 
						and (part_system_exists(parent.ID)) and (part_emitter_exists(parent.ID, ID)))
						{
							streamEnabled = _streamEnabled;
						}
					}
					
				#endregion
				#region <<Execution>>
					
					// @argument			{ParticleType} particleType
					// @argument			{int} number
					// @description			Create a number of Particles within the region.
					static burst = function(_number)
					{
						if ((parent != undefined) and (parent.ID != undefined) 
						and (part_system_exists(parent.ID)) and (particleType != undefined) 
						and (part_type_exists(particleType.ID))
						and (part_emitter_exists(parent.ID, ID)))
						{
							part_emitter_burst(parent.ID, ID, particleType.ID, _number);
						}
					}
					
					// @description			Continously create Particles using the stream 
					//						configuration.
					static stream = function()
					{
						if ((parent != undefined) and (parent.ID != undefined) 
						and (part_system_exists(parent.ID)) and (particleType != undefined) 
						and (part_type_exists(particleType.ID))
						and (part_emitter_exists(parent.ID, ID)))
						{
							if (streamEnabled)
							{
								part_emitter_stream(parent.ID, ID, particleType.ID, 
													streamNumber);
							}
							else
							{
								part_emitter_stream(parent.ID, ID, particleType.ID, 0);
							}
						}
					}
					
				#endregion
				#region <<Conversion>>
					
					// @returns				{string}
					// @description			Overrides the string conversion with an ID output.
					static toString = function()
					{
						var _constructorName = "ParticleSystem.ParticleEmitter";
						
						if ((instanceof(parent) == "ParticleSystem")
						and (part_system_exists(parent.ID))
						and (instanceof(particleType) == "ParticleType")
						and (part_type_exists(particleType.ID))
						and (part_emitter_exists(parent.ID, ID)))
						{
							return (_constructorName + "(" + string(ID) + ": "
									+ string(particleType) + ")");
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
				if ((argument_count > 0) and (instanceof(argument[0]) == "ParticleSystem"))
				{
					//|Construction method: Constructor copy.
					var _other = argument[0];
					
					layer = _other.layer;
					persistent = _other.persistent;
					
					depth = _other.depth;
					
					location = _other.location;
					
					automaticUpdate = _other.automaticUpdate;
					automaticRender = _other.automaticRender;
					
					drawOrder_oldToNew = _other.drawOrder_oldToNew;
					
					if (layer != undefined)
					{
						var _layer = ((instanceof(layer) == "Layer") ? layer.ID : layer);
						
						ID = part_system_create_layer(_layer, persistent);
					}
					else
					{
						ID = part_system_create();
						
						persistent = false;
						
						if (depth != undefined)
						{
							self.setDepth(depth);
						}
					}
					
					self.setLocation(location);
					self.setAutomaticUpdate(automaticUpdate);
					self.setAutomaticRender(automaticRender);
					self.setDrawOrder_oldToNew(drawOrder_oldToNew);
					
					emitterList = new List();
					
					var _i = 0;
					repeat (_other.emitterList.getSize())
					{
						emitterList.add(new ParticleEmitter(emitterList.getValue(_i)));
						
						++_i;
					}
				}
				else
				{
					//|Construction method: New constructor.
					layer = ((argument_count > 0) ? argument[0] : undefined);
					persistent = ((argument_count > 1) and (argument[1] != undefined) ? argument[1]
																					  : false);
					
					depth = undefined;
					
					location = new Vector2(0, 0);
					
					automaticUpdate = true;
					automaticRender = true;
					
					drawOrder_oldToNew = true;
					
					emitterList = new List();
					
					if (layer != undefined)
					{
						ID = part_system_create_layer(layer, persistent);
					}
					else
					{
						ID = part_system_create();
						persistent = false;
					}
				}
			}
			
			// @returns				{undefined}
			// @description			Remove the internal information from the memory.
			static destroy = function()
			{
				if (instanceof(emitterList) == "List")
				{
					var _i = 0;
					repeat (emitterList.getSize())
					{
						emitterList.getValue(_i).destroy();
						
						++_i;
					}
					
					emitterList = emitterList.destroy();
				}
				
				if ((is_real(ID)) and (part_system_exists(ID)))
				{
					part_system_destroy(ID);
					
					ID = undefined;
				}
				
				return undefined; 
			}
			
			// @description			Recreate the Particle System with its initial arguments.
			static clear = function()
			{
				if ((is_real(ID)) and (part_system_exists(ID)))
				{
					part_system_destroy(ID);
				}
				
				self.construct(originalArguments.layer, originalArguments.persistent);
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{int} depth
			// @description			Set a render depth that is independent from any layer depth.
			static setDepth = function(_depth)
			{
				if ((is_real(ID)) and (part_system_exists(ID)))
				{
					depth = _depth;
					
					layer = undefined;
					persistent = false;
					
					part_system_depth(ID, depth);
				}
			}
			
			// @argument			{Layer|layer} layer
			// @description			Set the render depth to layer, ignoring previous depth settings.
			static setLayer = function(_layer)
			{
				if ((is_real(ID)) and (part_system_exists(ID)) and (layer_exists(_layer)))
				{
					layer = _layer;
					depth = undefined;
					
					var _layer_new = ((instanceof(layer) == "Layer") ? layer.ID : layer);
					
					part_system_layer(ID, _layer_new);
				}
			}
			
			// @argument			{Vector2} location
			// @description			Set the origin point of this particle system.
			static setLocation = function(_location)
			{
				if ((is_real(ID)) and (part_system_exists(ID)))
				{
					location = _location;
					
					part_system_position(ID, location.x, location.y);
				}
			}
			
			// @argument			{bool} automaticUpdate
			// @description			Set whether created Particles are executed without update call.
			static setAutomaticUpdate = function(_automaticUpdate)
			{
				if ((is_real(ID)) and (part_system_exists(ID)))
				{
					automaticUpdate = _automaticUpdate;
					
					part_system_automatic_update(ID, automaticUpdate);
				}
			}
			
			// @argument			{bool} automaticRender
			// @description			Set whether created Particles are executed without render call.
			static setAutomaticRender = function(_automaticRender)
			{
				if ((is_real(ID)) and (part_system_exists(ID)))
				{
					automaticRender = _automaticRender;
					
					part_system_automatic_draw(ID, automaticRender);
				}
			}
			
			// @argument			{bool} drawOrder_oldToNew
			// @description			Set whether older Particles are drawn benath newer.
			static setDrawOrder_oldToNew = function(_drawOrder_oldToNew)
			{
				if ((is_real(ID)) and (part_system_exists(ID)))
				{
					drawOrder_oldToNew = _drawOrder_oldToNew;
					
					part_system_draw_order(ID, _drawOrder_oldToNew);
				}
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{int} | On error: {undefined}
			// @description			Return a number of currently existing Particles of this Particle
			//						System.
			static getParticlesCount = function()
			{
				return (((is_real(ID)) and (part_system_exists(ID))) ? part_particles_count(ID)
																	 : undefined);
			}
			
			// @returns				{layerID} | On error: {undefined}
			// @description			Return the ID of the layer the system is internally operated in.
			static getLayer = function()
			{
				return (((is_real(ID)) and (part_system_exists(ID))) ? part_system_get_layer(ID)
																	 : undefined);
			}
			
		#endregion
		#region <Execution>
			
			// @description			Render the created Particles.
			static render = function()
			{
				if ((is_real(ID)) and (part_system_exists(ID)))
				{
					part_system_drawit(ID);
				}
			}
			
			// @description			Advance all actions of created Particles.
			static update = function()
			{
				if ((is_real(ID)) and (part_system_exists(ID)))
				{
					part_system_update(ID);
				}
			}
			
			// @description			Remove all currently existing Particles of this Particle System.
			static clear_particles = function()
			{
				if ((is_real(ID)) and (part_system_exists(ID)))
				{
					part_particles_clear(ID);
				}
			}
			
			// @argument			{ParticleType} particleType
			// @description			Create a Particle Emitter in this Particle System.
			static create_emitter = function()
			{
				if ((is_real(ID)) and (part_system_exists(ID)))
				{
					var _element = new ParticleEmitter(argument[0]);
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the ID and draw sorting 
			//						properties of this Particle System.
			static toString = function()
			{
				if ((is_real(ID)) and (part_system_exists(ID)))
				{
					var _mark_separator = ", ";
					
					var _label_drawSorting = "";
					var _value_drawSorting = "";
					var _separator_drawSorting = "";
					
					if (layer != undefined)
					{
						_label_drawSorting = "Layer: ";
						_value_drawSorting = string(layer);
						_separator_drawSorting = _mark_separator;
					}
					else if (depth != undefined)
					{
						_label_drawSorting = "Depth: ";
						_value_drawSorting = string(depth);
					}
					
					return (instanceof(self) + 
							"(" +
							"ID: " + string(ID) + _mark_separator +
							_label_drawSorting + _value_drawSorting + _separator_drawSorting +
							"Persistent: " + string(persistent) +
							")");
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
