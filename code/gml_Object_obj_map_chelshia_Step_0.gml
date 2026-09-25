lvl = instance_place(x, y, obj_map_level);

if (canmove && (global.Qpress || keyboard_check_pressed(vk_escape)))
{
    canmove = 0;
    instance_create(x, y, obj_pause);
}

if (canmove && global.Apress)
{
    lvl = instance_place(x, y, obj_map_level);
    
    if (lvl != -4)
    {
        var unlock_item = 500100000 + lvl.index + 1;
        if (ap_item_get(unlock_item)) {
            // enter stage
            scr_fademusic();
            scr_supersound(18, global.v_snd, 0);
            image_speed = 0;
            image_index = 4;
            canmove = 0;
            alarm[0] = -1;
            alarm[1] = -1;
            walking = 0;
            idling = 0;
            xspeed = 0;
            yspeed = 0;
            alarm[4] = 15;
        } else {
            // stage is locked.
            scr_supersound(29, global.v_snd, 0);
        }
        
    }
}

ww = 0;

if (canmove)
{
    if (global.Lhold && place_free(x - 16, y))
    {
        xspeed = -2;
        ww = 1;
    }
    else if (global.Rhold && place_free(x + 16, y))
    {
        xspeed = 2;
        ww = 1;
    }
    else if (global.Uhold && place_free(x, y - 16))
    {
        yspeed = -2;
        ww = 1;
    }
    else if (global.Dhold && place_free(x, y + 16))
    {
        yspeed = 2;
        ww = 1;
    }
}

if (ww)
{
    scr_supersound(23, global.v_snd, 0);
    walking = 1;
    idling = 0;
    alarm[0] = 8;
    alarm[1] = -1;
    canmove = 0;
}

if (walking)
    image_index = walkImg;

if (idling)
    image_index = idleImg;

x += xspeed;
y += yspeed;
