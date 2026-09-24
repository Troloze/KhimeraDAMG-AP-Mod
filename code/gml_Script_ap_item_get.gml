var item = argument0;

var count = ds_map_find_value(global.ap_item_map, item);
if (is_undefined(count)) return 0;
return count;
