return; // No achievements.

if (!global.ach_achieved[argument0])
{
    global.ach_achieved[argument0] = 1;
    var scrAA = instance_create(0, 0, obj_getAch);
    scrAA.index = argument0;
    scrAA = instance_create(0, 0, obj_ef_screenFade);
    scrAA.depth = -201;
    scr_saveAch(argument0);
    scr_steamCheck();
    
    if (global.STEAM_OPEN)
    {
        if (!steam_get_achievement(global.ach_steamName[argument0]))
            steam_set_achievement(global.ach_steamName[argument0]);
    }
}
