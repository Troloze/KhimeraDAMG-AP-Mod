var lock_item = ap_item_make(global.AP_ITEM_STAGE, index + 1);
var clear_loc = ap_location_make(index, global.AP_LOC_CLEAR, 1);

if (!ap_item_get(lock_item)){
    visible = true;
    image_index = 1;
} else if (ap_location_get(clear_loc)) {
    visible = true;
    image_index = 0;
} else {
    visible = false;
}