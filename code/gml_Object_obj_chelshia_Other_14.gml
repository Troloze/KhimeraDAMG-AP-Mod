wingSpr = 325;

if (global.costume_index == 2)
{
    sprIdle[0] = 301;
    sprIdle[1] = 300;
    sprRun[0] = 303;
    sprRun[1] = 302;
}
else if (global.costume_index == 3)
{
    sprIdle[0] = 305;
    sprIdle[1] = 304;
    sprRun[0] = 307;
    sprRun[1] = 306;
}
else if (global.costume_index == 4)
{
    sprIdle[0] = 309;
    sprIdle[1] = 308;
    sprRun[0] = 311;
    sprRun[1] = 310;
    wingSpr = 326;
}
else if (global.costume_index == 5)
{
    sprIdle[0] = 317;
    sprIdle[1] = 316;
    sprRun[0] = 319;
    sprRun[1] = 318;
}
else if (global.costume_index == 6)
{
    sprIdle[0] = 313;
    sprIdle[1] = 312;
    sprRun[0] = 315;
    sprRun[1] = 314;
}
else
{
    sprIdle[0] = 321;
    sprIdle[1] = 320;
    sprRun[0] = 323;
    sprRun[1] = 322;
}

wepWing = global.ap_item_wep_obtained[2] && global.wep_active[2];
wepChest = global.ap_item_wep_obtained[4] && global.wep_active[4];
wepAnchor = global.ap_item_wep_obtained[5] && global.wep_active[5];
wepShot = global.ap_item_wep_obtained[3] && global.wep_active[3];
wepEye = global.ap_item_wep_obtained[6] && global.wep_active[6];
wepFire = global.ap_item_wep_obtained[8] && global.wep_active[8];
wepGiant = global.ap_item_wep_obtained[7] && global.wep_active[7];
wepFeet = global.ap_item_wep_obtained[9] && global.wep_active[9];
berzerkMode = global.costume_index == 4;
