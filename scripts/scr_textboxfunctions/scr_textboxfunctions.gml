 // this is the sole script that performs custom markups!
 function markup_perform(markup)
 {
	 var title = markup.title 
	 var value = markup.value 
	 var triggered = markup.triggered  
	 var reset = markup.reset 
	 
	  if getting_details
		if !(string_pos("&",title) || array_contains(["w","width","h","height","font","sprite"],title)) exit;
	 
	 switch (title)
	{
		case "talker":
		
			talker = global.talker[$value[0]]
			
		break;
		case "talker_sprite": case "sprite":
		
			talker.sprite_name = value[0]
			if array_length(value) > 1 talker.sprite_emotion = value[1]
			
		break;
		case "emotion": case "img": case "talker_img": case "image_index": case "talker_image_index":
		
			talker.sprite_emotion = value[0]
			
		break;
		
		case "event":
		
			var do_once = (array_length(value) == 1) 
			if (do_once && triggered)
			break;
			if variable_instance_exists(id,"event_" + value[0])
				script_execute_ext(variable_instance_get(id,"event_" + value[0]),customevent_get_params(value[0]))
		
		break;
		
		case "wave": case "rainbow": case "shake": case "nervous": case "wobble":
		
			if reset 
				variable_instance_set(id,"texteffect_" + title,false)
			else
			variable_instance_set(id,"texteffect_" + title,true)
		
		break;
		
		case ",": case ".":
		
			if triggered || page_skipped break;
			scr_textbox_stop((title == "." ? 12 : 7))
			
		break;
		
		case "col": case "color":
		
			if reset color_current = color
				else if string_starts_with(value[0],"#") 
					color_current = hex_to_color(value[0])
						else
					color_current = string_to_color(value[0])
		
		break;
		
		case ",&": case "&,": case ".&": case "&.":
		
			if !(triggered || page_skipped)
			scr_textbox_stop((string_pos(".",title) ? 12 : 7))
		
		case "&":
		
			if getting_details
			{
				max_width = max(max_width,((current_x + 9) - start_x))
				page_sentence_ammount ++
			}
			current_x = start_x;
			if char == "*"
			current_x -= 16 * letter_width;
			current_y += line_separation * letter_height;
			
		break;
		case "speed": case "spd":
		
			if reset write_speed = 1
			else
				write_speed = real(value[0]) 
		
		break;
		case "snd": case "sound": 
		
			if !triggered
			play_sound(asset_get_index(value[0]))
		
		break;
	}
 }

function string_replace_all_ext(str, replace, insert)
{
    var out = "";
    var i = 1;
    var in_markup = false;
    var L = string_length(str);
    var RL = string_length(replace);

    while (i <= L)
    {
        var ch = string_char_at(str, i);

        // markup start
        if (ch == "{")
        {
            in_markup = true;
            out += ch;
            i++;
            continue;
        }

        // markup end
        if (ch == "}")
        {
            in_markup = false;
            out += ch;
            i++;
            continue;
        }

        // if not in markup, try replacement
        if (!in_markup)
        {
            if (string_copy(str, i, RL) == replace)
            {
                out += insert;
                i += RL;
                continue;
            }
        }

        out += ch;
        i++;
    }

    return out;
}

function scr_markups_from_string(str)
{
	var markups = []
	var words = smart_space_split(str)
	for (var i = 0; i < array_length(words); i++)
		if string_pos("{",words[i]) 
		{
			var gotmarkup = scr_markup_from_word(words[i])
			for (var a = 0; a < array_length(gotmarkup[1]); a++)
			array_push(markups,"{" + gotmarkup[1][a] + "}")
		}
	return markups
}

function smart_space_split(str) 
{
	var _result = [];
	var word = "";
	var in_markup = false;

	for (var i = 1; i <= string_length(str); i++) {
		var ch = string_char_at(str, i);

		if (ch == "{") {
			in_markup = true;
			word += ch;
		}
		else if (ch == "}") {
			in_markup = false;
			word += ch;
		}
		else if (ch == " " && !in_markup) {
			if (word != "") {
				array_push(_result, word);
				word = "";
			}
		}
		else {
			word += ch;
		}
	}

	if (word != "") array_push(_result, word); 

	return _result;
}

function scr_markup_from_word(word)
{
	var clean_word = word
	var markups = []

	var start = string_pos("{", clean_word)
	var _end = string_pos("}", clean_word)

	while (start > 0 && _end > start)
	{
		var markup = string_copy(clean_word, start + 1, _end - start - 1 )
		array_push(markups, markup)
		clean_word = string_delete(clean_word, start, _end - start + 1)
		start = string_pos("{", clean_word)
		_end = string_pos("}", clean_word)
	}

	return [clean_word, markups]
}

function scr_txtbox_getnumberofsentences()
{ 
	page_sentence_ammount = 1
	max_width = 0
	max_height = 0
	var variable_names = variable_instance_get_names(id)
	var prev_vars = {}
	for (var i = 0; i < array_length(variable_names); i++)
	prev_vars[$variable_names[i]] = variable_clone(variable_instance_get(id,variable_names[i]))
	getting_details = true
	
	event_user(1)
	var height = max_height 
	var width = max_width 
	var sentences = page_sentence_ammount
	for (var i = 0; i < array_length(variable_names); i++)
	variable_instance_set(id,variable_names[i],prev_vars[$variable_names[i]])
	
	max_height = height  
	max_width = width 
	page_sentence_ammount = sentences
 }
 
 function create_textbox(dialogue,var_struct = {})
{
	var_struct.dialogue = variable_clone(dialogue)
	return instance_create(obj_textbox,var_struct)
}

function textbox_option(_text,_result,_result_parameters = [],_x = 0,_y = 0,_h_align = fa_center,_v_align = fa_middle)
{
	return 
	{
		text: _text, 
		x: _x, 
		y: _y,
		h_align: _h_align,
		v_align: _v_align,
		result: _result,
		event_result_parameters: _result_parameters
	}
}

function scr_draw_text_with_texteffects(_x,_y,_char,_xscale,_yscale,_angle,i)
{
	if texteffect_wave
		_y += sin(current_time * 0.005 + i * 0.4) * 3
	if texteffect_wobble
	{
		_x += cos(current_time * 0.004 + i * 0.5) 
		_y += sin(current_time * 0.005 + i * 0.4) 
	}
	if texteffect_shake
	{
		var ran = !irandom(100) 
		if _char == "*" ran = false
		_x += ran ? random_range(-1,1) : 0
		_y += ran ? random_range(-1,1) : 0
	}
	if texteffect_nervous
	{
		if !irandom(500)
				_y += random_range(-1, 1)
		if !irandom(500)	
				_x += random_range(-1, 1)
	}
		
	if texteffect_rainbow
		draw_text_transformed_color(_x,_y,_char,_xscale,_yscale,0,make_color_rainbow(i),make_color_rainbow(i + 1),make_color_rainbow(i + 1),make_color_rainbow(i),draw_get_alpha())
	else 
		draw_text_transformed(_x , _y, _char,_xscale,_yscale,0)
}

function scr_textbox_stop(time)
{
	alarm[0] = time
	stop_drawing = true
	write = false
	letter_drawn_current --
	play_sound_this_frame = false
}