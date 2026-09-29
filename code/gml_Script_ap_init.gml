// ##### Moving this from the title create in order to get the nurse DLC #####
scr_steamCheck();

if (global.game_version == 0)
{
    if (steam_initialised()){
        global.DLCnurse = steam_user_owns_dlc(485280);
    }
}
else if (global.game_version == 1)
{
    global.DLCnurse = 1;
}

// ##### Archipelago Randomizer Globals #####
// Constants
global.ap_startup_time_stamp = ap_misc_generate_time_stamp(true);
global.ap_mod_version = "v0.1.0";
global.AP_DEBUG = ap_is_debug();
if (global.AP_DEBUG) ap_misc_log("DEBUG MODE ACTIVATED");
global.ap_max_heartbeat_delta = 2.0;

global.AP_ID_ITEM = 500000000;
global.AP_ID_STAGE = 10000000;
global.AP_ID_TYPE = 100000;

global.AP_LOC_GENERAL = 0;
global.AP_LOC_CLEAR = 1;
global.AP_LOC_FAIRY = 2;
global.AP_LOC_BOOK = 3;
global.AP_LOC_CANDY = 4;
global.AP_LOC_DETONATOR = 5;
global.AP_LOC_GOURMET_GAL = 6;
global.AP_LOC_MINIBOSS = 7;


global.AP_ITEM_WEAPON = 0;
global.AP_ITEM_STAGE = 1;
global.AP_ITEM_FAIRY = 2;
global.AP_ITEM_BOOK = 3;
global.AP_ITEM_CANDY = 4;
global.AP_ITEM_DETONATOR = 5;
global.AP_ITEM_GOURMET_GAL = 6;
global.AP_ITEM_COSTUME = 7;
global.AP_ITEM_TRAP = 8;
global.AP_ITEM_FILLER = 9;

global.AP_FAIRY_ID = ap_item_make(global.AP_ITEM_FAIRY, 1);

// Connection constants
global.ap_has_cctx = 0;
global.ap_version = undefined;
global.ap_slot_name = undefined;
global.ap_seed = undefined;

global.ap_options = undefined;
global.ap_options_default = undefined;

global.ap_gen_info = undefined;
global.ap_gen_info_default = undefined;

global.ap_has_li = 0;
global.ap_li_enabled = 0;
global.ap_location_information = undefined;

global.ap_is_win = 0; // Not really a constant, since the game will set this on victory, but it shall stay here regardless.

// Game Data.
global.ap_data = ds_map_create(); 

global.ap_data_changes_counter = 0;
global.ap_data_changes_a = ds_map_create();
global.ap_data_changes_b = ds_map_create();

// Helper structures
global.ap_book_loc_to_id = undefined;
global.ap_book_id_to_loc = undefined;

global.ap_weapon_loc_to_id = undefined;
global.ap_weapon_id_to_loc = undefined;
global.ap_weapon_id_to_item = undefined;

// Variables
global.ap_client_connected = 0;
global.ap_fully_connected = 0;

global.ap_last_client_heartbeat = -1;
global.ap_last_client_heartbeat_time = 0;

global.ap_game_heartbeat = 0;

global.ap_last_death_link = 0;
global.ap_last_death_link_message = undefined;
global.ap_last_death_link_ack = 0;

global.ap_last_ack = 0;

global.ap_data_disable_update_signals = 0;

global.ap_state_initialized = 0;

// Pipeline structures
global.ap_incomming_tasks = ds_queue_create();
global.ap_outgoing_tasks = ds_queue_create();

// Inner State structures
global.ap_item_map = ds_map_create();           
global.ap_local_locations = ds_map_create();    // This is for communication handling only.
global.ap_acked_locations = ds_map_create();    // Game elements should check for this to see if a location was checked or not.

global.ap_enemy_id = 0;
global.ap_enemy_tracker = ds_map_create();

global.ap_splash_queue = ds_queue_create();

// Cleanup leftover files
ap_misc_cleanup();

// Create communication handler
ap_misc_log("Starting the communication handler.");
instance_create(0, 0, ap_manager);