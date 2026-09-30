action_inherited();
if (scr_getFairiesRescued() < 6) {
    canInteract = 0;
    visible = false;
} else {
    canInteract = 1;
    visible = true;
}
