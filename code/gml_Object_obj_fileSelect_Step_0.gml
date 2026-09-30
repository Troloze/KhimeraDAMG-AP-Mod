if (global.Dpress && canmove && !confirmDelete)
{
    scr_supersound(29, global.v_snd, 0);
    selected += 1;
    
    if (selected > choices)
        selected = 1;
}
else if (global.Upress && canmove && !confirmDelete)
{
    scr_supersound(29, global.v_snd, 0);
    selected -= 1;
    
    if (selected < 1)
        selected = choices;
}

if (global.Apress && canmove)
{
    if (selected == 4)
    {
        deleteMode = !deleteMode;
        confirmDelete = 0;
        
        if (deleteMode)
            scr_supersound(17, global.v_snd, 0);
        else
            scr_supersound(7, global.v_snd, 0);
    }
    else if (confirmDelete)
    {
        scr_deleteGame(selected);
        deleteMode = 0;
        confirmDelete = 0;
        scr_supersound(39, global.v_snd, 0);
        aa = instance_create(x, y, obj_ef_screenFade);
        aa.trans = 3;
        aa.transrate = -0.5;
        event_perform(ev_other, ev_user0);
    }
    else if (deleteMode)
    {
        confirmDelete = 1;
    }
    else
    {
        scr_loadGame(selected);
        global.current_file = selected;
        event_perform(ev_other, ev_user1);
        

        global.cutsceneIndex = 0;
        destination = 4;   

        
        blinking = 1;
        alarm[0] = 15;
        canmove = 0;
        scr_stopmusic();
        scr_supersound(17, global.v_snd, 0);
    }
}

if ((global.Spress || keyboard_check_pressed(vk_escape)) && canmove)
{
    if (deleteMode)
    {
        scr_supersound(7, global.v_snd, 0);
        confirmDelete = 0;
        deleteMode = 0;
    }
    else
    {
        canmove = 0;
        scr_fademusic();
        scr_roomtrans(2, 0.05);
    }
}

blink = !blink && blinking;
yRot = (yRot + yRotRate) % 360;

if (confirmDelete)
    bombImg = explodeImg;
else
    bombImg = 0;
