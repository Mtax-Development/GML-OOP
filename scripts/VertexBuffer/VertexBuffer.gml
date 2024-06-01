//  @function				VertexBuffer()
/// @description			Constructs a Vertex Buffer for storing and rendering vertices as primitive
///							shapes alongside a Vertex Format and a Shader. Used to achieve fast render
///							times, particularly for static graphics.
function VertexBuffer() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				ID = vertex_create_buffer();
				active = false;
				readOnly = false;
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			///						NOTE: Returned result is approximate, as there is no way to fully
			///							  validate a Vertex Buffer.
			static isFunctional = function()
			{
				return (is_handle(ID));
			}
			
			/// @returns			{undefined}
			/// @description		Remove the internal information from the memory.
			static destroy = function()
			{
				if (self.isFunctional())
				{
					try
					{
						vertex_delete_buffer(ID);
					}
					catch (_exception)
					{
						new ErrorReport().report([other, self, "destroy()"], _exception);
					}
					
					ID = undefined;
				}
				
				return undefined;
			}
			
		#endregion
		#region <Setters>
			
			/// @description		Add position data of a single vertex to this Vertex Buffer.
			static setLocation = function(_location)
			{
				try
				{
					vertex_position(ID, _location.x, _location.y);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setLocation()"], _exception);
				}
				
				return self;
			}
			
			/// @description		Add color and alpha data of a single vertex to this Vertex Buffer.
			static setColor = function(_color, _alpha = 1)
			{
				try
				{
					vertex_color(ID, _color, _alpha);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setColor()"], _exception);
				}
				
				return self;
			}
			
			/// @description		Add texture coordinate data of a single vertex to this Vertex
			///						Buffer.
			static setUV = function(_u = 0, _v = 0)
			{
				try
				{
					vertex_texcoord(ID, _u, _v);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setUV()"], _exception);
				}
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			/// @argument			primitive_type {constant:pr_*}
			/// @argument			texture? {pointer|int:-1}
			/// @description		Draw vertices contained in this Vertex Buffer to the currently
			///						active Surface, using the specified primitive type and either the
			///						specified or no texture, provided following requirements are met:
			///						 - A number of vertices appropriate for the specified primitive
			///						   type is contained in this Vertex Buffer.
			///						 - Vertices were added to this Vertex Buffer with the same number
			///						   and order of types of primitive data as in used Vertex Format.
			///						 - A Shader is currently active to operate exact the number and
			///						   types of primitive data used in Vertex Format.
			static render = function(_primitive_type, _texture = -1)
			{
				try
				{
					vertex_submit(ID, _primitive_type, _texture);
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "render()"], _exception);
				}
			}
			
			/// @argument			target {VertexFormat|bool:false}
			/// @description		Set whether a primitive is currently being written to this Vertex
			///						Buffer by specifying its Vertex Format or false to finish it.
			///						Each type of primitive data used with the specified Vertex Format
			///						must be added and it must be done so in the same order as specified
			///						in the Vertex Format.
			static setActive = function(_target)
			{
				try
				{
					if (is_instanceof(_target, VertexFormat)) and (is_handle(_target.ID))
					{
						vertex_begin(ID, _target.ID);
						
						active = true;
					}
					else if (_target == false)
					{
						vertex_end(ID);
						
						active = false;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "setActive()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			primitiveType {constant:pr_*}
			/// @argument			vertexFormat? {VertexFormat}
			/// @argument			texture? {pointer|int:-1}
			/// @returns			{VertexBuffer.PrimitiveRenderData} | On error: {noone}
			/// @description		Return a constructor containing the specified rendering information
			///						of this Vertex Buffer.
			static createPrimitiveRenderData = function(_primitiveType, _format, _texture)
			{
				if (self.isFunctional())
				{
					return new PrimitiveRenderData(_primitiveType, _format, _texture);
				}
				else
				{
					new ErrorReport().report([other, self, "createPrimitiveRenderData()"],
											 ("Attempted to create render data of an invalid Vertex" +
											  "Buffer: " + "{" + string(ID) + "}"));
					
					return noone;
				}
			}
			
			/// @description		Move the contents of this Vertex Buffer to VRAM for faster access
			///						to its information during rendering by preventing further changes.
			///						Intended mainly for Vertex Buffers containing a lot of data.
			static makeReadOnly = function()
			{
				try
				{
					if ((!readOnly) and (vertex_freeze(ID) == 0))
					{
						readOnly = true;
					}
				}
				catch (_exception)
				{
					new ErrorReport().report([other, self, "makeReadOnly()"], _exception);
				}
				
				return self;
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented by the data of this Vertex Buffer.
			static toString = function(_multiline = false)
			{
				if (self.isFunctional())
				{
					try
					{
						var _mark_separator = ((_multiline) ? "\n" : ", ");
						var _string = ("Vertex Count: " + string(vertex_get_number(ID)) +
														+ _mark_separator +
									   "Size: " + string(vertex_get_buffer_size(ID)) + " bytes");
						
						return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
					}
					catch (_) {}
				}
				
				return (instanceof(self) + "<>");
			}
			
		#endregion
	#endregion
	#region [Elements]
		
		//  @function			VertexBuffer.PrimitiveRenderData()
		/// @argument			primitiveType {constant:pr_*}
		/// @argument			vertexFormat? {VertexFormat}
		/// @argument			texture? {pointer|int:-1}
		/// @description		Constructs an element storing Vertex Buffer rendering information.
		//						
		//						Construction types:
		//						- New element
		function PrimitiveRenderData() constructor
		{
			#region [[Static Variables]]
				
				static passthroughFormat = new VertexFormat(vertex_format_add_position,
															vertex_format_add_color,
															vertex_format_add_texcoord);
				
			#endregion
			#region [[Methods]]
				#region <<Management>>
					
					/// @description		Initialize this constructor.
					static construct = function()
					{
						vertexBuffer = other;
						primitiveType = argument[0];
						vertexFormat = ((argument_count > 1) ? argument[1] : passthroughFormat);
						texture = ((argument_count > 2) ? argument[2] : -1);
					}
					
				#endregion
				#region <<Execution>>
					
					/// @description		Draw the contents of the Vertex Buffer to the currently
					///						active Surface through the currently active Shader.
					static render = function()
					{
						vertexBuffer.render(primitiveType, texture);
					}
					
				#endregion
			#endregion
			#region [[Constructor]]
				
				static constructor = function() {with (other) {return PrimitiveRenderData;}}();
				
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
		
	#endregion
	#region [Constructor]
		
		static constructor = VertexBuffer;
		
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
