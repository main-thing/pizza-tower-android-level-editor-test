live_auto_call;
enum BUTTON_IDS 
{
	BUILD,
	EDIT,
	DELETE
}

//depth = obj_camera.depth - 1;
edit_mode = true;
//global.forcehidecontrols = true;
//with(obj_virtual_controller)
//	event_perform(ev_mouse, ev_global_left_button)
	
zoom = 1;
 // replace these with a macro
object_x = 260;
object_y = 400;
object_size = 60;
buttonid = BUTTON_IDS.BUILD;

buttons =
[
	{
		name : "build",
		bounds : [10, 400, 130, 440],
		type: BUTTON_IDS.BUILD
	},
	{
		name : "edit",
		bounds : [10, 450, 130, 490],
		type: BUTTON_IDS.EDIT
	}
];
	
pagebuttons =
[
	{
		bounds : [200, 370, 160, 510]
	},
	{
		bounds : [760, 370, 800, 510]
	},
];
	
scalebuttons =
[
	{
		bounds : [20, 240, 60, 280]
	},
	{	
		bounds : [20, 300, 60, 340]
	},
];

in_pause_menu = false;
menubutton = [900, 20, 940, 60];

playbutton = [20, 20, 80, 80]
playbutton_triangle = [30, 30, 70, 70]

last_search = "trigger";
last_search_parent = "obj_baddie";
last_search_verbatim = "obj_noisey, obj_cheeseslime";
last_search_page = 1;
q_search_object = noone;
q_search_object_parent = noone;
q_search_object_verbatim = noone;
q_jump_page = noone;
editbuttons =
[
	new fakereditorer_button
	(
		"search",
		 [object_x, object_y, object_x + object_size, object_y + object_size],
		 function()
		 {
			q_search_object = get_string_async("search objects by name", last_search);
		 }
	),
	new fakereditorer_button
	(
		"search\nparent",
		 [object_x + (object_size + 10), object_y, object_x + object_size + (object_size + 10), object_y + object_size],
		 function()
		 {
			q_search_object_parent = get_string_async("search objects by parent", last_search_parent);
		 }
	),
	new fakereditorer_button
	(
		"search\nlist",
		 [object_x + (object_size + 10) * 2, object_y, object_x + object_size + (object_size + 10) * 2, object_y + object_size],
		 function()
		 {
			q_search_object_verbatim = get_string_async("search object by name", last_search_verbatim);
		 }
	),
	new fakereditorer_button
	(
		"export\nlist",
		 [object_x + (object_size + 10) * 3, object_y, object_x + object_size + (object_size + 10) * 3, object_y + object_size],
		 function()
		 {
			var str = "";
			for(var i = 0; i < array_length(display_objects); i++)
				str += object_get_name(display_objects[i]) + ",";
			get_string_async("exported object list", str);
		 }
	),
	new fakereditorer_button
	(
		"clear\nsearch",
		 [object_x + (object_size + 10) * 4, object_y, object_x + object_size + (object_size + 10) * 4, object_y + object_size],
		 function()
		 {
			display_objects = [];
			display_offset = 0;
		 }
	),
	new fakereditorer_button
	(
		"duplicate\nselected",
		 [object_x + (object_size + 10) * 5, object_y, object_x + object_size + (object_size + 10) * 5, object_y + object_size],
		 function()
		 {
			with(selectedobject)
				instance_copy(true);
		 }
	),
	new fakereditorer_button
	(
		"delete\nselected",
		[object_x, object_y + (object_size + 10), object_x + object_size, object_y + object_size + (object_size + 10)],
		 function()
		 {
			with(selectedobject)
				instance_destroy();
		 }
	),
	new fakereditorer_button
	(
		"toggle\ncollisions",
		[object_x + (object_size + 10), object_y + (object_size + 10), object_x + object_size + (object_size + 10), object_y + object_size + (object_size + 10)],
		 function()
		 {
			//with(selectedobject)
				//instance_destroy();
		 }
	)
];
	
objlist = [];
for(var i = 0; object_exists(i) && string_pos("__YYInternalObject", object_get_name(i)) == 0; i++)
	objlist[i] = i;
	
mv = false;
spr = noone;
obj = noone;
omv = false;
mobj = noone;
display_objects = [];
display_offset = 0;
maxob = 6;
selectedobject = noone;
	
array_copy(display_objects, 0, objlist, 0, array_length(objlist));