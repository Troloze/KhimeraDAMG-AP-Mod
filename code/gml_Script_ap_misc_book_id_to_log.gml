var book_id = argument0

if (is_undefined(global.ap_book_id_to_loc)) {
    global.ap_book_id_to_loc[1] =  ap_location_make( 0, global.AP_LOC_BOOK, 3);          // Ragazza plains 3 (Chelshia)
    global.ap_book_id_to_loc[2] =  ap_location_make( 1, global.AP_LOC_BOOK, 2);          // Sky Fortress 2 (The Professor)
    global.ap_book_id_to_loc[3] =  ap_location_make( 3, global.AP_LOC_BOOK, 4);          // Pumpkin Valley 4 (Bernadette)
    global.ap_book_id_to_loc[4] =  ap_location_make( 0, global.AP_LOC_BOOK, 2);          // Ragazza plains 2 (Floof Pirate)
    global.ap_book_id_to_loc[5] =  ap_location_make( 1, global.AP_LOC_BOOK, 1);          // Sky Fortress 1 (Floof Aviator)
    global.ap_book_id_to_loc[6] =  ap_location_make( 4, global.AP_LOC_BOOK, 3);          // Oil Platform 3 (Floof Bomber)
    global.ap_book_id_to_loc[7] =  ap_location_make( 4, global.AP_LOC_BOOK, 2);          // Oil Platform 2 (Pirate Swordsman)
    global.ap_book_id_to_loc[8] =  ap_location_make( 7, global.AP_LOC_BOOK, 2);          // Windy Way 2 (Pirate Marksman)
    global.ap_book_id_to_loc[9] =  ap_location_make( 1, global.AP_LOC_BOOK, 3);          // Sky Fortress 3 (Pirate Cannoneer)
    global.ap_book_id_to_loc[10] = ap_location_make( 8, global.AP_LOC_BOOK, 2);          // Brine Cave 2 (Pirate Demolitions)
    global.ap_book_id_to_loc[11] = ap_location_make( 2, global.AP_LOC_BOOK, 1);          // Mt. Afrokupa 1 (Pirate Explorer)
    global.ap_book_id_to_loc[12] = ap_location_make(10, global.AP_LOC_BOOK, 1);          // The Black Widow 1 (Pirate Samurai)
    global.ap_book_id_to_loc[13] = ap_location_make( 9, global.AP_LOC_BOOK, 1);          // Ragazza Town 1 (Scuttlebit)
    global.ap_book_id_to_loc[14] = ap_location_make( 3, global.AP_LOC_BOOK, 1);          // Pumpkin Valley 1 (Zambot)
    global.ap_book_id_to_loc[15] = ap_location_make( 3, global.AP_LOC_BOOK, 2);          // Pumpkin Valley 2 (Seedle)
    global.ap_book_id_to_loc[16] = ap_location_make( 2, global.AP_LOC_BOOK, 2);          // Mt. Afrokupa 2 (Misboro)
    global.ap_book_id_to_loc[17] = ap_location_make( 6, global.AP_LOC_BOOK, 1);          // Icy Path 1 (Skallo)
    global.ap_book_id_to_loc[18] = ap_location_make( 7, global.AP_LOC_BOOK, 1);          // Windy Way 1 (Kiran)
    global.ap_book_id_to_loc[19] = ap_location_make( 2, global.AP_LOC_BOOK, 3);          // Mt. Afrokupa 3 (Little Oni)
    global.ap_book_id_to_loc[20] = ap_location_make( 8, global.AP_LOC_BOOK, 1);          // Brine Cave 1 (Squidge)
    global.ap_book_id_to_loc[21] = ap_location_make( 4, global.AP_LOC_BOOK, 4);          // Oil Platform 4 (Tamole)
    global.ap_book_id_to_loc[22] = ap_location_make( 5, global.AP_LOC_BOOK, 1);          // Tower of Power 1 (Spaîctre Die)
    global.ap_book_id_to_loc[23] = ap_location_make(10, global.AP_LOC_BOOK, 2);          // The Black Widow 2 (Weekday Witches)
    global.ap_book_id_to_loc[24] = ap_location_make( 6, global.AP_LOC_BOOK, 2);          // Icy Path 2 (Chibeara)
    global.ap_book_id_to_loc[25] = ap_location_make( 0, global.AP_LOC_BOOK, 1);          // Ragazza plains 1 (Serpantina)
    global.ap_book_id_to_loc[26] = ap_location_make( 1, global.AP_LOC_BOOK, 4);          // Sky Fortress 4 (Amelia)
    global.ap_book_id_to_loc[27] = ap_location_make( 2, global.AP_LOC_BOOK, 4);          // Mt. Afrokupa 4 (Anchovy)
    global.ap_book_id_to_loc[28] = ap_location_make( 3, global.AP_LOC_BOOK, 3);          // Pumpkin Valley 3 (Mimi the Mimic)
    global.ap_book_id_to_loc[29] = ap_location_make( 4, global.AP_LOC_BOOK, 1);          // Oil Platform 1 (Pacifica Oceana)
    global.ap_book_id_to_loc[30] = ap_location_make(11, global.AP_LOC_BOOK, 1);          // Mechanical Mayhem 1 (DJ Doroko)
    global.ap_book_id_to_loc[31] = ap_location_make(12, global.AP_LOC_BOOK, 1);          // The Spiders Web 1 (The Pirate Captain)
    global.ap_book_id_to_loc[32] = ap_location_make(13, global.AP_LOC_BOOK, 2);          // The Fairies Domain 2 (The Fairy Queen)
    global.ap_book_id_to_loc[33] = ap_location_make(13, global.AP_LOC_BOOK, 1);          // The Fairies Domain 1 (Gourmet Gal)
    global.ap_book_id_to_loc[34] = ap_location_make(16, global.AP_LOC_BOOK, 1);          // ??? 1 (Mouthface)
    global.ap_book_id_to_loc[35] = ap_location_make( 9, global.AP_LOC_BOOK, 2);          // Ragazza Town 2 (Nyazione)
    global.ap_book_id_to_loc[36] = ap_location_make(14, global.AP_LOC_BOOK, 1);          // Chelshia's House 1 (Muffey)
    global.ap_book_id_to_loc[37] = ap_location_make( 5, global.AP_LOC_BOOK, 2);          // Tower of Power 2 (Estylia)
    global.ap_book_id_to_loc[38] = ap_location_make(18, global.AP_LOC_BOOK, 1);          // Cakeboy 1 (Cakeboy) [Technically Chelshia's House 2]
}

if (book_id < 0 || book_id > 38) return undefined;

return global.ap_book_id_to_loc[book_id]