/// @description Menu set
initital_cover = 0
can_move = false
in_slider = false
destroyed = false 
value_selection = 0
prev_sel = 0
depth = obj_title_parent.depth - 2 
obj_title_parent.visible = false
event_user(0)
goto_main_settings()
initital_cover = 170

if weather_type != -1
{
	lerp_var_ext(id,"initital_cover",0.04,10,170)
	
	play_sound(snd_harpnoise,2,,3)
	globalmusic_stop(true)
	
	with weather_layout[weather_type]
		globalmusic_play(mus_played,0,,,true)
}