var ease_func = [progress,var_start,var_end]
for (var i = 0; i < array_length(ease_params);i++)
ease_func[i + 3] = ease_params[i]
variable_instance_set(object_or_instance,var_name, method_call(ease_type,ease_func))
progress += progress_speed

if destroy 
{
	instance_destroy()
	if timer_to_start != -1 with creator 
		alarm_set_instant(0,other.timer_to_start)
}
if progress >= 1
{
	progress = 1 
	destroy = true 
}