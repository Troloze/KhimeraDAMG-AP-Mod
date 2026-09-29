if (!throwing)
{
    throwing = 1;
    scr_supersound(11, global.v_snd, 0);
    if (!thru) {
        aa = instance_create(x, y, obj_nme_witchPotion);
        aa.gravity = 0.4;
        aa.vspeed = -2;
        aa.hspeed = (2 * dire) - 1;
    } else {
        aa = instance_create(x, y, obj_food);
        aa.hspeed = (2 * dire) - 1;
    }
    
    alarm[0] = 10;
}
else
{
    throwing = 0;
    alarm[0] = 20;
}
