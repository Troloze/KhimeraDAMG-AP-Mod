choices = 4;
selected = 1;
Scommand = -1;
choiceDisplace = 64;
cursorHeight = 0;
choice[1] = lMesStart[lang];
toolTip[1] = lMesStartTool[lang];
action[1] = 11;
choice[2] = lMesOptions[lang];
toolTip[2] = lMesOptionsTool[lang];
action[2] = 19;
choice[3] = lMesCredits[lang];
toolTip[3] = lMesCreditsTool[lang];
action[3] = 22;
choice[4] = lMesQuit[lang];
toolTip[4] = lMesQuitTool[lang];
action[4] = 14;
draw_set_font(fnt_score);

for (i = 1; i <= choices; i += 1)
    choiceW[i] = string_width(choice[i]);

view = "main";
cursorHeight = 0;
toolTipIndex = selected;
toolTipStr = "";
toolTipLen = string_length(toolTip[toolTipIndex]);
toolTipCurrent = 0;
alarm[2] = 2;
