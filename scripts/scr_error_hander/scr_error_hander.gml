function string_date_add0(time)
{
	time = string(time)
	if string_length(time) == 1 
	return "0" + time 
	return time
}

function currenthour(date = date_current_datetime())
{
	return string_date_add0(date_get_hour(date)) + ":" + string_date_add0(date_get_minute(date)) + ":" + string_date_add0(date_get_second(date))
}
function currentday(date = date_current_datetime())
{
	return string_date_add0(date_get_day(date)) + "/" + string_date_add0(date_get_month(date)) + "/" + string_date_add0(date_get_year(date))
}
function crashfile_write(error_message)
{
	var crash_log = ""
	var file_name = "crash_log.txt"
	if file_exists(file_name) 
		crash_log = file_read_all_text(file_name)  
	var bigline = string_repeat(chr(95),43)
	var str = bigline + "\n" + currentday() + "\n" + "Crash occured at " + currenthour() + "\n" + error_message + bigline + string_repeat("\n",5) 
	file_write_all_text(file_name,str + crash_log)
	return str
}

function get_error_message(ex)
{
	var save = "?"
	if variable_global_exists("information") && variable_struct_exists(global.information,"savefile_num")
		save = global.information.savefile_num
	
	var stack = "" 
	for (var i = 0; i < array_length(ex.stacktrace); i++)
	stack += ex.stacktrace[i] + "\n"
	
	var hashstrings = string_repeat("#",48)
	var longmess = "Error in" + string_copy(ex.longMessage,29,string_length(ex.longMessage))
	var custom_message = ("Room: " + string(room_get_name(room)) + ", SaveNum: " + string(save))
	
	var error_message = hashstrings + "\n" + longmess + custom_message + "\n" +hashstrings + "\n" + stack 
	
	show_debug_message(error_message)
	
	return error_message
}

function show_error_message(ex)
{
	var error_message = get_error_message(ex)
	var final_error_message = 
	"You've encountered a game crash!" + 
	"\n" + "Please screenshot this message and send it to the devs." + 
	"\n" + string_repeat(chr(95),43) + "\n" + error_message
	+ "\nWould you like to copy this error message?" +"\n" 
	
	crashfile_write(error_message)	

	if show_question(final_error_message + "\n\n\n") 
	clipboard_set_text(error_message)
		
	return 0
}