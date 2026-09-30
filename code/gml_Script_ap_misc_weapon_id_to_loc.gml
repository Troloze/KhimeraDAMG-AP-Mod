var wep_id = argument0;

if (is_undefined(global.ap_weapon_id_to_loc)) {
    // Why couldn't the devs just follow the order of the stage ids THEY THEMSELVES HAD SET?
    var json = "{"
    + "'2': " + string_format(ap_location_make(1, global.AP_LOC_CLEAR, 2), 0, 0) + ","
    + "'3': " + string_format(ap_location_make(2, global.AP_LOC_CLEAR, 2), 0, 0) + ","
    + "'4': " + string_format(ap_location_make(3, global.AP_LOC_CLEAR, 2), 0, 0) + ","
    + "'5': " + string_format(ap_location_make(4, global.AP_LOC_CLEAR, 2), 0, 0) + ","
    + "'6': " + string_format(ap_location_make(7, global.AP_LOC_CLEAR, 2), 0, 0) + ","
    + "'7': " + string_format(ap_location_make(5, global.AP_LOC_CLEAR, 2), 0, 0) + ","
    + "'8': " + string_format(ap_location_make(6, global.AP_LOC_CLEAR, 2), 0, 0) + ","
    + "'9': " + string_format(ap_location_make(8, global.AP_LOC_CLEAR, 2), 0, 0)
    + "}"; // the line above cannot have a comma at the end.
    
    global.ap_weapon_id_to_loc = json_decode(json);
    if (ds_map_exists(global.ap_weapon_id_to_loc, "default")) ap_misc_crash("Malformed weapon id_to_loc json structure.");
}

return ds_map_find_value(global.ap_weapon_id_to_loc, string_format(wep_id, 0, 0));