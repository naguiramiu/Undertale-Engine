if !created // this create event runs every turn end, except for this
	battle_start()

selected_char_number = 0

while (get_char_by_party_position(selected_char_number).hp <= 0) && selected_char_number != array_length(global.stats.party)
	selected_char_number ++ 

if (array_length(global.stats.party) > 1)
	menu_buttons_lerp(selected_char_number)

if check_battleend() // check if somehow the monsters died in the battle and if so, win
{
	battle_started = true // battle isnt actually started this just makes it so you can move
	do_later(10,battle_win)
	exit;
}
alarm[0] = 10 // dialogue default
controler_can_move = true

#region variables

battle_started = false

var ary = array_length(global.stats.party)
current_character_selections = array_create_struct_unique(ary,
{
	fight_selection: 0,
	
	act_monster_selection: 0,
	act_selection: 0,
	item_yoff: 0,
	item_selection: 0,
	item_page: 0,
	item_char_selection: 0,
	prev_inventory: [],
	in_submenu: false,
	in_submenu2: false,
	mercy_selection: 0,
	spare_monster_selection: 0,
	main_menu_selection: 0,
})

// ensure you cannot select a wrpng menu
current_character_selections[selected_char_number].main_menu_selection = modwrap(0,0,4,get_unavailable_battle_menus(selected_char_number))

actions = array_create(ary,-1)
#endregion
scr_checkforduplicate()
