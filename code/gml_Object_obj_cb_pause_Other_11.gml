instance_deactivate_all(true);
instance_activate_object(ap_manager);
instance_activate_object(obj_inputcontrol);
instance_activate_object(obj_soundEngine);
instance_activate_object(obj_roomTransitionCont);
instance_activate_object(obj_upsideDownMachine);
instance_activate_object(obj_block);

with (obj_block)
    event_perform(ev_other, ev_user10);

instance_activate_object(obj_cb_drawcont);

with (obj_cb_drawcont)
{
    remAlarm[0] = alarm[0];
    alarm[0] = -1;
    remAlarm[2] = alarm[2];
    alarm[2] = -1;
    remAlarm[3] = alarm[3];
    alarm[3] = -1;
    remAlarm[4] = alarm[4];
    alarm[4] = -1;
}
