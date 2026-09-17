var option_data = argument0;


var list_ref = ds_map_find_value(option_data, "__ds_list_references");
var map_ref = ds_map_find_value(option_data, "__ds_map_references");
var i;
if(!is_undefined(list_ref)) {
    var l_size = ds_list_size(list_ref);
    for (i = 0; i < l_size; i++) ds_list_destroy(ds_list_find_value(list_ref, i));
    ds_list_destroy(list_ref);
}
if(!is_undefined(map_ref)) {
    var m_size = ds_list_size(map_ref);
    for (i = 0; i < m_size; i++) ds_map_destroy(ds_list_find_value(map_ref, i));
    ds_list_destroy(map_ref);
}

ds_map_destroy(option_data);