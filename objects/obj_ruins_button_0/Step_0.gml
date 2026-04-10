if image_index == 0 && (place_meeting(x,y,player) || place_meeting(x,y,obj_npc_base))
{
	play_sound(snd_noise,,,2)
	image_index = 1
}