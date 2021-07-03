/// @argument			{Sprite} sprite
/// @argument			{Vector2} location
/// @argument			{int} frame?
/// @argument			{Scale} scale?
/// @argument			{Angle} angle?
/// @argument			{int:color} color?
/// @argument			{int} alpha?
///
/// @description		Construct a handler storing information for Sprite rendering.
///						
///						Construction types:
///						- New constructor
///						- Empty: {void}
///						- Constructor copy: {SpriteDraw} other
function SpriteDraw() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				sprite = undefined;
				location = undefined;
				frame = undefined;
				scale = undefined;
				angle = undefined;
				color = undefined;
				alpha = undefined;
				
				if (argument_count > 0)
				{
					if (instanceof(argument[0]) == "SpriteDraw")
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						sprite = ((instanceof(_other.sprite) == "Sprite")
								  ? new Sprite(_other.sprite.ID) : _other.sprite);
						location = ((instanceof(_other.location) == "Vector2")
									? new Vector2(_other.location) : _other.location);
						frame = _other.frame;
						scale = ((instanceof(_other.scale) == "Scale") ? new Scale(_other.scale)
																	   : _other.scale);
						angle = ((instanceof(_other.angle) == "Angle") ? new Angle(_other.angle)
																	   : _other.angle);
						color = _other.color;
						alpha = _other.alpha;
					}
					else
					{
						//|Construction type: New constructor.
						sprite = argument[0];
						location = argument[1];
						frame = ((argument_count > 2) ? argument[2] : 0);
						scale = ((argument_count > 3) ? argument[3] : new Scale(1, 1));
						angle = ((argument_count > 4) ? argument[4] : new Angle(0));
						color = ((argument_count > 5) ? argument[5] : c_white);
						alpha = ((argument_count > 6) ? argument[6] : 1);
					}
				}
			}
			
		#endregion
		#region <Execution>
			
			// @description			Execute the draw.
			static render = function()
			{
				sprite.render(location, frame, scale, angle, color, alpha);
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
