# About
This branch contains Unit Tests for **GML-OOP**.    
Their purpose is to ensure and prove that its every feature is possible to execute without errors and follows its intended behavior.


# Initialization

The following GML dependencies are required:

* [GML-OOP](https://github.com/Mtax-Development/GML-OOP) itself.
* [UnitTest](https://github.com/Mtax-Development/GML-Development-Toolbox/blob/master/scripts/UnitTest/UnitTest.gml) constructor from [GML Development Toolbox](https://github.com/Git-Mtax/GML-Development-Toolbox).

Include them in the project found in this branch.    
The preferred way to do so is to use Local Packages. In GameMaker Studio 2 IDE, this can be done from the `Tools` toolbar menu, from which you can use the option `Create Local Package` on open projects of the above dependencies to then load them into the Unit Test project using the `Import Local Package` option.


# Usage

By default, each object that is a child of `PARENT_unitTest` will launch its Unit Test stored in its `User Event 0` during its `Create Event`, resulting in a message box showing readable results of the tests. Therefore, Unit Tests can be executed by creating an instance of their respective objects.

The behavior of all Unit Tests can be altered at once by modifying the parent.    
The `order_display` variable in its `Create Event` is a condition required to use the code in the `Step Event` that can be altered to handle the results of the tests differently.


# Expansion

Most of steps necessary in creation of Unit Tests for new constructors have been automatized.

Therefore, a proper constructor Unit Test has to fulfill the following requirements:

* Be a child of `PARENT_unitTest` and execute its inherited events.
* Execute its Unit Tests in its `User Event 0` using the methods of `Unit Test` constructor referred to by the `unitTest` variable inherited from the parent.
* Have its object name use the following pattern: `unitTest_#`, where `#` is the exact name of the constructor that is being tested.
