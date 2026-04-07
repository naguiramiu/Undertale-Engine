is_destroyed = true

if variable_instance_exists(id,"event_destroy")
	script_execute_ext(event_destroy,customevent_get_params("destroy"))

if variable_instance_exists(id,"event_battle")
	event_battle()

if variable_instance_exists(id,"event_cutscene")
{
	if do_cutscene_event_at_destroy
		event_cutscene()
}

if !is_option
global.can_move = let_player_move_end


