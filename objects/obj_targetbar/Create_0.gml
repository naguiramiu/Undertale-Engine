image_speed = 0;
outside = 0;
image_xscale = 0.5 
image_yscale = 0.5
var spd = obj_target.attackspeed + random(0.2)
damage = 0
if (x <= obj_target.x)
    hspeed = spd;
else
if (x > (obj_target.x))
    hspeed = -spd
	
fade = false
attacked = false