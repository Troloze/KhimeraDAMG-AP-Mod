global.killBonusCounter = 0;
global.noHit = 0;
scr_stopmusic();

with (obj_drawcont)
    cantimer = 0;

aa = instance_create(x, y, obj_deadChel);
aa.dire = dire;
aa.sprite_index = sprIdle[dire];
aa.fallDeath = fallDeath;

if (hasScuttle && !fallDeath)
{
    aa = instance_create(x - (8 * ((dire * 2) - 1)), y - 16, obj_ef_fade);
    aa.transrate = 0;
    aa.sprite_index = spr_scuttle_ride;
    aa.image_speed = 0;
    aa.image_index = 0;
    aa.image_xscale = (dire * 2) - 1;
    aa.rotrate = ((dire * 2) - 1) * 3;
    aa.hspeed = -((dire * 2) - 1) * 2;
    aa.vspeed = -6;
    aa.gravity = 0.5;
    aa.depth = depth + 1;
}

if (!is_death_link) ap_death_link(); // Death Link!

instance_destroy();
