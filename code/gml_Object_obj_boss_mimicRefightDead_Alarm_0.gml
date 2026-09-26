action += 1;

if (action == 1)
{
    shake = 1;
    alarm[0] = 5;
}

if (action <= 26)
{
    aa = instance_create((x + irandom(4)) - 2, ((y - 24) + irandom(4)) - 2, obj_treasure);
    aa.xspeed = floor(cos((action * 30 * pi) / 180) * 4);
    aa.yspeed = -6;
    aa.value = 50;
    aa = instance_create((x + irandom(4)) - 2, ((y - 24) + irandom(4)) - 2, obj_treasure);
    aa.xspeed = irandom(8) - 4;
    aa.yspeed = -5;
    aa.value = 5;
    aa = instance_create((x + irandom(4)) - 2, ((y - 24) + irandom(4)) - 2, obj_treasure);
    aa.xspeed = irandom(8) - 4;
    aa.yspeed = -5;
    aa.value = 5;
    alarm[0] = 5;
}
else if (action == 27)
{
    shake = 0;
    alarm[0] = 180;
}
else
{
    scr_unlockAch(4);
    event_perform_object(obj_boss_harpyRefightDead, ev_other, ev_user12);
    ap_location_miniboss(obj_boss_mimicRefight, undefined);
}
