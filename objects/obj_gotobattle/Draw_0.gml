with player 
	draw_sprite(spr_alert,0,x,-4+ y - sprite_height)

if darken 
{
	screen_cover()
	
	if draw_chars
		array_foreach(get_party_array_by_depth(),function(me) {	with me event_perform(ev_draw,ev_draw_normal) })
}

if audio_is_playing(snd_noise) || draw_soul
	draw_sprite_ext(spr_soul,0,ease_out(soul_progress,player.x - 2,cam_x + 17.5 + 6),ease_out(soul_progress,player.y - 12,cam_y + 227),0.5,0.5,0,c_white,1)