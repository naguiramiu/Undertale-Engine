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
		toriel:
		{
			sound_to_play: snd_texttor,
			sprite_animate_talking : true
		}
	}
}