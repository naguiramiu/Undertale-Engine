x = cam_x 
y = cam_y

draw_menu(x + 8,y + 8,304,224,3)
draw_set_font(font_deter_12)
draw_set_halign_center()
draw_text(x + 83, y + 16, "INVENTORY")
draw_text(x + 234, y + 16, "BOX")
draw_text(x + 158, y + 204, "Press [X] to Finish")
draw_reset_align()

var inventories = ["inventory","storage_box"]

if right_key_press || left_key_press
	{
		selected_collumn = !selected_collumn
		play_sound(snd_menu_move)
		selection = clamp(selection,0,array_length(global.stats[$inventories[selected_collumn]]) - 1)
	}
var interact = interact_key_press
for (var column = 0; column < 2; column ++)
{
	var inv = global.stats[$inventories[column]]
	var selected = (selected_collumn == column)
	var cx = x + 151 * column
	var ary = array_length(inv)
	if (selected)
		{
			var prev = selection
			
			if keyboard_check_holdpress(vk_down)
				selection = modwrap(selection,1,ary)
			if keyboard_check_holdpress(vk_up)
				selection = modwrap(selection,-1,ary)
			
			if (prev != selection) play_sound(snd_menu_move)
			
			if (interact) && inv[selection] != ITEM_EMPTY
			{
				var other_inv = global.stats[$inventories[!column]]
				var other_ary = array_length(other_inv)
				var other_amount = get_number_of_items(other_inv)
				if (other_amount == other_ary)
					play_sound(snd_cantselect)
				else
				{
					other_inv[other_amount] = inv[selection]
					inv[selection] = ITEM_EMPTY
					play_sound(snd_select)
					inventory_clear_empty(inv)
				}
				interact = false
			}
			draw_sprite(spr_soul_text,0,cx + 19, y + 40 + 16 * selection)
		}

	for (var i = 0, num_of_items = get_number_of_items(inv); i < ary; i++)
	{
		if i >= num_of_items 
		{
			draw_set_colour(c_red)
			draw_line(cx + 78 / 2,y + (92 / 2) + 16 * i,cx + 258 / 2,y + (92 / 2) + 16 * i)	
			continue;
		}
	
		var item = get_item_by_id(inv[i])
		draw_text(cx + 34, y + 37 + (i * 16),item.name)
		
	}
	draw_reset_color()
	draw_line(x + 160 + column,y + 46,x + 160 + column,y + 46 + 150)
}

if (back_key_press)
{
	instance_destroy()
	global.can_move = true
	play_sound(snd_menu_move)
}