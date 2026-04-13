image_xscale = 0.5
image_yscale = 0.5
main_speed = 2
xspd = 0
yspd = 0
can_move = false
can_hitbox = true
global.invframes_timer = 0
image_speed = 0

scr_party_hpaverage = function()
{
    var total_hp = 0
    var total_max_hp = 0
    var ary = array_length(global.stats.party)

    for (var i = 0; i < ary; i++)
    {
			var char = get_char_by_party_position(i)
            total_hp += char.hp 
            total_max_hp += char.max_hp
    }
	
	var average = total_hp / total_max_hp
	
    if (total_hp > 0)
        return average
        return 0
}

scr_battle_gettargetnum = function() 
{
	var target = scr_randomtarget()
	var char = get_char_by_party_position(target)
	
      if ((char.hp / char.max_hp) < (scr_party_hpaverage() / 2))
	  {
                target = scr_randomtarget()
				char = get_char_by_party_position(target)
	  }
	  if ((char.hp / char.max_hp) < (scr_party_hpaverage() / 2))
	  {
                target = scr_randomtarget()
				char = get_char_by_party_position(target)
	  }

      if (target == 0 && (char.hp / char.max_hp) < 0.35)
		  target = scr_randomtarget()	
		  
	return target
}

scr_randomtarget = function()
{
	var ary = array_length(global.stats.party) - 1
	var candidate = irandom(ary)
	
	while get_char_by_party_position(candidate).hp <= 0 
	candidate = irandom(ary)
	
	return candidate
	
}

damage_calculation = function(base_damage,char_num)
{
	var char = get_char_by_party_position(char_num)
    var defense = 0 
	
	if char.weapon != ITEM_EMPTY 
	defense += global.items[$char.weapon].defense
	if char.armor != ITEM_EMPTY 
	defense += global.items[$char.armor].defense
	
    var max_hp = char.max_hp
    var hpthresholda = max_hp / 5
    var hpthresholdb = max_hp / 8

    for (var i = 0; i < defense; i++)
    {
        if (base_damage > hpthresholda)
            base_damage -= 3
        else if (base_damage > hpthresholdb)
            base_damage -= 2
        else
            base_damage -= 1
    }

    return max(base_damage, 1)

}


get_hit = function(inst)
{
	var chosen = scr_battle_gettargetnum()
	var char = get_char_by_party_position(chosen)	
			
	if global.invframes_timer == 0 && instance_exists(inst)
	{
		global.invframes_timer = inst.myinvframes
		image_index = 1
		var damage = damage_calculation(inst.damage,chosen)
			
		if is_method(inst.event_hit)
		inst.event_hit(); 
			
		if !instance_exists(inst) return false
		if inst.damage > 0 
		{
			shake_camera(3,1.5)	
			char.hp -= damage
			var col = c_white
			if char.hp <= 0 
			{
				char.hp = 0 //round(-char.max_hp / 2)
				col = c_red
				var defeated = 0
				var ary = array_length(global.stats.party)
				for (var i = 0; i < ary; i++)
				if get_char_by_party_position(i).hp <= 0 defeated ++
				
				if defeated == array_length(global.stats.party)
					battle_lose()
			}
			play_sound(snd_hurt,2,,20)
		}
		if inst.destroy_on_impact instance_destroy(inst)
	}
}