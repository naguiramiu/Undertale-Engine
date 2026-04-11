/// @description EXIT
if open_menu 
{
	with create_large_dialogue(large_text_dialogue.exiting_out)
	{
		max_sentence_width = 301
		event_destroy = function()
		{
			instance_activate_object(parent_char)
			instance_create(obj_roomtransition,
			{
				target_room: rm_dev_testingarea,	
				vertical_dir: 0,
				mywarp: inst_509376C9,
			})	
			player.front_vector = DOWN
		}
		can_skip = true 
		can_advance = true
	}
}

draw_menu(0,120,319,120,4) 

if instance_exists(large_dialogue)
with large_dialogue event_user(1)

draw_reset_all()
