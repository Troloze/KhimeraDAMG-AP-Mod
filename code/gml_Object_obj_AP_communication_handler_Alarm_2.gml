// Writer loop

// Game information composer
if (!ap_communication_probe_message("ap.gi")){
    // Split tasks into types;
    var death_ack = undefined, location_ids = ds_list_create(), location_acks = ds_list_create();
    var message, task_id, task, t_type, i;
    for (i = 0; i < max_outgoing_tasks_per_tick; i++) {
        if (ds_queue_empty(global.ap_outgoing_tasks)) break;
        task = ds_queue_dequeue(global.ap_outgoing_tasks);
        t_type = ds_map_find_value(task, "type");
        // The task was malformed, let's move on.
        if (is_undefined(t_type)) {
            ds_map_destroy(task);
            continue;
        }
        switch (t_type) {
            case "location":
                task_id = ds_map_find_value(task, "id");
                if (is_undefined(task_id)) break;
                ds_list_add(location_ids, task_id);
                break;
            case "location_ack":
                task_id = ds_map_find_value(task, "id");
                if (is_undefined(task_id)) break;
                ds_list_add(location_acks, task_id);
                break;
            case "death_ack":
                task_id = ds_map_find_value(task, "id");
                if (is_undefined(task_id)) break;
                death_ack = task_id;
                break;
        }
        ds_map_destroy(task);
    }
    
    // Compose the map
    var gi_message = ds_map_create(), death_link = ds_map_create(), emit_gi = false;
    
    if (!ds_list_empty(location_ids)) {
        ds_map_replace_list(gi_message, "location_ids", location_ids);
        location_ids = undefined;
        emit_gi = true;
    }
    
    if (!ds_list_empty(location_acks)) {
        ds_map_replace_list(gi_message, "location_acks", location_acks);
        location_acks = undefined;
        emit_gi = true;
    }
    
    if (!is_undefined(death_ack)) {
        ds_map_replace(gi_message, "death_ack", death_ack);
        emit_gi = true;
    }
    
    // Death link (we issue even if death link is disabled, the client will discard it)
    if (!(global.ap_last_death_link == global.ap_last_death_link_ack)) {
        ds_map_replace(death_link, "id", global.ap_last_death_link);
        if (is_undefined(global.ap_last_death_link_message)) ds_map_replace(death_link, "message", "%s has died.");
        else ds_map_replace(death_link, "message", global.ap_last_death_link_message);
        ds_map_replace_map(gi_message, "death_link", death_link);
        death_link = undefined;
        emit_gi = true;
    }
    
    if (emit_gi) {
        var game_information = ds_map_create();
        ds_map_replace_map(game_information, "message", gi_message);
        gi_message = undefined;
        ap_communication_set_message("ap.gi", game_information);
        ds_map_destroy(game_information);
    }
    
    if (!is_undefined(location_ids)) ds_list_destroy(location_ids);
    if (!is_undefined(location_acks)) ds_list_destroy(location_acks);
    if (!is_undefined(death_link)) ds_map_destroy(death_link);
    if (!is_undefined(gi_message)) ds_map_destroy(gi_message);
    
}
// Flags
var current_heartbeat = global.ap_game_heartbeat++;
var req = 0;

if (!global.ap_has_li) req += 1;
if (!global.ap_has_cctx) req += 2;

ap_communication_set_flag("gshb", current_heartbeat);
ap_communication_set_flag("gsack", global.ap_last_ack);
ap_communication_set_flag("gsreq", req); 
ap_communication_set_flag("gswin", global.ap_is_win);

alarm[2] = writer_tick