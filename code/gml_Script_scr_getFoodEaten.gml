var scrT = 0;

for (var scrI = 0; scrI <= global.total_levels; scrI += 1)
{
    if (global.level_hasFood[scrI])
        scrT += global.ap_item_level_food[scrI];
}

return scrT;
