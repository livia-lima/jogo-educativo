
if (mouse_check_button_pressed(mb_left)) {

    if (point_in_rectangle(
        mouse_x, mouse_y,
        min_x - 12, barra_y - 18,
        max_x + 12, barra_y + 18
    )) {
        arrastando = true;
    }
}

if (arrastando) {

    if (mouse_check_button(mb_left)) {

        pos_x = clamp(mouse_x, min_x, max_x);

        // Volume entre 0 e 1
        global.volume_jogo = (pos_x - min_x) / largura;

        // Aplica o volume ao jogo
        audio_master_gain(global.volume_jogo);

    } else {
        arrastando = false;
    }
}
