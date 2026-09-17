// Start communication loops
writer_tick = 6;
observer_tick = 5;
max_incomming_tasks_per_step = 50;
max_outgoing_tasks_per_tick = 100;

cctx_read_cooldown = 0;
li_read_cooldown = 0;

alarm[1] = 1; // Read first
alarm[2] = 2; // Then write