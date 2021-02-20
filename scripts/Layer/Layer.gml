/// @function				Layer()
/// @argument				{int} depth
///
/// @description			Construct a Layer resource, used to group graphical elements and sort 
///							their rendering depth.
///
///							Construction methods:
///							- New Layer: {int} depth
///							- Exisiting Layer: {string} name
///							- Constructor copy: {Layer} other
///							   Information about object instances will not be copied.
function Layer(_depth) constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				ID = undefined;
				name = undefined;
				
				depth = undefined;
				
				location = undefined;
				speed = undefined;
				
				visible = undefined;
				instancesPaused = undefined;
				
				script_drawBegin = undefined;
				script_drawEnd = undefined;
				
				shader = undefined;
				
				instanceList = undefined;
				spriteList = undefined;
				backgroundList = undefined;
				tilemapList = undefined;
				
				if (instanceof(argument[0]) == "Layer")
				{
					//|Construction method: Constructor copy.
					var _other = argument[0];
					
					depth = _other.depth;
					
					location = new Vector2(_other.location);
					speed = new Vector2(_other.speed);
					
					visible = _other.visible;
					instancesPaused = false;
					
					script_drawBegin = _other.script_drawBegin;
					script_drawEnd = _other.script_drawEnd;
					
					shader = ((instanceof(_other.shader) == "Shader") ? new Shader(_other.shader)
																	  : _other.shader);
					
					instanceList = new List();
					spriteList = new List();
					backgroundList = new List();
					tilemapList = new List();
					
					var _elementLists = [spriteList, backgroundList, tilemapList];
					var _elementLists_other = [_other.spriteList, _other.backgroundList, 
											   _other.tilemapList];
					var _elementTypes = [SpriteElement, BackgroundElement, TilemapElement];
					
					var _i = 0;
					repeat (array_length(_elementLists))
					{
						var _j = 0;
						
						repeat (_elementLists_other[_i].getSize())
						{
							_elementLists[_i].add
							(
								new _elementTypes[_i](_elementLists_other.getValue(_j))
							);
							
							++_j;
						}
						
						++_i;
					}
				}
				else
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
							
							switch (_type)
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
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (layer_exists(ID)));
			}
			
			// @returns				{undefined}
			// @description			Remove the internal Layer information from the memory.
			static destroy = function()
			{
				if ((is_real(ID)) and (layer_exists(ID)))
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
			}
			
			// @argument			{script} script
			// @description			Set a function that will be called during the Draw Begin of
			//						this Layer.
			static setScript_drawBegin = function(_script)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					script_drawBegin = _script;
					
					layer_script_begin(ID, script_drawBegin);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setScript_drawBegin";
					var _errorText = ("Attempted to set a property of an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{script} script
			// @description			Set a function that will be called during the Draw End of
			//						this Layer.
			static setScript_drawEnd = function(_script)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					script_drawEnd = _script;
					
					layer_script_end(ID, script_drawEnd);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setScript_drawEnd";
					var _errorText = ("Attempted to set a property of an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{Shader} Shader
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
			}
			
		#endregion
		#region <Getters>
			
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
			
		#endregion
		#region <Execution>
			
			// @argument			{Sprite} sprite
			// @argument			{Vector2} location
			// @returns				{SpriteElement} | On error: {noone}
			// @description			Create a Sprite Element on this Layer and return it.
			static create_sprite = function(_sprite, _location)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					var _element = new SpriteElement(_sprite, _location);
					
					spriteList.add(_element);
					
					return _element;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "create_sprite";
					var _errorText = ("Attempted to add Element to an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return noone;
				}
			}
			
			// @argument			{Sprite} sprite
			// @returns				{BackgroundElement} | On error: {noone}
			// @description			Create a Background Element on this Layer and return it.
			static create_background = function(_sprite)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					var _element = new BackgroundElement(_sprite);
					
					backgroundList.add(_element);
					
					return _element;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "create_background";
					var _errorText = ("Attempted to add Element to an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return noone;
				}
			}
			
			// @argument			{tileset} tileset
			// @argument			{Vector2} location
			// @argument			{Vector2} size
			// @returns				{TilemapElement} | On error: {noone}
			// @description			Create a Tilemap Element on this Layer at the specified specified
			//						location in the room and cell size and return it.
			static create_tilemap = function(_tileset, _location, _size)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					var _element = new TilemapElement(_tileset, _location, _size);
					
					tilemapList.add(_element);
					
					return _element;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "create_tilemap";
					var _errorText = ("Attempted to add Element to an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return noone;
				}
			}
			
			// @argument			{Vector2} location
			// @argument			{object} object
			// @returns				{int} | On error: {noone}
			// @description			Create an instance on this Layer and return its internal ID.
			static create_instance = function(_location, _object)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					var _instance = instance_create_layer(_location.x, _location.y, ID, _object)
					
					instanceList.add(_instance);
					
					return _instance;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "create_instance";
					var _errorText = ("Attempted to add Element to an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return noone;
				}
			}
			
			// @argument			{bool} instancesPaused
			// @description			Activate or deactivate all instances bound to this Layer.
			static setInstancePause = function(_instancesPaused)
			{
				if ((is_real(ID)) and (layer_exists(ID)))
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
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setInstancePause";
					var _errorText = ("Attempted to set a property of an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return noone;
				}
			}
			
			// @description			Destroy all instances that are bound to this Layer.
			static destroy_instances = function()
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					instanceList.clear();
					
					layer_destroy_instances(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "create_instance";
					var _errorText = ("Attempted to remove Elements from an invalid Layer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return noone;
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Create a string representing the constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the name and depth of this
			//						Layer.
			static toString = function()
			{
				if ((is_real(ID)) and (layer_exists(ID)))
				{
					return (instanceof(self) + "(" + string(name) + ": " + string(depth) + ")");
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
		#endregion
	#endregion
	#region [Elements]
		
		// @function				Layer.SpriteElement()
		// @argument				{Sprite} sprite
		// @description				Construct a Sprite Element, which is used to draw a Sprite on
		//							this Layer.
		//
		//							Construction methods:
		//							- New element: {Sprite} sprite
		//							- Wrapper: {spriteElement} spriteElement
		//							- Constructor copy: {Layer.SpriteElement} other
		function SpriteElement() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					// @description			Initialize the constructor.
					static construct = function()
					{
						ID = undefined;
						sprite = undefined;
						location = undefined;
						scale = undefined;
						angle = undefined;
						color = undefined;
						alpha = undefined;
						frame = undefined;
						speed = undefined;
						
						parent = other;
						
						if (argument_count > 0)
						{
							switch (instanceof(argument[0]))
							{
								case "SpriteElement":
									//|Construction method: Constructor copy.
									var _other = argument[0];
									
									sprite = _other.sprite;
									ID = layer_sprite_create(parent.ID, _other.location.x,
															 _other.location.y, sprite.ID);
									
									location = new Vector2(_other.location);
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
									//|Construction method: New element.
									sprite = argument[0];
									location = argument[1];
									ID = layer_sprite_create(parent.ID, location.x, location.y,
															 sprite.ID);
							
									scale = new Scale(sprite.scale.x, sprite.scale.y);
									angle = new Angle(sprite.angle.value);
									color = sprite.color;
									alpha = sprite.alpha;
									frame = sprite.frame;
									speed = sprite.speed;
									
									layer_sprite_xscale(ID, scale.x);
									layer_sprite_yscale(ID, scale.y);
									layer_sprite_angle(ID, angle.value);
									layer_sprite_blend(ID, color);
									layer_sprite_alpha(ID, alpha);
									layer_sprite_index(ID, frame);
									layer_sprite_speed(ID, speed);
								break;
							
								default:
									//|Construction method: Wrapper.
									ID = argument[0];
									sprite = new Sprite
									(
										layer_sprite_get_sprite(ID),
										new Vector2(layer_sprite_get_x(ID), layer_sprite_get_y(ID)),
										layer_sprite_get_index(ID),
										layer_sprite_get_speed(ID),
										new Scale(layer_sprite_get_xscale(ID), 
												  layer_sprite_get_yscale(ID)),
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
								break;
							}
						}
					}
					
					// @returns				{bool}
					// @description			Check if this constructor is functional.
					static isFunctional = function()
					{
						return ((instanceof(parent) == "Layer") and (parent.isFunctional())) and
								(layer_sprite_exists(parent.ID, ID));
					}
					
					// @argument			{Layer|int:layer} other
					// @description			Move this Element to another Layer.
					static changeParent = function(_other)
					{
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_sprite_exists(parent.ID, ID)))
						{
							if ((instanceof(_other) == "Layer") and (layer_exists(_other.ID)))
							{
								parent.spriteList.remove_value(self);
									
								parent = _other;
									
								parent.spriteList.add(self);
									
								layer_element_move(ID, parent.ID);
							}
							else if ((is_real(_other)) and (layer_exists(_other)))
							{
								parent.spriteList.remove_value(self);
									
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
					}
					
					// @returns				{undefined}
					// @description			Remove the internal information from the memory.
					static destroy = function()
					{
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_sprite_exists(parent.ID, ID)))
						{
							parent.spriteList.remove_value(self);
							
							layer_sprite_destroy(ID);
						}
						
						return undefined;
					}
					
				#endregion
				#region <<Execution>>
					
					// @argument			{Sprite|int:-1} sprite
					// @description			Set the sprite of this Sprite Element to the current
					//						status of the specified Sprite.
					//						A value of -1 can be specified instead of the Sprite,
					//						in which case this element will have no Sprite assigned.
					static update = function(_sprite)
					{
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) 
						and (layer_sprite_exists(parent.ID, ID)))
						{
							if (_sprite == -1)
							{
								sprite = _sprite;
								
								layer_sprite_change(ID, sprite);
								
								scale = undefined;
								angle = undefined;
								color = undefined;
								alpha = undefined;
								frame = undefined;
								speed = undefined;
							}
							else if ((instanceof(_sprite) == "Sprite") and (is_real(_sprite.ID))
							and (sprite_exists(_sprite.ID)))
							{
								sprite = _sprite;
								
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
							else
							{
								var _errorReport = new ErrorReport();
								var _callstack = debug_get_callstack();
								var _methodName = "update";
								var _errorText = ("Attempted to set properties of an Element " +
												  "to an invalid Sprite:\n" +
												  "Self: " + "{" + string(self) + "}" + "\n" +
												  "Sprite: " + "{" + string(_sprite) + "}");
								_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																	 _errorText);
							}
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "update";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
					}
					
				#endregion
				#region <<Conversion>>
					
					// @returns				{string}
					// @description			Create a string representing this constructor.
					//						Overrides the string() conversion.
					//						Content will be represented with the ID and the Sprite of
					//						this SpriteElement.
					static toString = function()
					{
						var _constructorName = "Layer.SpriteElement";
						
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
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
		// @description				Construct a Background Element, which is used to draw a 
		//							Background on this Layer.
		//
		//							Construction methods:
		//							- New element: {Sprite} sprite
		//							- Wrapper: {backgroundElement} backgroundElement
		//							- Constructor copy: {Layer.BackgroundElement} other
		function BackgroundElement() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					// @description			Initialize the constructor.
					static construct = function()
					{
						ID = undefined;
						sprite = undefined;
							
						visible = undefined;
						stretched = undefined;
						tiled_x = undefined;
						tiled_y = undefined;
							
						scale = undefined;
						color = undefined;
						alpha = undefined;
						frame = undefined;
						speed = undefined;
						
						parent = other;
						
						if (argument_count > 0)
						{
							switch (instanceof(argument[0]))
							{
								case "BackgroundElement":
									//|Construction method: Constructor copy.
									var _other = argument[0];
									
									sprite = _other.sprite;
									ID = layer_background_create(layer.ID, sprite.ID);
									
									visible = _other.visible;
									stretched = _other.stretched;
									tiled_x = _other.tiled_x;
									tiled_y = _other.tiled_y;
									
									scale = new Scale(_other.scale);
									color = _other.color;
									alpha = _other.alpha;
									frame = _other.frame;
									speed = _other.speed;
									
									layer_background_visible(ID, visible);
									layer_background_stretch(ID, stretched);
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
									//|Construction method: New element.
									sprite = argument[0];
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
								break;
								
								default:
									//|Construction method: Wrapper.
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
								break;
							}
						}
					}
					
					// @returns				{bool}
					// @description			Check if this constructor is functional.
					static isFunctional = function()
					{
						return ((instanceof(parent) == "Layer") and (parent.isFunctional())) and
								(layer_sprite_exists(parent.ID, ID));
					}
					
					// @argument			{Layer|layer} other
					// @description			Move this Element to another Layer.
					static changeParent = function(_other)
					{
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_background_exists(parent.ID, ID)))
						{
							if ((instanceof(_other) == "Layer") and (layer_exists(_other.ID)))
							{
								parent.backgroundList.remove_value(self);
									
								parent = _other;
									
								parent.backgroundList.add(self);
									
								layer_element_move(ID, parent.ID);
							}
							else if ((is_real(_other)) and (layer_exists(_other)))
							{
								parent.backgroundList.remove_value(self);
									
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
					}
					
					// @returns				{undefined}
					// @description			Remove the internal information from the memory.
					static destroy = function()
					{
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_background_exists(parent.ID, ID)))
						{
							parent.backgroundList.remove_value(self);
							
							layer_background_destroy(ID);
						}
						
						return undefined;
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
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_background_exists(parent.ID, ID)))
						{
							if (sprite == -1)
							{
								sprite = _sprite;
								
								layer_background_sprite(ID, sprite);
								
								scale = undefined;
								color = undefined;
								alpha = undefined;
								frame = undefined;
								speed = undefined;
							}
							else if ((instanceof(_sprite) == "Sprite") and (is_real(_sprite.ID))
							and (sprite_exists(_sprite.ID)))
							{
								sprite = _sprite;
								
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
							else
							{
								var _errorReport = new ErrorReport();
								var _callstack = debug_get_callstack();
								var _methodName = "update";
								var _errorText = ("Attempted to set properties of an Element " +
												  "to an invalid Sprite:\n" +
												  "Self: " + "{" + string(self) + "}" + "\n" +
												  "Sprite: " + "{" + string(_sprite) + "}");
								_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																	 _errorText);
							}
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "update";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
					}
					
				#endregion
				#region <<Setters>>
					
					// @argument			{bool} stretched
					// @description			Set the scretch property of this Background Element.
					static setStretched = function(_stretched)
					{
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_background_exists(parent.ID, ID)))
						{
							stretched = _stretched;
							
							layer_background_stretch(ID, _stretched);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setStretched";
							var _errorText = ("Attempted to set properties on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
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
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_background_exists(parent.ID, ID)))
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
					}
					
					// @argument			{bool} visible
					// @description			Set the visibility property of this Background Element.
					static setVisible = function(_visible)
					{
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_background_exists(parent.ID, ID)))
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
					}
					
				#endregion
				#region <<Conversion>>
					
					// @returns				{string}
					// @description			Create a string representing this constructor.
					//						Overrides the string() conversion.
					//						Content will be represented with the ID and the sprite of
					//						this BackgroundElement.
					static toString = function()
					{
						var _constructorName = "Layer.BackgroundElement";
						
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
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
		// @description				Construct a Tilemap Element, which is used to draw Tiles from
		//							a Tileset on this Layer.
		//
		//							Construction methods:
		//							- New element: {tileset} tileset, {Vector2} location,
		//										   {Vector2} size
		//							- Wrapper: {int} tilemapElement
		//							- Constructor copy: {Layer.TilemapElement} other
		function TilemapElement() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					// @description			Initialize the constructor.
					static construct = function()
					{
						ID = undefined;
						tileset = undefined;
						location = undefined;
						size = undefined;
						
						parent = other;
						
						if ((argument_count > 0) and (instanceof(argument[0]) == "TilemapElement"))
						{
							//|Construction method: Constructor copy.
							var _other = argument[0];
							
							tileset = _other.tileset;
							location = _other.location;
							size = _other.size;
							
							ID = layer_tilemap_create(parent.ID, location.x, location.y, 
													  tileset, size.x, size.y);
						}
						else
						{
							if (argument_count > 2)
							{
								//|Construction method: New element.
								tileset = argument[0];
								location = argument[1];
								size = argument[2];
								
								ID = layer_tilemap_create(parent.ID, location.x, location.y, 
														  tileset, size.x, size.y);
							}
							else
							{
								//|Construction method: Wrapper.
								ID = argument[0];
								
								tileset = tilemap_get_tileset(ID);
								location = new Vector2(tilemap_get_x(ID), tilemap_get_y(ID));
								size = new Vector2(tilemap_get_width(ID), tilemap_get_height(ID));
							}
						}

					}
					
					// @returns				{bool}
					// @description			Check if this constructor is functional.
					static isFunctional = function()
					{
						return ((instanceof(parent) == "Layer") and (parent.isFunctional())) and
								(layer_sprite_exists(parent.ID, ID));
					}
					
					// @returns				{undefined}
					// @description			Remove the internal information from the memory.
					static destroy = function()
					{
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
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
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
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
					}
					
					// @argument			{Layer|layer} other
					// @description			Move this Element to another Layer.
					static changeParent = function(_other)
					{
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							if ((instanceof(_other) == "Layer") and (layer_exists(_other.ID)))
							{
								parent.tilemapList.remove_value(self);
									
								parent = _other;
									
								parent.tilemapList.add(self);
									
								layer_element_move(ID, parent.ID);
							}
							else if ((is_real(_other)) and (layer_exists(_other)))
							{
								parent.tilemapList.remove_value(self);
									
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
					}
					
				#endregion
				#region <<Getters>>
					
					// @returns				{int} | On error: {int}
					// @description			Return the bit mask value for this Tilemap.
					//						Returns 0 if there is no mask and -1 in case of an error.
					static getMask = function()
					{
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
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
					
					// @returns				{int} | On error: {undefined}
					// @description			Return the current Sprite frame of this Tilemap.
					static getFrame = function()
					{
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
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
					
					// @returns				{Vector2} | On error: {undefined}
					// @description			Return the size of Tiles in this Tilemap.
					static getCellSize = function()
					{
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							return new Vector2(tilemap_get_tile_width(ID), 
											   tilemap_get_tile_height(ID));
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "getCellSize";
							var _errorText = ("Attempted to get properties of an invalid Element " +
											  "or Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
							
							return undefined;
						}
					}
					
					// @argument			{Vector2} location
					// @returns				{Layer.TilemapElement.TileData}
					// @description			Return a TileData referring to the Tile in a cell at the
					//						specified location.
					static getTile_inCell = function(_location)
					{
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							return new TileData(tilemap_get(ID, _location.x, _location.y));
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "getTile_inCell";
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
					static getTile_atPoint = function(_location)
					{
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							return new TileData(tilemap_get_at_pixel(ID, _location.x, _location.y));
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "getTile_atPoint";
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
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
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
					
					// @argument			{Vector2} location
					// @argument			{Layer.TilemapElement.TileData|int:tiledata} tiledata?
					// @returns				{bool}
					// @description			Set the Tile at the specified cell to a Tile referred
					//						to by the specified Tile Data and return a boolean for
					//						confirmation whether the operation was a success or not. 
					//						If Tile Data is not provided or 0 is provided in its
					//						place, the cell will be cleared.
					static setTile_inCell = function(_location, _tiledata)
					{
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							if (_tiledata == undefined)
							{
								_tiledata = 0;
							}
							else if (instanceof(_tiledata) == "TileData")
							{
								_tiledata = _tiledata.ID;
							}
							
							return ((_tiledata != -1) ? tilemap_set(ID, _tiledata, _location.x,
														_location.y) : false);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setTile_inCell";
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
					static setTile_inPoint = function(_tiledata, _location)
					{
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							if (_tiledata == undefined)
							{
								_tiledata = 0;
							}
							else if (instanceof(_tiledata) == "TileData")
							{
								_tiledata = _tiledata.ID;
							}
							
							return ((_tiledata != -1) ? tilemap_set_at_pixel(ID, _tiledata,
																			 _location.x,
																			 _location.y): false);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setTile_inPoint";
							var _errorText = ("Attempted to set a property on invalid Element or " +
											  "Layer:\n" +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Parent: " + "{" + string(parent) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
							
							return false;
						}
					}
					
					// @argument			{int|hex} mask
					// @description			Set the tile bit mask for this Tilemap.
					static setMask = function(_mask)
					{
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
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
							
							return false;
						}
					}
					
					// @argument			{tileset} tileset
					// @description			Change the Tileset used by this Tilemap.
					static setTileset = function(_tileset)
					{
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
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
					}
					
					// @argument			{Vector2} size
					// @description			Set the size of this Tilemap, which is the number of Tile
					//						cells it will use.
					static setSize = function(_size)
					{
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
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
					}
					
				#endregion
				#region <<Execution>>
					
					// @argument			{Vector2} location?
					// @description			Execute the draw of this Tilemap, independent of its 
					//						draw handled by its Layer.
					static render = function(_location)
					{
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
						{
							if (_location == undefined) {_location = new Vector2(0, 0);}
							
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
					}
					
				#endregion
				#region <<Conversion>>
					
					// @returns				{string}
					// @description			Create a string representing this constructor.
					//						Overrides the string() conversion.
					//						Content will be represented with the ID and properties of
					//						this TilemapElement.
					static toString = function(_multiline)
					{
						var _constructorName = "Layer.TilemapElement";
						
						if ((instanceof(parent) == "Layer") and (is_real(parent.ID)) 
						and (layer_exists(parent.ID)) and (layer_tilemap_exists(parent.ID, ID)))
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
				
				// @function				Layer.TilemapElement.TileData()
				// @argument				{int|hex} id
				// @description				Constructs a TileData Element, which refers to a Tile
				//							in this Tilemap.
				//
				//							Construction methods:
				//							- New constructor
				//							- Constructor copy: {Layer.TilemapElement.TileData} other
				function TileData(_id) constructor
				{
					#region [[[Methods]]]
						#region <<<Management>>>
							
							// @description			Initialize the constructor.
							static construct = function()
							{
								ID = 0;
								
								parent = other;
								
								if (instanceof(argument[0]) == "TileData")
								{
									//|Construction method: Constructor copy.
									var _other = argument[0];
									
									ID = _other.ID;
								}
								else
								{
									//|Construction method: New constructor.
									ID = argument[0];
								}
							}
							
							// @returns				{bool}
							// @description			Check if this constructor is functional.
							static isFunctional = function()
							{
								return ((ID >= 0));
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
							static isMirrored_x = function()
							{
								if (!(ID >= 0))
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "isMirrored_x";
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
							static isMirrored_y = function()
							{
								if (!(ID >= 0))
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "isMirrored_y";
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
							
							// @description			Empty the Tile this Tile Data refers to.
							static setEmpty = function()
							{
								if (!(ID >= 0))
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "setEmpty";
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
							}
							
							// @argument			{int}
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
							}
							
							// @argument			{bool}
							// @description			Set the horizontal mirroring property of the Tile
							//						this Tile Data refers to.
							static setMirror_x = function(_mirror)
							{
								if (!(ID >= 0))
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "setMirror_x";
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
							}
							
							// @argument			{bool}
							// @description			Set the vertical mirroring property of the Tile
							//						this Tile Data refers to.
							static setMirror_y = function(_mirror)
							{
								if (!(ID >= 0))
								{
									var _errorReport = new ErrorReport();
									var _callstack = debug_get_callstack();
									var _methodName = "setMirror_y";
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
							}
							
							// @argument			{bool}
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
								
								if (_location == undefined) {_location = new Vector2(0, 0);}
								if (_frame == undefined) {_frame = 0;}
									
								draw_tile(parent.tileset, ID, _frame, _location.x, _location.y);
							}
							
						#endregion
						#region <<<Conversion>>>
							
							// @returns				{string}
							// @description			Create a string representing this constructor.
							//						Overrides the string() conversion.
							//						Content will be represented with the ID of this
							//						TileData.
							static toString = function()
							{
								var _constructorName = "Layer.TilemapElement.TileData";
								
								return ((ID >= 0) ? (_constructorName + "(" + string(ID) + ")")
												  : (_constructorName + "<>"));
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
