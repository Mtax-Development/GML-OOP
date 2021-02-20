/// @function				Shader()
/// @argument				{shader} shader
///
/// @description			Construct a Shader resource used to alter drawing.
///
///							Construction methods:
///							- New constructor
///							- Constructor copy: {Shader} other
function Shader() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				ID = undefined;
				name = undefined;
				compiled = undefined;
				uniform = undefined;
				
				if ((argument_count > 0) and (instanceof(argument[0]) == "Shader"))
				{
					//|Construction method: Constructor copy.
					var _other = argument[0];
					
					ID = _other.ID;
					name = _other.name;
					compiled = _other.compiled;
					uniform = _other.uniform;
				}
				else
				{
					//|Construction method: New constructor.
					ID = argument[0];
					name = shader_get_name(ID);
					compiled = shader_is_compiled(ID);
					uniform = {};
				}
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{string} uniform
			// @argument			{real|real[]|Vector2} value1
			// @argument			{real} value2?
			// @argument			{real} value3?
			// @argument			{real} value4?
			// @description			Pass one or more float values as a uniform to this Shader.
			//						If only one value argument is passed, it can be an array or
			//						Vector2. Otherwise all value arguments have to be numbers.
			static setUniform_float = function()
			{
				if (compiled)
				{
					if (argument_count > 1)
					{
						var _uniform = argument[0];
						
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
									exit;
								}
							break;
							
							case 3:
								shader_set_uniform_f(_handle, argument[1], argument[2]);
								
								_value = [argument[1], argument[2]];
							break;
							
							case 4:
								shader_set_uniform_f(_handle, argument[1], argument[2], argument[3]);
								
								_value = [argument[1], argument[2], argument[3]];
							break;
							
							case 5:
								shader_set_uniform_f(_handle, argument[1], argument[2], argument[3], 
													 argument[4]);
								
								_value = [argument[1], argument[2], argument[3], argument[4]];
							break;
						}
						
						var _struct = 
						{
							handle: _handle,
							type: "float",
							value: _value
						};
						
						variable_struct_set(uniform, _uniform, _struct);
						
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setUniform_float";
					var _errorText = ("Attempted to use a Shader that is not compiled: " +
									  "{" + string(name) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{string} uniform
			// @argument			{int|int[]|Vector2} value1
			// @argument			{int} value2?
			// @argument			{int} value3?
			// @argument			{int} value4?
			// @description			Pass one or more integer values as a uniform to this Shader.
			//						If only one value argument is passed, it can be an array or
			//						Vector2. Otherwise all value arguments have to be numbers.
			static setUniform_int = function()
			{
				if (compiled)
				{
					if (argument_count > 1)
					{
						var _uniform = argument[0];
						
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
									exit;
								}
							break;
							
							case 3:
								shader_set_uniform_i(_handle, argument[1], argument[2]);
								
								_value = [argument[1], argument[2]];
							break;
							
							case 4:
								shader_set_uniform_i(_handle, argument[1], argument[2], argument[3]);
								
								_value = [argument[1], argument[2], argument[3]];
							break;
							
							case 5:
								shader_set_uniform_i(_handle, argument[1], argument[2], argument[3], 
													 argument[4]);
								
								_value = [argument[1], argument[2], argument[3], argument[4]];
							break;
						}
						
						var _struct = 
						{
							handle: _handle,
							type: "int",
							value: _value
						};
						
						variable_struct_set(uniform, _uniform, _struct);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setUniform_int";
					var _errorText = ("Attempted to use a Shader that is not compiled: " +
									  "{" + string(name) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
			// @argument			{string} uniform
			// @argument			{real[]} array?
			// @description			Pass the currently set matrix or an array of its values as a
			//						uniform to this Shader.
			static setUniform_matrix = function(_uniform, _array)
			{
				if (compiled)
				{
					if (_uniform != undefined)
					{
						var _value = undefined;
						var _handle = shader_get_uniform(ID, _uniform);
						var _struct = {};
						
						if (_array != undefined)
						{
							shader_set_uniform_matrix_array(_uniform, _array);
							_value = _array;
						}
						else
						{
							shader_set_uniform_matrix(_uniform);
						}
						
						var _struct = 
						{
							handle: _handle,
							type: "matrix",
							value: _value
						};
						
						variable_struct_set(uniform, _uniform, _struct);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setUniform_matrix";
					var _errorText = ("Attempted to use a Shader that is not compiled: " +
									  "{" + string(name) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{string} uniform
			// @returns				{int} | On error: {int:-1}
			// @description			Get a sampler index of a uniform from this Shader
			static getSampler = function(_uniform)
			{
				if (compiled)
				{
					return shader_get_sampler_index(ID, _uniform);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getSampler";
					var _errorText = ("Attempted to use a Shader that is not compiled: " +
									  "{" + string(name) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return -1;
				}
			}
			
			// @returns				{bool}
			// @description			Check whether this Shader is the currently set one.
			static isCurrent = function()
			{
				return ((compiled) ? (shader_current() == ID) : false);
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{bool} active
			// @description			Set whether this Shader is active.
			static set = function(_active)
			{
				if (compiled)
				{
					if (_active)
					{
						shader_set(ID);
					}
					else if (shader_current() == ID)
					{
						shader_reset();
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "set";
					var _errorText = ("Attempted to use a Shader that is not compiled: " +
									  "{" + string(name) + "}" + "\n");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the name of this Shader.
			//						If this Shader is not compiled, it will be marked as such.
			static toString = function()
			{
				if (is_real(ID))
				{
					var _text_uncompiled = ((shader_is_compiled(ID)) ? "" : "; uncompiled");
					
					return (instanceof(self) + "(" + shader_get_name(ID) + _text_uncompiled + ")");
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
