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
    alarm[0] = 60;
}
else if (action <= 87)
{
    visible = !visible;
    alarm[0] = 1;
}
else
{
    instance_destroy();
    
    with (obj_chelshia)
        canpause = 1;
    
    with (block1)
        instance_destroy();
    
    with (block2)
        instance_destroy();
    
    instance_create(x, y + 16, obj_food);
    
    with (obj_drawcont)
    {
        cantimer = 1;
        drawBoss = 0;
        event_perform(ev_other, ev_user0);
    }
    
    ap_location_miniboss(obj_boss_snakeRefight, undefined);
}
