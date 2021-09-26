/// @function				Shader()
/// @argument				{int:shader} shader
///							
/// @description			Construct a Shader resource used to alter drawing.
///							
///							Construction types:
///							- New constructor
///							- Empty: {void|undefined}
///							- Constructor copy: {Shader} other
function Shader() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				ID = undefined;
				name = undefined;
				compiled = undefined;
				uniform = undefined;
				sampler = undefined;
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (instanceof(argument[0]) == "Shader")
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						ID = _other.ID;
						name = _other.name;
						compiled = _other.compiled;
						uniform = _other.uniform;
						sampler = _other.sampler;
					}
					else
					{
						//|Construction type: New constructor.
						ID = argument[0];
						name = shader_get_name(ID);
						compiled = shader_is_compiled(ID);
						uniform = {};
						sampler = {};
					}
				}
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (shader_is_compiled(ID)));
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{string} uniform
			// @returns				{int} | On error: {undefined}
			// @description			Get a sampler index of a uniform from this Shader
			static getSampler = function(_uniform)
			{
				if (compiled)
				{
					var _sampler = shader_get_sampler_index(ID, _uniform);
					var _handle = ((_sampler != -1) ? _sampler : undefined)
					
					var _struct =
					{
						handle: _handle
					}
					
					variable_struct_set(sampler, _uniform, _struct);
					
					return _handle;
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getSampler";
					var _errorText = ("Attempted to use a Shader that is not compiled: " +
									  "{" + string(name) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{bool}
			// @description			Check whether this Shader is the currently set one.
			static isActive = function()
			{
				return ((compiled) ? (shader_current() == ID) : false);
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{string} uniform
			// @argument			{real|real[]|Vector2} value1
			// @argument			{real} value2?
			// @argument			{real} value3?
			// @argument			{real} value4?
			// @description			Pass one or more float-type numbers as a uniform to this Shader.
			//						If only one value argument is passed, it can be an array or
			//						Vector2. Otherwise all value arguments have to be numbers.
			static setUniformFloat = function(_uniform)
			{
				if (compiled)
				{
					var _value = undefined;
					var _handle = shader_get_uniform(ID, _uniform);
					
					switch (argument_count)
					{
						case 2:
							var _value = argument[1];
							
							if (is_real(_value))
							{
								shader_set_uniform_f(_handle, _value);
							}
							else if (is_array(_value))
							{
								shader_set_uniform_f_array(_handle, _value);
							}
							else if (instanceof(_value) == "Vector2")
							{
								shader_set_uniform_f(_handle, _value.x, _value.y);
							}
							else
							{
								var _errorReport = new ErrorReport();
								var _callstack = debug_get_callstack();
								var _methodName = "setUniformFloat";
								var _errorText = ("Attempted to set an uniform using an " +
												  "unrecognized data type:\n" +
												  "Shader: " + "{" + string(name) + "}" + "\n" +
												  "Data: " + "{" + string(_value) + "}");
								_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																	 _errorText);
								
								exit;
							}
						break;
						
						case 3:
							_value = [argument[1], argument[2]];
							
							shader_set_uniform_f(_handle, _value[0], _value[1]);
						break;
						
						case 4:
							_value = [argument[1], argument[2], argument[3]];
							
							shader_set_uniform_f(_handle, _value[0], _value[1], _value[2]);
						break;
						
						case 5:
						default:
							_value = [argument[1], argument[2], argument[3], argument[4]];
							
							shader_set_uniform_f(_handle, _value[0], _value[1], _value[2], _value[3]);
						break;
					}
					
					var _struct = 
					{
						handle: ((_handle != -1) ? _handle : undefined),
						type: "float",
						value: _value
					};
					
					variable_struct_set(uniform, _uniform, _struct);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setUniformFloat";
					var _errorText = ("Attempted to use a Shader that is not compiled: " +
									  "{" + string(name) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{string} uniform
			// @argument			{int|int[]|Vector2} value1
			// @argument			{int} value2?
			// @argument			{int} value3?
			// @argument			{int} value4?
			// @description			Pass one or more integer values as a uniform to this Shader.
			//						If only one value argument is passed, it can be an array or
			//						Vector2. Otherwise all value arguments have to be numbers.
			static setUniformInt = function(_uniform)
			{
				if (compiled)
				{
					var _value = undefined;
					var _handle = shader_get_uniform(ID, _uniform);
					
					switch (argument_count)
					{
						case 2:
							var _value = argument[1];
							
							if (is_real(_value))
							{
								shader_set_uniform_i(_handle, _value);
							}
							else if (is_array(_value))
							{
								shader_set_uniform_i_array(_handle, _value);
							}
							else if (instanceof(_value) == "Vector2")
							{
								shader_set_uniform_i(_handle, _value.x, _value.y);
							}
							else
							{
								var _errorReport = new ErrorReport();
								var _callstack = debug_get_callstack();
								var _methodName = "setUniformInt";
								var _errorText = ("Attempted to set an uniform using an " +
												  "unrecognized data type:\n" +
												  "Shader: " + "{" + string(name) + "}" + "\n" +
												  "Data: " + "{" + string(_value) + "}");
								_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																	 _errorText);
								
								exit;
							}
						break;
						
						case 3:
							_value = [argument[1], argument[2]];
							
							shader_set_uniform_i(_handle, _value[0], _value[1]);
						break;
						
						case 4:
							_value = [argument[1], argument[2], argument[3]];
							
							shader_set_uniform_i(_handle, _value[0], _value[1], _value[2]);
						break;
						
						case 5:
						default:
							_value = [argument[1], argument[2], argument[3], argument[4]];
							
							shader_set_uniform_i(_handle, _value[0], _value[1], _value[2], _value[3]);
						break;
					}
					
					var _struct = 
					{
						handle: ((_handle != -1) ? _handle : undefined),
						type: "int",
						value: _value
					};
					
					variable_struct_set(uniform, _uniform, _struct);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setUniformInt";
					var _errorText = ("Attempted to use a Shader that is not compiled: " +
									  "{" + string(name) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{string} uniform
			// @argument			{real[]} value?
			// @description			Pass the currently set matrix or an array of its values as a
			//						uniform to this Shader.
			static setUniformMatrix = function(_uniform, _value)
			{
				if (compiled)
				{
					var _handle = shader_get_uniform(ID, _uniform);
					
					if (is_array(_value))
					{
						shader_set_uniform_matrix_array(_handle, _value);
					}
					else
					{
						shader_set_uniform_matrix(_handle);
					}
					
					var _struct = 
					{
						handle: _handle,
						type: "matrix",
						value: _value
					};
					
					variable_struct_set(uniform, _uniform, _struct);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setUniformMatrix";
					var _errorText = ("Attempted to use a Shader that is not compiled: " +
									  "{" + string(name) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{bool} target
			// @description			Set whether this Shader is currently applied.
			static setActive = function(_target)
			{
				if (compiled)
				{
					switch (_target)
					{
						case true:
							shader_set(ID);
						break;
						
						case false:
							if (shader_current() == ID)
							{
								shader_reset();
							}
						break;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "set";
					var _errorText = ("Attempted to use a Shader that is not compiled: " +
									  "{" + string(name) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the name of this Shader.
			//						If this Shader is not compiled, it will be marked as such.
			static toString = function(_multiline = false)
			{
				if (is_real(ID))
				{
					var _string = "";
					
					if (_multiline)
					{
						var _mark_separator = "\n";
						
						_string = ("Name: " + shader_get_name(ID) + _mark_separator +
								   "Compiled: " + string(shader_is_compiled(ID)));
					}
					else
					{
						var _string_compilation = ((shader_is_compiled(ID)) ? "" : " (Uncompiled)");
						
						_string = (shader_get_name(ID) + _string_compilation);
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
