//  @function				Camera()
/// @description			Constructs a Camera Resource, used to project part of a three-dimensional
///							scene.
//							
//							Construction types:
//							- New constructor
//							- Wrapper: name {int:camera}
//							- Empty: {void|undefined}
//							- Constructor copy: other {Camera}
function Camera() constructor
//  @feather	ignore all
{
	#region [Methods]
		#region <Management>
			
			/// @description		Initialize this constructor.
			static construct = function()
			{
				//|Construction type: Empty.
				ID = undefined;
				projectionMatrix = undefined;
				viewMatrix = undefined;
				
				if (argument_count > 0)
				{
					if (is_instanceof(argument[0], Camera))
					{
						//|Construction type: Constructor copy.
						var _other = argument[0];
						
						if (is_instanceof(_other.projectionMatrix, OrtographicProjectionMatrix))
						{
							projectionMatrix = new OrtographicProjectionMatrix(_other
																				.projectionMatrix);
						}
						else if (is_instanceof(_other.projectionMatrix,
											   PerspectiveFieldOfViewProjectionMatrix))
						{
							projectionMatrix =
							 new PerspectiveFieldOfViewProjectionMatrix(_other.projectionMatrix);
						}
						else
						{
							projectionMatrix = _other.projectionMatrix;
						}
						
						viewMatrix = ((is_instanceof(_other.viewMatrix, ViewMatrix))
									  ? new ViewMatrix(_other.viewMatrix) : _other.viewMatrix);
						
						ID = camera_create();
						camera_copy_transforms(ID, _other.ID);
					}
					else if (is_real(argument[0]))
					{
						//|Construction type: Wrapper.
						ID = argument[0];
					}
				}
				else
				{
					//|Construction type: New constructor.
					ID = camera_create();
				}
				
				return self;
			}
			
			/// @returns			{bool}
			/// @description		Check if this constructor is functional.
			///						NOTE: Returned result is approximate, as there is no way to
			///							  directly validate a Camera.
			static isFunctional = function()
			{
				return is_real(ID);
			}
			
			/// @returns			{undefined}
			/// @description		Remove the internal information from the memory.
			static destroy = function()
			{
				if (self.isFunctional())
				{
					camera_destroy(ID);
					
					ID = undefined;
				}
				
				return undefined;
			}
			
		#endregion
		#region <Execution>
			
			/// @description		Make this Camera use settings it has been set in rendering.
			static applySettings = function()
			{
				try
				{
					if (is_struct(projectionMatrix))
					{
						camera_set_proj_mat(ID, projectionMatrix.build().ID);
					}
					
					if (is_instanceof(viewMatrix, ViewMatrix))
					{
						camera_set_view_mat(ID, viewMatrix.build().ID);
					}
					
					camera_apply(ID);
				}
				catch (_exception)
				{
					ErrorReport.report([other, self, "applySettings()"], _exception);
				}
				
				return self;
			}
			
			/// @argument			size {Vector2}
			/// @argument			clippingPlane {Range}
			/// @returns			{Camera.OrtographicProjectionMatrix}
			/// @description		Create and assign to this Camera the first of matrices needed to
			///						display graphics, the projection matrix. This projection does not
			///						contain perspective information, making the view ortographic.
			///						Specified values change how much of the scene is fit into the
			///						projection, according to size affecting its aspect ratio and zoom,
			///						as well as the clipping plane cutting out graphics outside of it.
			static createOrtographicProjectionMatrix = function(_size, _clippingPlane)
			{
				try
				{
					if (self.isFunctional())
					{
						projectionMatrix = new OrtographicProjectionMatrix(_size, _clippingPlane);
						
						return projectionMatrix;
					}
					else
					{
						ErrorReport.report([other, self, "createOrtographicProjectionMatrix()"],
										   ("Attempted to add a projection matrix to an invalid " +
											"Camera: " +
											"{" + string(ID) + "}"));
					}
				}
				catch (_exception)
				{
					ErrorReport.report([other, self, "createOrtographicProjectionMatrix()"],
									   _exception);
				}
				
				return noone;
			}
			
			/// @argument			size {Vector2}
			/// @argument			clippingPlane {Range}
			/// @returns			{Camera.PerspectiveProjectionMatrix}
			/// @description		Create and assign to this Camera the first of matrices needed to
			///						display graphics, the projection matrix. This projection contains
			///						perspective information. Specified values change how much of the
			///						scene is fit into the projection, according to size stretching
			///						either dimension of rendering result and a clipping plane cutting
			///						out graphics outside of it.
			static createPerspectiveProjectionMatrix = function(_size, _clippingPlane)
			{
				try
				{
					if (self.isFunctional())
					{
						projectionMatrix = new PerspectiveProjectionMatrix(_size, _clippingPlane);
						
						return projectionMatrix;
					}
					else
					{
						ErrorReport.report([other, self, "createPerspectiveProjectionMatrix()"],
										   ("Attempted to add a projection matrix to an invalid " +
											"Camera: " +
											"{" + string(ID) + "}"));
					}
				}
				catch (_exception)
				{
					ErrorReport.report([other, self, "createPerspectiveProjectionMatrix()"],
									   _exception);
				}
				
				return noone;
			}
			
			/// @argument			fieldOfView {Angle}
			/// @argument			aspectRatio {real}
			/// @argument			clippingPlane {Range}
			/// @returns			{Camera.PerspectiveFieldOfViewProjectionMatrix}
			/// @description		Create and assign to this Camera the first of matrices needed to
			///						display graphics, the projection matrix. This projection contains
			///						perspective information. Specified values change how much of the
			///						scene is fit into the projection, according to field of view Angle
			///						affecting how wide the view is, aspect ratio stretching either
			///						dimension of rendering result and a clipping plane cutting out
			///						graphics outside of it.
			static createPerspectiveFieldOfViewProjectionMatrix = function(_fieldOfView,
																		   _clippingPlane,
																		   _aspectRatio)
			{
				try
				{
					if (self.isFunctional())
					{
						projectionMatrix = new PerspectiveFieldOfViewProjectionMatrix(_fieldOfView,
																					  _aspectRatio,
																					  _clippingPlane);
						
						return projectionMatrix;
					}
					else
					{
						ErrorReport.report([other, self,
											"createPerspectiveFieldOfViewProjectionMatrix()"],
											("Attempted to add a projection matrix to an invalid " +
											 "Camera: " +
											 "{" + string(ID) + "}"));
					}
				}
				catch (_exception)
				{
					ErrorReport.report([other, self,
										"createPerspectiveFieldOfViewProjectionMatrix()"],
										_exception);
				}
				
				return noone;
			}
			
			/// @argument			source {Vector3}
			/// @argument			target {Vector3}
			/// @argument			upVector? {Vector3}
			/// @description		Create and assign to this Camera the second of matrices needed to
			///						display graphics, the view matrix. It contains specified location
			///						from where this Camera is heading towards the location it points
			///						to, both orientated around the specified upward vector.
			static createViewMatrix = function(_source, _target, _upVector = new Vector3(0, 1, 0))
			{
				try
				{
					if (self.isFunctional())
					{
						viewMatrix = new ViewMatrix(_source, _target, _upVector);
						
						return viewMatrix;
					}
					else
					{
						ErrorReport.report([other, self, "createViewMatrix()"],
										   ("Attempted to add a view matrix to an invalid Camera: " +
											"{" + string(ID) + "}"));
					}
				}
				catch (_exception)
				{
					ErrorReport.report([other, self, "createViewMatrix()"], _exception);
				}
				
				return noone;
			}
			
		#endregion
		#region <Conversion>
			
			/// @argument			multiline? {bool}
			/// @argument			full? {bool}
			/// @returns			{string}
			/// @description		Create a string representing this constructor.
			///						Overrides the string() conversion.
			///						Content will be represented with the properties of this Camera.
			static toString = function(_multiline = false, _full = false)
			{
				if (self.isFunctional())
				{
					if (_full)
					{
						var _mark_separator = ((_multiline) ? "\n" : ", ");
						var _string = ("ID: " + string(ID) + _mark_separator +
									   "Projection Matrix: " + string(projectionMatrix) +
															 _mark_separator +
									   "View Matrix: " + string(viewMatrix));
						
						return ((_multiline) ? _string 
											 : (instanceof(self) + "(" + _string + ")"));
					}
					else
					{
						return ((_multiline) ? string(ID)
											 : (instanceof(self) + "(" + string(ID) + ")"));
					}
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
		#endregion
	#endregion
	#region [Elements]
		
		//  @function			Camera.OrtographicProjectionMatrix
		/// @argument			size {Vector2}
		/// @argument			clippingPlane {Range}
		/// @description		Constructs a matrix supplying the Camera with two-dimensional
		///						projection.
		//						
		//						Construction types:
		//						- New element
		//						- Empty: {void|undefined}
		//						- Constructor copy: other {Camera.OrtographicProjectionMatrix}
		function OrtographicProjectionMatrix() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					/// @description		Initialize this constructor.
					static construct = function()
					{
						//|Construction type: Empty.
						parent = other;
						ID = undefined;
						size = undefined;
						clippingPlane = undefined;
						
						switch (argument_count)
						{
							case 1:
								if (string_copy(instanceof(argument[0]), 1, 27) ==
									"OrtographicProjectionMatrix")
								{
									//|Construction type: Constructor copy.
									var _other = argument[0];
									
									size = ((is_instanceof(_other.size, Vector2))
											? new Vector2(_other.size) : _other.size);
									clippingPlane = ((is_instanceof(_other.clippingPlane, Range))
													 ? new Range(_other.clippingPlane)
													 : _other.clippingPlane);
								}
							break;
							default:
								//|Construction type: New element.
								size = argument[0];
								clippingPlane = argument[1];
							break;
						}
						
						return self;
					}
					
					/// @returns			{bool}
					/// @description		Check if this constructor is functional.
					static isFunctional = function()
					{
						var _matrix_valid = (ID == undefined);
						
						if (!_matrix_valid)
						{
							if ((is_array(ID)) and (array_length(ID) == 16))
							{
								_matrix_valid = true;
								var _i = 0;
								repeat (16)
								{
									if (!is_real(ID[_i]))
									{
										_matrix_valid = false;
										
										break;
									}
									
									++_i;
								}
							}
						}
						
						return ((_matrix_valid) and ((is_instanceof(size, Vector2)) and
								(size.isFunctional())) and ((is_instanceof(clippingPlane, Range)) and
								(clippingPlane.isFunctional())));
					}
					
				#endregion
				#region <<Execution>>
					
					/// @argument			size? {Vector2}
					/// @argument			clippingPlane? {Range}
					/// @description		Build and assign to this constructor a numeric array
					///						representing projection matrix, using either its
					///						configuration or specified temporarily replaced parts.
					static build = function(_size = size, _clippingPlane = clippingPlane)
					{
						try
						{
							ID = matrix_build_projection_ortho(_size.x, _size.y,
															   _clippingPlane.minimum,
															   _clippingPlane.maximum);
						}
						catch (_exception)
						{
							ErrorReport.report([other, parent, "OrtographicProjectionMatrix",
												"build()"], _exception);
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
					///						matrix.
					static toString = function(_multiline = false, _full = false)
					{
						var _constructorName = "Camera.OrtographicProjectionMatrix";
						
						if (self.isFunctional())
						{
							var _mark_separator = ((_multiline) ? "\n" : ", ");
							var _string_matrix = ((_full) ? ("Matrix: " + string(ID) +
															 _mark_separator)
														  : "");
							var _string = (_string_matrix +
										   "Size: " + string(size) + _mark_separator +
										   "Clipping Plane: " + string(clippingPlane));
							
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
						return OrtographicProjectionMatrix;
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
		
		//  @function			Camera.PerspectiveProjectionMatrix()
		/// @argument			size {Vector2}
		/// @argument			clippingPlane {Range}
		/// @description		Constructs a matrix supplying the Camera with three-dimensional
		///						projection using field of view based on its size and clipping plane.
		//						
		//						Construction types:
		//						- New element
		//						- Empty: {void|undefined}
		//						- Constructor copy: other {Camera.PerspectiveProjectionMatrix}
		function PerspectiveProjectionMatrix() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					/// @description		Initialize this constructor.
					static construct = function()
					{
						//|Construction type: Empty.
						parent = other;
						ID = undefined;
						size = undefined;
						clippingPlane = undefined;
						
						switch (argument_count)
						{
							case 1:
								if (string_copy(instanceof(argument[0]), 1, 27) ==
									"PerspectiveProjectionMatrix")
								{
									//|Construction type: Constructor copy.
									var _other = argument[0];
									
									size = ((is_instanceof(_other.size, Vector2))
											? new Vector2(_other.size) : _other.size);
									clippingPlane = ((is_instanceof(_other.clippingPlane, Range))
													 ? new Range(_other.clippingPlane)
													 : _other.clippingPlane);
								}
							break
							default:
								//|Construction type: New element.
								size = argument[0];
								clippingPlane = argument[1];
							break;
						}
						
						return self;
					}
					
					/// @returns			{bool}
					/// @description		Check if this constructor is functional.
					static isFunctional = function()
					{
						var _matrix_valid = (ID == undefined);
						
						if (!_matrix_valid)
						{
							if ((is_array(ID)) and (array_length(ID) == 16))
							{
								_matrix_valid = true;
								var _i = 0;
								repeat (16)
								{
									if (!is_real(ID[_i]))
									{
										_matrix_valid = false;
										
										break;
									}
									
									++_i;
								}
							}
						}
						
						return ((_matrix_valid) and ((is_instanceof(size, Vector2)) and
								(size.isFunctional())) and ((is_instanceof(clippingPlane, Range)) and
								(clippingPlane.isFunctional())));
					}
					
				#endregion
				#region <<Execution>>
					
					/// @argument			size? {Vector2}
					/// @argument			clippingPlane? {Range}
					/// @description		Build and assign to this constructor a numeric array
					///						representing projection matrix, using either its
					///						configuration or specified temporarily replaced parts.
					static build = function(_size = size, _clippingPlane = clippingPlane)
					{
						try
						{
							ID = matrix_build_projection_perspective(_size.x, _size.y,
																	 _clippingPlane.minimum,
																	 _clippingPlane.maximum)
						}
						catch (_exception)
						{
							ErrorReport.report([other, parent, "PerspectiveProjectionMatrix",
											   "build()"], _exception);
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
					///						matrix.
					static toString = function(_multiline = false, _full = false)
					{
						var _constructorName = "Camera.PerspectiveProjectionMatrix";
						
						if (self.isFunctional())
						{
							var _mark_separator = ((_multiline) ? "\n" : ", ");
							var _string_matrix = ((_full) ? ("Matrix: " + string(ID) +
															 _mark_separator)
														  : "");
							var _string = (_string_matrix +
										   "Size: " + string(size) + _mark_separator +
										   "Clipping Plane: " + string(clippingPlane));
							
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
						return PerspectiveProjectionMatrix;
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
		
		//  @function			Camera.PerspectiveFieldOfViewProjectionMatrix()
		/// @argument			fieldOfView {Angle}
		/// @argument			aspectRatio {real}
		/// @argument			clippingPlane {Range}
		/// @description		Constructs a matrix supplying the Camera with three-dimensional
		///						projection using configurable field of view.
		//						
		//						Construction types:
		//						- New element
		//						- Empty: {void|undefined}
		//						- Constructor copy: other
		//											{Camera.PerspectiveFieldOfViewProjectionMatrix}
		function PerspectiveFieldOfViewProjectionMatrix() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					/// @description		Initialize this constructor.
					static construct = function()
					{
						//|Construction type: Empty.
						parent = other;
						ID = undefined;
						fieldOfView = undefined;
						aspectRatio = undefined;
						clippingPlane = undefined;
						
						switch (argument_count)
						{
							case 1:
								if (string_copy(instanceof(argument[0]), 1, 38) ==
									"PerspectiveFieldOfViewProjectionMatrix")
								{
									//|Construction type: Constructor copy.
									var _other = argument[0];
									
									fieldOfView = ((is_instanceof(_other.fieldOfView, Angle))
												   ? new Angle(_other.fieldOfView)
												   : _other.fieldOfView);
									aspectRatio = _other.aspectRatio;
									clippingPlane = ((is_instanceof(_other.clippingPlane, Range))
													 ? new Range(_other.clippingPlane)
													 : _other.clippingPlane);
								}
							break;
							default:
								//|Construction type: New element.
								fieldOfView = argument[0];
								aspectRatio = argument[1];
								clippingPlane = argument[2];
							break;
						}
						
						return self;
					}
					
					/// @returns			{bool}
					/// @description		Check if this constructor is functional.
					static isFunctional = function()
					{
						var _matrix_valid = (ID == undefined);
						
						if (!_matrix_valid)
						{
							if ((is_array(ID)) and (array_length(ID) == 16))
							{
								_matrix_valid = true;
								var _i = 0;
								repeat (16)
								{
									if (!is_real(ID[_i]))
									{
										_matrix_valid = false;
										
										break;
									}
									
									++_i;
								}
							}
						}
						
						return ((_matrix_valid) and ((is_instanceof(fieldOfView, Angle)) and
								(fieldOfView.isFunctional())) and (is_real(aspectRatio)) and
								((is_instanceof(clippingPlane, Range)) and
								(clippingPlane.isFunctional())));
					}
					
				#endregion
				#region <<Execution>>
					
					/// @argument			fieldOfView? {Angle}
					/// @argument			aspectRatio? {real}
					/// @argument			clippingPlane? {Range}
					/// @description		Build and assign to this constructor a numeric array
					///						representing projection matrix, using either its
					///						configuration or specified temporarily replaced parts.
					static build = function(_fieldOfView = fieldOfView, _aspectRatio = aspectRatio,
											_clippingPlane = clippingPlane)
					{
						try
						{
							ID = matrix_build_projection_perspective_fov(_fieldOfView.value,
																		 _aspectRatio,
																		 _clippingPlane.minimum,
																		 _clippingPlane.maximum)
						}
						catch (_exception)
						{
							ErrorReport.report([other, parent,
												"PerspectiveFieldOfViewProjectionMatrix", "build()"],
											   _exception);
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
					///						matrix.
					static toString = function(_multiline = false, _full = false)
					{
						var _constructorName = "Camera.PerspectiveFieldOfViewProjectionMatrix";
						
						if (self.isFunctional())
						{
							var _mark_separator = ((_multiline) ? "\n" : ", ");
							var _string_matrix = ((_full) ? ("Matrix: " + string(ID) +
															 _mark_separator)
														  : "");
							var _string = (_string_matrix +
										   "Field of View: " + string(fieldOfView) + _mark_separator +
										   "Aspect Ratio: " + string(aspectRatio) + _mark_separator +
										   "Clipping Plane: " + string(clippingPlane));
							
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
						return PerspectiveFieldOfViewProjectionMatrix;
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
		
		//  @function			Camera.ViewMatrix()
		/// @argument			source {Vector3}
		/// @argument			target {Vector3}
		/// @argument			upVector {Vector3}
		/// @description		Constructs a matrix supplying the Camera with information about source
		///						and target location of the view and its orientation.
		//						
		//						Construction types:
		//						- New element
		//						- Empty: {void|undefined}
		//						- Constructor copy: other {Camera.ViewMatrix}
		function ViewMatrix() constructor
		{
			#region [[Methods]]
				#region <<Management>>
					
					/// @description		Initialize this constructor.
					static construct = function()
					{
						//|Construction type: Empty.
						parent = other;
						ID = undefined;
						source = undefined;
						target = undefined;
						upVector = undefined;
						
						switch (argument_count)
						{
							case 1:
								if (string_copy(instanceof(argument[0]), 1, 10) == "ViewMatrix")
								{
									//|Construction type: Constructor copy.
									var _other = argument[0];
									
									source = ((is_instanceof(_other.source, Vector3))
											  ? new Vector3(_other.source) : _other.source);
									target = ((is_instanceof(_other.target, Vector3))
											  ? new Vector3(_other.target) : _other.target);
									upVector = ((is_instanceof(_other.upVector, Vector3))
												? new Vector3(_other.upVector) : _other.upVector);
								}
							break;
							default:
								//|Construction type: New element.
								source = argument[0];
								target = argument[1];
								upVector = (((argument_count > 2) and (argument[2] != undefined))
											? argument[2] : new Vector3(0, 1, 0));
							break;
						}
						
						return self;
					}
					
					/// @returns			{bool}
					/// @description		Check if this constructor is functional.
					static isFunctional = function()
					{
						var _matrix_valid = (ID == undefined);
						
						if (!_matrix_valid)
						{
							if ((is_array(ID)) and (array_length(ID) == 16))
							{
								_matrix_valid = true;
								var _i = 0;
								repeat (16)
								{
									if (!is_real(ID[_i]))
									{
										_matrix_valid = false;
										
										break;
									}
									
									++_i;
								}
							}
						}
						
						return ((_matrix_valid) and ((is_instanceof(source, Vector3)) and
								(source.isFunctional())) and ((is_instanceof(target, Vector3)) and
								(target.isFunctional())) and ((is_instanceof(upVector, Vector3)) and
								(upVector.isFunctional())));
					}
					
				#endregion
				#region <<Execution>>
					
					/// @argument			source? {Vector3}
					/// @argument			target? {Vector3}
					/// @argument			upVector? {Vector3}
					/// @description		Build and assign to this constructor a numeric array
					///						representing view matrix, using either its configuration
					///						or specified temporarily replaced parts.
					static build = function(_source = source, _target = target, _upVector = upVector)
					{
						try
						{
							ID = matrix_build_lookat(_source.x, _source.y, _source.z, _target.x,
													 _target.y, _target.z, _upVector.x,
													 _upVector.y, _upVector.z);
						}
						catch (_exception)
						{
							ErrorReport.report([other, parent, "ViewMatrix", "build()"], _exception);
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
					///						matrix.
					static toString = function(_multiline = false, _full = false)
					{
						var _constructorName = "Camera.ViewMatrix";
						
						if (self.isFunctional())
						{
							var _mark_separator = ((_multiline) ? "\n" : ", ");
							var _string_matrix = ((_full) ? ("Matrix: " + string(ID) +
															 _mark_separator)
														  : "");
							var _string = (_string_matrix +
										   "Source: " + string(source) + _mark_separator +
										   "Target: " + string(target) + _mark_separator +
										   "Up Vector: " + string(upVector));
							
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
						return ViewMatrix;
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
		
		static constructor = Camera;
		
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