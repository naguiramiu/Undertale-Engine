var _to_destroy = 
[
	inst_4ED3E337,
	inst_5BC25A56,
	inst_175984E7,
	inst_5EC460F5,
]
if global.flags.ruins.flowey_cutscene_0
{
	destroy_instances(_to_destroy)
	exit;
}
var cut_start = 
[
	cut_perform_function(0,globalmusic_play,[mus_flowey,0]),
	cut_textbox_talker(global.talker.flowey_default),
]

var cut_end = 
[
	cut_perform_function(0,instance_create,[obj_flowey_firstcutscene_controler,{to_destroy: _to_destroy}])
]

var cut_middle = []

switch truefile_get("flowey_firstcutscene_met") ?? 0 // times met
{
	case 0: // never met
	cut_middle = 
	[
		cut_textbox("* Howdy!{.&}* I'm {col:y}FLOWEY{/col}.{&.}* {col:y}FLOWEY{/col} the {col:y}FLOWER{/col}!"),
		cut_textbox("* Hmmm..."),
		cut_textbox("* You're new to the UNDERGROUND, aren'tcha?"),
		cut_textbox("* Golly, you must be so confused."),
		cut_textbox("* Someone out to teach you how things work around here!"),
		cut_textbox("* I guess little old me will have to do."),
		cut_textbox("* Ready?{.&}* Here we go!."),
	]
	break;
	case 1:
	cut_middle = 
	[
		cut_textbox("* Hee hee hee..."),
		cut_textbox("* Why'd you make me introduce myself?"),
		cut_textbox("* It's rude to act like you don't know who I am."),
		cut_textbox("* Someone ought to teach you proper manners."),
		cut_textbox("* I guess little old me will have to do."),
		cut_textbox("* Ready?{.&}* Here we go!."),
	]
	break;
	default:
	cut_middle = 
	[
		cut_textbox("* Don't you have anything BETTER to do?")
	]
	break;
}
cutscene = array_concat(cut_start,cut_middle,cut_end)
