
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
function create_collision(_x,_y,_image_xscale = 1,_image_yscale = 1,_object_index = obj_collision_wall_rectangle, _image_angle = 0)
{
	return instance_create(_object_index,
	{
		x: _x, 
		y: _y, 
		image_xscale: _image_xscale,
		image_yscale: _image_yscale,
		image_angle: _image_angle
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

function get_variable()
{
	var is_variable_valid = function (str) 
	{
		var _allowed = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_"
		var _remainder = string_digits(string_letters(str)) + "_"
		str = string_replace_all(str," ","_")
		for (var i = 1; i <= string_length(_allowed); i++)
			str = string_replace_all(str, string_char_at(_allowed, i), "")
			return str 
	}
	var variable_name = get_string("Please enter the name for the new variable","")
	if (is_undefined(variable_name) || string_length(variable_name) == 0)
	show_message("Error! Please ensure the variable name is valid.")
	else
	{
		var v = is_variable_valid(variable_name)
		if string_length(v) != 0
		show_message("Error! Unknown token(s): \"" + v + "\"")
		else
			return get_variable_value(variable_name)
	}
	return -1
}

function get_variable_value(variable_name,default_value = "")
{
	var a = get_string
	(
		"Please enter the value for this variable.\n" +
		"Make sure it follows these examples:\n" +
		"for a struct: {\"variable_name\":value, \"variable_name_2\":value2}\n" +
		"for a number: 50.0\n" + 
		"for a string: \"string\"\n" + 
		"for an array: [23.0,\"string\"]",
		default_value
	)
	if (is_undefined(a) || string_length(a) == 0)
	{
		show_message("Error! Please ensure the value is valid.")
		return -1
	}
		if string_length(string_letters(a))
		&& !(string_pos("{",a) || string_pos("[",a))
		{
			if !string_starts_with(a,"\"")
			a = "\"" + string(a)
			if !string_ends_with(a,"\"")
			a += "\""
		}
							
	var final = "{\"" + variable_name + "\" : " + a + "}"
	try 
	{
		final = json_parse(final)	
	}
	catch (e) 
	{
		show_message("Error! Malformed variable:\n" + get_error_message(e) )
		return -1
	}
	return final
}