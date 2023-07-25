//  @function				get_construction_types()
/// @argument				string {string}
/// @returns				{string[]}
/// @description			Return the construction type names and arguments in the specified string.
function get_construction_types(_string)
{
	static _arrayParser = new ArrayParser();
	static _stringParser = new StringParser();
	
	return _arrayParser
			.setParser(_stringParser.setParser(_string)
									.replace("/")
									.trim()
									.replace("    ", "\n ")
									.replace("  ", " ")
									.split(" - ", StringParser))
			.forEach(function(_i, _value, _argument) {return _value.replace("- ").trim().ID;});
}
