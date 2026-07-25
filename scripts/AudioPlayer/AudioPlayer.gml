//  @function			AudioPlayer()
/// @argument			audio [Audio}
/// @argument			loop? {bool}
/// @argument			pitch? {real}
/// @argument			gain? {real}
/// @argument			offset? {real}
/// @argument			priority? {int}
/// @argument			singular? {bool}
/// @description		Constructs a Handler storing information for playing Audio.
// 						
// 						Construction types:
// 						- New constructor
// 						- Empty: {void}
// 						- Constructor copy: other {AudioPlayer}
function AudioPlayer() constructor
//  @feather	ignore all
{
  #region [Methods]
   #region <Management>
	
	/// @description		Initialize this constructor.
	static construct = function()
	{
		//|Construction type: Empty.
		audio = undefined;
		loop = undefined;
		pitch = undefined;
		gain = undefined;
		offset = undefined;
		priority = undefined;
		singular = undefined;
		
		var _scope = self;
		event =
		{
			beforePlaying: new Callback(undefined, [], _scope),
			afterPlaying: new Callback(undefined, [], _scope)
		};
		
		if ((argument_count > 0) and (argument[0] != undefined))
		{
			if (is_instanceof(argument[0], AudioPlayer))
			{
				//|Construction type: Constructor copy.
				var _other = argument[0];
				
				audio = _other.audio;
				loop = _other.loop;
				pitch = _other.pitch;
				gain = _other.gain;
				offset = _other.offset;
				priority = _other.priority;
				singular = _other.singular;
				
				if (is_struct(_other.event))
				{
					event.beforePlaying.setAll(_other.event.beforePlaying);
					event.afterPlaying.setAll(_other.event.afterPlaying);
				}
				else
				{
					event = _other.event;
				}
			}
			else
			{
				//|Construction type: New constructor.
				audio = argument[0];
				loop = ((argument_count > 1) ? argument[1] : false);
				pitch = ((argument_count > 2) ? argument[2] : 1);
				gain = ((argument_count > 3) ? argument[3] : 1);
				offset = ((argument_count > 4) ? argument[4] : undefined);
				priority = ((argument_count > 5) ? argument[5] : undefined);
				singular = ((argument_count > 6) ? argument[6] : false);
			}
		}
		
		return self;
	}
	
	/// @returns			{bool}
	/// @description		Check if this constructor is functional.
	static isFunctional = function()
	{
		return (((is_instanceof(audio, Audio)) and (audio.isFunctional())) and (is_bool(loop)) and
				(is_real(pitch)) and (is_real(gain)) and (is_real(offset)) and (is_real(priority)) and
				(is_bool(singular)));
	}
	
   #endregion
   #region <Execution>
	
	/// @argument			audio? [Audio}
	/// @argument			loop? {bool}
	/// @argument			pitch? {real}
	/// @argument			gain? {real}
	/// @argument			offset? {real}
	/// @argument			priority? {int}
	/// @argument			singular? {bool}
	/// @description		Play the Audio, using data of this constructor or its specified
	///						temporarily replaced parts.
	static play = function(_audio = audio, _loop = loop, _pitch = pitch, _gain = gain,
						   _offset = offset, _priority = priority, _singular = singular)
	{
		try
		{
			if ((is_instanceof(_audio, Audio)) and (_audio.isFunctional()) and ((!_singular)
			or (!audio_is_playing(_audio.ID))))
			{
				event.beforePlaying.execute();
				_audio.play(_loop, _pitch, _gain, _offset, _priority);
				event.afterPlaying.execute();
			}
		}
		catch (_exception)
		{
			ErrorReport.report([other, self, "play()"], _exception);
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
	///						Content will be represented with the properties of this constructor.
	static toString = function(_multiline = false, _full = false)
	{
		var _string = "";
		var _mark_separator = ((_multiline) ? "\n" : ", ");
		
		if (_full)
		{
			var _mark_separator_inline = ", ";
			var _string_offset = "";
			var _string_priority = "";
			
			if ((is_instanceof(audio, Audio)) and (audio.isFunctional()))
			{
				_string_offset = ((is_real(offset)) ? string(offset) : string(audio.offset));
				_string_priority = ((is_real(priority)) ? string(priority) : string(audio.priority));
			}
			else
			{
				_string_offset = string(offset);
				_string_priority = string(priority);
			}
			
			_string = ("Audio: " + string(audio) + _mark_separator +
					   "Loop: " + string(loop) + _mark_separator +
					   "Pitch: " + string(pitch) + _mark_separator +
					   "Gain: " + string(gain) + _mark_separator +
					   "Offset: " + _string_offset + _mark_separator +
					   "Priority: " + _string_priority + _mark_separator +
					   "Singular: " + string(singular));
		}
		else
		{
			_string = ("Audio: " + string(audio));
		}
		
		return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
	}
	
   #endregion
  #endregion
  #region [Constructor]
	
	static constructor = AudioPlayer;
	
	static prototype = {};
	var _property = variable_struct_get_names(prototype);
	var _i = 0;
	repeat (array_length(_property))
	{
		var _name = _property[_i];
		var _value = variable_struct_get(prototype, _name);
		
		variable_struct_set(self, _name, ((is_method(_value)) ? method(self, _value) : _value));
		
		++_i;
	}
	
	var _argument = array_create(argument_count, undefined);
	var _i = 0;
	repeat (argument_count)
	{
		_argument[_i] = argument[_i];
		
		++_i;
	}
	
	script_execute_ext(self.construct, _argument);
	
  #endregion
}
