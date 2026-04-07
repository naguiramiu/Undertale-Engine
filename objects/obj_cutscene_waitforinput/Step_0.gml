switch input 
{
	case e_waitforinput_type.anykey: 
		if keyboard_check(vk_anykey) && keyboard_lastkey != vk_nokey
			instance_destroy()
	break;
	case e_waitforinput_type.player_move:
		movement += (max(abs(player.y - player.yprevious),abs(player.x - player.xprevious)))
		if movement >= hold_timer
		instance_destroy()
	break;
	case e_waitforinput_type.interact_key:
	if hold 
	{
		if interact_key_hold holding_for ++
		else holding_for = 0
		
		if holding_for >= hold_timer
		instance_destroy()
	}
	else if interact_key_press
		instance_destroy();
	break;
}