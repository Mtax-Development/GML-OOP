/// @function				Layer()
/// @argument				{int} depth
/// @argument				{string} name?
///							
/// @description			Construct a Layer resource, used to group graphical elements and sort 
///							their rendering depth.
///							
///							Construction types:
///							- New constructor
///							- Wrapper: {string} name
///							- Empty: {void|undefined}
///							- Constructor copy: {Layer} other, {string} name?
///							   Information about object instances will not be copied.
function Layer() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty
				ID = undefined;
				name = undefined;
				
				depth = undefined;
				
				location = undefined;
				speed = undefined;
				
				visible = undefined;
				instancesPaused = undefined;
				
				shader = undefined;
				
				function_drawBegin = undefined;
				function_drawEnd = undefined;
				
				instanceList = undefined;
				spriteList = undefined;
				backgroundList = undefined;
				tilemapList = undefined;
				particleSystemList = undefined;
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (instanceof(argument[0]) == "Layer")
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						depth = _other.depth;
						
						if ((argument_count > 1) and (is_string(argument[1])))
						{
							name = argument[1];
							ID = layer_create(depth, name);
						}
						else
						{
							ID = layer_create(depth);
							name = layer_get_name(ID);
						}
						
						location = new Vector2(_other.location);
						self.setLocation(location);
						
						speed = new Vector2(_other.speed);
						self.setSpeed(speed);
						
						visible = _other.visible;
						setVisible(visible);
						
						instancesPaused = false;
						
						shader = ((instanceof(_other.shader) == "Shader") ? new Shader(_other.shader)
																		  : _other.shader);
						
						function_drawBegin = _other.function_drawBegin;
						function_drawEnd = _other.function_drawEnd;
						
						if (function_drawBegin != undefined)
						{
							self.setFunctionDrawBegin(function_drawBegin);
						}
						
						if (function_drawEnd != undefined)
						{
							self.setFunctionDrawEnd(function_drawEnd);
						}
						
						if (instanceof(shader) == "Shader")
						{
							self.setShader(shader);
						}
						
						instanceList = new List();
						spriteList = new List();
						backgroundList = new List();
						tilemapList = new List();
						particleSystemList = new List();
						
						var _elementList = [_other.spriteList, _other.backgroundList, 
											_other.tilemapList, _other.particleSystemList];
						var _elementType = [SpriteElement, BackgroundElement, TilemapElement,
											ParticleSystem];
						
						var _i = [0, 0];
						repeat (array_length(_elementList))
						{
							_i[1] = 0;
							repeat (_elementList[_i[0]].getSize())
							{
								var _ = new _elementType[_i[0]](_elementList[_i[0]].getValue(_i[1]));
								
								++_i[1];
							}
							
							++_i[0];
						}
					}
					else
					{
						if (is_string(argument[0]))
						{
							//|Construction type: Wrapper.
							var _name = argument[0];
							
							name = _name;
							ID = layer_get_id(name);
							
							depth = layer_get_depth(ID);
							
							location = new Vector2(layer_get_x(ID), layer_get_y(ID));
							speed = new Vector2(layer_get_hspeed(ID), layer_get_vspeed(ID));
							
							visible = layer_get_visible(ID);
							instancesPaused = undefined;
							
							function_drawBegin = layer_get_script_begin(ID);
							function_drawEnd = layer_get_script_end(ID);
							
							shader = layer_get_shader(ID);
							
							instanceList = new List();
							spriteList = new List();
							backgroundList = new List();
							tilemapList = new List();
							particleSystemList = new List();
							
							var _elements = layer_get_all_elements(ID);
						
							var _i = 0;
							repeat (array_length(_elements))
							{
								var _type = layer_get_element_type(_elements[_i]);
								
								switch (_type)
								{
									case layerelementtype_instance:
										instanceList.add(layer_instance_get_instance(_elements[_i]));
									break;
									
									case layerelementtype_sprite:
										var _ = new SpriteElement(_elements[_i]);
									break;
									
									case layerelementtype_background:
										var _ = new BackgroundElement(_elements[_i]);
									break;
									
									case layerelementtype_tilemap:
										var _ = new TilemapElement(_elements[_i]);
									break;
									
									case layerelementtype_particlesystem:
										var _ = new ParticleSystem(_elements[_i]);
									break;
								}
								
								++_i;
							}
						}
						else
						{
							//Construction type: New constructor.
							depth = argument[0];
							
							location = new Vector2(0, 0);
							speed = new Vector2(0, 0);
							
							visible = true;
							instancesPaused = false;
							
							function_drawBegin = undefined;
							function_drawEnd = undefined;
							
							shader = undefined;
							
							instanceList = new List();
							spriteList = new List();
							backgroundList = new List();
							tilemapList = new List();
							particleSystemList = new List();
							
							if ((argument_count > 1) and (is_string(argument[1])))
							{
								name = argument[1];
								ID = layer_create(depth, name);
							}
							else
							{
								ID = layer_create(depth);
								name = layer_get_name(ID);
							}
						}
					}
				}
				
				return self;
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (layer_exists(ID)));
			}
			
			// @argument			{bool} forceDestruction?
			// @returns				{undefined}
			// @description			Remove the internal information from the memory.
			//						If there are persistent instances bound to this Layer, they will
			//						be not be destroyed, unless the destruction is forced, but all
			//						Data Structures of this Layer will be always destroyed.
			static destroy = function(_forceDestruction = false)
			{
				var _persistentElementExists = false;
				
				if (instanceof(instanceList) == "List")
				{
					if (!_forceDestruction)
					{
						var _i = 0;
						repeat (instanceList.getSize())
						{
							var _instance = instanceList.getValue(_i);
							
							if ((instance_exists(_instance)) and (_instance.persistent))
							{
								_persistentElementExists = true;
								break;
							}
							
							++_i;
						}
					}
					
					instanceList = instanceList.destroy();
				}
				
				if (instanceof(spriteList) == "List")
				{
					spriteList = spriteList.destroy();
				}
				
				if (instanceof(backgroundList) == "List")
				{
					backgroundList = backgroundList.destroy();
				}
				
				if (instanceof(tilemapList) == "List")
				{
					tilemapList = tilemapList.destroy();
				}
				
				if (instanceof(particleSystemList) == "List")
				{
					var _i = 0;
					repeat (particleSystemList.getSize())
					{
						var _particleSystem = particleSystemList.getValue(_i);
						
						if (_particleSystem.isFunctional())
						{
							if (_particleSystem.persistent)
							{
								_persistentElementExists = true;
								
								if (_forceDestruction)
								{
									_particleSystem.destroy();
								}
							}
							else
							{
								_particleSystem.destroy();
							}
						}
						
						++_i;
					}
					
					particleSystemList = particleSystemList.destroy();
				}
				
				if (((_forceDestruction) or (!_persistentElementExists)) and (is_real(ID))
				and (layer_exists(ID)))
				{
					layer_destroy(ID);
					
					ID = undefined;
				}
				
				return undefined;
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{int:instance} instance
			// @returns				{bool} | On error: {undefined}
			// @description			Check whether the specified instance is bound to this Layer.
			static hasInstance = function(_instance)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					return layer_has_instance(ID, _instance);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "hasInstance";
					var _errorText = ("Attempted to get Element of an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{int[]}
			// @description			Return the array of all internal element IDs held by this Layer.
			static getElements = function()
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					return layer_get_all_elements(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getElements";
					var _errorText = ("Attempted to get Elements of an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return [];
				}
			}
		#endregion
		#region <Setters>
			
			// @argument			{Vector2} location
			// @description			Change the rendering offset for Elements of this Layer except
			//						object instances.
			static setLocation = function(_location)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					location = _location;
					
					layer_x(ID, location.x);
					layer_y(ID, location.y);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setLocation";
					var _errorText = ("Attempted to set a property of an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{Vector2} speed
			// @description			Set the horizontal and vertical speed of Elements of this Layer
			//						except object instances.
			static setSpeed = function(_speed)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					speed = _speed;
					
					layer_hspeed(ID, speed.x);
					layer_vspeed(ID, speed.y);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setSpeed";
					var _errorText = ("Attempted to set a property of an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{bool} visible
			// @description			Set the visiblity property for all elements of this Layer.
			//						Instances on a Layer that is not visible will not have their
			//						Draw Events run.
			static setVisible = function(_visible)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					visible = _visible;
					
					layer_set_visible(ID, visible);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setVisible";
					var _errorText = ("Attempted to set a property of an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{int} depth
			// @description			Set depth of this Layer, which dictates its render sorting.
			static setDepth = function(_depth)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					depth = _depth;
					
					layer_depth(ID, depth);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setDepth";
					var _errorText = ("Attempted to set a property of an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{Shader} shader
			// @description			Set a Shader that will be applied to every Element of this Layer.
			static setShader = function(_shader)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					shader = _shader;
					
					layer_shader(ID, shader.ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setShader";
					var _errorText = ("Attempted to set a property of an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{function} function
			// @description			Set a function that will be called during the Draw Begin of
			//						this Layer.
			static setFunctionDrawBegin = function(_function)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					function_drawBegin = _function;
					
					layer_script_begin(ID, function_drawBegin);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setFunctionDrawBegin";
					var _errorText = ("Attempted to set a property of an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{function} function
			// @description			Set a function that will be called during the Draw End of
			//						this Layer.
			static setFunctionDrawEnd = function(_function)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					function_drawEnd = _function;
					
					layer_script_end(ID, function_drawEnd);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setFunctionDrawEnd";
					var _errorText = ("Attempted to set a property of an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{Sprite} sprite
			// @returns				{Layer.BackgroundElement} | On error: {noone}
			// @description			Create a Background Element on this Layer and return it.
			static createBackground = function(_sprite)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					var _element = new BackgroundElement(_sprite);
					
					return _element;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "createBackground";
					var _errorText = ("Attempted to add an Element to an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return noone;
				}
			}
			
			// @argument			{int:object} object
			// @argument			{Vector2} location?
			// @returns				{int:instance} | On error: {noone}
			// @description			Create an instance on this Layer and return its internal ID.
			static createInstance = function(_object, _location)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					var _location_x = 0;
					var _location_y = 0;
					
					if (_location != undefined)
					{
						_location_x = _location.x;
						_location_y = _location.y;
					}
					
					var _instance = instance_create_layer(_location_x, _location_y, ID, _object);
					
					instanceList.add(_instance);
					
					return _instance;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "createInstance";
					var _errorText = ("Attempted to add an Element to an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return noone;
				}
			}
			
			// @argument			{tileset} tileset
			// @argument			{Vector2} location
			// @argument			{Vector2} size
			// @returns				{Layer.TilemapElement} | On error: {noone}
			// @description			Create a Tilemap Element on this Layer at the specified specified
			//						location in the room and cell size and return it.
			static createTilemap = function(_tileset, _location, _size)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					var _element = new TilemapElement(_tileset, _location, _size);
					
					return _element;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "createTilemap";
					var _errorText = ("Attempted to add an Element to an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return noone;
				}
			}
			
			// @argument			{Sprite|Layer.SpriteElement|int:spriteElement} sprite
			// @argument			{Vector2} location
			// @returns				{Layer.SpriteElement} | On error: {noone}
			// @description			Create a Sprite Element on this Layer and return it.
			static createSprite = function(_sprite, _location)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					var _element = new SpriteElement(_sprite, _location);
					
					return _element;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "createSprite";
					var _errorText = ("Attempted to add an Element to an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return noone;
				}
			}
			
			// @argument			{bool} persistent?
			// @returns				{Layer.ParticleSystem} | On error: {noone}
			// @description			Create a Particle System in this Layer and return it.
			static createParticleSystem = function(_persistent = false)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					var _element = new ParticleSystem(_persistent);
					
					return _element;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "createParticleSystem";
					var _errorText = ("Attempted to add an Element to an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return noone;
				}
			}
			
			// @argument			{int:instance|int:object|all} target
			// @description			Destroy the specified or all instances or objects of this Layer.
			//						If {all} is specified, the instances will be destroyed instantly.
			//						Otherwise, they will remain until the next application frame.
			static destroyInstance = function(_target)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					if (_target == all)
					{
						instanceList.clear();
						
						layer_destroy_instances(ID);
					}
					else
					{
						var _i = 0;
						repeat (instanceList.getSize())
						{
							var _instance = instanceList.getValue(_i);
							
							if ((_instance.id == _target) or (_instance.object_index == _target))
							{
								instance_destroy(_instance);
								
								instanceList.removePosition(_i);
							}
							else
							{
								++_i;
							}
						}
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "destroyInstances";
					var _errorText = ("Attempted to remove Elements from an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{bool} instancesPaused
			// @description			Activate or deactivate all instances bound to this Layer.
			static setInstancePause = function(_instancesPaused)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					if (_instancesPaused)
					{
						instancesPaused = true;
						
						instance_deactivate_layer(ID);
					}
					else
					{
						instancesPaused = false;
						
						instance_activate_layer(ID);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setInstancePause";
					var _errorText = ("Attempted to set a property of an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @argument			{bool} full?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the name and depth of this
			//						Layer.
			static toString = function(_multiline = false, _full = false)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					var _string = "";
					var _mark_separator = ((_multiline) ? "\n" : ", ");
					
					if (!_full)
					{
						_string = ("Name: " + string(name) + _mark_separator +
								   "Depth: " + string(depth));
					}
					else
					{
						var _string_function_drawBegin = ((is_real(function_drawBegin))
														  ? script_get_name(function_drawBegin)
														  : string(function_drawBegin));
						var _string_function_drawEnd = ((is_real(function_drawEnd))
														? script_get_name(function_drawEnd)
														: string(function_drawEnd));
						
						_string = ("Name: " + string(name) + _mark_separator +
								   "Depth: " + string(depth) + _mark_separator +
								   "Location: " + string(location) + _mark_separator +
								   "Speed: " + string(speed) + _mark_separator +
								   "Visible: " + string(visible) + _mark_separator +
								   "Instances Paused: " + string(instancesPaused)
														+ _mark_separator +
								   "Function (Draw Begin): " + _string_function_drawBegin
															 + _mark_separator +
								   "Function (Draw End): " + _string_function_drawEnd
														   + _mark_separator +
								   "Shader: " + string(shader) + _mark_separator +
								   "Instance List: " + string(instanceList) + _mark_separator +
								   "Sprite List: " + string(spriteList) + _mark_separator +
								   "Background List: " + string(backgroundList) + _mark_separator +
								   "Tilemap List: " + string(tilemapList) + _mark_separator +
								   "Particle System List: " + string(particleSystemList));
					}
					
					return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
		#endregion
	#endregion
	#region [Elements]
		
		// @function			Layer.SpriteElement()
		// @argument			{Sprite} sprite
		//						
		// @description			Construct a Sprite Element used to draw a Sprite on this Layer.
		//						
		//						Construction types:
		//						- New element.
		//						- Wrapper: {spriteElement} spriteElement
		//						- Constructor copy: {Layer.SpriteElement} other
		function SpriteElement() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					// @description			Initialize the constructor.
					static construct = function()
					{
						parent = other;
						parent.spriteList.add(self);
						
						ID = undefined;
						sprite = undefined;
						location = undefined;
						scale = undefined;
						angle = undefined;
						color = undefined;
						alpha = undefined;
						frame = undefined;
						speed = undefined;
						
						var _instanceof_self = instanceof(self);
						var _instanceof_other = instanceof(argument[0]);
						
						switch (_instanceof_other)
						{
							case _instanceof_self:
								//|Construction type: Constructor copy.
								var _other = argument[0];
								
								sprite = new Sprite(_other.sprite.ID);
								location = new Vector2(_other.location);
								
								ID = layer_sprite_create(parent.ID, location.x, location.y,
														 sprite.ID);
								
								scale = new Scale(_other.scale);
								angle = new Angle(_other.angle);
								color = _other.color;
								alpha = _other.alpha;
								frame = _other.frame;
								speed = _other.speed;
								
								layer_sprite_xscale(ID, scale.x);
								layer_sprite_yscale(ID, scale.y);
								layer_sprite_angle(ID, angle.value);
								layer_sprite_blend(ID, color);
								layer_sprite_alpha(ID, alpha);
								layer_sprite_index(ID, frame);
								layer_sprite_speed(ID, speed);
							break;
							
							case "Sprite":
								//|Construction type: New element.
								sprite = argument[0];
								location = argument[1];
								
								ID = layer_sprite_create(parent.ID, location.x, location.y,
														 sprite.ID);
								
								angle = new Angle(0);
								scale = new Scale(1, 1);
								color = c_white;
								alpha = 1;
								frame = 0;
								speed = 0;
							break;
							
							default:
								//|Construction type: Wrapper.
								ID = argument[0];
								
								sprite = layer_sprite_get_sprite(ID);
								location = new Vector2(layer_sprite_get_x(ID),
													   layer_sprite_get_y(ID));
								angle = new Angle(layer_sprite_get_angle(ID));
								scale = new Scale(layer_sprite_get_xscale(ID),
												  layer_sprite_get_yscale(ID));
								color = layer_sprite_get_blend(ID)
								alpha = layer_sprite_get_alpha(ID)
								frame = layer_sprite_get_index(ID)
								speed = layer_sprite_get_speed(ID)
							break;
						}
						
						return self;
					}
					
					// @returns				{bool}
					// @description			Check if this constructor is functional.
					static isFunctional = function()
					{
						return ((instanceof(parent) == "Layer") and (parent.isFunctional()))
								and (layer_sprite_exists(parent.ID, ID));
					}
					
					// @argument			{Layer|int:layer|string:layer} other
					// @description			Move this Element to another Layer.
					static changeParent = function(_other)
					{
						if (self.isFunctional())
						{
							if ((instanceof(_other) == "Layer") and (_other.isFunctional()))
							{
								parent.spriteList.removeValue(self);
								parent = _other;
								parent.spriteList.add(self);
								
								layer_element_move(ID, parent.ID);
							}
							else if (((is_real(_other)) or (is_string(_other)))
							and (layer_exists(_other)))
							{
								parent.spriteList.removeValue(self);
								parent = undefined;
								
								layer_element_move(ID, _other);
							}
							else
							{
								var _errorReport = new ErrorReport();
								var _callstack = debug_get_callstack();
								var _methodName = "changeParent";
								var _errorText = ("Attempted a parent change to an invalid Layer:" +
												  "\n" +
												  "Self: " + "{" + string(self) + "}" + "\n" +
												  "Parent: " + "{" + string(parent) + "}" + "\n" +
												  "Other: " + "{" + string(_other) + "}");
								_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																	 _errorText);
							}
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "changeParent";
							var _errorText = ("Attempted a parent change on invalid Element or " +
											  "invalid Parent:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @returns				{undefined}
					// @description			Remove the internal information from the memory.
					static destroy = function()
					{
						if (instanceof(parent) == "Layer")
						{
							 if (instanceof(parent.spriteList) == "List")
							 {
								parent.spriteList.removeValue(self);
							 }
						}
						
						if (self.isFunctional())
						{
							layer_sprite_destroy(ID);
						}
						
						return undefined;
					}
					
				#endregion
				#region <<Setters>>
					
					// @argument			{Sprite|int:-1} sprite?
					// @description			Set the Sprite of this Sprite Element. If it is not
					//						specified or specified as -1, the Sprite will be cleared.
					static setSprite = function(_sprite)
					{
						if (self.isFunctional())
						{
							if ((_sprite == undefined) or (_sprite == -1))
							{
								sprite = undefined;
								
								layer_sprite_change(ID, -1);
							}
							else
							{
								sprite = _sprite;
								
								layer_sprite_change(ID, sprite.ID);
							}
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setStretch";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @argument			{Scale} scale
					// @description			Set the scale property of this Sprite Element.
					static setScale = function(_scale)
					{
						if (self.isFunctional())
						{
							scale = _scale;
							
							layer_sprite_xscale(ID, scale.x);
							layer_sprite_yscale(ID, scale.y);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setScale";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @argument			{int:color} color
					// @description			Set the color property of this Sprite Element.
					static setColor = function(_color)
					{
						if (self.isFunctional())
						{
							color = _color;
							
							layer_sprite_blend(ID, color);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setColor";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @argument			{real} alpha
					// @description			Set the alpha property of this Sprite Element.
					static setAlpha = function(_alpha)
					{
						if (self.isFunctional())
						{
							alpha = _alpha;
							
							layer_sprite_alpha(ID, alpha);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setAlpha";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @argument			{int} frame
					// @description			Set the current Sprite frame of this Sprite Element.
					static setFrame = function(_frame)
					{
						if (self.isFunctional())
						{
							frame = _frame;
							
							layer_sprite_index(ID, frame);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setFrame";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					
					// @argument			{real} speed
					// @description			Set the Sprite speed property of this Sprite Element.
					static setSpeed = function(_speed)
					{
						if (self.isFunctional())
						{
							speed = _speed;
							
							layer_sprite_speed(ID, speed);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setSpeed";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
				#endregion
				#region <<Conversion>>
					
					// @argument			{bool} multiline?
					// @argument			{bool} full?
					// @returns				{string}
					// @description			Create a string representing this constructor.
					//						Overrides the string() conversion.
					//						Content will be represented with the properties of this
					//						Sprite Element.
					static toString = function(_multiline = false, _full = false)
					{
						var _constructorName = "Layer.SpriteElement";
						
						if (self.isFunctional())
						{
							var _string = "";
							var _mark_separator = ((_multiline) ? "\n" : ", ");
							
							if (!_full)
							{
								_string = ("ID: " + string(ID) + _mark_separator +
										   "Sprite: " + string(sprite));
							}
							else
							{
								_string = ("ID: " + string(ID) + _mark_separator +
										   "Sprite: " + string(sprite) + _mark_separator +
										   "Location: " + string(location) + _mark_separator +
										   "Scale: " + string(scale) + _mark_separator +
										   "Angle: " + string(angle) + _mark_separator +
										   "Color: " + string(color) + _mark_separator +
										   "Alpha: " + string(alpha) + _mark_separator +
										   "Frame: " + string(frame) + _mark_separator +
										   "Speed: " + string(speed));
							}
							
							return ((_multiline) ? _string
												 : (_constructorName + "(" + _string + ")"));
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
				
				script_execute_ext(method_get_index(self.construct), argument_original);
				
			#endregion
		}
		
		// @function			Layer.BackgroundElement()
		// @argument			{Sprite} sprite
		//						
		// @description			Construct a Background Element used to draw a Background on this
		//						Layer.
		//						
		//						Construction types:
		//						- New element.
		//						- Wrapper: {backgroundElement} backgroundElement
		//						- Constructor copy: {Layer.BackgroundElement} other
		function BackgroundElement() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					// @description			Initialize the constructor.
					static construct = function()
					{
						parent = other;
						parent.backgroundList.add(self);
						
						ID = undefined;
						sprite = undefined;
						visible = undefined;
						stretch = undefined;
						tiled_x = undefined;
						tiled_y = undefined;
						scale = undefined;
						color = undefined;
						alpha = undefined;
						frame = undefined;
						speed = undefined;
						
						var _instanceof_self = instanceof(self);
						var _instanceof_other = instanceof(argument[0]);
						
						switch (_instanceof_other)
						{
							case _instanceof_self:
								//|Construction type: Constructor copy.
								var _other = argument[0];
								
								sprite = new Sprite(_other.sprite.ID);
								ID = layer_background_create(parent.ID, sprite.ID);
								
								visible = _other.visible;
								stretch = _other.stretch;
								tiled_x = _other.tiled_x;
								tiled_y = _other.tiled_y;
								scale = ((instanceof(_other.sprite) == "Scale")
										 ? new Scale(_other.scale) : _other.scale);
								color = _other.color;
								alpha = _other.alpha;
								frame = _other.frame;
								speed = _other.speed;
								
								layer_background_visible(ID, visible);
								layer_background_stretch(ID, stretch);
								layer_background_htiled(ID, tiled_x);
								layer_background_vtiled(ID, tiled_y);
								layer_background_xscale(ID, scale.x);
								layer_background_yscale(ID, scale.y);
								layer_background_blend(ID, color);
								layer_background_alpha(ID, alpha);
								layer_background_index(ID, frame);
								layer_background_speed(ID, speed);
							break;
							
							case "Sprite":
								//|Construction type: New element.
								sprite = argument[0];
								ID = layer_background_create(parent.ID, sprite.ID);
								
								visible = true;
								stretch = false;
								tiled_x = false;
								tiled_y = false;
								scale = new Scale(1, 1);
								color = c_white;
								alpha = 1;
								frame = 0;
								speed = 0;
							break;
							
							default:
								//|Construction type: Wrapper.
								ID = argument[0];
								
								sprite = new Sprite(layer_background_get_sprite(ID));
								visible = layer_background_get_visible(ID);
								stretch = layer_background_get_stretch(ID);
								tiled_x = layer_background_get_htiled(ID);
								tiled_y = layer_background_get_vtiled(ID);
								scale = new Scale(layer_background_get_xscale(ID),
												  layer_background_get_yscale(ID));
								color = layer_background_get_blend(ID)
								alpha = layer_background_get_alpha(ID)
								frame = layer_background_get_index(ID)
								speed = layer_background_get_speed(ID)
							break;
						}
						
						return self;
					}
					
					// @returns				{bool}
					// @description			Check if this constructor is functional.
					static isFunctional = function()
					{
						return ((instanceof(parent) == "Layer") and (parent.isFunctional()))
								and (layer_background_exists(parent.ID, ID));
					}
					
					// @argument			{Layer|int:layer|string:layer} other
					// @description			Move this Element to another Layer.
					static changeParent = function(_other)
					{
						if (self.isFunctional())
						{
							if ((instanceof(_other) == "Layer") and (layer_exists(_other.ID)))
							{
								parent.backgroundList.removeValue(self);
								parent = _other;
								parent.backgroundList.add(self);
								
								layer_element_move(ID, parent.ID);
							}
							else if (((is_real(_other)) or (is_string(_other)))
							and (layer_exists(_other)))
							{
								parent.backgroundList.removeValue(self);
								parent = undefined;
								
								layer_element_move(ID, _other);
							}
							else
							{
								var _errorReport = new ErrorReport();
								var _callstack = debug_get_callstack();
								var _methodName = "changeParent";
								var _errorText = ("Attempted a parent change to an invalid Layer:" +
												  "\n" +
												  "Self: " + "{" + string(self) + "}" + "\n" +
												  "Parent: " + "{" + string(parent) + "}" + "\n" +
												  "Other: " + "{" + string(_other) + "}");
								_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																	 _errorText);
							}
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "changeParent";
							var _errorText = ("Attempted a parent change on invalid Element or " +
											  "invalid Parent:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @returns				{undefined}
					// @description			Remove the internal information from the memory.
					static destroy = function()
					{
						if (instanceof(parent) == "Layer")
						{
							 if (instanceof(parent.spriteList) == "List")
							 {
								parent.backgroundList.removeValue(self);
							 }
						}
						
						if (self.isFunctional())
						{
							layer_background_destroy(ID);
						}
						
						return undefined;
					}
					
				#endregion
				#region <<Setters>>
					
					// @argument			{Sprite|int:-1} sprite?
					// @description			Set the Sprite of this Background Element. If it is not
					//						specified or specified as -1, the Sprite will be cleared.
					static setSprite = function(_sprite)
					{
						if (self.isFunctional())
						{
							if ((_sprite == undefined) or (_sprite == -1))
							{
								sprite = undefined;
								
								layer_background_change(ID, -1);
							}
							else
							{
								sprite = _sprite;
									
								layer_background_change(ID, sprite.ID);
							}
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setSprite";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @argument			{Scale} scale
					// @description			Set the scale property of this Background Element.
					static setScale = function(_scale)
					{
						if (self.isFunctional())
						{
							scale = _scale;
							
							layer_background_xscale(ID, scale.x);
							layer_background_yscale(ID, scale.y);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setScale";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @argument			{int:color} color
					// @description			Set the color property of this Background Element.
					static setColor = function(_color)
					{
						if (self.isFunctional())
						{
							color = _color;
							
							layer_background_blend(ID, color);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setColor";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @argument			{real} alpha
					// @description			Set the alpha property of this Background Element.
					static setAlpha = function(_alpha)
					{
						if (self.isFunctional())
						{
							alpha = _alpha;
							
							layer_background_alpha(ID, alpha);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setAlpha";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @argument			{int} frame
					// @description			Set the current Sprite frame of this Background Element.
					static setFrame = function(_frame)
					{
						if (self.isFunctional())
						{
							frame = _frame;
							
							layer_background_index(ID, frame);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setFrame";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @argument			{real} speed
					// @description			Set the Sprite speed property of this Background Element.
					static setSpeed = function(_speed)
					{
						if (self.isFunctional())
						{
							speed = _speed;
							
							layer_background_speed(ID, speed);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setSpeed";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @argument			{bool} stretch
					// @description			Set the scretch property of this Background Element.
					static setStretch = function(_stretch)
					{
						if (self.isFunctional())
						{
							stretch = _stretch;
							
							layer_background_stretch(ID, _stretch);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setStretch";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @argument			{bool} tiled_x?
					// @argument			{bool} tiled_y?
					// @description			Set the tiling properties of this Background Element for
					//						horizontal and vertical tiling respectively.
					static setTiled = function(_tiled_x, _tiled_y)
					{
						if (self.isFunctional())
						{
							if (_tiled_x != undefined) {tiled_x = _tiled_x;}
							if (_tiled_y != undefined) {tiled_y = _tiled_y;}
							
							layer_background_htiled(ID, tiled_x);
							layer_background_vtiled(ID, tiled_y);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setTiled";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @argument			{bool} visible
					// @description			Set the visibility property of this Background Element.
					static setVisible = function(_visible)
					{
						if (self.isFunctional())
						{
							visible = _visible;
							
							layer_background_visible(ID, visible);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setVisible";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
				#endregion
				#region <<Conversion>>
					
					// @argument			{bool} multiline?
					// @argument			{bool} full?
					// @returns				{string}
					// @description			Create a string representing this constructor.
					//						Overrides the string() conversion.
					//						Content will be represented with the properties of this
					//						Background Element.
					static toString = function(_multiline = false, _full = false)
					{
						var _constructorName = "Layer.BackgroundElement";
						
						if (self.isFunctional())
						{
							var _string = "";
							var _mark_separator = ((_multiline) ? "\n" : ", ");
							
							if (!_full)
							{
								_string = ("ID: " + string(ID) + _mark_separator +
										   "Sprite: " + string(sprite));
							}
							else
							{
								_string = ("ID: " + string(ID) + _mark_separator +
										   "Sprite: " + string(sprite) + _mark_separator +
										   "Visible: " + string(visible) + _mark_separator +
										   "Stretch: " + string(stretch) + _mark_separator +
										   "Tiled X: " + string(tiled_x) + _mark_separator +
										   "Tiled Y: " + string(tiled_y) + _mark_separator +
										   "Scale: " + string(scale) + _mark_separator +
										   "Color: " + string(color) + _mark_separator +
										   "Alpha: " + string(alpha) + _mark_separator +
										   "Frame: " + string(frame) + _mark_separator +
										   "Speed: " + string(speed));
							}
							
							return ((_multiline) ? _string
												 : (_constructorName + "(" + _string + ")"));
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
				
				script_execute_ext(method_get_index(self.construct), argument_original);
				
			#endregion
		}
		
		// @function			Layer.TilemapElement()
		// @argument			{int:tileset} tileset
		// @argument			{Vector2} location
		// @argument			{Vector2} size
		//						
		// @description			Construct a Tilemap Element used to draw Tiles from a Tileset on
		//						this Layer.
		//						
		//						Construction types:
		//						- New element.
		//						- Wrapper: {int} tilemapElement
		//						- Constructor copy: {Layer.TilemapElement} other
		function TilemapElement() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					// @description			Initialize the constructor.
					static construct = function()
					{
						parent = other;
						parent.tilemapList.add(self);
						
						ID = undefined;
						tileset = undefined;
						location = undefined;
						size = undefined;
						
						var _instanceof_self = instanceof(self);
						var _instanceof_other = instanceof(argument[0]);
						
						if ((argument_count > 0) and (_instanceof_other == _instanceof_self))
						{
							//|Construction type: Constructor copy.
							var _other = argument[0];
							
							tileset = _other.tileset;
							location = _other.location;
							size = _other.size;
							
							ID = layer_tilemap_create(parent.ID, location.x, location.y, tileset,
													  size.x, size.y);
						}
						else
						{
							if (argument_count > 2)
							{
								//|Construction type: New element.
								tileset = argument[0];
								location = argument[1];
								size = argument[2];
								
								ID = layer_tilemap_create(parent.ID, location.x, location.y, tileset,
														  size.x, size.y);
							}
							else
							{
								//|Construction type: Wrapper.
								ID = argument[0];
								
								tileset = tilemap_get_tileset(ID);
								location = new Vector2(tilemap_get_x(ID), tilemap_get_y(ID));
								size = new Vector2(tilemap_get_width(ID), tilemap_get_height(ID));
							}
						}
						
						return self;
					}
					
					// @returns				{bool}
					// @description			Check if this constructor is functional.
					static isFunctional = function()
					{
						return ((instanceof(parent) == "Layer") and (parent.isFunctional()))
								and (layer_tilemap_exists(parent.ID, ID));
					}
					
					// @returns				{undefined}
					// @description			Remove the internal information from the memory.
					static destroy = function()
					{
						if (self.isFunctional())
						{
							parent.tilemapList.removeValue(self);
							
							layer_tilemap_destroy(ID);
						}
						
						return undefined;
					}
					
					// @argument			{Layer.TilemapElement.TileData|int:tiledata} tiledata?
					// @description			Set all Tiles in this Tilemap to empty or the specified
					//						Tile Data.
					static clear = function(_tiledata)
					{
						if (self.isFunctional())
						{
							if (_tiledata == undefined)
							{
								tilemap_clear(ID, 0);
							}
							else if (string_copy(instanceof(_tiledata), 1, 8) == "TileData")
							{
								if (_tiledata.isFunctional())
								{
									tilemap_clear(ID, _tiledata.ID);
								}
								else
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "clear";
									var _errorText = ("Attempted to clear an Element using an" +
													  "invalid Tile: " +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}" +
													  "\n" + "Other: " + "{" + string(_tiledata) +
													  "}");
									_errorReport.reportConstructorMethod(self, _callstack,
																		 _methodName, _errorText);
								}
							}
							else
							{
								tilemap_clear(ID, _tiledata);
							}
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "clear";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @argument			{Layer|int:layer|string:layer} other
					// @description			Move this Element to another Layer.
					static changeParent = function(_other)
					{
						if (self.isFunctional())
						{
							if ((instanceof(_other) == "Layer") and (layer_exists(_other.ID)))
							{
								parent.tilemapList.removeValue(self);
								parent = _other;
								parent.tilemapList.add(self);
									
								layer_element_move(ID, parent.ID);
							}
							else if (((is_real(_other)) or (is_string(_other)))
							and (layer_exists(_other)))
							{
								parent.tilemapList.removeValue(self);
								parent = undefined;
									
								layer_element_move(ID, _other);
							}
							else
							{
								var _errorReport = new ErrorReport();
								var _callstack = debug_get_callstack();
								var _methodName = "changeParent";
								var _errorText = ("Attempted a parent change to an invalid Layer:" +
												  "\n" +
												  "Self: " + "{" + string(self) + "}" + "\n" +
												  "Parent: " + "{" + string(parent) + "}" + "\n" +
												  "Other: " + "{" + string(_other) + "}");
								_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																	 _errorText);
							}
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "changeParent";
							var _errorText = ("Attempted a parent change on invalid Element or " +
											  "invalid Parent:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
				#endregion
				#region <<Getters>>
					
					// @returns				{int} | On error: {undefined}
					// @description			Return the current Sprite frame of this Tilemap.
					static getFrame = function()
					{
						if (self.isFunctional())
						{
							return tilemap_get_frame(ID);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "getFrame";
							var _errorText = ("Attempted to get a property of an invalid Element " +
											  "or Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
							
							return undefined;
						}
					}
					
					// @returns				{int} | On error: {int:-1}
					// @description			Return the bit mask value for this Tilemap or 0 if there
					//						is none.
					static getMask = function()
					{
						if (self.isFunctional())
						{
							return tilemap_get_mask(ID);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "getMask";
							var _errorText = ("Attempted to get a property of an invalid Element " +
											  "or Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
							
							return -1;
						}
					}
					
					// @argument			{Vector2} location
					// @returns				{Layer.TilemapElement.TileData}
					// @description			Return a TileData referring to the Tile in a cell at the
					//						specified location.
					static getTileInCell = function(_location)
					{
						if (self.isFunctional())
						{
							return new TileData(tilemap_get(ID, _location.x, _location.y));
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "getTileInCell";
							var _errorText = ("Attempted to get an Element of an invalid Element " +
											  "or Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
							
							return new TileData(-1);
						}
					}
					
					// @argument			{Vector2} location
					// @returns				{Layer.TilemapElement.TileData}
					// @description			Return a TileData referring to the Tile at specified
					//						point in the Room.
					static getTileAtPoint = function(_location)
					{
						if (self.isFunctional())
						{
							return new TileData(tilemap_get_at_pixel(ID, _location.x, _location.y));
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "getTileAtPoint";
							var _errorText = ("Attempted to get an Element of an invalid Element " +
											  "or Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
							
							return new TileData(-1);
						}
					}
					
					// @argument			{Vector2} location
					// @returns				{Vector2} | On error: {undefined}
					// @description			Return the cell location for a Tile at specified point
					//						in space.
					static getCellAtPoint = function(_location)
					{
						if (self.isFunctional())
						{
							return new Vector2
							(
								tilemap_get_cell_x_at_pixel(ID, _location.x, _location.y),
								tilemap_get_cell_y_at_pixel(ID, _location.x, _location.y)
							);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "getCellAtPoint";
							var _errorText = ("Attempted to get a property of an invalid Element " +
											  "or Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
							
							return undefined;
						}
					}
					
				#endregion
				#region <<Setters>>
					
					// @argument			{int} mask
					// @description			Set the tile bit mask for this Tilemap.
					static setMask = function(_mask)
					{
						if (self.isFunctional())
						{
							tilemap_set_mask(ID, _mask);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setMap";
							var _errorText = ("Attempted to set a property on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @argument			{int:tileset} tileset
					// @description			Change the Tileset used by this Tilemap.
					static setTileset = function(_tileset)
					{
						if (self.isFunctional())
						{
							tileset = _tileset;
							
							tilemap_tileset(ID, tileset);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setTileset";
							var _errorText = ("Attempted to set a property on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @argument			{Vector2} size
					// @description			Set the size of this Tilemap, which is the number of Tile
					//						cells it will use.
					static setSize = function(_size)
					{
						if (self.isFunctional())
						{
							size = _size;
							
							tilemap_set_width(ID, size.x);
							tilemap_set_height(ID, size.y);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setSize";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
				#endregion
				#region <<Execution>>
					
					// @argument			{Vector2} location?
					// @description			Execute the draw of this Tilemap, independent of its draw
					//						executed by its Layer.
					static render = function(_location = new Vector2(0, 0))
					{
						if (self.isFunctional())
						{
							draw_tilemap(ID, _location.x, _location.y);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "render";
							var _errorText = ("Attempted to render an invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					

					// @argument			{Vector2} location
					// @argument			{Layer.TilemapElement.TileData|int:tiledata} tiledata?
					// @returns				{bool}
					// @description			Set the Tile at the specified cell to a Tile referred
					//						to by the specified Tile Data and return a boolean for
					//						confirmation whether the operation was a success or not. 
					//						If Tile Data is not provided or 0 is provided in its
					//						place, the cell will be cleared.
					static setTileInCell = function(_location, _tiledata)
					{
						if (self.isFunctional())
						{
							if (_tiledata == undefined)
							{
								_tiledata = 0;
							}
							else if (instanceof(_tiledata) == "TileData")
							{
								_tiledata = _tiledata.ID;
							}
							
							return ((_tiledata != -1)
									? tilemap_set(ID, _tiledata, _location.x, _location.y) : false);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setTileInCell";
							var _errorText = ("Attempted to set a property on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
							
							return false;
						}
					}
					
					// @argument			{Vector2} location
					// @argument			{Layer.TilemapElement.TileData|int:tiledata} tiledata?
					// @description			Set the Tile at the specified point in space to a Tile
					//						referred to by the specified Tile Data and return a
					//						boolean for confirmation whether the operation was a
					//						success or not.
					//						If Thile Data is not provided or 0 is provided in its
					//						place, the cell will be cleared.
					static setTileAtPoint = function(_location, _tiledata = 0)
					{
						if (self.isFunctional())
						{
							if (instanceof(_tiledata) == "TileData")
							{
								_tiledata = _tiledata.ID;
							}
							
							return ((_tiledata != -1)
									? tilemap_set_at_pixel(ID, _tiledata, _location.x, _location.y)
									: false);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setTileAtPoint";
							var _errorText = ("Attempted to set a property on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
							
							return false;
						}
					}
					
					
				#endregion
				#region <<Conversion>>
					
					// @returns				{string}
					// @description			Create a string representing this constructor.
					//						Overrides the string() conversion.
					//						Content will be represented with the properties of this
					//						Tilemap Element.
					static toString = function(_multiline = false)
					{
						var _constructorName = "Layer.TilemapElement";
						
						if (self.isFunctional())
						{
							var _mark_separator = ((_multiline) ? "\n" : ", ");
							
							var _string = ("ID: " + string(ID) + _mark_separator +
										   "Tileset: " + tileset_get_name(tileset) + 
													   _mark_separator +
										   "Location: " + string(location) + _mark_separator +
										   "Size: " + string(size));
							
							return ((_multiline) ? _string 
												 : (_constructorName + "(" + _string + ")"));
						}
						else
						{
							return (_constructorName + "<>");
						}
					}
					
				#endregion
			#endregion
			#region [[Elements]]
				
				// @function			Layer.TilemapElement.TileData()
				// @argument			{int} id?
				//						
				// @description			Constructs a TileData Element, which refers to a Tile in this
				//						Tilemap.
				//						
				//						Construction types:
				//						- New constructor
				//						- Constructor copy: {Layer.TilemapElement.TileData} other
				function TileData() constructor
				{
					#region [[[Methods]]]
						#region <<<Management>>>
							
							// @description			Initialize the constructor.
							static construct = function()
							{
								ID = 0;
								
								parent = other;
								
								if (argument_count > 0)
								{
									var _instanceof_self = instanceof(self);
									var _instanceof_other = instanceof(argument[0]);
									
									if (_instanceof_other == _instanceof_self)
									{
										//|Construction type: Constructor copy.
										var _other = argument[0];
									
										ID = _other.ID;
									}
									else
									{
										//|Construction type: New constructor.
										ID = argument[0];
									}
								}
								
								return self;
							}
							
							// @returns				{bool}
							// @description			Check if this constructor is functional.
							static isFunctional = function()
							{
								return ((ID >= 0));
							}
							
							// @description			Empty the Tile this Tile Data refers to.
							static clear = function()
							{
								if (!(ID >= 0))
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "clear";
									var _errorText = ("Attempted to set a property of an invalid " +
													  "Tile:\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}") + 
													  "\n" +
													  "Clearing the Tile ID to 0.";
									_errorReport.reportConstructorMethod([parent, self], _callstack,
																		 _methodName, _errorText);
									
									ID = 0;
								}
								
								ID = tile_set_empty(ID);
								
								return self;
							}
							
						#endregion
						#region <<<Getters>>>
							
							// @returns				{int}
							// @description			Return the index of the Tile this Tile Data 
							//						refers to on its tileset.
							static getTilesetIndex = function()
							{
								if (!(ID >= 0))
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "getTilesetIndex";
									var _errorText = ("Attempted to get a property of an invalid " +
													  "Tile:\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}") + 
													  "\n" +
													  "Clearing the Tile ID to 0.";
									_errorReport.reportConstructorMethod([parent, self], _callstack,
																		 _methodName, _errorText);
									
									ID = 0;
								}
								
								return tile_get_index(ID);
							}
							
							// @returns				{bool}
							// @description			Check if this Tile Data refers to an empty Tile.
							static isEmpty = function()
							{
								if (!(ID >= 0))
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "isEmpty";
									var _errorText = ("Attempted to get a property of an invalid " +
													  "Tile:\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}") + 
													  "\n" +
													  "Clearing the Tile ID to 0.";
									_errorReport.reportConstructorMethod([parent, self], _callstack,
																		 _methodName, _errorText);
									
									ID = 0;
								}
								
								return tile_get_empty(ID);
							}
							
							// @returns				{bool}
							// @description			Check if this Tile Data refers to a Tile that was
							//						mirrored horizontally.
							static isMirroredX = function()
							{
								if (!(ID >= 0))
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "isMirroredX";
									var _errorText = ("Attempted to get a property of an invalid " +
													  "Tile:\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}") + 
													  "\n" +
													  "Clearing the Tile ID to 0.";
									_errorReport.reportConstructorMethod([parent, self], _callstack,
																		 _methodName, _errorText);
									
									ID = 0;
								}
								
								return tile_get_mirror(ID);
							}
							
							// @returns				{bool}
							// @description			Check if this Tile Data refers to a Tile that was
							//						mirrored vertically.
							static isMirroredY = function()
							{
								if (!(ID >= 0))
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "isMirroredY";
									var _errorText = ("Attempted to get a property of an invalid " +
													  "Tile:\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}") + 
													  "\n" +
													  "Clearing the Tile ID to 0.";
									_errorReport.reportConstructorMethod([parent, self], _callstack,
																		 _methodName, _errorText);
									
									ID = 0;
								}
								
								return tile_get_flip(ID);
							}
							
							// @returns				{bool} | On error: {undefined}
							// @description			Check if this Tile Data refers to a Tile that was
							//						rotated by 90 degrees.
							static isRotated = function()
							{
								if (!(ID >= 0))
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "isRotated";
									var _errorText = ("Attempted to get a property of an invalid " +
													  "Tile:\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}") + 
													  "\n" +
													  "Clearing the Tile ID to 0.";
									_errorReport.reportConstructorMethod([parent, self], _callstack,
																		 _methodName, _errorText);
									
									ID = 0;
								}
								
								return tile_get_rotate(ID);
							}
							
						#endregion
						#region <<<Setters>>>
							
							// @argument			{int} index
							// @description			Change the Tile this Tile Data refers to, based
							//						on the index of its tileset.
							static setTilesetIndex = function(_index)
							{
								if (!(ID >= 0))
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "setTilesetIndex";
									var _errorText = ("Attempted to set a property of an invalid " +
													  "Tile:\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}") + 
													  "\n" +
													  "Clearing the Tile ID to 0.";
									_errorReport.reportConstructorMethod([parent, self], _callstack,
																		 _methodName, _errorText);
									
									ID = 0;
								}
								
								ID = tile_set_index(ID, _index);
								
								return self;
							}
							
							// @argument			{bool} mirror
							// @description			Set the horizontal mirroring property of the Tile
							//						this Tile Data refers to.
							static setMirrorX = function(_mirror)
							{
								if (!(ID >= 0))
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "setMirrorX";
									var _errorText = ("Attempted to set a property of an invalid " +
													  "Tile:\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}") + 
													  "\n" +
													  "Clearing the Tile ID to 0.";
									_errorReport.reportConstructorMethod([parent, self], _callstack,
																		 _methodName, _errorText);
									
									ID = 0;
								}
								
								ID = tile_set_mirror(ID, _mirror);
								
								return self;
							}
							
							// @argument			{bool} mirror
							// @description			Set the vertical mirroring property of the Tile
							//						this Tile Data refers to.
							static setMirrorY = function(_mirror)
							{
								if (!(ID >= 0))
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "setMirrorY";
									var _errorText = ("Attempted to set a property of an invalid " +
													  "Tile:\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}") + 
													  "\n" +
													  "Clearing the Tile ID to 0.";
									_errorReport.reportConstructorMethod([parent, self], _callstack,
																		 _methodName, _errorText);
									
									ID = 0;
								}
								
								ID = tile_set_flip(ID, _mirror);
								
								return self;
							}
							
							// @argument			{bool} rotate
							// @description			Set the 90 degree rotation property of the Tile
							//						this Tile Data refers to.
							static setRotate = function(_rotate)
							{
								if (!(ID >= 0))
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "setRotate";
									var _errorText = ("Attempted to set a property of an invalid " +
													  "Tile:\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}") + 
													  "\n" +
													  "Clearing the Tile ID to 0.";
									_errorReport.reportConstructorMethod([parent, self], _callstack,
																		 _methodName, _errorText);
									
									ID = 0;
								}
								
								ID = tile_set_rotate(ID, _rotate);
								
								return self;
							}
							
						#endregion
						#region <<<Execution>>>
							
							// @argument			{Vector2} location?
							// @argument			{int} frame?
							// @description			Execute the draw of the Tile this Tile Data
							//						refers to, independent of its draw handled
							//						by its Layer.
							static render = function(_location = new Vector2(0, 0), _frame = 0)
							{
								if (!(ID >= 0))
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "render";
									var _errorText = ("Attempted to render an invalid Tile:\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}") + 
													  "\n" +
													  "Clearing the Tile ID to 0.";
									_errorReport.reportConstructorMethod([parent, self], _callstack,
																		 _methodName, _errorText);
									
									ID = 0;
								}
								
								draw_tile(parent.tileset, ID, _frame, _location.x, _location.y);
								
								return self;
							}
							
						#endregion
						#region <<<Conversion>>>
							
							// @argument			{bool} multiline?
							// @returns				{string}
							// @description			Create a string representing this constructor.
							//						Overrides the string() conversion.
							//						Content will be represented with the ID of this
							//						Tile Data.
							static toString = function(_multiline = false)
							{
								var _constructorName = "Layer.TilemapElement.TileData";
								
								if (ID >= 0)
								{
									var _string = string(ID);
									
									return ((_multiline) ? _string
														 : (_constructorName + "(" + _string + ")"));
								}
								else
								{
									return (_constructorName + "<>");
								}
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
						
						script_execute_ext(method_get_index(self.construct), argument_original);
						
					#endregion
				}
				
			#endregion
			#region [[Constructor]]
				
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
		
		// @function			Layer.ParticleSystem()
		// @argument			{bool} persistent?
		//						
		// @description			Construct a Particle System Element used to create Particles of
		//						any Particle Type on this Layer.
		//						
		//						Construction types:
		//						- New element.
		//						- Constructor copy: {Layer.ParticleSystem} other
		function ParticleSystem() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					// @description			Initialize the constructor.
					static construct = function()
					{
						parent = other;
						parent.particleSystemList.add(self);
						
						ID = undefined;
						
						persistent = undefined;
						
						location = undefined;
						
						automaticUpdate = undefined;
						automaticRender = undefined;
						
						drawOrder_newerOnTop = undefined;
						
						emitterList = undefined;
						
						var _instanceof_self = instanceof(self);
						var _instanceof_other = ((argument_count > 0) ? instanceof(argument[0])
																	  : undefined);
						
						if ((argument_count > 0) and (_instanceof_other == _instanceof_self))
						{
							//|Construction type: Constructor copy.
							var _other = argument[0];
							
							persistent = _other.persistent;
							
							ID = part_system_create_layer(parent.ID, persistent);
							
							self.setLocation(_other.location);
							self.setAutomaticUpdate(_other.automaticUpdate);
							self.setAutomaticRender(_other.automaticRender);
							self.setDrawOrder(_other.drawOrder_newerOnTop);
							
							emitterList = new List();
							
							var _i = 0;
							repeat (_other.emitterList.getSize())
							{
								var _ = new ParticleEmitter(emitterList.getValue(_i));
								_ = undefined;
								
								++_i;
							}
						}
						else
						{
							//|Construction type: New constructor.
							persistent = (((argument_count > 0) and (argument[0] != undefined))
										  ? argument[0] : false);
							
							location = new Vector2(0, 0);
							
							automaticUpdate = true;
							automaticRender = true;
							
							drawOrder_newerOnTop = true;
							
							emitterList = new List();
							
							ID = part_system_create_layer(parent.ID, persistent);
						}
						
						return self;
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
							emitterList = emitterList.destroy();
						}
						
						if ((is_real(ID)) and (part_system_exists(ID)))
						{
							part_system_destroy(ID);
							
							ID = undefined;
						}
						
						return undefined;
					}
					
					// @description			Remove all Particles currently existing in this Particle
					//						System.
					static clear = function()
					{
						if ((is_real(ID)) and (part_system_exists(ID)))
						{
							part_particles_clear(ID);
						}
						
						return self;
					}
					
					// @argument			{Layer|int:layer|string:layer} other
					// @description			Move this Element to another Layer.
					static changeParent = function(_other)
					{
						if (self.isFunctional())
						{
							if ((instanceof(_other) == "Layer") and (layer_exists(_other.ID)))
							{
								parent.particleSystemList.removeValue(self);
								parent = _other;
								parent.particleSystemList.add(self);
									
								layer_element_move(ID, parent.ID);
							}
							else if (((is_real(_other)) or (is_string(_other)))
							and (layer_exists(_other)))
							{
								parent.particleSystemList.removeValue(self);
								parent = undefined;
									
								layer_element_move(ID, _other);
							}
							else
							{
								var _errorReport = new ErrorReport();
								var _callstack = debug_get_callstack();
								var _methodName = "changeParent";
								var _errorText = ("Attempted a parent change to an invalid Layer:" +
												  "\n" +
												  "Self: " + "{" + string(self) + "}" + "\n" +
												  "Parent: " + "{" + string(parent) + "}" + "\n" +
												  "Other: " + "{" + string(_other) + "}");
								_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																	 _errorText);
							}
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "changeParent";
							var _errorText = ("Attempted a parent change on invalid Element or " +
											  "invalid Parent:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
				#endregion
				#region <<Getters>>
					
					// @returns				{int}
					// @description			Return a number of currently existing Particles of this
					//						Particle System.
					static getParticleCount = function()
					{
						if ((is_real(ID)) and (part_system_exists(ID)))
						{
							return part_particles_count(ID);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "getParticleCount";
							var _errorText = ("Attempted to get a property of an invalid Particle " +
											  "System:\n" +
											  "{" + string(ID) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
							
							return 0;
						}
					}
					
				#endregion
				#region <<Setters>>
					
					// @argument			{Vector2} location
					// @description			Set the offset for the Particle render.
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
							var _errorText = ("Attempted to set a property of an invalid Particle " +
											  "System:\n" +
											  "{" + string(ID) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @argument			{bool} newerOnTop
					// @description			Set whether older Particles are drawn benath newer.
					static setDrawOrder = function(_newerOnTop)
					{
						if ((is_real(ID)) and (part_system_exists(ID)))
						{
							drawOrder_newerOnTop = _newerOnTop;
							
							part_system_draw_order(ID, _newerOnTop);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setDrawOrder";
							var _errorText = ("Attempted to set a property of an invalid Particle " +
											  "System:\n" +
											  "{" + string(ID) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @argument			{bool} automaticUpdate
					// @description			Set whether created Particles are executed without the
					//						update call.
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
							var _errorText = ("Attempted to set a property of an invalid Particle " +
											  "System:\n" +
											  "{" + string(ID) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @argument			{bool} automaticRender
					// @description			Set whether created Particles are executed without the
					//						render call.
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
							var _errorText = ("Attempted to set a property of an invalid Particle " +
											  "System:\n" +
											  "{" + string(ID) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
			
				#endregion
				#region <<Execution>>
					
					// @argument			{ParticleType} particleType
					// @returns				{ParticleSystem.ParticleEmitter} | On error: {noone}
					// @description			Create a Particle Emitter in this Particle System.
					static createEmitter = function(_particleType)
					{
						if ((is_real(ID)) and (part_system_exists(ID)))
						{
							return new ParticleEmitter(_particleType);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "createEmitter";
							var _errorText = ("Attempted to add an Element to an invalid Particle " +
											  "System:\n" +
											  "{" + string(ID) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
							
							return noone;
						}
					}
					
					// @description			Render the Particles within this Particle System.
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
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
					// @argument			{int} count?
					// @description			Advance all actions of created Particles by the specified
					//						number of steps.
					static update = function(_count = 1)
					{
						if ((is_real(ID)) and (part_system_exists(ID)))
						{
							repeat (_count)
							{
								part_system_update(ID);
							}
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "update";
							var _errorText = ("Attempted to update an invalid Particle System:\n" +
											  "{" + string(ID) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
						
						return self;
					}
					
				#endregion
				#region <<Conversion>>
					
					// @argument			{bool} multiline?
					// @argument			{bool} full?
					// @returns				{string}
					// @description			Create a string representing this constructor.
					//						Overrides the string() conversion.
					//						Content will be represented with the properties of this
					//						Particle System.
					static toString = function(_multiline = false, _full = false)
					{
						var _constructorName = "Layer.ParticleSystem";
						
						if ((is_real(ID)) and (part_system_exists(ID)))
						{
							var _string = "";
							var _mark_separator = ((_multiline) ? "\n" : ", ");
							
							var _string_emitterNumber = (((instanceof(emitterList) == "List")
														   and (emitterList.isFunctional()))
														 ? string(emitterList.getSize())
														 : string(undefined));
							
							if (_full)
							{
								var _string_drawOrder_newerOnTop;
								
								switch (drawOrder_newerOnTop)
								{
									case true: _string_drawOrder_newerOnTop = "Newer on Top"; break;
									case false: _string_drawOrder_newerOnTop = "Older on Top"; break;
									default: _string_drawOrder_newerOnTop = string(undefined); break;
								}
								
								_string = ("ID: " + string(ID) + _mark_separator+
										   "Persistent: " + string(persistent) + _mark_separator +
										   "Location: " + string(location) + _mark_separator +
										   "Automatic Update: " + string(automaticUpdate)
																+ _mark_separator +
										   "Automatic Render: " + string(automaticRender)
																+ _mark_separator +
										   "Draw Order: " + _string_drawOrder_newerOnTop
														  + _mark_separator +
										   "Emitter Number: " + _string_emitterNumber);
							}
							else
							{
								_string = ("ID: " + string(ID) + _mark_separator +
										   "Emitter Number: " + _string_emitterNumber);
							}
							
							return ((_multiline) ? _string
												 : (_constructorName + "(" + _string + ")"));
						}
						else
						{
							return (_constructorName + "<>");
						}
					}
					
				#endregion
			#endregion
			#region [[Element]]
				
				// @function			Layer.ParticleSystem.ParticleEmitter()
				// @argument			{ParticleType} particleType
				//						
				// @description			Construct a Particle Emitter resource in this Particle
				//						System, used to create particles of a Particles Type in
				//						a region.
				//						
				//						Construction types:
				//						- New element.
				//						- Constructor copy: {Layer.ParticleSystem.ParticleEmitter}
				//											other
				function ParticleEmitter() constructor
				{
					#region [[[Methods]]]
						#region <<<Management>>>
							
							// @description			Initialize the constructor.
							static construct = function()
							{
								parent = other;
								parent.emitterList.add(self);
								
								particleType = undefined;
								
								location = undefined;
								shape = undefined;
								distribution = undefined;
								
								streamEnabled = true;
								streamCount = 0;
								
								ID = part_emitter_create(parent.ID);
								
								if (argument_count > 0)
								{
									if (string_copy(string(instanceof(argument[0])), 1, 15)
										== "ParticleEmitter")
									{
										//|Construction type: Constructor copy.
										var _other = argument[0];
										
										particleType = _other.particleType;
										
										if ((_other.location != undefined)
										and (_other.shape != undefined)
										and (_other.distribution != undefined))
										{
											self.setRegion(_other.location, _other.shape,
														   _other.distribution);
										}
									}
									else
									{
										//|Construction type: New constructor.
										particleType = argument[0];
									}
								}
								
								return self;
							}
							
							// @returns				{bool}
							// @description			Check if this constructor is functional.
							static isFunctional = function()
							{
								return ((is_real(ID))
										 and (string_copy(string(instanceof(parent)), 1, 14)
											  == "ParticleSystem") and (parent.isFunctional())
										 and (part_emitter_exists(parent.ID, ID)))
							}
							
							// @returns				{undefined}
							// @description			Remove the internal information from the memory.
							static destroy = function()
							{
								if ((is_real(ID))
								and (string_copy(string(instanceof(parent)), 1, 14)
									 == "ParticleSystem") and (parent.isFunctional())
								and (part_emitter_exists(parent.ID, ID)))
								{
									parent.emitterList.removeValue(self);
									
									part_emitter_destroy(parent.ID, ID);
									
									ID = undefined;
								}
								
								return undefined;
							}
							
							// @description			Set all properties of this Particle Emitter to
							//						default, except for its used Particle Type.
							static clear = function()
							{
								if (self.isFunctional())
								{
									location = undefined;
									shape = undefined;
									distribution = undefined;
								
									streamEnabled = true;
									streamCount = 0;
									
									part_emitter_clear(parent.ID, ID);
								}
								else if ((string_copy(string(instanceof(parent)), 1, 14)
										 == "ParticleSystem") and (parent.isFunctional()))
								{
									location = undefined;
									shape = undefined;
									distribution = undefined;
								
									streamEnabled = true;
									streamCount = 0;
									
									ID = part_emitter_create(parent.ID);
								}
								else
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "setRegion";
									var _errorText = ("Attempted to clear an Element of an " +
													  "invalid Particle System:\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}");
									_errorReport.reportConstructorMethod(self, _callstack,
																		 _methodName, _errorText);
								}
								
								return self;
							}
							
						#endregion
						#region <<<Setters>>>
					
							// @argument			{Vector4} location
							// @argument			{constant:ps_shape_*} shape
							// @argument			{constant:ps_distr_*} distribution
							// @description			Set the region in which the particles will be
							//						created.
							static setRegion = function(_location, _shape, _distribution)
							{
								if (self.isFunctional())
								{
									location = _location;
									shape = _shape;
									distribution = _distribution;
									
									part_emitter_region(parent.ID, ID, location.x1, location.x2,
														location.y1, location.y2, shape,
														distribution);
								}
								else
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "setRegion";
									var _errorText = ("Attempted to set properties on invalid " +
													  "Element or Particle System:\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}");
									_errorReport.reportConstructorMethod(self, _callstack,
																		 _methodName, _errorText);
								}
								
								return self;
							}
							
							// @argument			{bool} streamEnabled
							// @description			Toggle continous particle streaming.
							static setStreamEnabled = function(_streamEnabled)
							{
								if (self.isFunctional())
								{
									streamEnabled = _streamEnabled;
								}
								else
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "setStreamEnabled";
									var _errorText = ("Attempted to set a property on invalid " +
													  "Element or Particle System:\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}");
									_errorReport.reportConstructorMethod(self, _callstack,
																		 _methodName, _errorText);
								}
								
								return self;
							}
							
							// @argument			{int} number
							// @description			Set the number of created particles during a
							//						stream.
							static setStreamCount = function(_number)
							{
								if (self.isFunctional())
								{
									streamCount = _number;
								}
								else
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "setStreamCount";
									var _errorText = ("Attempted to set a property on invalid " +
													  "Element or Particle System:\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}");
									_errorReport.reportConstructorMethod(self, _callstack,
																		 _methodName, _errorText);
								}
								
								return self;
							}
							
						#endregion
						#region <<<Execution>>>
							
							// @argument			{int} number
							// @description			Create a number of Particles within the region.
							static burst = function(_number)
							{
								if (self.isFunctional())
								and (instanceof(particleType) == "ParticleType")
								and (particleType.isFunctional())
								{
									part_emitter_burst(parent.ID, ID, particleType.ID, _number);
								}
								else
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "burst";
									var _errorText = ("Attempted to emit Praticles using an " +
													  "invalid Particle Emitter, Particle System " +
													  "or Particle Type:\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}" +
													  "\n" +
													  "Target: " + "{" + string(particleType));
									_errorReport.reportConstructorMethod(self, _callstack,
																		 _methodName, _errorText);
								}
								
								return self;
							}
							
							// @description			Continously create Particles using the stream 
							//						configuration.
							static stream = function()
							{
								if (self.isFunctional())
								and (instanceof(particleType) == "ParticleType")
								and (particleType.isFunctional())
								{
									var _number = ((streamEnabled) ? streamCount : 0);
									
									part_emitter_stream(parent.ID, ID, particleType.ID, _number);
								}
								else
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "stream";
									var _errorText = ("Attempted to emit Praticles using an " +
													  "invalid Particle Emitter, Particle System " +
													  "or Particle Type:\n" +
													  "Self: " + "{" + string(self) + "}" +"\n" +
													  "Parent: " + "{" + string(parent) + "}" +
													  "\n" +
													  "Target: " + "{" + string(particleType));
									_errorReport.reportConstructorMethod(self, _callstack,
																		 _methodName, _errorText);
								}
								
								return self;
							}
							
						#endregion
						#region <<<Conversion>>>
							
							// @argument			{bool} multiline?
							// @argument			{bool} full?
							// @returns				{string}
							// @description			Create a string representing this constructor.
							//						Overrides the string() conversion.
							//						Content will be represented with the properties
							//						of this Particle Emitter.
							static toString = function(_multiline = false, _full = false)
							{
								var _constructorName = "Layer.ParticleSystem.ParticleEmitter";
								
								if (self.isFunctional())
								{
									var _string = "";
									var _mark_separator = ((_multiline) ? "\n" : ", ");
									
									if (!_full)
									{
										_string = ("ID: " + string(ID) + _mark_separator +
												   "Particle Type: " + string(particleType));
									}
									else
									{
										var _string_shape;
										switch (shape)
										{
											case ps_shape_rectangle:
												_string_shape = "Rectangle";
											break;
											
											case ps_shape_ellipse:
												_string_shape = "Ellipse";
											break;
											
											case ps_shape_diamond:
												_string_shape = "Diamond";
											break;
											
											case ps_shape_line:
												_string_shape = "Line";
											break;
											
											default:
												_string_shape = string(undefined);
											break;
										}
										
										var _string_distribution;
										switch (distribution)
										{
											case ps_distr_linear:
												_string_distribution = "Linear";
											break;
											
											case ps_distr_gaussian:
												_string_distribution = "Gaussian";
											break;
											
											case ps_distr_invgaussian:
												_string_distribution = "Inverse Gaussian";
											break;
											
											default:
												_string_distribution = string(undefined);
											break;
											
										}
										
										_string = ("ID: " + string(ID) + _mark_separator +
												   "Particle Type: " + string(particleType)
																	 + _mark_separator +
												   "Location: " + string(location)
																+ _mark_separator +
												   "Shape: " + _string_shape + _mark_separator +
												   "Distribution: " + _string_distribution
																	+ _mark_separator +
												   "Stream Enabled: " + string(streamEnabled)
																	  + _mark_separator +
												   "Stream Count: " + string(streamCount));
									}
									
									return ((_multiline) ? _string : (_constructorName + "(" +
																	  _string + ")"));
								}
								else
								{
									return (_constructorName + "<>");
								}
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
						
						script_execute_ext(method_get_index(self.construct), argument_original);
						
					#endregion
				}
				
			#endregion
			#region [[Constructor]]
				
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

