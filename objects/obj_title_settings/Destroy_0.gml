destroyed = true
play_sound(snd_menu_move)
if weather_type != -1
globalmusic_stop(true)
do_later(1,function()
{
	if instance_exists(obj_settings_leaves)
	instance_destroy(obj_settings_leaves)
	with obj_title_parent
	{
		visible = true
		event_user(0)
	}
})
scr_settings_save()