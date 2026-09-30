action += 1;

if (action == 1)
{
    yspeed = -3;
    scr_supersound(9, global.v_snd, 0);
    idling = 0;
    atkImg = 21;
    alarm[8] = 30;
}
else if (action == 2)
{
    yspeed = -3;
    scr_supersound(9, global.v_snd, 0);
    idling = 0;
    atkImg = 21;
    alarm[8] = 60;
}
else if (action == 3)
{
    alarm[8] = 5;
}
else if (action == 4)
{
    dire = 0;
    alarm[8] = 5;
}
else if (action == 5)
{
    global.bossHP = HP;
    scr_playmusic(2, global.v_bgm, 1);
    obj_drawcont.drawBoss = 1;
    obj_drawcont.drawBossHP = 0;
    cansprite = 0;
    atkImg = 16;
    alarm[8] = 5;
}
else if (action <= 6)
{
    idling = 0;
    atkImg = 4;
    alarm[3] = 2;
    alarm[8] = 45;
}
else
{
    with (obj_chelshia)
        canmove = 1;
    
    with (obj_drawcont)
        cantimer = 1;
    
    action = 0;
    canhit = 1;
    candamage = 1;
    alarm[0] = 30;
}
