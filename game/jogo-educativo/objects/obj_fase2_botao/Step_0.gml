hover = point_in_rectangle(mouse_x, mouse_y, x - largura/2, y - altura/2, x + largura/2, y + altura/2);
if (hover && mouse_check_button_pressed(mb_left)) {
    obj_fase2_controle.verificar(valor);
}