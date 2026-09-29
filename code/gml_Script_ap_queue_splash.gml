var font = argument0;
var color = argument1;
var text = argument2;

var can_start = ds_queue_empty(global.ap_splash_queue) && !instance_exists(ap_ef_splash_text)

var aa = instance_create(x, y, ap_ef_splash_text);
if (!is_undefined(font)) aa.font = font;
if (!is_undefined(color)) aa.color = color;
if (!is_undefined(text)) aa.text = text;
if (can_start) aa.disabled = 0;
else ds_queue_enqueue(global.ap_splash_queue, aa);

return aa;