// Observer loop
var root_cctx = -1;
var root_li = -1;
var root_hi = -1;
var cshb = undefined;
var csc = undefined;

root_cctx = ap_communication_get_message("ap.cctx");
root_li = ap_communication_get_message("ap.li");
root_hi = ap_communication_get_message("ap.hi");
cshb = ap_communication_get_flag("cshb");
csc = ap_communication_get_flag("csc");

if (cctx_read_cooldown > 0) {
    cctx_read_cooldown -= 1;
    if (root_cctx != -1) {
        ds_map_destroy(root_cctx);
        root_cctx = -1;
    }
}

if (li_read_cooldown > 0) {
    li_read_cooldown -= 1;
    if (root_li != -1) {
        ds_map_destroy(root_li);
        root_li = -1;
    }
}

// Using while for the purpose of escaping in case an inconsistency is found, 
// this only runs once.
while (root_cctx != -1) {
// Handle connection context importing
    ap_misc_log(false, "Attempting to load cctx...");
  
    // We do not read it if we're missing any parts of the context.
    var cctx = ds_map_find_value(root_cctx, "message");
    if (is_undefined(cctx)) {
        ap_misc_log(true, "Failed to load cctx: base message field is undefined.");
        break;
    }
    
    // First layer validation
    var meta = ds_map_find_value(cctx, "meta");
    var options = ds_map_find_value(cctx, "options");
    var data = ds_map_find_value(cctx, "data");
    var session = ds_map_find_value(cctx, "session");
    
    if (is_undefined(meta)) {
        ap_misc_log(true, "Failed to load cctx: meta field is undefined.");
        break;
    }
    
    // Meta validation
    var meta_ap_version = ds_map_find_value(meta, "archipelago_version");
    var meta_host_version = ds_map_find_value(meta, "host_world_version");
    var meta_client_version = ds_map_find_value(meta, "client_world_version");
    var meta_slot_name = ds_map_find_value(meta, "slot_name");
    var meta_seed = ds_map_find_value(meta, "seed");
    
    if (is_undefined(meta_ap_version)) {
        ap_misc_log(true, "Failed to load cctx: archipelago_version field from meta is undefined.");
        break;
    }
    if (is_undefined(meta_host_version)) {
        ap_misc_log(true, "Failed to load cctx: host_world_version field from meta is undefined.");
        break;
    }
    if (is_undefined(meta_client_version)) {
        ap_misc_log(true, "Failed to load cctx: client_world_version field from meta is undefined.");
        break;
    }
    if (is_undefined(meta_slot_name)) {
        ap_misc_log(true, "Failed to load cctx: slot_name field from meta is undefined.");
        break;
    }
    if (is_undefined(meta_seed)) {
        // Current client version doesn't push seed, once that is updated remove these comments.
        // ap_misc_log(true, "Failed to load cctx: seed field from meta is undefined.");
        // break; 
    }
    
    // Options validation
    var options_names;
    var options_types;
    var options_values;
    var options_count;
    if (!is_undefined(options)) {
        options_names = ds_map_find_value(options, "names");
        options_types = ds_map_find_value(options, "types");
        options_values = ds_map_find_value(options, "values");
        options_count = ds_map_find_value(options, "count");
        
        if (is_undefined(options_names)) {
            ap_misc_log(true, "Failed to load cctx: names field from options is undefined.");
            break;
        }
        if (is_undefined(options_types)) {
            ap_misc_log(true, "Failed to load cctx: types field from options is undefined.");
            break;
        }
        if (is_undefined(options_values)) {
            ap_misc_log(true, "Failed to load cctx: values field from options is undefined.");
            break;
        }
        if (is_undefined(options_count)) {
            ap_misc_log(true, "Failed to load cctx: count field from options is undefined.");
            break;
        }
    }
    
    // Data validation
    var data_names;
    var data_types;
    var data_values;
    var data_count;
    if (!is_undefined(data)) {
        data_names = ds_map_find_value(data, "names");
        data_types = ds_map_find_value(data, "types");
        data_values = ds_map_find_value(data, "values");
        data_count = ds_map_find_value(data, "count");
    
        if (is_undefined(data_names)) {
            ap_misc_log(true, "Failed to load cctx: names field from data is undefined.");
            break;
        }
        if (is_undefined(data_types)) {
            ap_misc_log(true, "Failed to load cctx: types field from data is undefined.");
            break;
        }
        if (is_undefined(data_values)) {
            ap_misc_log(true, "Failed to load cctx: values field from data is undefined.");
            break;
        }
        if (is_undefined(data_count)) {
            ap_misc_log(true, "Failed to load cctx: count field from data is undefined.");
            break;
        }
    }
    
    // Session validation
    var session_last_ack;
    var session_item_list;
    var session_location_ids;
    var session_is_win;
    
    var sit_item_ids;
    var sit_player_ids;
    var sit_count;
    if (!is_undefined(session)){
        session_last_ack = ds_map_find_value(session, "last_ack");
        session_item_list = ds_map_find_value(session, "item_list");
        session_location_ids = ds_map_find_value(session, "location_ids");
        session_is_win = ds_map_find_value(session, "is_win");
         
        
        if (!is_undefined(session_item_list)){
            // Session item list validation
            sit_item_ids = ds_map_find_value(session_item_list, "item_ids");
            sit_player_ids = ds_map_find_value(session_item_list, "player_ids");
            sit_count = ds_map_find_value(session_item_list, "count");
            
            if (is_undefined(sit_item_ids)) {
                ap_misc_log(true, "Failed to load cctx: item_ids field from item_list (session) is undefined.");
                break;
            }
            if (is_undefined(sit_player_ids)) {
                ap_misc_log(true, "Failed to load cctx: player_ids field from item_list (session) is undefined.");
                break;
            }
            if (is_undefined(sit_count)) {
                ap_misc_log(true, "Failed to load cctx: count field from item_list (session) is undefined.");
                break;
            }
        }
    }
    
    // If we reached here, we are validated!
    
    // Incorporate data once data can be incorporated
    
    // Meta:
    // Versions will be used for incompatiblity handling and won't be stored globaly.
    if (!is_undefined(global.ap_slot_name) && !is_undefined(global.ap_seed)) {
        if (meta_slot_name != global.ap_slot_name || meta_seed != global.ap_seed) {
            // Attempt to change slots mid gameplay, handle accordingly later.
            
        }
    }
    global.ap_slot_name = meta_slot_name;
    global.ap_seed = meta_seed;
    
    var option_data;
    // Options:
    if (!is_undefined(options)) {
        if (!is_undefined(global.ap_options)) ap_communication_destroy_option_data(global.ap_options);
        option_data = ap_communication_create_option_data(options_names, options_types, options_values, options_count);
        if (option_data != -1) global.ap_options = option_data;
    }
    // Data:
    if (!is_undefined(data)) {
        if (!is_undefined(global.ap_data)) ap_communication_destroy_option_data(global.ap_data);
        option_data = ap_communication_create_option_data(data_names, data_types, data_values, data_count);
        if (option_data != -1) global.ap_data = option_data;
    }
    
    // Session:
    if (!is_undefined(session)) {
        if (!is_undefined(session_last_ack)) {
            global.ap_last_ack = real(session_last_ack);
        }
        if (!is_undefined(session_is_win)) {
            global.ap_is_win = real(session_is_win);
        }
        if (!is_undefined(session_location_ids)) {
            var sli_size = ds_list_size(session_location_ids);
            var sli_i;
            for (sli_i = 0; sli_i < sli_size; sli_i++) {
                var sli_task = ds_map_create();
                ds_map_replace(sli_task, "type", "location");
                ds_map_replace(sli_task, "id", ds_list_find_value(session_location_ids, sli_i));
                ds_queue_enqueue(global.ap_incomming_tasks, sli_task);
            }
        }
        if (!is_undefined(session_item_list)) {
            var sit_i;
            // Skip 0;
            for (sit_i = 1; sit_i <= sit_count; sit_i++) {
                var sit_task = ds_map_create();
                ds_map_replace(sit_task, "type", "item");
                ds_map_replace(sit_task, "sender", ds_list_find_value(sit_player_ids, sit_i));
                ds_map_replace(sit_task, "index", sit_i);
                ds_map_replace(sit_task, "id", ds_list_find_value(sit_item_ids, sit_i));
                // Note that items are always placed in order.
                ds_queue_enqueue(global.ap_incomming_tasks, sit_task);
            }
        }
    }

    ap_misc_log(false, "Successfully loaded cctx.");
    cctx_read_cooldown = 10; // Wait 10 ticks before reading another cctx.
    global.ap_has_cctx = 1;

    // Close the loop
    break;
}

