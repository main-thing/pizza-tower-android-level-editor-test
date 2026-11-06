live_auto_call;
var i_d = ds_map_find_value(async_load, "id");
if(!ds_map_find_value(async_load, "status"))
	exit;
if(i_d == q_search_object)
{
	var _name = ds_map_find_value(async_load, "result");
	last_search = _name;
	if(string_trim(_name) == "" || string_trim(_name) == "*")
		return array_copy(display_objects, 0, objlist, 0, array_length(objlist));
	for(var i = 0;i < array_length(objlist);i++)
	{
		if(string_pos(_name, object_get_name(objlist[i])) != 0 && string_pos("__YYInternalObject", object_get_name(i)) == 0)
			array_push(display_objects, objlist[i]);
	}
}
if(i_d == q_search_object_verbatim)
{
	var _objects = ds_map_find_value(async_load, "result");
	last_search_verbatim = _objects;
	var objs = string_split(_objects + ",", ",", true);
	for(var i = 0;i < array_length(objs);i++)
	{
		var obj = asset_get_index(string_trim(objs[i]));
		if(object_exists(obj) && string_pos("__YYInternalObject", object_get_name(i)) == 0)
			array_push(display_objects, obj);
	}
}
if(i_d == q_search_object_parent)
{
	var _name = ds_map_find_value(async_load, "result");
	last_search_parent = _name;
	var parentobj = asset_get_index(_name);
	if(object_exists(parentobj))
	{
		for(var i = 0;i < array_length(objlist);i++)
		{
			if(object_get_parent(objlist[i]) == parentobj)
				array_push(display_objects, objlist[i]);
		}
	}
}
if(i_d == q_jump_page)
{
	var _value = ds_map_find_value(async_load, "result");
	try _value = real(_value)
	catch(e) _value = 1;
	last_search_page = _value;
	_value = clamp(_value, 1, ceil(array_length(display_objects) / maxob))
	display_offset = (_value - 1) * maxob;
}