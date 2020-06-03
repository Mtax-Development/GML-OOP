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
	
	static Mirror = function()
	{
		x = -x;
		y = -y;
	}
	
	static Mirror_X = function()
	{
		x = -x;
	}
	
	static Mirror_Y = function()
	{
		y = -y;
	}
}