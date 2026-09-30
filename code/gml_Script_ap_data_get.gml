var key = argument0

if (is_undefined(global.ap_data)) return undefined;

var entry = ds_map_find_value(global.ap_data, key);

if (is_undefined(entry)) return undefined;

var type = ds_map_find_value(entry, "type");
var value = ds_map_find_value(entry, "value");
var copy;
switch (type) {
    case "value":
        return value;
    case "list":
        copy = ds_list_create();
        ds_list_copy(copy, value)
        return copy;
    case "dict":
        copy = ds_map_create();
        ds_map_copy(copy, value)
        return copy;
}

return undefined;