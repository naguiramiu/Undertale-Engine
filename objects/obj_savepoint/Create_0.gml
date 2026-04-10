depth = -y - 1

var lan = get_lan(lan_savescreen).room_text
if is_undefined(dialogue) && variable_struct_exists(lan,room_get_name(room))
	dialogue = get_lan(lan,room_get_name(room))
	
open_save = function()
{
	play_sound(snd_menu_move)
	instance_create(obj_savescreen)
	global.can_move = false
}