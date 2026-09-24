var cc, text = "";
if (global.ap_fully_connected) {
    cc = connection_status_text_color[0];
    text = connection_status_text[0];
    if (connection_status_hide_counter > 0) connection_status_hide_counter--;
} else if (global.ap_client_connected) {
    cc = connection_status_text_color[1];
    text = connection_status_text[1];
    connection_status_hide_counter = connection_status_counter_refill;
} else {
    cc = connection_status_text_color[2];
    text = connection_status_text[2];
    connection_status_hide_counter = connection_status_counter_refill;
}

connection_status_fade = (connection_status_fade_time - connection_status_hide_counter) / connection_status_fade_time;
if (connection_status_fade > 1) connection_status_fade = 1;
if (connection_status_fade < 0) connection_status_fade = 0;

var w, h, fade_offset;
var offset = 2, box_x = 5, box_y = 0;
var trim_top = 0, trim_bottom = 3, trim_right = 2, pad = 2;
// Connection Status
if ((text != "") && (connection_status_hide_counter > 0)) {
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(fnt_text);
    w = string_width(text) - trim_right;
    h = string_height(text) - trim_top - trim_bottom;
    fade_offset = connection_status_fade * (box_y + h + pad * 2);
    draw_set_color(connection_status_background_color);
    draw_set_alpha(connection_status_background_alpha);
    draw_rectangle(box_x, box_y - fade_offset, box_x + w + pad * 2, box_y + h + pad * 2  - fade_offset, false);
    draw_set_color(cc);
    draw_set_alpha(connection_status_text_alpha);
    draw_text(box_x + pad, box_y + pad - trim_top - fade_offset, text);
}

