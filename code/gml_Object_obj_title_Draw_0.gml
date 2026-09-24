xx = room_width / 2;
yy = 16 + (sprite_height / 2);

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
            draw_set_color(cursorColor);
            draw_set_alpha(0.5);
            draw_rectangle(ix, iy + 11, ix + choiceW[i], (iy + 11) - cursorHeight, false);
            if (action[i] != -1) cc = make_color_rgb(255, 199, 4);
            else cc = make_color_rgb(200, 200, 200);
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
    scr_shadowText(2, view_hview - 2, "AP RANDOMIZER MOD V." + global.ap_mod_version + "#2026 TROLOZE", 16777215, 0, 2);
    
    // Removed steam connection status viewer since it is useless for this mod's purpose, and I want to use that area for connection status viewing.
}
