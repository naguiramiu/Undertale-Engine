/// @description ITEM
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
				stop_drawing_after_destroy: true
			}
			
			switch item_bottom_selection
			{
				case 0:
				use_item_main(
					selected_item,
					in_item_selection_vertical,
					var_struct					
				)	
				break;	
				case 1: 
					create_textbox(selected_item.check_description,var_struct)
				break;
				case 2: 
					drop_item(selected_item,in_item_selection_vertical,var_struct)
				break;
				}
				var item_ary = get_number_of_items()
				inventory_clear_empty() 
				
				item_selecting_bottom = false 
				in_item_selection_vertical = min(item_ary - 1,in_item_selection_vertical)
				if !item_ary
					in_submenu = false
		},,id)
	}
}
			
draw_set_font(font_deter_12)
var _x = x 
var _y = y

draw_menu(_x + 94,_y + 26,172,180,3)


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
		
if (back_key && !selecting_characters) 
{ 
	back_key = false 
	if item_selecting_bottom 
		item_selecting_bottom = false
	else
	{
		in_submenu = false
		item_selecting_bottom = false 
		item_bottom_selection = 0
		in_item_selection_vertical = 0
	}
	play_sound(snd_menu_move)
}