//  @function				Shader()
/// @argument				shader {int:shader}
/// @description			Constructs a Shader resource used to alter drawing.
//							
//							Construction types:
//							- New constructor
//							- Empty: {void|undefined}
//							- Constructor copy: other {Shader}
function Shader() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				ID = undefined;
				name = undefined;
				compiled = undefined;
				uniform = undefined;
				sampler = undefined;
				
				event =
				{
					beforeActivation: new Callback(undefined, [], other),
					afterActivation: new Callback(undefined, [], other),
					beforeDeactivation: new Callback(undefined, [], other),
					afterDeactivation: new Callback(undefined, [], other),
				};
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					if (is_instanceof(argument[0], Shader))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						ID = _other.ID;
						name = _other.name;
						compiled = _other.compiled;
						
						if (is_struct(_other.uniform))
						{
							uniform = {};
							
							var _uniform = variable_struct_get_names(_other.uniform);
							var _i = 0;
							repeat (array_length(_uniform))
							{
								var _other_struct = variable_struct_get(_other.uniform, _uniform[_i]);
								
								var _struct = 
								{
									handle: _other_struct.handle,
									type: _other_struct.type,
									value: ((is_array(_other_struct.value))
											? array_copy([], 0, _other_struct.value, 0,
														 array_length(_other_struct))
											: _other_struct.value)
								};
								
								variable_struct_set(uniform, _uniform[_i], _struct);
								
								++_i;
							}
						}
						else
						{
							uniform = _other.uniform;
						}
						
						if (is_struct(_other.sampler))
						{
							sampler = {};
							
							var _sampler = variable_struct_get_names(_other.sampler);
							var _i = 0;
							repeat (array_length(_sampler))
							{
								var _other_struct = variable_struct_get(uniform, _uniform[_i]);
								var _struct = 
								{
									handle: _other_struct.handle
								};
								
								variable_struct_set(sampler, _sampler[_i], _struct);
								
								++_i;
							}
						}
						else
						{
							sampler = _other.sampler;
						}
						
						if (is_struct(_other.event))
						{
							event.beforeActivation.setAll(_other.event.beforeActivation);
							event.afterActivation.setAll(_other.event.afterActivation);
							event.beforeDeactivation.setAll(_other.event.beforeDeactivation);
							event.afterDeactivation.setAll(_other.event.afterDeactivation);
						}
						else
						{
							event = _other.event;
						}
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
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_handle(ID)) and (shader_is_compiled(ID)));
			}
			
		#endregion
		#region <Getters>
			
			/// @argument			uniform {string}
			/// @returns			{int} | On error: {undefined}
			/// @description		Get a sampler index of a uniform from this Shader
			static getSampler = function(_uniform)
			{
				if (self.isFunctional())
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
					new ErrorReport().report([other, self, "getSampler()"],
											 ("Attempted to use an invalid Shader: " +
											  "{" + string(ID) + "}"));
					
					return undefined;
				}
			}
			
			/// @returns			{bool}
			/// @description		Check whether this Shader is the currently set one.
			static isActive = function()
			{
				return ((shader_is_compiled(ID)) ? (shader_current() == ID) : false);
			}
			
		#endregion
		#region <Setters>
			
			/// @argument			uniform {string}
			/// @argument			value1 {real|real[]|Vector2}
			/// @argument			value2? {real}
			/// @argument			value3? {real}
			/// @argument			value4? {real}
			/// @description		Pass one or more float-type numbers as a uniform to this Shader.
			///						If only one value argument is passed, it can be an array or
			///						Vector2. Otherwise all value arguments have to be numbers.
			static setUniformFloat = function(_uniform)
			{
				try
				{
					if (self.isFunctional())
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
								else if (is_instanceof(_value, Vector2))
								{
									shader_set_uniform_f(_handle, _value.x, _value.y);
								}
								else
								{
									new ErrorReport().report([other, self, "setUniformFloat()"],
															  ("Attempted to set an uniform using " +
															   "an unrecognized data type:" + "\n" +
															   "Shader: " + "{" + string(name) + "}" +
															   "\n" + "Data: " + "{" + string(_value) +
																"}"));
									
									return self;
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
								
								shader_set_uniform_f(_handle, _value[0], _value[1], _value[2],
													 _value[3]);
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
						new ErrorReport().report([other, self, "setUniformFloat()"],
												 ("Attempted to use an invalid Shader: " +
												  "{" + string(ID) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setUniformFloat()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			uniform {string}
			/// @argument			value1 {int|int[]|Vector2}
			/// @argument			value2? {int}
			/// @argument			value3? {int}
			/// @argument			value4? {int}
			/// @description		Pass one or more integer values as a uniform to this Shader.
			///						If only one value argument is passed, it can be an array or
			///						Vector2. Otherwise all value arguments have to be numbers.
			static setUniformInt = function(_uniform)
			{
				try
				{
					if (self.isFunctional())
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
								else if (is_instanceof(_value, Vector2))
								{
									shader_set_uniform_i(_handle, _value.x, _value.y);
								}
								else
								{
									new ErrorReport().report([other, self, "setUniformInt()"],
															  ("Attempted to set an uniform using " +
															   "an unrecognized data type:" + "\n" +
															   "Shader: " + "{" + string(name) + "}" +
															   "\n" + "Data: " + "{" + string(_value) +
																"}"));
									
									return self;
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
								
								shader_set_uniform_i(_handle, _value[0], _value[1], _value[2],
													 _value[3]);
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
						new ErrorReport().report([other, self, "setUniformInt()"],
												 ("Attempted to use an invalid Shader: " +
												  "{" + string(ID) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setUniformInt()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			uniform {string}
			/// @argument			value? {real[]}
			/// @description		Pass the currently set matrix or an array of its values as a
			///						uniform to this Shader.
			static setUniformMatrix = function(_uniform, _value)
			{
				try
				{
					if (self.isFunctional())
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
						new ErrorReport().report([other, self, "setUniformMatrix()"],
												 ("Attempted to use an invalid Shader: " +
												  "{" + string(ID) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setUniformMatrix()"], _exception);
				}
				
				return self;
			}
			
			/// @description		Update the uniforms in this Shader with all values held by the
			///						uniform struct.
			static updateUniforms = function()
			{
				try
				{
					var _uniform = variable_struct_get_names(uniform);
					var _i = 0;
					repeat (array_length(_uniform))
					{
						try
						{
							var _struct = variable_struct_get(uniform, _uniform[_i]);
							var _value_array = (is_array(_struct.value) ? _struct.value
																		: [_struct.value]);
							var _argument = [_uniform[_i]];
							array_copy(_argument, 1, _value_array, 0, array_length(_value_array));
							
							switch (_struct.type)
							{
								case "float":
									script_execute_ext(method_get_index(self.setUniformFloat),
													   _argument);
								break;
								
								case "int":
									script_execute_ext(method_get_index(self.setUniformInt),
													   _argument);
								break;
								
								case "matrix":
									script_execute_ext(method_get_index(self.setUniformMatrix),
													   _argument);
								break;
							}
						}
						catch (_exception)
						{
							new ErrorReport().report([other, self, "updateUniforms()"], _exception);
						}
						
						++_i;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "updateUniforms()"], _exception);
				}
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			target {bool}
			/// @description		Set whether this Shader is currently applied.
			static setActive = function(_target)
			{
				try
				{
					if (self.isFunctional())
					{
						switch (_target)
						{
							case true:
								event.beforeActivation.execute();
								shader_set(ID);
								event.afterActivation.execute();
							break;
							case false:
								if (shader_current() == ID)
								{
									event.beforeDeactivation.execute();
									shader_reset();
									event.afterDeactivation.execute();
								}
							break;
						}
					}
					else
					{
						new ErrorReport().report([other, self, "setActive()"],
												 ("Attempted to use a Shader that is not compiled: " +
												  "{" + string(name) + "}"));
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setActive()"], _exception);
				}
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented with the name of this Shader.
			///						If this Shader is not compiled, it will be marked as such.
			static toString = function(_multiline = false)
			{
				if (is_handle(ID))
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
		
		static constructor = Shader;
		
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
