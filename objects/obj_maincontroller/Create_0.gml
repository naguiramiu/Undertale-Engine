depth = UI_DEPTH + 100
quitting_time = 0

can_open_menu = function()
{
	if !instance_exists(player) return false;
	if !global.can_move return false;
	var instances = [obj_textbox]
	for (var i = 0; i < array_length(instances); i++)
	if instance_exists(instances[i]) return false;
	return true;
}