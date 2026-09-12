action += 1;

if (action == 1)
{
    shake = 1;
    alarm[0] = 5;
}

if (action <= 26)
{
    aa = instance_create((x + irandom(4)) - 2, (y + irandom(4)) - 2, obj_treasure);
    aa.xspeed = floor(cos((action * 30 * pi) / 180) * 4);
    aa.yspeed = -6;
    aa.value = 50;
    aa = instance_create((x + irandom(4)) - 2, (y + irandom(4)) - 2, obj_treasure);
    aa.xspeed = irandom(8) - 4;
    aa.yspeed = -5;
    aa.value = 5;
    aa = instance_create((x + irandom(4)) - 2, (y + irandom(4)) - 2, obj_treasure);
    aa.xspeed = irandom(8) - 4;
    aa.yspeed = -5;
    aa.value = 5;
    alarm[0] = 5;
}
else if (action == 27)
{
    shake = 0;
    alarm[0] = 120;
}
else if (action <= 29)
{
    with (obj_chelshia)
        event_perform(ev_other, ev_user8);
    
    image_index -= 1;
    alarm[0] = 2;
}
else if (action == 30)
{
    image_index = 24;
    alarm[2] = 15;
    alarm[0] = 15;
}
else if (action == 31)
{
    with (obj_chelshia)
    {
        if (x < obj_boss_snakeDead.x)
            dire = 1;
        else
            dire = 0;
    }
    
    scr_facePlayer();
    
    alarm[0] = 5;
    action += 2;   
}
// Action 32 and 33 are cutscene related
else if (action == 34)
{
    alarm[2] = -1;
    image_index = 26;
    alarm[0] = 10;
}
else if (action == 35)
{
    scr_supersound(21, global.v_snd, 0);
    visible = false;
    aa = instance_create(x, y, obj_ef_fade);
    aa.sprite_index = sprite_index;
    aa.image_speed = 0;
    aa.image_index = 27;
    aa.xscale = (dire * 2) - 1;
    aa.vspeed = -7;
    aa.gravity = 0.4;
    aa.hspeed = ((dire * 2) - 1) * -3;
    aa.transrate = 0;
    alarm[0] = 60;
}
else if (action == 36)
{
    scr_unlockAch(1);
    aa = instance_create(x, y, obj_winCont);
    aa.labSkip = 1;
}
