var book_id = argument0

if (is_undefined(global.ap_book_id_to_loc)) {
    // Start at last index for faster alocation
    global.ap_book_id_to_loc[38] = 180300003;        // Cakeboy 1 (Cakeboy) [Technically Chelshia's House 2]
    global.ap_book_id_to_loc[1] = 300003;            // Ragazza plains 3 (Chelshia)
    global.ap_book_id_to_loc[2] = 10300002;          // Sky Fortress 2 (The Professor)
    global.ap_book_id_to_loc[3] = 30300004;          // Pumpkin Valley 4 (Bernadette)
    global.ap_book_id_to_loc[4] = 300002;            // Ragazza plains 2 (Floof Pirate)
    global.ap_book_id_to_loc[5] = 10300001;          // Sky Fortress 1 (Floof Aviator)
    global.ap_book_id_to_loc[6] = 40300003;          // Oil Platform 3 (Floof Bomber)
    global.ap_book_id_to_loc[7] = 40300002;          // Oil Platform 2 (Pirate Swordsman)
    global.ap_book_id_to_loc[8] = 70300002;          // Windy Way 2 (Pirate Marksman)
    global.ap_book_id_to_loc[9] = 10300003;          // Sky Fortress 3 (Pirate Cannoneer)
    global.ap_book_id_to_loc[10] = 80300002;         // Brine Cave 2 (Pirate Demolitions)
    global.ap_book_id_to_loc[11] = 20300001;         // Mt. Afrokupa 1 (Pirate Explorer)
    global.ap_book_id_to_loc[12] = 100300001;        // The Black Widow 1 (Pirate Samurai)
    global.ap_book_id_to_loc[13] = 90300001;         // Ragazza Town 1 (Scuttlebit)
    global.ap_book_id_to_loc[14] = 30300001;         // Pumpkin Valley 1 (Zambot)
    global.ap_book_id_to_loc[15] = 30300002;         // Pumpkin Valley 2 (Seedle)
    global.ap_book_id_to_loc[16] = 20300002;         // Mt. Afrokupa 2 (Misboro)
    global.ap_book_id_to_loc[17] = 60300001;         // Icy Path 1 (Skallo)
    global.ap_book_id_to_loc[18] = 70300001;         // Windy Way 1 (Kiran)
    global.ap_book_id_to_loc[19] = 20300003;         // Mt. Afrokupa 3 (Little Oni)
    global.ap_book_id_to_loc[20] = 80300001;         // Brine Cave 1 (Squidge)
    global.ap_book_id_to_loc[21] = 40300004;         // Oil Platform 4 (Tamole)
    global.ap_book_id_to_loc[22] = 50300001;         // Tower of Power 1 (Spaîctre Die)
    global.ap_book_id_to_loc[23] = 100300002;        // The Black Widow 2 (Weekday Witches)
    global.ap_book_id_to_loc[24] = 60300002;         // Icy Path 2 (Chibeara)
    global.ap_book_id_to_loc[25] = 300001;           // Ragazza plains 1 (Serpantina)
    global.ap_book_id_to_loc[26] = 10300004;         // Sky Fortress 4 (Amelia)
    global.ap_book_id_to_loc[27] = 20300004;         // Mt. Afrokupa 4 (Anchovy)
    global.ap_book_id_to_loc[28] = 30300003;         // Pumpkin Valley 3 (Mimi the Mimic)
    global.ap_book_id_to_loc[29] = 40300001;         // Oil Platform 1 (Pacifica Oceana)
    global.ap_book_id_to_loc[30] = 110300001;        // Mechanical Mayhem 1 (DJ Doroko)
    global.ap_book_id_to_loc[31] = 120300001;        // The Spiders Web 1 (The Pirate Captain)
    global.ap_book_id_to_loc[32] = 130300002;        // The Fairies Domain 2 (The Fairy Queen)
    global.ap_book_id_to_loc[33] = 130300001;        // The Fairies Domain 1 (Gourmet Gal)
    global.ap_book_id_to_loc[34] = 160300003;        // ??? 1 (Mouthface)
    global.ap_book_id_to_loc[35] = 90300002;         // Ragazza Town 2 (Nyazione)
    global.ap_book_id_to_loc[36] = 140300001;        // Chelshia's House 1 (Muffey)
    global.ap_book_id_to_loc[37] = 50300002;         // Tower of Power 2 (Estylia)
}

if (book_id < 0 || book_id > 38) return undefined;

return global.ap_book_id_to_loc[book_id]