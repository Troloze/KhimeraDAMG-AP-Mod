return;
xx = view_xview;
yy = (view_yview + view_hview) - 24 - displace;
draw_set_color(c_black);
draw_set_alpha(0.6);
draw_rectangle(xx, yy - drawHeight, xx + view_wview, yy + drawHeight, false);

if (drawHeight >= maxHeight)
{
    draw_set_font(fnt_text);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(253, 182, 85));
    draw_text(xx + (view_wview / 2), yy - drawHeight, header[index]);
    draw_set_color(c_white);
    draw_text_ext(xx + (view_wview / 2), yy - 4, message[index], 8, view_wview - 16);
}
