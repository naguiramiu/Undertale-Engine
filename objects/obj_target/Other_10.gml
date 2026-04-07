/// @description Hurt

var m = global.monsters[mytarget]

m.hp -= damage

do_later(20,
function(m)
{
	instance_create_depth(m.x + 15, m.y - 34, m.depth - 2, obj_dmgwriter, {target: m, dmg: damage})
	instance_create(obj_enemy_attacked_shake,{enemy: m})
	
	do_later(40,function(m)
	{
		if (m.hp <= 0) // enemy died 
		{
			if variable_instance_exists(m,"event_defeated")
				with m event_defeated()
			
			obj_battlecontroler.added_gold += m.added_gold_defeated
			obj_battlecontroler.added_xp += m.added_xp_defeated 
			
			instance_create(obj_vaporized,{target: m})
			m.can_be_selected = false;
		}
		
		obj_targetbar.fade = true
		obj_target.fade = true
		
		battle_next_action()
	},m)
	
},m)


instance_create_depth(m.x, m.y - 5, m.depth - 1,obj_slice,{stretch: m.sprite_height});
 