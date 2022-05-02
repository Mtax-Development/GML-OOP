/// @function				Room()
/// @argument				{Vector2} size?
/// @argument				{bool} persistent?
///							
/// @description			Constructs a Room resource, used to group all other resources.
///							
///							Construction types:
///							- New constructor
///							- Wrapper: {int:room} other
///							- Constructor copy: {Room} other
function Room() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				ID = undefined;
				name = string(undefined);
				persistent = undefined;
				size = undefined;
				addedInstances = [];
				visited = false;
				persistenceOnVisit = undefined;
				previousRoom = undefined;
				
				if ((argument_count > 0) and (instanceof(argument[0]) == "Room"))
				{
					var _other = argument[0];
					
					if (_other.isFunctional())
					{
						//|Construction type: Constructor copy.
						persistent = _other.persistent;
						size = ((instanceof(_other.size) == "Vector2") ? new Vector2(_other.size)
																	   : _other.size);
						
						ID = room_add();
						room_set_width(ID, size.x);
						room_set_height(ID, size.y);
						
						if (persistent)
						{
							room_set_persistent(ID, persistent);
						}
						
						room_assign(ID, _other.ID);
						
						var _addedInstancesCount = array_length(_other.addedInstances);
						
						addedInstances = array_create(_addedInstancesCount);
						
						var _i = 0;
						repeat (_addedInstancesCount)
						{
							addedInstances[_i] = new AddedInstance(_other.addedInstances[_i]);
							
							++_i;
						}
					}
				}
				else if ((argument_count > 0) and (is_real(argument[0])))
				{
					//|Construction type: Wrapper.
					ID = argument[0];
					name = room_get_name(ID);
				}
				else
				{
					//|Construction type: New constructor.
					size = (((argument_count > 0) and (argument[0] != undefined))
							? argument[0] : new Vector2(0, 0));
					persistent = (((argument_count > 1) and (argument[1] != undefined)) ? argument[1]
																						: false);
					
					ID = room_add();
					
					room_set_width(ID, size.x);
					room_set_height(ID, size.y);
					room_set_persistent(ID, persistent);
				}
				
				return self;
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (room_exists(ID)));
			}
			
			// @argument			{Room|int:room} other
			// @description			Replace the contents and properties of this Room with the ones
			//						from another one.
			static copy = function(_other)
			{
				if (is_real(_other))
				{
					room_assign(ID, _other);
					
					size = undefined;
					addedInstances = [];
				}
				else if ((instanceof(_other) == "Room") and (_other.isFunctional()))
				{
					room_assign(ID, _other.ID);
					
					persistent = _other.persistent;
					size = _other.size;
					addedInstances = [];
					
					if (is_array(_other.addedInstances))
					{
						array_copy(addedInstances, 0, _other.addedInstances, 0,
								   array_length(_other.addedInstances));
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "copy";
					var _errorText = ("Attempted to copy from an invalid Room: " +
									  "{" + string(_other) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{bool}
			// @description			Check if this Room is the one currently active.
			static isActive = function()
			{
				return ((is_real(ID)) and (room_exists(ID)) and (room == ID));
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{Vector2} size
			// @description			Set the room size property for this Room if it is not in use.
			static setSize = function(_size)
			{
				if ((is_real(ID)) and (room_exists(ID)))
				{
					if (room != ID)
					{
						size = _size;
						
						room_set_width(ID, size.x);
						room_set_height(ID, size.y);
					}
					else
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "setSize";
						var _errorText = ("Attempted to set a property of a Room in use: " +
										  "{" + string(ID) + "}");
						_errorReport.reportConstructorMethod(self, _callstack, _methodName,
															 _errorText);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setSize";
					var _errorText = ("Attempted to change a property of an invalid Room: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{bool} persistent
			// @description			Toggle the persistence of this Room.
			//						Cannot be used to free the memory if this Room was active while
			//						persistent and is not currently active.
			static setPersistent = function(_persistent)
			{
				if ((is_real(ID)) and (room_exists(ID)))
				{
					if (room != ID)
					{
						if ((_persistent) or (!persistenceOnVisit))
						{
							persistent = _persistent;
							
							room_set_persistent(ID, persistent);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "setPersistent";
							var _errorText = ("Attempted to disable persistency of a Room that was " +
											  "visited while persistent and is not currently " +
											  "active: " +
											  "{" + string(ID) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
						}
					}
					else
					{
						room_persistent = _persistent;
						persistent = _persistent;
						persistenceOnVisit = _persistent;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setPersistent";
					var _errorText = ("Attempted to change a property of an invalid Room: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{object} object
			// @argument			{Vector2} location?
			// @returns				{Room.AddedInstance} | On error: {noone}
			// @description			Add an instance of an object to this inactive room.
			static createInstance = function(_object, _location)
			{
				if ((is_real(ID)) and (room_exists(ID)))
				{
					if (room != ID)
					{
						return new AddedInstance(_object, _location);
					}
					else
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "createInstance";
						var _errorText = ("Attempted to add an instance to a Room in use: " +
										  "{" + string(ID) + "}");
						_errorReport.reportConstructorMethod(self, _callstack, _methodName,
															 _errorText);
						
						return noone;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "createInstance";
					var _errorText = ("Attempted to add an Element to an invalid Room: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return noone;
				}
			}
			
			// @description			Switch the active room to this one.
			static setActive = function()
			{
				if ((is_real(ID)) and (room_exists(ID)))
				{
					if (room != ID)
					{
						previousRoom = room;
					}
					
					visited = true;
					persistenceOnVisit = persistent;
					
					room_goto(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "goto";
					var _errorText = ("Attempted to switch to an invalid Room: " +
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
			//						Content will be represented with the properties of this Room.
			static toString = function(_multiline = false, _full = false)
			{
				if ((is_real(ID)) and (room_exists(ID)))
				{
					var _string = "";
					var _mark_separator = ((_multiline) ? "\n" : ", ");
					
					if (!_full)
					{
						_string = ("ID: " + (string(ID)) + _mark_separator +
								   "Name: " + string(name));
					}
					else
					{
						var _string_addedInstanceCount = ((is_array(addedInstances))
														  ? string(array_length(addedInstances))
														  : string(undefined));
						
						_string = ("ID: " + string(ID) + _mark_separator +
								   "Name: " + string(name) + _mark_separator +
								   "Persistent: " + string(persistent) + _mark_separator +
								   "Size: " + string(size) + _mark_separator +
								   "Added Instance Count:" + _string_addedInstanceCount
														   + _mark_separator +
								   "Visited: " + string(visited) + _mark_separator +
								   "Persistence on Visit: " + string(persistenceOnVisit)
															+ _mark_separator +
								   "Previous Room: " + string(previousRoom));
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
		
		// @function			Room.AddedInstance()
		// @argument			{int:object} object
		// @argument			{Vector2} location?
		//						
		// @description			A container constructor for properties of instances added to this Room
		//						before its activation.
		//						
		//						Construction types:
		//						- New constructor.
		//						- Constructor copy: {Room.AddedInstance} other
		function AddedInstance() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					// @description			Initialize the constructor.
					static construct = function()
					{
						parent = other;
						array_push(parent.addedInstances, self);
						
						ID = undefined;
						
						object = undefined;
						location = undefined;
						
						if (string_copy(string(instanceof(argument[0])), 1, 13) == "AddedInstance")
						{
							//|Construction type: Constructor copy.
							var _other = argument[0];
							
							object = _other.object;
							location = ((instanceof(_other.location) == "Vector2")
										? new Vector2(_other.location) : _other.location);
							
							ID = room_instance_add(parent.ID, location.x, location.y, object);
						}
						else
						{
							//|Construction type: New constructor.
							object = argument[0];
							location = (((argument_count > 1) and (argument[1] != undefined))
										? argument[1] : new Vector2(0, 0));
							
							ID = room_instance_add(parent.ID, location.x, location.y, object);
						}
						
						return self;
					}
					
					// @returns				{bool}
					// @description			Check if this constructor is functional.
					static isFunctional = function()
					{
						return ((is_real(ID)) and (is_real(object))
								and (instanceof(location) == "Vector2")
								and (location.isFunctional()));
					}
					
				#endregion
				#region <<Conversion>>
					
					// @argument			{bool} multiline?
					// @returns				{string}
					// @description			Create a string representing this constructor.
					//						Overrides the string() conversion.
					//						Content will be represented with the properties of this
					//						instance.
					static toString = function(_multiline = false)
					{
						var _constructorName = "Room.AddedInstance";
						
						if (self.isFunctional())
						{
							var _mark_separator = ((_multiline) ? "\n" : ", ");
							
							var _string = ("Object: " + object_get_name(object) + _mark_separator +
										   "Location: " + string(location));
							
							return ((_multiline) ? _string
												 : (_constructorName + "(" + _string +
													")"));
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

