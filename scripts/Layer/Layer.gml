//  @function				Layer()
/// @argument				depth {int}
/// @argument				name? {string}
///							
/// @description			Construct a Layer resource, used to group graphical elements and sort 
//							their rendering depth.
//							
//							Construction types:
//							- New constructor
//							- Wrapper: name {string}
//							- Empty: {void|undefined}
//							- Constructor copy: other {Layer}, name? {string}
///							   Information about object instances will not be copied.
function Layer() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
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
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (layer_exists(ID)));
			}
			
			/// @argument			forceDestruction? {bool}
			/// @returns			{undefined}
			/// @description		Remove the internal information from the memory.
			///						If there are persistent instances bound to this Layer, they will
			///						be not be destroyed, unless the destruction is forced, but all
			///						Data Structures of this Layer will be always destroyed.
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
			
			/// @argument			instance {int:instance}
			/// @returns			{bool} | On error: {undefined}
			/// @description		Check whether the specified instance is bound to this Layer.
			static hasInstance = function(_instance)
			{
				try
				{
					return layer_has_instance(ID, _instance);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "hasInstance()"], _exception);
				}
				
				return undefined;
			}
			
			/// @returns			{int[]}
			/// @description		Return the array of all internal element IDs held by this Layer.
			static getElements = function()
			{
				try
				{
					return layer_get_all_elements(ID);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getElements()"], _exception);
				}
				
				return [];
			}
		#endregion
		#region <Setters>
			
			/// @argument			location {Vector2}
			/// @description		Change the rendering offset for Elements of this Layer except
			///						object instances.
			static setLocation = function(_location)
			{
				try
				{
					layer_x(ID, _location.x);
					layer_y(ID, _location.y);
					
					location = _location;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setLocation()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			speed {Vector2}
			/// @description		Set the horizontal and vertical speed of Elements of this Layer
			///						except object instances.
			static setSpeed = function(_speed)
			{
				try
				{
					layer_hspeed(ID, _speed.x);
					layer_vspeed(ID, _speed.y);
					
					speed = _speed;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setSpeed()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			visible {bool}
			/// @description		Set the visiblity property for all elements of this Layer.
			///						Instances on a Layer that is not visible will not have their
			///						Draw Events run.
			static setVisible = function(_visible)
			{
				try
				{
					layer_set_visible(ID, _visible);
					
					visible = _visible;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setVisible()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			depth {int}
			/// @description		Set depth of this Layer, which dictates its render sorting.
			static setDepth = function(_depth)
			{
				try
				{
					layer_depth(ID, _depth);

					depth = _depth;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setDepth()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			shader {Shader}
			/// @description		Set a Shader that will be applied to every Element of this Layer.
			static setShader = function(_shader)
			{
				try
				{
					layer_shader(ID, _shader.ID);
					
					shader = _shader;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setShader()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			function {function}
			/// @description		Set a function that will be called during the Draw Begin of this
			///						Layer.
			static setFunctionDrawBegin = function(_function)
			{
				try
				{
					layer_script_begin(ID, _function);
					
					function_drawBegin = _function;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setFunctionDrawBegin()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			function {function}
			/// @description		Set a function that will be called during the Draw End of this
			///						Layer.
			static setFunctionDrawEnd = function(_function)
			{
				try
				{
					layer_script_end(ID, _function);
					
					function_drawEnd = _function;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setFunctionDrawEnd()"], _exception);
				}
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			sprite {Sprite}
			/// @returns			{Layer.BackgroundElement} | On error: {noone}
			/// @description		Create a Background Element on this Layer and return it.
			static createBackground = function(_sprite)
			{
				try
				{
					if ((is_real(ID)) and (layer_exists(ID)))
					{
						var _element = new BackgroundElement(_sprite);
						
						return _element;
					}
					else
					{
						new ErrorReport().report([other, self, "createBackground()"],
												 ("Attempted to add an Element to an invalid " +
												  "Layer: " +
												  "{" + string(ID) + "}"));
						
						return noone;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "createBackground()"], _exception);
				}
				
				return noone;
			}
			
			/// @argument			object {int:object}
			/// @argument			location? {Vector2}
			/// @returns			{int:instance} | On error: {noone}
			/// @description		Create an instance on this Layer and return its internal ID.
			static createInstance = function(_object, _location)
			{
				try
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
				catch (_exception)
				{
					new ErrorReport().report([other, self, "createInstance()"], _exception);
				}
				
				return noone;
			}
			
			/// @argument			tileset {tileset}
			/// @argument			location {Vector2}
			/// @argument			size {Vector2}
			/// @returns			{Layer.TilemapElement} | On error: {noone}
			/// @description		Create a Tilemap Element on this Layer at the specified specified
			///						location in the room and cell size and return it.
			static createTilemap = function(_tileset, _location, _size)
			{
				try
				{
					if ((is_real(ID)) and (layer_exists(ID)))
					{
						var _element = new TilemapElement(_tileset, _location, _size);
						
						return _element;
					}
					else
					{
						new ErrorReport().report([other, self, "createTilemap()"], 
												 ("Attempted to add an Element to an invalid " +
												  "Layer: " +
												  "{" + string(ID) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "createTilemap()"], _exception);
				}
				
				return noone;
			}
			
			/// @argument			sprite {Sprite|Layer.SpriteElement|int:spriteElement}
			/// @argument			location {Vector2}
			/// @returns			{Layer.SpriteElement} | On error: {noone}
			/// @description		Create a Sprite Element on this Layer and return it.
			static createSprite = function(_sprite, _location)
			{
				try
				{
					if ((is_real(ID)) and (layer_exists(ID)))
					{
						var _element = new SpriteElement(_sprite, _location);
						
						return _element;
					}
					else
					{
						new ErrorReport().report([other, self, "createSprite()"],
												 ("Attempted to add an Element to an invalid " +
												  "Layer: " +
												  "{" + string(ID) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "createSprite()"], _exception);
				}
				
				return noone;
			}
			
			/// @argument			persistent? {bool}
			/// @returns			{Layer.ParticleSystem} | On error: {noone}
			/// @description		Create a Particle System in this Layer and return it.
			static createParticleSystem = function(_persistent = false)
			{
				try
				{
					if ((is_real(ID)) and (layer_exists(ID)))
					{
						var _element = new ParticleSystem(_persistent);
						
						return _element;
					}
					else
					{
						new ErrorReport().report([other, self, "createParticleSystem()"],
												 ("Attempted to add an Element to an invalid " +
												  "Layer: " +
												  "{" + string(ID) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "createParticleSystem()"], _exception);
				}
				
				return noone;
			}
			
			/// @argument			target {int:instance|int:object|all}
			/// @description		Destroy the specified or all instances or objects of this Layer.
			///						If {all} is specified, the instances will be destroyed instantly.
			///						Otherwise, they will remain until the next application frame.
			static destroyInstance = function(_target)
			{
				try
				{
					if (_target == all)
					{
						layer_destroy_instances(ID);
						
						instanceList.clear();
					}
					else
					{
						var _i = 0;
						repeat (instanceList.getSize())
						{
							try
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
							catch (_exception)
							{
								new ErrorReport().report([other, self, "destroyInstances()"],
														 _exception);
							}
						}
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "destroyInstances()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			instancesPaused {bool}
			/// @description		Activate or deactivate all instances bound to this Layer.
			static setInstancePause = function(_instancesPaused)
			{
				try
				{
					if (_instancesPaused)
					{
						instance_deactivate_layer(ID);
						
						instancesPaused = true;
					}
					else
					{
						instance_activate_layer(ID);
						
						instancesPaused = false;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setInstancePause()"], _exception);
				}
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @argument			full? {bool}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented with the name and depth of this
			///						Layer.
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
		
		//  @function			Layer.SpriteElement()
		/// @argument			sprite {Sprite}
		///						
		/// @description		Construct a Sprite Element used to draw a Sprite on this Layer.
		//						
		//						Construction types:
		//						- New element
		//						- Wrapper: spriteElement {int:spriteElement}
		//						- Empty: {void|undefined}
		//						- Constructor copy: other {Layer.SpriteElement}
		function SpriteElement() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					/// @description		Initialize the constructor.
					static construct = function()
					{
						//|Construction type: Empty.
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
						
						if ((argument_count > 0) and (argument[0] != undefined))
						{
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
						}
						
						return self;
					}
					
					/// @returns			{bool}
					/// @description		Check if this constructor is functional.
					static isFunctional = function()
					{
						return ((instanceof(parent) == "Layer") and (parent.isFunctional()))
								and (layer_sprite_exists(parent.ID, ID));
					}
					
					/// @argument			other {Layer|int:layer|string:layer}
					/// @description		Move this Element to another Layer.
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
								new ErrorReport().report([other, parent, "SpriteElement",
														  "changeParent()"],
														 ("Attempted a parent change to an invalid " +
														  "Layer:" + "\n" +
														  "Self: " + "{" + string(self) + "}" + "\n" +
														  "Parent: " + "{" + string(parent) + "}" +
														  "\n" +
														  "Other: " + "{" + string(_other) + "}"));
							}
						}
						else
						{
							new ErrorReport().report([other, parent, "SpriteElement",
													  "changeParent()"],
													 ("Attempted a parent change on invalid " +
													  "Element or invalid Parent:" + "\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}"));
						}
						
						return self;
					}
					
					/// @returns			{undefined}
					/// @description		Remove the internal information from the memory.
					static destroy = function()
					{
						if (instanceof(parent) == "Layer")
						and (instanceof(parent.spriteList) == "List")
						{
							parent.spriteList.removeValue(self);
						}
						
						if (self.isFunctional())
						{
							layer_sprite_destroy(ID);
						}
						
						return undefined;
					}
					
				#endregion
				#region <<Setters>>
					
					/// @argument			sprite? {Sprite|int:-1}
					/// @description		Set the Sprite of this Sprite Element. If it is not
					///						specified or specified as -1, the Sprite will be cleared.
					static setSprite = function(_sprite)
					{
						try
						{
							if ((_sprite == undefined) or (_sprite == -1))
							{
								layer_sprite_change(ID, -1);
								
								sprite = undefined;
							}
							else
							{
								layer_sprite_change(ID, _sprite.ID);
								
								sprite = _sprite;
							}
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "SpriteElement", "setSprite()"],
													 _exception);
						}
						
						return self;
					}
					
					/// @argument			scale {Scale}
					/// @description		Set the scale property of this Sprite Element.
					static setScale = function(_scale)
					{
						try
						{
							layer_sprite_xscale(ID, _scale.x);
							layer_sprite_yscale(ID, _scale.y);
							
							scale = _scale;
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "SpriteElement", "setScale()"],
													 _exception);
						}
						
						return self;
					}
					
					/// @argument			color {int:color}
					/// @description		Set the color property of this Sprite Element.
					static setColor = function(_color)
					{
						try
						{
							layer_sprite_blend(ID, _color);
							
							color = _color;
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "SpriteElement", "setColor()"],
													 _exception);
						}
						
						return self;
					}
					
					/// @argument			alpha {real}
					/// @description		Set the alpha property of this Sprite Element.
					static setAlpha = function(_alpha)
					{
						try
						{
							layer_sprite_alpha(ID, _alpha);
							
							alpha = _alpha;
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "SpriteElement", "setAlpha()"],
													 _exception);
						}
						
						return self;
					}
					
					/// @argument			frame {int}
					/// @description		Set the current Sprite frame of this Sprite Element.
					static setFrame = function(_frame)
					{
						try
						{
							layer_sprite_index(ID, _frame);
							
							frame = _frame;
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "SpriteElement", "setFrame()"],
													 _exception);
						}
						
						return self;
					}
					
					
					/// @argument			speed {real}
					/// @description		Set the Sprite speed property of this Sprite Element.
					static setSpeed = function(_speed)
					{
						try
						{
							layer_sprite_speed(ID, _speed);
							
							speed = _speed;
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "SpriteElement", "setSpeed()"],
													 _exception);
						}
						
						return self;
					}
					
				#endregion
				#region <<Conversion>>
					
					/// @argument			multiline? {bool}
					/// @argument			full? {bool}
					/// @returns			{string}
					/// @description		Create a string representing this constructor.
					///						Overrides the string() conversion.
					///						Content will be represented with the properties of this
					///						Sprite Element.
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
				
				static prototype = {};
				var _property = variable_struct_get_names(prototype);
				var _i = 0;
				repeat (array_length(_property))
				{
					var _name = _property[_i];
					var _value = variable_struct_get(prototype, _name);
					
					variable_struct_set(self, _name, ((is_method(_value)) ? method(self, _value)
																		  : _value));
					
					++_i;
				}
				
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
		
		//  @function			Layer.BackgroundElement()
		/// @argument			sprite {Sprite}
		///						
		/// @description		Construct a Background Element used to draw a Background on this
		///						Layer.
		//						
		//						Construction types:
		//						- New element
		//						- Wrapper: backgroundElement {int:backgroundElement}
		//						- Empty: {void|undefined}
		//						- Constructor copy: other {Layer.BackgroundElement}
		function BackgroundElement() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					/// @description		Initialize the constructor.
					static construct = function()
					{
						//|Construction type: Empty.
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
						
						if ((argument_count > 0) and (argument[0] != undefined))
						{
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
						}
						
						return self;
					}
					
					/// @returns			{bool}
					/// @description		Check if this constructor is functional.
					static isFunctional = function()
					{
						return ((instanceof(parent) == "Layer") and (parent.isFunctional()))
								and (layer_background_exists(parent.ID, ID));
					}
					
					/// @argument			other {Layer|int:layer|string:layer}
					/// @description		Move this Element to another Layer.
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
								new ErrorReport().report([other, parent, "BackgroundElement",
														  "changeParent()"],
														 ("Attempted a parent change to an invalid " +
														  "Layer:" + "\n" +
														  "Self: " + "{" + string(self) + "}" + "\n" +
														  "Parent: " + "{" + string(parent) + "}" +
														  "\n" +
														  "Other: " + "{" + string(_other) + "}"));
							}
						}
						else
						{
							new ErrorReport().report([other, parent, "BackgroundElement",
													  "changeParent()"],
													 ("Attempted a parent change on invalid " +
													  "Element or invalid Parent:" + "\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}"));
						}
						
						return self;
					}
					
					/// @returns			{undefined}
					/// @description		Remove the internal information from the memory.
					static destroy = function()
					{
						if ((instanceof(parent) == "Layer")
						and (instanceof(parent.backgroundList) == "List"))
						{
							parent.backgroundList.removeValue(self);
						}
						
						if (self.isFunctional())
						{
							layer_background_destroy(ID);
						}
						
						return undefined;
					}
					
				#endregion
				#region <<Setters>>
					
					/// @argument			sprite? {Sprite|int:-1}
					/// @description		Set the Sprite of this Background Element. If it is not
					///						specified or specified as -1, the Sprite will be cleared.
					static setSprite = function(_sprite)
					{
						try
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
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "BackgroundElement",
													  "setSprite()"], _exception);
						}
						
						return self;
					}
					
					/// @argument			scale {Scale}
					/// @description		Set the scale property of this Background Element.
					static setScale = function(_scale)
					{
						try
						{
							layer_background_xscale(ID, _scale.x);
							layer_background_yscale(ID, _scale.y);
							
							scale = _scale;
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "BackgroundElement",
													  "setScale()"], _exception);
						}
						
						return self;
					}
					
					/// @argument			color {int:color}
					/// @description		Set the color property of this Background Element.
					static setColor = function(_color)
					{
						try
						{
							layer_background_blend(ID, _color);
							
							color = _color;
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "BackgroundElement",
													  "setColor()"], _exception);
						}
						
						return self;
					}
					
					/// @argument			alpha {real}
					/// @description		Set the alpha property of this Background Element.
					static setAlpha = function(_alpha)
					{
						try
						{
							layer_background_alpha(ID, _alpha);
							
							alpha = _alpha;
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "BackgroundElement",
													  "setAlpha()"], _exception);
						}
						
						return self;
					}
					
					/// @argument			frame {int}
					/// @description		Set the current Sprite frame of this Background Element.
					static setFrame = function(_frame)
					{
						try
						{
							layer_background_index(ID, _frame);
							
							frame = _frame;
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "BackgroundElement",
													  "setFrame()"], _exception);
						}
						return self;
					}
					
					/// @argument			speed {real}
					/// @description		Set the Sprite speed property of this Background Element.
					static setSpeed = function(_speed)
					{
						try
						{
							layer_background_speed(ID, _speed);
							
							speed = _speed;
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "BackgroundElement",
													  "setSpeed()"], _exception);
						}
						
						
						return self;
					}
					
					/// @argument			stretch {bool}
					/// @description		Set the scretch property of this Background Element.
					static setStretch = function(_stretch)
					{
						try
						{
							layer_background_stretch(ID, _stretch);
							
							stretch = _stretch;
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "BackgroundElement",
													  "setStretch()"], _exception);
						}
						
						return self;
					}
					
					/// @argument			tiled_x? {bool}
					/// @argument			tiled_y? {bool}
					/// @description		Set the tiling properties of this Background Element for
					///						horizontal and vertical tiling respectively.
					static setTiled = function(_tiled_x, _tiled_y)
					{
						try
						{
							if (_tiled_x != undefined)
							{
								layer_background_htiled(ID, _tiled_x);
								
								tiled_x = _tiled_x;
							}
							
							if (_tiled_y != undefined)
							{
								layer_background_vtiled(ID, _tiled_y);
								
								tiled_y = _tiled_y;
							}
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "BackgroundElement",
													  "setTiled()"], _exception);
						}
						
						return self;
					}
					
					/// @argument			visible {bool}
					/// @description		Set the visibility property of this Background Element.
					static setVisible = function(_visible)
					{
						try
						{
							layer_background_visible(ID, _visible);
							
							visible = _visible;
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "BackgroundElement",
													  "setVisible()"], _exception);
						}
						
						return self;
					}
					
				#endregion
				#region <<Conversion>>
					
					/// @argument			multiline? {bool}
					/// @argument			full? {bool}
					/// @returns			{string}
					/// @description		Create a string representing this constructor.
					///						Overrides the string() conversion.
					///						Content will be represented with the properties of this
					///						Background Element.
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
				
				static prototype = {};
				var _property = variable_struct_get_names(prototype);
				var _i = 0;
				repeat (array_length(_property))
				{
					var _name = _property[_i];
					var _value = variable_struct_get(prototype, _name);
					
					variable_struct_set(self, _name, ((is_method(_value)) ? method(self, _value)
																		  : _value));
					
					++_i;
				}
				
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
		
		//  @function			Layer.TilemapElement()
		/// @argument			tileset {int:tileset}
		/// @argument			location {Vector2}
		/// @argument			size {Vector2}
		///						
		/// @description		Construct a Tilemap Element used to draw Tiles from a Tileset on
		///						this Layer.
		//						
		//						Construction types:
		//						- New element
		//						- Wrapper: tilemapElement {int:tilemapElement}
		//						- Empty: {void|undefined}
		//						- Constructor copy: other {Layer.TilemapElement}
		function TilemapElement() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					/// @description		Initialize the constructor.
					static construct = function()
					{
						//|Construction type: Empty.
						parent = other;
						parent.tilemapList.add(self);
						ID = undefined;
						tileset = undefined;
						location = undefined;
						size = undefined;
						
						if ((argument_count > 0) and (argument[0] != undefined))
						{
							var _instanceof_self = instanceof(self);
							var _instanceof_other = instanceof(argument[0]);
							
							if (_instanceof_other == _instanceof_self)
							{
								//|Construction type: Constructor copy.
								var _other = argument[0];
								
								tileset = _other.tileset;
								location = _other.location;
								size = _other.size;
								ID = layer_tilemap_create(parent.ID, location.x, location.y, tileset,
														  size.x, size.y);
							}
							else if (argument_count > 2)
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
					
					/// @returns			{bool}
					/// @description		Check if this constructor is functional.
					static isFunctional = function()
					{
						return ((instanceof(parent) == "Layer") and (parent.isFunctional()))
								and (layer_tilemap_exists(parent.ID, ID));
					}
					
					/// @returns			{undefined}
					/// @description		Remove the internal information from the memory.
					static destroy = function()
					{
						if ((instanceof(parent) == "Layer")
						and (instanceof(parent.tilemapList) == "List"))
						{
							parent.tilemapList.removeValue(self);
						}
						
						if (self.isFunctional())
						{
							layer_tilemap_destroy(ID);
						}
						
						return undefined;
					}
					
					/// @argument			tiledata? {Layer.TilemapElement.TileData|int:tiledata}
					/// @description		Set all Tiles in this Tilemap to empty or the specified
					///						Tile Data.
					static clear = function(_tiledata = 0)
					{
						try
						{
							if (string_copy(instanceof(_tiledata), 1, 8) == "TileData")
							{
								tilemap_clear(ID, _tiledata.ID);
							}
							else
							{
								tilemap_clear(ID, _tiledata);
							}
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "TilemapElement", "clear()"],
													 _exception);
						}
						
						return self;
					}
					
					/// @argument			other {Layer|int:layer|string:layer}
					/// @description		Move this Element to another Layer.
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
								new ErrorReport().report([other, parent, "TilemapElement",
														 "changeParent()"],
														 ("Attempted a parent change to an invalid " +
														  "Layer:" + "\n" +
														  "Self: " + "{" + string(self) + "}" + "\n" +
														  "Parent: " + "{" + string(parent) + "}" +
														  "\n" +
														  "Other: " + "{" + string(_other) + "}"));
							}
						}
						else
						{
							new ErrorReport().report([other, parent, "SpriteElement",
													  "changeParent()"],
													 ("Attempted a parent change on invalid " +
													  "Element or invalid Parent:" + "\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}"));
						}
						
						return self;
					}
					
				#endregion
				#region <<Getters>>
					
					/// @returns			{int} | On error: {undefined}
					/// @description		Return the current Sprite frame of this Tilemap.
					static getFrame = function()
					{
						try
						{
							return tilemap_get_frame(ID);
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "TilemapElement", "getFrame()"],
													 _exception);
						}
					}
					
					/// @returns			{int} | On error: {int:-1}
					/// @description		Return the bit mask value for this Tilemap or 0 if there
					///						is none.
					static getMask = function()
					{
						try
						{
							return tilemap_get_mask(ID);
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "TilemapElement", "getMask()"],
													 _exception);
						}
						
						return -1;
					}
					
					/// @argument			location {Vector2}
					/// @returns			{Layer.TilemapElement.TileData}
					/// @description		Return a TileData referring to the Tile in a cell at the
					///						specified location.
					static getTileInCell = function(_location)
					{
						try
						{
							return new TileData(tilemap_get(ID, _location.x, _location.y));
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "TilemapElement",
													 "getTileInCell()"], _exception);
						}
						
						return new TileData(-1);
					}
					
					/// @argument			location {Vector2}
					/// @returns			{Layer.TilemapElement.TileData}
					/// @description		Return a TileData referring to the Tile at specified
					///						point in the Room.
					static getTileAtPoint = function(_location)
					{
						try
						{
							return new TileData(tilemap_get_at_pixel(ID, _location.x, _location.y));
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "TilemapElement",
													  "getTileAtPoint()"], _exception);
						}
						
						return new TileData(-1);
					}
					
					/// @argument			location {Vector2}
					/// @returns			{Vector2} | On error: {undefined}
					/// @description		Return the cell location for a Tile at specified point in
					///						space.
					static getCellAtPoint = function(_location)
					{
						try
						{
							return new Vector2
							(
								tilemap_get_cell_x_at_pixel(ID, _location.x, _location.y),
								tilemap_get_cell_y_at_pixel(ID, _location.x, _location.y)
							);
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "TilemapElement",
													  "getCellAtPoint()"], _exception);
						}
						
						return undefined;
					}
					
				#endregion
				#region <<Setters>>
					
					/// @argument			mask {int}
					/// @description		Set the tile bit mask for this Tilemap.
					static setMask = function(_mask)
					{
						try
						{
							tilemap_set_mask(ID, _mask);
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "TilemapElement", "setMask()"],
													 _exception);
						}
						
						return self;
					}
					
					/// @argument			tileset {int:tileset}
					/// @description		Change the Tileset used by this Tilemap.
					static setTileset = function(_tileset)
					{
						try
						{
							tilemap_tileset(ID, _tileset);
							
							tileset = _tileset;
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "TilemapElement",
													  "setTileset()"], _exception);
						}
						
						return self;
					}
					
					/// @argument			size {Vector2}
					/// @description		Set the size of this Tilemap, which is the number of Tile
					///						cells it will use.
					static setSize = function(_size)
					{
						try
						{
							tilemap_set_width(ID, _size.x);
							tilemap_set_height(ID, _size.y);
							
							size = _size;
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "TilemapElement", "setSize()"],
													 _exception);
						}
						
						return self;
					}
					
				#endregion
				#region <<Execution>>
					
					/// @argument			location? {Vector2}
					/// @description		Execute the draw of this Tilemap, independent of its draw
					///						executed by its Layer.
					static render = function(_location = new Vector2(0, 0))
					{
						try
						{
							draw_tilemap(ID, _location.x, _location.y);
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "TilemapElement", "render()"],
													 _exception);
						}
						
						return self;
					}
					

					/// @argument			location {Vector2}
					/// @argument			tiledata? {Layer.TilemapElement.TileData|int:tiledata}
					/// @returns			{bool}
					/// @description		Set the Tile at the specified cell to a Tile referred
					///						to by the specified Tile Data and return a boolean for
					///						confirmation whether the operation was a success or not. 
					///						If Tile Data is not provided or 0 is provided in its
					///						place, the cell will be cleared.
					static setTileInCell = function(_location, _tiledata = 0)
					{
						try
						{
							if (instanceof(_tiledata) == "TileData")
							{
								_tiledata = _tiledata.ID;
							}
							
							return ((_tiledata != -1)
									? tilemap_set(ID, _tiledata, _location.x, _location.y) : false);
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "TilemapElement",
													 "setTileInCell()"], _exception);
						}
						
						return false;
					}
					
					/// @argument			location {Vector2}
					/// @argument			tiledata? {Layer.TilemapElement.TileData|int:tiledata}
					/// @description		Set the Tile at the specified point in space to a Tile
					///						referred to by the specified Tile Data and return a
					///						boolean for confirmation whether the operation was a
					///						success or not.
					///						If Thile Data is not provided or 0 is provided in its
					///						place, the cell will be cleared.
					static setTileAtPoint = function(_location, _tiledata = 0)
					{
						try
						{
							if (instanceof(_tiledata) == "TileData")
							{
								_tiledata = _tiledata.ID;
							}
							
							return ((_tiledata != -1)
									? tilemap_set_at_pixel(ID, _tiledata, _location.x, _location.y)
									: false);
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "TilemapElement",
													  "setTileAtPoint()"], _exception);
						}
						
						return false;
					}
					
					
				#endregion
				#region <<Conversion>>
					
					/// @returns			{string}
					/// @description		Create a string representing this constructor.
					///						Overrides the string() conversion.
					///						Content will be represented with the properties of this
					///						Tilemap Element.
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
				
				//  @function			Layer.TilemapElement.TileData()
				/// @argument			id? {int}
				///						
				/// @description		Constructs a TileData Element, which refers to a Tile in this
				///						Tilemap.
				//						
				//						Construction types:
				//						- New element
				//						- Empty: {void|undefined}
				//						- Constructor copy: other {Layer.TilemapElement.TileData}
				function TileData() constructor
				{
					#region [[[Methods]]]
						#region <<<Management>>>
							
							/// @description		Initialize the constructor.
							static construct = function()
							{
								//|Construction type: Empty.
								parent = other;
								ID = 0;
								
								if ((argument_count > 0) and (argument[0] != undefined))
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
										//|Construction type: New element.
										ID = argument[0];
									}
								}
								
								return self;
							}
							
							/// @returns			{bool}
							/// @description		Check if this constructor is functional.
							static isFunctional = function()
							{
								return ((ID >= 0));
							}
							
							/// @description		Empty the Tile this Tile Data refers to.
							static clear = function()
							{
								if (!(ID >= 0))
								{
									new ErrorReport().report([other, "Layer", "TilemapElement",
															  "TileData", "clear()"],
															 ("Attempted to set a property of an" +
															  "invalid Tile:" + "\n" +
															  "Self: " + "{" + string(self) + "}" +
															  "\n" + "Parent: " +
															  "{" + string(parent) + "}" + "\n" +
															  "Clearing the Tile ID to 0."));
									
									ID = 0;
								}
								
								ID = tile_set_empty(ID);
								
								return self;
							}
							
						#endregion
						#region <<<Getters>>>
							
							/// @returns			{int}
							/// @description		Return the index of the Tile this Tile Data refers
							///						to on its tileset.
							static getTilesetIndex = function()
							{
								if (!(ID >= 0))
								{
									new ErrorReport().report([other, "Layer", "TilemapElement",
															  "TileData", "getTilesetIndex()"],
															 ("Attempted to set a property of an" +
															  "invalid Tile:" + "\n" +
															  "Self: " + "{" + string(self) + "}" +
															  "\n" + "Parent: " +
															  "{" + string(parent) + "}" + "\n" +
															  "Clearing the Tile ID to 0."));
									
									ID = 0;
								}
								
								return tile_get_index(ID);
							}
							
							/// @returns			{bool}
							/// @description		Check if this Tile Data refers to an empty Tile.
							static isEmpty = function()
							{
								if (!(ID >= 0))
								{
									new ErrorReport().report([other, "Layer", "TilemapElement",
															  "TileData", "isEmpty()"],
															 ("Attempted to set a property of an" +
															  "invalid Tile:" + "\n" +
															  "Self: " + "{" + string(self) + "}" +
															  "\n" + "Parent: " +
															  "{" + string(parent) + "}" + "\n" +
															  "Clearing the Tile ID to 0."));
									
									ID = 0;
								}
								
								return tile_get_empty(ID);
							}
							
							/// @returns			{bool}
							/// @description		Check if this Tile Data refers to a Tile that was
							///						mirrored horizontally.
							static isMirroredX = function()
							{
								if (!(ID >= 0))
								{
									new ErrorReport().report([other, "Layer", "TilemapElement",
															  "TileData", "isMirroredX()"],
															 ("Attempted to set a property of an" +
															  "invalid Tile:" + "\n" +
															  "Self: " + "{" + string(self) + "}" +
															  "\n" + "Parent: " +
															  "{" + string(parent) + "}" + "\n" +
															  "Clearing the Tile ID to 0."));
									
									ID = 0;
								}
								
								return tile_get_mirror(ID);
							}
							
							/// @returns			{bool}
							/// @description		Check if this Tile Data refers to a Tile that was
							///						mirrored vertically.
							static isMirroredY = function()
							{
								if (!(ID >= 0))
								{
									new ErrorReport().report([other, "Layer", "TilemapElement",
															  "TileData", "isMirroredY()"],
															 ("Attempted to set a property of an" +
															  "invalid Tile:" + "\n" +
															  "Self: " + "{" + string(self) + "}" +
															  "\n" + "Parent: " +
															  "{" + string(parent) + "}" + "\n" +
															  "Clearing the Tile ID to 0."));
									
									ID = 0;
								}
								
								return tile_get_flip(ID);
							}
							
							/// @returns			{bool} | On error: {undefined}
							/// @description		Check if this Tile Data refers to a Tile that was
							///						rotated by 90 degrees.
							static isRotated = function()
							{
								if (!(ID >= 0))
								{
									new ErrorReport().report([other, "Layer", "TilemapElement",
															  "TileData", "isRotated()"],
															 ("Attempted to set a property of an" +
															  "invalid Tile:" + "\n" +
															  "Self: " + "{" + string(self) + "}" +
															  "\n" + "Parent: " +
															  "{" + string(parent) + "}" + "\n" +
															  "Clearing the Tile ID to 0."));
									
									ID = 0;
								}
								
								return tile_get_rotate(ID);
							}
							
						#endregion
						#region <<<Setters>>>
							
							/// @argument			index {int}
							/// @description		Change the Tile this Tile Data refers to, based
							///						on the index of its tileset.
							static setTilesetIndex = function(_index)
							{
								try
								{
									if (!(ID >= 0))
									{
										new ErrorReport().report([other, "Layer", "TilemapElement",
																 "TileData", "setTilesetIndex()"],
																 ("Attempted to set a property of" +
																  "an invalid Tile:" + "\n" +
																  "Self: " +
																  "{" + string(self) + "}" + "\n" +
																  "Parent: " +
																  "{" + string(parent) + "}" + "\n" +
																  "Clearing the Tile ID to 0."));
										
										ID = 0;
									}
									
									ID = tile_set_index(ID, _index);
								}
								catch (_exception)
								{
									new ErrorReport().report([other, "Layer", "TilemapElement",
															  "TileData", "setTilesetIndex()"],
															 _exception);
								}
								
								return self;
							}
							
							/// @argument			mirror {bool}
							/// @description		Set the horizontal mirroring property of the Tile
							///						this Tile Data refers to.
							static setMirrorX = function(_mirror)
							{
								try
								{
									if (!(ID >= 0))
									{
										new ErrorReport().report([other, "Layer", "TilemapElement",
																 "TileData", "setMirrorX()"],
																 ("Attempted to set a property of" +
																  "an invalid Tile:" + "\n" +
																  "Self: " +
																  "{" + string(self) + "}" + "\n" +
																  "Parent: " +
																  "{" + string(parent) + "}" + "\n" +
																  "Clearing the Tile ID to 0."));
										
										ID = 0;
									}
									
									ID = tile_set_mirror(ID, _mirror);
								}
								catch (_exception)
								{
									new ErrorReport().report([other, "Layer", "TilemapElement",
															  "TileData", "setMirrorX()"],
															 _exception);
								}
								
								return self;
							}
							
							/// @argument			mirror {bool}
							/// @description		Set the vertical mirroring property of the Tile
							///						this Tile Data refers to.
							static setMirrorY = function(_mirror)
							{
								try
								{
									if (!(ID >= 0))
									{
										new ErrorReport().report([other, "Layer", "TilemapElement",
																  "TileData", "setMirrorY()"],
																 ("Attempted to set a property of" +
																  "an invalid Tile:" + "\n" +
																  "Self: " +
																  "{" + string(self) + "}" + "\n" +
																  "Parent: " +
																  "{" + string(parent) + "}" + "\n" +
																  "Clearing the Tile ID to 0."));
										
										ID = 0;
									}
									
									ID = tile_set_flip(ID, _mirror);
								}
								catch (_exception)
								{
									new ErrorReport().report([other, "Layer", "TilemapElement",
															  "TileData", "setMirrorY()"],
															 _exception);
								}
								
								return self;
							}
							
							/// @argument			rotate {bool}
							/// @description		Set the 90 degree rotation property of the Tile
							///						this Tile Data refers to.
							static setRotate = function(_rotate)
							{
								try
								{
									if (!(ID >= 0))
									{
										new ErrorReport().report([other, "Layer", "TilemapElement",
																  "TileData", "setRotate()"],
																 ("Attempted to set a property of" +
																  "an invalid Tile:" + "\n" +
																  "Self: " +
																  "{" + string(self) + "}" + "\n" +
																  "Parent: " +
																  "{" + string(parent) + "}" + "\n" +
																  "Clearing the Tile ID to 0."));
										
										ID = 0;
									}
									
									ID = tile_set_rotate(ID, _rotate);
								}
								catch (_exception)
								{
									new ErrorReport().report([other, "Layer", "TilemapElement",
															  "TileData", "setRotate()"],
															 _exception);
								}
								
								return self;
							}
							
						#endregion
						#region <<<Execution>>>
							
							/// @argument			location? {Vector2}
							/// @argument			frame? {int}
							/// @description		Execute the draw of the Tile this Tile Data
							///						refers to, independent of its draw handled
							///						by its Layer.
							static render = function(_location = new Vector2(0, 0), _frame = 0)
							{
								try
								{
									if (!(ID >= 0))
									{
										new ErrorReport().report([other, "Layer", "TilemapElement",
																  "TileData", "render()"],
																 ("Attempted to set a property of" +
																  "an invalid Tile:" + "\n" +
																  "Self: " +
																  "{" + string(self) + "}" + "\n" +
																  "Parent: " +
																  "{" + string(parent) + "}" + "\n" +
																  "Clearing the Tile ID to 0."));
										
										ID = 0;
									}
									
									draw_tile(parent.tileset, ID, _frame, _location.x, _location.y);
								}
								catch (_exception)
								{
									new ErrorReport().report([other, "Layer", "TilemapElement",
															  "TileData", "render()"],
															 _exception);
								}
								
								return self;
							}
							
						#endregion
						#region <<<Conversion>>>
							
							/// @argument			multiline? {bool}
							/// @returns			{string}
							/// @description		Create a string representing this constructor.
							///						Overrides the string() conversion.
							///						Content will be represented with the ID of this
							///						Tile Data.
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
						
						static prototype = {};
						var _property = variable_struct_get_names(prototype);
						var _i = 0;
						repeat (array_length(_property))
						{
							var _name = _property[_i];
							var _value = variable_struct_get(prototype, _name);
							
							variable_struct_set(self, _name, ((is_method(_value))
															  ? method(self, _value) : _value));
							
							++_i;
						}
						
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
				
				static prototype = {};
				var _property = variable_struct_get_names(prototype);
				var _i = 0;
				repeat (array_length(_property))
				{
					var _name = _property[_i];
					var _value = variable_struct_get(prototype, _name);
					
					variable_struct_set(self, _name, ((is_method(_value)) ? method(self, _value)
																		  : _value));
					
					++_i;
				}
				
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
		
		//  @function			Layer.ParticleSystem()
		/// @argument			persistent? {bool}
		///						
		/// @description		Construct a Particle System Element used to create Particles of
		///						any Particle Type on this Layer.
		//						
		//						Construction types:
		//						- New element
		//						- Empty: {void|undefined}
		//						- Constructor copy: other {Layer.ParticleSystem}
		function ParticleSystem() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					/// @description		Initialize the constructor.
					static construct = function()
					{
						//|Construction type: Empty.
						parent = other;
						parent.particleSystemList.add(self);
						ID = undefined;
						persistent = undefined;
						location = undefined;
						automaticUpdate = undefined;
						automaticRender = undefined;
						drawOrder_newerOnTop = undefined;
						emitterList = undefined;
						
						if ((argument_count > 0) and (argument[0] != undefined))
						{
							var _instanceof_self = instanceof(self);
							var _instanceof_other = ((argument_count > 0) ? instanceof(argument[0])
																		  : undefined);
							
							if (_instanceof_other == _instanceof_self)
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
						}
						
						return self;
					}
					
					/// @returns			{bool}
					/// @description		Check if this constructor is functional.
					static isFunctional = function()
					{
						return ((is_real(ID)) and (part_system_exists(ID)));
					}
					
					/// @returns			{undefined}
					/// @description		Remove the internal information from the memory.
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
					
					/// @description		Remove all Particles currently existing in this Particle
					///						System.
					static clear = function()
					{
						try
						{
							part_particles_clear(ID);
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "ParticleSystem", "clear()"],
													 _exception);
						}
						
						return self;
					}
					
					/// @argument			other {Layer|int:layer|string:layer}
					/// @description		Move this Element to another Layer.
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
								new ErrorReport().report([other, parent, "ParticleSystem",
														 "changeParent()"],
														 ("Attempted a parent change to an invalid " +
														  "Layer:" + "\n" +
														  "Self: " + "{" + string(self) + "}" + "\n" +
														  "Parent: " + "{" + string(parent) + "}" +
														  "\n" +
														  "Other: " + "{" + string(_other) + "}"));
							}
						}
						else
						{
							new ErrorReport().report([other, parent, "ParticleSystem",
													  "changeParent()"],
													 ("Attempted a parent change on invalid " +
													  "Element or invalid Parent:" + "\n" +
													  "Self: " + "{" + string(self) + "}" + "\n" +
													  "Parent: " + "{" + string(parent) + "}"));
						}
						
						return self;
					}
					
				#endregion
				#region <<Getters>>
					
					/// @returns			{int}
					/// @description		Return a number of currently existing Particles of this
					///						Particle System.
					static getParticleCount = function()
					{
						try
						{
							return part_particles_count(ID);
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "ParticleSystem",
													 "getParticleCount()"], _exception);
						}
						
						return 0;
					}
					
				#endregion
				#region <<Setters>>
					
					/// @argument			location {Vector2}
					/// @description		Set the offset for the Particle render.
					static setLocation = function(_location)
					{
						try
						{
							part_system_position(ID, _location.x, _location.y);
							
							location = _location;
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "ParticleSystem",
													  "setLocation()"], _exception);
						}
						
						return self;
					}
					
					/// @argument			newerOnTop {bool}
					/// @description		Set whether older Particles are drawn benath newer.
					static setDrawOrder = function(_newerOnTop)
					{
						try
						{
							part_system_draw_order(ID, _newerOnTop);
							
							drawOrder_newerOnTop = _newerOnTop;
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "ParticleSystem",
													  "setDrawOrder()"], _exception);
						}
						
						return self;
					}
					
					/// @argument			automaticUpdate {bool}
					/// @description		Set whether created Particles are executed without the
					///						update call.
					static setAutomaticUpdate = function(_automaticUpdate)
					{
						try
						{
							part_system_automatic_update(ID, _automaticUpdate);
							
							automaticUpdate = _automaticUpdate;
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "ParticleSystem",
													 "setAutomaticUpdate()"], _exception);
						}
						
						return self;
					}
					
					/// @argument			automaticRender {bool}
					/// @description		Set whether created Particles are executed without the
					///						render call.
					static setAutomaticRender = function(_automaticRender)
					{
						try
						{
							part_system_automatic_draw(ID, _automaticRender);
							
							automaticRender = _automaticRender;
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "ParticleSystem",
													 "setAutomaticRender()"], _exception);
						}
						
						return self;
					}
			
				#endregion
				#region <<Execution>>
					
					/// @argument			particleType {ParticleType}
					/// @returns			{ParticleSystem.ParticleEmitter} | On error: {noone}
					/// @description		Create a Particle Emitter in this Particle System.
					static createEmitter = function(_particleType)
					{
						try
						{
							return new ParticleEmitter(_particleType);
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "ParticleSystem",
													 "createEmitter()"], _exception);
						}
						
						return noone;
					}
					
					/// @description		Render the Particles within this Particle System.
					static render = function()
					{
						try
						{
							part_system_drawit(ID);
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "ParticleSystem", "render()"],
													 _exception);
						}
						
						return self;
					}
					
					/// @argument			count? {int}
					/// @description		Advance all actions of created Particles by the specified
					///						number of steps.
					static update = function(_count = 1)
					{
						try
						{
							repeat (_count)
							{
								part_system_update(ID);
							}
						}
						catch (_exception)
						{
							new ErrorReport().report([other, parent, "ParticleSystem", "update()"],
													 _exception);
						}
						
						return self;
					}
					
				#endregion
				#region <<Conversion>>
					
					/// @argument			multiline? {bool}
					/// @argument			full? {bool}
					/// @returns			{string}
					/// @description		Create a string representing this constructor.
					///						Overrides the string() conversion.
					///						Content will be represented with the properties of this
					///						Particle System.
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
				
				//  @function			Layer.ParticleSystem.ParticleEmitter()
				/// @argument			particleType {ParticleType}
				///						
				/// @description		Construct a Particle Emitter resource in this Particle
				///						System, used to create particles of a Particles Type in
				///						a region.
				//						
				//						Construction types:
				//						- New element
				//						- Empty: {undefined}
				//						- Constructor copy: other
				//											{Layer.ParticleSystem.ParticleEmitter}
				function ParticleEmitter() constructor
				{
					#region [[[Methods]]]
						#region <<<Management>>>
							
							/// @description		Initialize the constructor.
							static construct = function()
							{
								//|Construction type: Empty.
								parent = other;
								parent.emitterList.add(self);
								ID = undefined;
								particleType = undefined;
								location = undefined;
								shape = undefined;
								distribution = undefined;
								streamEnabled = true;
								streamCount = 0;
								
								if (argument_count > 0)
								{
									if (argument[0] != undefined)
									{
										ID = part_emitter_create(parent.ID);
										
										if (string_copy(string(instanceof(argument[0])), 1, 15) ==
											"ParticleEmitter")
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
								}
								else
								{
									ID = part_emitter_create(parent.ID);
								}
								
								return self;
							}
							
							/// @returns			{bool}
							/// @description		Check if this constructor is functional.
							static isFunctional = function()
							{
								return ((is_real(ID))
										 and (string_copy(string(instanceof(parent)), 1, 14)
											  == "ParticleSystem") and (parent.isFunctional())
										 and (part_emitter_exists(parent.ID, ID)))
							}
							
							/// @returns			{undefined}
							/// @description		Remove the internal information from the memory.
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
							
							/// @description		Set all properties of this Particle Emitter to
							///						default, except for its used Particle Type.
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
									new ErrorReport().report([other, "Layer", "ParticleSystem",
															 "ParticleEmitter", "clear()"],
															 ("Attempted to clear an Element of an " +
															  "invalid Particle System:" + "\n" +
															  "Self: " + "{" + string(self) + "}" +
															  "\n" + "Parent: " +
															  "{" + string(parent) + "}"));
								}
								
								return self;
							}
							
						#endregion
						#region <<<Setters>>>
					
							/// @argument			location {Vector4}
							/// @argument			shape {constant:ps_shape_*}
							/// @argument			distribution {constant:ps_distr_*}
							/// @description		Set the region in which the particles will be
							///						created.
							static setRegion = function(_location, _shape, _distribution)
							{
								try
								{
									part_emitter_region(parent.ID, ID, _location.x1, _location.x2,
														_location.y1, _location.y2, _shape,
														_distribution);
									
									location = _location;
									shape = _shape;
									distribution = _distribution;
								}
								catch (_exception)
								{
									new ErrorReport().report([other, "Layer", "ParticleSystem",
															 "ParticleEmitter", "setRegion()"],
															 _exception);
								}
								
								return self;
							}
							
							/// @argument			streamEnabled {bool}
							/// @description		Toggle continous particle streaming.
							static setStreamEnabled = function(_streamEnabled)
							{
								if (self.isFunctional())
								{
									streamEnabled = _streamEnabled;
								}
								else
								{
									new ErrorReport().report([other, "Layer", "ParticleSystem",
															 "ParticleEmitter", "setStreamEnabled()"],
															 ("Attempted to set properties on " +
															  "invalid Element or Particle System:" +
															  "\n" + "Self: " +
															  "{" + string(self) + "}" +
															  "\n" + "Parent: " +
															  "{" + string(parent) + "}"));
								}
								
								return self;
							}
							
							/// @argument			number {int}
							/// @description		Set the number of created particles during a
							///						stream.
							static setStreamCount = function(_number)
							{
								if (self.isFunctional())
								{
									streamCount = _number;
								}
								else
								{
									new ErrorReport().report([other, "Layer", "ParticleSystem",
															 "ParticleEmitter", "setStreamCount()"],
															 ("Attempted to set properties on " +
															  "invalid Element or Particle System:" +
															  "\n" + "Self: " +
															  "{" + string(self) + "}" +
															  "\n" + "Parent: " +
															  "{" + string(parent) + "}"));
								}
								
								return self;
							}
							
						#endregion
						#region <<<Execution>>>
							
							/// @argument			number {int}
							/// @description		Create a number of Particles within the region.
							static burst = function(_number)
							{
								try
								{
									part_emitter_burst(parent.ID, ID, particleType.ID, _number);
								}
								catch (_exception)
								{
									new ErrorReport().report([other, "Layer", "ParticleSystem",
															 "ParticleEmitter", "burst()"],
															 _exception);
								}
								
								return self;
							}
							
							/// @description		Continously create Particles using the stream 
							///						configuration.
							static stream = function()
							{
								try
								{
									var _number = ((streamEnabled) ? streamCount : 0);
									
									part_emitter_stream(parent.ID, ID, particleType.ID, _number);
								}
								catch (_exception)
								{
									new ErrorReport().report([other, "Layer", "ParticleSystem",
															 "ParticleEmitter", "stream()"],
															 _exception);
								}
								
								return self;
							}
							
						#endregion
						#region <<<Conversion>>>
							
							/// @argument			multiline? {bool}
							/// @argument			full? {bool}
							/// @returns			{string}
							/// @description		Create a string representing this constructor.
							///						Overrides the string() conversion.
							///						Content will be represented with the properties
							///						of this Particle Emitter.
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
						
						static prototype = {};
						var _property = variable_struct_get_names(prototype);
						var _i = 0;
						repeat (array_length(_property))
						{
							var _name = _property[_i];
							var _value = variable_struct_get(prototype, _name);
							
							variable_struct_set(self, _name, ((is_method(_value))
															  ? method(self, _value) : _value));
							
							++_i;
						}
						
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
				
				static prototype = {};
				var _property = variable_struct_get_names(prototype);
				var _i = 0;
				repeat (array_length(_property))
				{
					var _name = _property[_i];
					var _value = variable_struct_get(prototype, _name);
					
					variable_struct_set(self, _name, ((is_method(_value)) ? method(self, _value)
																		  : _value));
					
					++_i;
				}
				
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
		
		static prototype = {};
		var _property = variable_struct_get_names(prototype);
		var _i = 0;
		repeat (array_length(_property))
		{
			var _name = _property[_i];
			var _value = variable_struct_get(prototype, _name);
			
			variable_struct_set(self, _name, ((is_method(_value)) ? method(self, _value) : _value));
			
			++_i;
		}
		
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
