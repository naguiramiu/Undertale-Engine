
function scr_updown_modwrap(sel,ary,moved = function(){ play_sound(snd_menu_move)},array_denied = [],am = 1)
{
	var prev = sel
	if down_key_press sel = modwrap(sel,am,ary,array_denied)
	if up_key_press sel = modwrap(sel,-am,ary,array_denied)
	if prev != sel && moved != -1
		moved()
	return sel
}

function scr_leftright_modwrap(sel,ary,moved = function(){play_sound(snd_menu_move)}, am = 1)
{
	var prev = sel
	if left_key_press sel = modwrap(sel,-am,ary)
	if right_key_press sel = modwrap(sel,am,ary)
	if prev != sel && moved != -1
		moved()
	return sel
}



function function_call(func,array_args = [])
{
	if !is_array(array_args) array_args = [array_args]

	if is_method(func)
	method_call(func,array_args)
	else
	script_execute_ext(func,array_args)	
}


function variable_self_get(name,_self = self)
{
	if is_struct(_self) return variable_struct_get(_self,name)
		return variable_instance_get(_self,name)
}

function variable_self_exists(name,_self = self)
{
	if is_struct(_self) return variable_struct_exists(_self,name)
		return variable_instance_exists(_self,name)
}

function variable_self_set(name,val,_self = self)
{
	if is_struct(_self) variable_struct_set(_self,name,val)
		else variable_instance_set(_self,name,val)
}

function struct_merge(original,replacement)
{
	var keys = struct_get_names(original)
	for (var i = 0; i < array_length(keys); i++)
	{
		if (!is_struct(replacement) || !variable_struct_exists(replacement,keys[i])) // if the one trying to load does not have a var from the original
			replacement[$keys[i]] = original[$keys[i]] // put it there
		else 
			if is_struct(original[$keys[i]]) // if it does, but its a struct, run this again
					replacement[$keys[i]] =	struct_merge(original[$keys[i]],replacement[$keys[i]])
	}
	return replacement
}


function is_defined(n)
{
	return !is_undefined(n)	
}

function struct_add_unique(original, new_struct) 
{
    var names = struct_get_names(new_struct);
    for (var i = 0; i < array_length(names); i++) 
        if (!struct_exists(original, names[i]))
            original[$names[i]] = new_struct[$names[i]]
}

function struct_replace_unique(original, new_struct) 
{
    var names = struct_get_names(new_struct);
    for (var i = 0; i < array_length(names); i++) 
            original[$names[i]] = new_struct[$names[i]]
}


function struct_merge_ext(original, replacement)
{
    if (is_struct(original))
    {
        if (!is_struct(replacement)) replacement = {};
        var keys = struct_get_names(original);
        for (var i = 0; i < array_length(keys); i++)
        {
            var key = keys[i];
            if (!variable_struct_exists(replacement, key)) 
                replacement[$ key] = original[$ key];
            else 
                replacement[$ key] = struct_merge_ext(original[$ key], replacement[$ key]);
        }
    }
    else if (is_array(original))
    {
        if (!is_array(replacement)) replacement = [];
        
        var len_orig = array_length(original);
        var len_repl = array_length(replacement);
        var max_len = len_orig// max(len_orig, len_repl);
        for (var i = 0; i < max_len; i++)
        {
            if (i >= len_repl)
                replacement[i] = original[i];
            else if (i < len_orig)
                replacement[i] = struct_merge_ext(original[i], replacement[i]);
        }
    }
    return replacement;
}


function alarm_create_free(time_to,func,args = [],self_id = noone,var_struct = {})
{
	if !is_array(args) args = [args]	
	var_struct.time_to = time_to 
	var_struct.func = func 
	var_struct.args = args 
	var_struct.target_instance = self_id 
	return instance_create(obj_free_alarm,var_struct)
}

function do_later(time_to,func,args = [],self_id = noone,var_struct = {})
{
	return alarm_create_free(time_to,func,args,self_id,var_struct)
}

function set_later(_time_to,_instance_or_struct,_variable_name,_value)
{
	instance_create(obj_set_later,
	{
		time_to: _time_to,
		instance_or_struct: _instance_or_struct,
		variable_name: _variable_name,
		value: _value
	})
}



//custom function for setting alarms that allows it to automatically perform if timer == 0
function alarm_set_instant(alarm_number,timer) 
{
		if timer == 0 event_perform(ev_alarm,alarm_number) 
		else
		alarm[alarm_number] = timer
}

