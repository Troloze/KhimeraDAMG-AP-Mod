if (gravitymode)
{
    if (global.ap_item_wep_obtained[10] && global.wep_active[10] && !hidden)
    {
        if (instance_exists(obj_chelshia))
        {
            if (point_distance(x, y, obj_chelshia.x, obj_chelshia.y) <= 48)
                gravitymode = 0;
        }
    }
    
    if (instance_place(x, y + 1, obj_block) == -4 && yspeed < 8)
        yspeed += 0.5;
    
    if (xspeed != 0)
    {
        if (place_free(x + xspeed, y))
            x += xspeed;
    }
    
    scr_yspeed();
}
else if (instance_exists(obj_chelshia))
{
    gravity = 0.2;
    gravity_direction = point_direction(x, y, obj_chelshia.x, obj_chelshia.y + 16);
    
    if (speed > 3)
        speed = 3;
}
else
{
    instance_destroy();
}
