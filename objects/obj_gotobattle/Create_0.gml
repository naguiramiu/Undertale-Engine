depth = UI_DEPTH + 1
global.can_move = false
destroy_instances
(
	[
		obj_textbox,
		obj_mainmenu,
		obj_savescreen,
		obj_savescreen_files,
	]
)
globalmusic_stop()
play_sound(snd_encounter)
soul_progress = 0
darken = false 
draw_chars = true
cutscene_perform_event = false
draw_soul = false
var cutscene = cutscene_create
(
	cut_wait(30),
	cut_set_var(id,"darken",true),
	cut_perform_function(0,set_border,spr_border_simple),
	cut_playsound(snd_noise,,4),
	cut_playsound(snd_noise,,4),
	cut_playsound(snd_noise,,4),
	cut_set_var(id,"draw_soul",true,12),
	cut_set_var(id,"draw_chars",false),
	cut_playsound(snd_battlefall),
	cut_interpolate_var(id,"soul_progress",0.05,0,1,0),
	cut_perform_function(0,instance_create,[obj_battlecontroler,encounter]),
	cut_perform_function(0,instance_destroy,id)
)
cutscene_start(cutscene)