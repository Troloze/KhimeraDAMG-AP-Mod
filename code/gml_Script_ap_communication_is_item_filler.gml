var item_id = argument0, item_type_identifier;

if (is_string(item_id)) {
    item_type_identifier = string_copy(item_id, 3, 2)
    return (item_type_identifier == "08" || item_type_identifier == "09"); // 08 - Filler Trap, 09 - Filler Harmless
}

item_type_identifier = floor(item_id / 100000) % 100
return (item_type_identifier == 8 || item_type_identifier == 9); // 08 - Filler Trap, 09 - Filler Harmless