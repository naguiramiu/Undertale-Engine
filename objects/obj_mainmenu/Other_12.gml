/// @description CELL

if instance_exists(item_textbox)
{
	with item_textbox
		event_user(1)
	
	if instance_exists(item_textbox) // it may be destroyed in event user 1 so check again
	exit;
}

var _x = x + 94
var _y = y + 26

draw_menu(_x ,_y ,172,134,3) // bg menu

var cell = ["Call no one"]

for (var i = 0; i < array_length(cell); i++)
	draw_text(116,41 + 16 * i,cell[i])
	
draw_sprite(spr_soul_text,0,103,43 + 16 * cell_selection)

if interact_key 
{
	var var_struct = 
		{	
			let_player_move_end: false,
			visible: false
		}
	
	switch cell_selection
	{
		case 0: 
		item_textbox = create_textbox(["* You dialed no one...","* No one picked up."],var_struct)
		break;
	}
}

if (back_key)
{
	back_key = false 
	in_submenu = false 
	play_sound(snd_menu_move)	
}