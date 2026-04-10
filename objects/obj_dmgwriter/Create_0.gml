lerp_var_ext(id,"shown_hp",0.05,target.hp + dmg,target.hp,ease_out)
fade = 0
alarm[1] = 35

vspeed = -2
anim = true 

if dmg == 0
{
	vspeed = 0
	anim = false 
	lerp_var_ext(id,"y",0.1,y - 10,y,ease_out)
}