// escurece o fundo
draw_set_alpha(0.5);
draw_set_colour(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_colour(c_orange);
draw_text_transformed(bx, 250, "Não foi dessa vez...", 4, 4, 0);

var _mx = mouse_x, _my = mouse_y;
var _textos = ["Tentar de novo!", "Voltar ao menu"];
var _ys = [b1y, b2y];
for (var i = 0; i < 2; i++) {
    var _over = point_in_rectangle(_mx, _my, bx - bw/2, _ys[i] - bh/2, bx + bw/2, _ys[i] + bh/2);
    draw_set_colour(_over ? c_yellow : make_colour_rgb(200, 120, 20));
    draw_rectangle(bx - bw/2, _ys[i] - bh/2, bx + bw/2, _ys[i] + bh/2, false);
    draw_set_colour(c_black);
    draw_text_transformed(bx, _ys[i], _textos[i], 2, 2, 0);
}

draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);