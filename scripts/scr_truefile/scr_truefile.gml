function truefile_write(struct)
{
	var tf = truefile_load()
	struct_replace_unique(tf,struct)
	
	truefile_overwrite(tf)
} 

function truefile_overwrite(struct)
{
	file_write_all_text(TRUE_FILE_NAME,(ENCRYPT_SAVEDATA ? string_quote_parse(scr_struct_fy_save(struct),0) : json_stringify(struct,1)))
} 

function truefile_load()
{
	var fname = TRUE_FILE_NAME
	var loaded_data = {}
	if file_exists(fname)
	{
		try
		{
			var data = file_read_all_text(fname)
			if data != ""
				var loaded_data = load_savefile(data)
		} 
	}
	return loaded_data
}

function truefile_get(name,file = truefile_load())
{
	return variable_struct_exists(file,name) ? variable_struct_get(file,name) : undefined
}

#macro TRUE_FILE_NAME file_dir() + "tsavedata_" + string(global.settings.selected_file) + ".txt"
