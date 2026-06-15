//  @function				Audio()
/// @argument				audio {handle:audio}
/// @argument				priority? {int}
/// @description			Constructs an Audio Resource used to play sounds.
//							
//							Construction types:
//							- New constructor.
//							- Empty: {void|undefined}
//							- Constructor copy: other {Audio}
function Audio() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				ID = undefined;
				priority = undefined;
				offset = undefined;
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (is_instanceof(argument[0], Audio))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						ID = _other.ID;
						priority = _other.priority;
						offset = _other.offset;
					}
					else
					{
						//|Construction type: New constructor.
						ID = argument[0];
						priority = ((argument_count > 1) ? argument[1] : 0);
						offset = audio_sound_get_track_position(ID);
					}
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_handle(ID)) and (is_real(priority)) and (is_real(offset)));
			}
			
		#endregion
		#region <Setters>
			
			/// @argument			seconds {real}
			/// @description		Set the position of the point from which this Audio Resource will
			///						be next played from to the specified number of seconds.
			static setOffset = function(_seconds)
			{
				try
				{
					audio_sound_set_track_position(ID, _seconds);
					
					offset = audio_sound_get_track_position(ID);
				}
				catch (_exception)
				{
					ErrorReport.report([other, self, "setOffset()"], _exception);
				}
				
				return self;
			}
			
		#endregion
		#region <Getters>
			
			/// @returns			{bool}
			/// @description		Return whether this Audio Resource is already playing.
			static isPlaying = function()
			{
				try
				{
					return audio_is_playing(ID);
				}
				catch (_exception)
				{
					ErrorReport.report([other, self, "isPlay()"], _exception);
				}
				
				return undefined;
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			loop? {bool}
			/// @argument			pitch? {real}
			/// @argument			gain? {real}
			/// @argument			offset? {real}
			/// @argument			priority? {int}
			/// @description		Play this Audio Resource with specified properties.
			static play = function(_loop = false, _pitch = 1, _gain = 1, _offset = offset,
								   _priority = priority)
			{
				try
				{
					audio_play_sound(ID, _priority, _loop, _gain, _offset, _pitch);
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
			///						Content will be represented with the properties of this Resource.
			static toString = function(_multiline = false, _full = false)
			{
				if (self.isFunctional())
				{
					var _string = "";
					var _mark_separator = ((_multiline) ? "\n" : ", ");
					var _string_name = audio_get_name(ID);
					
					if (_full)
					{
						_string = ("Name: " + _string_name + _mark_separator +
								   "Priority: " + string(priority) + _mark_separator +
								   "Offset: " + string(offset));
					}
					else
					{
						_string = _string_name;
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
	#region [Constructor]
		
		static constructor = Audio;
		
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
