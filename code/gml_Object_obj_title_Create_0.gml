lang = global.gameLanguage;
gameType[0] = "STEAM";
gameType[1] = "PC";
steamMessage[0, 0] = "CANNOT CONNECT TO STEAM";
steamMessage[1, 0] = "CONNECTED TO STEAM";
startPrompt[0] = "PRESS [" + scr_keyname(global.A) + "] TO START";
lMesStart[0] = "START GAME";
lMesStartTool[0] = "START PLAYING THE GAME!";
lMesDisco[0] = "START GAME";
lMesDiscoTool[0] = "CONNECT TO ARCHIPELAGO IN ORDER TO START.";
lMesOptions[0] = "OPTIONS";
lMesOptionsTool[0] = "CONFIGURE YOUR KHIMERA EXPERIENCE!";
lMesExtra[0] = "EXTRAS";
lMesExtraTool[0] = "PLAY EXTRA MODES AND VIEW ADDITIONAL CONTENT!";
lMesQuit[0] = "QUIT";
lMesQuitTool[0] = "ENDS THE GAME!";
lMesAch[0] = "ACHIEVEMENTS";
lMesAchTool[0] = "SEE HOW MANY ACHIEVEMENTS YOU'VE UNLOCKED!";
lMesCredits[0] = "CREDITS";
lMesCreditsTool[0] = "WHO MADE THIS GAME?";
lMesRace[0] = "RACE MODE";
lMesRaceTool[0] = "A TIMED MODE WHERE YOU GO FROM START TO FINISH!";
lMesBerserk[0] = "BERSERK RACE";
lMesBerserkTool[0] = "RACE AGAINST THE CLOCK WITH LIMITED HEALTH!";
lMesHarvest[0] = "HARVEST EVENT";
lMesHarvestTool[0] = "A SPECIAL EPILOGUE CHAPTER JUST FOR YOU!";
lMesBack[0] = "BACK";
lMesBackTool[0] = "RETURN TO PREVIOUS MENU!";
lMesControls[0] = "CONTROL SETUP";
lMesControlsTool[0] = "CONFIGURE YOUR KEYBOARD/CONTROLLER INPUT";
lMesGameSettings[0] = "SETTINGS";
lMesGameSettingsTool[0] = "GENERAL GAMEPLAY SETTINGS!";
lMesLang[0] = "LANGUAGE";
lMesLangTool[0] = "CHANGE GAME LANGUAGE!";
lMesSTest[0] = "SOUND TEST";
lMesSTestTool[0] = "LISTEN TO SONGS YOU'VE HEARD IN-GAME!";
steamMessage[0, 1] = "IMPOSIBLE CONECTARSE A STEAM";
steamMessage[1, 1] = "CONECTADO CON ÉXITO A STEAM";
startPrompt[1] = "PULSA [" + scr_keyname(global.A) + "] PARA EMPEZAR";
lMesStart[1] = "INICIAR JUEGO";
lMesStartTool[1] = "¡EMPIEZA A JUGAR!";
lMesDisco[1] = "DESCONECTADO";
lMesDiscoTool[1] = "CONÉCTATE AL ARCHIPELAGO PARA EMPEZAR.";
lMesOptions[1] = "OPCIONES";
lMesOptionsTool[1] = "¡CONFIGURA TU EXPERIENCIA KHIMERA!";
lMesExtra[1] = "EXTRAS";
lMesExtraTool[1] = "¡MODOS EXTRA Y CONTENIDO ADICIONAL!";
lMesQuit[1] = "SALIR";
lMesQuitTool[1] = "¡CIERRA EL JUEGO!";
lMesAch[1] = "LOGROS";
lMesAchTool[1] = "¡MIRA LOS LOGROS QUE HAYAS DESBLOQUEADO!";
lMesCredits[1] = "CRÉDITOS";
lMesCreditsTool[1] = "¿QUIÉN HIZO ESTE JUEGO?";
lMesRace[1] = "MODO CARRERA";
lMesRaceTool[1] = "MODO CRONOMETRADO QUE ABARCA EL JUEGO DE PRINCIPIO A FIN";
lMesBerserk[1] = "CARRERA BERSERK";
lMesBerserkTool[1] = "¡COMPITE CONTRA EL CRONÓMETRO CON SALUD LIMITADA!";
lMesHarvest[1] = "COSECHA KHIMERA";
lMesHarvestTool[1] = "¡UN EPÍLOGO ESPECIAL SOLO PARA TI!";
lMesBack[1] = "ATRÁS";
lMesBackTool[1] = "¡VUELVE AL MENÚ ANTERIOR!";
lMesControls[1] = "AJUSTES DE CONTROLES";
lMesControlsTool[1] = "CONFIGURA LOS BOTONES DE TU MANDO/TECLADO";
lMesGameSettings[1] = "OPCIONES";
lMesGameSettingsTool[1] = "¡AJUSTES RELATIVOS A LA JUGABILIDAD!";
lMesLang[1] = "IDIOMA";
lMesLangTool[1] = "¡CÁMBIA EL IDIOMA DEL JUEGO!";
lMesSTest[1] = "SOUND TEST";
lMesSTestTool[1] = "";

with (obj_halloweenCont)
    instance_destroy();

view = "";
choices = 1;
choice[1] = "";
action[1] = "";
choiceW[1] = 1;
choiceDisplace = 64;
Scommand = -1;
cursorHeight = 0;
cursorColor = make_color_rgb(202, 141, 30);
disabledCursorColor = make_color_rgb(162, 168, 172);
toolTipStr = "";
toolTipLen = 0;
toolTipCurrent = 0;
toolTipIndex = 0;
pressAPrompt = 0;
alarm[3] = 1;
drawPrompt = 0;
drawMisc = 0;
global.berserkRace = 0;

if (global.firstTitle)
{
    global.firstTitle = 0;
    alarm[0] = 5;
    drawDisplace = room_width;
    drawMenu = 0;
    canmove = 0;
}
else
{
    drawMenu = 1;
    drawMisc = 1;
    canmove = 1;
    drawDisplace = 0;
}

scr_steamCheck();

if (global.game_version == 0)
{
    if (steam_initialised())
        global.DLCnurse = steam_user_owns_dlc(485280);
}
else if (global.game_version == 1)
{
    global.DLCnurse = 1;
}

archipelago_spin = 360;

archipelago_color[0] = make_color_rgb(201, 118, 130)
archipelago_color[1] = make_color_rgb(117, 194, 117)
archipelago_color[2] = make_color_rgb(202, 148, 194)
archipelago_color[3] = make_color_rgb(217, 160, 125)
archipelago_color[4] = make_color_rgb(118, 126, 189)
archipelago_color[5] = make_color_rgb(238, 227, 145)

event_perform(ev_other, ev_user0);
