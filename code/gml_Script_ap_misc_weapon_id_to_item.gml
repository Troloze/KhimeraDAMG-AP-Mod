var wep_id = argument0;

if (is_undefined(global.ap_weapon_id_to_item)) {
    // Why couldn't the devs just follow the order of the stage ids THEY THEMSELVES HAD SET?
    var json = "{"
    + "'2': " + string_format(ap_item_make(global.AP_ITEM_WEAPON, 1), 0, 0) + ","
    + "'3': " + string_format(ap_item_make(global.AP_ITEM_WEAPON, 2), 0, 0) + ","
    + "'4': " + string_format(ap_item_make(global.AP_ITEM_WEAPON, 3), 0, 0) + ","
    + "'5': " + string_format(ap_item_make(global.AP_ITEM_WEAPON, 4), 0, 0) + ","
    + "'6': " + string_format(ap_item_make(global.AP_ITEM_WEAPON, 7), 0, 0) + ","
    + "'7': " + string_format(ap_item_make(global.AP_ITEM_WEAPON, 5), 0, 0) + ","
    + "'8': " + string_format(ap_item_make(global.AP_ITEM_WEAPON, 6), 0, 0) + ","
    + "'9': " + string_format(ap_item_make(global.AP_ITEM_WEAPON, 8), 0, 0)
    + "}"; // the line above cannot have a comma at the end. 
    
    global.ap_weapon_id_to_item = json_decode(json);
    if (ds_map_exists(global.ap_weapon_id_to_item, "default")) ap_misc_crash("Malformed weapon id_to_item json structure.");
}

return ds_map_find_value(global.ap_weapon_id_to_item, string_format(wep_id, 0, 0));