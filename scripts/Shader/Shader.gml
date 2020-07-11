// @function				Shader()
// @argument				{shader} shader
// @description				Constructs a Shader resource, which can be used to alter drawing.
function Shader(_shader) constructor
{
	#region [Methods]
		#region <Setters>
			
			// @argument			{uniform|string} uniform
			// @argument			{real|real[]} value1?
			// @argument			{real} value2?
			// @argument			{real} value3?
			// @argument			{real} value4?
			// @description			Pass float-type value(s) to this Shader's uniform.
			static setUniform_float = function(_uniform, _value1)
			{
				if (compiled)
				{
					if (_uniform != undefined)
					{
						if (is_string(_uniform))
						{
							_uniform = shader_get_uniform(ID, _uniform);
						}
						
						switch (argument_count)
						{
							case 2:
								if (is_array(_value1))
								{
									shader_set_uniform_f_array(_uniform, _value1);
								}
								else
								{
									shader_set_uniform_f(_uniform, _value1);
								}
							break;
							
							case 3:
								shader_set_uniform_f(_uniform, _value1, argument[2]);
							break;
							
							case 4:
								shader_set_uniform_f(_uniform, _value1, argument[2], argument[3]);
							break;
							
							case 5:
								shader_set_uniform_f(_uniform, _value1, argument[2], argument[3], 
													 argument[4]);
							break;
						}
					}
				}
			}
			
			// @argument			{uniform|string} uniform
			// @argument			{int|int[]} value1?
			// @argument			{int} value2?
			// @argument			{int} value3?
			// @argument			{int} value4?
			// @description			Pass int-type value(s) to this Shader's uniform.
			static setUniform_int = function(_uniform, _value1)
			{
				if (compiled)
				{
					if (_uniform != undefined)
					{
						if (is_string(_uniform))
						{
							_uniform = shader_get_uniform(ID, _uniform);
						}
						
						switch (argument_count)
						{
							case 2:
								if (is_array(_value1))
								{
									shader_set_uniform_i_array(_uniform, _value1);
								}
								else
								{
									shader_set_uniform_i(_uniform, _value1);
								}
							break;
							
							case 3:
								shader_set_uniform_i(_uniform, _value1, argument[2]);
							break;
							
							case 4:
								shader_set_uniform_i(_uniform, _value1, argument[2], argument[3]);
							break;
							
							case 5:
								shader_set_uniform_i(_uniform, _value1, argument[2], argument[3], 
													 argument[4]);
							break;
						}
					}
				}
			}
			
			// @argument			{uniform|string} uniform
			// @argument			{real[]} array?
			// @description			Pass the currently set matrix or an array of its values
			//						to this Shader's uniform.
			static setMatrix = function(_uniform, _array)
			{
				if (compiled)
				{
					if (_uniform != undefined)
					{
						if (is_string(_uniform))
						{
							_uniform = shader_get_uniform(ID, _uniform);
						}
						
						if (_array != undefined)
						{
							shader_set_uniform_matrix_array(_uniform, _array);
						}
						else
						{
							shader_set_uniform_matrix(_uniform);
						}
					}
				}
			}
			
		#endregion
		#region <Getters>
			
			// @argument			{string} uniform
			// @returns				{uniform|undefined}
			// @description			Get a handle of this Shader's uniform.
			//						Returns {undefined} if this Shader is not compiled.
			static getUniform = function(_uniform)
			{
				return ((compiled) ? shader_get_uniform(ID, _uniform) : undefined);
			}
			
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
		
	#endregion
}