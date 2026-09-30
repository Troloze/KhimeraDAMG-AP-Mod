scr_supersound(42, global.v_snd, 0);

if (room != rm_map)
{
    with (obj_breakableParent)
        paused = 1;
    
    instance_deactivate_all(true);
    instance_activate_object(ap_manager);
    instance_activate_object(obj_halloweenCont);
    instance_activate_object(obj_inputcontrol);
    instance_activate_object(obj_soundEngine);
    instance_activate_object(obj_roomTransitionCont);
    instance_activate_object(obj_bgparent);
    instance_activate_object(obj_drawcont);
    instance_activate_object(obj_upsideDownMachine);
    instance_activate_object(obj_block);
    instance_activate_object(obj_NPC_andyQuerie);
    
    with (obj_block)
        event_perform(ev_other, ev_user10);
    
    if (global.game_mode == 1)
        scr_setRaceTimerActive(0);
    
    with (obj_drawcont)
        cantimer = 0;
}
