with (obj_drawcont)
    followplayer = 1;

with (block1)
    instance_destroy();

with (block2)
    instance_destroy();

if (spawnScroll)
{
    aa = instance_create(arenax, arenay, obj_scroll);
    aa.index = scrollIndex;
    scr_ef_smoke(arenax - 8, arenay - 8);
    scr_ef_smoke(arenax - 8, arenay + 8);
    scr_ef_smoke(arenax + 8, arenay - 8);
    scr_ef_smoke(arenax + 8, arenay + 8);
}

if (candyIndex != -1)
{
    aa = instance_create(arenax, arenay, obj_halloweenCandy);
    aa.index = candyIndex;
    scr_ef_smoke(arenax - 8, arenay - 8);
    scr_ef_smoke(arenax - 8, arenay + 8);
    scr_ef_smoke(arenax + 8, arenay - 8);
    scr_ef_smoke(arenax + 8, arenay + 8);
}

ap_location_miniboss(index, undefined);