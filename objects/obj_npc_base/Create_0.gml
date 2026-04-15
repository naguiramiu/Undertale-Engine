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

prev_was_moving = false
move = -1 
dir_before_dialogue = -1

if is_undefined(dialogue_event_destroy)
dialogue_event_destroy = function(inst)
{
	inst.dir = inst.dir_before_dialogue
}