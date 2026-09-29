if (disabled) {
    alarm[0] = 1;
    return;
}


draw_set_font(font);
width = string_width(text) - trim_left - trim_right;
height = string_height(text) - trim_top - trim_bottom;

var draw_ypos = -1; 

var c_c = view_yview + view_hview / 2;
with (obj_chelshia) {
    if (y < c_c) draw_ypos = 1; 
}

draw_x = view_wview / 2 - width / 2 - padding;
draw_y = view_hview / 2 + draw_height_from_center * draw_ypos - height / 2 - padding;

start_x = - width + padding * 2 - 2;
end_x = view_wview + padding * 2 + 2;

t_1 = tr_time;
t_2 = time + tr_time;
t_f = time + tr_time + tr_time - 1;

draw = 1;

alarm[1] = t_f + 1;