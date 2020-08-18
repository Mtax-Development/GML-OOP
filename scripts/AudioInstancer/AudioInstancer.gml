/// @function				AudioInstancer()
/// @argument				{sound} file
/// @argument				{real|Range} pitch
/// @argument				{real} priority (within range: 0-100)
/// @description			Constructs an instance tracker of single Audio resource playback.
///
///							A single selected sound can be played and then manipulated.
///							The constructed object will track all instances of the sound
///							played by it on their play and will affect them all upon modifying
///							its status. So for example, if a sound is played before its
///							previous playback is not finished and then it's paused, both of
///							the playbacks will be paused and then both will also be resumed
///							at the same time upon the resume, creating a stack of sounds.
function AudioInstancer(_file, _pitch, _priority) constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Refresh the instance list by checking which still exists.
			static list_instances = function()
			{
				var instances_new = [];
				
				var instances_length = array_length(instances);
		
				for (var i = 0; i < instances_length; i++)
				{
					if (audio_exists(instances[i]))
					{
						instances_new[array_length(instances_new)] = instances[i];
					}
				}
				
				instances = instances_new;
			}
			
		#endregion
		#region <Execution>
			
			// @description			Execute the sound playback.
			static play = function()
			{
				if (audio_exists(file))
				{	
					var instance = audio_play_sound(file, 0, false);
			
					if (instanceof(pitch) == "Range")
					{
						audio_sound_pitch(instance, pitch.random_real());
					}
					else
					{
						audio_sound_pitch(instance, pitch);
					}
					
					self.list_instances();
					
					instances[array_length(instances)] = instance;
					
					return instance;
				}
			}
			
			// @description			Stop all instances of the sound and clear their list.
			static stop = function()
			{
				for (var i = 0; i < array_length(instances); i++)
				{
					if (audio_exists(instances[i]))
					{
						audio_stop_sound(instances[i]);
					}
				}
				
				instances = [];
			}
			
			// @argument			{bool} pause
			// @description			Pause all instances or resume all of the paused ones at once.
			static pause = function(_pause)
			{
				for (var i = 0; i < array_length(instances); i++)
				{
					if (audio_exists(instances[i]))
					{
						if (_pause)
						{
							audio_pause_sound(instances[i]);
						}
						else
						{
							audio_resume_sound(instances[i]);
						}
					}
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Overrides the string conversion with a name output.
			static toString = function()
			{
				return ((audio_exists(file)) ? audio_get_name(file) : string(undefined));
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		file = _file;
		pitch = _pitch;
		priority = _priority;
		instances = [];
		
	#endregion
}
