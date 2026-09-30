action += 1;

if (action == 1)
{
    shake = 1;
    image_index = 4;
    alarm[0] = 5;
}

if (action <= 26)
{
    if ((action % 5) == 0)
        image_index += 1;
    
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
    alarm[0] = 120;
}
else if (action == 28)
{
    with (obj_chelshia)
    {
        event_perform(ev_other, ev_user8);
        
        if (x < obj_boss_pizzaDead.x)
            dire = 1;
        else
            dire = 0;
    }
    
    alarm[0] = 60;
}
else
{
    scr_unlockAch(3);
    event_perform_object(obj_boss_harpyRefightDead, ev_other, ev_user12);
    ap_location_miniboss(obj_boss_pizzaRefight, undefined);
}
