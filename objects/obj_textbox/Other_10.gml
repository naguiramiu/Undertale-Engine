//// @desc New page

letter_drawn_current = 1
if is_option
	letter_drawn_current = 0

write = true 
prev_written = false
page_skipped = false

// automatically wait at ","
if comma_wait
dialogue[current_page] = string_replace_all_ext(dialogue[current_page],",",",{,}")

// if fullstop wait automatically wait at "."
if fullstop_wait 
dialogue[current_page] = string_replace_all_ext(dialogue[current_page],".",".{.}")

markups = []

//okay so the markup system
/*
To be honest i coded this a while ago and dont remember it perfectly but ill try to explain.
Basically, this code right here below gets every markup from a string
like "Funny {col:purple}noise!{snd:snd_noise}" > "[{col:purple},{snd_noise}]"
Then it iterates through them, finds their position in the original string and then adds to the markup array this for every markup:
{
	pos: nextpos, // its position in the string 
	title: name, // its first value (eg: {col:purple}'s title is col 
	value: temp_value, // its other values (purple)
	reset: _reset, // if you write "\" before a markup like {/col} it sets reset to true 
	triggered: false, // markups like play sound or change sprite only do it if not triggered yet
})
*/

var temp_markups = scr_markups_from_string(dialogue[current_page]) // returns ["test","trying: fixthis","the","the","hotdog"]
if array_length(temp_markups)
{
	var nextpos = string_pos(temp_markups[0],dialogue[current_page]) 
	var starting_markups = true
	if nextpos != 1 starting_markups = false
	for (var i = 1; i <= string_length(dialogue[current_page]); i++)
	{
		while (i == nextpos)
		{
			dialogue[current_page] = string_delete(dialogue[current_page],nextpos,string_length(temp_markups[0]))
			var markup_text = string_copy(temp_markups[0],2,string_length(temp_markups[0]) - 2)
			var temp_value = ""
			var name = markup_text
			if string_pos(":",markup_text)
			{
				temp_value = string_split(markup_text,":")
				name = temp_value[0]
				array_delete(temp_value,0,1)
			}
			var _reset = string_starts_with(name,"/")
			if _reset 
			name = string_delete(name,1,1)
			array_push(markups,
			{
				pos: nextpos,
				title: name,
				value: temp_value,
				reset: _reset,
				triggered: false,
			})
			if starting_markups
			markup_perform(markups[array_length(markups) - 1])
		
			array_delete(temp_markups,0,1)
			if !array_length(temp_markups)
			break;
		
			nextpos = string_pos(temp_markups[0],dialogue[current_page]) 
			if nextpos != 1 starting_markups = false
			
		}
			if !array_length(temp_markups)
			break;
	}
}

page_sentence_ammount = 1

var prev_width = max_width 
var prev_height = max_height 

if do_get_details || do_extend_box
scr_txtbox_getnumberofsentences()

if is_speechbubble
{
	if get_size_auto 
	{
		if prev_height > max_height 
			max_height = prev_height 
		if prev_width > max_width 
			max_width = prev_width
	}
	else 
	{
		max_height = prev_height 
		max_width = prev_width
	}
}


if insta_write 
letter_drawn_current = string_length(dialogue[current_page]) 