// Create a save from locations and game data, also initializes data entries.
ap_misc_log("Restoring state data...");
// Initializing game state globals.
global.level_complete[17] = 0;          // *
global.level_noDeath[17] = 0;           // *
global.level_noHit[17] = 0;             // *
global.level_berserk[17] = 0;           // *
global.level_rank[17] = 0;              // *
global.level_topMoney[17] = 0;          // *
global.level_topTime[17] = -1;          // *
global.level_food[17] = 0;              // *
global.level_rockPile[17] = 0;          // *
global.level_fairy[17, 3] = 0;          // *
global.trigger[16] = 0;                 // *
global.wep_obtained[10] = 0;            // *
global.wep_active[10] = 0;              // *
global.nme_obtained[38] = 0;            // * 
global.nme_new[38] = 0;                 // * Won't be used, all entries will be marked as "read" by default
global.costume_obtained[6] = 0;         // * 
global.costume_index = 0;               // * 
global.stat_treasure = 0;               // *
global.stat_enemies = 0;                // *
global.stat_levels = 0;                 // *
global.stat_food = 0;                   // *
global.stat_deaths = 0;                  // *

// Initializing game state diff globals. (used for inspection)
global._level_complete[17] = 0;          // *
global._level_noDeath[17] = 0;           // *
global._level_noHit[17] = 0;             // *
global._level_berserk[17] = 0;           // *
global._level_rank[17] = 0;              // *
global._level_topMoney[17] = 0;          // *
global._level_topTime[17] = 0;           // *
global._level_food[17] = 0;              // *
global._level_rockPile[17] = 0;          // *
global._level_fairy[17, 3] = 0;          // *
global._trigger[16] = 0;                 // *
global._wep_obtained[10] = 0;            // *
global._wep_active[10] = 0;              // *
global._nme_obtained[38] = 0;            // * 
// global._nme_new[38] = 0;              // * Won't be used, all entries will be marked as "read" by default
global._costume_obtained[6] = 0;         // * 
global._costume_index = 0;               // * 
global._stat_treasure = 0;               // *
global._stat_enemies = 0;                // *
global._stat_levels = 0;                 // *
global._stat_food = 0;                   // *
global._stat_deaths = 0;                  // *

global.ap_data_disable_update_signals = 1; // Disable data update signals to client, used to construct the default data state.

var i, j;
// ############################## LOCATIONS ##############################
// Clear 
var no_death_list = ap_data_get("level_noDeath");
var no_hit_list = ap_data_get("level_noHit");
var berserk_list = ap_data_get("level_berserk");
var rank_list = ap_data_get("level_rank");
var top_money_list = ap_data_get("level_topMoney");
var top_time_list = ap_data_get("level_topTime");
if (is_undefined(no_death_list)) {
    no_death_list = ds_list_create();
    for (i = 0; i <= 17; i++) ds_list_add(no_death_list, 0);
    ap_data_update_list("level_noDeath", no_death_list);
    no_death_list = ap_data_get("level_noDeath");
}
if (is_undefined(no_hit_list)) {
    no_hit_list = ds_list_create();
    for (i = 0; i <= 17; i++) ds_list_add(no_hit_list, 0);
    ap_data_update_list("level_noHit", no_hit_list);
    no_hit_list = ap_data_get("level_noHit");
}
if (is_undefined(berserk_list)) {
    berserk_list = ds_list_create();
    for (i = 0; i <= 17; i++) ds_list_add(berserk_list, 0);
    ap_data_update_list("level_berserk", berserk_list);
    berserk_list = ap_data_get("level_berserk");
}
if (is_undefined(rank_list)) {
    rank_list = ds_list_create();
    for (i = 0; i <= 17; i++) ds_list_add(rank_list, 0);
    ap_data_update_list("level_rank", rank_list);
    rank_list = ap_data_get("level_rank");
}
if (is_undefined(top_money_list)) {
    top_money_list = ds_list_create();
    for (i = 0; i <= 17; i++) ds_list_add(top_money_list, 0);
    ap_data_update_list("level_topMoney", top_money_list);
    top_money_list = ap_data_get("level_topMoney");
}
if (is_undefined(top_time_list)) {
    top_time_list = ds_list_create();
    for (i = 0; i <= 17; i++) ds_list_add(top_time_list, -1);
    ap_data_update_list("level_topTime", top_time_list);
    top_time_list = ap_data_get("level_topTime");
}
for (i = 0; i <= 17; i++) {
    // Stage clear?
    var stage_location = i * 10000000 + 100001;
    var is_clear = ap_location_get(stage_location); // Some of the iterated locations do not exist. This is fine, it will simply return 0 (false).
    global.level_complete[i] = is_clear;
    global._level_complete[i] = is_clear
    if (is_clear) {
        // No Death?
        global.level_noDeath[i] = ds_list_find_value(no_death_list, i);
        global._level_noDeath[i] = ds_list_find_value(no_death_list, i);
        
        // No Hit?
        global.level_noHit[i] = ds_list_find_value(no_hit_list, i);
        global._level_noHit[i] = ds_list_find_value(no_hit_list, i);
            
        // Berserker?
        global.level_berserk[i] = ds_list_find_value(berserk_list, i);
        global._level_berserk[i] = ds_list_find_value(berserk_list, i);
            
        // Rank
        global.level_rank[i] = ds_list_find_value(rank_list, i);
        global._level_rank[i] = ds_list_find_value(rank_list, i);

        // Top Money
        global.level_topMoney[i] = ds_list_find_value(top_money_list, i);
        global._level_topMoney[i] = ds_list_find_value(top_money_list, i);
        
        // Top Time
        global.level_topTime[i] = ds_list_find_value(top_time_list, i);
        global._level_topTime[i] = ds_list_find_value(top_time_list, i);
        
    }
}
if (!is_undefined(no_death_list)) ds_list_destroy(no_death_list);
if (!is_undefined(no_hit_list)) ds_list_destroy(no_hit_list);
if (!is_undefined(berserk_list)) ds_list_destroy(berserk_list);
if (!is_undefined(rank_list)) ds_list_destroy(rank_list);
if (!is_undefined(top_money_list)) ds_list_destroy(top_money_list);
if (!is_undefined(top_time_list)) ds_list_destroy(top_time_list);

