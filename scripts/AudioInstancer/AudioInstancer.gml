/// @function				AudioInstancer()
/// @argument				{sound} file
/// @argument				{real|Range} pitch
/// @argument				{real} priority 
///
/// @description			Constructs an instance tracker of single Audio resource playback,
///							which can play Audio and manipulate its all instances all at once.
///
///							Construction methods:
///							- New constructor
///							- Constructor copy: {AudioInstancer} other
///							   The current instance list will not be copied.
function AudioInstancer() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				file = undefined;
				pitch = undefined;
				priority = undefined;
				instances = undefined;
				
				if ((argument_count > 0) and (instanceof(argument[0]) == "AudioInstancer"))
				{
					//|Construction method: Constructor copy.
					var _other = argument[0];
					
					file = _other.file;
					pitch = _other.pitch;
					priority = _other.priority;
					instances = _other.instances;
				}
				else
				{
					//|Construction method: New constructor.
					file = argument[0];
					pitch = argument[1];
					priority = argument[2];
					instances = [];
				}
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(file)) and (audio_exists(file))
				and (is_real(priority)) and (is_array(instances))
				and ((is_real(pitch)) or ((instanceof(pitch) == "Range")
				and (pitch.isFunctional()))));
			}
			
			// @description			Refresh the instance list by checking which still exists.
			static refresh = function()
			{
				var _instances_new = [];
				
				var _instances_length = array_length(instances);
				
				var _i = 0;
				repeat (_instances_length)
				{
					if (audio_exists(instances[_i]))
					{
						_instances_new[array_length(_instances_new)] = _instances[_i];
					}
					
					++_i;
				}
				
				instances = _instances_new;
			}
			
		#endregion
		#region <Execution>
			
			// @returns				{int} | On error: {undefined}
			// @description			Execute the sound playback and return its instance.
			static play = function()
			{
				if ((is_real(file)) and (audio_exists(file)))
				{	
					var _instance = audio_play_sound(file, 0, false);
					
					if (instanceof(pitch) == "Range")
					{
						audio_sound_pitch(_instance, pitch.random_real());
					}
					else
					{
						audio_sound_pitch(_instance, pitch);
					}
					
					self.refresh();
					
					array_push(instances, _instance);
					
					return _instance;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "play";
					var _errorText = ("Attempted to play an invalid audio file: " + 
									  "{" + string(file) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @description			Stop all instances of the sound playback and clear their list.
			static stop = function()
			{
				var _i = 0;
				repeat (array_length(instances))
				{
					if (audio_exists(instances[_i]))
					{
						audio_stop_sound(instances[_i]);
					}
					
					++_i;
				}
				
				instances = [];
			}
			
			// @argument			{bool} pause
			// @description			Pause or resume all existing instances of the sound playback.
			static pause = function(_pause)
			{
				if (_pause == undefined) {_pause = true;}
				
				var _i = 0;
				
				if (_pause)
				{
					repeat (array_length(instances))
					{
						audio_pause_sound(instances[_i]);
					}
					
					++_i;
				}
				else
				{
					repeat (array_length(instances))
					{
						audio_resume_sound(instances[_i]);
					}
					
					++_i;
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the name of the audio file.
			static toString = function()
			{
				if ((is_real(file)) and (audio_exists(file)))
				{
					return (instanceof(self) + "(" + audio_get_name(file) + ")");
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
