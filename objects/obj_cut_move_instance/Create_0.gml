advance = function()
{
	if instance_exists(cutscene_creator)
	if do_cutscene
		do_later(cutscene_timer,cutscene_next_event,cutscene_creator)
	instance_destroy()	
}