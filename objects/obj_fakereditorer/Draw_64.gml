live_auto_call;
draw_set_alpha(0.2);
draw_sprite_stretched(ref, 0, 0, 0, 960, 540);
var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);
var vw = camera_get_view_width(view_camera[0]) / 960;
var vh = camera_get_view_height(view_camera[0]) / 540;

draw_set_alpha(1);
draw_set_color(c_gray);
var b = playbutton;
var c = playbutton_triangle;
draw_rectangle(b[0], b[1], b[2], b[3], false);
draw_set_color(c_black);
draw_triangle(c[0], c[1], c[0], c[3], c[2], c[1] + (c[3] - c[1]) / 2, false);
if(!edit_mode)
	return;
	
draw_set_font(creditsfont_placeholder);
draw_set_color(c_white);
draw_set_halign(1);
draw_set_valign(0);
with(selectedobject)
{
	var tempspr = sprite_exists(sprite_index) ? sprite_index : spr_wall;
	draw_sprite_ext(tempspr, image_index, (x - vx) / vw, (y - vy) / vh, image_xscale / other.zoom, image_yscale / other.zoom, image_angle, c_red, 0.5);
	draw_text(480, 70, object_get_name(content));
}
draw_set_alpha(0.5);
draw_set_color(c_red);
draw_rectangle(0, 390, 960, 540, false);
draw_set_alpha(1);
for(var i = 0; i < 2; i++)
{
	var b = buttons[i];
	draw_set_color(i == buttonid ? c_aqua : c_lime);
	draw_rectangle(b.bounds[0], b.bounds[1], b.bounds[2], b.bounds[3], false);
}
for(var i = 0; i < 2; i++)
{
	var b = scalebuttons[i];
	draw_set_color(i ? c_green : c_red);
	draw_rectangle(b.bounds[0], b.bounds[1], b.bounds[2], b.bounds[3], false);
}
var b = menubutton;
draw_set_color(c_yellow);
draw_rectangle(b[0], b[1], b[2], b[3], false);

if(buttonid == 0)
{
	for(var i = 0; i < 2; i++)
	{
		var b = pagebuttons[i];
		draw_set_color(c_aqua);
		draw_set_alpha(i ? (display_offset + maxob < array_length(display_objects)) : (display_offset > 0));
		draw_triangle(b.bounds[0], b.bounds[1], b.bounds[0], b.bounds[3], b.bounds[2], b.bounds[1] + (b.bounds[3] - b.bounds[1]) / 2, false);
	}
}
draw_set_alpha(1);
draw_set_font(creditsfont_placeholder);
draw_set_color(c_white);
draw_set_halign(0);
for(var i = 0; i < 2; i++)
{
	var b = buttons[i];
	draw_text(b.bounds[0], b.bounds[1], b.name);
}
draw_set_color(c_gray);
if(buttonid == BUTTON_IDS.BUILD)
{
	for(var i = 0, display_len = array_length(display_objects) - 1; i < maxob; i++)
	{
		var j = i + display_offset;
		if(j > display_len)
			break;
		draw_rectangle(object_x + (object_size + 10) * i, object_y, object_x + object_size + (object_size + 10) * i, object_y + object_size, false);
		var tempspr = sprite_exists(object_get_sprite(display_objects[j])) ? object_get_sprite(display_objects[j]) : spr_fakereditorer_unknown;
		var w = sprite_get_width(tempspr);
		var h = sprite_get_height(tempspr);
		var s = min(object_size / h, object_size / w);
		var ox = sprite_get_xoffset(tempspr) * s;
		var oy = sprite_get_yoffset(tempspr) * s;
		draw_sprite_ext(tempspr, 0, object_x + (object_size + 10) * i + ox, object_y + oy, s, s, 0, c_white, 1);
	}
	draw_set_halign(1);
	draw_text(480, 500, string(display_offset / maxob + 1) + "/" + string(ceil(array_length(display_objects) / maxob)));
}
draw_set_halign(0);
if(buttonid == BUTTON_IDS.EDIT)
{
	for(var i = 0; i < 8; i++)
	{
		if(i > array_length(editbuttons) - 1)
			break;
		draw_set_color(c_lime);
		var b = editbuttons[i];
		draw_rectangle(b.bounds[0], b.bounds[1], b.bounds[2], b.bounds[3], false);
		draw_set_color(c_white);
		draw_set_font(smallfont2_placeholder)
		draw_text(b.bounds[0], b.bounds[1], b.name);
	}
}
if(omv)
{
	draw_sprite_ext(spr, 0, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 1 / zoom, 1 / zoom, 0, c_white, 1);
	draw_set_color(c_white);
	draw_set_font(smallfont2_placeholder);
	draw_set_halign(1);
	draw_text(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0) - 70, object_get_name(obj));
}

if(mobj != noone)
{
	draw_set_color(c_white);
	draw_text(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), object_get_name(mobj));
}
draw_circle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 5, false);