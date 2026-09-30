action_inherited();
if (scr_getFairiesRescued() < 3) {
    canInteract = 0;
    visible = false;
} else {
    canInteract = 1;
    visible = true;
}
