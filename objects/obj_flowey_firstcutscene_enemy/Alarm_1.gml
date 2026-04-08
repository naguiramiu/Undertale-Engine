var cut = cutscene_create( 
	add_text("Down here, LOVE is shared through..."),
	add_text("Little white... {.}\"friendliness pellets.\"",true),
	cut_wait(35),
	cut_set_var(obj_flowey_firstcutscene_enemy,"sprite_index",spr_flowey_side_1,-1),
	add_text("Are you ready?",true),
	cut_set_var(obj_flowey_firstcutscene_enemy,"sprite_index",spr_flowey_dialogue,-1),
	cut_perform_function(0,function()
	{
		with obj_friendlypellet
		{
			direction = point_direction(x,y,obj_soul.x,obj_soul.y)
			speed = 2
		}
	}),
	add_text("Move around!{.&}Get as many as you can!",true,false),
	cut_wait(60), 
	destroy_dialogue(),
	cut_wait(60),
	cut_perform_function(0,function()
	{
		var char = get_char_by_party_position(0)
		if char.hp < char.max_hp exit;
		
		
		
		
	})
)
cutscene_start(cut)

repeat 5 
instance_create_depth(x + 21,y + 23,obj_battlebox.depth - 10, obj_friendlypellet)

sprite_index = spr_flowey_side_0

//my_dialogue = create_speechbubble(
//[
//	"Down here, LOVE is{&}shared through...",
//	"Little white..." + "{.&}" + "{event:change_flowey_sprite}" + "\"friendliness pellets.\"",
//	"What's LV stand for?{.&}Why, LOVE, of course!",
//	"You want some LOVE, don't you?",
//	"Don't worry,{&}I'll share some{&}with you!",
//],
//x + 62.5,
//y + 5.5,
//x,
//y + 15,
//140,
//{ 
//	talker: global.talker.flowey_default,
//	event_destroy: obj_flowey_firstcutscene_controller.first_dialogue_end_event,
//	event_new_page:  function()
//	{
		
		
		
//	}
	
//	//can_skip: false,
//})

