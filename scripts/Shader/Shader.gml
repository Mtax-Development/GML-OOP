// @function				Shader()
// @argument				{shader} shader
// @description				Constructs a Shader resource, which can be used to alter drawing.
function Shader(_shader) constructor
{
	#region [Methods]
		#region <Setters>
			
			// @argument			{string} uniform
			// @argument			{real|real[]|Vector2} value1
			// @argument			{real} value2?
			// @argument			{real} value3?
			// @argument			{real} value4?
			// @description			Pass float value(s) to this Shader's uniform.
			static setUniform_float = function(_uniform, _value1)
			{
				if (compiled)
				{
					if (_uniform != undefined)
					{
						var _value;
						var _handle = shader_get_uniform(ID, _uniform);
						
						if (is_array(_value1))
						{
							shader_set_uniform_i_array(_handle, _value1);
							
							if (array_length(_value1) == 1)
							{
								_value = _value1[0];
							}
							else
							{
								_value = _value1;
							}
						}
						else if (is_struct(_value1))
						{
							shader_set_uniform_f(_handle, _value1.x, _value1.y);
							_value = [_value1.x, _value1.y];
						}
						else
						{
							switch (argument_count)
							{
								case 2:
									shader_set_uniform_f(_handle, _value1);
									_value = _value1;
								break;
							
								case 3:
									shader_set_uniform_f(_handle, _value1, argument[2]);
									_value = [_value1, argument[2]];
								break;
							
								case 4:
									shader_set_uniform_f(_handle, _value1, argument[2], argument[3]);
									_value = [_value1, argument[2], argument[3]];
								break;
							
								case 5:
									shader_set_uniform_f(_handle, _value1, argument[2], argument[3], 
														 argument[4]);
									_value = [_value1, argument[2], argument[3], argument[4]];
								break;
								
								default:
									exit;
								break;
							}
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
			}
			
			// @argument			{string} uniform
			// @argument			{int|int[]|Vector2} value1
			// @argument			{int} value2?
			// @argument			{int} value3?
			// @argument			{int} value4?
			// @description			Pass integer value(s) to this Shader's uniform.
			static setUniform_int = function(_uniform, _value1)
			{
				if (compiled)
				{
					if (_uniform != undefined)
					{
						var _value;
						var _handle = shader_get_uniform(ID, _uniform);
						
						if (is_array(_value1))
						{
							shader_set_uniform_i_array(_handle, _value1);
							
							if (array_length(_value1) == 1)
							{
								_value = _value1[0];
							}
							else
							{
								_value = _value1;
							}
						}
						else if (is_struct(_value1))
						{
							shader_set_uniform_f(_handle, _value1.x, _value1.y);
							_value = [_value1.x, _value1.y];
						}
						else
						{
							switch (argument_count)
							{
								case 2:
									shader_set_uniform_i(_handle, _value1);
									_value = _value1;
								break;
							
								case 3:
									shader_set_uniform_i(_handle, _value1, argument[2]);
									_value = [_value1, argument[2]];
								break;
							
								case 4:
									shader_set_uniform_i(_handle, _value1, argument[2], argument[3]);
									_value = [_value1, argument[2], argument[3]];
								break;
							
								case 5:
									shader_set_uniform_i(_handle, _value1, argument[2], argument[3], 
														 argument[4]);
									_value = [_value1, argument[2], argument[3], argument[4]];
								break;
								
								default:
									exit;
								break;
							}
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
			}
			
			// @argument			{string} uniform
			// @argument			{real[]} array?
			// @description			Pass the currently set matrix or an array of its values
			//						to this Shader's uniform.
			static setUniform_matrix = function(_uniform, _array)
			{
				if (compiled)
				{
					if (_uniform != undefined)
					{
						var _value;
						var _handle = shader_get_uniform(ID, _uniform);
						
						if (_array != undefined)
						{
							shader_set_uniform_matrix_array(_uniform, _array);
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
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{string} uniform
			// @returns				{sampler|undefined}
			// @description			Get a sampler of this Shader's uniform.
			//						Returns {undefined} if this Shader is not compiled.
			static getSampler = function(_uniform)
			{
				return ((compiled) ? shader_get_sampler_index(ID, _uniform) : undefined);
			}
			
			// @returns				{bool}
			// @description			Check whether this Shader is the currently set one.
			static isCurrent = function()
			{
				return ((compiled) ? shader_current() == ID : false);
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{bool} active
			// @description			Set this Shader as the currently used one or inactive.
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
			}
			
		#endregion
	#endregion
	#region [Constructor]
		
		ID = _shader;
		name = shader_get_name(ID);
		compiled = shader_is_compiled(ID);
		uniform = {};
		
	#endregion
}