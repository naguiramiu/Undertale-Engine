var m =  global.monsters[obj_target.mytarget]

if (hspeed > 0)
{
    if (x > (obj_target.x + obj_target.sprite_width / 2))
        outside = true;
}
else
{
    if (x < obj_target.x - obj_target.sprite_width / 2)
        outside = true;
}

if (outside)
{
    damage = 0
    instance_destroy();
    exit;
}


if (image_speed == 0)
{
    if interact_key_press
    {
        hspeed = 0;
		
		var char = get_char_by_party_position(0)
		
		var weapon_attack = 0
		if char.weapon != ITEM_EMPTY
			weapon_attack = global.items[$char.weapon].attack
		var armor_attack = 0
		if char.armor != ITEM_EMPTY
			armor_attack += global.items[$char.armor].attack
		
		var damage = ((char.attack + weapon_attack + 10) - m.defense) + random(2);

        var bonusfactor = abs(x - obj_target.x);

        if (bonusfactor == 0)
            bonusfactor = 1;
        
        var _stretch = (obj_target.sprite_width - bonusfactor) / obj_target.sprite_width;
        
        if (bonusfactor <= 12)
           damage = round(damage * 2.2);
        
        if (bonusfactor > 12)
           damage = round(damage * _stretch * 2);
        
		var is_last = true 
		with obj_targetbar
		{
			if id != other.id 	
			if image_speed == 0 
			is_last = false
		}
		obj_target.damage += damage
		if is_last 
		{
			with obj_target 
				event_user(0)
	       
	        image_speed = 0.4;
		}
    }
}

if fade 
{
	if image_alpha > 0 image_alpha -= 0.1 
	else instance_destroy()
}