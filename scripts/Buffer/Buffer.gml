/// @function				Buffer()
/// @argument				{int} size
/// @argument				{constant:buffer_[type]} type
/// @argument				{int} aligment?
///
///	@description			Constructs a Buffer, which is a region of memory, primarly used
///							temporarily while moving data between places, such as through network.
///
///							Construction methods:
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
				
				if ((argument_count > 0) and (instanceof(argument[0]) == "Buffer"))
				{
					var _other = argument[0];
					
					if ((is_real(_other.ID)) and (buffer_exists(_other.ID)))
					{
						//|Construction method: Constructor copy.
						var _size = buffer_get_size(_other.ID);
						var _type = buffer_get_type(_other.ID);
						var _aligment = buffer_get_alignment(_other.ID);
								
						ID = buffer_create(_size, _type, _aligment);
								
						buffer_copy(_other.ID, 0, _size, ID, 0);
					}
				}
				else
				{
					switch (argument_count)
					{
						case 1:
							if ((is_real(argument[0])) and (buffer_exists(argument[0])))
							{
								//|Construction method: Wrapper.
								ID = argument[0];
							}
						break;
					
						case 2:
						case 3:
						default:
							//|Construction method: New constructor.
							var _size = argument[0];
							var _type = argument[1];
							var _aligment = ((argument_count > 2) ? argument[2] : 1);
							
							if (!(_size > 0)) {_size = 1;} //|Size of less than 0 is not allowed.
														   // Size of 0 can crash the application.
							
							ID = buffer_create(_size, _type, _aligment);
						break;
					}
				}
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
			
			// @argument			{Buffer|buffer} other
			// @argument			{int} size?
			// @argument			{int} offset?
			// @argument			{int} other_offset?
			// @description			Copy all data or segment of it from other Buffer to this one.
			//						For both Buffers, a byte offset can be specified for where the
			//						operation will start and then continue until either the specified
			//						size in bytes was affected or the end of this Buffer is reached.
			static copy = function(_other, _size, _offset, _other_offset)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if (instanceof(_other) == "Buffer")
					{
						_other = _other.ID;
					}
					
					if (is_real(_other) and (buffer_exists(_other)))
					{
						if ((_size == undefined) or (_size == all)) {_size = buffer_get_size(_other);}
						if (_offset == undefined) {_offset = 0;}
						if (_other_offset == undefined) {_other_offset = 0;}
					
						if ((is_real(_other)) and (buffer_exists(_other)))
						{
							buffer_copy(_other, _other_offset, _size, ID, _offset);
						}
					}
				}
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
					return undefined;
				}
			}
			
			// @returns				{constant:buffer_[type]} | On error: {undefined}
			// @description			Return the type of this Buffer.
			static getType = function()
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					return buffer_get_type(ID);
				}
				else
				{
					return undefined;
				}
			}
			
			// @returns				{int} | On error: {int:0}
			// @description			Return the size of this Buffer in bytes.
			static getSize = function()
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					return buffer_get_size(ID);
				}
				else
				{
					return 0;
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
					return undefined;
				}
			}
			
			// @returns				{ptr} | On error: {undefined}
			// @description			Return the pointer to the position of this Buffer in the memory.
			static getPointer = function()
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					return buffer_get_address(ID);
				}
				else
				{
					return undefined;
				}
			}
			
		#endregion
		#region <Setters>
			
			// @argument			{constant:buffer_seek_*} base
			// @argument			{int} offset?
			// @description			Set the seek position for this Buffer, which is the position at
			//						which simple read and write operations are performed and then 
			//						that position is advanced by the number of bytes affected.
			//						To set that position, a base is used, which can be the start or 
			//						end this Buffer or the position relative to the current one.
			//						To this base, a byte offset can be specified, which can also be
			//						a negative number.
			static setSeekPosition = function(_base, _offset)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if (_offset == undefined) {_offset = 0;}
					
					buffer_seek(ID, _base, _offset);
				}
			}
			
		#endregion
		#region <Execution>
			
			// @argument			{constant:buffer_[dataType]} type
			// @argument			...
			// @description			Read the data of the specified type from the Buffer, then advance
			//						the seek position by the number of bytes read.
			static read = function()
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					var _results = array_create(argument_count, undefined);
					
					var _i = 0;
					
					repeat (argument_count)
					{
						_results[_i] = buffer_read(ID, argument[_i]);
						
						++_i;
					}
					
					switch (argument_count)
					{
						case 0: return undefined; break;
						case 1: return _results[0]; break;
						default: return _results; break;
					}
				}
				else
				{
					return undefined;
				}
			}
			
			// @argument			{constant:buffer_[dataType]} type
			// @argument			{bool|real|string} value
			// @argument			...
			// @returns				{int|int[]} | On error: {int:-1|int[]:[...-1]}
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
						_results[_i div 2] = buffer_write(ID, argument[_i], argument[_i + 1]);
						
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
					return -1;
				}
			}
			
			// @argument			{constant:buffer_[dataType]} type
			// @argument			{bool|real|string} value
			// @argument			{int} size?
			// @argument			{int} offset?
			// @description			Fill this Buffer with data of the specified data type, starting
			//						from its start or the specified offset to it and ending 
			//						if either the specified size in bytes is filled or the end of the 
			//						Buffer is reached.
			static fill = function(_type, _value, _size, _offset)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if ((_size == undefined) or (_size == all)) {_size = buffer_get_size(ID);}
					if (_offset == undefined) {_offset = 0;}
					
					buffer_fill(ID, _offset, _type, _value, _size);
				}
			}
			
			// @argument			{constant:buffer_[dataType]} type
			// @argument			{int} offset?
			// @returns				{bool|real|string} | On error: {undefined}
			// @description			Get the value of the specified data type at the current seek 
			//						position without changing that position.
			static peek = function(_type, _offset)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if (_offset == undefined) {_offset = 0;}
					
					return buffer_peek(ID, _offset, _type);
				}
				else
				{
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
			//						by it, self will be returned for this. Otherwise it will be a new,
			//						separate Buffer.
			static compress = function(_replace, _size, _offset)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if ((_size == undefined) or (_size == all)) {_size = buffer_get_size(ID);}
					if (_offset == undefined) {_offset = 0;}
				
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
						return undefined;
					}
				}
				else
				{
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
			static decompress = function(_replace)
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
						return undefined;
					}
				}
				else
				{
					return undefined;
				}
			}
			
		#endregion
		#region <Conversion>
			
			// @returns				{string}
			// @description			Create a string representing this constructor.
			//						Overrides the string() conversion.
			//						Content will be represented with the properties of this Buffer.
			static toString = function()
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					var _size = buffer_get_size(ID);
					var _type = buffer_get_type(ID);
					var _aligment = buffer_get_alignment(ID);
					
					switch(_type)
					{
						case buffer_fixed: _type = "Fixed"; break;
						case buffer_grow: _type = "Grow"; break;
						case buffer_wrap: _type = "Wrap"; break;
						case buffer_fast: _type = "Fast"; break;
						case buffer_vbuffer: _type = "Vertex"; break;
						default: _type = string(undefined); break;
					}
					
					return (instanceof(self) + 
						   "(" + 
						   "ID: " + string(ID) + ", " +
						   "Size: " + string(_size) + ", " + 
						   "Type: " + string(_type) + ", " +
						   "Aligment: " + string(_aligment) + 
						   ")");
						   
				}
				else
				{
					return (instanceof(self) + "<>");
				}
			}
			
			// @returns				{string}
			// @description			Create a string representing entirety or part of data of this
			//						Buffer hashed by the MD5 algorithm.
			//						A byte offset can be specified for where the operation will start
			//						and then continue until either the specified size in bytes was
			//						affected or the end of this Buffer is reached.
			static toString_hash_md5 = function(_size, _offset)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if ((_size == undefined) or (_size == all)) {_size = buffer_get_size(ID);}
					if (_offset == undefined) {_offset = 0;}
					
					return buffer_md5(ID, _offset, _size);
				}
				else
				{
					return string(undefined);
				}
			}
			
			// @returns				{string}
			// @description			Create a string representing entirety or part of data of this
			//						Buffer hashed by the SHA-1 algorithm.
			//						A byte offset can be specified for where the operation will start
			//						and then continue until either the specified size in bytes was
			//						affected or the end of this Buffer is reached.
			static toString_hash_sha1 = function(_size, _offset)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if ((_size == undefined) or (_size == all)) {_size = buffer_get_size(ID);}
					if (_offset == undefined) {_offset = 0;}
					
					return buffer_sha1(ID, _offset, _size);
				}
				else
				{
					return string(undefined);
				}
			}
			
			// @returns				{string}
			// @description			Create a string representing entirety or part of data of this
			//						Buffer hashed by the CRC32 checksum algorithm.
			//						A byte offset can be specified for where the operation will start
			//						and then continue until either the specified size in bytes was
			//						affected or the end of this Buffer is reached.
			static toString_hash_crc32 = function(_size, _offset)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if ((_size == undefined) or (_size == all)) {_size = buffer_get_size(ID);}
					if (_offset == undefined) {_offset = 0;}
					
					return buffer_crc32(ID, _offset, _size);
				}
				else
				{
					return string(undefined);
				}
			}
			
			// @returns				{string}
			// @description			Return a string of this Buffer encoded using Base64 encoding
			//						scheme, which can later be decoded to recreate it.
			//						A byte offset can be specified for where the operation will start
			//						and then continue until either the specified size in bytes was
			//						affected or the end of this Buffer is reached.
			static toEncodedString = function(_size, _offset)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if ((_size == undefined) or (_size == all)) {_size = buffer_get_size(ID);}
					if (_offset == undefined) {_offset = 0;}
					
					return buffer_base64_encode(ID, _offset, _size);
				}
				else
				{
					return string(undefined);
				}
			}
			
			// @argument			{string} string
			// @argument			{int} offset?
			// @description			Decode the previously encoded string of the same Buffer and
			//						recreate it into this one.
			//						A byte offset can be specified for where the operation will start.
			static fromEncodedString = function(_string, _offset)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if (_offset == undefined) {_offset = 0;}
					
					buffer_base64_decode_ext(ID, _string, _offset);
				}
			}
			
			// @argument			{Surface} surface
			// @argument			{int} offset?
			// @argument			{int} modulo?
			// @description			Copy information from the specified Surface to this Buffer.
			//						A byte offset can be specified for where the operation will start.
			//						A modulo value can be specified for number of bytes left after
			//						every written line for storing additional data.
			//						For this operation, this Buffer should be of Grow type with
			//						alignment of 1 byte.
			static fromSurface = function(_surface, _offset, _modulo)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if (surface_exists(_surface.ID))
					{
						if (_offset == undefined) {_offset = 0;}
						
						buffer_get_surface(ID, _surface.ID, _offset);
					}
				}
			}
			
			// @argument			{string} path
			// @argument			{int} offset?
			// @argument			{int} size?
			// @argument			{bool} async?
			//						Save the data of this Buffer to the specified file.
			//						A byte offset can be specified for where the operation will start
			//						and then continue until either the specified size in bytes was
			//						affected or the end of this Buffer is reached.
			//						This operation can be done asynchronously, which will prevent the
			//						game from stopping while in process.
			//						If performed asynchronously, the file path will have "Default/"
			//						added at the beginning of it automatically.
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
						var _offset = (((argument_count > 1) and (argument[1] != undefined)) ? 
									  argument[1] : 0);
						var _size = (((argument_count > 2) and (argument[2] != undefined) 
									and (argument[2] != all)) ? argument[2] : buffer_get_size(ID));
						
						if (argument_count <= 3)
						{
							buffer_save_ext(ID, _path, _offset, _size);
						}
						else if (argument[3])
						{
							buffer_save_async(ID, _path, _offset, _size);
						}
					}
				}
			}
			
			// @argument			{string} path
			// @argument			{int} offset?
			// @argument			{int|all} async_size?
			// @returns				{undefined|int}
			// @description			Recreate a Buffer from the specified file containing a previously
			//						saved file and load it to this Buffer.
			//						A byte offset can be specified for where the operation will start.
			//						If no offset is specified, this Buffer will be replaced with a
			//						Buffer of Grow type and alignment of 1 byte.
			//						An async size can be specified, in which case this operation will
			//						be performed asynchronously and until the specified size in bytes
			//						loaded or the entire Buffer if the size was specified as {all}.
			//						If performed asynchronously, the file path will have "Default/"
			//						added at the beginning of it automatically, also the ID will be
			//						returned that will equal the value of the ID key in Save/Load 
			//						asynchronous event.
			static fromFile = function(_path)
			{
				var _offset = (((argument_count > 1) and (argument[1] != undefined)) ? 
								argument[1] : 0);
					
				if ((argument_count <= 2) or (!argument[2]))
				{
					buffer_load_ext(ID, _path, _offset);
				}
				else
				{
					var _async_size = argument[2];
						
					if (_async_size == all) {_async_size = -1;}
					
					return buffer_load_async(ID, _path, _offset, _async_size);
				}
				
				return undefined;
			}
			
			// @argument			{string} path
			// @argument			{int} size
			// @argument			{int} offset?
			// @argument			{int} other_offset?
			// @description			Recreate a part of a Buffer from the specified file containing
			//						a previously saved file and load it to this Buffer.
			//						For both Buffers, a byte offset can be specified for where the
			//						operation will start and then continue until either the specified
			//						size in bytes was affected or the end of this Buffer is reached.
			static fromFile_part = function(_path, _size, _offset, _other_offset)
			{
				if ((is_real(ID)) and (buffer_exists(ID)))
				{
					if (_offset == undefined) {_offset = 0;}
					if (_other_offset == undefined) {_other_offset = 0;}
					
					buffer_load_partial(ID, _path, _other_offset, _size, _offset);
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
