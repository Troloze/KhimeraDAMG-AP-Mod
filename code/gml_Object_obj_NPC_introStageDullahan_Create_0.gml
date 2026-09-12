action_inherited();
image_speed = 0;
dire = 0;
idleImg = 12;
alarm[1] = 1;
firstDialogue = 1;


instance_destroy();

lang = global.gameLanguage;
lMesMain[0] = "@^90You can fight with all kinds of neat attacks with [" + scr_keyname(global.S) + "] and [" + scr_keyname(global.W) + "].@!@%" + "For example, Try pressing [" + scr_keyname(global.S) + "] while holding [" + scr_keyname(global.U) + "] to do a dash attack!@!@%" + "@^91Press [F1] to see a full list of controls and what attacks you can do.@!@%" + "@^89Now that dirty pirate snake is up ahead!@!@%" + "Now It's up to you to stop her!@!";
lMesMain[1] = "@^90Puedes usar todo tipo de ataques chulos pulsando [" + scr_keyname(global.S) + "] y [" + scr_keyname(global.W) + "].@!@%" + "Por ejemplo, ¡prueba a pulsar [" + scr_keyname(global.S) + "] mientras mantienes [" + scr_keyname(global.U) + "] para hacer una embestida!@!@%" + "@^91Pulsa [F1] para ver la lista de comandos completa.@!@%" + "@^89Ahora, ¡esa sucia serpiente pirata está más adelante!@!@%" + "¡Tienes que detenerla!@!";
