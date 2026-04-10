/// @description Deal damage

hspeed = 0;
var m =  global.monsters[obj_target.mytarget]
	
var char = get_char_by_party_position(0)
		
var weapon_attack = 0
if char.weapon != ITEM_EMPTY
weapon_attack = global.items[$char.weapon].attack
var armor_attack = 0
if char.armor != ITEM_EMPTY
armor_attack += global.items[$char.armor].attack
		
damage = ((char.attack + weapon_attack + 10) - m.defense) + random(2);

var bonusfactor = abs(x - obj_target.x);

if (bonusfactor == 0)
bonusfactor = 1;
        
var _stretch = (obj_target.sprite_width - bonusfactor) / obj_target.sprite_width;
        
if instance_number(obj_targetbar) > 1
{
	var perfect = (bonusfactor <= 4)
	play_sound(perfect ? snd_multibar_notperfect : snd_multibar_notperfcet) 
	if perfect 
	{
		image_blend = c_yellow
		damage *= 2	
	}
}
if (bonusfactor <= 12)
damage = round(damage * 2.2);
        
if (bonusfactor > 12)
damage = round(damage * _stretch * 2);
		  
attacked = true  
obj_target.damage += damage
image_speed = 0.4;