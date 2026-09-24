var names = argument0;
var types = argument1;
var values = argument2;
var count = argument3;

var is_update = global.ap_has_cctx;
// If the game already has a cctx, we will maintain the current data structure, but send the client a 
// diff of our state to theirs, ensuring that everything is matched. 
// The game has priority since this is where the changes happen.
if (is_update) {
    // We're making a complete diff of the client state to the game state.
    // Whatever changes we had buffered prior will be included, meaning we can reset these.
    ds_map_clear(global.ap_data_changes_a);
    ds_map_clear(global.ap_data_changes_b);
}

if (is_undefined(global.ap_data)) global.ap_data = ds_map_create();

var i, j, change_id, new_entry, current_key, current_value, current_size;

var data_entries = ds_map_create();
current_key = ds_map_find_first(global.ap_data)
while (!is_undefined(current_key)) {
    ds_map_replace(data_entries, current_key, 1);
    current_key = ds_map_find_next(global.ap_data, current_key);   
}

if (!is_undefined(names)) {
    for (i = 0; i < count; i++) {
        var c_name = ds_list_find_value(names, i);
        var c_type = ds_list_find_value(types, i);
        var c_value = ds_list_find_value(values, i);
        if (is_undefined(c_name)) continue;
        if (is_undefined(c_type)) continue;
        if (is_undefined(c_value)) continue;
        
        switch(c_type) {
            case "SV":
            case "NV":
                if (!is_update) {
                    // Don't use helpers since we don't want to send a diff to the client.
                    new_entry = ds_map_create();
                    ds_map_replace(new_entry, "type", "value");
                    ds_map_replace(new_entry, "value", c_value);
                    ds_map_replace(global.ap_data, c_name, new_entry);
                    continue;
                }
                
                // If different, we send a diff.
                if ((!ds_map_exists(global.ap_data, c_name)) || (ap_data_get_type(c_name) != "value") || (ap_data_get(c_name) != c_value)) {
                    change_id = global.ap_data_changes_counter++;
                    ds_map_replace(global.ap_data_changes_a, c_name, change_id);
                    ds_map_replace(global.ap_data_changes_b, change_id, c_name);
                }
                // Remove key from the data entries list;
                ds_map_delete(data_entries, c_name);
                break;
            case "SL":
            case "NL":
                var c_list = ds_list_create();
                var l_size = ds_list_size(c_value);
                for (j = 0; j < l_size; j++) ds_list_add(c_list, ds_list_find_value(c_value, j));
                if (!is_update) {
                    // Don't use helpers since we don't want to send a diff to the client.
                    new_entry = ds_map_create();
                    ds_map_replace(new_entry, "type", "list");
                    ds_map_replace(new_entry, "value", c_list);
                    ds_map_replace(global.ap_data, c_name, new_entry);
                    continue;
                }
                
                if ((!ds_map_exists(global.ap_data, c_name)) || (ap_data_get_type(c_name) != "list")) {
                    change_id = global.ap_data_changes_counter++;
                    ds_map_replace(global.ap_data_changes_a, c_name, change_id);
                    ds_map_replace(global.ap_data_changes_b, change_id, c_name);
                    ds_map_delete(data_entries, c_name);
                    ds_list_destroy(c_list)
                    break;
                }
                
                // Entry exists and is a list; time to check for equality.
                current_value = ap_data_get(c_name);
                current_size = ds_list_size(current_value);
                // Different size
                if (l_size != current_size) {
                    change_id = global.ap_data_changes_counter++;
                    ds_map_replace(global.ap_data_changes_a, c_name, change_id);
                    ds_map_replace(global.ap_data_changes_b, change_id, c_name);
                    ds_map_delete(data_entries, c_name);
                    ds_list_destroy(c_list)
                    break;
                }
                var list_is_different = 0;
                for (j = 0; j < current_size; j++) {
                    if (ds_list_find_value(current_value, j) != ds_list_find_value(c_list, j)) {
                        list_is_different = 1;
                        break;
                    }
                }
                // At least one value is different
                if (list_is_different) {
                    change_id = global.ap_data_changes_counter++;
                    ds_map_replace(global.ap_data_changes_a, c_name, change_id);
                    ds_map_replace(global.ap_data_changes_b, change_id, c_name);
                }
                
                ds_map_delete(data_entries, c_name);
                ds_list_destroy(c_list)
                break;
            case "D":
                var c_map = ds_map_create();
                var m_size = ds_list_size(c_value) / 2;
                for (j = 0; j < m_size; j++) ds_map_replace(c_map, ds_list_find_value(c_value, 2 * j), ds_list_find_value(c_value, 2 * j + 1));
                if (!is_update) {
                    // Don't use helpers since we don't want to send a diff to the client.
                    new_entry = ds_map_create();
                    ds_map_replace(new_entry, "type", "dict");
                    ds_map_replace(new_entry, "value", c_list);
                    ds_map_replace(global.ap_data, c_name, new_entry);
                    continue;
                }
                
                if ((!ds_map_exists(global.ap_data, c_name)) || (ap_data_get_type(c_name) != "dict")) {
                    change_id = global.ap_data_changes_counter++;
                    ds_map_replace(global.ap_data_changes_a, c_name, change_id);
                    ds_map_replace(global.ap_data_changes_b, change_id, c_name);
                    ds_map_delete(data_entries, c_name);
                    ds_map_destroy(c_map)
                    break;
                }
                
                // Entry exists and is a list; time to check for equality.
                current_value = ap_data_get(c_name);
                current_size = ds_map_size(current_value);
                // Different size
                if (m_size != current_size) {
                    change_id = global.ap_data_changes_counter++;
                    ds_map_replace(global.ap_data_changes_a, c_name, change_id);
                    ds_map_replace(global.ap_data_changes_b, change_id, c_name);
                    ds_map_delete(data_entries, c_name);
                    ds_map_destroy(c_map)
                    break;
                }
                
                var map_is_different = 0;
                current_key = ds_map_find_first(current_value);
                while (!is_undefined(current_key)) {
                    if (!ds_map_exists(c_map) || (ds_map_find_value(current_value, current_key) != ds_map_find_value(c_map, current_key))) {
                        // If the key isn't there, it is different;
                        map_is_different = 1;
                        break;
                    }
                }
                
                if (map_is_different) {
                    change_id = global.ap_data_changes_counter++;
                    ds_map_replace(global.ap_data_changes_a, c_name, change_id);
                    ds_map_replace(global.ap_data_changes_b, change_id, c_name);
                }
                
                ds_map_delete(data_entries, c_name);
                ds_map_destroy(c_map)
                break;
            default:
                break;
        }
    }
}

if (is_update) {
    // Any entries left in data_entries are not present in the client state, so we need to send those as well.
    current_key = ds_map_find_first(data_entries);
    while (!is_undefined(current_key)) {
        change_id = global.ap_data_changes_counter++;
        ds_map_replace(global.ap_data_changes_a, current_key, change_id);
        ds_map_replace(global.ap_data_changes_b, change_id, current_key);
        current_key = ds_map_find_next(data_entries, current_key);
    }
}

ds_map_destroy(data_entries);