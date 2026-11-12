
arrastando = false;

// Limites da parte visível da barra
min_x = x + (sprite_get_bbox_left(sprite_index) - sprite_get_xoffset(sprite_index)) * image_xscale;
max_x = x + (sprite_get_bbox_right(sprite_index) - sprite_get_xoffset(sprite_index)) * image_xscale;

largura = max_x - min_x;

// Centro vertical da parte visível da barra
barra_y = y + (
    (sprite_get_bbox_top(spr_slider_barra) +
     sprite_get_bbox_bottom(spr_slider_barra)) / 2
    - sprite_get_yoffset(spr_slider_barra)
) * image_yscale;

// Correção da origem visual do pino
ajuste_pino_y = (
    (sprite_get_bbox_top(spr_slider_pino) +
     sprite_get_bbox_bottom(spr_slider_pino)) / 2
    - sprite_get_yoffset(spr_slider_pino)
) * image_yscale;

// Posição inicial do volume
pos_x = lerp(min_x, max_x, global.volume_jogo);
