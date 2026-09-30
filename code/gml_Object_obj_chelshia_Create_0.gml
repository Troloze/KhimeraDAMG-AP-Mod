st_grav = 0.4;
st_grav_chest = 0.6;
st_wspd = 3;
st_maxFall = 7;
st_jmp = -7;
st_dspd = 6;
st_dlength = 15;
st_dbuffer = 10;
Abuffer = 0;
Sbuffer = 0;
Wbuffer = 0;
Ebuffer = 0;
fades = 0;
punching = 0;
canhit = 1;
boosting = 0;
canJumpRelease = 1;
dmgEvent = 0;
canmove = 1;
cansprite = 1;
dashing = 0;
dashAtk = 0;
canDashAtk = 1;
downAtk = 0;
placefree = 0;
cangrav = 1;
dashButton = 0;
blinking = 0;
fallDeath = 0;
xspeed = 0;
yspeed = 0;
grav = 0;
dire = 1;
flashing = 0;
flash = 0;
treasureBuffer = 0;
chestMode = 0;
bounceTally = 0;
wingPower = 0;
airJumpBufferMax = 8;
airJumpBuffer = 0;

if (instance_place(x, y + 1, obj_block) != -4)
{
    airJumpBuffer = airJumpBufferMax;
    wingPower = 1;
}

creditsMode = room == rm_credits;
hasScuttle = 0;
scuttleImg = 0;
canpause = 0;
alarm[10] = 5;
event = 0;
action = 0;
charge = 0;
chargeImg = 0;
maxCharge = 90;
chargeRot = 0;
wingImg = -1;
event_perform(ev_other, ev_user4);
idleImg = 0;
fallImg = 6;
dashImg = 25;
winning = 0;
winImg = 30;
alarm[2] = 10;
alarm[9] = 30;
waterMode = 0;
waterCheck = instance_exists(obj_ef_ocean);

if (waterCheck)
    waterId = obj_ef_ocean.id;
else
    waterId = -1;

talkIcoBase = 0;
talkIcoImg = 0;
drawTalkIco = 0;
talkIcoTrans = 0;
alarm[8] = 40;


is_death_link = 0; // Death Link flag to avoid sending it back.