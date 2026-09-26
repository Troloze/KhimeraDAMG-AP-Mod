action += 1;

if (action == 1)
{
    totalEx = 24;
    currentEx = 0;
    alarm[0] = 1;
}
else if (action == 2)
{
    currentEx += 1;
    
    if (currentEx == totalEx)
    {
        scr_supersound(22, global.v_snd * 0.2, 0);
        aa = instance_create(x, y, obj_ef_screenShake);
        aa.alarm[0] = 60;
        alarm[1] = 120;
    }
    else
    {
        var exRatio = ((totalEx - currentEx) / totalEx)
        var volume = 0.0 + 1 * exRatio * exRatio;
        var pitch = 0.96 + 0.04 * (1-((1-exRatio) * (1-exRatio)));
        scr_supersound(12, global.v_snd * volume, 0);
        audio_sound_pitch(12, pitch);
        if (currentEx == (totalEx - 1))
            alarm[0] = 40;
        else
            alarm[0] = 6;
        
        action -= 1;
    }
}
