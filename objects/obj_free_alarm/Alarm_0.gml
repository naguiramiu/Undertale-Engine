if target_instance != noone 
{
	with target_instance
	function_call(other.func,other.args)
}
else
	function_call(func,args)
	
instance_destroy()