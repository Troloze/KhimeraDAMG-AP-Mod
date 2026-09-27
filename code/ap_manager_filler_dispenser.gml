var can_dispense = 0;
with (obj_chelshia) {
    if (canmove) can_dispense = 1;
}

alarm[2] = dispenser_attempt_cooldown;
if (!can_dispense) return;

var is_trap_cooldown = 0;

if (!ds_map_empty(trap_entities)) {
    var c_entry = ds_map_find_first(trap_entities);
    var c_value;
    while (!is_undefined(c_entry)) {
        c_value = ds_map_find_value(trap_entities, c_entry);
        if (is_undefined(c_value) || !ap_enemy_tracker_exists(c_entry, c_value)) {
            var old_entry = c_entry
            c_entry = ds_map_find_next(trap_entities, c_entry);
            ds_map_delete(trap_entities, old_entry);
            continue;
        }
        // A trap-spawned enemy exists
        is_trap_cooldown = 1;
        c_entry = ds_map_find_next(trap_entities, c_entry); // We don't stop so we can iterate over the whole map, deleting all destroyed entities.
    }
}

if (is_trap_cooldown && instance_cooldown_tracker <= 0) {
    instance_cooldown_tracker = dispenser_instance_cooldown_max_cycles
    is_trap_cooldown = 0;
}

instance_cooldown_tracker -= 1;

var action = undefined;
if (!is_trap_cooldown && !ds_queue_empty(filler_instance_queue)) {
    action = ds_queue_dequeue(filler_instance_queue);
} else if (!ds_queue_empty(filler_queue)) {
    action = ds_queue_dequeue(filler_queue);
}

if (is_undefined(action)) return;

