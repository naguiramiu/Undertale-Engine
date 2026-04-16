function scr_language_set_title()
{
	#macro lan_savescreen "savescreen"
	
	global.language_text[$lan_savescreen] = 
	{
		room_text: 
		{
			rm_dev_testingarea: "* (Finding yourself in a room of developer things...){.&}* (Fills you with dread. yeah.)",
			rm_ruins_startingroom: "* (The thought that this is just the start of your journey fills you with determination.)",
			rm_ruins_staircase: "* (The shadow of the ruins looms above, filling you with determination.)"
		}
		
	}
	
	var name_entry = function(_entry,_response,_allow = true) constructor
	{
		entry = _entry
		response = _response
		allow = _allow
	}
	
	
	#macro lan_text_title "titlescreen"
	global.language_text[$lan_text_title] =
	{
		namescreen:
		{
			instructions: 
			[
				"[Z or ENTER] - Confirm",
				"[X or SHIFT] - Cancel",
				"[C or CTRL] - Menu (In-game)",
				"[F4] - Fullscreen",
				"[Hold ESC] - Quit",
				"When HP is 0, you lose."
			],
			instruction_title: "Instruction",
			instruction_begin: "Begin Game",
			instruction_settings: "Settings",
			quit: "Quit",
			backspace: "Backspace",
			done: "Done",
			name_entry_title: "Name the fallen human.",
			name_correct: "Is this name correct?",
			name_correct_no: "No",
			name_correct_yes: "Yes",
			name_correct_go_back: "Go back",
			name_not_creative: "Not very creative...?",
			names: 
			{
				asgore: new name_entry("Asgore", "You cannot.", false),
		        toriel: new name_entry("Toriel", "I think you should{&}think of your own{&}name, my child.", false),
		        sans:   new name_entry("Sans", "nope.", false),
		        undyne: new name_entry("Undyne", "Get your OWN name!", false),
		        flowey: new name_entry("Flowey", "I already CHOSE{&}that name.", false),
		        chara:  new name_entry("Chara", "The true name."), 
		        alphys: new name_entry("Alphys", "D-don't do that.", false),
		        alphy:  new name_entry("Alphy", "Uh... OK?"),
		        papyru: new name_entry("Papyru", "I'LL ALLOW IT!!!!"),
		        napsta: new name_entry(["Napsta", "Blooky"], "...........{&}(They're powerless to{&}stop you.)"),
		        route:  new name_entry(["Murder", "Mercy"], "That's a little on-{&}the nose, isn't it...?"),
		        asriel: new name_entry("Asriel", "...", false),
		        catty:  new name_entry("Catty", "Bratty! Bratty!{&}That's MY name!"),
		        bratty: new name_entry("Bratty", "Like, OK I guess."),
		        mtt:    new name_entry(["MTT", "Metta", "Mett"], "OOOOH!!! ARE YOU{&}PROMOTING MY BRAND?"),
		        gerson: new name_entry("Gerson", "Wah ha ha! Why not?"),
		        shyren: new name_entry("Shyren", "...?"),
		        aaron:  new name_entry("Aaron", "Is this name correct? ; )"),
		        temmie: new name_entry("Temmie", "hOI!"),
		        woshua: new name_entry("Woshua", "Clean name."),
		        jerry:  new name_entry("Jerry", "Jerry."),
		        bpants: new name_entry("Bpants", "You are really scraping the{&}bottom of the barrel.")
			}
		},
		start_poppup_hint: "[Press Z or ENTER]",
		title_options_continue: "Continue",
		title_options_start: "Start",
		title_options_reset: "Reset",
		title_options_return: "Return",
		title_options_settings: "Settings",
		settings: {
			exit_text: "EXIT",
			language_text: "LANGUAGE",
			gen_volume: "MASTER VOLUME",
			mus_volume: "MUSIC VOLUME",
			snd_volume: "SOUND VOLUME",
			auto_run: "AUTO RUN",
			borders: "BORDERS",
			border_value_disabled: "DISABLED",
			border_value_simple: "SIMPLE",
			border_value_enabled: "ENABLED",
			show_border_windowed: "SHOW BORDER WINDOWED",
			keys_text: "KEYS",
			language_text: "LANGUAGES",
			back: "BACK",
			reset: "RESET",
			finish: "FINISH",
			settings_menu: "SETTINGS",
			settings_true: "TRUE",
			settings_false: "FALSE",
			keys:
			{
				key_up: "UP KEY",
				key_left: "LEFT KEY",
				key_down: "DOWN KEY",
				key_right: "RIGHT KEY",
				key_confirm: "CONFIRM KEY",
				key_back: "BACK KEY",
				key_menu: "MENU KEY"
			}
		},
		file_select:
		{
			select: "Select a file.",
			file_number: "[File {num}]",
			empty:  "[EMPTY]",
			back: "Back",
			go_back: "Return",
			continue_game: "Continue",
			start_game: "Start",
			lv_text: "LV:",
			lv_text_2: "LV",
			save: "Save",
			file_saved: "File saved",
			new_file: "New File",
			overwrite_slot: "Overwrite Slot {num}?"
		}
	}
}

