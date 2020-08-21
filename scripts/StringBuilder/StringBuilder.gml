/// @function				StringBuilder()
/// @argument				{any} text?
///
/// @description			Constructs a String Builder Operator, assisting in string processing.
function StringBuilder() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				if (argument_count <= 0)
				{
					ID = "";	
				}
				else
				{
					ID = string(argument[0]);
				}
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
			// @description			Return the number of how many bytes this string occupies.
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
			//						in this string.
			static getSubstringCount = function(_substring)
			{
				return string_count(string(_substring), string(ID));
			}
			
			// @returns				{string}
			// @description			Return a version of this string that contains only its digits.
			static getDigits = function()
			{
				return string_digits(string(ID));
			}
			
			// @returns				{int}
			// @description			Return the number of characters in the string after parsing
			//						escape characters.
			static getLength = function()
			{
				return string_length(string(ID));	
			}
			
			// @returns				{string}
			// @description			Return a version of this string that only contains its letters
			//						from the English alphabet.
			static getLetters = function()
			{
				return string_letters(string(ID));
			}
			
			// @returns				{string}
			// @description			Return a version of this string that only contains its letters
			//						from the English alphabet and digits.
			static getLettersAndDigits = function()
			{
				return string_lettersdigits(string(ID));
			}
			
			// @argument			{any} substring
			// @argument			{bool} startFromEnd?
			// @argument			{int} startPosition?
			// @returns				{int|undefined}
			// @description			Return the position of the first instance of a substring in
			//						this string, starting from its start, end or with offset of
			//						either. The position will equal the position of the first 
			//						character of the substring, counting always from the start.
			//						Returns {undefined} if the substring does not exist in this
			//						string.
			static getSubstringPosition = function(_substring, _startFromEnd, _startPosition)
			{
				var _result = undefined;
				var _string = string(ID);
				
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
			// @argument			{int} separation>
			// @argument			{int} width?
			// @returns				{int}
			// @description			Return the width in pixels of how much this string would occupy
			//						when drawn with the current or defined font, possibly also
			//						counting the limitations of width before forced line-break 
			//						and separation upon it.
			static getSize_x = function(_font, _separation, _width)
			{
				if ((_font != undefined) and (_font != draw_get_font()))
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
					return string_width_ext(string(ID), _separation, _width);
				}
				else
				{
					return string_width(string(ID));
				}
			}
			
			// @argument			{Font|font} font?
			// @argument			{int} separation>
			// @argument			{int} width?
			// @returns				{int}
			// @description			Return the height in pixels of how much this string would occupy
			//						when drawn with the current or defined font, possibly also
			//						counting the limitations of width before forced line-break 
			//						and separation upon it.
			static getSize_y = function(_font, _separation, _width)
			{
				if ((_font != undefined) and (_font != draw_get_font()))
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

				if (_separation != undefined) and (_width != undefined)
				{
					return string_height_ext(string(ID), _separation, _width);
				}
				else
				{
					return string_height(string(ID));
				}
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{int} position
			// @argument			{int} byte
			// @description			Replace the selected character by other one, specified 
			//						by UTF-8 byte value.
			static setByte = function(_position, _byte)
			{
				var _string = string(ID);
				_position = clamp(_position, 1, (string_length(_string) + 1));
				
				ID = string_set_byte_at(_string, _position, _byte);
				
				return ID;
			}
			
			// @argument			{int} position
			// @argument			{int} number
			// @description			Delete a part of the string, starting from the character
			//						at the specified position and continuing right by the 
			//						specified number of characters or its end.
			static deletePart = function(_position, _number)
			{
				var _string = string(ID);
				_position = clamp(_position, 1, (string_length(_string) + 1));
				
				ID = string_delete(_string, _position, _number);
				
				return ID;
			}
			
			// @argument			{real} value
			// @argument			{int} wholeNumberPlaces
			// @argument			{int} decimalPlaces
			// @argument			{bool} replace?
			// @description			Add to this string or replace it with a number that has a 
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
			// @description			Insert a specified substring to the left of the specified 
			//						character.
			static insert = function(_substring, _position)
			{
				ID = string_insert(string(_substring), string(ID), _position);
				
				return ID;
			}
			
			// @argument			{int} number
			// @argument			{any} separator?
			// @description			Add the specified number of copies of this string to itself,
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
			// @argument			{int} number
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
			
			// @returns				{string}
			// @description			Set all letters from English alphabet in this string to lowercase.
			static setLowercase = function()
			{
				ID = string_lower(string(ID));
				
				return ID;
			}
			
			// @returns				{string}
			// @description			Set all letters from English alphabet in this string to uppercase.
			static setUppercase = function()
			{
				ID = string_upper(string(ID));
				
				return ID;
			}
			
		#endregion
		#region <Execution>
			
			// @description			Display this string in the standard output of the program.
			static display_output = function()
			{
				show_debug_message(ID);
			}
			
			// @description			Display this string in the message box handled by the system.
			static display_messageBox = function()
			{
				show_message(ID);
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Overrides the string conversion with the content.
			static toString = function()
			{
				return string(ID);
			}
			
			// @returns				{string}
			// @description			Return a string with constructor name and its content.
			static toString_full = function()
			{
				return (instanceof(self) + "(" + string(ID) + ")");
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		argument_original = [argument[0]];
		
		if (argument_count <= 0)
		{
			self.construct();
		}
		else
		{
			self.construct(argument_original[0]);
		}
		
	#endregion
}
