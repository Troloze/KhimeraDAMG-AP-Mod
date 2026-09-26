// Death Link!
scr_supersound(16, global.v_snd, 0);
global.HP = 0;
is_death_link = 1;
event_perform(ev_other, ev_user1);
