/// @description STAT
var lan = get_lan(lan_main_menu)
var char = selected_char
if !is_defined(stats_screen)
{
	var empty = lan.empty_slot
	var char_weapon = global.items[$char.weapon]
	var char_armor = global.items[$char.armor]
	stats_screen = variable_clone(lan.stats)

	var markup_replace =
	{
		name: char.name, 

		lv: global.stats.lv,
		hp: char.hp, max_hp: char.max_hp,
	
		item_attack: char_weapon.attack + char_armor.attack,
		item_defense: char_weapon.defense + char_armor.defense,
		weapon: is_defined(char_weapon) ? char_weapon.name : empty,
		armor: is_defined(char_armor) ? char_armor.name : empty,
	
		xp: global.stats.xp,
		next: get_nex_lvl(global.stats.lv), 
	
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

if (string_length(char.name) > 6 || !scr_namecheck(char.name).allow)
	draw_text_ext(_x + 84,_y + 43,lan.name_was_edited_response,16,56)

if (back_key || interact_key)
{
	stats_screen = undefined
	back_key = false 
	interact_key = false
	in_submenu = false  
	play_sound(snd_menu_move)	
}