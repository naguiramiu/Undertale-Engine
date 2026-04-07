function scr_language_set_title()
{
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
				asgore:
				{
					entry: "Asgore",
					response: "You cannot.",
					allow: false
				},
				toriel:
				{
					entry: "Toriel",
					response: "I think you should{&}think of your own{&}name, my child.",
					allow: false
				},
				sans:
				{
					entry: "Sans",
					response: "nope.",
					allow: false
				},
				undyne:
				{
					entry: "Undyne",
					response: "Get your OWN name!",
					allow: false
				},
				flowey:
				{
					entry: "Flowey",
					response: "I already CHOSE{&}that name.",
					allow: false
				},
				chara:
				{
					entry: "Chara",
					response: "The true name.",
					allow: true
				},
				alphys:
				{
					entry: "Alphys",
					response: "D-don't do that.",
					allow: false
				},
				alphy:
				{
					entry: "Alphy",
					response: "Uh... OK?",
					allow: true
				},
				papyru:
				{
					entry: "Papyru",
					response: "I'LL ALLOW IT!!!!",
					allow: true
				},
				napsta:
				{
					entry: ["Napsta", "Blooky"],
					response: "...........{&}(They're powerless to{&}stop you.)",
					allow: true
				},
				route:
				{
					entry: ["Murder", "Mercy"],
					response: "That's a little on-{&}the nose, isn't it...?",
					allow: true
				},
				asriel:
				{
					entry: "Asriel",
					response: "...",
					allow: false
				},
				catty:
				{
					entry: "Catty",
					response: "Bratty! Bratty!{&}That's MY name!",
					allow: true
				},
				bratty:
				{
					entry: "Bratty",
					response: "Like, OK I guess.",
					allow: true
				},
				mtt:
				{
					entry: ["MTT", "Metta", "Mett"],
					response: "OOOOH!!! ARE YOU{&}PROMOTING MY BRAND?",
					allow: true
				},
				gerson:
				{
					entry: "Gerson",
					response: "Wah ha ha! Why not?",
					allow: true
				},
				shyren:
				{
					entry: "Shyren",
					response: "...?",
					allow: true
				},
				aaron:
				{
					entry: "Aaron",
					response: "Is this name correct? ; )",
					allow: true
				},
				temmie:
				{
					entry: "Temmie",
					response: "hOI!",
					allow: true
				},
				woshua:
				{
					entry: "Woshua",
					response: "Clean name.",
					allow: true
				},
				jerry:
				{
					entry: "Jerry",
					response: "Jerry.",
					allow: true
				},
				bpants:
				{
					entry: "Bpants",
					response: "You are really scraping the{&}bottom of the barrel.",
					allow: true
				}
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

