/// @function				AudioFile();
/// @argument				file {sound}
/// @argument				pitch {real | Range}
/// @argument				priority {real} (within range: 0-100)
function AudioFile(_file, _pitch, _priority) constructor
{
	file = _file;
	pitch = _pitch;
	priority = _priority;
	instances = [];
	
	
	static list_instances = function()
	{
		var instances_new = [];
		
		var instances_length = array_length(instances)
		
		for (var i = 0; i < instances_length; i++)
		{
			if (audio_exists(instances[i]))
			{
				instances_new[array_length(instances_new)] = instances[i];
			}
		}
		
		instances = instances_new;
	}
	
	static play = function()
	{
		if (audio_exists(file))
		{	
			var instance = audio_play_sound(file, 0, false);
			
			if (is_struct(pitch))
			{
				audio_sound_pitch(instance, pitch.random_real());
			}
			else
			{
				audio_sound_pitch(instance, pitch);
			}
			
			list_instances();
			
			instances[array_length(instances)] = instance;
			
			return instance;
		}
	}
	
	static stop = function()
	{
		for (var i = 0; i < array_length(instances); i++)
		{
			if (audio_exists(instances[i]))
			{
				audio_stop_sound(instances[i]);
			}
		}
	}
	
	static pause = function(_state)
	{
		for (var i = 0; i < array_length(instances); i++)
		{
			if (audio_exists(instances[i]))
			{
				if (_state)
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
}
