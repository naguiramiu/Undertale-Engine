/// @description Play sound 
if sound_delay_current > 0 sound_delay_current --
else
{	
	var sound_to_play = snd_text_default
	
	if talker_has("sound_to_play")
	sound_to_play = talker.sound_to_play
	
	if !insta_write
	talker.sound_playing = play_sound(sound_to_play,2,,10)
	if talker_has("add_sound_delay")
	sound_delay_current = talker.add_sound_delay
}