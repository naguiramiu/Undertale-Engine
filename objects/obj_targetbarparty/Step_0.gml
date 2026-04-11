if attacked || fade
{
	if image_alpha > 0 image_alpha -= 0.1 
	
	image_xscale *= 1.1
	image_yscale *= 1.1
}
else
if x < obj_target_party.x + 30
	attacked = true 	