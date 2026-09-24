if (room_width > view_wview || room_height > view_hview)
    instance_deactivate_all(true);

instance_activate_object(obj_immunity);
instance_activate_object(obj_enemyImmune);
instance_activate_object(obj_NPCimmune);
instance_activate_object(ap_manager);
instance_activate_region(view_xview - 32, view_yview - 32, view_wview + 64, view_hview + 64, true);
