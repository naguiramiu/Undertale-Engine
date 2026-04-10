prev_sprite_test = ""
if is_defined(talker)
dialogue_var_struct.talker = talker
depth = -y 
my_dialogue = noone
img = 0
if !is_string(sprite_name)
sprite = sprite_get_name(sprite_name)
sprite = noone
prev_path_speed = 0
if !can_collide
	mask_index = spr_no_collision
else mask_index = -1

path_look_down_when_stopped = true
prev_was_moving = false

move = -1 
movespeed = 1