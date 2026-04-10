if (move) 
{
	move_towards_point(obj_battlebox.x,obj_battlebox.y,0.25)
	if place_meeting(x,y,obj_soul)
		obj_flowey_firstcutscene_controler.final_event()
}

