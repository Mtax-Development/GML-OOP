//  @function				Callback()
/// @argument				function {function|function[]}
/// @argument				argument? {any|any[]|any[+]}
/// @description			Constructs a handler storing a reference to a function, method or an array
///							of them and their arguments to execute them at any time.
///							Single value specified as an argument will be provided to each execution.
///							If multiple functions or methods are being executed, arguments specified in
///							an array will be provided to calls at respective array positions as single
///							argument, unless it is a nested array to provide every of its values as
///							multiple arguments to a single call. Empty arrays provide zero arguments.
// 							
// 							Construction types:
// 							- New constructor
// 							- Empty: {void|undefined}
// 							- Constructor copy: other {Callback}
function Callback() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				ID = undefined;
				self.argument = [];
				
				if (argument_count > 0)
				{
					if (is_instanceof(argument[0], Callback))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						ID = _other.ID;
						self.argument = _other.argument;
					}
					else
					{
						//|Construction type: New constructor.
						ID = argument[0];
						self.argument = ((argument_count > 1) ? argument[1] : []);
					}
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				if (is_callable(ID))
				{
					return true;
				}
				else if (is_array(ID))
				{
					var _i = 0;
					repeat (array_length(ID))
					{
						if (!is_callable(ID[_i]))
						{
							return false;
						}
						
						++_i;
					}
					
					return true;
				}
				else
				{
					return false;
				}
			}
			
			/// @argument			{bool} keepArgumentData?
			/// @description		Remove references to functions or methods from this constructor, so
			///						its executions will have no effect when called. Argument data will
			///						also be removed, unless specified otherwise.
			static clear = function(_keepArgumentData = false)
			{
				ID = undefined;
				
				if (!_keepArgumentData)
				{
					self.argument = [];
				}
				
				return self;
			}
			
		#endregion
		#region <Setters>
			
			/// @argument			function? {function|function[]}
			/// @argument			argument? {any|any[]|any[+]}
			/// @description		Set each value of this constructor.
			static set = function(_function = ID, _argument = self.argument)
			{
				ID = _function;
				self.argument = _argument;
				
				return self;
			}
			
			/// @argument			value {Callback|any[]|any[+]}
			/// @description		Set the function or method of this constructor to ones of specified
			///						Callback or array, the first value of which is a function or method
			///						and second value is their arguments. Each of these array positions
			///						can be be occupied by a nested array to specify multiple values.
			static setAll = function(_value)
			{
				try
				{
					var _callback = ID;
					var _argument = self.argument;
					
					if (is_array(_value))
					{
						_callback = _value[0];
						
						if (array_length(_value) > 1)
						{
							_argument = _value[1];
						}
					}
					else
					{
						_callback = _value.ID;
						_argument = _value.argument;
					}
					
					ID = _callback;
					self.argument = _argument;
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setAll()"], _exception);
				}
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			condition? {bool}
			/// @returns			{any|undefined}
			/// @description		Execute all functions and methods of this constructor in their
			///						order by providing them their respective arguments, if any. This
			///						execution can be additionally controlled by specifying a condition
			///						to prevent the operation when that condition is not fulfilled.
			static execute = function(_condition = true)
			{
				if ((ID != undefined) and (_condition))
				{
					var _callback_isArray = is_array(ID);
					var _argument_isArray = is_array(self.argument);
					var _argument_direct = (((!_callback_isArray) and (_argument_isArray)) or
											((_argument_isArray) and
											(array_length(self.argument) == 0)));
					var _callback_array = ((_callback_isArray) ? ID : [ID]);
					var _callback_count = array_length(_callback_array);
					var _argument_array = ((_argument_isArray)
										   ? self.argument : array_create(_callback_count,
																		  self.argument));
					var _result = array_create(_callback_count, undefined);
					var _i = 0;
					repeat (_callback_count)
					{
						var _callback_index = ((is_method(_callback_array[_i]))
											   ? method_get_index(_callback_array[_i])
											   : _callback_array[_i]);
						
						try
						{
							_result[_i] = script_execute_ext(_callback_index,
															 ((_argument_direct)
															  ? _argument_array
															  : ((is_array(_argument_array[_i]))
																 ? _argument_array[_i]
																 : [_argument_array[_i]])));
						}
						catch (_exception)
						{
							new ErrorReport().report([other, self, "execute()",
													  ("loop" + "[" + string(_i) + "]")],
													 _exception);
						}
						
						++_i;
					}
					
					return ((_callback_isArray) ? _result : _result[0]);
				}
				
				return undefined;
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @argument			elementNumber? {int|all}
			/// @argument			elementLength? {int|all}
			/// @argument			mark_separator? {string}
			/// @argument			mark_cut? {string}
			/// @argument			mark_elementStart? {string}
			/// @argument			mark_elementEnd? {string}
			/// @argument			mark_sizeSeparator? {string}
			/// @argument			mark_arraySeparator? {string}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented by data of this constructor.
			static toString = function(_multiline = false, _elementNumber = 10, _elementLength = 30,
									   _mark_separator = ", ", _mark_cut = "...",
									   _mark_elementStart = "", _mark_elementEnd = "",
									   _mark_sizeSeparator = " - ", _mark_arraySeparator = ", ")
			{
				if (self.isFunctional())
				{
					//|General initialization.
					var _callback_isArray = is_array(ID);
					var _argument_isArray = is_array(self.argument);
					var _argument_direct = (((!_callback_isArray) and (_argument_isArray)) or
											((_argument_isArray) and
											(array_length(self.argument) == 0)));
					var _callback_array = ((is_array(ID) ? ID : [ID]));
					var _size = array_length(_callback_array);
					var _argument_array = ((_argument_isArray)
										   ? self.argument : array_create(_size, self.argument));
					
					if (_elementNumber == all)
					{
						_elementNumber = _size;
					}
					
					var _mark_separator_length = string_length(_mark_separator);
					var _mark_cut_length = string_length(_mark_cut);
					var _mark_elementStart_length = string_length(_mark_elementStart);
					var _mark_elementEnd_length = string_length(_mark_elementEnd);
					var _string = "";
					var _string_size = (string(_size));
					
					if (!_multiline)
					{
						_string += (instanceof(self) + "(" + _string_size);
						
						if (_size > 0)
						{
							_string += _mark_sizeSeparator;
						}
					}
					
					var _string_lengthLimit = (string_length(_string) + _elementLength +
											   _mark_elementStart_length + _mark_elementEnd_length);
					var _string_lengthLimit_cut = (_string_lengthLimit + _mark_cut_length);
					
					//|Content loop.
					var _i = [0, 0];
					repeat (min(_size, _elementNumber))
					{
						//|Get Callback Element.
						var _newElement = "";
						var _callback_current = _callback_array[_i[0]];
						var _argument_current = ((_argument_direct) ? _argument_array
																	: _argument_array[_i[0]]);
						var _argument_current_string = "";
						
						if (is_array(_argument_current))
						{
							var _argument_current_size = array_length(_argument_current)
							_i[1] = 0;
							repeat (_argument_current_size)
							{
								_argument_current_string += string(_argument_current[_i[1]]);
								
								if (_i[1] < (_argument_current_size - 1))
								{
									_argument_current_string += _mark_arraySeparator;
								}
								
								++_i[1];
							}
						}
						else
						{
							_argument_current_string = string(_argument_current);
						}
						
						try
						{
							if (is_method(_callback_current))
							{
								var _callback_owner = method_get_self(_callback_current);
								
								if (is_struct(_callback_owner))
								{
									var _callback_owner_name = instanceof(_callback_owner);
									
									if (_callback_owner_name == "<unknown>")
									{
										_newElement = room_get_name(room);
									}
									else
									{
										var _separatorPosition = string_last_pos("@",
																				 _callback_owner_name);
										
										_newElement = ((_separatorPosition > 0)
													   ? string_copy(_callback_owner_name, 1,
																	 (_separatorPosition - 1))
													   : _callback_owner_name);
									}
								}
								else
								{
									_newElement = ((id == 0) ? room_get_name(room)
															 : object_get_name(object_index));
								}
								
								_newElement += ".method";
							}
							else
							{
								_newElement = (script_get_name(_callback_current));
							}
							
							_newElement += ("(" + _argument_current_string + ")");
						}
						catch (_) {}
						
						//|Limit element length for multiline listing.
						if ((_multiline) and (_elementLength != all))
						{
							if ((string_length(_newElement)) > _elementLength)
							{
								_newElement = string_copy(_newElement, 1, _elementLength);
								_newElement += _mark_cut;
							}
						}
						
						//|Add the element string with all its parts.
						_string += (_mark_elementStart + _newElement + _mark_elementEnd);
						
						//|Cut strings and add cut or separation marks if appropriate.
						if (!_multiline)
						{
							if (_elementLength != all)
							{
								var _string_length = string_length(_string);
								
								//|If the current element is not the last, add a separator or cut it
								// if it would be too long.
								if (_i[0] < (_size - 1))
								{
									if ((_string_length + _mark_separator_length) >=
										 _string_lengthLimit)
									{
										_string = string_copy(_string, 1, _string_lengthLimit);
										_string += _mark_cut;
										break;
									}
									else
									{
										if (_i[0] < (_elementNumber - 1))
										{
											_string += _mark_separator;
										}
										else
										{
											_string += _mark_cut;
											break;
										}
									}
								}
								else
								{
									//|If the current element is last, cut it if it would be too long,
									// but expand the length check by the length of the cut mark.
									if (_string_length > _string_lengthLimit_cut)
									{
										_string = string_copy(_string, 1, _string_lengthLimit);
										_string += _mark_cut;
										break;
									}
								}
							}
							else
							{
								//|If the elements are to be shown fully, add separators after the
								// ones that are not last. Add a cut mark after the last one if not
								// all elements are shown.
								if (_i[0] < (_elementNumber - 1))
								{
									_string += _mark_separator;
								}
								else if (_elementNumber != _size)
								{
									_string += _mark_cut;
								}
							}
						}
						else
						{
							_string += "\n";
						}
						
						++_i[0];
					}
					
					//|String finish.
					if (_multiline)
					{
						//|Add a cut mark at the end of multiline listing if not all are shown.
						if (_i[0] < _size)
						{
							_string += _mark_cut;
						}
					}
					else
					{
						_string += ")";
					}
					
					return _string;
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			/// @returns			{any[]|any[+]}
			/// @description		Create an array with all functions or methods of this constructor
			///						at its first position and their arguments at second position.
			///						If any of these properties contain multiple values, they  will be
			///						returned in a nested array.
			static toArray = function()
			{
				return [ID, self.argument];
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		static constructor = Callback;
		
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
