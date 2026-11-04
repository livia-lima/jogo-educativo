draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (sprite_index != -1) {
    draw_sprite_ext(sprite_index, image_index, x, y, escala, escala, 0, c_white, 1);
} else {
    // Provisório até chegar a imagem
    draw_set_colour(c_aqua);
    draw_circle(x, y, 50 * escala, false);
    draw_set_colour(c_black);
    draw_text(x, y, "BIKE");
}

if (numero > 0) {
    draw_set_colour(c_yellow);
    draw_text_transformed(x, y - 80, string(numero), 3, 3, 0);
}

draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);