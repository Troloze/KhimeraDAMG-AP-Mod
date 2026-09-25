global.stat_food += 1;
other.cansprite = 1;
other.winning = 1;
scr_ef_sparkleCluster(other.x, other.y + 16, 24, 3, 5);
// global.maxHP += 2            // Handled by the ap manager
global.HP = global.maxHP;       // Can still grand the full restore.
scr_supersound(17, global.v_snd, 0);

with (obj_NPC_chef)
    alarm[0] = 60;

global.level_food[global.current_level] = 1;
global.gamePercent = scr_getCompletion();

if (scr_getFoodEaten() == 4)
    scr_unlockAch(18);

instance_destroy();
