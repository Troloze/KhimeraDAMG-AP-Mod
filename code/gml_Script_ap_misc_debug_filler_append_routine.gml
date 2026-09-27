if (!global.AP_DEBUG) return;

if (keyboard_check(ord('T'))) {
    if (keyboard_check_pressed(ord('0'))) {
        ds_queue_enqueue(filler_queue, 0);
        scr_supersound(snd_click, global.v_snd, 0);
    }
    if (keyboard_check_pressed(ord('1'))) {
        ds_queue_enqueue(filler_queue, 1);
        scr_supersound(snd_click, global.v_snd, 0);
    }
    if (keyboard_check_pressed(ord('2'))) {
        ds_queue_enqueue(filler_queue, 2);
        scr_supersound(snd_click, global.v_snd, 0);
    }
    if (keyboard_check_pressed(ord('3'))) {
        ds_queue_enqueue(filler_queue, 3);
        scr_supersound(snd_click, global.v_snd, 0);
    }
    if (keyboard_check_pressed(ord('4'))) {
        ds_queue_enqueue(filler_instance_queue, 4);
        scr_supersound(snd_click, global.v_snd, 0);
    }
    if (keyboard_check_pressed(ord('5'))) {
        ds_queue_enqueue(filler_instance_queue, 5);
        scr_supersound(snd_click, global.v_snd, 0);
    }
    if (keyboard_check_pressed(ord('6'))) {
        ds_queue_enqueue(filler_instance_queue, 6);
        scr_supersound(snd_click, global.v_snd, 0);
    }
    if (keyboard_check_pressed(ord('7'))) {
        ds_queue_enqueue(filler_queue, 7);
        scr_supersound(snd_click, global.v_snd, 0);
    }
    if (keyboard_check_pressed(ord('8'))) {
        ds_queue_enqueue(filler_instance_queue, 8);
        scr_supersound(snd_click, global.v_snd, 0);
    }
    if (keyboard_check_pressed(ord('9'))) {
        ds_queue_enqueue(filler_instance_queue, 9);
        scr_supersound(snd_click, global.v_snd, 0);
    }
} 