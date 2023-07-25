//  @function				format_links()
/// @argument				text {string}
/// @argument				constructor_name {string}
/// @argument				constructor_property? {string[+]}
/// @argument				link_constructor_name? {bool}
/// @argument				skip_midwords? {bool}
/// @argument				encloseLanguageFeature? {bool|string|noone}
/// @argument				ignoredProperties? {string[]}
/// @returns				{string}
/// @description			Format hyperlinks to pages of documentation in relevant parts of the
///							specified string. This formatting can be configured in various ways,
///							depending on arguments:
///							 - The name of most relevant constructor can be turned into either a linked
///							   or bold test.
///							 - The text linking can be filtered to detect the end of text before
///							   linking it to not result with only a part of the word being linked.
///							 - Language features can be specified to be either enclosed in grave accent
///							   character to be turned into a link or specified as {noone} to not be
///							   affected by formatting.
///							 - Property names can be specified to be ignored in formatting.
function format_links(_text, _constructor_name, _constructor_property, _link_constructor_name = false,
					  _skip_midwords = false, _encloseLanguageFeature = false, _ignoredProperties = [])
{
	static _stringParser = new StringParser();
	static _stringParser_element_chain = new StringParser();
	static _stringParser_method = new StringParser();
	static _arrayParser = new ArrayParser();
	static _arrayParser_ignoredProperties = new ArrayParser();
	
	_arrayParser.ID = [];
	_arrayParser_ignoredProperties.setParser(_ignoredProperties);
	
	if (!is_string(_text))
	{
		show_error("Attempted to format a data type that is not a string.", true);
	}
	
	_text = string(_text);
	
	var _unicode_newline = "\000a";
	var _link_manual_language = @"https://manual.yoyogames.com/GameMaker_Language/";
	var _filter_dataType = ["void", "any", "undefined", "bool", "pointer", "int", "real", "string",
							"char", "struct", "function", "constant", "self", "all", "noone"];
	var _filter_languageFeature =
	 [["if", @"GML_Overview/Language_Features/If_Else_and_Conditional_Operators.htm"],
	  ["else", @"GML_Overview/Language_Features/If_Else_and_Conditional_Operators.htm"],
	  ["return", @"GML_Overview/Language_Features/return.htm"],
	  ["exit", @"GML_Overview/Language_Features/exit.htm"],
	  ["new", @"GML_Overview/Language_Features/new.htm"],
	  ["with", @"GML_Overview/Language_Features/with.htm"],
	  ["repeat", @"GML_Overview/Language_Features/repeat.htm"],
	  ["while", @"GML_Overview/Language_Features/while.htm"],
	  ["switch", @"GML_Overview/Language_Features/switch.htm"],
	  ["break", @"GML_Overview/Language_Features/break.htm"],
	  ["false", @"GML_Reference/Maths_And_Numbers/Maths_And_Numbers.htm"],
	  ["true", @"GML_Reference/Maths_And_Numbers/Maths_And_Numbers.htm"]];
	var _filter_constant =
	[["bboxkind_*", (@"GML_Reference/Asset_Management/Sprites/Sprite_Manipulation/" +
					 @"sprite_collision_mask.htm")],
	 ["bboxmode_*", (@"GML_Reference/Asset_Management/Sprites/Sprite_Manipulation/" +
					 @"sprite_set_bbox_mode.htm")],
	 ["buffer_[bufferType]", @"GML_Reference/Buffers/buffer_get_type.htm"],
	 ["buffer_[dataType]", @"GML_Reference/Buffers/buffer_write.htm"],
	 ["buffer_seek_*", @"GML_Reference/Buffers/buffer_seek.htm"],
	 ["fa_[halign]", @"GML_Reference/Drawing/Text/draw_set_halign.htm"],
	 ["fa_[valign]", @"GML_Reference/Drawing/Text/draw_set_valign.htm"],
	 ["mb_*", @"GML_Reference/Game_Input/Mouse_Input/Mouse_Input.htm"],
	 ["pt_shape_*", @"GML_Reference/Drawing/Particles/Particle_Types/part_type_shape.htm"],
	 ["ps_distr_*", @"GML_Reference/Drawing/Particles/Particle_Emitters/part_emitter_region.htm"],
	 ["ps_shape_*", @"GML_Reference/Drawing/Particles/Particle_Emitters/part_emitter_region.htm"],
	 ["spritespeed_*", (@"GML_Reference/Asset_Management/Sprites/Sprite_Manipulation/" +
						@"sprite_set_speed.htm")]];
	var _filter_constant_value =
	[["fa_left", @"GML_Reference/Drawing/Text/draw_set_halign.htm"],
	 ["fa_top", @"GML_Reference/Drawing/Text/draw_set_valign.htm"]];
	var _filter_function =
	[["string()", @"GML_Reference/Strings/string.htm"]];
	var _filter_overview = [["Event system", (@"Overview#event-system")]]
	var _filter_dataType_count = array_length(_filter_dataType);
	var _subsidiaryDataType_separator = ":";
	var _subsidiaryDataType_count = string_count(_subsidiaryDataType_separator,
												 string_replace(_text, "On error:", ""));
	
	if (_subsidiaryDataType_count > 0)
	{
		var _string_subsidiaryDataType = _text;
		
		repeat (_subsidiaryDataType_count)
		{
			var _position_subsidiaryDataType_separator = string_pos(_subsidiaryDataType_separator,
																	_string_subsidiaryDataType);
			
			var _primaryType = "";
			var _i = 0;
			repeat (_filter_dataType_count)
			{
				var _dataType_check = (string_copy(_string_subsidiaryDataType,
									   (_position_subsidiaryDataType_separator -
										string_length(_filter_dataType[_i])),
									   string_length(_filter_dataType[_i])));
				
				if (_dataType_check == _filter_dataType[_i])
				{
					_primaryType = _filter_dataType[_i];
					
					break;
				}
				
				++_i;
			}
			
			_string_subsidiaryDataType = string_copy(_string_subsidiaryDataType,
													 (_position_subsidiaryDataType_separator + 1),
													 (string_length(_string_subsidiaryDataType) -
													  (_position_subsidiaryDataType_separator + 1)));
			
			var _subsidiaryType = "";
			var _i = 1;
			repeat (string_length(_string_subsidiaryDataType))
			{
				var _character = string_char_at(_string_subsidiaryDataType, _i);
				
				if (_character == string_lettersdigits(_character))
				{
					_subsidiaryType += _character;
				}
				else
				{
					break;
				}
				
				++_i;
			}
			
			var _subsidiaryDataType_formated = (_primaryType + _subsidiaryDataType_separator +
												_subsidiaryType);
			
			if (!_arrayParser.contains(_subsidiaryDataType_formated))
			{
				_arrayParser.add(_subsidiaryDataType_formated);
			}
		}
	}
	
	_filter_dataType_count = array_length(_filter_dataType);
	
	_stringParser.setParser(_text);
	
	var _constructor_element_chain = new StringParser(_constructor_name).split(".");
	var _constructor_element_chain_last;
	
	if (is_array(_constructor_element_chain))
	{
		_constructor_element_chain_last =
			_constructor_element_chain[(array_length(_constructor_element_chain) - 1)];
	}
	else
	{
		_constructor_element_chain_last = _constructor_element_chain;
		_constructor_element_chain = [_constructor_element_chain];
	}
	
	var _constructor_link = [];
	var _i = array_length(constructor_name);
	repeat (_i--)
	{
		var _constructor_name_element_chain = _stringParser_element_chain
											   .setParser(constructor_name[_i])
											   .split(".");
			
		if (is_array(_constructor_name_element_chain))
		{
			var _constructor_name_element_last =
			_constructor_name_element_chain[(array_length(_constructor_name_element_chain) - 1)];
				
			array_push(_constructor_link, [_constructor_name_element_last,
											("<a href=\"" + string_upper(constructor_name[_i]) +
											"\">" + string_upper(_constructor_name_element_last) + 
											"</a>")]);
		}
		else
		{
			array_push(_constructor_link, [constructor_name[_i],
											("<a href=\"" + string_upper(constructor_name[_i]) +
											"\">" + string_upper(constructor_name[_i]) +
											"</a>")]);
		}
		
		--_i;
	}
	
	array_sort(_constructor_link, function(_value1, _value2)
	{
		return ((string_length(_value1[0]) >= string_length(_value2[0])) ? -1 : 1);
	});
	
	var _i = [0, 2];
	repeat (array_length(_constructor_link))
	{
		var _name = _constructor_link[_i[0]][0];
		_i[1] = 2;
		repeat (string_length(_name) - _i[1])
		{
			var _char = string_char_at(_name, _i[1]);
			
			if (_char == string_upper(_char))
			{
				var _name_uppercase = string_upper(_name);
				var _name_spaced = string_insert(" ", _name, _i[1]);
				var _link_name_spaced = string_replace(_constructor_link[_i[0]][1],
													   (_name_uppercase + "</a>"),
													   (string_upper(_name_spaced) + "</a>"));
				
				array_insert(_constructor_link, _i[0], [_name_spaced, _link_name_spaced]);
				
				++_i[0];
				
				break;
			}
			
			++_i[1];
		}
		
		++_i[0];
	}
	
	var _midword_filter = ((_skip_midwords) ? [" ", "{", "|", ".", _unicode_newline] : [""]);
	var _i = [0, 0];
	repeat (array_length(_constructor_link))
	{
		_i[1] = 0;
		repeat (array_length(_midword_filter))
		{
			if ((!_link_constructor_name)
			and (_constructor_link[_i[0]][0] == _constructor_element_chain_last))
			{
				_stringParser.replace((_midword_filter[_i[1]] + _constructor_link[_i[0]][0]), 
									  (_midword_filter[_i[1]] + "<b>" +
									   string_upper(_constructor_element_chain_last) + "</b>"));
			}
			else
			{
				if (_stringParser.startsWith(_constructor_link[_i[0]][0]))
				{
					_stringParser.replace(_constructor_link[_i[0]][0], _constructor_link[_i[0]][1], 1);
				}
				
				_stringParser.replace((_midword_filter[_i[1]] + _constructor_link[_i[0]][0]),
									  (_midword_filter[_i[1]] + _constructor_link[_i[0]][1]));
				
			}
			
			++_i[1];
		}
		
		++_i[0];
	}
	
	if (_skip_midwords)
	{
		var _i = 0;
		repeat (_filter_dataType_count)
		{
			var _dataType_upper = string_upper(_filter_dataType[_i]);
		
			_stringParser.replace((_filter_dataType[_i] + "("), (_dataType_upper + "("))
						 .replace(("{" + _filter_dataType[_i]),
								  ("{" + "<a href=\"Overview#data-type-listing\">" +
								   (_dataType_upper) + "</a>"))
						 .replace(("|" + _filter_dataType[_i]),
								  ("|" + "<a href=\"Overview#data-type-listing\">" +
								   (_dataType_upper) + "</a>"));
		
			++_i;
		}
	}
	else
	{
		var _i = 0;
		repeat (_filter_dataType_count)
		{
			var _dataType_upper = string_upper(_filter_dataType[_i]);
			
			_stringParser.replace((_filter_dataType[_i] + "("), (_dataType_upper + "("))
						 .replace(_filter_dataType[_i], ("<a href=\"Overview#data-type-listing\">" +
														 _dataType_upper + "</a>"));
		
			++_i;
		}
	}
	
	if (_stringParser.contains("CONSTANT"))
	{
		var _i = 0;
		repeat (array_length(_filter_constant))
		{
			_stringParser.replace(_filter_constant[_i][0],
								  ("<a href=\"" + _link_manual_language + _filter_constant[_i][1] +
								   "\">" + _filter_constant[_i][0] + "</a>"));
			
			++_i;
		}
	}
	
	var _i = 0;
	repeat (array_length(_filter_constant_value))
	{
		_stringParser.replace(_filter_constant_value[_i][0],
							  ("<a href=\"" + _link_manual_language +
							   _filter_constant_value[_i][1] + "\">" + _filter_constant_value[_i][0] +
							   "</a>"));
		
		++_i;
	}
	
	var _inner_link = [];
	var _i = 0;
	repeat (array_length(_constructor_link))
	{
		array_push(_inner_link, _constructor_link[_i][0]);
		
		++_i;
	}
	
	var _i = 0;
	repeat (array_length(_filter_dataType))
	{
		array_push(_inner_link, _filter_dataType[_i]);
		
		++_i;
	}
	
	//array_sort(_inner_link, function(_value1, _value2)
	//{
	//	return (string_length(_value1) > string_length(_value2) ? -1 : 1);
	//});
	
	var _i = 0;
	repeat (array_length(_inner_link))
	{
		_stringParser.replace(string_upper(_inner_link[_i]), _inner_link[_i]);
		
		++_i;
	}
	
	var _filter_languageFeature_midword = ((_skip_midwords) ? [" "] : [""]);
	
	if (_encloseLanguageFeature != noone)
	{
		var _filter_languageFeature_enclose = ((_encloseLanguageFeature) ? ["`", "<code>", "</code>"]
																		 : array_create(3, ""));
		var _i = [0, 0];
		repeat (array_length(_filter_languageFeature))
		{
			_i[1] = 0;
			repeat (array_length(_filter_languageFeature_midword))
			{
				var _filter_languageFeature_current_midword = (_filter_languageFeature_enclose[0] +
															   _filter_languageFeature[_i[0]][0] +
															   _filter_languageFeature_enclose[0] +
															   _filter_languageFeature_midword[_i[1]]);
				_stringParser.replace(_filter_languageFeature_current_midword,
									  (_filter_languageFeature_enclose[1] +
									   "<a href=\"" + _link_manual_language +
									   _filter_languageFeature[_i[0]][1] + "\">" +
									   _filter_languageFeature[_i[0]][0] + "</a>" +
									   _filter_languageFeature_midword[_i[1]] +
									   _filter_languageFeature_enclose[2]));
			
				++_i[1];
			}
		
			++_i[0];
		}
	}
	
	var _method_chained = _stringParser.getBetween("\">", "()", [" ", "\n"]);
	
	if (_method_chained != "")
	{
		_method_chained = array(_method_chained);
		var _i = 0;
		repeat (array_length(_method_chained))
		{
			_method_chained[_i] = _stringParser_method.setParser(_method_chained[_i]).split("</a>.");
			var _method_chained_link = ("<a href=\"" + _method_chained[_i][0] + "\">" +
										_method_chained[_i][0] + "</a>." + _method_chained[_i][1] +
										"()");
			_stringParser.replace(_method_chained_link,
								  ("<code>" + string_replace(_method_chained_link,
															 ("</a>." + _method_chained[_i][1] + "()"),
								   "</a>." + "<a href=\"" + _method_chained[_i][0] + "." +
								   _method_chained[_i][1] + "()" + "\"" + ">" +
								   _method_chained[_i][1] + "()" + "</a>") + "</code>"));
			
			++_i;
		}
	}
	
	method_listing.getValue(_constructor_name).forEach
	(
		function(_i, _key, _value, _argument)
		{
			var _stringParser = _argument[0];
			var _constructor_name = _argument[1];
			_i = 0;
			repeat (array_length(_value))
			{
				var _method_link = ("<a href=\"" + _constructor_name + "." + _value[_i] + "()" +
									"\">" + _value[_i] + "()" + "</a>");
				
				_stringParser.replace((" " + _value[_i] + "()"), (" " + _method_link));
				
				++_i;
			}
		},
		[_stringParser, _constructor_name]
	);
	
	if (is_array(_constructor_property))
	{
		var _midword_filter = ((_skip_midwords) ? [" ", "(", ")", "}", "|", "."] : [""]);
		var _i = [0, 0];
		repeat (array_length(_constructor_property))
		{
			if (!_arrayParser_ignoredProperties.contains(_constructor_property[_i[0]][0]))
			{
				_i[1] = 0;
				repeat (array_length(_midword_filter))
				{
					_stringParser.replace((_constructor_property[_i[0]][0] + _midword_filter[_i[1]]),
										  ("<code><a href=\"" +
										   _constructor_name + "#properties\">" +
										   _constructor_property[_i[0]][0] + "</a></code>" +
										   _midword_filter[_i[1]]));
					
					++_i[1];
				}
			}
			
			++_i[0];
		}
	}
	
	var _i = 0;
	repeat (array_length(_filter_function))
	{
		_stringParser.replace(_filter_function[_i][0],
							  ("<a href=\"" + _link_manual_language + _filter_function[_i][1] +
							   "\">" + _filter_function[_i][0] + "</a>"));
		
		++_i;
	}
	
	var _i = 0;
	repeat (array_length(_filter_overview))
	{
		_stringParser.replace(_filter_overview[_i][0],
							  ("<a href=\"" + _filter_overview[_i][1] + "\">" +
							   _filter_overview[_i][0] + "</a>"));
		
		++_i;
	}
	
	return _stringParser.ID;
}
