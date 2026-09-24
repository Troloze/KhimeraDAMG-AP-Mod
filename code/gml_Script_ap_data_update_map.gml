var key = argument0;
var value = argument1;

if (is_undefined(global.ap_data)) {
    ds_map_destroy(value);    
    return;
}

if (ds_map_exists(global.ap_data, key)) {
    var data_entry = ds_map_find_value(global.ap_data, key)
    var data_type = ds_map_find_value(data_entry, "type");
    var data_value = ds_map_find_value(data_entry, "value");
    if (data_type == "list") {
        ds_list_destroy(data_value);
    }
    if (data_type == "dict") {
        // Check for equality;
        if (value != data_value) {
            // Returning same reference means the values will read as equals even if changes were made, always raise change flag in this case.
            var new_map_size = ds_map_size(value);
            var curr_map_size = ds_map_size(data_value);
            if (new_map_size == curr_map_size) {
                if (new_map_size == 0) {
                    ds_map_destroy(value);
                    return;
                }
                var c_check = ds_map_find_first(value), is_equal = 1;
                while (!is_undefined(c_check)) {
                    var new_value = ds_map_find_value(value, c_check);
                    var curr_value = ds_map_find_value(data_value, c_check);
                    if (is_undefined(new_value) != is_undefined(curr_value)) {
                        is_equal = 0;
                        break;
                    }
                    if (new_value != curr_value) {
                        is_equal = 0;
                        break;
                    }
                    c_check = ds_map_find_next(value, c_check);
                }
                if (is_equal) {
                    ds_map_destroy(value);
                    return;
                }
            }
            ds_map_destroy(data_value); // We don't destroy the reference if value == data_value.
        }
    } 
    ds_map_destroy(data_entry);
    ds_map_delete(global.ap_data, key);
}

var new_entry = ds_map_create();
ds_map_replace(new_entry, "type", "dict");
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
