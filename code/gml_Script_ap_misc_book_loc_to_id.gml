var loc = argument0;

if (is_undefined(global.ap_book_loc_to_id)) {
    var json = "{"
    + "'" + string_format(ap_location_make( 0, global.AP_LOC_BOOK, 1), 0, 0) + "': 25,"      // Ragazza plains 1 (Serpantina)
    + "'" + string_format(ap_location_make( 0, global.AP_LOC_BOOK, 2), 0, 0) + "': 4,"       // Ragazza plains 2 (Floof Pirate)
    + "'" + string_format(ap_location_make( 0, global.AP_LOC_BOOK, 3), 0, 0) + "': 1,"       // Ragazza plains 3 (Chelshia)
    + "'" + string_format(ap_location_make( 1, global.AP_LOC_BOOK, 1), 0, 0) + "': 5,"       // Sky Fortress 1 (Floof Aviator)
    + "'" + string_format(ap_location_make( 1, global.AP_LOC_BOOK, 2), 0, 0) + "': 2,"       // Sky Fortress 2 (The Professor)
    + "'" + string_format(ap_location_make( 1, global.AP_LOC_BOOK, 3), 0, 0) + "': 9,"       // Sky Fortress 3 (Pirate Cannoneer)
    + "'" + string_format(ap_location_make( 1, global.AP_LOC_BOOK, 4), 0, 0) + "': 26,"      // Sky Fortress 4 (Amelia)
    + "'" + string_format(ap_location_make( 2, global.AP_LOC_BOOK, 1), 0, 0) + "': 11,"      // Mt. Afrokupa 1 (Pirate Explorer)
    + "'" + string_format(ap_location_make( 2, global.AP_LOC_BOOK, 2), 0, 0) + "': 16,"      // Mt. Afrokupa 2 (Misboro)
    + "'" + string_format(ap_location_make( 2, global.AP_LOC_BOOK, 3), 0, 0) + "': 19,"      // Mt. Afrokupa 3 (Little Oni)
    + "'" + string_format(ap_location_make( 2, global.AP_LOC_BOOK, 4), 0, 0) + "': 27,"      // Mt. Afrokupa 4 (Anchovy)
    + "'" + string_format(ap_location_make( 3, global.AP_LOC_BOOK, 1), 0, 0) + "': 14,"      // Pumpkin Valley 1 (Zambot)
    + "'" + string_format(ap_location_make( 3, global.AP_LOC_BOOK, 2), 0, 0) + "': 15,"      // Pumpkin Valley 2 (Seedle)
    + "'" + string_format(ap_location_make( 3, global.AP_LOC_BOOK, 3), 0, 0) + "': 28,"      // Pumpkin Valley 3 (Mimi the Mimic)
    + "'" + string_format(ap_location_make( 3, global.AP_LOC_BOOK, 4), 0, 0) + "': 3,"       // Pumpkin Valley 4 (Bernadette)
    + "'" + string_format(ap_location_make( 4, global.AP_LOC_BOOK, 1), 0, 0) + "': 29,"      // Oil Platform 1 (Pacifica Oceana)
    + "'" + string_format(ap_location_make( 4, global.AP_LOC_BOOK, 2), 0, 0) + "': 7,"       // Oil Platform 2 (Pirate Swordsman)
    + "'" + string_format(ap_location_make( 4, global.AP_LOC_BOOK, 3), 0, 0) + "': 6,"       // Oil Platform 3 (Floof Bomber)
    + "'" + string_format(ap_location_make( 4, global.AP_LOC_BOOK, 4), 0, 0) + "': 21,"      // Oil Platform 4 (Tamole)
    + "'" + string_format(ap_location_make( 5, global.AP_LOC_BOOK, 1), 0, 0) + "': 22,"      // Tower of Power 1 (Spaîctre Die)
    + "'" + string_format(ap_location_make( 5, global.AP_LOC_BOOK, 2), 0, 0) + "': 37,"      // Tower of Power 2 (Estylia)
    + "'" + string_format(ap_location_make( 6, global.AP_LOC_BOOK, 1), 0, 0) + "': 17,"      // Icy Path 1 (Skallo)
    + "'" + string_format(ap_location_make( 6, global.AP_LOC_BOOK, 2), 0, 0) + "': 24,"      // Icy Path 2 (Chibeara)
    + "'" + string_format(ap_location_make( 7, global.AP_LOC_BOOK, 1), 0, 0) + "': 18,"      // Windy Way 1 (Kiran)
    + "'" + string_format(ap_location_make( 7, global.AP_LOC_BOOK, 2), 0, 0) + "': 8,"       // Windy Way 2 (Pirate Marksman)
    + "'" + string_format(ap_location_make( 8, global.AP_LOC_BOOK, 1), 0, 0) + "': 20,"      // Brine Cave 1 (Squidge)
    + "'" + string_format(ap_location_make( 8, global.AP_LOC_BOOK, 2), 0, 0) + "': 10,"      // Brine Cave 2 (Pirate Demolitions)
    + "'" + string_format(ap_location_make( 9, global.AP_LOC_BOOK, 1), 0, 0) + "': 13,"      // Ragazza Town 1 (Scuttlebit)
    + "'" + string_format(ap_location_make( 9, global.AP_LOC_BOOK, 2), 0, 0) + "': 35,"      // Ragazza Town 2 (Nyazione)
    + "'" + string_format(ap_location_make(10, global.AP_LOC_BOOK, 1), 0, 0) + "': 12,"      // The Black Widow 1 (Pirate Samurai)
    + "'" + string_format(ap_location_make(10, global.AP_LOC_BOOK, 2), 0, 0) + "': 23,"      // The Black Widow 2 (Weekday Witches)
    + "'" + string_format(ap_location_make(11, global.AP_LOC_BOOK, 1), 0, 0) + "': 30,"      // Mechanical Mayhem 1 (DJ Doroko)
    + "'" + string_format(ap_location_make(12, global.AP_LOC_BOOK, 1), 0, 0) + "': 31,"      // The Spiders Web 1 (The Pirate Captain)
    + "'" + string_format(ap_location_make(13, global.AP_LOC_BOOK, 1), 0, 0) + "': 33,"      // The Fairies Domain 1 (Gourmet Gal)
    + "'" + string_format(ap_location_make(13, global.AP_LOC_BOOK, 2), 0, 0) + "': 32,"      // The Fairies Domain 2 (The Fairy Queen)
    + "'" + string_format(ap_location_make(14, global.AP_LOC_BOOK, 1), 0, 0) + "': 36,"      // Chelshia's House 1 (Muffey)
    + "'" + string_format(ap_location_make(16, global.AP_LOC_BOOK, 1), 0, 0) + "': 34,"      // ??? 1 (Mouthface)
    + "'" + string_format(ap_location_make(18, global.AP_LOC_BOOK, 1), 0, 0) + "': 38"      // Cakeboy 1 (Cakeboy) [Technically Chelshia's House 2]
    + "}"; // the line above cannot have a comma at the end.
    
    global.ap_book_loc_to_id = json_decode(json);
    if (ds_map_exists(global.ap_book_loc_to_id, "default")) ap_misc_crash("Malformed book loc_to_id json structure.");
}

return ds_map_find_value(global.ap_book_loc_to_id, string_format(loc, 0, 0))
