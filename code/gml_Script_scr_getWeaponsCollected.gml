var scrT = 0;

for (var scrI = 1; scrI <= global.total_weapons; scrI += 1)
    scrT += global.ap_item_wep_obtained[scrI];

return scrT;
