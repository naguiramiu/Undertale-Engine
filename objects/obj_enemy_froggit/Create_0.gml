y += 10

hp /= 2
x = scr_enemy_align_to_grid_x(x) + sprite_width / 2
can_be_spared = true
potential_dialogue = ["Ribbit, ribbit.","Croak, croak.","Hop, hop.","Meow."]
actions = 
[
	new enemy_act("Check",check_enemy_desc("* Life is difficult for this enemy.")),
	new enemy_act("Compliment","* Froggit didn't understand what you said, but was flattered anyway.",true,"(Blushes deeply.){wait:15}{&} Ribbit.."),
	new enemy_act("Threaten","* Froggit didn't understand what you said, but was scared anyway.",true,"Shiver, shiver.")
]

event_turn_start = function()
{
	bullet = 0
	turn_set_length(240)	
} 

spared = function(monster)
{
	if !monster.can_be_spared
	show_message("HAHA I CANT BE SPARED!")
}

