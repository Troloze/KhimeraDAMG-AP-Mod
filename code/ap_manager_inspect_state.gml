if (!global.ap_state_initialized) return;
var i, j;


var robin_max = 4;  // cycles from 0 to robin_max (inclusive)

if (inspector_round_robin++ >= robin_max) inspector_round_robin = 0;

if (inspector_round_robin == 0) {
    // Stage information 
    for (i = 0; i <= 17; i++) {
        if (i == 9 || i == 13 || i == 14 || i == 15 || i == 16 || i == 17) continue;
        // Clear
        if (global.level_complete[i] != global._level_complete[i]) {
            var clear_location = i * 10000000 + 100001;
            if (!ap_location_get(clear_location)) ds_map_replace(global.ap_local_locations, clear_location, 1); // Send the location.
            
            global._level_complete[i] = global.level_complete[i];
            with (obj_pause) issue_update = 1; // Update pause stats.
        }
        
        // No Death
        if (global.level_noDeath[i] != global._level_noDeath[i]) {
            var no_death_list = ap_data_get("level_noDeath");
            ds_list_replace(no_death_list, i, global.level_noDeath[i]);
            ap_data_update_list("level_noDeath", no_death_list);
    
            global._level_noDeath[i] = global.level_noDeath[i];
            with (obj_pause) issue_update = 1; // Update pause stats.
        }
        
        // No Hit
        if (global.level_noHit[i] != global._level_noHit[i]){
            var no_hit_list = ap_data_get("level_noHit");
            ds_list_replace(no_hit_list, i, global.level_noHit[i]);
            ap_data_update_list("level_noHit", no_hit_list);
    
            global._level_noHit[i] = global.level_noHit[i];
        }
        
        // Berserk
        if (global.level_berserk[i] != global._level_berserk[i]){
            var berserk_list = ap_data_get("level_berserk");
            ds_list_replace(berserk_list, i, global.level_berserk[i]);
            ap_data_update_list("level_berserk", berserk_list);
    
            global._level_berserk[i] = global.level_berserk[i];
            with (obj_pause) issue_update = 1; // Update pause stats.
        }
        
        // Rank
        if (global.level_rank[i] != global._level_rank[i]){
            var rank_list = ap_data_get("level_rank");
            ds_list_replace(rank_list, i, global.level_rank[i]);
            ap_data_update_list("level_rank", rank_list);
            
            global._level_rank[i] = global.level_rank[i];
            with (obj_pause) issue_update = 1; // Update pause stats.
        }
        
        // Top Money
        if (global.level_topMoney[i] != global._level_topMoney[i]){
            var top_money_list = ap_data_get("level_topMoney");
            ds_list_replace(top_money_list, i, global.level_topMoney[i]);
            ap_data_update_list("level_topMoney", top_money_list);
            
            global._level_topMoney[i] = global.level_topMoney[i];
        }
    
        // Top Time
        if (global.level_topTime[i] != global._level_topTime[i]){
            var top_time_list = ap_data_get("level_topTime");
            ds_list_replace(top_time_list, i, global.level_topTime[i]);
            ap_data_update_list("level_topTime", top_time_list);
            
            global._level_topTime[i] = global.level_topTime[i];
        }
    }
}


if (inspector_round_robin == 1) {
    // Fairies
    var fairies_map = undefined;
    for (i = 0; i <= 17; i++) {
        for (j = 1; j <= global.level_hasFairies[i]; j++) {
            
            if (global.level_fairy[i, j] != global._level_fairy[i, j]) {
                var fairy_location = 
                    i * 10000000 +  // Stage 
                    200000 +        // Fairy
                    j;              // Identifier
                if (ap_option_get("shuffle_fairies")) {
                    if (!ap_location_get(fairy_location)) ds_map_replace(global.ap_local_locations, fairy_location, 1); // Send the location.
                } else {
                    if (is_undefined(fairies_map)) fairies_map = ap_data_get("fairies");
                    ds_map_replace(fairies_map, fairy_location, global.level_fairy[i, j]); // Store in data
                }
                global._level_fairy[i, j] = global.level_fairy[i, j];
            }
        }
    }
    if (!is_undefined(fairies_map)) ap_data_update_map("fairies", fairies_map);
    
    if (ap_option_get("shuffle_fairies")) {
        var f_count = scr_getFairiesRescued();
        if (f_count != global.ap_item_total_fairies) {
            global.ap_item_total_fairies = f_count;
            with (obj_pause) issue_update = 1; // Update pause stats.
        }
    }
    // Books
    var books_map = undefined;
    for (i = 1; i <= 38; i++) {
        // Location
        if (global.nme_obtained[i] != global._nme_obtained[i]) {
            var book_location = ap_misc_book_id_to_loc(i);
            if (ap_option_get("shuffle_books")) {
                if (!ap_location_get(book_location)) ds_map_replace(global.ap_local_locations, book_location, 1); // Send the location.
            } else {
                if (is_undefined(books_map)) books_map = ap_data_get("books");
                ds_map_replace(books_map, book_location, global.nme_obtained[i]); // Store in data
                global.ap_item_nme_obtained[i] = global.nme_obtained[i]; // Update item state.
                with (obj_pause) issue_update = 1; // Update pause stats.
            } 
            global._nme_obtained[i] = global.nme_obtained[i];
        }
        // Item
        var book_item = ap_misc_book_id_to_item(i);
        if (ap_item_get(book_item) && !global.ap_item_nme_obtained[i]) {
            global.ap_item_nme_obtained[i] = 1;
            with (obj_pause) issue_update = 1; // Update pause stats.
        }
    }
    
    if (!is_undefined(books_map)) ap_data_update_map("books", books_map);
}

