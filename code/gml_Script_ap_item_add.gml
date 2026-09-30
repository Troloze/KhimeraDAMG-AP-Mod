var item_id = argument0;
var ignore = argument1;

var current_item_count = ds_map_find_value(global.ap_item_map, item_id)
if (is_undefined(current_item_count)) {
    ds_map_replace(global.ap_item_map, item_id, 1);
} else {
    ds_map_replace(global.ap_item_map, item_id, current_item_count + 1);
}

if (ignore) return;
var item_type = floor(item_id / global.AP_ID_TYPE) % 100;
var item_uid = item_id % global.AP_ID_TYPE;

if (item_type == global.AP_ITEM_TRAP) {
    // Traps
    switch (item_uid) {
        case 1:     // Balls
            ds_queue_enqueue(filler_instance_queue, 4);
            break;
        case 2:     // Floof Aviator Swarm
            ds_queue_enqueue(filler_instance_queue, 5);
            break;
        case 3:     // Kiran Drive-By
            ds_queue_enqueue(filler_instance_queue, 6);
            break;
        case 4:     // Box 
            ds_queue_enqueue(filler_queue, 7);
            break;
        case 5:     // Random Enemy
            ds_queue_enqueue(filler_instance_queue, 8);
            break;
    }
} else if (item_type == global.AP_ITEM_FILLER) {
    // Filler
    switch (item_uid) {
        case 1:     // Coin Drop
            ds_queue_enqueue(filler_queue, 0);
            break;
        case 2:     // Small Treasure Drop
            ds_queue_enqueue(filler_queue, 1);
            break;
        case 3:     // Big Treasure Drop
            ds_queue_enqueue(filler_queue, 2);
            break;
        case 4:     // Food Drop
            ds_queue_enqueue(filler_queue, 3);
            break;
        case 5:     // Kiran Drive-Thru
            ds_queue_enqueue(filler_instance_queue, 9);
            break;
    }
} else {
    // Others ( I don't have a way to find item name through id :( )
    // var aa = ap_queue_splash(undefined, undefined, "RECEIVED: ");
}