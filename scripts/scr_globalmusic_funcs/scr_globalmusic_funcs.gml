function globalmusic_stop(instant = false )
{
	if instance_exists(obj_globalmusicplayer)
	{
		with obj_globalmusicplayer if audio_is_playing(playing_audio)
		{
			var time = (instant ? 0 : audio_data[$audio_get_name(playing_audio)].sound_fade_out_time)
			audio_sound_gain(playing_audio,0,time)
			switching = true
		}
	}
}

function scr_globalaudio_info(mus_id,fade_in_time = 1000,fade_out_time = 1000,can_loop = true,_sound_reset_leftoff = false,_sound_gain = 1,_sound_pitch = 1)
{
	sound_asset = mus_id
	sound_fade_in_time = fade_in_time
	sound_fade_out_time = fade_out_time
	audio_can_loop = can_loop
	sound_gain = _sound_gain
	sound_pitch = _sound_pitch
	sound_reset_leftoff = _sound_reset_leftoff
	if sound_reset_leftoff sound_leftoff = 0
}

function globalmusic_play(mus_id,fade_in_time = 1000,fade_out_time = 1000,loop = true, audio_reset_timeoff = true,sound_gain = 1, sound_pitch = 1)
{
	if !instance_exists(obj_globalmusicplayer)
	{
		var var_struct = {}
		with var_struct scr_globalaudio_info(mus_id,fade_in_time,fade_out_time,loop,audio_reset_timeoff,sound_gain,sound_pitch)
		
		instance_create(obj_globalmusicplayer,
		var_struct)
	}
	else with obj_globalmusicplayer
	{
		if !variable_struct_exists(audio_data,audio_get_name(mus_id)) 
		audio_data[$audio_get_name(mus_id)] = {sound_leftoff: 0}
		
		with audio_data[$audio_get_name(mus_id)]
		scr_globalaudio_info(mus_id,fade_in_time,fade_out_time,loop,audio_reset_timeoff,sound_gain,sound_pitch)
		next_sound = mus_id
	}
}