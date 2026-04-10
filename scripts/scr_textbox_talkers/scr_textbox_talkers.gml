function scr_textbox_talkers(){
	
	global.talker = 
	{
		battle:
		{
			sound_to_play: snd_text_battle
		},
		flowey_default:
		{
			sprite_name: "spr_flowey_dialogue",
			sound_to_play: snd_floweytalk,
			sprite_animate_talking : true
		},
		flowey_evil:
		{
			sprite_name: "spr_flowey_dialogue",
			sound_to_play: snd_floweytalk2,
			sprite_animate_talking : true
		},
		toriel_blink:
		{
			post_sprite: spr_toriel_neck,
			sprite_name: "spr_face_toriel_blink",
			sound_to_play: snd_texttor,
			sprite_animate_blinking: true 
		},
		toriel:
		{
			post_sprite: spr_toriel_neck,
			sprite_name: "spr_face_toriel_talk",
			sound_to_play: snd_texttor,
			sprite_animate_talking : true
		}
	}
}