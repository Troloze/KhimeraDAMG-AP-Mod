var scrT = 0;

for (var scrI = 1; scrI <= global.total_enemies; scrI += 1)
    scrT += global.ap_item_nme_obtained[scrI];

return scrT;
