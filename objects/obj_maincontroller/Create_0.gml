depth = UI_DEPTH + 100
quitting_time = 0

can_open_menu = function()
{
	if !instance_exists(player) return false;
	if !global.can_move return false;
	if instances_exist([obj_textbox,obj_gotobattle])
		return false
	return true;
}