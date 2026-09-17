var task, t_type, loc_id, sender, item_index, item_id, dl_id, message, dack_id, i, out_task;


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
            // Hook this up to a location handler, that will transform obtained locations into vanilla flags.
            
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
            
            // This will skip other items if one of them was not consumed.
            if (item_index == global.ap_last_ack + 1) {
                // Consume the item, yadda yadda.
                
                global.ap_last_ack = item_index;
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
            ap_misc_log(false, "Received message - " + message);
            if (is_undefined(sender)) break;
            if (is_undefined(message)) break;
            // No outgoing task here.
            break;
        default:
            continue;
    }
    ds_map_destroy(task);
}