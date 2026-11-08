if (mouse_check_button_pressed(mb_left) && point_in_rectangle(mouse_x, mouse_y, min_x, y-15, max_x, y+15)) arrastando = true;
if (mouse_check_button_released(mb_left)) arrastando = false;

if (arrastando) {
    pos_x = clamp(mouse_x, min_x, max_x);
    global.escala_fonte = 1 + ((pos_x - min_x) / largura); // Gera um valor entre 1.0 e 2.0
}