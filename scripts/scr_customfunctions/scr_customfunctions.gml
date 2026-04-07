
function instance_create(instance,var_struct = {})
{
	return (instance_create_depth(0,0,0,instance,var_struct));
}

function shake_camera(duration,strength)
{
	with obj_camera	
	{
		shake_duration = duration
		shake_strenght = strength
	}
}
function create_collision(x,y,image_xscale = 1,image_yscale = 1,object_index = obj_collision_wall_rectangle, image_angle = 0)
{
	return instance_create(object_index,
	{
		x: x, 
		y: y, 
		image_xscale: image_xscale,
		image_yscale: image_yscale,
		image_angle: image_angle
	})	
}

// replaces instances or creates them if there arent any
function create_instances(instances)
{
	if !is_array(instances) 
		instance_create(instances);
	else 
		array_foreach(instances,
		function(value,index)
		{
			if instance_exists(value)
			instance_destroy(value);
			instance_create(value);
		});
}

function time_normalized(current_multiplier = 0.002)
{
	return abs((sin(current_time * current_multiplier) * 0.5) + 0.5)	
}

function play_sound(sound,gain = 1,loops = false,priority = 1, pitch = 1)
{
	return audio_play_sound(sound,priority,loops,1 * gain,0,pitch)
}
function set_border(border)
{
	if obj_border_controller.border != border 
		obj_border_controller.nextborder = border	
}

function remove_border()
{
	set_border(spr_border_noone)
}

function is_missing_text(n)
{
	return (n == DEFAULT_MISSING_TEXT)
}