
if (hspeed > 0)
{
    if (x > (obj_target.x + obj_target.sprite_width / 2))
        outside = true;
}
else
{
    if (x < obj_target.x - obj_target.sprite_width / 2)
        outside = true;
}

if (outside)
{
	image_speed = 1
	attacked = true 
    damage = 0
    fade = true
}

if fade 
{
	if image_alpha > 0 
		image_alpha -= 0.1 
	else instance_destroy()
}

if instance_number(obj_targetbar) > 1 && attacked
{
	fade = true 
	image_xscale *= 1.1
	image_yscale *= 1.1
}