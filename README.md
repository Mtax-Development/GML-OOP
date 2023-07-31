This branch contains a documentation generator specialized for **GML-OOP**. It is used to generate [Wiki](https://github.com/Mtax-Development/GML-OOP/wiki) pages of the project.

# Initialization
The following GameMaker Language dependencies are required:

* [GML-OOP](https://github.com/Mtax-Development/GML-OOP) itself.
* Following scripts from [GML Development Toolbox](https://github.com/Mtax-Development/GML-Development-Toolbox):
  * [out()](https://raw.githubusercontent.com/Mtax-Development/GML-Development-Toolbox/master/scripts/out/out.gml)
  * [array()](https://raw.githubusercontent.com/Mtax-Development/GML-Development-Toolbox/master/scripts/array/array.gml)
  * [file_to_string()](https://raw.githubusercontent.com/Mtax-Development/GML-Development-Toolbox/master/scripts/file_to_string/file_to_string.gml)
  * [string_to_file()](https://raw.githubusercontent.com/Mtax-Development/GML-Development-Toolbox/master/scripts/string_to_file/string_to_file.gml)
  * [json_to_struct()](https://raw.githubusercontent.com/Mtax-Development/GML-Development-Toolbox/master/scripts/json_to_struct/json_to_struct.gml)

Include them in the project found in this branch. The preferred way to include several scripts at once is to use Local Packages. In the GameMaker IDE, this can be done from the `Tools` toolbar menu, from which you can use the option `Create Local Package` on open projects of the above dependencies to then load them into the **Documentation Generator** project using the `Import Local Package` option. Single scripts can be created in the `Asset Browser` to have their content copied from above links.

# Usage
The generator will begin creating files in [`working_directory`](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/File_Handling/File_Directories/working_directory.htm) after launching it, as specified in `Platform Settings` of the GameMaker project file. Two types of files will be created:
* Supplement files: Editable JSON files with configuration of additional information placed into the output files during their generation.
* Output files: Files containing formatted Wiki pages.

Supplement files can also be placed in the `datafiles/Supplement` folder of this project. Files supplementing constructor pages have to then be placed in a subsidiary folder named with the exact name of that constructor.

To launch this program, the `documentation` script must be modified in the code. The `project` property of the `path` struct must be filled with a string containg a path to the directory containing **GML-OOP** project file. The generator will read the files in its subsidiary `scripts` folder to generate pages based on them. Output files will be overwritten on each launch of this program, but supplement files will be not.

This program does not have a graphical interface. All information output occurs in the standard output of the application and folders described above.
