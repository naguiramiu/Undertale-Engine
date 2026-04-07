/// @description Draw event

var current_dialogue = dialogue[current_page]
text_written = (letter_drawn_current >= string_length(current_dialogue))

play_sound_this_frame = false
start_x = 46
current_y = 15

if !getting_details
{
	if !text_written && write// progress the text
	{
		var prev = letter_drawn_current
		letter_drawn_current += write_speed
		text_written = (letter_drawn_current >= string_length(current_dialogue))
		
		if (floor(prev) != floor(letter_drawn_current)) && string_char_at(current_dialogue,letter_drawn_current) != " "
		play_sound_this_frame = true
	}
	
	if text_written && !prev_written // page written event
	{
		if (!is_option && array_length(options) && (current_page  == array_length(dialogue) - 1)) 
			instance_create_depth(0,0,depth - 1,obj_textoptioncontroller,{options: options, creator: id, diagonal: options_diagonal})

		write = false
		
		if variable_instance_exists(id,"event_pagewritten")
			script_execute_ext(event_pagewritten,customevent_get_params("pagewritten"))
	}
	prev_written = text_written
	
	
	if ((open_menu_key_press || back_key_press) && letter_drawn_current > 1) && !text_written
	{
		if can_skip
		{
			letter_drawn_current = string_length(current_dialogue)  // set the writing progress to the last character
			page_skipped = true
		}
	}

	if (((text_written || (is_speechbubble)) 
	&& (interact_key_press || open_menu_key_press))) && can_advance
	{
		if current_page < array_length(dialogue) - 1
		{
			current_page ++ 
			event_user(0) // get info about the new page
		} 
		else if can_destroy
		{
			is_destroyed = true
			instance_destroy()
			if stop_drawing_after_destroy 
			exit;
		}
	}

	var drawn_x = x + cam_x 
	var drawn_y = y + cam_y  
	
	if is_option // center align
	{
		drawn_x -= max_width / 2
		drawn_y += max_height / 2
	}
	drawn_x = round(drawn_x)
	drawn_y = round(drawn_y)
	
	var sentence_y_offset = (do_extend_box ? (max(0, page_sentence_ammount - 3) * line_separation) : 0)

	if (textbox_position == DOWN) // draw below or above
	{
		drawn_y += 155
		drawn_y -= sentence_y_offset
	}
	
	draw_set_alpha(image_alpha)
	
	if draw_bg
	{
		if talker_has("textbox_bg")
		draw_sprite_ext(talker.textbox_bg,0,drawn_x , drawn_y,2,2,0,c_white,draw_get_alpha())
		else
		draw_menu(drawn_x + 16,drawn_y + 5, 288,75 + sentence_y_offset,3,c_white)
	}
	
	if is_speechbubble
		scr_textbox_draw_speechbubble(drawn_x,drawn_y)
		
	if talker_has("sprite_name") // dialogue sprites
	{
		var sprite_name = talker.sprite_name
		if talker_has("sprite_emotion") sprite_name += talker.sprite_emotion
		var sprite = asset_get_index(sprite_name) ?? spr_textbox_error
		draw_sprite_ext(sprite,0,drawn_x + 69,drawn_y + 40,2,2,0,c_white,draw_get_alpha())
		start_x += 116
	}
}
draw_set_font(font_current)
draw_set_color(color_current)
current_x = start_x

if string_starts_with(current_dialogue,"* ")
current_x -= (16 * letter_width)

var words = string_split(current_dialogue," ")
var current_word = 0

if is_option && option_num == obj_textoptioncontroller.option_selected && obj_textoptioncontroller.created
{
	draw_sprite(spr_soul_text,0,drawn_x + current_x + -14,drawn_y + 1.5 + current_y)	
}
for (var i = 1; i <= string_length(current_dialogue); i++)
{

	if !(i <= letter_drawn_current) && !getting_details break;
	
	char = string_char_at(current_dialogue,i)
	stop_drawing = false 
	
	for (var m = 0; m < array_length(markups); m++)
	{
		if markups[m].pos > i break; // if markups pos hasnt been reached dont bother 
		if (markups[m].pos == i) // else if we are in the correct pos 
		{
			markup_perform(markups[m]) // dew it 
			markups[m].triggered = true // trigger it
		}
	} 
	
	if !getting_details
	{
		if stop_drawing break;
		draw_set_colour(color_current) // default
		scr_draw_text_with_texteffects(drawn_x + current_x, drawn_y + current_y,char,letter_width,letter_height,0,i)
	}
	else 
	{	
		var line_end_width = ((current_x + 9) - start_x)
		max_width = max(max_width, line_end_width)
	}
	
	var char_width = monospaced ? 9 : string_width(char)
	var lwidth = (char_width * letter_width) + letter_spacing
	
	var w_width = monospaced ? (string_length(words[current_word]) * 9) : string_width(words[current_word])
	var word_width = (w_width * letter_width) + (string_length(words[current_word]) * letter_spacing);

	if (char == " ") 
	{
	    var next_word_idx = current_word + 1
	    if (next_word_idx < array_length(words)) 
		{
			var next_w_width = monospaced ? (string_length(words[next_word_idx]) * 9) : string_width(words[next_word_idx])

	        var next_word_w = (next_w_width * letter_width) + (string_length(words[next_word_idx]) * letter_spacing)

	        if (current_x + next_word_w > max_sentence_width) 
	        {
				if getting_details page_sentence_ammount ++
	            current_x = start_x
	            current_y += line_separation * letter_height
	            lwidth = 0
	        }
	    }
	    current_word++
	}
	current_x += lwidth;
}

color_current = color

if getting_details 
	max_height = current_y 
	
draw_set_alpha(1)

if play_sound_this_frame
	{
			event_perform(ev_alarm,1)
	}