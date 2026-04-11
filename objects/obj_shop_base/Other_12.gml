/// @description TALK

var back_key = back_key_press

if open_menu
	create_tiny_dialogue(tiny_dialogue_text.default_talk_dialogue)

var backout = false
var boxtext = ""

if !item_in_choicer
{
	var prev = item_selection + selecting_exit

	if down_key_press
	{
		if selecting_exit
		{
			item_selection = 0	
			selecting_exit = false
		}
		else
		{
			if item_selection != array_length(talk_options) - 1
			item_selection ++
			else selecting_exit = true
		}
	}

	if up_key_press
	{
		if selecting_exit
		{
			item_selection = array_length(talk_options) - 1	
			selecting_exit = false
		}
		else
		{
			if item_selection != 0
			item_selection --
			else selecting_exit = true
		}
	
	}
	
	if prev != item_selection + selecting_exit
	play_sound(snd_menu_move)
	
	if interact_key
	{
		if selecting_exit
		backout = true 
		else
		{
			var sel = talk[talk_options[item_selection]]
			
			talk_dialogue = create_textbox(sel.dialogue,
			{
				visible: false,
				stop_drawing_after_destroy: false,
				creator_instance: id,
				x: 0,
				y: 115, 
				draw_bg: false,
				let_player_move_end: false,
				do_extend_box: false,
				textbox_position: UP,
			})
			item_in_choicer = true
			interact_key = false
			play_sound(snd_select)
			instance_destroy(tiny_dialogue)
			if sel.goto != -1 
			talk_options[item_selection] = sel.goto
		}
	}
}

if item_in_choicer
{
	draw_menu(0,120,319,120,4) 
	
	var dial_existed = instance_exists(talk_dialogue)
	
	if dial_existed
	{
		with talk_dialogue
			event_user(1)
		draw_reset_all()
	}
	var dial_exists = instance_exists(talk_dialogue)
	
	if dial_existed != dial_exists
	{
		if !dial_exists
		{
			item_in_choicer = false 
			create_tiny_dialogue(tiny_dialogue_text.default_talk_dialogue)
		}
		
	}
	if dial_existed
	exit;
}
else
{
	if instance_exists(tiny_dialogue)
	{
		with tiny_dialogue
			event_user(1)
		
		draw_reset_all()
	}
}

for (var i = 0; i < array_length(talk_options); i++)
{
	if i == item_selection && !selecting_exit
		draw_sprite(spr_soul_text,0,15,134 + 20 * i)
		
	var op = talk[talk_options[i]]
	draw_set_colour(op.highlighted ? c_yellow : c_white)
	draw_text(30,131 + 20 * i,op.title)
}
draw_reset_color()
if selecting_exit
draw_sprite(spr_soul_text,0,15,215)
draw_text(30,211,"Exit")

if back_key || backout
{
	in_submenu = false 
	create_large_dialogue(large_text_dialogue.exiting_menu)
	play_sound(snd_menu_move)
	instance_destroy(tiny_dialogue)
	alarm_set_instant(0,0)
}