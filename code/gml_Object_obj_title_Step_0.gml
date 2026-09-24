
if (view == "main") {
    if (global.ap_state_initialized) {
        choice[1] = lMesStart[lang];
        toolTip[1] = lMesStartTool[lang];
        if (action[1] == -1 && selected == 1) {
            // Just connected, let's update the tooltip.
            toolTipStr = "";
            toolTipLen = string_length(toolTip[toolTipIndex]);
            toolTipCurrent = 0;
            alarm[2] = 2;
        }
        action[1] = 11;
    } else {
        choice[1] = lMesDisco[lang];
        toolTip[1] = lMesDiscoTool[lang];
        action[1] = -1;
    }
}

if (choiceDisplace > 0)
    choiceDisplace -= 16;

if (cursorHeight < 4)
    cursorHeight += 1;

prevSelected = selected;

if (global.Dpress && canmove && !pressAPrompt)
{
    scr_supersound(29, global.v_snd, 0);
    selected += 1;
    
    if (selected > choices)
        selected = 1;
}
else if (global.Upress && canmove && !pressAPrompt)
{
    scr_supersound(29, global.v_snd, 0);
    selected -= 1;
    
    if (selected < 1)
        selected = choices;
}

if (prevSelected != selected)
{
    cursorHeight = 0;
    toolTipIndex = selected;
    toolTipStr = "";
    toolTipLen = string_length(toolTip[toolTipIndex]);
    toolTipCurrent = 0;
    alarm[2] = 2;
}

if (global.Apress && canmove)
{
    if (pressAPrompt)
    {
        pressAPrompt = 0;
        scr_supersound(26, global.v_snd, 0);
        drawMenu = 1;
        event_perform(ev_other, ev_user0);
    }
    else
    {
        if (action[selected] != -1) event_perform(ev_other, action[selected]);
        else scr_supersound(23, global.v_snd, 0);
    }
}

if (global.Spress && canmove && Scommand != -1)
{
    event_perform(ev_other, Scommand);
    scr_supersound(23, global.v_snd, 0);
}

if (keyboard_check_pressed(vk_escape))
    game_end();
