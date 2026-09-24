var value = argument0;

if (is_undefined(global.ap_options)) return undefined; // Not initialized.

var ret = ds_map_find_value(global.ap_options, value);
if (is_undefined(ret)) return ap_option_get_default(value); // Will return undefined if option does not exists (or dev made a typo somewhere).
return ret;