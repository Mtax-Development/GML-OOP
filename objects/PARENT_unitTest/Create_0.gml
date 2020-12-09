constructorName = string_replace(object_get_name(object_index), "unitTest_", "");
constructorType = asset_get_index(constructorName);

unitTest = new UnitTest(script_get_name(constructorType));

order_display = true;

event_user(0);
