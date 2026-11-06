live_auto_call;

if(keyboard_check_pressed(ord("Q")))
	room_restart();
	
var b = playbutton;
if(mouse_check_button_pressed(mb_left) && point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), b[0], b[1], b[2], b[3]))
{
	edit_mode = !edit_mode;
	//camera_set_view_size(view_camera[0], edit_mode ? room_width : 960, edit_mode ? room_height : 540);
	//view_set_visible(0, !edit_mode);
	//with(obj_camera)
		//event_perform(ev_step, ev_step_normal)
	//view_set_visible(1, edit_mode);
	//global.forcehidecontrols = edit_mode;
	//with(obj_virtual_controller)
		//event_perform(ev_mouse, ev_global_left_button);
	return;
}
if(!edit_mode)
	return;

if(in_pause_menu)
	return;

mobj = noone;
if(buttonid = BUTTON_IDS.BUILD)
{
	for(var i = 0, display_len = array_length(display_objects) - 1; i < maxob; i++)
	{
		if(i > display_len)
				break;
		if(point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), object_x + (object_size + 10) * i, 400, object_x + object_size + (object_size + 10) * i, object_y + object_size))
			mobj = display_objects[i + display_offset];
	}
}

if(mouse_check_button_pressed(mb_left))
{
	for(var i = 0; i < 2; i++)
	{
		var b = buttons[i];
		if(point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), b.bounds[0], b.bounds[1], b.bounds[2], b.bounds[3]))
			buttonid = b.type;
	}
	for(var i = 0; i < 2; i++)
	{
		var b = scalebuttons[i];
		if(point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), b.bounds[0], b.bounds[1], b.bounds[2], b.bounds[3]))
		{
			zoom += i ? -0.1 : 0.1;
			zoom = clamp(zoom, 0.1, 5);
		}
	}
	if(buttonid == BUTTON_IDS.BUILD)
	{
		for(var i = 0, display_len = array_length(display_objects) - 1; i < maxob; i++)
		{
			if(i > display_len)
					break;
			if(point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), object_x + (object_size + 10) * i, object_y, object_x + object_size + (object_size + 10) * i, object_y + object_size))
			{
				omv = true;
				obj = display_objects[i + display_offset];
				var tempspr = object_get_sprite(obj);
				spr = sprite_exists(tempspr) ? tempspr : spr_fakereditorer_unknown;
			}
		}
		for(var i = 0; i < 2; i++)
		{
			var b = pagebuttons[i];
			if(point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), b.bounds[i ? 0 : 2], b.bounds[1], b.bounds[i ? 2 : 0], b.bounds[3]))
			{
				if(i ? (display_offset + maxob < array_length(display_objects)) : (display_offset > 0))
					display_offset += i ? maxob : -maxob
			}
		}
		if(point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 220, 480, 740, 510))
		{
			q_jump_page = get_integer_async("Jump to page", last_search_page);
		}
	}
	if(buttonid == BUTTON_IDS.EDIT)
	{
		for(var i = 0; i < 8; i++)
		{
			var b = editbuttons[i];
			if(point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), b.bounds[0], b.bounds[1], b.bounds[2], b.bounds[3]))
				b.func();
		}
	}
	if(!point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 0, 340, 960, 540))
	{
		cx = mouse_x;
		cy = mouse_y; 
		if(buttonid == BUTTON_IDS.BUILD)
			mv = true;
		if(buttonid == BUTTON_IDS.EDIT)
		{
			var _list = ds_list_create();
			var _num = instance_position_list(mouse_x, mouse_y, obj_fakereditorercontent, _list, true);
			if(_num > 0)
			{
				for (var i = 0; i < _num; ++i)
				{
					var inst = _list[| i];
					var ob = inst.object_index;
					if(selectedobject != inst/* && ob != obj_virtual_controller*/)
					{
						selectedobject = inst
						break;
					}
				}
			}
			ds_list_destroy(_list);
		}
		if(buttonid == BUTTON_IDS.DELETE)
		{
			var _list = ds_list_create();
			var _num = instance_position_list(mouse_x, mouse_y, obj_fakereditorercontent, _list, true);
			if(_num > 0)
			{
				for (var i = 0; i < _num; ++i)
				{
					var inst = _list[| i];
					var ob = inst.object_index;
					//if(ob != obj_virtual_controller && ob != obj_player1 && ob != obj_heatafterimage && ob != obj_tv && ob != obj_camera && ob != obj_baddiecollisionbox)
					//{
					    instance_destroy(inst);
						break;
					//}
				}
			}
			ds_list_destroy(_list);
		}
	}
	camera_set_view_size(view_camera[0], (960 * zoom), (540 * zoom));
}
if(mouse_check_button(mb_left) && mv) 
	camera_set_view_pos(view_camera[0], cx - (mouse_x - camera_get_view_x(view_camera[0])), cy - (mouse_y - camera_get_view_y(view_camera[0])));
else 
	mv = false;
if(mouse_check_button_released(mb_left) && omv)
{
	with(instance_create_depth(mouse_x, mouse_y, depth, obj_fakereditorercontent))
	{
		content = other.obj;
		var _spr = object_get_sprite(other. obj);
		sprite_index = _spr == -1 ? spr_fakereditorer_unknown : _spr;
	}
	omv = false;
}