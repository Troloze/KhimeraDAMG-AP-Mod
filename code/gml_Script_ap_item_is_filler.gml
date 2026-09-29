var item_id = argument0, item_type_identifier;

item_type_identifier = floor(item_id / global.AP_ID_TYPE) % 100;
return (item_type_identifier == global.AP_ITEM_TRAP || item_type_identifier == global.AP_ITEM_FILLER); // 08 - Filler Trap, 09 - Filler Harmless