if !audio_exists(sound_asset) 
	show_poppup("Error: Sound asset loaded doesn't exist or is undefined")

audio_data = {}
audio_data[$audio_get_name(sound_asset)] = {}

with audio_data[$audio_get_name(sound_asset)]
scr_globalaudio_info(other.sound_asset,other.sound_fade_in_time,other.sound_fade_out_time,other.audio_can_loop,other.sound_reset_leftoff,other.sound_gain,other.sound_pitch)

var newsound = audio_data[$audio_get_name(sound_asset)]
playing_audio = play_sound(newsound.sound_asset,1,newsound.audio_can_loop,3,newsound.sound_pitch)
audio_sound_gain(playing_audio,0,0)
audio_sound_gain(playing_audio,newsound.sound_gain,newsound.sound_fade_in_time)

next_sound = noone
switching = false