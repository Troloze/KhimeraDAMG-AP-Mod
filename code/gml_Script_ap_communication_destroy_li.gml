var li = argument0;

var current_key = ds_map_find_first(li);
while (!is_undefined(current_key)) {
    var current_value = ds_map_find_value(li, current_key);
    ds_map_destroy(current_value);
    current_key = ds_map_find_next(li, current_key);
}

ds_map_destroy(li);