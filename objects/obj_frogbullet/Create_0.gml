alarm[0] = 20;
image_angle = 0;
active = false;
side = 0;
lazy = true;
event_inherited()
image_xscale = 0.5 
image_yscale = 0.5
destroy_on_impact = false
cant = function()
{
	active = false
	gravity = 0; 
	speed = 0;
	image_index = 1
	alarm[0] = 8;
	if (lazy)
	alarm[0] = 20;	
}