if !instance_exists(obj_soul) exit;
var r = 8
var fx = obj_soul.x + irandom_range(-r,r)
var fy = obj_soul.y + irandom_range(-r,r)
if (active == 0)
{
    if (side == 0)
    {
        move_towards_point(fx + 36, fy, 3);
        gravity_direction = 180;
    }
    
    if (side == 1)
    {
        move_towards_point(fx + 15, fy + 36, 3);
    }
    
    if (side == 2)
    {
        move_towards_point(fx - 26, fy + 10, 3);
        gravity_direction = 0;
    }
    
    if (side == 3)
    {
        move_towards_point(fx, fy - 26, 3);
        gravity_direction = 270;
    }
	gravity = 0.16 / 2
    
 image_index = 0

}

active = true;