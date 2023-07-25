//  @function				load_supplement()
/// @argument				constructor_name {string}
/// @argument				method_name {string}
/// @returns				{struct}
/// @description			Load a JSON file formatted with the supplement template and return it as a
///							struct. If the file does not exist, it is created with the template.
function load_supplement(_constructor_name, _method_name)
{
	if (!directory_exists(path.supplement))
	{
		directory_create(path.supplement)
	}
	
	if (!directory_exists(path.supplement + @"\" + _constructor_name))
	{
		directory_create(path.supplement + @"\" + _constructor_name);
	}
	
	var _path_target, _path_template;
	
	if (is_string(_method_name))
	{
		_path_target = (path.supplement + _constructor_name + @"\" +  _constructor_name + @"." +
						_method_name + @"()" + path.extension.supplement);
		_path_template = path.file.supplement.methodTemplate;
	}
	else
	{
		_path_target = (path.supplement + _constructor_name + @"\" + _constructor_name +
						path.extension.supplement);
		_path_template = path.file.supplement.constructorTemplate;
	}
	
	if (!file_exists(_path_target))
	{
		file_copy(_path_template, _path_target);
	}
	
	return json_to_struct(_path_target);
}
