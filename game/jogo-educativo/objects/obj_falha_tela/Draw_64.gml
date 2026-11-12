// O fundo e os botões são imagens da room. Aqui só o título e o destaque do mouse.
var _f = global.fonte_pixel;
var _s = (_f != -1) ? 2.5 : 4;
if (_f != -1) draw_set_font(_f);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Título com sombra (segue o tamanho de fonte da acessibilidade, sem passar da tela)
var _s1 = escala_que_cabe("Que Pena!", _s * escala_texto(), room_width - 120);
var _s2 = escala_que_cabe("Não foi dessa vez...", _s * escala_texto(), room_width - 120);
draw_set_colour(c_black);
draw_text_transformed(bx + 4, 134, "Que Pena!", _s1, _s1, 0);
draw_text_transformed(bx + 4, 204, "Não foi dessa vez...", _s2, _s2, 0);
draw_set_colour(make_colour_rgb(255, 170, 40));
draw_text_transformed(bx, 130, "Que Pena!", _s1, _s1, 0);
draw_text_transformed(bx, 200, "Não foi dessa vez...", _s2, _s2, 0);

// Brilho no botão quando o mouse passa
var _ys = [b1y, b2y];
for (var i = 0; i < 2; i++) {
    if (point_in_rectangle(mouse_x, mouse_y, bx - bw/2, _ys[i] - bh/2, bx + bw/2, _ys[i] + bh/2)) {
        draw_set_alpha(0.2);
        draw_set_colour(c_white);
        draw_rectangle(bx - bw/2, _ys[i] - bh/2, bx + bw/2, _ys[i] + bh/2, false);
        draw_set_alpha(1);
    }
}

draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);
