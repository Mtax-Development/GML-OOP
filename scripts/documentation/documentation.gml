draw_enable_drawevent(false);
out("GML-OOP documentation generation start.");

var _ROOT = self;
path = {} with (path)
{
	project = @"";
	scripts = (project + @"scripts\");
	supplement = @"Supplement\";
	output = @"Output\";
	
	extension = {} with (extension)
	{
		page = @".md";
		supplement = @".json";
		script = @".gml";
		metadata = @".yy";
	}
	
	file = {} with (file)
	{
		page = {} with (page)
		{
			table_of_contents = ("_Sidebar" + _ROOT.path.extension.page);
		}
		supplement = {} with (supplement)
		{
			constructorTemplate = ("ConstructorTemplate" + _ROOT.path.extension.supplement);
			methodTemplate = ("MethodTemplate" + _ROOT.path.extension.supplement);
		}
	}
}

if (!((is_string(path.project)) and (string_length(path.project) > 0)))
{
	var _error = "ERROR: Path to the project to document not set. Unable to continue.";
	
	out(_error);
	show_message(_error);
	
	exit;
}

output_count =
{
	constructor_page: 0,
	method_page: 0,
	table_of_contents_page: 0
};

constructor_name = get_file_names_constructors();
constructor_type = new Map();
method_listing = new Map();
method_type = ["Management", "Getters", "Setters", "Execution", "Conversion"];

var _method_type_count = array_length(method_type);
var _i = [0, 0];
repeat (array_length(constructor_name))
{
	out("Generating pages for " + string(constructor_name[_i[0]]) + ".");
	
	var _constructor_name = constructor_name[_i[0]];
	var _parent_constructor_name = _constructor_name;
	var _element_name = undefined;
	
	if (string_count(".", _constructor_name) > 0)
	{
		_parent_constructor_name = string_copy(_constructor_name, 1,
											   (string_pos(".", _constructor_name) - 1));
		_element_name = _constructor_name;
	}
	
	var _path_constructor_folder = (path.scripts + _parent_constructor_name + @"\");
	var _path_source = (_path_constructor_folder + _parent_constructor_name + path.extension.script);
	var _path_metadata = (_path_constructor_folder + _parent_constructor_name +
						  path.extension.metadata);
	var _metadata = json_to_struct(_path_metadata);
	
	var _method_type_map = new Map();
	_i[1] = 0;
	repeat (array_length(method_type))
	{
		_method_type_map.add(method_type[_i[1]], []);
		
		++_i[1];
	}
	
	method_listing.add(_constructor_name, _method_type_map);
	
	if (!constructor_type.keyExists(_metadata.parent.name))
	{
		constructor_type.add(_metadata.parent.name, []);
	}
	
	array_push(constructor_type.getValue(_metadata.parent.name), _constructor_name);
	
	generate_pages_methods(_path_source, _element_name);
	generate_page_constructor(_path_source, _element_name);
	
	++_i[0];
}

out("Generating Table of Contents");

generate_page_table_of_contents(_path_source)

constructor_type.destroy();
method_listing.destroy(true);

out("Documentation generation finished." + "\n" +
	"Resulting output:" + "\n" +
	"-> " + string(output_count.constructor_page) + " constructor pages" + "\n" +
	"-> " + string(output_count.method_page) + " method pages" + "\n" +
	"-> " + string(output_count.table_of_contents_page) + " table of contents page");

//|Application exits in Room Creation Code.
