action += 1;

if (action == 1)
{
    visible = true;
    scr_supersound(26, global.v_snd, 0);
    alarm[0] = 4;
}
else if (action <= 5)
{
    image_index += 1;
    alarm[0] = 4;
    
    if (action == 5)
        alarm[0] = 80;
}
else
{
    if (global.AP_DEBUG) scr_roomtrans(4, 0.025);
    else scr_roomtrans(-2, 0.025);
}
