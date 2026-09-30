xx = view_xview + x;
yy = view_yview + y;
scr_superdraw(sprite_index, 0, xx, yy, 1, 1, 0, 16777215, 1);

if (candraw)
{
    draw_set_color(c_black);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_set_font(fnt_biosBig);
    draw_set_alpha(1);
    
    if (pageIndex == 0)
    {
        draw_text(xx + 26 + 60, yy + 22, "Table of Contents");
        draw_set_font(fnt_bios);
        draw_set_halign(fa_left);
        
        for (i = 1; i <= indexChoices; i += 1)
        {
            ix = xx + 19 + (160 * (i > pageLimit));
            iy = (yy + 41 + ((i - 1) * 10)) - (pageLimit * 10 * (i > pageLimit));
            
            if (global.ap_item_nme_obtained[i])
                str = global.nme_name[i];
            else
                str = "----------";
            
            if (i == indexSelected)
                draw_set_color(c_red);
            else
                draw_set_color(c_black);
            
            draw_text(ix, iy, string(i) + ".");
            draw_text(ix + 20, iy, str);
            
            /* Let's skip this "new" thing.
            if (global.nme_new[i])
                draw_sprite(spr_bioNew, 0, ix, iy - 6);
            */
        }
    }
    else
    {
        draw_text(xx + 26 + 60, yy + 22, global.nme_name[pageIndex]);
        img = pageIndex;
        scr_superdraw(214, img, xx + 26 + 60, yy + 70, 1, 1, 0, 16777215, 1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_font(fnt_bios);
        draw_text_ext(xx + 18, yy + 126, pageInfo, 20, -1);
        draw_text_ext(xx + 172, yy + 16, pageDesc, 10, 136);
    }
}
