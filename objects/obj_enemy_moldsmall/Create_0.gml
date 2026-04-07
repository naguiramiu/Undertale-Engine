y += 15
x = 3 + scr_enemy_align_to_grid_x(x - 40) + sprite_width / 2

potential_dialogue = [
	"Squorch...",
	"Burble burb...",
	"*Slime sounds*",
	"*Sexy wiggle*"
]

for (var i = 0; i < array_length(potential_dialogue); i++)
potential_dialogue[i] = "{wobble}" + potential_dialogue[i]

add_gold = function(cur)
{
		var monster = global.monsters[cur.act_monster_selection]
		monster.added_gold_mercy = 1
}
actions = 
[
	new enemy_act("Check",check_enemy_desc("* Stereotypical: Curvaceously attractive, but no brains...")),
	new enemy_act("Imitate","* You lie immobile with Moldsmal. You feel like you understand the world a little better.",true,"(Blushes deeply.){wait:15}{&} Ribbit..",add_gold),
	new enemy_act("Flirt","* You wiggle your hips. Moldsmal wiggles back. What a meaningful conversation!",false,"I can't handle this...",add_gold)
]
can_be_spared = true
event_turn_start = function()
{
	bullet = 0
	turn_set_length(240)	
} 

