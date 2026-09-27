var item_id = argument0;
var ignore = argument1;

var current_item_count = ds_map_find_value(global.ap_item_map, item_id)
if (is_undefined(current_item_count)) {
    ds_map_replace(global.ap_item_map, item_id, 1);
} else {
    ds_map_replace(global.ap_item_map, item_id, current_item_count + 1);
}

if (ignore) return;
var item_type = floor(item_id / 100000) % 100;
var item_uid = item_id % 100000;

if (item_type == 8) {
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
            var i, count = irandom(3) + 1;
            
            for (i = 0; i < count; i++) {
                if (!irandom(1)) ds_queue_enqueue(filler_queue, -1);
                if (!irandom(3)) ds_queue_enqueue(filler_queue, -1);
                if (!irandom(7)) ds_queue_enqueue(filler_queue, -1);
                ds_queue_enqueue(filler_queue, 7);
            }
            break;
        case 5:     // Random Enemy
            ds_queue_enqueue(filler_instance_queue, 8);
            break;
    }
}

if (item_type == 9) {
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
}