if (inspector_round_robin == 2) {
    // Detonators
    var detonators_map = undefined;
    for (i = 1; i <= 4; i++) {
        // Location
        if (global.level_rockPile[i] != global._level_rockPile[i]) {
            var detonator_location =    
                i * 10000000 +  // Stage 
                500001;         // Identifier
            if (ap_option_get("shuffle_detonators")) {
                if (!ap_location_get(detonator_location)) ds_map_replace(global.ap_local_locations, detonator_location, 1); // Send the location.
            } else {
                if (is_undefined(detonators_map)) detonators_map = ap_data_get("detonators");
                ds_map_replace(detonators_map, detonator_location, global.level_rockPile[i]); // Store in data
                global.ap_item_level_rockPile[i] = global.level_rockPile[i]; // Update item state.
                with (obj_pause) issue_update = 1; // Update pause stats.
            } 
            global._level_rockPile[i] = global.level_rockPile[i];
        }
        // Item
        var detonator_item = 500500000 + i;
        if (ap_item_get(detonator_item) && !global.ap_item_level_rockPile[i]) {
            global.ap_item_level_rockPile[i] = 1;
            with (obj_pause) issue_update = 1; // Update pause stats.
        }
    }
    if (!is_undefined(detonators_map)) ap_data_update_map("detonators", detonators_map);
    
    // Gourmet Gal
    var ggal_map = undefined;
    var food_count = 0;
    var just_fed = 0;
    for (i = 1; i <= 4; i++) {
        // Location
        if (global.level_food[i] != global._level_food[i]) {
            var ggal_location =    
                i * 10000000 +  // Stage 
                600001;         // Identifier
            if (ap_option_get("shuffle_gourmet_gal")) {
                if (!ap_location_get(ggal_location)) ds_map_replace(global.ap_local_locations, ggal_location, 1); // Send the location.
            } else {
                if (is_undefined(ggal_map)) ggal_map = ap_data_get("gourmet_gal");
                ds_map_replace(ggal_map, ggal_location, global.level_food[i]); // Store in data
                global.ap_item_level_food[i] = global.level_food[i]; // Update item state.
                with (obj_pause) issue_update = 1; // Update pause stats.
            } 
            
            // Handle the maxHP increase.
            if (!ap_option_get("shuffle_gourmet_gal") and global.level_food[i]) just_fed = 1;
            
            
            global._level_food[i] = global.level_food[i];
        }
        // Item
        var ggal_item = 500600000 + i;
        if (ap_item_get(ggal_item) && !global.ap_item_level_food[i]) {
            global.ap_item_level_food[i] = 1;
            with (obj_pause) issue_update = 1; // Update pause stats.
            // Handle the maxHP increase
            just_fed = 1;
        }
        
        // HP tracking
        if (global.ap_item_level_food[i]) {
            food_count++;
        }
    }
    
    global.maxHP = 8 + 2 * food_count; // Makes sure we don't account for something twice by accident.
    if (just_fed) global.HP += 2;
    
    if (!is_undefined(ggal_map)) ap_data_update_map("gourmet_gal", ggal_map);
}

