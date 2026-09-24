var scrFF = "file" + string(argument0);

return; // The mod handles file loading manually.

ini_open("chimera.dat");

for (var scrI = 0; scrI <= global.total_levels; scrI += 1)
{
    var scrSS = string(scrI);
    global.level_complete[scrI] = scr_IO(real(ini_read_string(scrFF, "c" + scrSS, "0")));
    global.level_noDeath[scrI] = scr_IO(real(ini_read_string(scrFF, "ndt" + scrSS, "0")));
    global.level_noHit[scrI] = scr_IO(real(ini_read_string(scrFF, "nht" + scrSS, "0")));
    global.level_berserk[scrI] = scr_IO(real(ini_read_string(scrFF, "bsk" + scrSS, "0")));
    global.level_rank[scrI] = scr_range(real(ini_read_string(scrFF, "r" + scrSS, "0")), 0, 4);
    global.level_topMoney[scrI] = real(ini_read_string(scrFF, "tm" + scrSS, "0"));
    global.level_topTime[scrI] = real(ini_read_string(scrFF, "tt" + scrSS, "-1"));
    
    if (global.level_hasFood[scrI])
    {
        global.level_food[scrI] = scr_IO(real(ini_read_string(scrFF, "fd" + scrSS, "0")));
        global.level_rockPile[scrI] = scr_IO(real(ini_read_string(scrFF, "rk" + scrSS, "0")));
    }
    
    for (var scrJ = 1; scrJ <= global.level_hasFairies[scrI]; scrJ += 1)
        global.level_fairy[scrI, scrJ] = scr_IO(real(ini_read_string(scrFF, "ff" + scrSS + "_" + string(scrJ), "0")));
}

for (var scrI = 0; scrI <= global.totalTriggers; scrI += 1)
    global.trigger[scrI] = real(ini_read_string(scrFF, "trg" + string(scrI), "0"));

for (var scrI = 0; scrI <= global.total_weapons; scrI += 1)
{
    global.wep_obtained[scrI] = scr_IO(real(ini_read_string(scrFF, "wep" + string(scrI), "0")));
    global.wep_active[scrI] = scr_IO(real(ini_read_string(scrFF, "wAct" + string(scrI), "1")));
}

for (var scrI = 1; scrI <= global.total_enemies; scrI += 1)
{
    global.nme_obtained[scrI] = scr_IO(real(ini_read_string(scrFF, "loO" + string(scrI), "0")));
    global.nme_new[scrI] = scr_IO(real(ini_read_string(scrFF, "loN" + string(scrI), "0")));
}

global.costume_index = scr_range(real(ini_read_string(scrFF, "cstm", "1")), 1, global.total_costumes);

for (var scrI = 1; scrI <= (global.total_costumes - global.total_dlcCostumes); scrI += 1)
    global.costume_obtained[scrI] = scr_IO(real(ini_read_string(scrFF, "cst" + string(scrI), "0")));

global.costume_obtained[5] = global.halloweenComplete;
global.costume_obtained[6] = global.DLCnurse;
global.stat_treasure = real(ini_read_string(scrFF, "st_tr", "0"));
global.stat_enemies = real(ini_read_string(scrFF, "st_en", "0"));
global.stat_levels = real(ini_read_string(scrFF, "st_lv", "0"));
global.stat_food = real(ini_read_string(scrFF, "st_fo", "0"));
global.stat_deaths = real(ini_read_string(scrFF, "st_de", "0"));
global.maxHP = 8 + (scr_getFoodEaten() * 2);
global.HP = global.maxHP;
global.wep_active[0] = 1;
global.wep_obtained[1] = 1;
global.wep_active[1] = 1;
global.costume_obtained[1] = 1;

if (!global.costume_obtained[global.costume_index])
    global.costume_index = 1;

global.level_complete[9] = 0;
global.level_complete[13] = 0;
global.level_complete[16] = 0;
global.trigger[13] = 0;
ini_close();
