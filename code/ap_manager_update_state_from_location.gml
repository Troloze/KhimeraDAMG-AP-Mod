// Called when a location released by the server is sent to the game.

if (!is_undefined(ds_map_find_value(global.ap_acked_locations, new_location))) return;

var stage_id = floor(new_location / 10000000);
var loc_type = floor(new_location / 100000) % 100;
var identifier = new_location % 100000;
switch(loc_type) {
    case 0: // General
        // No general locations in the current version.
        break;
    case 1: // Stage Clear and Upgrade
        if (identifier == 1) {
            global.level_complete[stage_id] = 1;
        } else if (identifier == 2) {
            global.wep_obtained[ap_misc_weapon_loc_to_id(new_location)] = 1;
        }
        break;
    case 2: // Fairy
        if (!ap_option_get("shuffle_fairies")) break; // Shouldn't happen, but just to be sure.
        
        global.level_fairy[stage_id, identifier] = 1;

        break;
    case 3: // Book
        if (!ap_option_get("shuffle_books")) break; // Shouldn't happen, but just to be sure.
        
        var book_id = ap_misc_book_loc_to_id(new_location);
        global.nme_obtained[book_id] = 1;

        break;
    /*case 4: // Candy (reserved, not implemented yet)
        if (!ap_option_get("shuffle_candy")) break; // Shouldn't happen, but just to be sure.
        break;*/
    case 5: // Detonator
        if (!ap_option_get("shuffle_detonators")) break; // Shouldn't happen, but just to be sure.
        
        global.level_rockPile[stage_id] = 1;

        break;
    case 6: // Gourmet Gal
        if (!ap_option_get("shuffle_gourmet_gal")) break; // Shouldn't happen, but just to be sure.
        
        global.level_food[stage_id] = 1;

        break;
    /*case 7: // Miniboss (Doesn't do anything for the state of the game)
        
        break;*/
    default:
        break;
}