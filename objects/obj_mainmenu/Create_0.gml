play_sound(snd_select)
could_move = global.can_move
global.can_move = false 
depth = UI_DEPTH - 100
in_submenu = false
stats_screen = undefined

selected_char = get_char_by_party_position(0)
