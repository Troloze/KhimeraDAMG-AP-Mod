var lock_item = 500100000 + index + 1
var clear_loc =  10000000 * index + 100001;

if (!ap_item_get(lock_item)){
    visible = true;
    image_index = 1;
} else if (ap_location_get(clear_loc)) {
    visible = true;
    image_index = 0;
} else {
    visible = false;
}