if fade
{
    image_alpha -= 0.08;
    image_xscale -= 0.06;
}
if (image_xscale < 0.08)
    instance_destroy()

if !instance_exists(obj_targetbar) exit;

if interact_key_press
{
	var best_dist = -1
	var found = noone
	with (obj_targetbar) 
	{
	    if !attacked
	    {
	        var dist = point_distance(x, y, other.x, other.y)
	        if (found == noone || dist < best_dist) 
	        {
	            best_dist = dist
	            found = id
	        }
	    }
	}
	
	if (found != noone)
	    with (found) event_user(1)
}

var all_attacked = true
with (obj_targetbar) 
if !attacked
{
	all_attacked = false
	break
}

if all_attacked && !done_damage
	event_user(0)
