/// @description critical error, game couldnt load 
/* 
	This is probably meaningless but just in case that somehow loading the 
	audiogroups fail or the game is so messed up that it crashed right when 
	you open it, sends you to dogcheck,
*/
window_custom_reset(window_get_fullscreen())
var hashstrings = string_repeat("#",48)
var error_message = hashstrings + "\nCritical error!\n" + hashstrings + "\n"
show_message(crashfile_write(error_message))
room_goto(rm_dogcheck)