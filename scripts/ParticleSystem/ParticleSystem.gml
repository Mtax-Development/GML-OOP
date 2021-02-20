/// @function				ParticleSystem()
/// @argument				{Layer|layer} layer?
/// @argument				{bool} persistent?
///
/// @description			Construct a Particle System resource, required to create particles of
///							each Particle Type.
///
///							Construction methods:
///							- New constructor
///							- Constructor copy: {ParticleSystem} other
function ParticleSystem() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				layer = undefined;
				persistent = undefined;
					
				depth = undefined;
					
				location = undefined;
					
				automaticUpdate = undefined;
				automaticRender = undefined;
					
				drawOrder_oldToNew = undefined;
					
				emitterList = undefined;
				
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
					if (argument_count > 0) {layer = argument[0];}
					if (argument_count > 1) {persistent = argument[1];}
					
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
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (part_system_exists(ID)));
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
			
			// @description			Recreate the Particle System with its initial properties.
			static clear = function()
			{
				if ((is_real(ID)) and (part_system_exists(ID)))
				{
					part_system_destroy(ID);
				}
				
				script_execute_ext(method_get_index(self.construct), argument_original);
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{int} depth
			// @description			Set a render depth that is independent from a Layer depth.
			static setDepth = function(_depth)
			{
				if ((is_real(ID)) and (part_system_exists(ID)))
				{
					depth = _depth;
					
					layer = undefined;
					persistent = false;
					
					part_system_depth(ID, depth);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setDepth";
					var _errorText = ("Attempted to set a property of an invalid Particle System:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Layer|layer} layer
			// @description			Set the render depth to a Layer, independent from invidual depth.
			static setLayer = function(_layer)
			{
				if ((is_real(ID)) and (part_system_exists(ID)))
				{
					var _layer_target = ((instanceof(layer) == "Layer") ? layer.ID : layer);
					
					if ((is_real(_layer_target)) and (layer_exists(_layer_target)))
					{
						layer = _layer;
						depth = undefined;
						
						part_system_layer(ID, _layer_new);
					}
					else
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "setLayer";
						var _errorText = ("Attempted to set a Particle System to an invalid " +
										  "Layer:\n" +
										  "Self: " + "{" + string(self) + "}" + "\n" +
										  "Other: " + "{" + string(_layer) + "}");
						_errorReport.reportConstructorMethod(self, _callstack, _methodName,
															 _errorText);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setLayer";
					var _errorText = ("Attempted to set a property of an invalid Particle System:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
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
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setLocation";
					var _errorText = ("Attempted to set a property of an invalid Particle System:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
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
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setAutomaticUpdate";
					var _errorText = ("Attempted to set a property of an invalid Particle System:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
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
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setAutomaticRender";
					var _errorText = ("Attempted to set a property of an invalid Particle System:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
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
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setDrawOrder_oldToNew";
					var _errorText = ("Attempted to set a property of an invalid Particle System:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{int}
			// @description			Return a number of currently existing Particles of this Particle
			//						System.
			static getParticlesCount = function()
			{
				if ((is_real(ID)) and (part_system_exists(ID)))
				{
					return part_particles_count(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getParticlesCount";
					var _errorText = ("Attempted to get a property of an invalid Particle System:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return 0;
				}
			}
			
			// @returns				{int:layer} | On error: {noone}
			// @description			Return the ID of the layer the system is internally operated in.
			static getLayer = function()
			{
				if ((is_real(ID)) and (part_system_exists(ID)))
				{
					return part_system_get_layer(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getLayer";
					var _errorText = ("Attempted to get a property of an invalid Particle System:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
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
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "render";
					var _errorText = ("Attempted to render an invalid Particle System:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @description			Advance all actions of created Particles.
			static update = function()
			{
				if ((is_real(ID)) and (part_system_exists(ID)))
				{
					part_system_update(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "update";
					var _errorText = ("Attempted to update an invalid Particle System:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
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
			// @returns				{ParticleEmitter} | On error: {noone}
			// @description			Create a Particle Emitter in this Particle System.
			static create_emitter = function()
			{
				if ((is_real(ID)) and (part_system_exists(ID)))
				{
					return new ParticleEmitter(argument[0]);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "create_emitter";
					var _errorText = ("Attempted to add Element to an invalid Particle System:\n" +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return noone;
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
						
						particleType = undefined;
						
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
					
					// @returns				{bool}
					// @description			Check if this constructor is functional.
					static isFunctional = function()
					{
						return ((instanceof(parent) == "ParticleSystem") and (is_real(parent.ID))
						and (part_system_exists(parent.ID)) and (part_emitter_exists(parent.ID, ID))
						and (instanceof(particleType) == "ParticleType")
						and (part_type_exists(particleType.ID)));
					}
					
					// @returns				{undefined}
					// @description			Remove the internal information from the memory.
					static destroy = function()
					{
						if ((instanceof(parent) == "ParticleSystem") and (is_real(parent.ID))
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
						if ((instanceof(parent) == "ParticleSystem") and (is_real(parent.ID))
						and (part_system_exists(parent.ID)) and (part_emitter_exists(parent.ID, ID)))
						{
							location = _location;
							shape = _shape;
							distribution = _distribution;
							
							part_emitter_region(parent.ID, ID, location.x1, location.x2,
												location.y1, location.y2, shape, distribution);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setRegion";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Particle System:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
					}
					
					// @argument			{int} number
					// @description			Set the number of created particles during a stream.
					static setStreamNumber = function(_number)
					{
						if ((instanceof(parent) == "ParticleSystem") and (is_real(parent.ID))
						and (part_system_exists(parent.ID)) and (part_emitter_exists(parent.ID, ID)))
						{
							streamNumber = _number;
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setStreamNumber";
							var _errorText = ("Attempted to set a property on invalid Element or " +
											  "Particle System:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
					}
					
					// @argument			{bool} streamEnabled
					// @description			Toggle continous particle streaming.
					static setStreamEnabled = function(_streamEnabled)
					{
						if ((instanceof(parent) == "ParticleSystem") and (is_real(parent.ID))
						and (part_system_exists(parent.ID)) and (part_emitter_exists(parent.ID, ID)))
						{
							streamEnabled = _streamEnabled;
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setStreamEnabled";
							var _errorText = ("Attempted to set a property on invalid Element or " +
											  "Particle System:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
					}
					
				#endregion
				#region <<Execution>>
					
					// @argument			{int} number
					// @description			Create a number of Particles within the region.
					static burst = function(_number)
					{
						if ((instanceof(parent) == "ParticleSystem") and (is_real(parent.ID))
						and (part_system_exists(parent.ID)) and (part_emitter_exists(parent.ID, ID))
						and (instanceof(particleType) == "ParticleType")
						and (part_type_exists(particleType.ID)))
						{
							part_emitter_burst(parent.ID, ID, particleType.ID, _number);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "burst";
							var _errorText = ("Attempted to emit Praticles using an invalid " +
											  "Particle Emitter, Particle System or Particle " +
											  "Type:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}" + "\n" +
											  "Target: " + "{" + string(particleType));
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
					}
					
					// @description			Continously create Particles using the stream 
					//						configuration.
					static stream = function()
					{
						if ((instanceof(parent) == "ParticleSystem") and (is_real(parent.ID))
						and (part_system_exists(parent.ID)) and (part_emitter_exists(parent.ID, ID))
						and (instanceof(particleType) == "ParticleType")
						and (part_type_exists(particleType.ID)))
						{
							var _number = ((streamEnabled) ? streamNumber : 0);
							
							part_emitter_stream(parent.ID, ID, particleType.ID, _number);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "stream";
							var _errorText = ("Attempted to emit Praticles using an invalid " +
											  "Particle Emitter, Particle System or Particle " +
											  "Type:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}" + "\n" +
											  "Target: " + "{" + string(particleType));
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
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
	#region [Constructor]
		
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
