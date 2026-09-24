scr_supersound(29, global.v_snd, 0);
choices = 3;
selected = 1;
Scommand = 10;
choiceDisplace = 64;
cursorHeight = 0;
choice[1] = lMesControls[lang];
toolTip[1] = lMesControlsTool[lang];
action[1] = 15;
choice[2] = lMesGameSettings[lang];
toolTip[2] = lMesGameSettingsTool[lang];
action[2] = 12;
choice[3] = lMesBack[lang];
toolTip[3] = lMesBackTool[lang];
action[3] = 10;

if (global.gameLanguage == 1)
{
    choice[1] = "CONTROLES";
    toolTip[1] = "CONFIGURAR TECLAS/BOTONES DEL MANDO";
    choice[2] = "OPCIONES DEL JUEGO";
    toolTip[2] = "¡AJUSTES RELATIVOS A LA JUGABILIDAD!";
    choice[3] = "IDIOMA";
    toolTip[3] = "¡CAMBIA EL IDIOMA DEL JUEGO!";
    choice[4] = "ATRÁS";
    toolTip[4] = "¡VUELVE AL MENÚ ANTERIOR!";
}

draw_set_font(fnt_score);

for (i = 1; i <= choices; i += 1)
    choiceW[i] = string_width(choice[i]);

view = "options"; 
cursorHeight = 0;
toolTipIndex = selected;
toolTipStr = "";
toolTipLen = string_length(toolTip[toolTipIndex]);
toolTipCurrent = 0;
alarm[2] = 2;
