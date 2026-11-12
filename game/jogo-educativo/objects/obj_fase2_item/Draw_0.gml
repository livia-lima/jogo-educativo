// Os sprites têm origem no canto de cima, então desenha centralizado em x,y
if (sprite_index != -1) {
    var _e = escala * escala_base;
    var _w = sprite_get_width(sprite_index) * _e;
    var _h = sprite_get_height(sprite_index) * _e;
    draw_sprite_ext(sprite_index, image_index, x - _w/2, y - _h/2, _e, _e, 0, c_white, 1);
} else {
    draw_set_colour(c_aqua);
    draw_circle(x, y, 50 * escala, false);
}

if (numero > 0) {
    var _f = global.fonte_pixel;
    var _s = (_f != -1) ? 2 : 3;
    if (_f != -1) draw_set_font(_f);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_colour(c_black);
    draw_text_transformed(x + 2, y - 85, string(numero), _s, _s, 0);
    draw_set_colour(c_yellow);
    draw_text_transformed(x, y - 87, string(numero), _s, _s, 0);
    draw_set_font(-1);
}

draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
