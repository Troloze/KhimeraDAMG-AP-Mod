var scrT = 0;
return 0; // No achievements.

for (var scrI = 1; scrI <= global.total_achievements; scrI += 1)
    scrT += global.ach_achieved[scrI];

return scrT;
