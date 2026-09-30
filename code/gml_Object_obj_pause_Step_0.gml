if (issue_update) event_perform(ev_other, ev_user15); // Updates stats.

height += heightRate;

if (heightRate > 0 && height >= heightMax)
{
    height = heightMax;
    heightRate = 0;
    canmove = 1;
}

if (heightRate < 0 && height <= 0)
{
    event_perform(ev_other, ev_user0);
    instance_destroy();
}

if (global.Upress && canmove)
{
    scr_supersound(29, global.v_snd, 0);
    
    if (selected != -1)
    {
        selected -= 1;
        
        if (selected < 1)
        {
            selected = -1;
            costumeSelected = 1;
        }
    }
    else if (wepSelected != -1)
    {
        wepSelected = -1;
        selected = choices;
    }
    else if (costumeSelected != -1)
    {
        wepSelected = costumeSelected;
        
        if (wepSelected > 10)
            wepSelected = 10;
        
        costumeSelected = -1;
    }
}
else if (global.Dpress && canmove)
{
    scr_supersound(29, global.v_snd, 0);
    
    if (selected != -1)
    {
        selected += 1;
        
        if (selected > choices)
        {
            selected = -1;
            wepSelected = 1;
        }
    }
    else if (wepSelected != -1)
    {
        costumeSelected = 1;
        wepSelected = -1;
    }
    else if (costumeSelected != -1)
    {
        selected = 1;
        costumeSelected = -1;
    }
}
else if (global.Rpress && canmove)
{
    if (wepSelected != -1)
    {
        scr_supersound(29, global.v_snd, 0);
        wepSelected += 1;
        
        if (wepSelected > 10)
            wepSelected = 1;
    }
    else if (costumeSelected != -1)
    {
        scr_supersound(29, global.v_snd, 0);
        costumeSelected += 1;
        
        if (costumeSelected > costumeChoices)
            costumeSelected = 1;
    }
}
else if (global.Lpress && canmove)
{
    if (wepSelected != -1)
    {
        wepSelected -= 1;
        scr_supersound(29, global.v_snd, 0);
        
        if (wepSelected < 1)
            wepSelected = 10;
    }
    else if (costumeSelected != -1)
    {
        scr_supersound(29, global.v_snd, 0);
        costumeSelected -= 1;
        
        if (costumeSelected < 1)
            costumeSelected = costumeChoices;
    }
}
else if (global.Apress && canmove)
{
    if (selected != -1)
    {
        if (choiceActive[selected])
            event_perform(ev_other, action[selected]);
    }
    else if (wepSelected != -1)
    {
        if (wepChoice[wepSelected] > 1)
        {
            global.wep_active[wepChoice[wepSelected]] = !global.wep_active[wepChoice[wepSelected]];
            scr_supersound(23, global.v_snd, 0);
        }
    }
    else if (costumeSelected != -1)
    {
        if (costumeChoice[costumeSelected] != 0 && costumeChoice[costumeSelected] != global.costume_index && !((global.costume_index == 4 || costumeChoice[costumeSelected] == 4) && room != rm_map))
        {
            scr_supersound(31, global.v_snd, 0);
            global.costume_index = costumeChoice[costumeSelected];
            
            if (global.game_mode == 1)
            {
                global.raceCostume = costumeChoice[costumeSelected];
                scr_saveRaceCostume();
            }
        }
        else
        {
            scr_supersound(16, global.v_snd, 0);
        }
    }
}
else if ((global.Spress || global.Qpress || keyboard_check_pressed(vk_escape)) && canmove)
{
    event_perform(ev_other, ev_user2);
}
