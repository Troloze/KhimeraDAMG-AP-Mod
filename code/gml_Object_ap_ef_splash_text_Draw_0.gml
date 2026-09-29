if (!draw) return;
var px, n, f;
if (t <= t_1) {
    n = t / (tr_time + 1);
    f = 1 - ((1 - n) * (1 - n)); // Fade out
    px = (draw_x - start_x) * f + start_x;
    
} else if (t <= t_2) {
    px = draw_x;
} else { 
    n = (t - t_2) / (tr_time + 1);
    f = n * n // Fade in
    px = (end_x - draw_x) * f + draw_x;
}

draw_set_color(bg_color);
draw_set_alpha(bg_alpha);
draw_rectangle(px, draw_y, px + width + padding * 2, draw_y + height + padding * 2, false);

draw_set_color(color);
draw_set_alpha(alpha);
draw_set_font(font);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(px + padding, draw_y + padding, text);

t++;