global.can_move = false
if instance_exists(obj_roomtransition)
obj_roomtransition.let_player_move = false
main_selection = 0

in_submenu = false
box_progress = 0

create_tiny_dialogue = function(dialogue)
{
	tiny_dialogue = create_textbox(dialogue,
	{
		visible: false, 
		x: 184,
		y: -39,
		draw_bg: false,
		can_advance: false,
		textbox_position: DOWN,
		max_sentence_width: 130,
		write: false,
		can_skip: false,
		do_extend_box: false,
	})
}
tiny_dialogue_text = 
{
	default_buy_dialogue: "What would you like to buy?",
	exit_out_buy: "Just looking?",
	inventory_full: "You're carrying too much.",
	no_gold: "You can't afford this.",
	buy_text: "Buy it for{&}{required}G ?",
	bought: "Thanks for your purchase.",
	default_sell_dialogue: "What are you willing to sell?",
	sell_text: "Sell it for {required}G ?",
	sold: "Thanks?",
	exit_out_sell: "Not selling?",
	default_talk_dialogue: "Care to chat?"
}

large_text_dialogue =
{
	default_main_dialogue: 	"* Hello, traveller.{.}{&}* How can I help you?",
	exiting_menu: "* Take your time.",
	exiting_out: "* Bye now!{.}{&}* Come back anytime!"
}

my_items = 
[
	{
		id: ITEM_BISICLE,
		sell_price: 10,
		description: "Heals 5HP{&}Splits into two Unisicles."
	},
	{
		id: ITEM_TOY_KNIFE,
		sell_price: 50,
		description: "Weapon: {&}3AT & 0DF{&}({attack_dif} AT) ({defense_dif} DF){&}A fake knife."
	},
	{
		id: ITEM_MONSTER_CANDY,
		sell_price: 4,
		description: "Heals 3HP{&}A candy for monsters."
	},
	
]

item_selection = 0
item_in_choicer = false 
item_choicer_sel = 0

selecting_exit = false
box_text_current = ""
open_menu = false
sell_scroll_offset = 0

create_large_dialogue = function(dialogue)
{
	large_dialogue = create_textbox(dialogue,
	{
		stop_drawing_after_destroy: false,
		visible: false,
		draw_bg: false,
		x: -10,
		y: -39,
		max_sentence_width: 220,
		can_advance: false,
		textbox_position: DOWN,
		do_extend_box: false,
	})
	return large_dialogue
}

create_large_dialogue(large_text_dialogue.default_main_dialogue)

var talk_option = function(_title,_dialogue,_goto = -1,_highlighted = false) constructor
{
	title = _title 
	dialogue = _dialogue 
	goto = _goto 
	highlighted = _highlighted
}


talk = 
[
	new talk_option( "Say hello","* Hello. This is a default dialogue for choosing the option \"Say hello\".{.}{&}* I hope you enjoy this dialogue.",4),
	new talk_option("What to do here",["* Dialing my logue.","* yep"]),
	new talk_option("Town history","* There was once a town here. its gone sorry."),
	new talk_option("Your life","* My life? I literally dont exist..."),
	new talk_option("Say hello (NEW)", "* WOAAAAAAA.",0,true),
]

talk_options = array_create_ext(4,function(i){return i})

alarm_set_instant(0,0)
parent_char.visible = false
talk_dialogue = noone