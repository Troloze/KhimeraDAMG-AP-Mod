var c_id = argument0;
var u_id = argument1;

var e_id = ds_map_find_value(global.ap_enemy_tracker, c_id);
if (is_undefined(e_id) || e_id != u_id) return false;
return true;