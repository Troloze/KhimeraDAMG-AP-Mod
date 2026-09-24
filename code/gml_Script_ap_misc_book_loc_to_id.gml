var loc = argument0;

if (is_undefined(global.ap_book_loc_to_id)) {
    var json = "{"
    + "'300001': 25,"      // Ragazza plains 1 (Serpantina)
    + "'300002': 4,"       // Ragazza plains 2 (Floof Pirate)
    + "'300003': 1,"       // Ragazza plains 3 (Chelshia)
    + "'10300001': 5,"       // Sky Fortress 1 (Floof Aviator)
    + "'10300002': 2,"       // Sky Fortress 2 (The Professor)
    + "'10300003': 9,"       // Sky Fortress 3 (Pirate Cannoneer)
    + "'10300004': 26,"      // Sky Fortress 4 (Amelia)
    + "'20300001': 11,"      // Mt. Afrokupa 1 (Pirate Explorer)
    + "'20300002': 16,"      // Mt. Afrokupa 2 (Misboro)
    + "'20300003': 19,"      // Mt. Afrokupa 3 (Little Oni)
    + "'20300004': 27,"      // Mt. Afrokupa 4 (Anchovy)
    + "'30300001': 14,"      // Pumpkin Valley 1 (Zambot)
    + "'30300002': 15,"      // Pumpkin Valley 2 (Seedle)
    + "'30300003': 28,"      // Pumpkin Valley 3 (Mimi the Mimic)
    + "'30300004': 3,"       // Pumpkin Valley 4 (Bernadette)
    + "'40300001': 29,"      // Oil Platform 1 (Pacifica Oceana)
    + "'40300002': 7,"       // Oil Platform 2 (Pirate Swordsman)
    + "'40300003': 6,"       // Oil Platform 3 (Floof Bomber)
    + "'40300004': 21,"      // Oil Platform 4 (Tamole)
    + "'50300001': 22,"      // Tower of Power 1 (Spaîctre Die)
    + "'50300002': 37,"      // Tower of Power 2 (Estylia)
    + "'60300001': 17,"      // Icy Path 1 (Skallo)
    + "'60300002': 24,"      // Icy Path 2 (Chibeara)
    + "'70300001': 18,"      // Windy Way 1 (Kiran)
    + "'70300002': 8,"       // Windy Way 2 (Pirate Marksman)
    + "'80300001': 20,"      // Brine Cave 1 (Squidge)
    + "'80300002': 10,"      // Brine Cave 2 (Pirate Demolitions)
    + "'90300001': 13,"      // Ragazza Town 1 (Scuttlebit)
    + "'90300002': 35,"      // Ragazza Town 2 (Nyazione)
    + "'100300001': 12,"      // The Black Widow 1 (Pirate Samurai)
    + "'100300002': 23,"      // The Black Widow 2 (Weekday Witches)
    + "'110300001': 30,"      // Mechanical Mayhem 1 (DJ Doroko)
    + "'120300001': 31,"      // The Spiders Web 1 (The Pirate Captain)
    + "'130300001': 33,"      // The Fairies Domain 1 (Gourmet Gal)
    + "'130300002': 32,"      // The Fairies Domain 2 (The Fairy Queen)
    + "'140300001': 36,"      // Chelshia's House 1 (Muffey)
    + "'160300001': 34,"      // ??? 1 (Mouthface)
    + "'180300001': 38"      // Cakeboy 1 (Cakeboy) [Technically Chelshia's House 2]
    + "}"; // the line above cannot have a comma at the end.
    
    global.ap_book_loc_to_id = json_decode(json);
    if (ds_map_exists(global.ap_book_loc_to_id, "default")) ap_misc_crash("Malformed book loc_to_id json structure.");
}

return ds_map_find_value(global.ap_book_loc_to_id, string_format(loc, 0, 0))
