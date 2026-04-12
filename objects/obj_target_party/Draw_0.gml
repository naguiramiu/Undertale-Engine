x = obj_battlebox.x - obj_battlebox.width / 2
y = obj_battlebox.y - obj_battlebox.height / 2
width = obj_battlebox.width 
height = obj_battlebox.height
draw_set_alpha(image_alpha)
var num = array_length(global.stats.party)
draw_set_font(font_crypt_4)
var padding = 5 
var spacing = 4
var total_x = x + padding
var total_y = y + padding
var total_w = (width - 2) - (padding * 2)
var total_h = (height - 1) - (padding * 2)
var available_h = total_h - (spacing * (num - 1))
var member_h = round(available_h / num)
var start_x_off = 32
var sel_bar_w = total_w * 0.33
var interact = interact_key_press
for (var i = 0; i < num; i++)
{
	var available = array_contains(array_from_struct_value(attacking,"party_member_attacking"),i)
    var draw_y = total_y + (i * (member_h + spacing))
    draw_set_colour(available ? get_char_by_party_position(i).ui_color : c_dkgray)
	draw_line_colour(total_x + start_x_off + sel_bar_w + 3,draw_y + -1.1,total_x + total_w + -24,draw_y + -1.1,draw_get_colour(),c_black)
	draw_line_colour(total_x + start_x_off + sel_bar_w + 3,round(draw_y + member_h ) + 0.2,total_x + total_w,round(draw_y + member_h) + 0.2,draw_get_colour(),c_black)
	draw_rectangle_wh(total_x + start_x_off + 3, draw_y,sel_bar_w, member_h, true)
	if !available continue;
	
	for (var a = 0; a < 3; a ++)
	draw_sprite_stretched_ext(spr_target_arrow,0, round(max(sin((current_time * 0.0075) + a * 208),0)) + total_x + start_x_off + 14 + 26 * a,draw_y + spacing - 0.5,26,member_h - spacing,merge_colour(draw_get_colour(),c_black,(a / 3) * 0.8),(1 + -(abs(sin((current_time * 0.0025) + a * 40) + 0.5) * 0.2)) * draw_get_alpha())
	
    
	draw_set_halign_center()
	draw_text(total_x + start_x_off / 2,draw_y + member_h / 2,"PRESS")
	draw_reset_align()
	draw_sprite_stretched_ext(spr_targetfield_1,current_time / 100,round(total_x + start_x_off + 2),draw_y - 1,8,member_h + 2.5,draw_get_colour(),draw_get_alpha())
	
	if instance_exists(obj_targetbarparty)
	{
		var this = attacking[i]

			for (var b = 0; b < array_length(this.bars); b++)
			with (this.bars[b]) 
			{
				var _base_w = 6
				var _base_h = member_h + 2.5
				var _scaled_w = _base_w * image_xscale
				var _scaled_h = _base_h * image_xscale
				var _draw_x = x - ((_scaled_w - _base_w) / 2)
				var _draw_y_offset = (draw_y - 1) - ((_scaled_h - _base_h) / 2)
				draw_sprite_stretched_ext(sprite_index, 0, _draw_x, _draw_y_offset, _scaled_w, _scaled_h, draw_get_colour(), draw_get_alpha() * image_alpha)
					
				var myid = id
				if instance_exists(obj_targetbarfader)
					with obj_targetbarfader if creator == myid
						draw_sprite_stretched_ext(sprite_index,0,x,draw_y - 1,6,member_h + 2.5,merge_colour(draw_get_colour(),c_white,0.5), (draw_get_alpha() * image_alpha))
			}
	}
}
var target_x = round(total_x + start_x_off + 2)

if interact_key_press
{
	var best_dist = -1
	var found = noone
	with obj_targetbarparty
	{
		if !attacked
		{
			var dist = (x - target_x)
			if (found == noone || dist < best_dist) 
			{
			    best_dist = dist
			    found = id
			}
		}
	}
	if (found != noone)
		{
			found.hspeed = 0
			found.attacked = true
			
			var this = attacking[found.character_done_by]
			with found
			this.damage += targetbar_do_damage(this.party_member_attacking,this.target_monster,target_x)
			
			var all_attacked_row = true 
			with obj_targetbarparty
				{
					if found.character_done_by == character_done_by && !attacked 
					all_attacked_row = false
				}
					
			if all_attacked_row && !this.done_damage
				{ 
					var last_attacker = -1 
					for (var a = 0; a < array_length(attacking); a++)
					if (attacking[a] != this) && !attacking[a].done_damage && attacking[a].target_monster == this.target_monster
					last_attacker = a
					
					if last_attacker != -1 
						attacking[last_attacker].damage += this.damage
					else
					do_damage_to_monster(this.target_monster, this.damage)
					this.done_damage = true
				}
	}
}


var ended = true 
with obj_targetbarparty 
if !attacked ended = false

if !ended alarm[0] = 60

if (ended) 
{
	for (var i = 0; i < array_length(attacking); i++)	
	if !attacking[i].done_damage 
	{
		var this = attacking[i]
		var last_attacker = -1 
		for (var a = 0; a < array_length(attacking); a++)
		if (attacking[a] != this) && !attacking[a].done_damage && attacking[a].target_monster == this.target_monster
		last_attacker = a
					
		if last_attacker != -1 
			attacking[last_attacker].damage += this.damage
		else
		do_damage_to_monster(this.target_monster, this.damage)
		this.done_damage = true
	}
}

if (fade) 
	if image_alpha > 0 image_alpha -= 0.1 
	else
	{
		instance_destroy()	
		battle_next_action()
	}
draw_reset_alpha()