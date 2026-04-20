if (push_player) && (instance_exists(player))
{
    var _dir = point_direction(x, y, player.x, player.y);
	var _too_much = 0
    while (place_meeting(x, y, player))	
    {
        player.x += lengthdir_x(1, _dir);
        player.y += lengthdir_y(1, _dir);
		_too_much ++;
		if (_too_much > 1000)
			{
				with (room_get_custom_info(room))
				scr_teleport_player(x,y,true);
				break;	
			}
    }
}