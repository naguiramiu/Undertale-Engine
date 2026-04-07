///@desc Start game
/* 
	First code the game runs
	This is best in create and not on game start for when you reset the game
	audiogroups are loaded here
	they must be checked for already being loaded in case of game_restart()
*/
scr_gamepad_keys_initialize()
audiogroups_load()
display_reset(false,true) // enable v-sync
window_custom_reset(window_get_fullscreen(),true,e_bordertype.enabled);