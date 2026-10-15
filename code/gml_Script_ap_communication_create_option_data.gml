var names = argument0;
var types = argument1;
var values = argument2;
var count = argument3;

var option_data = ds_map_create();
var list_safety_guard = ds_list_create();
var map_safety_guard = ds_list_create();
var error = 0;
var i, j;

for (i = 0; i < count; i++) {
    var c_name = ds_list_find_value(names, i);
    var c_type = ds_list_find_value(types, i);
    var c_value = ds_list_find_value(values, i);
    if (is_undefined(c_name)) {
        error = 1;
        break;
    }
    if (is_undefined(c_type)) {
        error = 1;
        break;
    }
    if (is_undefined(c_value)) {
        error = 1;
        break;
    }
    
    switch(c_type) {
        case "SV":
        case "NV":
            ds_map_replace(option_data, c_name, c_value);
            break;
        case "SL":
        case "NL":
            var c_list = ds_list_create();
            ds_list_add(list_safety_guard, c_list);
            var l_size = ds_list_size(c_value);
            
            for (j = 0; j < l_size; j++) ds_list_add(c_list, ds_list_find_value(c_value, j));
            ds_map_replace(option_data, c_name, c_list);
            break;
        case "D":
            var c_map = ds_map_create();
            ds_list_add(map_safety_guard, c_map);
            
            // Only works because the contract specifies dicts cannot have nested dicts or lists.
            var cur_key = ds_map_find_first(c_value);
            while (!is_undefined(cur_key)) {
                // cur_key is required to be a string, but the game will not check, this is the client's responsibility.
                var cur_value = ds_map_find_value(c_value, cur_key);
                ds_map_replace(c_map, cur_key, cur_value);
                
                cur_key = ds_map_find_next(c_value, cur_key);
            }
                
            ds_map_replace(option_data, c_name, c_map);
            break;
        default:
            error = 1;
            break;
    }
    if (error == 1) break;
}



if (error) {
    var l_size = ds_list_size(list_safety_guard);
    var m_size = ds_list_size(map_safety_guard);
    for (i = 0; i < l_size; i++) ds_list_destroy(ds_list_find_value(list_safety_guard, i));
    for (i = 0; i < m_size; i++) ds_map_destroy(ds_list_find_value(map_safety_guard, i));
    
    ds_list_destroy(list_safety_guard);
    ds_list_destroy(map_safety_guard);
    ds_map_destroy(option_data);
    option_data = -1;
} else {
    ds_map_replace(option_data, "__ds_list_references", list_safety_guard);
    ds_map_replace(option_data, "__ds_map_references", map_safety_guard);
}

return option_data;