/// @description Hurt

do_damage_to_monster(mytarget,damage)

done_damage = true 

do_later(60,function()
{
	if instance_exists(obj_targetbar)
		obj_targetbar.fade = true
	if instance_exists(obj_target)
		obj_target.fade = true	
})