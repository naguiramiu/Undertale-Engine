if !switching
{
	if next_sound != noone 
	{
		if (audio_get_name(playing_audio) == audio_get_name(next_sound))
			next_sound = noone
		else
		{
			audio_sound_gain(playing_audio,0,audio_data[$audio_get_name(playing_audio)].sound_fade_out_time)
			switching = true
		}
	}
	if !audio_is_playing(playing_audio) switching = true
}
else
{
	if (!audio_is_playing(playing_audio) || audio_sound_get_gain(playing_audio) == 0) && next_sound != noone
	{
		if audio_is_playing(playing_audio)
			audio_data[$audio_get_name(playing_audio)].sound_leftoff = audio_sound_get_track_position(playing_audio)
		switching = false	
		audio_stop_sound(playing_audio) 		
		
		if next_sound != noone
		{
			var newsound = audio_data[$audio_get_name(next_sound)]
			playing_audio = play_sound(next_sound,1,newsound.audio_can_loop,3,newsound.sound_pitch)
			if variable_struct_exists(newsound,"sound_leftoff")
			audio_sound_set_track_position(playing_audio,newsound.sound_leftoff)
			audio_sound_gain(playing_audio,0,0)
			audio_sound_gain(playing_audio,newsound.sound_gain,newsound.sound_fade_in_time)
			next_sound = noone
		}
	}
}