if (inspector_round_robin == 3) {
    // Costumes
    var costume_list = undefined;
    for (i = 1; i <= 4; i++) { // We don't touch the DLC costumes.
        if (global.costume_obtained[i] != global._costume_obtained[i]) {
            if (is_undefined(costume_list)) costume_list = ap_data_get("costumes");
            ds_list_replace(costume_list, i, global.costume_obtained[i]);
            global._costume_obtained[i] = global.costume_obtained[i];
        }
    }
    
    if (global.costume_index != global._costume_index) {
        if (is_undefined(costume_list)) costume_list = ap_data_get("costumes");
        ds_list_replace(costume_list, 0, global.costume_index);
        global._costume_index = global.costume_index;
    }
    
    if (!is_undefined(costume_list)) ap_data_update_list("costumes", costume_list);
    // Trigger
    if (!global.trigger[4] && scr_mainBeaten() >= 4) {
        with (obj_map_shipLock1)
            alarm[0] = 1;
        global.trigger[4] = 1;
    }
    
    if (!global.trigger[5] && global.level_complete[10]) {
        with (obj_map_shipLock2)
            alarm[0] = 1;
        global.trigger[5] = 1;
    }
    
    if (!global.trigger[6] && global.level_complete[11]) {
        with (obj_map_shipLock3)
            alarm[0] = 1;
        global.trigger[6] = 1;
    }
    
    var trigger_list = undefined;
    for (i = 0; i <= 16; i++) {
        if (global.trigger[i] != global._trigger[i]) {
            if (is_undefined(trigger_list)) trigger_list = ap_data_get("triggers");
            ds_list_replace(trigger_list, i, global.trigger[i]);
            global._trigger[i] = global.trigger[i];
        }
    }   
    if (!is_undefined(trigger_list)) ap_data_update_list("triggers", trigger_list);
    
    
    
    // Stats
    var stat_list = undefined;
    if (global.stat_treasure != global._stat_treasure) {
        if (is_undefined(stat_list)) stat_list = ap_data_get("stats");
        ds_list_replace(stat_list, 0, global.stat_treasure);
        global._stat_treasure = global.stat_treasure;
    }
    if (global.stat_enemies != global._stat_enemies) {
        if (is_undefined(stat_list)) stat_list = ap_data_get("stats");
        ds_list_replace(stat_list, 1, global.stat_enemies);
        global._stat_enemies = global.stat_enemies;
    }
    if (global.stat_levels != global._stat_levels) {
        if (is_undefined(stat_list)) stat_list = ap_data_get("stats");
        ds_list_replace(stat_list, 2, global.stat_levels);
        global._stat_levels = global.stat_levels;
    }
    if (global.stat_food != global._stat_food) {
        if (is_undefined(stat_list)) stat_list = ap_data_get("stats");
        ds_list_replace(stat_list, 3, global.stat_food);
        global._stat_food = global.stat_food;
    }
    if (global.stat_deaths != global._stat_deaths) {
        if (is_undefined(stat_list)) stat_list = ap_data_get("stats");
        ds_list_replace(stat_list, 4, global.stat_deaths);
        global._stat_deaths = global.stat_deaths;
    }
    if (!is_undefined(stat_list)) ap_data_update_list("stats", stat_list);
}

if (inspector_round_robin == 4) {
    // Weapons
    var weapon_list = undefined;
    for (i = 1; i <= 10; i++) {
        // Location
        if (i != 1 && global.wep_obtained[i] != global._wep_obtained[i]) {
            if (i == 10) {
                // Lucky Chax Doll
                ap_data_update("lucky_doll", global.wep_obtained[i]);
                global.ap_item_wep_obtained[i] = global.wep_obtained[i];
                global.wep_active[i] = 1;
                
            } else {
                // Location
                var weapon_location = ap_misc_weapon_id_to_loc(i);
                if (!ap_location_get(weapon_location)) ds_map_replace(global.ap_local_locations, weapon_location, 1); // Send the location.
                
            }
            global._wep_obtained[i] = global.wep_obtained[i];
            with (obj_pause) issue_update = 1; // Update pause stats.
        }
    
        // Item
        if ((i != 1) && (i != 10)) {
            var weapon_item = ap_misc_weapon_id_to_item(i);
            if (ap_item_get(weapon_item) && !global.ap_item_wep_obtained[i]) {
                global.ap_item_wep_obtained[i] = 1;
                global.wep_active[i] = 1;
                with (obj_pause) issue_update = 1; // Update pause stats.
            }
        }
        // Active weapon tracking
        if (global.wep_active[i] != global._wep_active[i]) {
            if (is_undefined(weapon_list)) weapon_list = ap_data_get("weapon_active");
            ds_list_replace(weapon_list, i, global.wep_active[i]);
            global._wep_active[i] = global.wep_active[i];
        }
    }
    if (!is_undefined(weapon_list)) ap_data_update_list("weapon_active", weapon_list);
    
    // Win condition
    switch(ap_option_get("victory_condition")) {
        case 0: // The Spiders Web Clear.
            if (global.level_complete[12]) global.ap_is_win = 1;
            break;
    }
}



