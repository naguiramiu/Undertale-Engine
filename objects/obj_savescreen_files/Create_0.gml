file_data = scr_array_fill_savefiledata()
selection = global.information.savefile_num
global.can_move = false

depth = UI_DEPTH - 1
overwritting = false 
overwritting_selection = 0
saved = false
interact = false

lerp_var_ext(id,"start_effect",0.1,0,1)

save = function()
{
	global.information.savefile_num = selection
	play_sound(snd_save)
	save_game()
	file_data = scr_array_fill_savefiledata()
	saved = true
}
