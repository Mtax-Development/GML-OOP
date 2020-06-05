/// @function				Room();
/// @argument				size? {Vector2}
///
/// @description			Constructs and creates a room resource, then saves
///							its information in a container. Also handles all
///							relevant functions and extends some of them.
function Room() constructor
{
	var _size = (argument_count >= 1 ? argument[0] : new Vector2(0, 0));
	
	size = _size;
	
	ID = room_add();
	name = room_get_name(ID);
	persistent = false;
	
	room_set_width(ID, size.x);
	room_set_height(ID, size.y);
	room_set_persistent(ID, persistent);


	static goto = function()
	{
		if (room_exists(ID))
		{
			room_goto(ID);
		}
	}
	
	static set_size = function(_size)
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
	
	static set_persistent = function(_value)
	{
		if (room_exists(ID))
		{
			room_set_persistent(ID, _value);
		}
	}
	
	static duplicate = function(_room)
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
		}
	}
	
	/// @function instance_add
	static instance_add = function(_object, _location)
	{
		if (room_exists(ID))
		{
			room_instance_add(ID, _location.x, _location.y, _object);
		}
	}
	
	static toString = function()
	{
		return name;
	}
}