#macro cutscene_hold_arguments \
if !(cutscene_perform_event) \
{ \
	var args = [asset_get_index(_GMFUNCTION_)]; \
	for (var i = 0; i < argument_count; i++) \
	args[i+1] = argument[i]; \
	return args; \
}
// 
//			to start a cutscene, variable cutscene_perform_event must be set to false.
//			When the cutscene is being played it is set to true. Use cutscene_start() too

function cutscene_create()
{
 	var cutscene = []
	for (var i = 0; i < argument_count; i++)
	cutscene[i] = argument[i];
	return cutscene
}

function cutscene_start(cutscene_array,var_struct = {},_persistent = false)
{
	var_struct.persistent = _persistent
	var_struct.cutscene = cutscene_array
	
	return instance_create_depth(0,0,0,obj_cutsceneplayer,var_struct)
}

function cutscene_start_self(cutscene_array,var_struct = {},_persistent = false)
{
	persistent = _persistent
	cutscene = cutscene_array
	cutscene_perform_event = true
	play_cutscene_event()
}

function cut_move_instance(_instance,_var_name,_amount,_target_amount,_time_till_next = 0,_start_timer_imediately = false)
{
	cutscene_hold_arguments
	
	instance_create(obj_cut_move_instance,
	{
		instance: _instance,
		var_name: _var_name,
		amount: _amount,
		target: _target_amount,
		do_cutscene: !_start_timer_imediately,
		cutscene_timer: _time_till_next,
		cutscene_creator: id
	})
	
	time_till_next = (_start_timer_imediately ? _time_till_next : -1);
}
function cut_interpolate_var(_object_or_instance,_var_name,_progress_speed,_start,_end, _time_till_next = 0,_ease_type = ease_square,_start_timer_imediately = false,_ease_params = [])
{  
	cutscene_hold_arguments
	
	
	with instance_create(obj_interpolatevar_ext,
	{
		persistent: persistent
	})
	{
			var_start = var_get(_start);
			var_end = var_get(_end);
			progress_speed = _progress_speed;
			object_or_instance = var_get(_object_or_instance);
			var_name = _var_name;
			ease_type = _ease_type;
			if !_start_timer_imediately
			timer_to_start = _time_till_next;
			creator = other.id;
			ease_params = _ease_params;
	}
		time_till_next = (_start_timer_imediately ? _time_till_next : -1);
}

function cut_can_move(flag)
{
	cutscene_hold_arguments	
	
	global.can_move = flag 
}

function cut_perform_function(_time_till_next,_func,_array_args = [])
{
	cutscene_hold_arguments
	
	if !is_array(_array_args) _array_args = [_array_args]
	if is_method(_func)
	method_call(_func,_array_args);
	else script_execute_ext(_func,_array_args)
	time_till_next = _time_till_next;
}
function cut_waitforinput(what_input, has_to_hold = false,has_to_hold_for_how_long = 0,_timer_till_next = 0,start_timer_imediately = false)
{
	cutscene_hold_arguments
	// start timer imediately makes it not wait until this is destroyed, shouuld be set to false
	instance_create(obj_cutscene_waitforinput,
	{	
		do_timer: !start_timer_imediately,
		input: what_input,	
		hold: has_to_hold,
		hold_timer: has_to_hold_for_how_long,
		creator: other.id,
		next_timer: _timer_till_next
	})
	time_till_next = start_timer_imediately ? _timer_till_next : -1
}


function cut_set_var(_object_or_instance,_var_name,_value,_time_till_next = 0) 
{
	cutscene_hold_arguments
	
	_object_or_instance = var_get(_object_or_instance);
	variable_self_set(_var_name,var_get(_value),_object_or_instance)
	time_till_next = _time_till_next;
}

function cut_wait(_time_till_next)
{
	cutscene_hold_arguments
	time_till_next = _time_till_next;
}

function cut_playsound(_sound,_gain = 1,_time_till_next = 0, _pitch = 1, _loops = false, _is_music = false,_priority = 1,fade_in_time = 0)
{
	cutscene_hold_arguments
	var played = play_sound(_sound,_gain,_loops,_priority,_pitch);
	
	if fade_in_time != 0 
	{
		audio_sound_gain(played,0,0)	
		audio_sound_gain(played,_gain,fade_in_time)
	}
	time_till_next = _time_till_next;
}

function cut_textbox(text,_time_till_next = 0, _start_timer_imediately = false, var_struct = {}, _creator_instance = noone,_do_cutscene_event_at_destroy = true)
{
	cutscene_hold_arguments
	
	struct_add_unique(var_struct,
	{
		do_cutscene_event_at_destroy: _do_cutscene_event_at_destroy,
		time_till_next: _time_till_next,
	})
	time_till_next = (_start_timer_imediately ? _time_till_next : -1);
	return 	scr_create_cutscene_textbox(text,var_struct)
}

function scr_create_cutscene_textbox(text,var_struct = {})
{
	var _var_struct = variable_clone(var_struct)
	struct_add_unique(_var_struct,
	{
		do_cutscene_event_at_destroy: true,
		time_till_next: 0,
		creator: id,
		stop_drawing_after_destroy: false,
		let_player_move_end: false,
		event_cutscene: function()
		{
			with creator	
				alarm_set_instant(0,time_till_next)
		}
	})
	
	if variable_self_exists("textbox_talker") && !variable_struct_exists(_var_struct,"talker")
	_var_struct.talker = textbox_talker
	
	return create_textbox(text,_var_struct)
}

function cutscene_pause(_cutscene_id = undefined)
{
	if is_undefined(_cutscene_id)
		time_till_next = -1 
	else _cutscene_id.time_till_next = -1
}

function cutscene_next_event(_cutscene_id = undefined)
{
	if is_undefined(_cutscene_id)
		play_cutscene_event()
	else with _cutscene_id 
		play_cutscene_event()
}

function cut_textbox_talker(talker)
{
	cutscene_hold_arguments
	
	self.textbox_talker = talker
}

function cutscene_force_end(_cutscene_id = undefined)
{
	if is_undefined(_cutscene_id)
		{
			if object_index == obj_cutsceneplayer instance_destroy()
			else if other.object_index == obj_cutsceneplayer instance_destroy(other)
		}
	else instance_destroy(_cutscene_id)
}