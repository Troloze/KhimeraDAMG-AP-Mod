var loc = argument0;

if (is_undefined(global.ap_weapon_loc_to_id)) {
    // Why couldn't the devs just follow the order of the stage ids THEY THEMSELVES HAD SET?
    var json = "{"
    + "'10100002': 2,"
    + "'20100002': 3,"
    + "'30100002': 4,"
    + "'40100002': 5,"
    + "'50100002': 7,"
    + "'60100002': 8,"
    + "'70100002': 6,"
    + "'80100002': 9"
    + "}"; // the line above cannot have a comma at the end.
    
    global.ap_weapon_loc_to_id = json_decode(json);
    if (ds_map_exists(global.ap_weapon_loc_to_id, "default")) ap_misc_crash("Malformed weapon loc_to_id json structure.");
}

return ds_map_find_value(global.ap_weapon_loc_to_id, string_format(loc, 0, 0));