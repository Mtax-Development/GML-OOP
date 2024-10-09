//  @function				StringParser()
/// @argument				string {any:string}
/// @description			Constructs a handler for parsing strings.
//							
//							Construction types:
//							- New constructor
//							- Empty: {void|undefined}
//							- Constructor copy: other {StringParser}
function StringParser() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				ID = "";
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (is_instanceof(argument[0], StringParser))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						ID = _other.ID;
					}
					else
					{
						//|Construction type: New constructor.
						ID = string(argument[0]);
					}
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return (is_string(ID));
			}
			
			/// @argument			value {any:string|StringParser}
			/// @description		Set the value operated by this parser to the specified value or
			///						the value of the specified parser by ensuring it is a string.
			static setParser = function(_value)
			{
				ID = ((is_instanceof(_value, StringParser)) ? string(_value.ID) : string(_value));
				
				return self;
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			value... {any:string|StringParser}
			/// @returns			{bool}
			/// @description		Check if at least one occurence of any of the specified filter
			///						substrings is contained in the string.
			static contains = function()
			{
				var _string = string(ID);
				var _i = 0;
				repeat (argument_count)
				{
					var _value = argument[_i];
					var _part = ((is_string(_value)) ? _value
													 : ((is_instanceof(_value, StringParser))
														? _value.ID : string(_value)));
					
					if (string_count(_part, _string) > 0)
					{
						return true;
					}
					
					++_i;
				}
				
				return false;
			}
			
			/// @argument			value... {any:string|StringParser}
			/// @returns			{bool}
			/// @description		Check if at least one occurrence of every of the specified
			///						substrings are contained in the string.
			static containsAll = function()
			{
				var _string = string(ID);
				var _i = 0;
				repeat (argument_count)
				{
					var _value = argument[_i];
					var _part = ((is_string(_value)) ? _value
													 : ((is_instanceof(_value, StringParser))
														? _value.ID : string(_value)));
					
					if (!(string_count(_part, _string) > 0))
					{
						return false;
					}
					
					++_i;
				}
				
				return true;
			}
			
			/// @argument			substring... {any:string}
			/// @returns			{bool}
			/// @description		Check if the string starts with any of the specified substrings.
			static startsWith = function()
			{
				var _string = string(ID);
				var _string_length = string_length(_string);
				var _i = 0;
				repeat (argument_count)
				{
					var _substring = string(argument[_i]);
					var _substring_length = string_length(_substring);
					
					if ((_substring_length > 0) and (_string_length >= _substring_length)
					and (string_copy(_string, 1, _substring_length) == _substring))
					{
						return true;
					}
					
					++_i;
				}
				
				return false;
			}
			
			/// @argument			substring... {any:string}
			/// @returns			{bool}
			/// @description		Check if the string ends with any of the specified substrings.
			static endsWith = function()
			{
				var _string = string(ID);
				var _string_length = string_length(_string);
				var _i = 0;
				repeat (argument_count)
				{
					var _substring = string(argument[_i]);
					var _substring_length = string_length(_substring);
					
					if ((_substring_length > 0) and (_string_length >= _substring_length)
					and (string_copy(_string, (_string_length - _substring_length + 1),
									 _substring_length) == _substring))
					{
						return true;
					}
					
					++_i;
				}
				
				return false;
			}
			
			/// @argument			position {int}
			/// @argument			other {char|char[]}
			/// @returns			{bool} | On error: {undefined}
			/// @description		Check if the character at the specified position is the same as
			///						the specified char or is contained in an array of them.
			static charEquals = function(_position, _other)
			{
				try
				{
					var _char = string_char_at(string(ID), _position);
					
					if (is_array(_other))
					{
						var _i = 0;
						repeat (array_length(_other))
						{
							if (_char == _other[_i])
							{
								return true;
							}
							
							++_i;
						}
						
						return false;
					}
					else
					{
						return (_char == _other);
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "charEquals()"], _exception);
				}
				
				return undefined;
			}
			
			/// @argument			position {int}
			/// @returns			{bool} | On error: {undefined}
			/// @description		Check if the character at the specified position in the string is
			///						an invisible character without a glyph.
			static charIsWhitespace = function(_position)
			{
				try
				{
					var _char = string_char_at(string(ID), _position);
					
					if (_char == "")
					{
						return false;
					}
					
					var _char_whitespace = ["\u0009", "\u000a", "\u000b", "\u000c", "\u000d",
											"\u0020", "\u0085", "\u00a0", "\u1680", "\u2000",
											"\u2001", "\u2002", "\u2003", "\u2004", "\u2005",
											"\u2006", "\u2007", "\u2008", "\u2009", "\u200a",
											"\u200b", "\u200c", "\u200d", "\u2028", "\u2029",
											"\u202f", "\u205f", "\u2060", "\u3000", "\ufeff"];
					
					var _i = 0;
					repeat (array_length(_char_whitespace))
					{
						if (_char_whitespace[_i] == _char)
						{
							return true;
						}
						
						++_i;
					}
					
					return false;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "charIsWhitespace()"], _exception);
				}
			}
			
			/// @argument			separator {any:string}
			/// @argument			parse_part? {function|constructor:StringParser}
			/// @returns			{string|StringParser|StringParser[]|any[]}
			/// @description		Create multiple strings divided by the specified separator and
			///						return them in an array. Parts of the string can be parsed after
			///						separating them and returned as {StringParser} if specified as
			///						such or by the specified function, which will be provided each
			///						string part as its only argument. The value of this parser will be
			///						set to a string part for the duration of each execution only.
			///						If the separator is not present, a single unseparated string is
			///						returned or {self} if the parsing was specified as {StringParser}.
			static split = function(_separator, _parse_part)
			{
				try
				{
					var _string = string(ID);
					var _string_separator = string(_separator);
					var _separator_count = string_count(_string_separator, _string);
					var _string_length = string_length(_string);
					var _separator_length = string_length(_separator);
					
					if (_separator_length > 0)
					{
						var _separator_count = ((_string_length -
												 string_length(string_replace_all(_string, _separator,
																				  "")))
												/ _separator_length);
						
						if ((_separator_count > 0)
						and (_string_length != (_separator_length * _separator_count)))
						{
							var _result = [];
							var _segment;
							var _position = 1;
							
							repeat (_separator_count)
							{
								if (string_copy(_string, _position, _separator_length) != _separator)
								{
									var _segment_end = string_pos_ext(_string_separator, _string,
																	  _position);
									var _segment_length = (_segment_end - _position);
									
									if (_segment_length > 0)
									{
										_segment = string_copy(_string, _position, _segment_length);
										
										if (_segment != _separator)
										{
											array_push(_result, _segment);
										}
									}
									
									_position = _segment_end;
								}
								
								_position += _separator_length;
							}
							
							_position = (string_last_pos(_string_separator, _string) +
										 _separator_length);
							_segment = string_copy(_string, _position,
												   (_string_length - _position + 1));
							
							if ((string_length(_segment) > 0) and (_segment != _separator))
							{
								array_push(_result, _segment);
							}
							
							if (_parse_part != undefined)
							{
								if (_parse_part == StringParser)
								{
									var _i = 0;
									repeat (array_length(_result))
									{
										_result[_i] = new StringParser(_result[_i]);
										
										++_i;
									}
								}
								else
								{
									var _constructor_value_original = ID;
									var _function_index = ((is_method(_parse_part)
														   ? method_get_index(_parse_part)
														   : _parse_part));
									
									if (is_real(_function_index))
									{
										var _i = 0;
										repeat (array_length(_result))
										{
											ID = _result[_i];
											
											try
											{
												_result[_i] = script_execute(_function_index,
																			 _result[_i]);
											}
											catch (_exception)
											{
												new ErrorReport().report([other, self, "split()",
																		  "function()"],
																		  _exception);
											}
											
											++_i;
										}
									}
									
									ID = _constructor_value_original;
								}
							}
							
							return _result;
						}
					}
					
					return ((_parse_part == StringParser) ? self : _string);
				}
				
				return "";
			}
			
			/// @returns			{char}
			/// @description		Return the first character of the string.
			static getFirst = function()
			{
				return string_char_at(string(ID), 1);
			}
			
			/// @returns			{char}
			/// @description		Return the last character of the string.
			static getLast = function()
			{
				var _string = string(ID);
				
				return string_char_at(_string, string_length(_string));
			}
			
			/// @argument			token_start? {string}
			/// @argument			token_end? {string}
			/// @argument			token_ignore? {string|string[]}
			/// @argument			include_tokens? {bool}
			/// @returns			{string|string[]}
			/// @description		Return a part of the string between two specified substrings or
			///						the start or the end of the string, excluding parts containing
			///						the specified ignored substring.
			///						If the result contains more than one of parts, they will be
			///						returned in an array. An empty string will be returned if it
			///						contains no parts. Used start and end of parts can be specified to
			///						be added back to them.
			static getBetween = function(_token_start = "", _token_end = "", _token_ignore,
										 _include_tokens = false)
			{
				try
				{
					var _result = [];
					var _string = string(ID);
					var _string_length = string_length(_string);
					var _token_start_length = string_length(_token_start);
					var _token_start_has_content = (_token_start_length > 0);
					var _token_start_position = 0;
					var _token_start_count = ((_token_start_has_content)
											  ? string_count(_token_start, _string) : 1);
					var _token_end_has_content = (string_length(_token_end) > 0);
					var _token_ignore_count = 0;
					
					if (_token_ignore != undefined)
					{
						if (!is_array(_token_ignore))
						{
							_token_ignore = [_token_ignore];
						}
						
						_token_ignore_count = array_length(_token_ignore);
					}
					
					repeat (_token_start_count)
					{
						_token_start_position = ((_token_start_has_content)
												 ? string_pos_ext(_token_start, _string,
																  _token_start_position)
												 : 1);
						
						if (_token_start_position > 0)
						{
							_token_start_position += _token_start_length;
							
							var _token_end_position = ((_token_end_has_content)
													   ? string_pos_ext(_token_end, _string,
																		_token_start_position)
													   : _string_length);
							
							if (_token_end_position > 0)
							{
								var _part = string_copy(_string, _token_start_position,
														(_token_end_position -
														 ((_token_end_has_content)
														  ? _token_start_position : 0)));
								
								if (string_length(_part) > 0)
								{
									var _part_ignore = false;
									
									var _i = 0;
									repeat (_token_ignore_count)
									{
										if (string_count(_token_ignore[_i], _part) > 0)
										{
											_part_ignore = true;
											
											break;
										}
										
										++_i;
									}
									
									if (!_part_ignore)
									{
										array_push(_result,
												   ((_include_tokens) ? (_token_start + _part +
																		 _token_end)
																	  : _part));
									}
								}
							}
						}
					}
					
					switch (array_length(_result))
					{
						case 0: return ""; break;
						case 1: return _result[0]; break;
						default: return _result; break;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getBetween()"], _exception);
				}
			}
			
			/// @argument			position {int}
			/// @returns			{int}
			/// @description		Return the raw byte value of a character from the string.
			static getByte = function(_position)
			{
				return string_byte_at(string(ID), _position);
			}
			
			/// @returns				{int}
			/// @description			Return the number of how many bytes the string occupies.
			static getByteLength = function()
			{
				return string_byte_length(string(ID));
			}
			
			/// @argument			position {int}
			/// @returns			{char}
			/// @description		Return a single readable character at the specified position.
			static getChar = function(_position)
			{
				return string_char_at(string(ID), _position);
			}
			
			/// @argument			position {int}
			/// @returns			{int}
			/// @description		Return an Unicode (UTF-8) value for a character from the string at
			///						the specified position.
			static getOrd = function(_position)
			{
				return string_ord_at(string(ID), _position);
			}
			
			/// @argument			position {int}
			/// @argument			count? {int}
			/// @returns			{string}
			/// @description		Return a part of the string, starting from the character at the
			///						specified position and continuing forward by the specified count
			///						of characters or its end.
			static getPart = function(_position, _count)
			{
				var _string = string(ID);
				
				return string_copy(_string, _position, (_count ?? string_length(_string)));
			}
			
			/// @returns			{string}
			/// @description		Return a version of the string containing only its letters from
			///						the English alphabet.
			static getLetters = function()
			{
				return string_letters(string(ID));
			}
			
			/// @returns			{string}
			/// @description		Return a version of the string containing only its digits.
			static getDigits = function()
			{
				return string_digits(string(ID));
			}
			
			/// @returns			{string}
			/// @description		Return a version of the string containing only its digits and 
			///						letters from the English alphabet.
			static getLettersAndDigits = function()
			{
				return string_lettersdigits(string(ID));
			}
			
			/// @argument			substring {any:string}
			/// @returns			{int}
			/// @description		Return a number of instances of the specified substring appearing
			///						in the string.
			static getSubstringCount = function(_substring)
			{
				return string_count(string(_substring), string(ID));
			}
			
			/// @argument			substring {any:string}
			/// @argument			startFromEnd? {bool}
			/// @argument			startPosition? {int}
			/// @argument			count? {int|all}
			/// @returns			{int|int[]|undefined}
			/// @description		Return the first position of a substring instance in a string,
			///						a specific number of them in an array, or all of them, starting
			///						from the start or end of the string, or specified offset from
			///						either. Positions will equal the position of the first character
			///						of the substring, always counting from the start of the string.
			///						Returns {undefined} if the string does not contain the specified
			///						substring.
			static getSubstringPosition = function(_substring, _startFromEnd = false, _startPosition,
												   _count = 1)
			{
				try
				{
					var _result = [];
					var _string = string(ID);
					var _string_substring = string(_substring);
					var _iterationCount = _count;
					var _positionModifier = 1;
					var __findPosition = string_pos_ext;
					
					if (_startPosition == undefined)
					{
						_startPosition = ((_startFromEnd) ? string_length(_string) : 0);
					}
					
					if (_startFromEnd)
					{
						_positionModifier = -1;
						__findPosition = string_last_pos_ext;
					}
					
					if (_iterationCount == all)
					{
						_iterationCount = string_count(_substring, _string);
					}
					
					repeat (_iterationCount)
					{
						var _position = __findPosition(_substring, _string, _startPosition);
						
						if (_position > 0)
						{
							array_push(_result, _position);
						}
						else
						{
							break;
						}
						
						_startPosition = (_position + _positionModifier);
					}
					
					switch (_count)
					{
						case 0:
						case 1:
							return ((array_length(_result) > 0) ? _result[0] : undefined);
						break;
						default:
							return _result;
						break;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getSubstringPosition()"], _exception);
				}
			}
			
			/// @returns			{int}
			/// @description		Return the number of characters in the string after parsing out
			///						escape characters.
			static getSize = function()
			{
				return string_length(string(ID));
			}
			
			/// @argument			font? {Font|int:font}
			/// @argument			scale? {Scale|int}
			/// @argument			separation? {int}
			/// @argument			width? {int}
			/// @returns			{Vector2}
			/// @description		Return the number of pixels the string would occupy by applying
			///						either the specified or currently set Font, at specified Scale
			///						or size of that Font.
			///						Limitations of width before forced line-break and separation 
			///						between lines of text can be specified to be included.
			static getPixelSize = function(_font, _scale, _separation, _width)
			{
				var _font_original = draw_get_font();
				
				try
				{
					var _result = undefined;
					var _string = string(ID);
					
					if (_font != undefined)
					{
						draw_set_font((is_instanceof(_font, Font)) ? _font.ID : _font);
					}
					
					var _font_current = draw_get_font();
					
					if ((_separation != undefined) and (_width != undefined))
					{
						_result = new Vector2(string_width_ext(_string, _separation, _width),
											  string_height_ext(_string, _separation, _width));
					}
					else
					{
						_result = new Vector2(string_width(_string), string_height(_string));
					}
					
					var _scale_x = 1;
					var _scale_y = 1;
					
					if (is_instanceof(_scale, Scale))
					{
						_scale_x = _scale.x;
						_scale_y = _scale.y;
					}
					else if (is_real(_scale))
					{
						var _font_point_size_multiplier = (round(_scale) /
														   font_get_size(_font_current));
						_scale_x = _font_point_size_multiplier;
						_scale_y = _font_point_size_multiplier;
					}
					
					_result.x *= _scale_x;
					_result.y *= _scale_y;
					
					return _result;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "getPixelSize()"], _exception);
				}
				finally
				{
					draw_set_font(_font_original);
				}
				
				return undefined;
			}
			
		#endregion
		#region <Setters>
			
			/// @argument			position {int}
			/// @argument			count? {int}
			/// @description		Delete a part of the string, starting from the character at the
			///						specified position and continuing to the right for the specified
			///						number of characters or its end.
			static remove = function(_position, _count = 1)
			{
				try
				{
					var _string = string(ID);
					
					_position = ((_position == undefined)
								 ? (string_length(_string) + 1)
								 : clamp(_position, 1, (string_length(_string) + 1)));
					
					ID = string_delete(_string, _position, _count);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "remove()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			number {real}
			/// @argument			wholeNumberPlaces {int}
			/// @argument			decimalPlaces {int}
			/// @argument			replace? {bool}
			/// @description		Add to the string or replace it with a number that has a specified
			///						formatting for number of displayed places of whole number and
			///						and decimal places.
			///						If there is less whole numbers than specified, the remaining
			///						places will be occupied by spaces added to the left.
			///						If there is less decimal numbers than specified, the remaining
			///						places will be occupied with zeros to the right.
			static formatNumber = function(_number, _wholeNumberPlaces, _decimalPlaces,
										   _replace = false)
			{
				try
				{
					if (_replace)
					{
						ID = string_format(_number, _wholeNumberPlaces, _decimalPlaces);
					}
					else
					{
						ID += string_format(_number, _wholeNumberPlaces, _decimalPlaces);
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "formatNumber()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			substring {any:string}
			/// @argument			position {int}
			/// @description		Insert a specified substring to the left of the specified
			///						character.
			static insert = function(_substring, _position)
			{
				try
				{
					ID = string_insert(string(_substring), string(ID), _position);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "insert()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			number {int}
			/// @argument			separator? {any:string}
			/// @description		Add the specified number of copies of the string to itself, either
			///						as it is or with added separator before the copy.
			static duplicate = function(_number, _separator)
			{
				try
				{
					var _string = string(ID);
					
					if (_separator != undefined)
					{
						var _string_separator = string(_separator);
						var _original = _string;
						repeat (_number)
						{
							_string += (_string_separator + _original);
						}
						
						ID = _string;
					}
					else
					{
						ID = string_repeat(_string, (_number + 1));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "duplicate()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			target {any:string}
			/// @argument			substitute? {any:string}
			/// @argument			count? {int}
			/// @description		Replace the specified target parts of the string with specified
			///						substitute string, either in its all instances or the specified
			///						count of times, as they are found from left to right.
			static replace = function(_target, _substitute = "", _count)
			{
				try
				{
					ID = string(ID);
					
					var _string_target = string(_target);
					var _string_substitute = string(_substitute);
					
					if (_count == undefined)
					{
						ID = string_replace_all(ID, _string_target, _string_substitute);
					}
					else
					{
						repeat (_count)
						{
							ID = string_replace(ID, _string_target, _string_substitute);
						}
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "replace()"], _exception);
				}
				
				return self;
			}
			
			/// @description		Reverse the order of characters in the string.
			static reverse = function()
			{
				var _result = "";
				var _string = string(ID);
				var _string_length = string_length(_string);
				var _i = _string_length;
				repeat (_string_length)
				{
					_result += string_char_at(ID, _i);
					
					--_i;
				}
				
				ID = _result;
				
				return self;
			}
			
			/// @argument			trimmedChar? {char|char[]}
			/// @argument			keep_left? {bool}
			/// @argument			keep_right? {bool}
			/// @description		Remove the specified characters from the start and the end of the
			///						string until a different character is detected. If no characters
			///						are specified, whitespace will be removed instead. Either side of
			///						the string can be specified to not be affected.
			static trim = function(_trimmedChar, _keep_left = false, _keep_right = false)
			{
				try
				{
					var _constructor_value_original = ID;
					
					ID = string(ID);
					
					var _string_length = string_length(ID);
					var __charCheck = ((_trimmedChar != undefined) ? self.charEquals
																   : self.charIsWhitespace);
					var _string_new_start = 1;
					var _string_new_end = (_string_length + 1);
					var _start_set = _keep_left;
					var _end_set = _keep_right;
					var _position_forward = 1;
					repeat (_string_length)
					{
						var _position_backward = (_string_length + 1 - _position_forward);
						
						if ((!_start_set) and (!__charCheck(_position_forward, _trimmedChar)))
						{
							_string_new_start = _position_forward;
							_start_set = true;
						}
						
						if ((!_end_set) and (!__charCheck(_position_backward, _trimmedChar)))
						{
							_string_new_end = (_position_backward + 1);
							_end_set = true;
						}
						
						if ((_start_set) and (_end_set))
						{
							ID = string_copy(ID, _string_new_start,
											 (_string_new_end - _string_new_start));
							
							break;
						}
						else if (_position_forward >= _string_new_end)
						{
							ID = string_copy(ID, _position_forward,
											 (_string_new_end - _string_new_start));
							
							break;
						}
						
						++_position_forward;
					}
					
					if ((string_length(ID) == 1) and (__charCheck(1, _trimmedChar)))
					{
						ID = "";
					}
				}
				catch (_exception)
				{
					ID = _constructor_value_original;
					
					new ErrorReport().report([other, self, "trim()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			position {int}
			/// @argument			byte {int}
			/// @description		Replace the character at the specified position by other one,
			///						specified with UTF-8 byte value.
			static setByte = function(_position, _byte)
			{
				try
				{
					var _string = string(ID);
					_position = clamp(_position, 1, (string_length(_string)));
					
					ID = string_set_byte_at(_string, _position, _byte);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setByte()"], _exception);
				}
				
				return self;
			}
			
			/// @description		Set all letters from English alphabet in the string to lowercase.
			static setLowercase = function()
			{
				ID = string_lower(string(ID));
				
				return self;
			}
			
			/// @description		Set all letters from English alphabet in the string to uppercase.
			static setUppercase = function()
			{
				ID = string_upper(string(ID));
				
				return self;
			}
			
			/// @description		Set the first character of the string to uppercase if it is a
			///						letter of the English alphabet.
			static capitalize = function()
			{
				ID = string(ID);
				ID = (string_upper(string_char_at(ID, 1)) + string_delete(ID, 1, 1));
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			/// @returns			function {function}
			/// @argument			argument? {any}
			/// @returns			{any[]}
			/// @description		Execute a function once for each character of the string.
			///						The following arguments will be provided to the function and can
			///						be accessed in it by using their name or the argument array:
			///						- argument[0]: _i {int}
			///						- argument[1]: _value {char}
			///						- argument[2]: _argument {any}
			static forEach = function(__function, _argument)
			{
				var _string = string(ID);
				var _functionReturn = [];
				var _i = 1;
				repeat (string_length(_string))
				{
					var _value = string_char_at(_string, _i);
					
					try
					{
						array_push(_functionReturn, __function(_i, _value, _argument));
					}
					catch (_exception)
					{
						new ErrorReport().report([other, self, "forEach()", "function()"],
												 _exception);
					}
					
					++_i;
				}
				
				return _functionReturn;
			}
			
			/// @description		Display the string in the standard output of the application.
			static displayOutput = function()
			{
				show_debug_message(ID);
				
				return self;
			}
			
			/// @description		Pause the execution of the application to display the string in 
			///						the message box handled by the build target if it supports it.
			static displayMessageBox = function()
			{
				show_message(ID);
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @argument			elementLength? {int|all}
			/// @argument			mark_cut? {string}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented with the string of this constructor,
			///						where linebreaks are replaced with spaces if not specified to use
			///						multiline.
			static toString = function(_multiline = false, _elementLength = 30, _mark_cut  = "...")
			{
				var _string = string(ID);
				var _string_lengthLimit = _elementLength;
				var _string_lengthLimit_cut = (_string_lengthLimit + string_length(_mark_cut));
				
				if (!_multiline)
				{
					_string = string_replace_all(_string, "\n", " ");
					_string = string_replace_all(_string, "\r", " ");
				}
				
				if (_elementLength != all)
				{
					if (string_length(_string) > _string_lengthLimit_cut)
					{
						_string = string_copy(_string, 1, _string_lengthLimit);
						_string += _mark_cut;
					}
				}
				
				if (_multiline)
				{
					return _string;
				}
				else
				{
					return (instanceof(self) + "(" + _string + ")");
				}
			}
			
			/// @argument			decimalDotCount? {int|noone}
			/// @returns			{real} | On error: {undefined}
			/// @description		Return the string as a number if it contains numerical characters.
			///						A counter for the dot character can be specified to treat all
			///						remaining number characters as decimal places after that many dot
			///						characters were found in the string. Specifying it as 0 will treat
			///						the entire number as decimal. Specifying it as {noone} will treat
			///						the entire number as integer.
			static toNumber = function(_decimalDotCount = 1)
			{
				try
				{
					var _string = string(ID);
					var _string_number = ((_decimalDotCount == 0) ? "." : "");
					var _dotCount_current = 0;
					var _i = 1;
					repeat (string_length(_string))
					{
						var _char = string_char_at(_string, _i);
						
						if (string_length(string_digits(_char)) > 0)
						{
							_string_number += _char;
						}
						else if (_char == ".")
						{
							++_dotCount_current;
							
							if (_dotCount_current == _decimalDotCount)
							{
								_string_number += ".";
							}
						}
						
						++_i;
					}
					
					return real(_string_number);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "toNumber()"], _exception);
				}
				
				return undefined;
			}
			
			/// @return				{char[]}
			/// @description		Return an array containing every character of the string.
			static toArray = function()
			{
				var _string = string(ID);
				var _string_length = string_length(_string);
				var _array = array_create(_string_length, "");
				var _i = 1;
				repeat (_string_length)
				{
					_array[_i] = string_char_at(_string, _i);
					
					++_i;
				}
				
				return _array;
			}
			
			/// @argument			array {any[]:string}
			/// @argument			connector? {any:string}
			/// @description		Set the string to one created from connecting all values of the
			///						specified array. A specified connector string can be included in
			///						between parts of the string.
			static fromArray = function(_array, _connector = "")
			{
				try
				{
					var _string = "";
					var _string_connector = string(_connector);
					var _count = array_length(_array);
					var _i = 0;
					repeat (_count)
					{
						_string += (string(_array[_i]) + (((_i + 1) < _count) ? _string_connector
																			  : ""));
						
						++_i;
					}
					
					ID = _string;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "fromArray()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			path {string:path}
			/// @description		Save the string by creating or fully overwriting a text file at
			///						the specified path. 
			static toFile = function(_path)
			{
				if (is_string(_path))
				{
					try
					{
						var _stream = file_text_open_write(_path);
						
						if (_stream >= 0)
						{
							file_text_write_string(_stream, string(ID));
							file_text_close(_stream);
						}
					}
					catch (_exception)
					{
						new ErrorReport().report([other, self, "toFile()"], _exception);
					}
				}
				else
				{
					new ErrorReport().report([other, self, "toFile()"],
											 ("Attempted to write to a file at invalid path: " +
											  "{" + string(_path) + "}"));
				}
				
				return self;
			}
			
			/// @argument			path {string:path}
			/// @description		Set the string to the contents of a file at the specified path.
			static fromFile = function(_path)
			{
				var _buffer = undefined;
				
				try
				{
					_buffer = buffer_load(_path);
					
					ID = buffer_read(_buffer, buffer_string);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "fromFile()"],
											 ("Attempted to parse a nonexistent or inacessible " +
											  "file at path: " +
											  "{" + string(_path) + "}"));
				}
				finally
				{
					if ((is_handle(_buffer)) and (buffer_exists(_buffer)))
					{
						buffer_delete(_buffer);
					}
				}
				
				return self;
			}
			
			/// @argument			path {string:path}
			/// @returns			{struct} | On error: {undefined}
			/// @description		Set the string to the contents of a file with JSON formatting at
			///						the specified path and return contents of that file as a struct.
			static fromJSON = function(_path)
			{
				var _buffer = undefined;
				
				try
				{
					_buffer = buffer_load(_path);
					
					if ((is_handle(_buffer)) and (buffer_exists(_buffer)))
					{
						try
						{
							var _JSON = buffer_read(_buffer, buffer_string);
							var _struct = json_parse(_JSON);
							ID = _JSON;
							
							return _struct;
						}
						catch (_exception)
						{
							new ErrorReport().report([other, self, "fromJSON()"],
													 ("Attempted to parse a file with invalid JSON " +
													  "formatting at path: " +
													  "{" + string(_path) + "}"));
						}
					}
					else
					{
						new ErrorReport().report([other, self, "fromJSON()"],
												 ("Attempted to parse a nonexistent or inacessible " +
												  "file at path: " +
												  "{" + string(_path) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "fromJSON()"],
											 ("Attempted to parse a nonexistent or inacessible " +
											  "file at path: " +
											  "{" + string(_path) + "}"));
				}
				finally
				{
					if ((is_handle(_buffer)) and (buffer_exists(_buffer)))
					{
						buffer_delete(_buffer);
					}
				}
				
				return undefined;
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static constructor = StringParser;
		
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
