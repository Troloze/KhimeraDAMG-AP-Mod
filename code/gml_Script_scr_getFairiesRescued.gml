var scrT = 0;


if (!ap_option_get("shuffle_fairies")) {
    for (var scrI = 0; scrI <= global.total_levels; scrI += 1)
    {
        for (var scrJ = 1; scrJ <= global.level_hasFairies[scrI]; scrJ += 1) {
            
            scrT += global.level_fairy[scrI, scrJ];
        }
            
    }
    return scrT;
}

return ap_item_get(500200001);
