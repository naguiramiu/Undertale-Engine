
enum e_battle_menus 
{
	main = -1,
	fight,
	act,
	item,
	mercy,
}


/* 
	You might not know this but deltarune uses a priority system for attacks and its crucial
   Think about it, if you, with kris, killed a monster, and then tried to act with susie on it, what would happen?
   It's dead, it cant happen. And you cant just act on another monster, since its actions are different.
   
   So deltarune does this really smart priority thing.
   
   it goes like this 
   
   ACTing ALWAYS goes first (higher priority)
   then everything else (items, mercy, healing spells)
   
   Then the before attack event (Attack spells, susie's rude buster, iceshock)
   
   Then at last, the attack events. FIGHTing.
*/
enum e_battle_priority
{
	act = 1,
	regular = 0,	
	before_attack = -1,
	attack = -2
}

enum e_bordertype
{
	not_enabled,		
	simple,
	enabled
}


enum e_fileselect_menu 
{
	base,
	copy,
	erase,
	languages, 
	keys
}
	
enum e_operator
{
	add ,
	subtract,
	multiply, 
	divide,
	modulo,
	int_div,
	array
}

enum e_settingstype 
{
	boolean,
	slider,
	event,
	result,
	key,
	array
}

enum e_waitforinput_type 
{
	anykey,
	player_move,
	interact_key
}