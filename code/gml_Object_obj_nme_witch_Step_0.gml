yRot = (yRot + 10) % 360;
y = ystart - (sin((yRot * pi) / 180) * 2);
hspeed = (6 * dire) - 3;

if (thru) candamage = 0;

if (hitstun)
    image_index = hitstunImg;
else if (throwing)
    image_index = 4;
else
    image_index = idleImg;

var comp;
if (!dire) comp = x < (view_xview - 24)
else comp = x > (view_xview + view_wview + 24);

if (comp)
{
    with (obj_nme_witchControl)
        alarm[0] = 90;
    
    instance_destroy();
}