// Fairies 
var fairy_map = ap_data_get("fairies");
if (!ap_option_get("shuffle_fairies") && is_undefined(fairy_map)) {
    fairy_map = ds_map_create(); // No need to initialize values, we check by existence of key.
    ap_data_update_map("fairies", fairy_map);
    fairy_map = ap_data_get("fairies");
}
for (i = 0; i <= 17; i++) {
    for (j = 1; j <= global.level_hasFairies[i]; j++) {
        var fairy_location = 
            i * 10000000 +  // Stage 
            200000 +        // Fairy
            j;              // Identifier
        var has_fairy;
        if (ap_option_get("shuffle_fairies")) has_fairy = ap_location_get(fairy_location);
        else has_fairy = ds_map_exists(fairy_map, fairy_location);
        
        global.level_fairy[i, j] = has_fairy;
        global._level_fairy[i, j] = has_fairy;
    }
}
if (!is_undefined(fairy_map)) ds_map_destroy(fairy_map);

// Books 
var book_map = ap_data_get("books");
if (!ap_option_get("shuffle_books") && is_undefined(book_map)) {
    book_map = ds_map_create();
    ap_data_update_map("books", book_map);
    book_map = ap_data_get("books");
}
for (i = 1; i <= 38; i++) {
    var book_location = ap_misc_book_id_to_loc(i);
    var has_book;
    if (ap_option_get("shuffle_books")) has_book = ap_location_get(book_location);
    else has_book = ds_map_exists(book_map, book_location);
    
    global.nme_obtained[i] = has_book;
    global._nme_obtained[i] = has_book;
    // global.nme_new[i] = 0;  // Always 0 for the purposes of the mod, we don't need to store or restore this information.
    // global._nme_new[i] = 0;
}

if (!is_undefined(book_map)) ds_map_destroy(book_map);

// Detonators
var detonator_map = ap_data_get("detonators");
if (!ap_option_get("shuffle_detonators") && is_undefined(detonator_map)) {
    detonator_map = ds_map_create();
    ap_data_update_map("detonators", detonator_map);
    detonator_map = ap_data_get("detonators");
}
for (i = 1; i <= 4; i++) {
    var detonator_location =    
        i * 10000000 +  // Stage 
        500001;         // Detonator
    var has_detonator;
    if (ap_option_get("shuffle_detonators")) has_detonator = ap_location_get(detonator_location);
    else if (!is_undefined(detonator_map)) has_detonator = ds_map_exists(detonator_map, detonator_location);
    else has_detonator = 0;
    
    global.level_rockPile[i] = has_detonator;
    global._level_rockPile[i] = has_detonator;
}

if (!is_undefined(detonator_map)) ds_map_destroy(detonator_map);

// Gourmet Gal
var ggal_map = ap_data_get("gourmet_gal");
if (!ap_option_get("shuffle_gourmet_gal") && is_undefined(ggal_map)) {
    ggal_map = ds_map_create();
    ap_data_update_map("gourmet_gal", ggal_map);
    ggal_map = ap_data_get("gourmet_gal");
}
for (i = 1; i <= 4; i++) {
    var ggal_location =    
        i * 10000000 +  // Stage 
        600001;         // Gourmet Gal
    var has_ggal;
    if (ap_option_get("shuffle_gourmet_gal")) has_ggal = ap_location_get(ggal_location);
    else if (!is_undefined(ggal_map)) has_ggal = ds_map_exists(ggal_map, ggal_location);
    else has_ggal = 0;
    
    global.level_food[i] = has_ggal;
    global._level_food[i] = has_ggal;
}

