xx = room_width / 2;
yy = 16 + (sprite_height / 2);


var i;

// Archipelago flair for no reason at all.
var in_r = 47, out_r = 45, t_r = in_r + out_r, outline = 2;
var cx = room_width - 70, cy = room_height - 45;
var ap_squeeze = 0.62;
var ap_fade = 0.35;

var archipelago_spin_rate = 4.5; // degrees per second.
archipelago_spin += clamp(delta_time/1000000, 0.1, 1.0) * archipelago_spin_rate;

while (archipelago_spin < 0) archipelago_spin += 360;
while (archipelago_spin > 361) archipelago_spin -= 360;

var order_displacement = (floor((archipelago_spin + 30)/60)) % 6;
ap_draw_order_current[0] = (6 - order_displacement)  % 6;
ap_draw_order_current[1] = (7 - order_displacement)  % 6;
ap_draw_order_current[2] = (8 - order_displacement)  % 6;
ap_draw_order_current[3] = (11 - order_displacement) % 6;
ap_draw_order_current[4] = (10 - order_displacement) % 6;
ap_draw_order_current[5] = (9 - order_displacement)  % 6;

for (i = 0; i < 6; i++) {
    var _i = ap_draw_order_current[i];
    var angle = 2 * pi * (_i * 60 - 90 + archipelago_spin) / 360;
    var dx = round(t_r * cos(angle));
    var dy = round(t_r * sin(angle) * ap_squeeze);
    var color = ap_misc_color_mix(archipelago_color[_i], background_color, 1 - ap_fade);
    draw_set_color(background_color);
    draw_set_alpha(1.0);
    draw_circle(cx + dx, cy + dy, out_r + outline, false);
    draw_set_color(color);
    draw_set_alpha(1.0);
    draw_circle(cx + dx, cy + dy, out_r, false);
}

if (drawDisplace > 0)
{
    scr_superdraw(sprite_index, 0, xx - drawDisplace, yy, 1, 1, 0, 16777215, 0.5);
    scr_superdraw(sprite_index, 0, xx + drawDisplace, yy, 1, 1, 0, 16777215, 0.5);
}
else
{
    scr_superdraw(sprite_index, 0, xx, yy, 1, 1, 0, 16777215, 1);
}

if (pressAPrompt && drawPrompt)
{
    draw_set_font(fnt_score);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_alpha(1);
    scr_shadowText(room_width / 2, (room_height / 2) + 32, startPrompt[lang], 16777215, 0, 2);
}

if (drawMenu)
{
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    
    for (i = 1; i <= choices; i += 1)
    {
        ix = 4 + (12 * (i - 1)) + choiceDisplace;
        iy = (room_height / 2) + (18 * (i - 1));
          
        if (i == selected)
        {
            iy -= 4;
            draw_set_alpha(0.5);
            if (action[i] != -1) {
                draw_set_color(cursorColor);
                cc = make_color_rgb(255, 199, 4);
            } else {
                draw_set_color(disabledCursorColor);
                cc = make_color_rgb(200, 200, 200);
            }
            draw_rectangle(ix, iy + 11, ix + choiceW[i], (iy + 11) - cursorHeight, false);
        }
        else
        {
            if (action[i] != -1) cc = make_color_rgb(146, 211, 149);
            else cc = make_color_rgb(140, 140, 140);
        }
        
        draw_set_alpha(1);
        draw_set_font(fnt_score);
        scr_shadowText(ix, iy, choice[i], cc, 0, 2);
        
        if (i == selected)
        {
            cc = make_color_rgb(241, 199, 209);
            draw_set_font(fnt_text);
            scr_shadowText(ix + 12, iy + 11, toolTipStr, cc, 0, 2);
        }
    }
}

if (drawMisc)
{
    draw_set_font(fnt_text);
    draw_set_alpha(1);
    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    scr_shadowText(view_wview - 2, view_hview - 2, gameType[global.game_version] + " V." + global.current_version + "#2016 SUITS & SANDALS", 16777215, 0, 2);
    draw_set_halign(fa_left);
    draw_set_valign(fa_bottom);
    scr_shadowText(2, view_hview - 2, "ARCHIPELAGO RANDOMIZER V." + global.ap_mod_version, 16777215, 0, 2);
    
    // Removed steam connection status since it is useless for this mod's purpose, and I want to use that area for connection status.
}
