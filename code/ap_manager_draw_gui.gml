// Text Messages Display
var i, _i, cap = min(text_message_cap, text_current_messages);
var c_message, c_time, c_type, draw_y = view_hview, draw_x = 0, t_height, pad_x = 2, pad_y = 2, fade = 1;
var bottom_pad = 0, extra = 0;
var stop = 0;
for (i = 0; i < cap; i++) {
    _i = (text_last_index - i + text_message_cap)%text_message_cap;
    
    draw_set_font(text_font);
    draw_set_halign(fa_left);
    draw_set_valign(fa_bottom);
    c_message = ds_grid_get(text_log, message_field, _i);
    c_time = ds_grid_get(text_log, time_field, _i);
    c_type = ds_grid_get(text_log, type_field, _i);
    ds_grid_set(text_log, time_field, _i, max(0, c_time - 1));
    
    if (stop) continue;
    
    t_height = string_height_ext(c_message, text_line_sep, text_line_width); 
    if (!text_full_display) fade = 1 - clamp((text_timeout_fade - c_time) / (text_timeout_fade), 0, 1);
    
    if (draw_y - (t_height + pad_y) > view_hview) {
        draw_y -= t_height + pad_y + 1; // Skip text bellow the screen.
        continue;
    } 
    else if ((text_full_display && (draw_y < 0)) || ((!text_full_display) && (draw_y < (view_hview - text_partial_threshold)))) {
        stop = 1;
        continue;
    }
    
    if (i == 0) extra = bottom_pad;
    draw_set_color(text_bg_color);
    draw_set_alpha(text_bg_alpha * fade);
    draw_rectangle(draw_x, draw_y, draw_x + text_line_width + pad_x * 2, draw_y - t_height - pad_y - extra, false);
    
    draw_set_color(text_color);
    if (c_type == 1) draw_set_color(text_color_death_link);
    draw_set_alpha(text_alpha * fade);
    draw_text_ext(draw_x + pad_x, draw_y - extra, c_message, text_line_sep, text_line_width);
    
    draw_y -= t_height + pad_y + extra + 1;
}

// Connection Status Display
var cs_color, cs_text = "";
if (global.AP_DEBUG) {
    cs_color = connection_status_text_color[0];
    cs_text = "DEBUG MODE";
    connection_status_hide_counter = connection_status_counter_refill;
} else if (global.ap_fully_connected) {
    cs_color = connection_status_text_color[0];
    cs_text = connection_status_text[0];
    if (connection_status_hide_counter > 0) connection_status_hide_counter--;
} else if (global.ap_client_connected) {
    cs_color = connection_status_text_color[1];
    cs_text = connection_status_text[1];
    connection_status_hide_counter = connection_status_counter_refill;
} else {
    cs_color = connection_status_text_color[2];
    cs_text = connection_status_text[2];
    connection_status_hide_counter = connection_status_counter_refill;
}

connection_status_fade = (connection_status_fade_time - connection_status_hide_counter) / connection_status_fade_time;
if (connection_status_fade > 1) connection_status_fade = 1;
if (connection_status_fade < 0) connection_status_fade = 0;

var w, h, fade_offset;
var box_x = 5, box_y = 0;
var trim_top = 0, trim_bottom = 3, trim_right = 2;
pad_x = 2; 
pad_y = 2;

if ((cs_text != "") && (connection_status_hide_counter > 0)) {
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(fnt_text);
    w = string_width(cs_text) - trim_right;
    h = string_height(cs_text) - trim_top - trim_bottom;
    fade_offset = connection_status_fade * (box_y + h + pad_y * 2);
    draw_set_color(connection_status_background_color);
    draw_set_alpha(connection_status_background_alpha);
    draw_rectangle(box_x, box_y - fade_offset, box_x + w + pad_x * 2, box_y + h + pad_y * 2  - fade_offset, false);
    draw_set_color(cs_color);
    draw_set_alpha(connection_status_text_alpha);
    draw_text(box_x + pad_x, box_y + pad_y - trim_top - fade_offset, cs_text);
}

