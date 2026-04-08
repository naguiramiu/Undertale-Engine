if sprite_talk
{
	if instance_exists(my_dialogue) && audio_is_playing(my_dialogue.sound_playing)
	image_speed = 1
	else 
	{
		image_speed = 0 
		image_index = 0
	}
}
draw_self()
