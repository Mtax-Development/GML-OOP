//  @function				Shader()
/// @argument				shader {int:shader}
/// @description			Constructs a Shader Resource used to alter graphical rendering with
///							GLSL or HLSL code executed by the Graphics Processing Unit.
///							Values in its code can be set through Uniforms, the copy of which is then
///							saved in a property with the same property name in the uniform struct of
///							this constructor. They are contained in the Uniform constructors, used to
///							further update their values.
///							Values set while a Shader is not active will be ignored by its code.
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
				
				var _scope = self;
				event =
				{
					beforeActivation: new Callback(undefined, [], _scope),
					afterActivation: new Callback(undefined, [], _scope),
					beforeDeactivation: new Callback(undefined, [], _scope),
					afterDeactivation: new Callback(undefined, [], _scope),
				};
				
				if ((argument_count > 0) and (argument[0] != undefined) and (argument[0] != (-1)))
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
								var _value_current = _other_struct.value;
								
								if (is_array(_other_struct.value))
								{
									_value_current = [];
									array_copy(_value_current, 0, _other_struct.value, 0,
											   array_length(_other_struct));
								}
								
								var _struct = 
								{
									handle: _other_struct.handle,
									type: _other_struct.type,
									value: _value_current
								};
								
								variable_struct_set(uniform, _uniform[_i], _struct);
								
								++_i;
							}
						}
						else
						{
							uniform = _other.uniform;
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
			
			/// @returns			{bool}
			/// @description		Check whether this Shader is the currently set one.
			static isActive = function()
			{
				return ((shader_is_compiled(ID)) ? (shader_current() == ID) : false);
			}
			
		#endregion
		#region <Setters>
			
			/// @argument			uniform {string}
			/// @argument			value1 {real|real[]|Vector2|Vector3}
			/// @argument			value2? {real}
			/// @argument			value3? {real}
			/// @argument			value4? {real}
			/// @description		Use the specified uniform to pass to this Shader one or more
			///						floating-point numbers. If only one value argument is passed, it
			///						can be an array, Vector2 or a Vector3. Otherwise all value
			///						arguments have to be numbers.
			static setUniformFloat = function(_uniform)
			{
				try
				{
					var _handle = shader_get_uniform(ID, _uniform);
					
					if (_handle >= 0)
					{
						var _value = undefined;
						
						if (argument_count > 2)
						{
							var _value_count = (argument_count - 1);
							_value = array_create(_value_count, undefined);
							var _i = 0;
							repeat (_value_count)
							{
								_value[_i] = argument[(_i + 1)];
								
								++_i;
							}
						}
						else
						{
							var _value_candidate = argument[1];
							
							if (is_array(_value_candidate))
							{
								_value = _value_candidate;
							}
							else if (is_numeric(_value_candidate))
							{
								_value = [real(_value_candidate)];
							}
							else if ((is_instanceof(_value_candidate, Vector2))
							or (is_instanceof(_value_candidate, Vector3)))
							{
								_value = _value_candidate.toArray();
							}
							else
							{
								new ErrorReport().report
								(
									[other, self, "setUniformFloat()"],
									("Attempted to set an uniform using an unrecognized data " +
									 "type:" + "\n" +
									 "Shader: " + "{" + string(name) + "}" + "\n" +
									 "Uniform: " + "{" + string(_uniform) + "}" + "\n" +
									 "Value: " + "{" + string(_value_candidate) + "}")
								);
								
								return self;
							}
						}
						
						script_execute_ext(shader_set_uniform_f_array, [_handle, _value]);
						
						self.createUniformData(_uniform, _handle, "float", _value,
											   shader_set_uniform_f_array);
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setUniformFloat()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			uniform {string}
			/// @argument			value1 {int|int[]|Vector2|Vector3}
			/// @argument			value2? {int}
			/// @argument			value3? {int}
			/// @argument			value4? {int}
			/// @description		Use the specified uniform to pass to this Shader one or more
			///						integer numbers. If only one value argument is passed, it can be an
			///						array, Vector2 or a Vector3. Otherwise all value arguments have to
			///						be numbers.
			static setUniformInt = function(_uniform)
			{
				try
				{
					var _handle = shader_get_uniform(ID, _uniform);
					
					if (_handle >= 0)
					{
						var _value = undefined;
						
						if (argument_count > 2)
						{
							var _value_count = (argument_count - 1);
							_value = array_create(_value_count, undefined);
							var _i = 0;
							repeat (_value_count)
							{
								_value[_i] = argument[(_i + 1)];
								
								++_i;
							}
						}
						else
						{
							var _value_candidate = argument[1];
							
							if (is_array(_value_candidate))
							{
								_value = _value_candidate;
							}
							else if (is_numeric(_value_candidate))
							{
								_value = [real(_value_candidate)];
							}
							else if ((is_instanceof(_value_candidate, Vector2))
							or (is_instanceof(_value_candidate, Vector3)))
							{
								_value = _value_candidate.toArray();
							}
							else
							{
								new ErrorReport().report
								(
									[other, self, "setUniformInt()"],
									("Attempted to set an uniform using an unrecognized data " +
									 "type:" + "\n" +
									 "Shader: " + "{" + string(name) + "}" + "\n" +
									 "Uniform: " + "{" + string(_uniform) + "}" + "\n" +
									 "Value: " + "{" + string(_value_candidate) + "}")
								);
								
								return self;
							}
						}
						
						script_execute_ext(shader_set_uniform_i_array, [_handle, _value]);
						
						self.createUniformData(_uniform, _handle, "int", _value,
											   shader_set_uniform_i_array);
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
			/// @description		Use the specified uniform to pass to this Shader either the
			///						specified matrix values or the ones of currently set transform
			///						matrix.
			static setUniformMatrix = function(_uniform, _value)
			{
				try
				{
					var _handle = shader_get_uniform(ID, _uniform);
					
					if (_handle >= 0)
					{
						var _updateFunction = undefined;
						
						if (is_array(_value))
						{
							shader_set_uniform_matrix_array(_handle, _value);
							
							self.createUniformData(_uniform, _handle, "matrix", [_value],
												   shader_set_uniform_matrix_array);
						}
						else
						{
							shader_set_uniform_matrix(_handle);
							
							self.createUniformData(_uniform, _handle, "matrix", undefined);
						}
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setUniformMatrix()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			uniform {string}
			/// @argument			texture? {pointer:texture}
			/// @description		Use the specified sampler uniform to pass to this Shader the
			///						specified pointer to a texture.
			static setUniformTexture = function(_uniform, _texture)
			{
				try
				{
					var _handle = shader_get_sampler_index(ID, _uniform);
					
					if (_handle >= 0)
					{
						texture_set_stage(_handle, _texture);
						
						self.createUniformData(_uniform, _handle, "sampler", [_texture],
											   texture_set_stage);
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setUniformTexture()"], _exception);
				}
				
				return self;
			}
			
			/// @description		Pass to this Shader values contained in uniform struct through
			///						uniforms with the same name as its properties.
			static updateUniforms = function()
			{
				try
				{
					struct_foreach(uniform, function(_name, _value)
					{
						try
						{
							_value.update();
						}
						catch (_exception)
						{
							new ErrorReport().report([other, self, "updateUniforms()"], _exception);
						}
					});
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "updateUniforms()"], _exception);
				}
				
				return self;
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
			
			/// @argument			uniform {string}
			/// @argument			handle {int}
			/// @argument			type {string}
			/// @argument			value {int[]|real[]|pointer:texture[]}
			/// @argument			updateFunction? {function:shader_set_uniform_*_array
			///										 |function:texture_set_stage}
			/// @description		Create a Uniform Handler containing specified data of a uniform
			///						of this Shader, through which its values can be updated.
			static createUniformData = function(_uniform, _handle, _type, _value, _updateFunction)
			{
				try
				{
					variable_struct_set(uniform, _uniform,
										new Uniform(_uniform, _handle, _type, _value,
													_updateFunction));
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "createUniformData()"], _exception);
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
	#region [Elements]
		
		//  @function			Shader.Uniform()
		/// @argument			name {string}
		/// @argument			handle {int}
		/// @argument			type {string}
		/// @argument			value {int[]|real[]|pointer:texture[]}
		/// @argument			updateFunction? {function:shader_set_uniform_*_array
		///										 |function:texture_set_stage}
		/// @description		Constructs a Handler with properties of a single Uniform used to
		///						update values within its parent Shader.
		//						
		//						Construction types:
		//						- New element
		function Uniform() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					/// @description		Initialize this constructor.
					static construct = function()
					{
						//|Construction type: New element.
						parent = other;
						name = argument[0];
						handle = argument[1];
						type = argument[2];
						value = argument[3];
						updateFunction = ((argument_count > 4) ? argument[4] : function() {})
					}
					
					/// @returns			{bool}
					/// @description		Check if this constructor is functional.
					static isFunctional = function()
					{
						return ((is_real(handle)) and (handle >= 0));
					}
					
				#endregion
				#region <<Execution>>
					
					/// @argument			value? {int[]|real[]|pointer:texture[]}
					/// @description		Set the uniform value within the Shader to the specified
					///						or current value of this constructor if that Shader is
					///						currently active. The value must be an array in the format
					///						of executable arguments for a function call.
					static update = function(_value = value)
					{
						try
						{
							value = _value;
							
							script_execute_ext(updateFunction, [handle, value]);
						}
						catch (_exception)
						{
							if (!is_array(value))
							{
								new ErrorReport().report([other, parent, "uniform", string(name),
														  "update()"],
														 ("Attempted to execute the update " + 
														  "function using a value that is not an " +
														  "array: " + "{" + string(value) + "}"));
							}
							else
							{
								new ErrorReport().report([other, parent, "uniform", string(name),
														  "update()"], _exception);
							}
						}
						
						return self;
					}
					
				#endregion
				#region <<Conversion>>
					
					/// @argument			multiline? {bool}
					/// @argument			full? {bool}
					/// @returns			{string}
					/// @description		Create a string representing this constructor.
					///						Overrides the string() conversion.
					///						Content will be represented with the properties of this
					///						constructor.
					static toString = function(_multiline = false, _full = false)
					{
						var _constructorName = "Shader.Uniform";
						
						if (self.isFunctional())
						{
							var _mark_separator = ((_multiline) ? "\n" : ", ");
							var _string = "";
							
							if (!_full)
							{
								_string = ("Name: " + string(name) + _mark_separator +
										   "Value: " + string(value));
							}
							else
							{
								_string = ("Name: " + string(name) + _mark_separator +
										   "Handle: " + string(handle) + _mark_separator +
										   "Type: " + string(type) + _mark_separator +
										   "Value: " + string(value));
							}
							
							return ((_multiline) ? _string
												 : (_constructorName + "(" + _string + ")"));
						}
						else
						{
							return (_constructorName + "<>");
						}
					}
					
				#endregion
			#endregion
			#region [[Constructor]]
				
				static constructor = function(_parent)
				{
					with (_parent)
					{
						return Uniform;
					}
				}(other);
				
				static prototype = {};
				var _property = variable_struct_get_names(prototype);
				var _i = 0;
				repeat (array_length(_property))
				{
					var _name = _property[_i];
					var _value = variable_struct_get(prototype, _name);
					
					variable_struct_set(self, _name, ((is_method(_value)) ? method(self, _value)
																		  : _value));
					
					++_i;
				}
				
				var _argument = array_create(argument_count, undefined);
				var _i = 0;
				repeat (argument_count)
				{
					_argument[_i] = argument[_i];
					
					++_i;
				}
				
				script_execute_ext(self.construct, _argument);
				
			#endregion
		}
		
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
		
		var _argument = array_create(argument_count, undefined);
		var _i = 0;
		repeat (argument_count)
		{
			_argument[_i] = argument[_i];
			
			++_i;
		}
		
		script_execute_ext(self.construct, _argument);
		
	#endregion
}
