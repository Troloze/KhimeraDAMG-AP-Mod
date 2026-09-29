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
    image_index = 25;
    alarm[0] = 30;
}
else if (action == 28)
{
    image_index = 26;
    alarm[0] = 3;
}
else if (action == 29)
{
    image_index = 25;
    alarm[0] = 15;
}
else if (action == 30)
{
    looking = 1;
    alarm[0] = 60;
}
else
{
    scr_unlockAch(2);
    event_perform(ev_other, ev_user12);
    ap_location_miniboss(obj_boss_harpyRefight, undefined);
}
