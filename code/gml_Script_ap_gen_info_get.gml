var value = argument0;

if (is_undefined(global.ap_gen_info)) return undefined; // Not initialized.

var ret = ds_map_find_value(global.ap_gen_info, value);
if (is_undefined(ret)) return ap_gen_info_get_default(value); // Will return undefined if gen info does not exists (or dev made a typo somewhere).
return ret;