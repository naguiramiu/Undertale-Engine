instance_create_depth(0,0,depth - 1,obj_empty).sprite_index = spr_title_boards_hole

main_cutscene = instance_create(obj_cutsceneplayer)

dialogue_var_struct = 
{
	max_sentence_width: 580,
	written: false,
	event_pagewritten: cutscene_next_event, // make it so it triggers next cutscene event upon finishing writing
	event_pagewritten_parameters: main_cutscene,
	x: 13,
	y: -10,
	letter_spacing: 1,
	monospaced: true,
	do_extend_box: false,
	can_advance: false, 
	draw_bg: false,
	can_skip: false,
	write_speed: 0.5,
	talker: {sound_to_play: snd_text_battle}
} 

cutscene_perform_event = false

var set_frame = function(img) {return [variable_instance_set,obj_title_story,"image_index",img]}
var write_text = function(dialogue)
{	
	cutscene_hold_arguments
	create_textbox(dialogue,obj_title_story.dialogue_var_struct)
	cutscene_pause()
} 

var next_page = function(time)
{ 
	cutscene_hold_arguments
	cutscene_pause(obj_title_story.main_cutscene)

	do_later(time,function()
		{
		// set the cutscene to stop
		lerp_var_ext(obj_title_story,"image_alpha",0.075,1,0,,,
		{ 
			event_destroy: function() // fade out
			{
				if instance_exists(obj_textbox)
					instance_destroy(obj_textbox) // destroy the text 
				obj_title_story.image_index ++ // go to the next image in the introduction 
				cutscene_next_event(obj_title_story.main_cutscene)
		
				lerp_var_ext(obj_title_story,"image_alpha",0.075,0,1) 	// fade back in
			}
		})
	})
}
var fade = function(_start,_end,spd = 0.075) {return [cut_interpolate_var,obj_title_story,"image_alpha",spd,_start,_end,0]}

var cut = cutscene_create
(
	cut_wait(5),
	[globalmusic_play,mus_story,0,100,true,false,(global.settings.mus_volume / 100),0.91],
	write_text("Long ago, two races{&}ruled over Earth:{.&}HUMANS and MONSTERS."),
	next_page(54),
	write_text("One day, war broke{&}out between the two{&}races."),
	next_page(55),
	write_text("After a long battle,{&}the humans were{&}victorious."),
	next_page(70),
	write_text("They sealed the monsters{&}underground with a magic{&}spell."),
	next_page(49),
	write_text("Many years later{,}.{,}.{.}.    "),
	next_page(43),
	write_text("      MT. EBOTT{&}         201X"),
	next_page(79),
	write_text("Legends say that those{&}who climb the mountain{&}never return."),
	next_page(80),
	next_page(160),
	next_page(160),
	cut_wait(160),
	fade(1,0),
	cut_set_var(id,"y",-212,0),
	cut_set_var(id,"sprite_index",spr_title_longboard),
	fade(0,1),
	cut_wait(140),
	cut_interpolate_var(id,"y",0.0045,-212,17,200),
	fade(1,0,0.05),
	cut_perform_function(0,globalmusic_stop),
	cut_perform_function(0,room_goto,rm_titlescreen)
)

with (main_cutscene) 
	cutscene_start_self(cut)

var cut2 = cutscene_create
(
	cut_waitforinput(e_waitforinput_type.interact_key),
	cut_interpolate_var(obj_camera,"screen_darken",0.1,0,1,0),
	cut_perform_function(0,globalmusic_stop),
	cut_perform_function(0,room_goto,rm_titlescreen),
)
cutscene_start(cut2)

if global.settings.dev.on
instance_create_depth(0,0,depth - 3,obj_event_performer,
{
	event_draw: function()
	{
		if keyboard_check_pressed(vk_add)
		{
			load_game(global.settings.selected_file)
			globalmusic_stop(true)
			audio_stop_all()
		}
	}
})