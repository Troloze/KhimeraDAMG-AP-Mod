var task, t_type, loc_id, sender, item_index, item_id, dl_id, message, dack_id, i, out_task, data_id;


// Incoming Tasks.
for (i = 0; i < max_incomming_tasks_per_step; i++) {
    if (ds_queue_empty(global.ap_incomming_tasks)) break;
    task = ds_queue_dequeue(global.ap_incomming_tasks);
    t_type = ds_map_find_value(task, "type");
    // The task was malformed, let's move on.
    if (is_undefined(t_type)) {
        ds_map_destroy(task);
        continue;
    }
    switch (t_type) {
        case "location":
            loc_id = ds_map_find_value(task, "id");
            if (is_undefined(loc_id)) break;

            if (!is_undefined(ds_map_find_value(global.ap_local_locations, loc_id))) {
                ds_map_delete(global.ap_local_locations, loc_id);
            } else if (!ds_map_exists(task, "from_cctx")) {
                // Location not provided by cctx and not present in local locations, need to incorporate manually.
                new_location = loc_id;
                event_perform(ev_other, ev_user2);
            }
            
            ds_map_replace(global.ap_acked_locations, loc_id, true);
            
            out_task = ds_map_create();
            ds_map_replace(out_task, "type", "location_ack");
            ds_map_replace(out_task, "id", loc_id);
            ds_queue_enqueue(global.ap_outgoing_tasks, out_task);
            break;
        case "item":
            sender = ds_map_find_value(task, "sender");
            item_index = ds_map_find_value(task, "index");
            item_id = ds_map_find_value(task, "id");
            if (is_undefined(sender)) break;
            if (is_undefined(item_index)) break;
            if (is_undefined(item_id)) break;
            
            // Items are always placed in index order, so we can use this to
            // check if an item was missed or not. 
            
            if (item_index <= global.ap_last_ack) {
                if (item_index <= local_last_ack) {
                    ap_misc_log("Skipped duplicated item: " + string(item_id) + "(" + string(item_index) + ")");
                } else {
                    if (!ap_communication_is_item_filler(item_id)) {
                        // Consume any non-filler items here, used mainly when loading cctx.
                        ap_misc_log("Received acked item: " + string(item_id) + "(" + string(item_index) + "/" + string(global.ap_last_ack) + ")")
                    } else ap_misc_log("Skipped acked filler item: " + string(item_id) + "(" + string(item_index) + "/" + string(global.ap_last_ack) +")")
                    // Regardless if it is or isn't filler, we add to the item structures.
                    var current_item_count = ds_map_find_value(global.ap_item_map, item_id)
                    if (is_undefined(current_item_count)) {
                        ds_map_replace(global.ap_item_map, item_id, 1);
                    } else {
                        ds_map_replace(global.ap_item_map, item_id, current_item_count + 1);
                    }
                    local_last_ack = item_index;
                }
            } 
            else if (item_index == global.ap_last_ack + 1) {
                // Consumes items in order. Will not consume items of higher indexes unless all lower items have been consumed.
                ap_misc_log("Received item: " + string(item_id) + "(" + string(item_index) + ")")
                // Adding item to the map.
                var current_item_count = ds_map_find_value(global.ap_item_map, item_id)
                if (is_undefined(current_item_count)) {
                    ds_map_replace(global.ap_item_map, item_id, 1);
                } else {
                    ds_map_replace(global.ap_item_map, item_id, current_item_count + 1);
                }
                global.ap_last_ack = item_index;
                local_last_ack = item_index;
            }
            
            // No outgoing task here (.gsack is handled by the writer)
            break;
        case "death_link":
            sender = ds_map_find_value(task, "sender");
            dl_id = ds_map_find_value(task, "id");
            message = ds_map_find_value(task, "message"); // Will be ignored for now, since the death link message also arrives as a message.
            if (is_undefined(sender)) break;
            if (is_undefined(dl_id)) break;
            if (is_undefined(message)) break;
            
            // No "if (ap_option_get("death_link"))" guard here since the client won't send death links if disabled.
            if (room == rm_map) {
                alarm[11] = 2;  
            } else {
                with (obj_chelshia) {
                    event_perform(ev_other, ev_user10);
                }
            }
            
            out_task = ds_map_create();
            ds_map_replace(out_task, "type", "death_ack");
            ds_map_replace(out_task, "id", dl_id);
            ds_queue_enqueue(global.ap_outgoing_tasks, out_task);
            // Create outgoing task of sending death_ack
            break;
        case "death_ack":
            dack_id = ds_map_find_value(task, "id");
            if (is_undefined(dack_id)) break;
            if (dack_id > global.ap_last_death_link_ack) global.ap_last_death_link_ack = dack_id;
            // No outgoing task here.
            break;
        case "message":
            sender = ds_map_find_value(task, "sender");
            message = ds_map_find_value(task, "message");
            if (is_undefined(sender)) break;
            if (is_undefined(message)) break;
            
            ap_misc_log("Received message: " + '"' + message + '"');
            
            // No outgoing task here.
            break;
        case "data_ack":
            data_id = ds_map_find_value(task, "id");
            
            var data_key = ds_map_find_value(global.ap_data_changes_b, data_id);
            if (is_undefined(data_key)) {
                // The id doesn't exist anymore, no changes required
            } else {
                ds_map_delete(global.ap_data_changes_a, data_key);
                ds_map_delete(global.ap_data_changes_b, data_id);
            }
            break;
        case "load_state":
            event_perform(ev_other, ev_user0); // Load the state
            break;
        default:
            // Do nothing.
            break;
    }
    ds_map_destroy(task);
}