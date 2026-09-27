var item_id = argument0, item_type_identifier;

item_type_identifier = floor(item_id / 100000) % 100;
return (item_type_identifier == 8 || item_type_identifier == 9); // 08 - Filler Trap, 09 - Filler Harmless