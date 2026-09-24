var key = argument0;
var value = argument1;

if (is_undefined(global.ap_data)) {
    ds_list_destroy(value);    
    return;
}

if (ds_map_exists(global.ap_data, key)) {
    var data_entry = ds_map_find_value(global.ap_data, key)
    var data_type = ds_map_find_value(data_entry, "type");
    var data_value = ds_map_find_value(data_entry, "value");
    if (data_type == "list") {
        // Check for equality;
        if (value != data_value) {
            // Returning same reference means the values will read as equals even if changes were made, always raise change flag in this case.
            var new_list_size = ds_list_size(value);
            var curr_list_size = ds_list_size(data_value);
            if (new_list_size == curr_list_size) {
                if (new_list_size == 0) {
                    ds_list_destroy(value);
                    return;
                }
                var lc_i, is_equal = 1;
                for (lc_i = 0; lc_i < new_list_size; lc_i++) {
                    if (ds_list_find_value(value, lc_i) != ds_list_find_value(data_value, lc_i)) {
                        is_equal = 0;
                        break;
                    }
                }
                if (is_equal) {
                    ds_list_destroy(value);
                    return;
                }
            }
            ds_list_destroy(data_value); // We don't destroy the reference if value == data_value.
        }
    }
    if (data_type == "dict") {
        ds_map_destroy(data_value);
    }   
    ds_map_destroy(data_entry);
    ds_map_delete(global.ap_data, key);
}

var new_entry = ds_map_create();
ds_map_replace(new_entry, "type", "list");
ds_map_replace(new_entry, "value", value);

ds_map_replace(global.ap_data, key, new_entry);

if (global.ap_data_disable_update_signals) return;

var change_id = global.ap_data_changes_counter++;

var previous_id = ds_map_find_value(global.ap_data_changes_a, key)

if (!is_undefined(previous_id)) { 
    ds_map_delete(global.ap_data_changes_b, previous_id);
}

ds_map_replace(global.ap_data_changes_a, key, change_id);
ds_map_replace(global.ap_data_changes_b, change_id, key);
