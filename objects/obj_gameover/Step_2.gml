if !created 
{
	x = obj_soul.x 
	y = obj_soul.y 
	audio_stop_all()
	var rw = room_width
	var rh = room_height
	room_goto(rm_deathscreen)
	room_set_width(rm_deathscreen,rw)
	room_set_height(rm_deathscreen,rh)
	created = true
}
