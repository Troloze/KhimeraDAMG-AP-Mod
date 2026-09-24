var value = argument0;

if (is_undefined(global.ap_gen_info_default)) {
    var default_values = '{'
    + '}' ; // the line above cannot have a comma at the end.

    global.ap_gen_info_default = json_decode(default_values);
}

return ds_map_find_value(global.ap_gen_info_default, value);