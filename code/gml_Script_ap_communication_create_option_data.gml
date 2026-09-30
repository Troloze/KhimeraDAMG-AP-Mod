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
            var m_size = ds_list_size(c_value) / 2;
            
            // Assumes non list. This goes against the contract, but I will deal with this later.
            for (j = 0; j < m_size; j++) ds_map_replace(c_map, ds_list_find_value(c_value, 2 * j), ds_list_find_value(c_value, 2 * j + 1));
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