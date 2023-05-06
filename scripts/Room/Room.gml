/// @function				Room()
/// @argument				size? {Vector2}
/// @argument				persistent? {bool}
///							
/// @description			Constructs a Room resource, used to group all other resources.
///							
///							Construction types:
///							- New constructor
///							- Wrapper: other {int:room}
///							- Empty: {undefined}
///							- Constructor copy: other {Room}
function Room() constructor
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				ID = undefined;
				name = string(undefined);
				persistent = undefined;
				size = undefined;
				addedInstances = [];
				visited = false;
				persistenceOnVisit = undefined;
				previousRoom = undefined;
				
				if (argument_count > 0)
				{
					if (instanceof(argument[0]) == "Room")
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
					else if (is_real(argument[0]))
					{
						//|Construction type: Wrapper.
						ID = argument[0];
						name = room_get_name(ID);
					}
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
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (room_exists(ID)));
			}
			
			/// @argument			other {Room|int:room}
			/// @description		Replace the contents and properties of this Room with the ones
			///						from another one.
			static copy = function(_other)
			{
				if (is_real(_other) and (room_exists(_other)))
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
					new ErrorReport().report([other, self, "copy()"],
											 ("Attempted to copy from an invalid Room: " +
											  "{" + string(_other) + "}"));
				}
				
				return self;
			}
			
		#endregion
		#region <Getters>
			
			/// @returns			{bool}
			/// @description		Check if this Room is the one currently active.
			static isActive = function()
			{
				return ((is_real(ID)) and (room_exists(ID)) and (room == ID));
			}
			
		#endregion
		#region <Setters>
			
			/// @argument			size {Vector2}
			/// @description		Set the room size property for this Room if it is not in use.
			static setSize = function(_size)
			{
				try
				{
					if (room != ID)
					{
						room_set_width(ID, _size.x);
						room_set_height(ID, _size.y);
						
						size = ((instanceof(size) == "Vector2") ? size.set(_size)
																: new Vector2(_size));
					}
					else
					{
						new ErrorReport().report([other, self, "setSize()"],
												 ("Attempted to set a property of a Room in use: " +
												  "{" + room_get_name(room) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setSize()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			persistent {bool}
			/// @description		Toggle the persistence of this Room.
			///						Cannot be used to free the memory if this Room was active while
			///						persistent and is not currently active.
			static setPersistent = function(_persistent)
			{
				if ((is_real(ID)) and (room_exists(ID)))
				{
					if (room != ID)
					{
						if ((_persistent) or (!persistenceOnVisit))
						{
							room_set_persistent(ID, _persistent);
							
							persistent = _persistent;
						}
						else
						{
							new ErrorReport().report([other, self, "setPersistent()"],
													 ("Attempted to disable persistency of a Room " +
													  "that was visited while persistent and is not " +
													  "currently active: " +
													  "{" + room_get_name(ID) + "}"));
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
					new ErrorReport().report([other, self, "setPersistent()"],
											 ("Attempted to change a property of an invalid Room: " +
											  "{" + string(ID) + "}"));
				}
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			object {int:object}
			/// @argument			location? {Vector2}
			/// @returns			{Room.AddedInstance} | On error: {noone}
			/// @description		Add an instance of an object to this inactive room.
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
						new ErrorReport().report([other, self, "createInstance()"],
												 ("Attempted to add an instance to a Room in use: " +
												  "{" + room_get_name(room) + "}"));
						
						return noone;
					}
				}
				else
				{
					new ErrorReport().report([other, self, "createInstance()"],
											 ("Attempted to add an instance to an invalid Room: " +
											  "{" + string(ID) + "}"));
					
					return noone;
				}
			}
			
			/// @description		Switch the active room to this one.
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
					new ErrorReport().report([other, self, "setActive()"],
											 ("Attempted to switch to an invalid Room: " +
											  "{" + string(ID) + "}"));
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
			///						Content will be represented with the properties of this Room.
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
		// @argument			object {int:object}
		// @argument			location? {Vector2}
		//						
		// @description			A container constructor for properties of instances added to this Room
		//						before its activation.
		//						
		//						Construction types:
		//						- New element
		//						- Constructor copy: other {Room.AddedInstance}
		function AddedInstance() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					/// @description		Initialize the constructor.
					static construct = function()
					{
						parent = other;
						ID = undefined;
						object = undefined;
						location = undefined;
						
						array_push(parent.addedInstances, self);
						
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
							//|Construction type: New element
							object = argument[0];
							location = (((argument_count > 1) and (argument[1] != undefined))
										? argument[1] : new Vector2(0, 0));
							ID = room_instance_add(parent.ID, location.x, location.y, object);
						}
						
						return self;
					}
					
					/// @returns			{bool}
					/// @description		Check if this constructor is functional.
					static isFunctional = function()
					{
						return ((is_real(ID)) and (is_real(object))
								and (instanceof(location) == "Vector2")
								and (location.isFunctional()));
					}
					
				#endregion
				#region <<Conversion>>
					
					/// @argument			multiline? {bool}
					/// @returns			{string}
					/// @description		Create a string representing this constructor.
					///						Overrides the string() conversion.
					///						Content will be represented with the properties of this
					///						instance.
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
				
				static prototype = {};
				var _property = variable_struct_get_names(prototype);
				var _i = 0;
				repeat (array_length(_property))
				{
					var _name = _property[_i];
					var _value = variable_struct_get(prototype, _property[_i]);
					
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
			var _value = variable_struct_get(prototype, _property[_i]);
			
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

