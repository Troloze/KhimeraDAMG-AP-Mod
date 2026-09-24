// Writer loop

// Game information composer
if (!ap_communication_probe_message("ap.gi")){
    // Split tasks into types;
    var death_ack = undefined, location_acks = ds_list_create();
    var task_id, task, t_type, i;
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
    var gi_message = ds_map_create(), death_link = ds_map_create(), data_changes = ds_map_create(), location_ids = ds_list_create(), emit_gi = false;
    
    if (!ds_map_empty(global.ap_local_locations)) {
        var current_key = ds_map_find_first(global.ap_local_locations);
        while (!is_undefined(current_key)) {
            ds_list_add(location_ids, current_key);
            current_key = ds_map_find_next(global.ap_local_locations, current_key);
        }
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
    
    if (!ds_map_empty(global.ap_data_changes_a)) {
        var data_changes_name = ds_list_create();
        var data_changes_id = ds_list_create();
        var data_changes_type = ds_list_create();
        var data_changes_value = ds_list_create();
        var c_entry = ds_map_find_first(global.ap_data_changes_a);
        var c_id, c_type, c_value;
        var data_counter = 0;
        while (!is_undefined(c_entry)) {
            data_counter++;
            c_id = ds_map_find_value(global.ap_data_changes_a, c_entry);
            c_type = ap_data_get_type(c_entry);
            if (is_undefined(c_type)) {
                c_type = "RM";
                c_value = 0
                ds_list_add(data_changes_name, c_entry);
                ds_list_add(data_changes_id, c_id);
                ds_list_add(data_changes_type, c_type);
                ds_list_add(data_changes_value, c_value);
                c_entry = ds_map_find_next(global.ap_data_changes_a, c_entry);
                continue;
            }
            c_value = ap_data_get(c_entry);
            
            if (c_type == "value") {
                if (is_string(c_value)) c_type = "SV";  
                else c_type = "NV";
                ds_list_add(data_changes_value, c_value);
            }
            else if (c_type == "list") {
            // Nothing on the game side will enforce the "all values in a list must be the of the same type" rule
            // the contract specifies. It will be the on the developer to make sure he does not mix types.
                if (ds_list_empty(c_value))
                    c_type = "NL"; // type is irrelevant in this case.
                else if (is_string(ds_list_find_value(c_value, 0))) 
                    c_type = "SL"; 
                else  
                    c_type = "NL";
                var list_copy = ds_list_create();
                ds_list_copy(list_copy, c_value);
                ds_list_add(data_changes_value, list_copy);
                ds_list_mark_as_list(data_changes_value, data_counter - 1);
            }
            else if (c_type == "dict") {
                c_type = "D";
                var map_copy = ds_map_create();
                ds_map_copy(map_copy, c_value);
                ds_list_add(data_changes_value, map_copy);
                ds_list_mark_as_map(data_changes_value, data_counter - 1);
            }
            ds_list_add(data_changes_name, c_entry);
            ds_list_add(data_changes_id, c_id);
            ds_list_add(data_changes_type, c_type);
            c_entry = ds_map_find_next(global.ap_data_changes_a, c_entry);
        }
        
        ds_map_replace_list(data_changes, "names", data_changes_name);
        ds_map_replace_list(data_changes, "ids", data_changes_id);
        ds_map_replace_list(data_changes, "types", data_changes_type);
        ds_map_replace_list(data_changes, "values", data_changes_value);
        ds_map_replace(data_changes, "count", data_counter);
        ds_map_replace_map(gi_message, "data", data_changes);
        data_changes = undefined;
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
    if (!is_undefined(data_changes)) ds_map_destroy(data_changes);
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

// Maintains the writer loop
alarm[1] = writer_tick