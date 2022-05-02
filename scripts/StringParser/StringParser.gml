/// @function				StringParser()
/// @argument				{any:string} string
///							
/// @description			Constructs a Handler for parsing strings.
///							
///							Construction types:
///							- New constructor
///							- Empty: {void|undefined}
///							- Constructor copy: {StringParser} other
function StringParser() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				ID = "";
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (instanceof(argument[0]) == "StringParser")
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
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return (is_string(ID));
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{any:string} substring...
			// @returns				{bool}
			// @description			Check if at least one occurence of the specified substrings are
			//						contained within the string.
			static contains = function()
			{
				var _i = 0;
				repeat (argument_count)
				{
					if (string_count(string(argument[_i]), string(ID)) > 0)
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
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "charEquals";
					var _errorText = ("Attempted to compare a character outside string bounds:\n" + 
									  "Self: " + "{" + string(_other) + "}" + "\n" +
									  "Position: " + "{" + string(_position) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
				else
				{
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
			
			// @argument			{any:string} separator
			// @argument			{bool} returnParser?
			// @returns				{string|string[]|StringParser|StringParser[]}
			// @description			Create multiple strings divided by the specified separator and
			//						return them in an array.
			//						The results can be returned as {StringParser} if it was specified.
			//						Returns the string in its original state is no operation was
			//						performed or {self} if return was specified as parser.
			static split = function(_separator, _returnParser = false)
			{
				var _string = string(ID);
				var _string_length = string_length(_string);
				var _string_separator = string(_separator);
				var _separator_lenght = string_length(_string_separator);
				var _separator_count = string_count(_string_separator, _string);
				
				if ((_string_length > 1) and (_separator_lenght >= 1) and (_separator_count >= 1)
				and (_string_length > (_separator_lenght + 1)))
				{
					var _position_copy = 1;
					var _result = [];
					
					var _i = 2;
					var _loopCount = (_string_length + 1);
					repeat (_loopCount)
					{
						if ((string_copy(_string, _i, _separator_lenght) == _string_separator) 
						or (_i == _loopCount))
						{
							var _segment = string_copy(_string, _position_copy,
													   (_i - _position_copy));
							
							if ((string_length(_segment) > 0) and (_segment != _string_separator))
							{
								_result[array_length(_result)] = string_replace_all(_segment,
																					_string_separator,
																					"");
							}
							
							_i += _separator_lenght;
							_position_copy = _i;
						}
						
						++_i;
					}
					
					if (_returnParser)
					{
						var _i = 0;
						repeat (array_length(_result))
						{
							_result[_i] = new StringParser(_result[_i]);
							
							++_i;
						}
					}
					
					return _result;
				}
				else
				{
					return ((_returnParser) ? self : _string);
				}
			}
			
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
			// @description			Return a single, readable character from the string at the
			//						specified position.
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
			// @argument			{int} count?
			// @returns				{string}
			// @description			Return a part of the string, starting from the character at the
			//						specified position and continuing forward by the specified count
			//						of characters or its end.
			static getPart = function(_position, _count)
			{
				var _string = string(ID);
				
				return string_copy(_string, _position, (_count ?? string_length(_string)));
			}
			
			// @argument			{any:string} substring
			// @returns				{int}
			// @description			Return a number of instances of the specified substring appearing
			//						in the string.
			static getSubstringCount = function(_substring)
			{
				return string_count(string(_substring), string(ID));
			}
			
			// @returns				{string}
			// @description			Return a version of the string containing only its letters from
			//						the English alphabet.
			static getLetters = function()
			{
				return string_letters(string(ID));
			}
			
			// @returns				{string}
			// @description			Return a version of the string containing only its digits.
			static getDigits = function()
			{
				return string_digits(string(ID));
			}
			
			// @returns				{string}
			// @description			Return a version of the string containing only its digits and 
			//						letters from the English alphabet.
			static getLettersAndDigits = function()
			{
				return string_lettersdigits(string(ID));
			}
			
			// @argument			{any:string} substring
			// @argument			{bool} startFromEnd?
			// @argument			{int} startPosition?
			// @returns				{int|undefined}
			// @description			Return the position of the first instance of a substring in
			//						the string, starting from its start, end or with offset of
			//						either. The position will equal the position of the first 
			//						character of the substring, always counting from the start.
			//						Returns {undefined} if the substring does not exist in the
			//						string.
			static getSubstringPosition = function(_substring, _startFromEnd = false, _startPosition)
			{
				var _string = string(ID);
				var _string_substring = string(_substring);
				var _result = undefined;
				
				if (_startFromEnd)
				{
					_result = string_last_pos_ext(_string_substring, _string,
												  (_startPosition ?? string_length(_string)));
				}
				else
				{
					_result = string_pos_ext(_string_substring, _string, (_startPosition ?? 0));
				}
				
				return ((_result > 0) ? _result : undefined);
			}
			
			// @returns				{int}
			// @description			Return the number of characters in the string after parsing
			//						escape characters.
			static getSize = function()
			{
				return string_length(string(ID));
			}
			
			// @argument			{Font|int:font} font?
			// @argument			{int} separation?
			// @argument			{int} width?
			// @returns				{Vector2}
			// @description			Return the number of pixels the string would occupy by applying
			//						either the specified or currently set Font.
			//						Limitations of width before forced line-break and separation 
			//						between lines of text can be specified to be included.
			static getPixelSize = function(_font, _separation, _width)
			{
				var _string = string(ID);
				var _currentFont = draw_get_font();
				
				if ((_font != undefined))
				{
					if (instanceof(_font) == "Font")
					{
						if (_font.isFunctional())
						{
							draw_set_font(_font.ID);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "getPixelSize";
							var _errorText = ("Attempted to use an invalid Font: " +
											  "Self: " + "{" + string(self) + "}" + "\n" +
											  "Other: " + "{" + string(_font) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
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
				
				var _result;
				
				if ((_separation != undefined) and (_width != undefined))
				{
					_result = new Vector2(string_width_ext(_string, _separation, _width),
										  string_height_ext(_string, _separation, _width));
				}
				else
				{
					_result = new Vector2(string_width(_string), string_height(_string));
				}
				
				draw_set_font(_currentFont);
				
				return _result;
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{int} position
			// @argument			{int} count?
			// @description			Delete a part of the string, starting from the character
			//						at the specified position and continuing to the right for the 
			//						specified number of characters or its end.
			static remove = function(_position, _count = 1)
			{
				var _string = string(ID);
				
				_position = ((_position == undefined)
							 ? (string_length(_string) + 1)
							 : clamp(_position, 1, (string_length(_string) + 1)));
				
				ID = string_delete(_string, _position, _count);
				
				return self;
			}
			
			// @argument			{real} number
			// @argument			{int} wholeNumberPlaces
			// @argument			{int} decimalPlaces
			// @argument			{bool} replace?
			// @description			Add to the string or replace it with a number that has a
			//						specified formatting for number of displayed places of
			//						whole numbers and decimal places.
			//						If there is less whole numbers than specified, the remaining
			//						places will be occupied by spaces added to the left.
			//						If there is less decimal numbers than specified, the remaining
			//						places will be occupied with zeros to the right.
			static formatNumber = function(_number, _wholeNumberPlaces, _decimalPlaces,
										   _replace = false)
			{
				if (_replace)
				{
					ID = string_format(_number, _wholeNumberPlaces, _decimalPlaces);
				}
				else
				{
					ID += string_format(_number, _wholeNumberPlaces, _decimalPlaces);
				}
				
				return self;
			}
			
			// @argument			{any:string} substring
			// @argument			{int} position
			// @description			Insert a specified substring to the left of the specified
			//						character.
			static insert = function(_substring, _position)
			{
				ID = string_insert(string(_substring), string(ID), _position);
				
				return self;
			}
			
			// @argument			{int} number
			// @argument			{any:string} separator?
			// @description			Add the specified number of copies of the string to itself, either
			//						as it is or with added separator before the copy.
			static duplicate = function(_number, _separator)
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
				
				return self;
			}
			
			// @argument			{any:string} target
			// @argument			{any:string} substitute
			// @argument			{int} count?
			// @description			Replace the specified target parts of the string with specified
			//						substitute string, either in its all instances or the specified
			//						count of times, as they are found from left to right.
			static replace = function(_target, _substitute, _count)
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
				
				return self;
			}
			
			// @description			Reverse the order of characters in the string.
			static reverse = function()
			{
				var _string = string(ID);
				var _string_length = string_length(_string);
				
				var _result = "";
				
				var _i = _string_length;
				repeat (_string_length)
				{
					_result += string_char_at(ID, _i);
					
					--_i;
				}
				
				ID = _result;
				
				return self;
			}
			
			// @argument			{char|char[]} charsToTrim?
			//						Remove the specified characters from the start and the end of the
			//						string until a different character is detected. If no characters
			//						are specified, whitespace will be removed instead.
			static trim = function(_charsToTrim)
			{
				ID = string(ID);
				
				var _string_length = string_length(ID);
				
				var __charCheck = ((_charsToTrim != undefined) ? self.charEquals
															   : self.charIsWhitespace);
				
				var _string_new_start = 0;
				var _string_new_end = _string_length;
					
				var _start_set = false;
				var _end_set = false;
					
				var _i = 1;
				repeat (_string_length)
				{
					var _i_backwards = (_string_length + 1 - _i);
					
					if ((!_start_set) and (!__charCheck(_i, _charsToTrim)))
					{
						_string_new_start = _i;
						_start_set = true;
					}
					
					if ((!_end_set) and (!__charCheck(_i_backwards, _charsToTrim)))
					{
						_string_new_end = (_i_backwards + 1);
						_end_set = true;
					}
					
					if ((_start_set) and (_end_set))
					{
						ID = string_copy(ID, _string_new_start,
										 (_string_new_end - _string_new_start));
							
						return self;
					}
					else if (_i == _i_backwards)
					{
						var _char = string_char_at(ID, _i);
						
						ID = ((__charCheck(_i, _charsToTrim)) ? "" : _char);
						
						return self;
					}
					
					++_i;
				}
				
				return self;
			}
			
			// @argument			{int} position
			// @argument			{int} byte
			// @description			Replace the character at the specified position by other one,
			//						specified with UTF-8 byte value.
			static setByte = function(_position, _byte)
			{
				var _string = string(ID);
				
				_position = clamp(_position, 1, (string_length(_string)));
				
				ID = string_set_byte_at(_string, _position, _byte);
				
				return self;
			}
			
			// @description			Set all letters from English alphabet in the string to lowercase.
			static setLowercase = function()
			{
				ID = string_lower(string(ID));
				
				return self;
			}
			
			// @description			Set all letters from English alphabet in the string to uppercase.
			static setUppercase = function()
			{
				ID = string_upper(string(ID));
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			// @returns				{function} function
			// @argument			{any} argument?
			// @returns				{any[]}
			// @description			Execute a function once for each character of the string.
			//						The following arguments will be provided to the function and can
			//						be accessed in it by using their name or the argument array:
			//						- argument[0]: {int} _i
			//						- argument[1]: {char} _value
			//						- argument[2]: {any} _argument
			static forEach = function(__function, _argument)
			{
				var _string = string(ID);
				
				var _functionReturn = [];
				
				var _i = 1;
				repeat (string_length(_string))
				{
					var _value = string_char_at(_string, _i);
					
					array_push(_functionReturn, __function(_i, _value, _argument));
					
					++_i;
				}
				
				return _functionReturn;
			}
			
			// @description			Display the string in the standard output of the application.
			static displayOutput = function()
			{
				show_debug_message(ID);
				
				return self;
			}
			
			// @description			Pause the execution of the application to display the string in 
			//						the message box handled by the build target if it supports it.
			static displayMessageBox = function()
			{
				show_message(ID);
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @argument			{int|all} elementLength?
			// @argument			{string} mark_cut?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the string of this constructor,
			//						where linebreaks are replaced with spaces if not specified to use
			//						multiline.
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
			
			// @returns				{real}
			// @description			Return the string as a number if it does not contain characters
			//						that would prevent it from being treated as such.
			static toNumber = function()
			{
				return real(string(ID));
			}
			
			// @return				{char[]}
			// @description			Return an array containing every character of the string.
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
			
			// @argument			{any[]:string}
			// @description			Set the string into one created from all values of an array.
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
				
				return self;
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

