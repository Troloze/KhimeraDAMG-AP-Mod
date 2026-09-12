if (drawHud)
{
    draw_set_font(fnt_text);
    draw_set_alpha(1);
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
    xx = view_xview + 2;
    yy = view_yview + 1;
    scr_borderText(xx, yy, healthStr, hudColor, 0, 1);
    
    for (i = 2; i <= global.maxHP; i += 2)
    {
        if (global.HP < (i - 1))
            img = 0;
        else if (global.HP == (i - 1))
            img = 1;
        else
            img = 2;
        
        draw_sprite(hudHPSpr, img, view_xview + 4, yy + 10 + (((i / 2) - 1) * 12));
    }
    
    if (drawBoss)
    {
        draw_set_halign(fa_right);
        xx = (view_xview + view_wview) - 2;
        yy = view_yview + 1;
        scr_borderText(xx, yy, bossStr, hudColor, 0, 1);
        
        for (i = 2; i <= global.bossMaxHP; i += 2)
        {
            if (drawBossHP < (i - 1))
                img = 0;
            else if (drawBossHP == (i - 1))
                img = 1;
            else
                img = 2;
            
            draw_sprite(spr_hudBossHP, img, (view_xview + view_wview) - 16, yy + 10 + (((i / 2) - 1) * 12));
        }
    }
    
    draw_set_halign(fa_center);
    
    if (global.current_level != 17)
    {
        str = "-" + moneyStr + "-#$" + scr_stringZeroes(global.money, 5);
        xx = floor(view_xview + (view_wview / 3));
        yy = view_yview + 1;
        scr_borderText(xx, yy, str, hudColor, 0, 1);
    }
    
    if (global.total_candy > 0)
    {
        str = "-" + candyStr + "-#" + scr_stringZeroes(global.total_candy, 2);
        draw_set_halign(fa_center);
        xx = floor(view_xview + (view_wview / 3));
        yy = view_yview + 1;
        scr_borderText(xx, yy, str, hudColor, 0, 1);
    }
    
    if (global.timerOn)
    {
        str = "-" + timeStr + "-#" + scr_time(global.timeFrames);
        xx = floor(view_xview + ((view_wview / 3) * 2));
        yy = view_yview + 1;
        scr_borderText(xx, yy, str, hudColor, 0, 1);
    }
    
}

if (global.showPercent && room != rm_halloween)
{
    draw_set_font(fnt_percent);
    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    xx = (view_xview + view_wview) - 2;
    yy = (view_yview + view_hview) - 2;
    str = string(global.gamePercent) + "%";
    draw_set_color(c_black);
    draw_text_transformed(xx + 1, yy + 1, str, percentScale, percentScale, 0);
    draw_set_color(c_white);
    draw_text_transformed(xx, yy, str, percentScale, percentScale, 0);
    
    if (!drawBoss)
    {
        yy = view_yview + 2;
        ll = global.current_level;
        
        if (global.level_hasFood[ll])
        {
            if (global.level_rockPile[ll])
                img = 5;
            else
                img = 0;
            
            draw_sprite(spr_map_foodIcon, img, xx - 16, yy);
            yy += 18;
        }
        
        if (global.level_hasFood[ll])
        {
            if (global.level_food[ll])
                img = global.level_foodImg[ll];
            else
                img = 0;
            
            draw_sprite(spr_map_foodIcon, img, xx - 16, yy);
            yy += 18;
        }
        
        if (global.level_hasFairies[ll] > 0)
        {
            for (i = 1; i <= global.level_hasFairies[ll]; i += 1)
            {
                draw_sprite(spr_map_fairyIcon, 0, xx - 10, yy);
                
                if (global.level_fairy[ll, i])
                    draw_sprite(spr_map_fairyIcon, global.level_fairyColor[ll, i], xx - 10, yy);
                
                yy += 12;
            }
        }
        
        if (global.level_hasLore[ll] > 0)
        {
            for (i = 1; i <= global.level_hasLore[ll]; i += 1)
            {
                draw_sprite(spr_map_fairyIcon, 0, xx - 10, yy);
                
                if (global.nme_obtained[global.level_loreIndex[ll, i]])
                    draw_sprite(spr_map_fairyIcon, 6, xx - 10, yy);
                
                yy += 12;
            }
        }
    }
}
