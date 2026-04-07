global.can_move = let_player_move_start 
if !is_array(dialogue) dialogue = [dialogue]

text_written = false
markups = [] 
current_page = 0
color_current = color

if is_option || array_length(options)
	can_destroy = false

sound_delay_current = 0
getting_details = false
max_height = 0
is_destroyed = false

talker_has = function(name) {return variable_struct_exists(talker,name)}

event_user(0)
