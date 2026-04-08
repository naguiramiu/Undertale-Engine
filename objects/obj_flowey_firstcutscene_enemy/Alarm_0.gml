instance_deactivate_object(parent_char)

final_event() exit;
var cut = cutscene_create
(
	add_text("See that heart?{.&}That is your SOUL, the very culmination of your being!"),
	add_text("Your SOUL starts off weak, but can grow strong if you gain{&}a lot of LV."),
	add_text("You want some LOVE, don't you?"),
	add_text("Don't worry,{&}I'll share some{&}with you!"),
	destroy_dialogue(),
	cut_perform_function(-1,function()
	{
		if instance_exists(obj_guidearrows)
			instance_destroy(obj_guidearrows)
	
		with obj_flowey_firstcutscene_enemy
		{
			sprite_index = spr_flowey_wink
		
			instance_create_depth(x + 20,y + 5,depth - 10,obj_event_performer,
			{
				image_xscale: 0.5,
				image_yscale: 0.5,
				friction: 0.8,
				speed: 8,
				timer: 60, 
				sprite_index: spr_winkstar,
				event_draw: function()
				{
					if (timer < 30)
				    image_alpha -= 0.1;

					image_angle += 8;
					direction = image_angle
					if timer > 0 timer --
					else instance_destroy()
			
					draw_self()
				}
		
			})
			
			alarm[1] = 60
		}
	})
)

cutscene_start(cut)