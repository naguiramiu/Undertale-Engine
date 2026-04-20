function scr_get_languages()
{
	var available_languages = []
	var folder = file_find_first(working_directory + "Languages/*", 16);
	while (folder != "")
	{
		var fname = working_directory + "Languages\\" + folder
		var file_all = file_read_all_text(fname)
		if !is_undefined(file_all) && string_length(file_all) != ""
		try 
		{
			var temp 
			temp = json_parse(file_all)
			array_push(available_languages,folder)
		}
		
	    folder = file_find_next();
	}
	file_find_close();
	return available_languages
	
}

function get_lan()
{
	var args = []
	for (var i = 0; i < argument_count; i++)
	args[i] = argument[i];
	
	var val = global.language_text
	if array_length(args)
		if !is_string(args[0]) // if the first argument isnt a string then it interprets it as a language struct
		{
			val = args[0]
			array_delete(args,0,1)	
		}
		
	for (var i = 0; i < array_length(args); i++)
		val = val[$args[i]]
		
	return val ?? DEFAULT_MISSING_TEXT
}

function filename_nameonly(fname)
{
	return string_copy(fname,1,string_length(fname) - string_length(filename_ext(fname)))
}

function scr_load_language(language_name)
{
	var fname = working_directory + "Languages\\" + language_name
	var file_all = file_read_all_text(fname)
	if !is_undefined(file_all) && string_length(file_all) != ""
	try 
	{
		var temp = json_parse(file_all)
		global.language_text = struct_merge_ext(global.language_text, temp)
		delete temp 
	}
	catch(e)
	{
		show_poppup("Error: Language " + filename_nameonly(language_name) + "not properly set.")
		show_poppup(e)
		language_name = "English.json"
	}
	global.settings.language = filename_nameonly(language_name)
	scr_settings_save()
	initialize()
	scr_settings_load()
}

function string_replace_markup(str,markups)
{
	if !is_array(markups)	
	return scr_replace_markup_single(str,markups)
	else 
	{
		while array_length(markups)
			str = scr_replace_markup_single(str,array_pop(markups))
		return str
	}
}

///@desc example: 
///string_replace_markup_ext("My name is {name}, I am the {profession} of the {place}.",  
///{
///		name: "Toriel",
///		profession: "guardian",
///		place: Ruins
///} --> My name is Toriel, I am the guardian of the Ruins.
function string_replace_markup_ext(str, markup_struct)
{
    var result = ""
    var len = string_length(str)
    var last_pos = 1
    var open_pos = string_pos_ext("{", str, last_pos)
    if !open_pos return str

    while open_pos > 0
	{
        result += string_copy(str, last_pos, open_pos - last_pos)
        var close_pos = string_pos_ext("}", str, open_pos)
        if close_pos > 0
		{
            var _key = string_copy(str, open_pos + 1, close_pos - open_pos - 1)
            var _val = markup_struct[$ _key]
            if (!is_undefined(_val))
                result += string(_val)
            else
                result += "{" + _key + "}"
            last_pos = close_pos + 1
        }
		else 
		{
            result += "{"
            last_pos = open_pos + 1
        }
        open_pos = string_pos_ext("{", str, last_pos)
    }
    result += string_copy(str, last_pos, len - last_pos + 1)
    return result;
}


///@desc ("My name is {name}, I am the guardian of the Ruins.", "Toriel") --> "My name is Toriel, I am the guardian of the Ruins."
function scr_replace_markup_single(str, markups)
{
    var start = string_pos("{", str);
    var m_end = string_pos_ext("}", str, start);
    if (start != 0 && m_end != 0)
    {
        var before = string_copy(str, 1, start - 1);
        var after = string_copy(str, m_end + 1, string_length(str) - m_end);
        return before + string(markups) + after;
    }
    return str;
}

//This is just for testing, it gets every string in a struct and turns it into "@string@" so you can 
// see what youve translated and whatnot
//function scr_test_language_text(_data) 
//{
//    if (is_struct(_data)) 
//    {
//        var _keys = struct_get_names(_data);
//        for (var i = 0; i < array_length(_keys); i++) 
//        {
//            var _val = _data[$ _keys[i]]; 
//            if (is_string(_val))
//                _data[$ _keys[i]] = "@" + _val + "@";
//            else if (is_struct(_val) || is_array(_val)) 
//                scr_test_language_text(_val); 
//        }
//    } 
//    else if (is_array(_data)) 
//    {
//        var _len = array_length(_data);
//        for (var i = 0; i < _len; i++) 
//        {
//            var _val = _data[i];
//            if (is_string(_val))
//                _data[i] = "@" + _val + "@";
//            else if (is_struct(_val) || is_array(_val))
//                scr_test_language_text(_val);
//        }
//    }
//}

function scr_setup_os_language()
{
	var os_lang = string_upper(os_get_language()) // "EN" "ES"
	
	var folder = file_find_first(working_directory + "Languages/*", 16);
	while (folder != "") // loop through all of the files in the Language folder
	{
		var fname = working_directory + "Languages\\" + folder // correct file name 
		var file_all = file_read_all_text(fname)
		if !is_undefined(file_all) && string_length(file_all) != ""
		try // reading from non-ini files should ALWAYS be in a try statement
		{
			var temp = json_parse(file_all)
			if variable_struct_exists(temp,"language_code") // just to make sure. it could've been forgotten
			{
				var code = string_upper(temp.language_code) // make it uppercase just in case 
				if (code != "EN") // game is already in english by default 
				{
					scr_load_language(folder) // load the language 
					break; // stop looking
				}
			}
		}
		folder = file_find_next(); // go to next file 
	}
	file_find_close(); // stop looking
}