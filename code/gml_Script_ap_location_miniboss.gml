index1 = argument0;
index2 = argument1;

if (room == rm_extraEye) {
    ds_map_replace(global.ap_local_locations, 70700001, 1);                             // Windy Way
} else if (is_undefined(index2)) {
    // Single miniboss
    if (index1 == 207) ds_map_replace(global.ap_local_locations, 10700001, 1);          // Air Fortress
    else if (index1 == 210) ds_map_replace(global.ap_local_locations, 20700001, 1);     // Mt. Afrokupa
    else if (index1 == 212) ds_map_replace(global.ap_local_locations, 30700001, 1);     // Pumpkin Valley
    else if (index1 == 214) ds_map_replace(global.ap_local_locations, 40700001, 1);     // Oil Platform
    
    // Mechanical mayhem encounters
    else if (index1 == obj_boss_snakeRefight) ds_map_replace(global.ap_local_locations,   110700001, 1);
    else if (index1 == obj_boss_harpyRefight) ds_map_replace(global.ap_local_locations,   110700002, 1);
    else if (index1 == obj_boss_pizzaRefight) ds_map_replace(global.ap_local_locations,   110700003, 1);
    else if (index1 == obj_boss_mimicRefight) ds_map_replace(global.ap_local_locations,   110700004, 1);
    else if (index1 == obj_boss_mermaidRefight) ds_map_replace(global.ap_local_locations, 110700005, 1);
} else {
    // Double miniboss
    if (index1 == 225 && index2 == 225) ds_map_replace(global.ap_local_locations, 700001, 1);           // Ragazza Plains
    else if (index1 == 207 && index2 == 212) ds_map_replace(global.ap_local_locations, 100700001, 1);   // The Black Widow 1
    else if (index1 == 214 && index2 == 210) ds_map_replace(global.ap_local_locations, 100700002, 1);   // The Black Widow 2
}