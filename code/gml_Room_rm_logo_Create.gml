global.current_version = "4.3";
global.game_version = 0;
init_musiclist();
instance_create(0, 0, obj_inputcontrol);
instance_create(0, 0, obj_roomTransitionCont);
instance_create(0, 0, obj_soundEngine);
instance_create(0, 0, obj_upsideDownMachine);
init_languages();
ini_open("chimera.dat");
global.gameLanguage = 0;
global.v_snd = scr_range(real(ini_read_string("settings", "snd", "10")), 0, 10);
global.v_bgm = scr_range(real(ini_read_string("settings", "bgm", "8")), 0, 10);
global.screenset = scr_range(real(ini_read_string("settings", "screenset", "3")), 1, 4);
global.dashType = scr_range(real(ini_read_string("settings", "dashType", "1")), 1, 3);
global.gorgonOn = scr_IO(real(ini_read_string("settings", "gorgonOn", "1")));
global.timerOn = scr_IO(real(ini_read_string("settings", "timerOn", "0")));
global.hideCursor = scr_IO(real(ini_read_string("settings", "hideCursor", "0")));
global.fontType = scr_IO(real(ini_read_string("settings", "fontType", "0")));
global.showPercent = scr_IO(real(ini_read_string("settings", "showPercent", "0")));
global.berserkUnlocked = 0;
global.halloweenUnlocked = 1; // Not accessible, but enabled to avoid showing the unlock text to the user.
global.halloweenComplete = 0;
global.raceCostume = 0;
ini_close();

if (global.hideCursor)
    window_set_cursor(cr_none);
else
    window_set_cursor(cr_default);

scr_setScreen(global.screenset);

if (global.gameLanguage == -1)
    global.gameLanguage = scr_steamLang();

init_levels();
init_weapons();
init_triggers();
init_achievements();
init_enemyLog();
init_costumes();
// scr_loadHarvestLore();
show_score = 0;
show_lives = 0;
show_health = 0;
global.chrMap = "!" + '"' + "#$%&'()*+,-./0123456789:;<=>?ABCDEFGHIJKLMNOPQRSTUVWXYZ¡¿ÁÉÍÑÓÚÜ";
font_replace_sprite_ext(fnt_score, spr_fnt_score, global.chrMap, 1, 2);
font_replace_sprite(fnt_treasure, spr_fnt_treasure, 48, 1, 1);
font_replace_sprite_ext(fnt_NES, spr_fnt_NES, global.chrMap, 0, 0);
font_replace_sprite_ext(fnt_percent, spr_fnt_percent, "0123456789%", 1, 1);

if (!global.fontType)
    font_replace_sprite_ext(fnt_text, spr_fnt_text, global.chrMap, 1, 1);
else
    font_replace_sprite_ext(fnt_text, spr_fnt_oldtext, global.chrMap, 1, 1);

global.now_playing_index = -1;
global.game_mode = 0;
global.gamePercent = 0;
global.firstTitle = 1;
global.STEAM_OPEN = 0;
global.pausereturn = 0;
global.current_file = 1;
global.totalScreenshots = 0;
global.current_level = 9;
global.costume_index = 1;
global.total_candy = 0;
global.noDeath = 1;
global.noHit = 1;
global.killBonusCounter = 0;
global.checkpoint = 0;
global.silohetteMode = 0;
global.cutsceneIndex = 0;
global.justWon = 0;
global.playDialogue = 1;
global.harpyDialogue = 1;
global.pizzaDialogue = 1;
global.mimicDialogue = 1;
global.mermaidDialogue = 1;
global.capSecondPhase = 0;
global.bossGauntletNum = 0;
global.waterMode = 0;
global.money = 0;
global.checkTreasure = 0;
global.game_difficulty = 1;
global.assistMode = 0;
global.maxHP = 8;
global.HP = global.maxHP;
global.bossMaxHP = 20;
global.bossHP = 0;
global.progressDirection = 1;
global.timeFrames = 0;
global.DLCnurse = 0;
global.stat_treasure = 0;
global.stat_enemies = 0;
global.stat_levels = 0;
global.stat_food = 0;
global.stat_deaths = 0;
global.berserkRace = 0;
global.race_steps = 0;
global.race_seconds = 0;
global.race_minutes = 0;
global.race_hours = 0;

// ##### Archipelago Randomizer Globals #####
// Constants
global.AP_DEBUG = 0; // DEAR LORD, DO **NOT** SHIP A RELEASE WITH THIS TURNED ON.
global.ap_startup_time_stamp = ap_misc_generate_time_stamp(true);
global.ap_mod_version = "v0.0.9";
global.ap_max_heartbeat_delta = 2.0;

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

// Cleanup leftover files
ap_misc_cleanup();

// Create communication handler
ap_misc_log("Starting the communication handler.");
instance_create(0, 0, ap_manager);

