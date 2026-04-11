/// @description STAT
var lan = get_lan(lan_main_menu)

if (array_length(global.stats.party) > 1)
{
	selected_char = scr_leftright_modwrap(selected_char,array_length(global.stats.party),function()
	{
		stats_screen = undefined
		play_sound(snd_menu_move)
	})
}

var char = get_char_by_party_position(selected_char)

if is_undefined(stats_screen)
{
	var empty = lan.empty_slot
	var char_weapon = global.items[$char.weapon]
	var char_armor = global.items[$char.armor]
	stats_screen = variable_clone(lan.stats)
	
	var markup_replace =
	{
		name: char.name, 

		lv: char.lv,
		hp: char.hp, max_hp: char.max_hp,
	
		item_attack: scr_get_char_item_attack(char),
		item_defense: scr_get_char_item_defense(char),
		weapon: is_defined(char_weapon) ? char_weapon.name : empty,
		armor: is_defined(char_armor) ? char_armor.name : empty,
	
		xp: char.xp,
		next: get_nex_lvl(char.lv), 
	
		attack: char.attack,
		defense: char.defense,
	
		gold:  global.stats.gold,
	}

	var names = variable_struct_get_names(stats_screen)
	for (var i = 0; i < array_length(names); i++)
	stats_screen[$names[i]] = string_replace_markup_ext(stats_screen[$names[i]],markup_replace)
}

var _x = x + 108
var _y = y

draw_menu(_x - 14,_y + 26,172,208,3) // bg menu

with stats_screen
{	
	draw_text(_x,_y + 43,name) 
	draw_text_linesep(_x,_y + 73,[lv,hp],16) 
	draw_text_linesep(_x,_y + 121,[attack,defense],16) 
	draw_text_linesep(_x + 84,_y + 121,[xp,next],16) 
	draw_text_linesep(_x,_y + 167,[weapon,armor],16) 
	draw_text(_x,_y + 203,gold)
}

if selected_char == 0
{
	if (string_length(char.name) > 6 || !scr_namecheck(char.name).allow)
		draw_text_ext(_x + 84,_y + 43,lan.name_was_edited_response,16,56)
}
if (back_key || interact_key)
{
	selected_char = 0
	stats_screen = undefined
	back_key = false 
	interact_key = false
	in_submenu = false  
	play_sound(snd_menu_move)	
}