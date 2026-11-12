
draw_self();

draw_sprite_ext(
    spr_slider_pino,
    0,
    pos_x,
    barra_y - ajuste_pino_y,
    image_xscale,
    image_yscale,
    0,
    c_white,
    1
);

// Prévia do tamanho escolhido, à direita da barra
texto_sombra(max_x + 20, barra_y, "Aa", fonte(FONTE_PIXELIFY, 36), escala_texto(),
	c_white, c_black, 3, fa_left);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);
draw_set_font(-1);