if (root_cctx != -1) ds_map_destroy(root_cctx);

// Using while for the purpose of escaping in case an inconsistency is found, 
// this only runs once.
while (root_li != -1) {
// Handle location information importing
    ap_misc_log(false, "Attempting to load li...");
    
    var li = ds_map_find_value(root_li, "message");
    
    if (is_undefined(li)) {
        ap_misc_log(true, "Failed to load li: base message field is undefined.");
        break;
    }
    
    var enabled = ds_map_find_value(li, "enabled");
    var locations = ds_map_find_value(li, "locations");
    
    if (is_undefined(enabled)) {
        ap_misc_log(true, "Failed to load li: enabled field is undefined.");
        break;
    }
     
    // If not enabled, set everything here and escape.
    if (!enabled) {
        global.ap_li_enabled = 0;
        global.ap_location_information = undefined;
        global.ap_has_li = 1;
        ap_misc_log(false, "Successfully loaded li.");
        break;
    }
    
    // Locations validation
    if (is_undefined(locations)) {
        ap_misc_log(true, "Failed to load li: enabled is set to true, but locations is undefined.");
        break;
    }
    
    var loc_location_ids = ds_map_find_value(locations, "location_ids");
    var loc_location_classifications = ds_map_find_value(locations, "location_classifications");
    var loc_player_ids = ds_map_find_value(locations, "player_ids");
    var loc_count = ds_map_find_value(locations, "count");
    
    if (is_undefined(loc_location_ids)) {
        ap_misc_log(true, "Failed to load li: enabled is set to true, but location_ids from locations is undefined.");
        break;
    }
    if (is_undefined(loc_location_classifications)) {
        ap_misc_log(true, "Failed to load li: enabled is set to true, but location_classifications from locations is undefined.");
        break;
    }
    if (is_undefined(loc_player_ids)) {
        ap_misc_log(true, "Failed to load li: enabled is set to true, but player_ids from locations is undefined.");
        break;
    }
    if (is_undefined(loc_count)) {
        ap_misc_log(true, "Failed to load li: enabled is set to true, but count from locations is undefined.");
        break;
    }
        
    // If we reached here, we are validated!
    
    if (!is_undefined(global.ap_location_information)) ap_communication_destroy_li(global.ap_location_information);
    global.ap_location_information = ap_communication_create_li(loc_location_ids, loc_location_classifications, loc_player_ids, loc_count);
    global.ap_li_enabled = 1;
    global.ap_has_li = 1;
    
    ap_misc_log(false, "Successfully loaded li.");
    li_read_cooldown = 10; // Wait 10 ticks before reading another li.
    // Close the loop
    break;
}

