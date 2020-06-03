function Scale() constructor
{
	switch(argument_count)
	{
		case 0:
			x = 1;
			y = 1;
		break;
		
		case 1:
			x = argument[0];
			y = argument[0];
		break;
		
		case 2:
			x = argument[0];
			y = argument[1];
		break;
	}
	
	static mirror = function()
	{
		x = -x;
		y = -y;
	}
	
	static mirror_x = function()
	{
		x = -x;
	}
	
	static mirror_y = function()
	{
		y = -y;
	}
}