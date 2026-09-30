var index1 = argument0;
var index2 = argument1;

var stage = undefined, uid = undefined;


if (room == rm_extraEye) {
    // Measured separately because it spawns a random weekday witch, so we can't track with enemy index.
    stage = 7; uid = 1;                             // Windy Way
} else if (is_undefined(index2)) {
    // Single miniboss
    if (index1 == 207)      {stage = 1; uid = 1;}     // Air Fortress
    else if (index1 == 210) {stage = 2; uid = 1;}     // Mt. Afrokupa
    else if (index1 == 212) {stage = 3; uid = 1;}     // Pumpkin Valley
    else if (index1 == 214) {stage = 4; uid = 1;}     // Oil Platform
    
    // Mechanical mayhem encounters
    else if (index1 == obj_boss_snakeRefight)   {stage = 11; uid = 1;}
    else if (index1 == obj_boss_harpyRefight)   {stage = 11; uid = 2;}
    else if (index1 == obj_boss_pizzaRefight)   {stage = 11; uid = 3;}
    else if (index1 == obj_boss_mimicRefight)   {stage = 11; uid = 4;}
    else if (index1 == obj_boss_mermaidRefight) {stage = 11; uid = 5;}
} else {
    // Double miniboss
    if (index1 == 225 && index2 == 225)      {stage =  0; uid = 1;}     // Ragazza Plains
    else if (index1 == 207 && index2 == 212) {stage = 10; uid = 1;}     // The Black Widow 1
    else if (index1 == 214 && index2 == 210) {stage = 10; uid = 2;}     // The Black Widow 2
}

if (!is_undefined(stage) && !is_undefined(uid)) ds_map_replace(global.ap_local_locations, ap_location_make(stage, global.AP_LOC_MINIBOSS, uid), 1);