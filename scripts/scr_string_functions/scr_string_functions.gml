function string_linebreaks(str)
{
	return string_replace_all(str,"{&}","\n")	
}

function string_to_real(str)
{
	if !is_string(str) return -1
	var ret_str = ""
	for (var s = 1; s <= string_length(str);s++)
	ret_str += string(string_ord_at(str,s))
	return ret_str												
}

function string_capitalize(str)
{
	return string_upper(string_char_at(str,1)) + string_lower(string_copy(str,2,string_length(str)))	
}
function string_prettify(str)
{
	return string_replace_all(string_capitalize(str),"_"," ")
}

function format_time(seconds) 
{
    var hours = floor(seconds / 3600)
    var minutes = floor((seconds % 3600) / 60)
    var secs = floor(seconds % 60)

    var hour_string = string(hours)
    var minute_string = string(minutes)
    var sec_string = string(secs)

    if minutes < 10 minute_string = "0" + minute_string
    if secs < 10 sec_string = "0" + sec_string

    if hours > 0
	{
        if (hours < 10) hour_string = "0" + hour_string
        return hour_string + ":" + minute_string + ":" + sec_string
    } 
	else return minute_string + ":" + sec_string
    
}

