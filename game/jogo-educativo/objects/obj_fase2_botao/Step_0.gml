var _antes = hover;
hover = point_in_rectangle(mouse_x, mouse_y, x - largura/2, y - altura/2, x + largura/2, y + altura/2);

// Fala o número quando o mouse entra no botão
if (hover && !_antes) obj_fase2_controle.falar(obj_fase2_controle.numeros_som[valor - 1]);

if (hover && mouse_check_button_pressed(mb_left)) {
    obj_fase2_controle.verificar(valor);
}
