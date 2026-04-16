if instance_exists(instance)
{
	with instance 
	{
		xprevious = x
		yprevious = y
	}
	variable_instance_set(instance,var_name,variable_instance_get(instance,var_name) + amount)

	if amount > 0
	{
		if variable_instance_get(instance,var_name) >= target 
		{
			variable_instance_set(instance,var_name,target)
			advance()
		}
	}
	else
	{
		if variable_instance_get(instance,var_name) <= target 
		{
			variable_instance_set(instance,var_name,target)
			advance()
		}
	}
}