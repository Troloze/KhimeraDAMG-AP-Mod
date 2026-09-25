with (obj_drawcont)
    showF1Prompt = 0;

event_perform(ev_other, ev_user1);
height = 0;
heightRate = 12;
heightMax = sprite_height / 2;
canmove = 0;
page = 1;
pages = 2;
totalMoves = 8;
moveText[1] = "-" + scr_keyname(global.S) + "-#REG PUNCH";
moveImg[1] = 1;
moveText[2] = "-" + scr_keyname(global.D) + "+" + scr_keyname(global.S) + "-#EARTH BREAKER";
moveImg[2] = 2;

if (global.dashType == 1)
    str = "-" + scr_keyname(global.U) + "+" + scr_keyname(global.S) + "-#OR -" + scr_keyname(global.E) + "-";
else if (global.dashType == 2)
    str = scr_keyname(global.L) + "/" + scr_keyname(global.R) + " X2#OR -" + scr_keyname(global.E) + "-";
else
    str = "-" + scr_keyname(global.E) + "-";

moveText[3] = str + "#DASH PUNCH";
moveImg[3] = 3;
moveText[4] = "-" + scr_keyname(global.D) + "+" + scr_keyname(global.S) + " IN AIR-#POGO-STRIKE";
moveImg[4] = 4;
moveText[5] = "-" + scr_keyname(global.W) + "-#STRONG PUNCH";
moveImg[5] = 5;

if (global.ap_item_wep_obtained[3])
{
    moveText[6] = "-HOLD " + scr_keyname(global.S) + "-#SAUCY SHOT";
    moveImg[6] = 6;
}
else
{
    moveText[6] = "-----";
    moveImg[6] = 0;
}

if (global.ap_item_wep_obtained[4])
{
    moveText[7] = "-" + scr_keyname(global.D) + "+" + scr_keyname(global.W) + "-#TREASURE BOX";
    moveImg[7] = 7;
}
else
{
    moveText[7] = "-----";
    moveImg[7] = 0;
}

if (global.ap_item_wep_obtained[5])
{
    moveText[8] = "-" + scr_keyname(global.U) + "+" + scr_keyname(global.W) + "-#MERMAID ANCHOR";
    moveImg[8] = 8;
}
else
{
    moveText[8] = "-----";
    moveImg[8] = 0;
}
