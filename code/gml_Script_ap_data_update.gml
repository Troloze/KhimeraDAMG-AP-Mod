var key = argument0;
var value = argument1;

if (is_undefined(global.ap_data)) return;

if (ds_map_exists(global.ap_data, key)) {
    var data_entry = ds_map_find_value(global.ap_data, key)
    var data_type = ds_map_find_value(data_entry, "type");
    var data_value = ds_map_find_value(data_entry, "value");
    if (data_type == "value") {
        if (value == data_value) return;
    }
    if (data_type == "list") {
        ds_list_destroy(data_value);
    }
    if (data_type == "dict") {
        ds_map_destroy(data_value);
    }   
    ds_map_destroy(data_entry);
    ds_map_delete(global.ap_data, key);
}

var new_entry = ds_map_create();
ds_map_replace(new_entry, "type", "value");
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
