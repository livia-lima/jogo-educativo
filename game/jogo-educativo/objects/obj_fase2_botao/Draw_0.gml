draw_set_colour(hover ? c_teal : c_dkgray);
draw_rectangle(x - largura/2, y - altura/2, x + largura/2, y + altura/2, false);
draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed(x, y, string(valor), 5, 5, 0);
draw_set_halign(fa_left);
draw_set_valign(fa_top);