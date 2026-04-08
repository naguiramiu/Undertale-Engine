/// @description ITEM

if instance_exists(item_textbox)
{
	with item_textbox
		event_user(1)
	
	if instance_exists(item_textbox) // it may be destroyed in event user 1 so check again
	exit;
}


var lan = get_lan(lan_main_menu)
var options = [lan.use,lan.info,lan.drop]
var ary = array_length(options)
var inventory = global.stats.inventory
if instance_exists(obj_textbox) exit;

var item_ary = get_number_of_items()

if !item_selecting_bottom // not selecting bottom 
{
	in_item_selection_vertical = scr_updown_modwrap(in_item_selection_vertical,item_ary)
	
	if interact_key
	{
		item_selecting_bottom = true 
		item_bottom_selection = 0	
		play_sound(snd_select)
	}
}
else 
{
	item_bottom_selection = scr_leftright_modwrap(item_bottom_selection,ary)
		
	 if interact_key
	 {
		if item_bottom_selection == 0 && (array_length(global.stats.party) > 1 && !selecting_characters)
		{
			selected_char = 0
			selecting_characters = true 
			play_sound(snd_menu_move)
		}
		else
		{
			play_sound(snd_select)
			do_later(1,function()
			{
				item_selecting_bottom = false
				var inventory = global.stats.inventory
				var selected_item = global.items[$inventory[in_item_selection_vertical]]
				var prev = global.stats.inventory[in_item_selection_vertical]
				var var_struct = 
				{	
					let_player_move_end: false,
					visible: false
				}
			
				switch item_bottom_selection
				{
					case 0:
					item_textbox = use_item_main(
						selected_item,
						in_item_selection_vertical,
						var_struct,,,,selected_char				
					)	
				break;	
				case 1: 
					item_textbox = create_textbox(selected_item.check_description,var_struct)
				break;
				case 2: 
					item_textbox = drop_item(selected_item,in_item_selection_vertical,var_struct)
				break;
				}
				var item_ary = get_number_of_items()
				inventory_clear_empty() 
				
				selecting_characters = false
				item_selecting_bottom = false 
				in_item_selection_vertical = min(item_ary - 1,in_item_selection_vertical)
				if !item_ary
					in_submenu = false
		},,id)
		}
	}
}
			
draw_set_font(font_deter_12)
var _x = x 
var _y = y

draw_menu(_x + 94,_y + 26,172,180,3)

if selecting_characters
{
	var ary = array_length(global.stats.party)
	
	selected_char = scr_updown_modwrap(selected_char,ary)
	
	for (var i = 0; i < ary; i++)
			draw_text(_x + 116,_y + 41 + (16 * i),get_char_by_party_position(i).name)
			
	draw_sprite(spr_soul_text,0,_x + 103, _y + 43 + (16 * selected_char))
}
else 
{
	for (var i = 0; i < array_length(inventory); i++)
		if inventory[i] != ITEM_EMPTY
			draw_text(_x + 116,_y + 41 + (16 * i),global.items[$inventory[i]].name)

	if !item_selecting_bottom draw_sprite(spr_soul_text,0,_x + 103, _y + 43 + (16 * in_item_selection_vertical))

	for (var b = 0; b < ary; b++)
	{
		var bmenu_x = 116 + (48 * b) + (b == 2) * 9
		draw_text(_x + bmenu_x, _y + 181, options[b])
		if b == item_bottom_selection && item_selecting_bottom draw_sprite(spr_soul_text,0,_x + bmenu_x - 13,_y + 183)
	} 
}	
if (back_key) 
{ 
	back_key = false 
	
	if selecting_characters
		selecting_characters = false 
	else 
	{
		if item_selecting_bottom 
			item_selecting_bottom = false
		else
		{
			in_submenu = false
			item_selecting_bottom = false 
			item_bottom_selection = 0
			in_item_selection_vertical = 0
		}
	}
	play_sound(snd_menu_move)
}



/*
var nine = sprite_get_nineslice(spr_sprite127);

// Downscaled
nine.enabled = false;
draw_sprite_ext(spr_sprite127, 0, mxx, myy, 0.5, 0.5, 0, c_white, 1);

// Upscaled
nine.enabled = true;
draw_sprite_ext(spr_sprite127, 0, mxx, myy+ 50, 4, 4, 0, c_white, 1);