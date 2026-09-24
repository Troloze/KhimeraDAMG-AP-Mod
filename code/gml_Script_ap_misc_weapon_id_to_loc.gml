var wep_id = argument0;

if (is_undefined(global.ap_weapon_id_to_loc)) {
    // Why couldn't the devs just follow the order of the stage ids THEY THEMSELVES HAD SET?
    var json = "{"
    + "'2': 10100002,"
    + "'3': 20100002,"
    + "'4': 30100002,"
    + "'5': 40100002,"
    + "'6': 70100002,"
    + "'7': 50100002,"
    + "'8': 60100002,"
    + "'9': 80100002"
    + "}"; // the line above cannot have a comma at the end.
    
    global.ap_weapon_id_to_loc = json_decode(json);
    if (ds_map_exists(global.ap_weapon_id_to_loc, "default")) ap_misc_crash("Malformed weapon id_to_loc json structure.");
}

return ds_map_find_value(global.ap_weapon_id_to_loc, string_format(wep_id, 0, 0));