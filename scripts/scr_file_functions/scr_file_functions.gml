
function file_read_all_text(filename)
{
    if !file_exists(filename)
    {
		return undefined
	}
	var buffer = buffer_load(filename)
    if (buffer_get_size(buffer) <= 0)
    {
        buffer_delete(buffer);
        return undefined;
    }
    var _result = buffer_read(buffer, buffer_string)
    buffer_delete(buffer)
    return _result
}

function file_write_all_text(filename, content) 
{
    var buffer = buffer_create(string_length(content), buffer_grow, 1)
    buffer_write(buffer,buffer_string, content)
    buffer_save(buffer, filename)
    buffer_delete(buffer)
}

function file_dir()
{
	return filename_dir(filename_dir(game_save_id)) + "\\" + "UNDERTALE-ENGINE" + "\\";
}

function string_quote_parse(str,load = true)
{
	if load return 	string_replace_all(str,"·","\"")
	return 	string_replace_all(str,"\"","·")
}

function dec_to_hex(dec) 
{
    var hex_digits = "0123456789ABCDEF"
    var hex = ""
    if (dec == 0) return "0"
    while (dec > 0)
	{
        var remainder = dec % 16
        hex = string_char_at(hex_digits, remainder + 1) + hex
        dec = dec div 16
    }
    return hex
}
function string_to_hex(str) 
{
    var _result = ""
    for (var i = 1; i <= string_length(str); i++) 
	{
        var char = ord(string_char_at(str, i))
        var hex_pair = dec_to_hex(char)
        if (string_length(hex_pair) == 1) hex_pair = "0" + hex_pair
        _result += hex_pair
    }
    return _result
}

// basic encryption
function scr_struct_fy_save(struct,k = "string")
{
	var str = json_stringify(struct)
    var e = ""
    for (var i = 0; i < string_length(str); i++) 
        e += chr((ord(string_char_at(str, i + 1)) + ord(string_char_at(k, (i % string_length(k)) + 1))) & 255)
    e = string_to_hex(e)
	var aftr = ""
    for (var i = string_length(e); i > 0; i--) 
        aftr += string_char_at(e, i)
	return aftr
}
function hex_to_string(hex)
{
    var _result = ""
    for (var i = 1; i <= string_length(hex); i += 2)
	{
        var hex_pair = string_char_at(hex, i) + string_char_at(hex, i + 1)
        var char = chr(hex_to_dec(hex_pair))
        _result += char
    }
    return _result
}

function scr_struct_fy_load(str,k = "string")
{
	var aftr = ""
    for (var i = string_length(str); i > 0; i--)
    aftr += string_char_at(str, i)
	aftr = hex_to_string(aftr)
	var d = ""
    for (var i = 0; i < string_length(aftr); i++) 
    d +=  chr((ord(string_char_at(aftr, i + 1)) - ord(string_char_at(k, (i % string_length(k)) + 1))) & 255)
	return d
}



#region what this does
/*
fills an array with the important bits for the savedata in the three savefiles.
example:
[
	{	 // file 0
		name: "Frisk",
		lv: 1,
		play_time: 17:12,
		room_name: "Starting Room",
		loaded: true,
	},
	{	 // file 1
		name: undefined,
		lv: undefined,
		play_time: undefined,
		room_name: undefined,
		loaded: false,
	},
	{	 // file 2
		name: "John",
		lv: 19,
		play_time: 241:12:24,
		room_name: "Throne of the gods",
		loaded: true,
	},
]
*/
#endregion

function scr_array_fill_savefiledata()
{
	var file_data = []
	
	for (var i = 0; i < NUMBER_OF_SAVEFILES; i++)
		file_data[i] = savefile_basic_information(i)
		
	return file_data
}


#region what this does
	/*
	fills an struct with the important bits for the savedata for the requested number
	example:
		{	 // file 0 
			name: "Frisk",
			lv: 1,
			play_time: 17:12,
			room_name: "Starting Room",
			loaded: true,
		},
	*/
	#endregion
function savefile_basic_information(num)
{
	var file = function(_name = undefined,_lv = undefined,_play_time = undefined,_saved_room_info_struct = undefined,_loaded = false) constructor
	{
		name = _name
		lv = _lv
		play_time = _play_time
		saved_room_info_struct = _saved_room_info_struct
		room_name = is_defined(saved_room_info_struct) ? saved_room_info_struct.room_name : undefined
		loaded = _loaded
	}
	
	var file_data = {}
	var has_data = false
	var corrupted = false
		
	var file_name = savefile_name(num)
		
	if file_exists(file_name)
	{
		try 
		{
			var data = file_read_all_text(file_name)
			has_data = (data != "")
				
			if has_data
			{
				var main_struct = load_savefile(data)
				var stats = main_struct.stats
				var char = get_char_by_party_position(0,stats)
				file_data = new file
				(
					char.name,
					char.lv,
					format_time(main_struct.information.play_time),
					room_get_custom_info(asset_get_index(main_struct.information.room_name)),
					true
				)
				delete main_struct
			}
		} 
		catch (e) 
		{
			corrupted = true
			show_debug_message(e)
		}
	}
	if corrupted || !has_data
		file_data = new file()
	
	return file_data
}

function savefile_name(file_num)
{
	return file_dir() + "savedata_" + string(file_num) + ".txt"
}