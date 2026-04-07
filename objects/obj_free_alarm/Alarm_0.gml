if target_instance != noone 
{
	with target_instance
	script_execute_ext(other.func,other.args)
}
else
{
	if is_method(func) method_call(func,args)
	else script_execute_ext(func,args)
}
instance_destroy()