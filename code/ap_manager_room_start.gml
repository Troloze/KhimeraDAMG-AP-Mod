event_perform(ev_other, ev_user1) // Inspects state (room transitions will skip end step, so we run it here to avoid a dropped scan)

// Clean enemy trackers
ds_map_clear(global.ap_enemy_tracker);
ds_map_clear(trap_entities);