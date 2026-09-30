image_speed = 0;
active = 1;
dire = 1;
action = 0;


scr_dropMoney(x, y, 56);
instance_destroy();


idleImg = 0;
alarm[1] = 10;
running = 0;
idling = 1;
runImg = 2;
alarm[2] = 5;
lang = global.gameLanguage;
lMesFirst[0] = "@*02@^33*huff* *huff*@!@%I hope this is far enough. I'm not built for long distance running!@!@%@*01@^00Hey, you! With the bag of treasure!@!";
lMesLast[0] = "@*02@^33Yikes! Someone caught up with me! You're a quick little...@!@%@^34What are you exactly?@!@%@*01@^00I'm the bad dude who's going to beat the ever-loving dollar signs out of you if you don't give back that stolen treasure!@!@%@*02@^33Woah! Tough talk for such a tiny thing! You think you can beat me?@!@%@*01@^36Easily!@!@%@*02@^34Is that so? Well too bad I'm running away instead!@!";
lMesFirst[1] = "@*02@^33¡Uf, uf!@!@%Espero que me baste con llegar hasta aquí. ¡No estoy hecha para correr largas distancias!@!@%@*01@^00¡Eh, tú! ¡La serpiente con la bolsa del tesoro!@!";
lMesLast[1] = "@*02@^33¡Diantres! ¡Me han alcanzado! Serás...@!@%@^34¿Qué eres exactamente?@!@%@*01@^00¡Soy la que te va a dar hasta en el simbolito del dólar que se te dibuja en los ojos si no me devuelves todo ese dinero!@!@%@*02@^33¡Oye! ¡Qué grosera eres para ser tan pequeña! ¿Crees que puedes vencerme?@!@%@*01@^36¡Y fácilmente!@!@%@*02@^34¿Ah, sí? ¡Pues qué pena que lo que haga sea largarme!@!";