if (!is_undefined(ggal_map)) ds_map_destroy(ggal_map);

// Costumes
var costume_list = ap_data_get("costumes");
if (is_undefined(costume_list)) {
    costume_list = ds_list_create();
    for (i = 0; i <= 4; i++) ds_list_add(costume_list, 0);
    ap_data_update_list("costumes", costume_list);
    costume_list = ap_data_get("costumes");
}
for (i = 1; i <= 4; i++) { // We won't store anything related to the DLC costume. Those who own it will have it and those who don't won't.
    global.costume_obtained[i] = ds_list_find_value(costume_list, i);
    global._costume_obtained[i] = ds_list_find_value(costume_list, i);
}
global.costume_index = ds_list_find_value(costume_list, 0);
global._costume_index = ds_list_find_value(costume_list, 0);
if (!is_undefined(costume_list)) ds_list_destroy(costume_list);
 

// Triggers
var trigger_list = ap_data_get("triggers");
if (is_undefined(trigger_list)) {
    trigger_list = ds_list_create();
    for (i = 0; i <= 16; i++) ds_list_add(trigger_list, 0);
    ap_data_update_list("triggers", trigger_list);
    trigger_list = ap_data_get("triggers");
}

for (i = 0; i <= 16; i++) {
    global.trigger[i] = ds_list_find_value(trigger_list, i);
    global._trigger[i] = ds_list_find_value(trigger_list, i);
    /*
        Trigger 4, 5, and 6 are the 3 ship locks.
        These should be enabled once the gates are implemented in future versions.
    */
}
if (!is_undefined(trigger_list)) ds_list_destroy(trigger_list);

// Stats
var stat_list = ap_data_get("stats");
if (is_undefined(stat_list)) {
    stat_list = ds_list_create();
    for (i = 0; i <= 4; i++) ds_list_add(stat_list, 0);
    ap_data_update_list("stats", stat_list);
    stat_list = ap_data_get("stats");
}
if (!is_undefined(stat_list)) {
    global.stat_treasure = ds_list_find_value(stat_list, 0);
    global._stat_treasure = ds_list_find_value(stat_list, 0);
    global.stat_enemies = ds_list_find_value(stat_list, 1);
    global._stat_enemies = ds_list_find_value(stat_list, 1);
    global.stat_levels = ds_list_find_value(stat_list, 2);
    global._stat_levels = ds_list_find_value(stat_list, 2);
    global.stat_food = ds_list_find_value(stat_list, 3);
    global._stat_food = ds_list_find_value(stat_list, 3);
    global.stat_deaths = ds_list_find_value(stat_list, 4);
    global._stat_deaths = ds_list_find_value(stat_list, 4);
}
if (!is_undefined(stat_list)) ds_list_destroy(stat_list);

// Weapons
global.wep_obtained[1] = 1 // Golem fist, always available.
global._wep_obtained[1] = 1 
for (i = 1; i <= 8; i++) { // All stage upgrades.
    var weapon_location =   
        i * 10000000 +  // Stage
        100002;         // Upgrade
    // No undefined checks, if this explodes it means I messed up and I need to know.
    var weapon_id = ap_misc_weapon_loc_to_id(weapon_location);    
    
    global.wep_obtained[weapon_id] = ap_location_get(weapon_location);
    global._wep_obtained[weapon_id] = ap_location_get(weapon_location);
}

var lucky_doll = ap_data_get("lucky_doll");
if (is_undefined(lucky_doll)) {
    ap_data_update("lucky_doll", 0);
    global.wep_obtained[10] = 0;
    global._wep_obtained[10] = 0;
} else {
    global.wep_obtained[10] = lucky_doll;
    global._wep_obtained[10] = lucky_doll;
}

// Active Weapons
var active_weapons = ap_data_get("weapon_active");
if (is_undefined(active_weapons)) {
    active_weapons = ds_list_create();
    for (i = 0; i <= 10; i++) ds_list_add(active_weapons, 0);
    ap_data_update_list("weapon_active", active_weapons);
    active_weapons = ap_data_get("weapon_active");
}
for (i = 1; i <= 10; i++) {
    global.wep_active[i] = ds_list_find_value(active_weapons, i);
    global._wep_active[i] = ds_list_find_value(active_weapons, i);
}
if (!is_undefined(active_weapons)) ds_list_destroy(active_weapons);

global.ap_data_disable_update_signals = 0; // Re-enable data updates to client.
global.ap_state_initialized = 1;
ap_misc_log("Successfully restored state data.");