if (root_li != -1) ds_map_destroy(root_li);

// Using while for the purpose of escaping in case an inconsistency is found, 
// this only runs once.
while (root_hi != -1) {
// Handle host information importing
    // No reason to log this one, it will happen constantly.
    // ap_misc_log(false, "Attempting to load hi...");
    
    var hi = ds_map_find_value(root_hi, "message");
    
    if (is_undefined(hi)) {
        ap_misc_log(true, "Failed to load hi: base message field is undefined.");
        break;
    }
    
    
    var messages = ds_map_find_value(hi, "messages");
    var death_link = ds_map_find_value(hi, "death_link");
    var item_list = ds_map_find_value(hi, "item_list");
    var location_ids = ds_map_find_value(hi, "location_ids");
    var death_ack = ds_map_find_value(hi, "death_ack");
    
    var msg_senders;
    var msg_messages;
    var msg_count;
    if (!is_undefined(messages)) {
        msg_senders = ds_map_find_value(messages, "senders");
        msg_messages = ds_map_find_value(messages, "messages");
        msg_count = ds_map_find_value(messages, "count");
        
        if (is_undefined(msg_senders)) {
            ap_misc_log(true, "Failed to load hi: senders field from messages is undefined.");
            break;
        }
        if (is_undefined(msg_messages)) {
            ap_misc_log(true, "Failed to load hi: messages field from messages is undefined.");
            break;
        }
        if (is_undefined(msg_count)) {
            ap_misc_log(true, "Failed to load hi: count field from messages is undefined.");
            break;
        }
    }
    
    var dl_sender;
    var dl_id;
    var dl_message;
    if (!is_undefined(death_link)) {
        dl_sender = ds_map_find_value(death_link, "sender");
        dl_id = ds_map_find_value(death_link, "death_id");
        dl_message = ds_map_find_value(death_link, "message");
        
        if (is_undefined(dl_sender)) {
            ap_misc_log(true, "Failed to load hi: sender field from death_link is undefined.");
            break;
        }
        if (is_undefined(dl_id)) {
            ap_misc_log(true, "Failed to load hi: id field from death_link is undefined.");
            break;
        }
        if (is_undefined(dl_message)) {
            ap_misc_log(true, "Failed to load hi: message field from death_link is undefined.");
            break;
        }
    }
    
    var il_item_ids;
    var il_player_ids;
    var il_item_indexes;
    var il_count;
    if (!is_undefined(item_list)) {
        il_item_ids = ds_map_find_value(item_list, "item_ids");
        il_player_ids = ds_map_find_value(item_list, "player_ids");
        il_item_indexes = ds_map_find_value(item_list, "item_indexes");
        il_count = ds_map_find_value(item_list, "count");
    
        if (is_undefined(il_item_ids)) {
            ap_misc_log(true, "Failed to load hi: item_ids field from item_list is undefined.");
            break;
        }
        if (is_undefined(il_player_ids)) {
            ap_misc_log(true, "Failed to load hi: player_ids field from item_list is undefined.");
            break;
        }
        if (is_undefined(il_item_indexes)) {
            ap_misc_log(true, "Failed to load hi: item_indexes field from item_list is undefined.");
            break;
        }
        if (is_undefined(il_count)) {
            ap_misc_log(true, "Failed to load hi: count field from item_list is undefined.");
            break;
        }
    }
    
    // If we reached here, we are validated!
    
    if (!is_undefined(messages)) {
        var msg_i;
        for (msg_i = 0; msg_i < msg_count; msg_i++) {
            var msg_task = ds_map_create();
            ds_map_replace(msg_task, "type", "message");
            ds_map_replace(msg_task, "sender", ds_list_find_value(msg_senders, msg_i));
            ds_map_replace(msg_task, "message", ds_list_find_value(msg_messages, msg_i));
            ds_queue_enqueue(global.ap_incomming_tasks, msg_task);
        }
    }
    if (!is_undefined(death_link)) {
        var dl_task = ds_map_create();
        ds_map_replace(dl_task, "type", "death_link");
        ds_map_replace(dl_task, "sender", dl_sender);
        ds_map_replace(dl_task, "message", dl_message);
        ds_map_replace(dl_task, "id", dl_id);
        ds_queue_enqueue(global.ap_incomming_tasks, dl_task);
    }
    if (!is_undefined(item_list)) {
        var il_i;
        for (il_i = 0; il_i < il_count; il_i++) {
            var il_task = ds_map_create();
            ds_map_replace(il_task, "type", "item");
            ds_map_replace(il_task, "sender", ds_list_find_value(il_player_ids, il_i));
            ds_map_replace(il_task, "index", ds_list_find_value(il_item_indexes, il_i));
            ds_map_replace(il_task, "id", ds_list_find_value(il_player_ids, il_i));
            // Note that items are always placed in order.
            ds_queue_enqueue(global.ap_incomming_tasks, il_task);
        }
    }
    if (!is_undefined(location_ids)) {
        var lid_size = ds_list_size(location_ids);
        var lid_i;
        for (lid_i = 0; lid_i < lid_size; lid_i++) {
            var lid_task = ds_map_create();
            ds_map_replace(lid_task, "type", "location");
            ds_map_replace(lid_task, "id", ds_list_find_value(location_ids, lid_i));
            ds_queue_enqueue(global.ap_incomming_tasks, lid_task);
        }
    }
    if (!is_undefined(death_ack)) {
        var dack_task = ds_map_create();
        ds_map_replace(dack_task, "type", "death_ack");
        ds_map_replace(dack_task, "id", real(death_ack));
        ds_queue_enqueue(global.ap_incomming_tasks, dack_task);
    }
    
    // No reason to log success on this one, as it is repeated on loop.

    // Close the loop
    break;
}

if (root_hi != -1) ds_map_destroy(root_hi);

// Process flags after files so cctx can be read before global.ap_fully_connected is set to true on a reconnection.

var hb_delta = (current_time - global.ap_last_client_heartbeat_time) / 1000;
if (is_undefined(cshb)) {
    // Delta in seconds.
    if (global.ap_client_connected && hb_delta > global.ap_max_heartbeat_delta) {
        global.ap_client_connected = 0;
    }
} else {
    if (real(cshb) == global.ap_last_client_heartbeat) {
        if (global.ap_client_connected && hb_delta > global.ap_max_heartbeat_delta) {
            global.ap_client_connected = 0;
        }
    } else { 
        global.ap_last_client_heartbeat = real(cshb);
        global.ap_last_client_heartbeat_time = current_time;
        global.ap_client_connected = 1;
    }
}

if (global.ap_client_connected) {
    if (is_undefined(csc)) global.ap_fully_connected = 0;
    else global.ap_fully_connected = 1;
} else global.ap_fully_connected = 0;


// Maintains the observer loop
alarm[1] = observer_tick;