var c_x, c_y;
with (obj_chelshia) {
    c_x = x + other.chelshia_center_displacement_x;
    c_y = y + other.chelshia_center_displacement_y;
}
var x_left, y_top, x_center, y_center, x_right, y_bottom, i;
switch (action) {
    case -1: // Wait a few moments ----------------------------------------------------------------------------------------------------------------
        alarm[2] = irandom(180) + 60;
        break;
    case 0: // coin ----------------------------------------------------------------------------------------------------------------
        scr_dropMoney(c_x, c_y - 50, choose(1, 5, 10));
        break;
    case 1: // Small treasure ----------------------------------------------------------------------------------------------------------------
        scr_dropMoney(c_x, c_y - 50, irandom(60) + 15);
        break;
    case 2: // Big treasure ----------------------------------------------------------------------------------------------------------------
        scr_dropMoney(c_x, c_y - 50, irandom(130) + 120);
        break;
    case 3: // Food ----------------------------------------------------------------------------------------------------------------
        instance_create(c_x, c_y - 50, obj_food);
        break;
    case 4: // Balls ----------------------------------------------------------------------------------------------------------------
        x_center = view_xview + view_wview / 2; // Center of the screen
        y_top = view_yview - 16; // Just above the top of the view
        var space = random(50) + 50;
        var displace = random(60) - 30;
        var aa1 = instance_create(x_center + displace - space, y_top, obj_nme_dropBall);
        var aa2 = instance_create(x_center + displace        , y_top, obj_nme_dropBall);
        var aa3 = instance_create(x_center + displace + space, y_top, obj_nme_dropBall);
        aa1.value = 0;
        aa1.banFood = 1;
        aa1.canIncrementKillCounter = 0;
        aa2.value = 0;
        aa2.banFood = 1;
        aa2.canIncrementKillCounter = 0;
        aa3.value = 0;
        aa3.banFood = 1;
        aa3.canIncrementKillCounter = 0;
        ds_map_replace(trap_entities, aa1, ap_enemy_tracker_get_id(aa1));
        ds_map_replace(trap_entities, aa2, ap_enemy_tracker_get_id(aa2));
        ds_map_replace(trap_entities, aa3, ap_enemy_tracker_get_id(aa3));
        instance_cooldown_tracker = dispenser_instance_cooldown_max_cycles;
        scr_supersound(snd_sheen, global.v_snd, 0);
        break;
    case 5: // Aviator Swarm ----------------------------------------------------------------------------------------------------------------
        var pos_disp = 0.15
        x_center = view_xview + view_wview / 2;
        x_left = view_xview + view_wview * pos_disp;
        x_right = view_xview + view_wview * (1 - pos_disp);
        y_center = view_yview + view_hview / 2; 
        y_top = view_yview + view_hview * pos_disp; 
        y_bottom = view_yview + view_hview * (1 - pos_disp);
        var y_center_threshold = 60;
        var x_center_threshold = 100;
        var x_delta = x_right - x_left;
        var y_delta = y_bottom - y_top;
        var h_count = 2, v_count = 2;
        var disable_top = 0, disable_bottom = 0, disable_left = 0, disable_right = 0;
        // Horizontal lines
        if (!(abs(c_y - y_center) < (y_center_threshold/2))) {
            h_count *= 2;
            if (c_y > y_center) disable_bottom = 1; // Large values means lower.
            else disable_top = 1;
        }
        for (i = 1; i < h_count + 1; i++) {
            var c_aa;
            var p_x = x_left + ((h_count + 1 - i) / (h_count + 1)) * x_delta;
            if (!disable_top) {
                c_aa = instance_create(p_x, y_top, obj_nme_followFluff);
                c_aa.value = 0;
                c_aa.banFood = 1;
                c_aa.canIncrementKillCounter = 0;
                scr_ef_smoke(p_x, y_top);
                ds_map_replace(trap_entities, c_aa, ap_enemy_tracker_get_id(c_aa));
                
            }
            if (!disable_bottom) {
                c_aa = instance_create(p_x, y_bottom, obj_nme_followFluff);
                c_aa.value = 0;
                c_aa.banFood = 1;
                c_aa.canIncrementKillCounter = 0;
                scr_ef_smoke(p_x, y_bottom);
                ds_map_replace(trap_entities, c_aa, ap_enemy_tracker_get_id(c_aa));
            }
        }
        // Vertical lines
        if (!(abs(c_x - x_center) < (x_center_threshold/2))) {
            v_count *= 2;
            if (c_x > x_center) disable_right = 1; // Large values means to the right.
            else disable_left = 1;
        }
        for (i = 1; i < v_count + 1; i++) {
            var c_aa;
            var p_y = y_top + ((v_count + 1 - i) / (v_count + 1)) * y_delta;
            if (!disable_left) {
                c_aa = instance_create(x_left, p_y, obj_nme_followFluff);
                scr_ef_smoke(x_left, p_y);
                ds_map_replace(trap_entities, c_aa, ap_enemy_tracker_get_id(c_aa));
            }
            if (!disable_right) {
                c_aa = instance_create(x_right, p_y, obj_nme_followFluff);
                scr_ef_smoke(x_right, p_y);
                ds_map_replace(trap_entities, c_aa, ap_enemy_tracker_get_id(c_aa));
            }
        }
        instance_cooldown_tracker = dispenser_instance_cooldown_max_cycles;
        scr_supersound(snd_sheen, global.v_snd, 0);
        break;
    case 6: // Kiran Drive-By ----------------------------------------------------------------------------------------------------------------
        if (instance_exists(obj_nme_witchControl)) {
            ds_queue_enqueue(filler_instance_queue, 7);
            break;
        }
        y_top = view_yview + view_hview * 0.2; // Almost at the top of the 
        x_center = view_xview + view_wview / 2; // Center of the screen
        x_left = view_xview - 16;
        x_right = view_xview + view_wview + 16;
        var dire, p_x;
        if (c_x <= x_center) {
            dire = 0; // Going Left
            p_x = x_right;
        } else {
            dire = 1; // Going Right
            p_x = x_left;
        }
        var k_aa = instance_create(p_x, y_top, obj_nme_witch);
        k_aa.dire = dire;
        k_aa.value = 0;
        k_aa.banFood = 1;
        k_aa.canIncrementKillCounter = 0;
        ds_map_replace(trap_entities, k_aa, ap_enemy_tracker_get_id(k_aa));
        instance_cooldown_tracker = dispenser_instance_cooldown_max_cycles;
        scr_supersound(snd_sheen, global.v_snd, 0);
        break;
    case 7: // Box Trap ----------------------------------------------------------------------------------------------------------------
        with (obj_chelshia) {
            if (chestMode) {
                ds_queue_enqueue(other.filler_queue, -1);
                ds_queue_enqueue(other.filler_queue, 6);
                break;
            }
            event_perform(ev_other, ev_user8);
            Wbuffer = 0;
            alarm[7] = 15;
            chestMode = 1;
            yspeed = -2;
            xspeed = 0;
            canhit = 1;
            blinking = 0;
            cangrav = 1;
            scr_supersound(18, global.v_snd, 0);
            event_perform(ev_other, ev_user3);
        }
        break;
    case 8: // Random Enemy Trap ----------------------------------------------------------------------------------------------------------------
        var enemy = choose( 
            obj_nme_beetle, 
            obj_nme_fluff,
            obj_nme_pirate, 
            obj_nme_starPirate, 
            obj_nme_cutterPirate,
            obj_nme_bob,
            obj_nme_squid,
            obj_nme_tadpole,
            obj_nme_zombie,
            obj_nme_bombZombie,
            obj_nme_redOni 
        );
        x_center = view_xview + view_wview / 2; // Center of the screen
        var p_x;
        if (c_x <= x_center) {
            p_x = c_x + 100;
        } else {
            p_x = c_x - 100;
        }
        var r_aa = instance_create(p_x, c_y - 30, enemy);
        r_aa.value = 0;
        r_aa.banFood = 1;
        r_aa.canIncrementKillCounter = 0;
        scr_ef_smoke(p_x, c_y - 30);
        ds_map_replace(trap_entities, r_aa, ap_enemy_tracker_get_id(r_aa));
        instance_cooldown_tracker = dispenser_instance_cooldown_max_cycles;
        break;
    case 9: // Kiran Drive-Thru ----------------------------------------------------------------------------------------------------------------
        if (instance_exists(obj_nme_witchControl)) {
            ds_queue_enqueue(filler_instance_queue, 9);
            break;
        }
        y_top = view_yview + view_hview * 0.2; // Almost at the top of the 
        x_center = view_xview + view_wview / 2; // Center of the screen
        x_left = view_xview - 16;
        x_right = view_xview + view_wview + 16;
        var dire, p_x;
        if (c_x <= x_center) {
            dire = 0; // Going Left
            p_x = x_right;
        } else {
            dire = 1; // Going Right
            p_x = x_left;
        }
        var k_aa = instance_create(p_x, y_top, obj_nme_witch);
        k_aa.dire = dire;
        k_aa.thru = 1;
        k_aa.value = 0;
        k_aa.banFood = 1;
        k_aa.canIncrementKillCounter = 0;
        ds_map_replace(trap_entities, k_aa, ap_enemy_tracker_get_id(k_aa));
        instance_cooldown_tracker = dispenser_instance_cooldown_max_cycles;
        scr_supersound(snd_sheen, global.v_snd, 0);
        break;
}





