/// @function				AudioFile();
/// @argument				file {sound}
/// @argument				pitch {real | Range}
/// @argument				priority {real} (within range: 0-100)
function AudioFile(_file, _pitch, _priority) constructor
{
	file = _file;
	pitch = _pitch;
	priority = _priority;
	instance = undefined;
	
	static play = function()
	{
		if (audio_exists(file))
		{
			instance = audio_play_sound(file, 0, false);
			
			if (is_struct(pitch))
			{
				audio_sound_pitch(instance, pitch.random_real());
			}
			else
			{
				audio_sound_pitch(instance, pitch);
			}
			
			return instance;
		}
	}
	
	static stop = function()
	{
		if (audio_exists(instance))
		{
			audio_stop_sound(instance);
		}
	}
	
	static pause = function(_state)
	{
		if (audio_exists(instance))
		{
			if (_state)
			{
				audio_pause_sound(instance);
			}
			else
			{
				audio_resume_sound(instance);
			}
		}
	}
}
