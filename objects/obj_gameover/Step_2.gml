if !created 
{
	audio_stop_all()
	var rw = room_width
	var rh = room_height
	room_goto(rm_gameover)
	room_set_width(rm_gameover,rw)
	room_set_height(rm_gameover,rh)
	created = true
}
