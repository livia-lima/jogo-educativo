if (mouse_check_button_pressed(mb_left) && point_in_rectangle(mouse_x, mouse_y, min_x, y-15, max_x, y+15)) {
    arrastando = true;
}
if (mouse_check_button_released(mb_left)) {
    arrastando = false; 
}

if (arrastando) {
    pos_x = clamp(mouse_x, min_x, max_x);
    global.volume_jogo = (pos_x - min_x) / largura;
    audio_master_gain(global.volume_jogo); // Altera o volume do motor do GameMaker
}