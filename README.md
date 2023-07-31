This branch contains Unit Tests for **GML-OOP**. Their purpose is to ensure and prove that its every feature is possible to execute without errors and follows intended behavior.

# Initialization
The following GameMaker Language dependencies are required:

* [GML-OOP](https://github.com/Mtax-Development/GML-OOP) itself.
* [UnitTest](https://raw.githubusercontent.com/Mtax-Development/GML-Development-Toolbox/master/scripts/UnitTest/UnitTest.gml) constructor from [GML Development Toolbox](https://github.com/Git-Mtax/GML-Development-Toolbox).

Include them in the project found in this branch. The preferred way to include several scripts at once is to use Local Packages. In the GameMaker IDE, this can be done from the `Tools` toolbar menu, from which you can use the option `Create Local Package` on open projects of the above dependencies to then load them into the Unit Test project using the `Import Local Package` option. Single scripts can be created in the `Asset Browser` to have their content copied from above links.

# Usage
By default, each object that is a child of `PARENT_unitTest` will launch its Unit Test stored in its `User Event 0` during its `Create Event`, resulting in a message box showing readable results of the tests. Therefore, Unit Tests can be executed by creating an instance of their respective objects.

The behavior of all Unit Tests can be altered at once by modifying the parent. The `order_display` variable in its `Create Event` is a condition required to use the code in the `Step Event` that can be altered to handle the results of the tests differently.

# Expansion
Most steps necessary to create Unit Tests for new constructors have been automated.

A proper constructor Unit Test needs to fulfill the following requirements:
* Be a child of `PARENT_unitTest` and execute its inherited events.
* Execute its Unit Tests in its `User Event 0` using the methods of `Unit Test` constructor referred to by the `unitTest` variable inherited from the parent.
* Have its object name use the following pattern: `unitTest_#`, where `#` is the exact name of the constructor that is being tested.
