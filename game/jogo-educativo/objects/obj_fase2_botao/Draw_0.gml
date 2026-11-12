// A casinha já é desenhada pela botao_frame_answer na room.
// Aqui só destaca quando o mouse passa e escreve o número.
if (hover) {
    draw_set_alpha(0.25);
    draw_set_colour(c_aqua);
    draw_rectangle(x - largura/2, y - altura/2, x + largura/2, y + altura/2, false);
    draw_set_alpha(1);
}

var _f = global.fonte_pixel;
var _s = (_f != -1) ? 4 : 6;
if (_f != -1) draw_set_font(_f);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_colour(c_black);
draw_text_transformed(x + 4, y + 4, string(valor), _s, _s, 0);
draw_set_colour(hover ? c_yellow : c_white);
draw_text_transformed(x, y, string(valor), _s, _s, 0);

draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);
