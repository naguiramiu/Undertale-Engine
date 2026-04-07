function get_char_by_party_position(pos, stats = global.stats)
{
	return get_char_by_id(stats.party[pos],stats)
}

function get_char_by_id(character_id,stats)
{
	var chars = struct_get_names(stats.char)
	for (var i = 0; i < array_length(chars); i++)
	if stats.char[$chars[i]].id == character_id return stats.char[$chars[i]]
	
	show_message("id is invalid!: " + string(character_id))
	return get_char_by_id(0,stats) // in case the id is invalid 
}
