if escape_key_hold
	quitting_time += 0.075
else if quitting_time > 0 quitting_time = lerp(quitting_time,0,0.2)
	
draw_sprite_ext(spr_quitting_message,min(3,quitting_time * 2),cam_x,cam_y,0.5,0.5,0,c_white,quitting_time)
if quitting_time > 3 game_end()