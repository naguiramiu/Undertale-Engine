potential_dialogue = [
	"I'm sorry...",
	"*sniff, sniff*",
	"I have no choice.." ,
	"Forgive me..."
]

run_away = function(cur)
{
	var monster = is_struct(cur) ? global.monsters[cur.act_monster_selection] : cur
	play_sound(snd_vaporized)
	instance_create(obj_spare_monster,{ target_instance: monster.id}).depth = monster.depth - 1
	monster.can_be_selected = false
}

depth = obj_battlebox.depth -10
actions = 
[
	new enemy_act("Check",check_enemy_desc("* This monster is too sensitive to fight...")),
	new enemy_act("Console","* Halfway through your first word, Whimsun bursts into tears and runs away.",true,"(Blushes deeply.){wait:15}{&} Ribbit..",,run_away),
	new enemy_act("Terrorize","* You raise your arms and wiggle your fingers. Whimsun freaks out!",false,"I can't handle this...",function(cur)
	{
		var monster = global.monsters[cur.act_monster_selection]
		monster.terrorized = true
	})
]



event_speechbubble_destroy = function(monster)
{
	if monster.terrorized 
		monster.run_away(monster)
}

event_battlebox_appear = function()
{
	if true
	{
		do_later(5,function()
		{
			lerp_var_ext(obj_battlebox,"image_angle",0.1,0,45)
		})
		global.battlebox_width = global.battlebox_height		
	}
}

event_turn_start = function()
{
	if can_be_selected 
	{
		//if !monster_is_alive(obj_enemy_froggit)
	
		bullet = [0,0]
		turn_set_length(240)	
	}
} 

terrorized = false