var key = argument0

if (is_undefined(global.ap_data)) return undefined;

var entry = ds_map_find_value(global.ap_data, key);

if (is_undefined(entry)) return undefined;

return ds_map_find_value(entry, "value");