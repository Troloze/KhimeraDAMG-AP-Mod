var wep_id = argument0;

if (is_undefined(global.ap_weapon_id_to_item)) {
    // Why couldn't the devs just follow the order of the stage ids THEY THEMSELVES HAD SET?
    var json = "{"
    + "'2': 500000001,"
    + "'3': 500000002,"
    + "'4': 500000003,"
    + "'5': 500000004,"
    + "'6': 500000007,"
    + "'7': 500000005,"
    + "'8': 500000006,"
    + "'9': 500000008"
    + "}"; 
    
    global.ap_weapon_id_to_item = json_decode(json);
    if (ds_map_exists(global.ap_weapon_id_to_item, "default")) ap_misc_crash("Malformed weapon id_to_item json structure.");
}

return ds_map_find_value(global.ap_weapon_id_to_item, string_format(wep_id, 0, 0));