// Reload information
issue_update = 0;

fairies = scr_stringZeroes(scr_getFairiesRescued(), 2) + "/" + scr_stringZeroes(scr_getTotalFairies(), 2);
lores = scr_stringZeroes(scr_getLoreCollected(), 2) + "/" + scr_stringZeroes(global.total_enemies, 2);
Aranks = scr_stringZeroes(scr_getARanks(), 2) + "/" + scr_stringZeroes(scr_getTotalARanks(), 2);
clears = scr_stringZeroes(scr_getStagesClear(), 2) + "/" + scr_stringZeroes(scr_getTotalARanks(), 2);
berserks = scr_stringZeroes(scr_getBerserks(), 2) + "/" + scr_stringZeroes(scr_getTotalARanks(), 2);
noDeaths = scr_stringZeroes(scr_getNoDeaths(), 2) + "/" + scr_stringZeroes(scr_getTotalARanks(), 2);
percent = string(global.gamePercent) + "%";
perfect = global.gamePercent >= 100;

for (i = 1; i <= wepChoices; i += 1)
    wepChoice[i] = 0;

wepChoice[1] = 1;

if (global.ap_item_wep_obtained[2])
    wepChoice[2] = 2;

if (global.ap_item_wep_obtained[3])
    wepChoice[3] = 3;

if (global.ap_item_wep_obtained[4])
    wepChoice[4] = 4;

if (global.ap_item_wep_obtained[5])
    wepChoice[5] = 5;

if (global.ap_item_wep_obtained[10])
    wepChoice[6] = 10;

if (global.ap_item_wep_obtained[7])
    wepChoice[7] = 7;

if (global.ap_item_wep_obtained[8])
    wepChoice[8] = 8;

if (global.ap_item_wep_obtained[6])
    wepChoice[9] = 6;

if (global.ap_item_wep_obtained[9])
    wepChoice[10] = 9;

if (wepChoice[6] != 10 && global.trigger[2] >= 1 && global.trigger[2] <= 10)
    wepChoice[6] = -global.trigger[2];

costumeChoices = global.total_costumes;
costumeSelected = -1;

for (i = 1; i <= costumeChoices; i += 1)
    costumeChoice[i] = global.costume_obtained[i] * i;

for (i = 1; i <= 4; i += 1)
    foodImg[i] = 0;

if (global.ap_item_level_food[1])
    foodImg[1] = 1;

if (global.ap_item_level_food[2])
    foodImg[2] = 2;

if (global.ap_item_level_food[3])
    foodImg[3] = 3;

if (global.ap_item_level_food[4])
    foodImg[4] = 4;
