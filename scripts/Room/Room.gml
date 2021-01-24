/// @function				Room()
/// @argument				{Vector2} size
/// @argument				{bool} persistent?
///
/// @description			Constructs a Room resource, used to group all other resources.
///
///							Construction methods:
///							- New constructor
///							- Duplicate Room: {room} other
///							- Constructor copy: {Room} other
function Room() constructor
{
	#region [Elements]
		
		// @function			Room.AddedInstance()
		// @argument			{object} object
		// @argument			{Vector2} location
		// @description			A container constructor for properties of instances added to this Room
		//						before its activation.
		//
		//						Construction methods:
		//						- New constructor.
		//						- Constructor copy: {Room.AddedInstance} other
		function AddedInstance(_object, _location) constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					// @description			Initialize the constructor.
					static construct = function()
					{
						parent = other;
						
						if ((argument_count > 0) and (instanceof(argument[0]) == "AddedInstance"))
						{
							//|Construction method: Constructor copy.
							var _other = argument[0];
							
							object = _other.object;
							location = _other.location;
							
							ID = room_instance_add(parent.ID, location.x, location.y, object);
						}
						else
						{
							//|Construction method: New constructor.
							object = argument[0];
							location = argument[1];
							
							ID = room_instance_add(parent.ID, location.x, location.y, object);
						}
					}
					
				#endregion
				#region <<Conversion>>
					
					// @returns				{string}
					// @description			Create a string representing this constructor.
					//						Overrides the string() conversion.
					//						Content will be represented with the properties of the
					//						instance.
					static toString = function()
					{
						var _constructorName = "Room.AddedInstance";
						
						return (_constructorName + 
								"(" + 
								"Object: " + object_get_name(object) + ", " + 
								"Location: " + string(location) + 
								")");
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
				ID = room_add();
				name = room_get_name(ID);
				persistent = undefined;
				size = undefined;
				addedInstanceList = new List();
				
				if ((argument_count > 0) and (instanceof(argument[0]) == "Room"))
				{
					if ((is_real(_other.ID)) and (room_exists(_other.ID)))
					{
						//|Construction method: Constructor copy.
						persistent = _other.persistent;
						size = _other.size;
						
						var _i = 0;
						repeat (_other.addedInstanceList.getSize())
						{
							addedInstanceList.add
							(
								new AddedInstance(_other.addedInstanceList.getValue[_i])
							);
							
							++_i;
						}
						
						if (size != undefined)
						{
							room_set_width(ID, size.x);
							room_set_height(ID, size.y);
						}
						
						if (persistent != undefined)
						{
							room_set_persistent(ID, persistent);
						}
						
						room_assign(ID, _other.ID);
					}
				}
				else
				{
					if (is_real(argument[0]))
					{
						var _other = argument[0];
						
						if (room_exists(_other))
						{
							//|Construction method: Room Duplicate.
							room_assign(ID, _other);
						}
					}
					else
					{
						//|Construction method: New Room.
						var _size = ((argument_count > 0) ? argument[0] : undefined);
						var _persistent = ((argument_count > 1) ? argument[1] : undefined);
						
						size = ((_size != undefined) ? _size : new Vector2(0, 0));
						persistent = ((_persistent != undefined) ? _persistent : false);
						
						room_set_width(ID, size.x);
						room_set_height(ID, size.y);
						room_set_persistent(ID, persistent);
					}
				}
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{Vector2} size
			// @description			Resize this Room to set location boundary for added instances.
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
				}
			}
			
			// @argument			{bool} value
			// @description			Change the persistence property for this Room.
			static setPersistent = function(_persistent)
			{		
				if ((is_real(ID)) and (room_exists(ID)))
				{
					persistent = _persistent;
					
					room_set_persistent(ID, persistent);
				}
			}
			
		#endregion
		#region <Execution>
			
			// @description			Switch the active room to this one.
			static goto = function()
			{
				if (room_exists(ID))
				{
					room_goto(ID);
				}
			}
			
			// @argument			{object} object
			// @argument			{Vector2} location
			// @returns				{Room.AddedInstance} | On error: {noone}
			// @description			Add an instance of an object to this inactive room.
			static instance_add = function(_object, _location)
			{
				if ((is_real(ID)) and (room_exists(ID)) and (room != ID))
				{
					if (_location == undefined) {_location = new Vector2(0, 0);}
					
					var _addedInstance = new AddedInstance(_object, _location);
					
					addedInstanceList.add(_addedInstance);
					
					return _addedInstance;
				}
				else
				{
					return noone;
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the ID and name of this Room.
			static toString = function()
			{
				if ((is_real(ID)) and (room_exists(ID)))
				{
					return (instanceof(self) + "(" + string(ID) + ": " + string(name) + ")");
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
		
		script_execute_ext(method_get_index(self.construct), argument_original);
		
	#endregion
}
