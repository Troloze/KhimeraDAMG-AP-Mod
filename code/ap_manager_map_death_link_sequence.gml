var i, _x = map_death_link_chelshia_x, _y = map_death_link_chelshia_y;
if (map_death_link_action == 0) {
    if (!instance_exists(obj_map_chelshia)) return; // doesn't remove death link buffer
    with (obj_map_chelshia) {
        canmove = 0;
        xspeed = 0;
        yspeed = 0;
        image_speed = 0;
        idling = 1;
        walking = 0;
        lvl = -4;  
        other.map_death_link_chelshia_x = x;
        other.map_death_link_chelshia_y = y;
    }
    scr_stopmusic();
    aa = instance_create(map_death_link_chelshia_x, map_death_link_chelshia_y, obj_ef_screenFade);
    aa.trans = 2;
    aa.transrate = -1;
    scr_supersound(7, global.v_snd, 0);
    
    alarm[11] = 30;
    map_death_link_action++;
}
else if (map_death_link_action == 1)
{
    with (obj_map_chelshia) {
        instance_destroy();
    }
    
    scr_ef_smoke(_x + 8, _y);
    scr_ef_smoke(_x, _y + 8);
    scr_ef_smoke(_x + 16, _y + 8);
    scr_ef_smoke(_x + 8, _y + 16);
    visible = true;
    aa = instance_create(_x, _y, obj_ef_screenFade);
    aa.trans = 4;
    aa.transrate = -1;
    scr_supersound(22, global.v_snd, 0);
    alarm[11] = 10;
    map_death_link_action++;
}
else if (map_death_link_action == 2)
{
    scr_ef_smoke(_x + 8, _y + 8);
    
    for (i = 0; i < 360; i += 30)
        scr_ef_smoke(_x + 8 + (cos((i * pi) / 180) * 16), (_y + 8) - (sin((i * pi) / 180) * 16));
    
    alarm[11] = 150;
    map_death_link_action++;
}
else if (map_death_link_action == 3) 
{
    scr_playmusic(3, global.v_bgm, 1);
    instance_create(_x, _y, obj_map_chelshia);
    map_death_link_action = 0;
}