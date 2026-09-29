if (ds_queue_empty(global.ap_splash_queue)) return;
var next = ds_queue_dequeue(global.ap_splash_queue);
if (!is_undefined(next)) next.disabled = 0;