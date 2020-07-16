/// @function				Room()
/// @argument				{Vector2} size?
/// @argument				{bool} persistent?
///
/// @description			Constructs and creates a Room resource with its information.
function Room(_size, _persistent) constructor
{
	#region [Methods]
		#region <Management>
			
			// @argument			{object} object
			// @argument			{Vector2} location
			// @description			Add an instance to this room when it's inactive.
			static addInstance = function(_object, _location)
			{
				if ((room_exists(ID)) and (room != ID))
				{
					room_instance_add(ID, _location.x, _location.y, _object);
					
					instances[array_length(instances)] = 
					{
						object: _object,
						location: _location
					}
				}
			}
			
			// @argument			{room|Room} room
			// @description			Make this room a duplicate of any existing one.
			static duplicate = function(_room)
			{
				if (instanceof(_room) == "Room")
				{
					if (room_exists(_room.ID))
					{
						ID = room_add();
						name = room_get_name(ID);
						persistent = _room.persistent;
						size = _room.size;

						room_set_width(ID, size.x);
						room_set_height(ID, size.y);
						room_set_persistent(ID, persistent);
				
						for (var i = 0; i < array_length(_room.instances); i++)
						{
							instance_add(_room.instances[i].object, _room.instances[i].location);
						}
					}
				}
				else
				{
					if (room_exists(_room))
					{
						ID = room_duplicate(_room);
						name = room_get_name(ID);
						persistent = _room.persistent;
						size = undefined; //+TODO
					}
				}
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{Vector2} size
			// @description			Resize the room to set location limitations of added instances.
			static setSize = function(_size)
			{
				if (room_exists(ID))
				{
					if (size.x != _size.x)
					{
						size.x = _size.x;
						room_set_width(ID, size.x);
					}
					
					if (size.y != _size.y)
					{
						size.y = _size.y;
						room_set_height(ID, size.y);
					}
				}
			}
			
			// @argument			{bool} value
			// @description			Change the persistence flag for this room.
			static setPersistent = function(_persistent)
			{		
				if (room_exists(ID))
				{
					persistent = _persistent;
					
					room_set_persistent(ID, persistent);
				}
			}
			
			// @description			Set all further Layer-related functions to this room.
			static setLayerTarget = function()
			{
				if (room_exists(ID))
				{
					layer_set_target_room(ID);
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
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Overrides the string conversion with a Room name and size output.
			static toString = function()
			{
				return ((room_exists(ID)) ? (name + " (" + string(size) + ")") : string(undefined));
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		size = ((_size != undefined) ? _size : new Vector2(0, 0));
		persistent = ((_persistent != undefined) ? _persistent : false);
		
		ID = room_add();
		name = room_get_name(ID);
		instances = [];
		
		room_set_width(ID, size.x);
		room_set_height(ID, size.y);
		room_set_persistent(ID, persistent);
		
	#endregion
}
