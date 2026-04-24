image_xscale = 0.5
image_yscale = 0.5
main_speed = 2
xspd = 0
yspd = 0
can_move = false
can_hitbox = true
global.invframes_timer = 0
image_speed = 0
col_surf = -1



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
				{
					battle_lose()
					can_move = false
				}	
			}
			play_sound(snd_hurt,2,,20)
		}
		if inst.destroy_on_impact instance_destroy(inst)
	}
}

compensate_for_diagonal_speed = function(wadir,spd)
{
	var dir = round(wadir / 45) * 45;
	dir = (dir + 360) % 360;
	if (dir % 45 == 0 && dir % 90 != 0) 
	return spd / 0.7
	return spd
}


//meeting_surface = function(_x = x, _y = y, dist = 10)
//{
//    if (!surface_exists(col_surf)) return false;
//    var _sw = surface_get_width(col_surf);
//    var _sh = surface_get_height(col_surf);
//    if (update_buffer || !buffer_exists(col_buffer))
//    {
//        var _size = _sw * _sh * 4;
//        if (!buffer_exists(col_buffer) || buffer_get_size(col_buffer) != _size) 
//        {
//            if (buffer_exists(col_buffer)) buffer_delete(col_buffer);
//            col_buffer = buffer_create(_size, buffer_fixed, 1);
//        }
//        buffer_get_surface(col_buffer, col_surf, 0);
//        update_buffer = false;
//    }
    
//    var found = false
//    var half = dist / 2
//    for (var iy = _y - half; iy < _y + half; iy++)
//    {
//        for (var ix = _x - half; ix < _x + half; ix++)
//            if (ix >= 0 && ix < _sw && iy >= 0 && iy < _sh)
//            {
//               buffer_seek(col_buffer, buffer_seek_start, ((floor(iy) * _sw + floor(ix)) * 4))
//			   if !(buffer_read(col_buffer, buffer_u32) == 4294967295) 
//			   {
//				    found = true
//					break
//			   }
//            }
//        if (found) break
//    }

//    return found;
//}