depth = UI_DEPTH - 200

with (all) 
	if variable_instance_exists(id,"event_room_warp_start")	
		event_room_warp_start()
		
global.can_move = false;
room_surf = -1
started = false