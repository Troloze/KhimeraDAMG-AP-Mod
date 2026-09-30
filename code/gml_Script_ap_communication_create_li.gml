var loc_ids = argument0;
var loc_class = argument1;
var loc_pids = argument2;
var count = argument3;

var error = 0;
var loc_info = ds_map_create();
var safety_guard = ds_list_create();
var i;
for (i = 0; i < count; i++) {
    var c_id = ds_list_find_value(loc_ids, i);
    var c_class = ds_list_find_value(loc_class, i);
    var c_pid = ds_list_find_value(loc_pids, i);
    if (is_undefined(c_id)) {
        error = 1;
        break;
    }
    if (is_undefined(c_class)) {
        error = 1;
        break;
    }
    if (is_undefined(c_pid)) {
        error = 1;
        break;
    }
    
    var entry_value = ds_map_create();
    ds_list_add(safety_guard, entry_value);
    ds_map_replace(entry_value, "classification", c_class);
    ds_map_replace(entry_value, "player", c_pid);
    ds_map_replace(loc_info, c_id, entry_value);
}

if (error) {
    var s_size = ds_list_size(safety_guard);
    for (i = 0; i < s_size; i++) {
        ds_map_destroy(ds_list_find_value(safety_guard, i));
    }
    ds_map_destroy(loc_info);
    loc_info = -1;
}

ds_list_destroy(safety_guard);

return loc_info;