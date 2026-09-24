// Communication loops
writer_tick = 6;
observer_tick = 5;
max_incomming_tasks_per_step = 50;
max_outgoing_tasks_per_tick = 100;

cctx_read_cooldown = 0;
li_read_cooldown = 0;

alarm[0] = 1; // Read first
alarm[1] = 2; // Then write

local_last_ack = 0;

// Archipelago GUI
// Connection Status
connection_status_background_color = make_color_rgb(0, 0, 0);
connection_status_background_alpha = 0.5;
connection_status_text_color[0] = make_color_rgb(146, 211, 149);
connection_status_text_color[1] = make_color_rgb(213, 201, 39);
connection_status_text_color[2] = make_color_rgb(243, 42, 30);
connection_status_text_alpha = 1;
connection_status_fade = 1;
connection_status_fade_time = 30;
connection_status_text[0] = "CONNECTED!";
connection_status_text[1] = "DISCONNECTED FROM HOST";
connection_status_text[2] = "DISCONNECTED FROM CLIENT";
connection_status_hide_counter = -1;
connection_status_counter_refill = 90;