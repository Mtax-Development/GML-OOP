//  @function				VertexFormat()
/// @description			Constructs a resource designating types of data used in rendering
///							primitives through a Vertex Buffer and a Shader.
//							
//							Construction types:
//							- New format: dataTypeAddFunction... {function:vertex_format_add_*}
//							- Empty: {void|undefined}
function VertexFormat() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				ID = undefined;
				source = [];
				
				if ((argument_count > 0) and (argument[0] != undefined))
				{
					source = array_create(argument_count, undefined);
					
					vertex_format_begin();
					{
						var _i = 0;
						repeat (argument_count)
						{
							script_execute(argument[_i]);
							source[_i] = argument[_i];
							
							++_i;
						}
					}
					ID = vertex_format_end();
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			static isFunctional = function()
			{
				if ((is_handle(ID)) and (is_array(source)))
				{
					var _locationExists = false;
					var _i = 0;
					repeat (array_length(source))
					{
						var _source = source[_i];
						
						if (is_callable(_source))
						{
							if ((_source == vertex_format_add_position)
							or (_source == vertex_format_add_position_3d))
							{
								_locationExists = true;
							}
							else
							{
								switch (_source)
								{
									case vertex_format_add_color:
									case vertex_format_add_position:
									case vertex_format_add_position_3d:
									case vertex_format_add_texcoord:
									case vertex_format_add_normal:
									case vertex_format_add_custom:
									break;
									default: return false; break;
								}
							}
						}
						else
						{
							return false;
						}
						
						++_i;
					}
					
					return _locationExists;
				}
				
				return false;
			}
			
			/// @returns			{undefined}
			/// @description		Remove the internal information from the memory.
			static destroy = function()
			{
				if (is_handle(ID))
				{
					vertex_format_delete(ID);
					
					ID = undefined;
				}
				
				return undefined;
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented by types of data in this Vertex Format.
			static toString = function(_multiline = false)
			{
				if (self.isFunctional())
				{
					var _mark_separator = ((_multiline) ? "\n" : ", ");
					var _string = "";
					var _i = 0;
					repeat (array_length(source))
					{
						if (_i != 0)
						{
							_string += _mark_separator;
						}
						
						switch (source[_i])
						{
							case vertex_format_add_color: _string += "Color"; break;
							case vertex_format_add_position:  _string += "Location"; break;
							case vertex_format_add_position_3d:  _string += "3D Location"; break;
							case vertex_format_add_texcoord: _string += "UV"; break;
							case vertex_format_add_normal: _string += "Normal"; break;
							case vertex_format_add_custom: _string += "Custom"; break;
						}
						
						++_i;
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
		
		static constructor = VertexFormat;
		
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
