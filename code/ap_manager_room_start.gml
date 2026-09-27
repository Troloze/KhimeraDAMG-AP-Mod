event_perform(ev_other, ev_user1) // Inspects state (room transitions will skip end step, so we run it here to avoid a dropped scan)

// Clean enemy trackers
var entry = ds_map_find_first(global.ap_enemy_tracker), old_entry;
while (!is_undefined(entry)) {
    old_entry = entry;
    entry = ds_map_find_next(global.ap_enemy_tracker, old_entry);
    ds_map_delete(global.ap_enemy_tracker, old_entry);
    ds_map_delete(trap_entities, old_entry); // Delete on missing value is safe.
}