function customevent_get_params(event_name = "",_id = self)
{
	var add_space = (event_name == "" ? "" : "_")
	var params = []
	var possible = ["arguments","params","parameters","args"]
	for (var i = 0; i < array_length(possible);i++){ 
	if variable_self_exists("event_" + event_name + add_space + possible[i],_id)
	{
		params = variable_self_get("event_" + event_name + add_space + possible[i],_id)
		break;
	}}
	if !is_array(params) params = [params]
	return params;
}

function var_id_exists(name)
{
	return variable_instance_exists(id,name)	
}
function var_id_get(name)
{
	return variable_instance_get(id,name)	
	
}
function var_id_set(name,val)
{
	variable_instance_set(id,name,val)	
}

// easy way to lerp variables. By providing an array of [instance,variable name], you can dinamically get variables that way too.
function lerp_var_ext(_object_or_instance,_var_name,_progress_speed,_start,_end,_ease_type = ease_square,_ease_params = [],var_struct = {})
{  
	if !variable_instance_exists(_object_or_instance,_var_name) variable_instance_set(_object_or_instance,_var_name,_start)
	with instance_create(obj_interpolatevar_ext,var_struct){
			var_start = var_get(_start);
			var_end = var_get(_end);
			progress_speed = _progress_speed;
			object_or_instance = var_get(_object_or_instance);
			var_name = _var_name;
			ease_type = _ease_type;
			creator = other;
			ease_params = _ease_params;
			return id;
		}
}



/*
 this function allows you to find variables which are declared at runtime, for example,
 [obj_camera,"x"] returns the x of the camera.
 it also works with structs, like this:
{
	is_var_get: true
	instance_name: obj_camera, //instance can also be another struct
	edit: 12, // you can do something to the original number with this
	edit_type: e_operator.add // you can use this enum to say what to do with the numbers
}
*/
function var_get(value)
{
	if is_struct(value) && variable_struct_exists(value,"is_var_get")
	{
		var final_value = variable_struct_get(value.instance_name,value.var_name)
		
		if variable_struct_exists(value,"edit") &&
		value.edit != undefined
		{
			var edit = value.edit 
			
			switch value.edit_type 
			{
				case e_operator.add:
					return final_value + edit 
				case e_operator.divide:
					return final_value / edit 
				case e_operator.int_div:
					return final_value div edit 
				case e_operator.modulo: 
					return final_value % edit 
				case e_operator.multiply:
					return final_value * edit 
				case e_operator.subtract:
					return final_value - edit 
				case e_operator.array:
					return final_value[edit]
			}
		}
		show_message(final_value)
		return final_value
	}
	
	return value 
}


function var_push(_instance_name,_var_name = "",_edit = undefined, _edit_type = e_operator.add)
{
	return 
		{
			instance_name: _instance_name, 
			var_name: _var_name,
			edit: _edit,
			edit_type: _edit_type,
			is_var_get: true
		}
}


/// @desc remap(in, min1, max1, min2, max2) 
/// @param in  The input value to be remapped
/// @param min1   The lower bound of the value's current range
/// @param max1  The upper bound of the value's current range
/// @param min2   The lower bound of the target range
/// @param max2  The upper bound of the target range

function remap(in, min1, max1, min2, max2) 
{
    return min2 + (in - min1) * (max2 - min2) / (max1 - min1);
}

function angle_lerp(a, b, t)
{
    var diff = angle_difference(b, a); 
    return a + diff * t;
}



/**
 
Add Wrap
Adds or subtracts an amount to a number, and wraps it around a set size.
input {Real} the original number that will be added or subtracted from.
change {Real} the amount to add to the number. can be negative.
size {Real} The size to wrap the number around, works like array_length, starts at 1.
array_denied {Array} (Optional) an array of numbers that will be skipped if the added to amount happens to equal it.*/

function modwrap(input,change,size,array_denied = [])
{
    var prev = input
    if change == 0 
        while (array_contains(array_denied,input))
        {
            input = (input + 1) % size 
            if prev == input 
            return input 
        }
    if size == 1 return input; 
    if change > 0 
    {
        input = (input + change) % size 
        var prev = input
        while (array_contains(array_denied,input))
        {
            input = (input + change) % size 
            if prev == input 
            return input 
        }
    }
    else if change < 0
    {
        input = ((input + change) + size) % size
        var prev = input
        while (array_contains(array_denied,input))
        {
            input = ((input + change) + size) % size
            if prev == input 
            return input 
        }
    }
    return input 
}
