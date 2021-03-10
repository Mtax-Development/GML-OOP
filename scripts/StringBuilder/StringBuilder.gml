/// @function				StringBuilder()
/// @argument				{any} string?
///
/// @description			Constructs a Parser for building Strings.
///
///							Construction methods:
///							- New constructor
///							   If the string is not specified, empty one will be created.
///							- Constructor copy: {StringBuilder} other
function StringBuilder() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				ID = "";
				
				if (argument_count > 0)
				{
					if (instanceof(argument[0]) == "StringBuilder")
					{
						//|Construction method: Constructor copy.
						var _other = argument[0];
						
						ID = _other.ID;
					}
					else
					{
						//|Construction method: New constructor.
						ID = string(argument[0]);
					}
				}
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return (is_string(ID));
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{int} position
			// @returns				{int}
			// @description			Return the raw byte value of a character from the string.
			static getByte = function(_position)
			{
				return string_byte_at(string(ID), _position);
			}
			
			// @returns				{int}
			// @description			Return the number of how many bytes the string occupies.
			static getByteLength = function()
			{
				return string_byte_length(string(ID));
			}
			
			// @argument			{int} position
			// @returns				{char}
			// @description			Return a single, readable character from the string at
			//						at the specified position.
			static getChar = function(_position)
			{
				return string_char_at(string(ID), _position);
			}
			
			// @argument			{int} position
			// @returns				{int}
			// @description			Return an Unicode (UTF-8) value for a character from the
			//						string at the specified position.
			static getOrd = function(_position)
			{
				return string_ord_at(string(ID), _position);
			}
			
			// @argument			{int} position
			// @argument			{int} position
			// @returns				{string}
			// @description			Return a part of the string, starting from the character
			//						at the specified position and continuing right by the 
			//						specified number of characters or its end.
			static getPart = function(_position, _number)
			{
				var _string = string(ID);
				
				if (_number == undefined) {_number = string_length(_string);}
				
				return string_copy(_string, _position, _number);
			}
			
			// @argument			{any} substring
			// @returns				{int}
			// @description			Return a number of instances of the specified substring appearing
			//						in the string.
			static getSubstringCount = function(_substring)
			{
				return string_count(string(_substring), string(ID));
			}
			
			// @returns				{string}
			// @description			Return a version of the string containing only its digits.
			static getDigits = function()
			{
				return string_digits(string(ID));
			}
			
			// @returns				{int}
			// @description			Return the number of characters in the string after parsing
			//						escape characters.
			static getSize = function()
			{
				return string_length(string(ID));	
			}
			
			// @returns				{string}
			// @description			Return a version of the string containing only its letters from
			//						the English alphabet.
			static getLetters = function()
			{
				return string_letters(string(ID));
			}
			
			// @returns				{string}
			// @description			Return a version of the string containing only its digits and 
			//						letters from the English alphabet.
			static getLettersAndDigits = function()
			{
				return string_lettersdigits(string(ID));
			}
			
			// @argument			{any} substring
			// @argument			{bool} startFromEnd?
			// @argument			{int} startPosition?
			// @returns				{int|undefined}
			// @description			Return the position of the first instance of a substring in
			//						the string, starting from its start, end or with offset of
			//						either. The position will equal the position of the first 
			//						character of the substring, always counting from the start.
			//						Returns {undefined} if the substring does not exist in the
			//						string.
			static getSubstringPosition = function(_substring, _startFromEnd, _startPosition)
			{
				var _string = string(ID);
				var _result = undefined;
				
				if (_startFromEnd)
				{
					if (_startPosition == undefined) {_startPosition = string_length(_string);}
					
					_result = string_last_pos_ext(_substring, _string, _startPosition);
				}
				else
				{
					if (_startPosition == undefined) {_startPosition = 0;}
					
					_result = string_pos_ext(_substring, _string, _startPosition);
				}
				
				return ((_result > 0) ? _result : undefined);
			}
			
			// @argument			{Font|font} font?
			// @argument			{int} separation?
			// @argument			{int} width?
			// @returns				{Vector2}
			// @description			Return the number of pixels the string would occupy by applying
			//						either the specified or currently set Font.
			//						Limitations of width before forced line-break and separation 
			//						between lines of text can be specified to be taken into the
			//						account.
			static getPixelSize = function(_font, _separation, _width)
			{
				var _string = string(ID);
				
				if ((_font != undefined))
				{
					if (instanceof(_font) == "Font")
					{
						if (font_exists(_font.ID))
						{
							draw_set_font(_font.ID);
						}
					}
					else
					{
						if (font_exists(_font))
						{
							draw_set_font(_font);
						}
					}
				}
				
				if ((_separation != undefined) and (_width != undefined))
				{
					return new Vector2(string_width_ext(_string, _separation, _width),
									   string_height_ext(_string, _separation, _width));
				}
				else
				{
					return new Vector2(string_width(_string), string_height(_string));
				}
			}
			
			// @argument			{int} position
			// @returns				{bool} | On error: {undefined}
			// @description			Check if the character at the specified position in the string
			//						has the whitespace property.
			static charIsWhitespace = function(_position)
			{
				var _string = string(ID);
				
				var _string_length = string_length(_string);
				
				if ((_string_length <= 0) or (_position > _string_length))
				{
					return undefined;
				}
				
				var _char = string_char_at(_string, _position);
				
				var _whitespaceChars = ["\u0009", "\u000a", "\u000b", "\u000c", "\u000d", "\u0020", 
									    "\u0085", "\u00a0", "\u1680", "\u2000", "\u2001", "\u2002", 
									    "\u2003", "\u2004", "\u2005", "\u2006", "\u2007", "\u2008", 
									    "\u2009", "\u200a", "\u2028", "\u2029", "\u202f", "\u205f", 
									    "\u3000"];
				
				var _i = 0;
				repeat (array_length(_whitespaceChars))
				{
					if ((_whitespaceChars[_i] == _char))
					{
						return true;
					}
					
					++_i;
				}
				
				return false;
			}
			
			// @argument			{int} position
			// @argument			{char|char[]} other
			// @returns				{bool} | On error: {undefined}
			// @description			Check if the characer at the specified position is the same
			//						as the specified char or is contained in an array of them.
			static charEquals = function(_position, _other)
			{
				var _string = string(ID);
				
				var _string_length = string_length(_string);
				
				if ((_string_length <= 0) or (_position > _string_length))
				{
					return undefined;
				}
				
				var _char = string_char_at(_string, _position);
				
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
			
			// @argument			{string} separator
			// @returns				{string[]|string|StringBuilder[]|StringBuilder}
			// @description			Create multiple strings divided by the specified separator and
			//						return them in an array.
			//						The results can be returned as {StringBuilder} if return was
			//						specified as parser.
			//						Returns the string in its original state is no operation was
			//						performed or returns self if return was specified as parser.
			static split = function(_separator, _returnAsParser)
			{
				var _string = string(ID);
				var _string_length = string_length(_string);
				var _separator_lenght = string_length(_separator);
				var _separator_count = string_count(_separator, _string);
				
				if ((_string_length > 1) and (_separator_lenght >= 1) and (_separator_count >= 1) 
				and (_string_length > (_separator_lenght + 1)))
				{
					var _position_copy = 1;
					var _result = [];
					
					var _i = 2;
					var _loopCount = (_string_length + 1);
					repeat (_loopCount)
					{
						if ((string_copy(_string, _i, _separator_lenght) == _separator) 
						or (_i == _loopCount))
						{
							var _segment = string_copy(_string, _position_copy, 
													   (_i - _position_copy));
							
							if ((string_length(_segment) > 0) and (_segment != _separator))
							{
								_result[array_length(_result)] = string_replace_all(_segment, 
																					_separator, "");
							}
							
							_i += _separator_lenght;
							_position_copy = _i;
						}
						
						++_i;
					}
					
					if (_returnAsParser)
					{
						var _i = 0;
						repeat (array_length(_result))
						{
							_result[_i] = new StringBuilder(_result[_i]);
							
							++_i;
						}
					}
					
					return _result;
				}
				else
				{
					return ((_returnAsParser) ? self : _string);
				}
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{int} position
			// @argument			{int} byte
			// @returns				{string}
			// @description			Replace the character at the specified position by other one,
			//						specified with UTF-8 byte value.
			static setByte = function(_position, _byte)
			{
				var _string = string(ID);
				
				_position = clamp(_position, 1, (string_length(_string) + 1));
				
				ID = string_set_byte_at(_string, _position, _byte);
				
				return ID;
			}
			
			// @argument			{int} position
			// @argument			{int} number?
			// @returns				{string}
			// @description			Delete a part of the string, starting from the character
			//						at the specified position and continuing to the right for the 
			//						specified number of characters or its end.
			static deletePart = function(_position, _number)
			{
				var _string = string(ID);
				
				_position = ((_position == undefined) ? (string_length(_string) + 1)
													  : clamp(_position, 1, (string_length(_string)
																			+ 1)));
				
				ID = string_delete(_string, _position, _number);
				
				return ID;
			}
			
			// @argument			{real} value
			// @argument			{int} wholeNumberPlaces
			// @argument			{int} decimalPlaces
			// @argument			{bool} replace?
			// @returns				{string}
			// @description			Add to the string or replace it with a number that has a 
			//						specified formatting for number of displayed places of
			//						whole numbers and decimal places.
			//						If there is less whole numbers than specified, the remaining
			//						places will be occupied by spaces added to the left.
			//						If there is less decimal numbers than specified, the remaining
			//						places will be occupied with zeros to the right.
			static formatNumber = function(_value, _wholeNumberPlaces, _decimalPlaces, _replace)
			{
				if (_replace)
				{
					ID = string_format(_value, _wholeNumberPlaces, _decimalPlaces);
				}
				else
				{
					ID += string_format(_value, _wholeNumberPlaces, _decimalPlaces);
				}
				
				return ID;
			}
			
			// @argument			{any} substring
			// @argument			{int} position
			// @returns				{string}
			// @description			Insert a specified substring to the left of the specified 
			//						character.
			static insert = function(_substring, _position)
			{
				ID = string_insert(string(_substring), string(ID), _position);
				
				return ID;
			}
			
			// @argument			{int} number
			// @argument			{any} separator?
			// @returns				{string}
			// @description			Add the specified number of copies of the string to itself,
			//						either as it is or with added separator before the copy.
			static duplicate = function(_number)
			{
				var _string = string(ID);
				
				if (argument_count > 1)
				{
					var _separator = string(argument[1]);
					
					var _originalString = _string;
					
					repeat (_number)
					{
						_string += (_separator + _originalString);
					}
					
					ID = _string;
				}
				else
				{
					ID = string_repeat(_string, (_number + 1));
				}
				
				return ID;
			}
			
			// @argument			{any} toReplace
			// @argument			{any} replaceBy
			// @argument			{int} number?
			// @returns				{string}
			// @description			Replace the specified parts of this string with another specified
			//						substring, either in all cases or the specified number of them
			//						that are searched for from left to right.
			static replace = function(_toReplace, _replaceBy, _number)
			{
				ID = string(ID);
				
				_toReplace = string(_toReplace);
				_replaceBy = string(_replaceBy);
				
				if (_number == undefined)
				{
					ID = string_replace_all(ID, _toReplace, _replaceBy);
				}
				else
				{
					repeat (_number)
					{
						ID = string_replace(ID, _toReplace, _replaceBy);
					}
				}
				
				return ID;
			}
			
			// @argument			{char|char[]} charsToTrim?
			// @returns				{string}
			//						Remove the specified characters from the start and the end of the
			//						string until a different character is detected. If no characters
			//						are specified, whitespace will be removed instead.
			static trim = function(_charsToTrim)
			{
				ID = string(ID);
				
				var _string_length = string_length(ID);
				
				var __charCheck = self.charIsWhitespace;
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					_charsToTrim = argument[0];
					__charCheck = self.charEquals;
				}

				var _string_new_start = 0;
				var _string_new_end = _string_length;
					
				var _start_set = false;
				var _end_set = false;
					
				var _i = 1;
				repeat (_string_length)
				{
					var _i_backwards = ((_string_length + 1) - _i);
						
					if (_i == _i_backwards)
					{
						var _char = string_char_at(ID, _i);
						
						ID = ((__charCheck(_i, _charsToTrim)) ? "" : _char);
						
						return ID;
					}
					else
					{
						if (!_start_set) and (!__charCheck(_i, _charsToTrim))
						{
							_string_new_start = _i;
							_start_set = true;
						}
						
						if (!_end_set) and (!__charCheck(_i_backwards, _charsToTrim))
						{
							_string_new_end = (_i_backwards + 1);
							_end_set = true;
						}
						
						if ((_start_set) and (_end_set))
						{
							ID = string_copy(ID, _string_new_start, 
												(_string_new_end - _string_new_start));
							
							return ID;
						}
					}
					
					++_i;
				}
				
				return ID;
			}
			
			// @returns				{string}
			// @description			Set all letters from English alphabet in the string to lowercase.
			static setLowercase = function()
			{
				ID = string_lower(string(ID));
				
				return ID;
			}
			
			// @returns				{string}
			// @description			Set all letters from English alphabet in the string to uppercase.
			static setUppercase = function()
			{
				ID = string_upper(string(ID));
				
				return ID;
			}
			
		#endregion
		#region <Execution>
			
			// @returns				{string}
			// @description			Display this String in the output of the application.
			static display_output = function()
			{
				show_debug_message(ID);
				
				return string(ID);
			}
			
			// @returns				{string}
			// @description			Pause the execution of the application to display the string in 
			//						the message box handled by the build target if it supports it.
			static display_messageBox = function()
			{
				show_message(ID);
				
				return string(ID);
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the string held by this 
			//						constructor.
			static toString = function()
			{
				return (instanceof(self) + "(" + string(ID) + ")");
			}
			
			// @returns				{real}
			// @description			Return this string as a number if it does not contain characters
			//						that would prevent it from being treated as such.
			static toNumber = function()
			{
				return real(string(ID));
			}
			
			// @returns				{string}
			// @description			Connect all values of an array into one string.
			static fromArray = function(_array)
			{
				var _string = "";
				
				var _i = 0;
				repeat (array_length(_array))
				{
					_string += string(_array[_i]);
					
					++_i;
				}
				
				ID = _string;
				
				return ID;
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
