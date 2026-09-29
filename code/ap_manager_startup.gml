// Communication loops
writer_tick = 6;
observer_tick = 5;
max_incomming_tasks_per_step = 10; // To avoid stutters on large batches (like releases).
max_outgoing_tasks_per_tick = 10;

cctx_read_cooldown = 0;
li_read_cooldown = 0;


if (global.AP_DEBUG) {
    event_perform(ev_other, ev_user0); // Loads empty data. Disables the communication.
} else {
    alarm[0] = 1; // Read first
    alarm[1] = 2; // Then write
}

local_last_ack = 0;

// Death link shenanigans
map_death_link_action = 0;
map_death_link_chelshia_x = 0;
map_death_link_chelshia_y = 0;

// Inspection
inspector_round_robin = 0;

// Filler items.
dispenser_attempt_cooldown = 12;
dispenser_instance_cooldown_max_cycles = 10; 
instance_cooldown_tracker = 0;

filler_queue = ds_queue_create() // Non enemy-instantiating filler
filler_instance_queue = ds_queue_create() // Enemy-instantiating filler

trap_entities = ds_map_create();        // Used to track which traps should require more waiting.

alarm[2] = dispenser_attempt_cooldown;

// Archipelago GUI
// Text Messages
text_message_cap = 150;
text_current_messages = 0;
text_last_index = 0;
text_fields = 3;
message_field = 0;
time_field = 1;
type_field = 2;
text_log = ds_grid_create(text_fields, text_message_cap);
text_line_width = 200;
text_max_lines = 3;
text_length_hard_cap = 300;
text_line_sep = -1;
text_font = fnt_text;
text_color = make_color_rgb(255, 255, 255);
text_color_death_link = make_color_rgb(243, 113, 102);
text_alpha = 1.0;
text_bg_color =  make_color_rgb(6, 4, 12);
text_bg_alpha = 0.7;
text_timeout = 180;
text_timeout_fade = 30;
text_time = text_timeout + text_timeout_fade;
current_message = undefined;

text_full_display = 0;
text_partial_threshold = 50;

text_tab_required = 30;
text_tab_count = 0;

// Connection Status
connection_status_background_color = make_color_rgb(0, 0, 0);
connection_status_background_alpha = 0.5;
connection_status_text_color[0] = make_color_rgb(146, 211, 149);
connection_status_text_color[1] = make_color_rgb(232, 202, 53);
connection_status_text_color[2] = make_color_rgb(230, 57, 57);
connection_status_text_alpha = 1;
connection_status_fade = 1;
connection_status_fade_time = 30;
connection_status_text[0] = "CONNECTED!";
connection_status_text[1] = "DISCONNECTED FROM HOST";
connection_status_text[2] = "DISCONNECTED FROM CLIENT";
connection_status_hide_counter = 0;
connection_status_counter_refill = 90;


// Miscelaneous
chelshia_center_displacement_x = 0;
chelshia_center_displacement_y = 16;