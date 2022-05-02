/// @function				Buffer()
/// @argument				{int} size
/// @argument				{constant:buffer_[bufferType]} type
/// @argument				{int} aligment?
///							
/// @description			Constructs a Buffer, which is a region of memory, primarly used while
///							moving data between places, such as through network or to files.
///							
///							Construction types:
///							- New constructor
///							- Wrapper: {buffer} other
///							- Constructor copy: {Buffer} other
function Buffer() constructor
{
	#region [Methods]
		#region <Management>
			
			// @description			Initialize the constructor.
			static construct = function()
			{
				ID = undefined;
				
				if (argument_count > 0)
				{
					if (instanceof(argument[0]) == "Buffer")
					{
						var _other = argument[0];
						
						if ((is_real(_other.ID)) and (buffer_exists(_other.ID)))
						{
							//|Construction type: Constructor copy.
							var _size = buffer_get_size(_other.ID);
							var _type = buffer_get_type(_other.ID);
							var _aligment = buffer_get_alignment(_other.ID);
							
							ID = buffer_create(_size, _type, _aligment);
							
							buffer_copy(_other.ID, 0, _size, ID, 0);
						}
					}
					else 
					{
						if (argument_count == 1)
						{
							if ((is_real(argument[0])) and (buffer_exists(argument[0])))
							{
								//|Construction type: Wrapper.
								ID = argument[0];
							}
						}
						else
						{
							//|Construction type: New constructor.
							var _size = argument[0];
							var _type = argument[1];
							var _aligment = ((argument_count > 2) ? argument[2] : 1);
							
							if (!(_size > 0)) {_size = 1;} //|Size of less than 0 is not allowed.
														   // Size of 0 can crash the application.
							
							ID = buffer_create(_size, _type, _aligment);
						}
					}
				}
				
				return self;
			}
			
			// @returns				{bool}
			// @description			Check if this constructor is functional.
			static isFunctional = function()
			{
				return ((is_real(ID)) and (buffer_exists(ID)));
			}
			
			// @returns				{undefined}
			// @description			Remove the internal information from the memory.
			static destroy = function()
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					buffer_delete(ID);
					
					ID = undefined;
				}
				
				return undefined;
			}
			
			// @argument			{Buffer} other
			// @argument			{int|all} size?
			// @argument			{int} offset?
			// @argument			{int} other_offset?
			// @description			Copy all data or a segment of it from other Buffer to this one.
			//						For both Buffers, a byte offset can be specified for where the
			//						operation will start and then continue until either the specified
			//						size in bytes was affected or the end of this Buffer is reached.
			static copy = function(_other, _size, _offset = 0, _other_offset = 0)
			{
				if ((instanceof(_other) == "Buffer") and (is_real(_other.ID))
				and (buffer_exists(_other.ID)))
				{
					if (_other != self)
					{
						if ((!is_real(ID)) or (!buffer_exists(ID)))
						{
							ID = buffer_create(buffer_get_size(_other.ID),
											   buffer_get_type(_other.ID),
											   buffer_get_alignment(_other.ID));
						}
						
						if ((_size == undefined) or (_size == all)) 
						{
							_size = buffer_get_size(_other.ID);
						}
						
						buffer_copy(_other.ID, _other_offset, _size, ID, _offset);
					}
					else
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "copy";
						var _errorText = ("Attempted to copy data from self: " +
										  "{" + string(_other) + "}");
						_errorReport.reportConstructorMethod(self, _callstack, _methodName,
															 _errorText);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "copy";
					var _errorText = ("Attempted to copy data from an invalid Buffer: " +
									  "{" + string(_other) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
		#endregion
		#region <Getters>
			
			// @returns				{int} | On error: {undefined}
			// @description			Get the current seek position for this Buffer, which is the
			//						position on which simple read and write operations are performed
			//						and then that position is advanced by number of bytes affected.
			static getSeekPosition = function()
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					return buffer_tell(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getSeekPosition";
					var _errorText = ("Attempted to read a property of an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{constant:buffer_[bufferType]} | On error: {undefined}
			// @description			Return the type of this Buffer.
			static getType = function()
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					return buffer_get_type(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getType";
					var _errorText = ("Attempted to read a property of an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{int} | On error: {undefined}
			// @description			Return the byte alignment of this Buffer.
			static getAlignment = function()
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					return buffer_get_alignment(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getAlignment";
					var _errorText = ("Attempted to read a property of an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @returns				{pointer}
			// @description			Return the pointer to the position of this Buffer in the memory.
			static getPointer = function()
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					return buffer_get_address(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getPointer";
					var _errorText = ("Attempted to read a property of an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return pointer_invalid;
				}
			}
			
			// @returns				{int}
			// @description			Return the size of this Buffer in bytes.
			static getSize = function()
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					return buffer_get_size(ID);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "getSize";
					var _errorText = ("Attempted to read a property of an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return 0;
				}
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{constant:buffer_seek_*} base
			// @argument			{int} offset?
			// @description			Set the seek position for this Buffer, which is the position at
			//						which simple read and write operations are performed, after
			//						which that position is then advanced by the number of bytes
			//						affected. To set that position, a base is used, which can be the
			//						start or end this Buffer or the position relative to the current
			//						one. In addition to the base, a byte offset can be specified,
			//						which can also be a negative number.
			static setSeekPosition = function(_base, _offset = 0)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if ((_base == buffer_seek_relative) or (_offset == 0))
					{
						buffer_seek(ID, _base, _offset);
					}
					else
					{
						buffer_seek(ID, _base, 0);
						buffer_seek(ID, buffer_seek_relative, _offset);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "setSeekPosition";
					var _errorText = ("Attempted to set a property of an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{constant:buffer_[dataType]} type...
			// @argument			{bool|real|string} value...
			// @returns				{int|int[]}
			// @description			Add the specified data of the specified data type to this Buffer,
			//						then advance the seek position by number of bytes written.
			//						Returns 0 if write was successful, -1 if it was not or an array
			//						of such in case of multiple writings.
			static write = function(_type, _value)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					var _pairCount = (argument_count div 2);
					
					var _results = array_create(_pairCount, -1);
					
					var _i = 0;
					repeat (_pairCount)
					{
						_results[_i div 2] = buffer_write(ID, argument[_i], argument[(_i + 1)]);
						
						_i += 2;
					}
					
					switch (_pairCount)
					{
						case 0: return -1; break;
						case 1: return _results[0]; break;
						default: return _results; break;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "write";
					var _errorText = ("Attempted to write to an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return array_create((argument_count div 2), -1);
				}
			}
			
			// @argument			{constant:buffer_[dataType]} type
			// @argument			{bool|real|string} value
			// @argument			{int} size?
			// @argument			{int} offset?
			// @description			Fill this Buffer with data of the specified data type, starting
			//						from its start or the specified offset to it and ending if either
			//						the specified size in bytes has been written or the end of this 
			//						Buffer is reached.
			static fill = function(_type, _value, _size = all, _offset = 0)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if (_size == all) {_size = buffer_get_size(ID);}
					
					buffer_fill(ID, _offset, _type, _value, _size);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "fill";
					var _errorText = ("Attempted to write to an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{constant:buffer_[dataType]} type...
			// @returns				{real|real[]|string|string[]|bool|bool[]} | On error: {undefined}
			// @description			Return the data of the specified type from the Buffer, then
			//						advance the seek position by the number of bytes read.
			//						If multiple values are to be read, they will be returned in
			//						an array.
			static read = function()
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					switch (argument_count)
					{
						case 0: return undefined; break;
						case 1: return buffer_read(ID, argument[0]); break;
						default:
							var _result = array_create(argument_count, undefined);
							
							var _i = 0;
							repeat (argument_count)
							{
								_result[_i] = buffer_read(ID, argument[_i]);
						
								++_i;
							}
							
							return _result;
						break;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "read";
					var _errorText = ("Attempted to read an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{bool} replace?
			// @argument			{int} size?
			// @argument			{int} offset?
			// @returns				{Buffer} | On error: {undefined}
			// @description			Use the zlib compression to create a copy of this Buffer with 
			//						entirety or part of its data compressed.
			//						A byte offset can be specified for where the operation will start
			//						and then continue until either the specified size in bytes was
			//						affected or the end of this Buffer is reached.
			//						A compressed Buffer will be returned. If this Buffer was replaced
			//						by it, self will be returned for this. Otherwise it will be a
			//						new, separate Buffer.
			static compress = function(_replace, _size = all, _offset = 0)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if (_size == all) {_size = buffer_get_size(ID);}
					
					var _new = buffer_compress(ID, _offset, _size);
					
					if (buffer_exists(_new))
					{
						if (_replace)
						{
							buffer_delete(ID);
							ID = _new;
						
							return self;
						}
						else
						{
							return new Buffer(_new);
						}
					}
					else
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "compress";
						var _errorText = ("Buffer compression failed: " + 
										  "{" + string(ID) + "}");
						_errorReport.reportConstructorMethod(self, _callstack, _methodName,
															 _errorText);
						
						return undefined;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "compress";
					var _errorText = ("Attempted to compress an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{bool} replace?
			// @returns				{Buffer} | On error: {undefined}
			// @description			Use the zlib compression to create a copy of this Buffer with
			//						entirety of its data decompressed.
			//						A decompressed Buffer will be returned. If this Buffer was
			//						replaced by it, self will be returned for this. Otherwise it will
			//						be a new, separate Buffer.
			static decompress = function(_replace = false)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					var _new = buffer_decompress(ID);
					
					if (buffer_exists(_new))
					{
						if (_replace)
						{
							buffer_delete(ID);
							ID = _new;
							
							return self;
						}
						else
						{
							return new Buffer(_new);
						}
					}
					else
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "decompress";
						var _errorText = ("Buffer decompression failed: " +
										  "{" + string(ID) + "}");
						_errorReport.reportConstructorMethod(self, _callstack, _methodName,
															 _errorText);
						
						return undefined;
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "decompress";
					var _errorText = ("Attempted to compress an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{constant:buffer_[dataType]} type
			// @argument			{int} offset?
			// @returns				{bool|real|string} | On error: {undefined|int:0}
			// @description			Get the value of the specified data type at the specified offset
			//						from the start of this Buffer without interacting with the seek
			//						position.
			static getValue = function(_type, _offset = 0)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					return buffer_peek(ID, _offset, _type);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "peek";
					var _errorText = ("Attempted to read an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @argument			{bool} multiline?
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the properties of this Buffer.
			static toString = function(_multiline = false)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					var _mark_separator = ((_multiline) ? "\n" : ", ");
					
					var _size = buffer_get_size(ID);
					var _type = buffer_get_type(ID);
					var _aligment = buffer_get_alignment(ID);
					
					switch (_type)
					{
						case buffer_fixed: _type = "Fixed"; break;
						case buffer_grow: _type = "Grow"; break;
						case buffer_wrap: _type = "Wrap"; break;
						case buffer_fast: _type = "Fast"; break;
						case buffer_vbuffer: _type = "Vertex"; break;
						default: _type = string(undefined); break;
					}
					
					var _string = ("ID: " + string(ID) + _mark_separator +
								   "Size: " + string(_size) + _mark_separator +
								   "Type: " + string(_type) + _mark_separator +
								   "Aligment: " + string(_aligment));
					
					return ((_multiline) ? _string : (instanceof(self) + "(" + _string + ")"));
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			// @argument			{int|all} size?
			// @argument			{int} offset?
			// @returns				{string}
			// @description			Create a string representing entirety or part of data of this
			//						Buffer hashed by the MD5 algorithm.
			//						A byte offset can be specified for where the operation will start
			//						and then continue until either the specified size in bytes was
			//						affected or the end of this Buffer is reached.
			static toHashMD5 = function(_size = all, _offset = 0)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if (_size == all) {_size = buffer_get_size(ID);}
					
					return buffer_md5(ID, _offset, _size);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "toHashMD5";
					var _errorText = ("Attempted to convert an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return string(undefined);
				}
			}
			
			// @argument			{int|all} size?
			// @argument			{int} offset?
			// @returns				{string}
			// @description			Create a string representing entirety or part of data of this
			//						Buffer hashed by the SHA-1 algorithm.
			//						A byte offset can be specified for where the operation will start
			//						and then continue until either the specified size in bytes was
			//						affected or the end of this Buffer is reached.
			static toHashSHA1 = function(_size = all, _offset = 0)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if (_size == all) {_size = buffer_get_size(ID);}
					
					return buffer_sha1(ID, _offset, _size);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "toHashSHA1";
					var _errorText = ("Attempted to convert an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return string(undefined);
				}
			}
			
			// @argument			{int|all} size?
			// @argument			{int} offset?
			// @returns				{int}
			// @description			Create a number representing entirety or part of data of this
			//						Buffer hashed by the CRC32 checksum algorithm.
			//						A byte offset can be specified for where the operation will start
			//						and then continue until either the specified size in bytes was
			//						affected or the end of this Buffer is reached.
			static toHashCRC32 = function(_size = all, _offset = 0)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if (_size == all) {_size = buffer_get_size(ID);}
					
					return buffer_crc32(ID, _offset, _size);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "toString_hash_crc32";
					var _errorText = ("Attempted to convert an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return string(undefined);
				}
			}
			
			// @argument			{int|all} size?
			// @argument			{int} offset?
			// @returns				{string}
			// @description			Encode this Buffer into a string using the Base64 format, from
			//						which it can be recreated.
			//						A byte offset can be specified for where the operation will start
			//						and then continue until either the specified size in bytes was
			//						affected or the end of this Buffer is reached.
			static toEncodedString = function(_size = all, _offset = 0)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if (_size == all) {_size = buffer_get_size(ID);}
					
					return buffer_base64_encode(ID, _offset, _size);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "toEncodedString";
					var _errorText = ("Attempted to convert an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return string(undefined);
				}
			}
			
			// @argument			{string} string
			// @argument			{int} offset?
			// @description			Decode a string to which a Buffer was previously encoded into
			//						this one.
			//						A byte offset can be specified for where the operation
			//						will start.
			static fromEncodedString = function(_string, _offset = 0)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					buffer_base64_decode_ext(ID, _string, _offset);
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "fromEncodedString";
					var _errorText = ("Attempted to convert an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return string(undefined);
				}
			}
			
			// @argument			{Map} map
			// @description			Obfuscate and save a Map in this Buffer, fingerprinted for use on
			//						this device only.
			//						Arrays will be saved as DS Lists.
			static secureFromMap = function(_map)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if ((instanceof(_map) == "Map") and (_map.isFunctional()))
					{
						ds_map_secure_save_buffer(_map.ID, ID);
					}
					else
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "secureToBuffer";
						var _errorText = ("Attempted to convert an invalid Data Structure into a " +
										  "Buffer:\n" +
										  "Self: " + "{" + string(self) + "}" + "\n" +
										  "Other: " + "{" + string(_map) + "}");
						_errorReport.reportConstructorMethod(self, _callstack, _methodName,
															 _errorText);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "secureFromMap";
					var _errorText = ("Attempted to convert an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{Surface|int:surface} surface
			// @argument			{int} offset?
			// @argument			{int} modulo?
			// @description			Copy information from the specified Surface to this Buffer.
			//						A byte offset can be specified for where the operation will
			//						start.
			//						For this operation, this Buffer should be of Grow type with
			//						alignment of 1 byte.
			static fromSurface = function(_surface, _offset = 0)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if (instanceof(_surface) == "Surface") {_surface = _surface.ID;}
					
					if ((is_real(_surface)) and (surface_exists(_surface)))
					{
						buffer_get_surface(ID, _surface, _offset);
					}
					else
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "fromSurface";
						var _errorText = ("Attempted to convert an invalid Surface: " +
										  "{" + string(_surface) + "}");
						_errorReport.reportConstructorMethod(self, _callstack, _methodName,
															 _errorText);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "fromSurface";
					var _errorText = ("Attempted to convert an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
			}
			
			// @argument			{string:path} path
			// @argument			{int} offset?
			// @argument			{int} size?
			// @argument			{bool} async?
			// @returns				{int|undefined}
			//						Save the data of this Buffer to the specified file.
			//						A byte offset can be specified for where the operation will start
			//						and then continue until either the specified size in bytes was
			//						affected or the end of this Buffer is reached.
			//						This operation can be done asynchronously, which will prevent the
			//						game from stopping while in process.
			//						If performed asynchronously, the file path will have "Default/"
			//						added at the beginning of it automatically, also the ID will be
			//						returned that will equal the value of the ID key in Save/Load 
			//						asynchronous event. Otherwise {undefined} will be returned.
			static toFile = function(_path)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if (argument_count == 1)
					{
						buffer_save(ID, _path);
					}
					else
					{
						var _offset = (((argument_count > 1) and (argument[1] != undefined))
									   ? argument[1] : 0);
						var _size = (((argument_count > 2) and (argument[2] != undefined)
									 and (argument[2] != all)) ? argument[2] : buffer_get_size(ID));
						
						if ((argument_count < 3) or (!argument[3]))
						{
							buffer_save_ext(ID, _path, _offset, _size);
						}
						else
						{
							return buffer_save_async(ID, _path, _offset, _size);
						}
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "toFile";
					var _errorText = ("Attempted to convert an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return undefined;
			}
			
			// @argument			{string:path} path
			// @argument			{int} offset?
			// @argument			{int|all} async_size?
			// @returns				{int|undefined}
			// @description			Recreate a Buffer from the specified file containing a previously
			//						saved file and load it to this Buffer.
			//						A byte offset can be specified for where the operation will
			//						start.
			//						If no offset is specified, this Buffer will be replaced with a
			//						Buffer of Grow type and alignment of 1 byte.
			//						An async size can be specified, in which case this operation will
			//						be performed asynchronously and until the specified size in bytes
			//						loaded or the entire Buffer if the size was specified as {all}.
			//						If performed asynchronously, the file path will have "Default/"
			//						added at the beginning of it automatically, also the ID will be
			//						returned that will equal the value of the ID key in Save/Load 
			//						asynchronous event. Otherwise {undefined} will be returned.
			static fromFile = function(_path)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					var _offset = (((argument_count > 1) and (argument[1] != undefined))
								   ? argument[1] : 0);
					
					if ((argument_count > 2) and (argument[2] != undefined))
					{
						if (file_exists("Default/" + _path))
						{
							var _async_size = argument[2];
							
							if (_async_size == all) {_async_size = -1;}
							
							return buffer_load_async(ID, _path, _offset, _async_size);
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "fromFile";
							var _errorText = ("Attempted to load a nonexistent file: " +
												"{" + string(_path) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
							
							return undefined;
						}
					}
					else
					{
						if (file_exists(_path))
						{
							buffer_load_ext(ID, _path, _offset);
							
							return undefined;
						}
						else
						{
							var _errorReport = new ErrorReport();
							var _callstack = debug_get_callstack();
							var _methodName = "fromFile";
							var _errorText = ("Attempted to load a nonexistent file: " +
											  "{" + string(_path) + "}");
							_errorReport.reportConstructorMethod(self, _callstack, _methodName,
																 _errorText);
							
							return undefined;
						}
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "fromFile";
					var _errorText = ("Attempted to write to an invalid Buffer: " +
									  "{" + string(ID) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
					
					return undefined;
				}
			}
			
			// @argument			{string:path} path
			// @argument			{int} size
			// @argument			{int} offset?
			// @argument			{int} file_offset?
			// @description			Recreate a part of a Buffer from the specified file containing
			//						a previously saved file and load it to this Buffer.
			//						For both this Buffer and the file, a byte offset can be specified
			//						forw here the operation will start and then continue until either
			//						the specified size in bytes was affected or the end of this
			//						Buffer is reached.
			static fromFilePart = function(_path, _size, _offset = 0, _file_offset = 0)
			{
				if (file_exists(_path))
				{
					if ((is_real(ID)) and (buffer_exists(ID)))
					{
						buffer_load_partial(ID, _path, _file_offset, _size, _offset);
					}
					else
					{
						var _errorReport = new ErrorReport();
						var _callstack = debug_get_callstack();
						var _methodName = "fromFilePart";
						var _errorText = ("Attempted to write to an invalid Buffer: " +
										  "{" + string(ID) + "}");
						_errorReport.reportConstructorMethod(self, _callstack, _methodName,
															 _errorText);
					}
				}
				else
				{
					var _errorReport = new ErrorReport();
					var _callstack = debug_get_callstack();
					var _methodName = "fromFilePath";
					var _errorText = ("Attempted to load a nonexistent file: " +
										"{" + string(_path) + "}");
					_errorReport.reportConstructorMethod(self, _callstack, _methodName, _errorText);
				}
				
				return self;
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

