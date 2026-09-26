if (!ap_option_get("death_link")) return;
global.ap_last_death_link += 1;
global.ap_last_death_link_message = "%s has died.";
ap_misc_log("[DEATH LINK] " + global.ap_last_death_link_message);