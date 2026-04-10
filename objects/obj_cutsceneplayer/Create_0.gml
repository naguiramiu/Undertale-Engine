/// event is the current custscene event we are on
event = 0;
time_till_next = 0;

depth = -1000;

/// @description Play cutscene
play_cutscene_event = function()
{
	if !instance_exists(id) exit;
	
	if (event >= array_length(cutscene))
	{
		instance_destroy();
		exit;
	}

	var cut = variable_clone(cutscene[event]);
	if !is_array(cut) cut = [cut]
	var cut_script = cut[0];
	array_delete(cut,0,1);
	if is_method(cut_script)
	method_call(cut_script,cut)
	else
	script_execute_ext(cut_script,cut)


	event ++;
	if (time_till_next >= 0)
	alarm_set_instant(0,time_till_next);
	time_till_next = 0;
}

if array_length(cutscene)
{
	cutscene_perform_event = true
	play_cutscene_event()
}