var value = argument0;

if (is_undefined(global.ap_options_default)) {
    var default_values = '{'
    + '"death_link": 0,'
    + '"victory_condition": 0,'
    + '"shuffle_books": 0,'
    + '"shuffle_fairies": 0,'
    + '"shuffle_detonators": 0,'
    + '"shuffle_gourmet_gal": 0'
    + '}' ; // the line above cannot have a comma at the end.

    global.ap_options_default = json_decode(default_values);
}

return ds_map_find_value(global.ap_options_default, value);