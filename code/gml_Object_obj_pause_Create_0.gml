event_perform(ev_other, ev_user1);
height = 0;
heightRate = 12;
heightMax = (view_hview - 12) / 2;
headerW = sprite_get_width(spr_pauseHeader);
headerX = 0;
headerRate = 1;
global.gamePercent = scr_getCompletion();
canmove = 0;
fairies = scr_stringZeroes(scr_getFairiesRescued(), 2) + "/" + scr_stringZeroes(scr_getTotalFairies(), 2);
lores = scr_stringZeroes(scr_getLoreCollected(), 2) + "/" + scr_stringZeroes(global.total_enemies, 2);
Aranks = scr_stringZeroes(scr_getARanks(), 2) + "/" + scr_stringZeroes(scr_getTotalARanks(), 2);
clears = scr_stringZeroes(scr_getStagesClear(), 2) + "/" + scr_stringZeroes(scr_getTotalARanks(), 2);
berserks = scr_stringZeroes(scr_getBerserks(), 2) + "/" + scr_stringZeroes(scr_getTotalARanks(), 2);
noDeaths = scr_stringZeroes(scr_getNoDeaths(), 2) + "/" + scr_stringZeroes(scr_getTotalARanks(), 2);
percent = string(global.gamePercent) + "%";
perfect = global.gamePercent >= 100;
chelImg = 30;
alarm[1] = 45;
costumeSpr[1] = 320;
costumeSpr[2] = 300;
costumeSpr[3] = 304;
costumeSpr[4] = 308;
costumeSpr[5] = 316;
costumeSpr[6] = 312;
selected = 1;
choices = 6;
choice[1] = "UNPAUSE";
action[1] = 12;
choiceActive[1] = 1;
choice[2] = "OPTIONS";
action[2] = 16;
choiceActive[2] = 1;
choice[3] = "CONTROLS";
action[3] = 17;
choiceActive[3] = 1;
choice[4] = "ACHIEVEMENTS";
action[4] = 15;
choiceActive[4] = 0;
choice[5] = "EXIT STAGE";
action[5] = 13;
choiceActive[5] = 1;
choice[6] = "QUIT TO TITLE";
action[6] = 14;
choiceActive[6] = 1;

if (global.game_mode == 1 || global.current_level == 17)
    choice[6] = "RETIRE";

if (global.game_mode == 1 || room == rm_map || global.current_level == 17)
    choiceActive[5] = 0;

wepChoices = 10;
wepSelected = -1;

for (i = 1; i <= wepChoices; i += 1)
    wepChoice[i] = 0;

wepChoice[1] = 1;

if (global.wep_obtained[2])
    wepChoice[2] = 2;

if (global.wep_obtained[3])
    wepChoice[3] = 3;

if (global.wep_obtained[4])
    wepChoice[4] = 4;

if (global.wep_obtained[5])
    wepChoice[5] = 5;

if (global.wep_obtained[10])
    wepChoice[6] = 10;

if (global.wep_obtained[7])
    wepChoice[7] = 7;

if (global.wep_obtained[8])
    wepChoice[8] = 8;

if (global.wep_obtained[6])
    wepChoice[9] = 6;

if (global.wep_obtained[9])
    wepChoice[10] = 9;

if (wepChoice[6] != 10 && global.trigger[2] >= 1 && global.trigger[2] <= 10)
    wepChoice[6] = -global.trigger[2];

costumeChoices = global.total_costumes;
costumeSelected = -1;

for (i = 1; i <= costumeChoices; i += 1)
    costumeChoice[i] = global.costume_obtained[i] * i;

for (i = 1; i <= 4; i += 1)
    foodImg[i] = 0;

if (global.level_food[1])
    foodImg[1] = 1;

if (global.level_food[2])
    foodImg[2] = 2;

if (global.level_food[3])
    foodImg[3] = 3;

if (global.level_food[4])
    foodImg[4] = 4;

menuColor[0] = 8421504;
menuColor[1] = 16777215;
