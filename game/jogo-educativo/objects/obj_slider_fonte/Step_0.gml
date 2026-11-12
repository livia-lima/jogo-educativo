
if (mouse_check_button_pressed(mb_left)) {

    // Verifica se o mouse clicou na área do slider
    if (point_in_rectangle(
        mouse_x, mouse_y,
        min_x - 12, barra_y - 18,
        max_x + 12, barra_y + 18
    )) {
        arrastando = true;
    }
}

// Movimenta o pino enquanto o mouse está pressionado
if (arrastando) {

    if (mouse_check_button(mb_left)) {

        // Limita o pino às extremidades da barra
        pos_x = clamp(mouse_x, min_x, max_x);

        // Atualiza a escala da fonte (1 a 2)
        global.escala_fonte = 1 + (pos_x - min_x) / largura;

    } else {
        arrastando = false;
    }
}
